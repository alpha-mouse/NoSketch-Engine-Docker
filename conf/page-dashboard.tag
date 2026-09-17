<features-tab-history class="card-content" role="tabpanel">
    <result-list></result-list>
</features-tab-history >

<features-tab-annotations class="card-content" role="tabpanel">
    <p class="annotDesc mb-2">
        {_("an.description")} <i class="material-icons notranslate">toc</i>
    </p>
    <p class="annotDesc mb-6">
        <a class="link"
                href="https://www.sketchengine.eu/guide/manual-annotation-skema/"
                target="_blank"
                rel="noopener noreferrer">
            {_("moreInformation")}
            <i class="helpIcon material-icons notranslate">help_outline</i>
        </a>
    </p>
    <p>
        <a href="#concordance"
                class="btn mt-1" role="button">{_("an.goToConcordanceBtn")}</a>
        <a href="#annotation?corpname={window.stores.app.data.corpus ? window.stores.app.data.corpus.corpname : ""}"
                class="btn mt-1" role="button">{_("an.manageExistingAnnotations")}</a>
    </p>
</features-tab-annotations>

<page-dashboard class="page-dashboard {bannerExpanded: bannerExpanded} {noBanner: hideBanner}">
    <main id="maincontent" role="main" tabindex="-1">
    <div class="row {isAnonymous: !isFullAccount}">
        <div class="col xl7 l6 m12 s12">
            <div class="card dashboardCard corpusCard">
                <div if={corpus} class="card-content">
                    <div class="card-title">
                        <div class="titleWithButton">
                            <h2 class="title">
                                {corpus.name}
                            </h2>
                            <div class="buttons center-align">
                                <button type="button" 
                                        id="btnCorpusInfo"
                                        class="white-text btn"
                                        onclick={SkE.showCorpusInfo.bind(null, corpus.corpname)}>
                                    {_("corpusInfo")}
                                </button>
                                <a if={window.permissions.ca}
                                        id="btnManageCorpus"
                                        onclick="location.href='#ca'"
                                        class="white-text btn tooltipped"
                                        data-tooltip={_("db.menuTip")}
                                        aria-label={_("manageCorpus")}
                                        role="button">
                                    {_("manageCorpus")}
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row" if={ready}>
                        <div class="col xl6 l12 m6 s12 {show-on-xlarge-only: !item.active}" each={item in items} >
                            <a href={item.active ? ("#" + item.page + (item.query || "")) : ""}
                                    id="dashboard_btn{item.id}"
                                    class="text-primary"
                                    onclick={onCardClick}
                                    role="button">
                                <div class={getClasses(item)}
                                        data-tooltip={getTooltipText(item)}>
                                    <i class="{item.iconClass || 'ske-icons'} {getFeatureIcon(item.id)} small">{item.icon}</i>
                                    <div class="card-content">
                                        <div class="featureName">
                                            {item.name || getFeatureLabel(item.id)}
                                            <i if={!item.active} class="helpIcon material-icons notranslate">help_outline</i>
                                        </div>
                                        <div class="featureDesc">
                                            {item.desc || _("db." + item.id + "Desc")}
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <div if={!corpus || !ready} class="card-content">
                    <div class="notReady">
                        <i class="material-icons notranslate">storage</i>
                        <virtual if={!corpus}>
                            <div class="h4-styles">{_("noCorpus")}</div>
                            <div class="note">{_("db.selectCorpus")}</div>
                            <br>
                            <a href="#corpus" class="btn white-text" role="button">{_("selectCorpus")}</a>
                        </virtual>
                        <virtual if={corpus}>
                            <virtual if={corpus.isCompiling && window.permissions["ca-compile"]}>
                                <div class="h4-styles">{_("ca.corpusBusy")}</div>
                                <div class="note">{_("ca.compilingDesc")}</div>
                                <div class="compilationProgress">
                                    <div class="progress">
                                        <div class="determinate" style="width: {getCompilationProgress()}%"></div>
                                    </div>
                                </div>
                                <br>
                                <a href="#ca-compile" class="btn white-text" role="button">{_("db.checkStatus")}</a>
                            </virtual>
                            <virtual if={corpus.isReady && window.permissions["ca-compile"]}>
                                 <div class="h4-styles">{_("db.toCompileTitle")}</div>
                                <div class="note">{_("db.toCompileDesc")}</div>
                                <br>
                                <a href="#ca-compile" class="btn white-text" role="button">{_("ca.compile")}</a>
                            </virtual>
                            <virtual if={corpus.isEmpty && window.permissions["ca-add-content"]}>
                                 <div class="h4-styles">{_("db.emptyTitle")}</div>
                                <div class="note">{_("db.emptyDesc")}</div>
                                <br>
                                <a href="#ca-add-content" class="btn white-text" role="button">{_("addTexts")}</a>
                            </virtual>
                            <virtual if={corpus.isCompilationFailed && window.permissions["ca-compile"]}>
                                 <div class="h4-styles">{_("compilation_failed")}</div>
                                <div class="note">{_("ca.compilation_failedDesc")}</div>
                                <br>
                                <a href="#ca-compile" class="btn white-text btn-primary" role="button">{_("compile")}</a>
                            </virtual>
                        </virtual>
                    </div>
                </div>
            </div>
        </div>

        <div class="col xl5 l6 m12 s12" if={isFullAccount}>
            <div class="card dashboardCard recentCorpora">
                <div class="card-content">
                    <div class="card-title">
                        <div class="titleWithButton">
                            <h2 class="title">
                                {_("db.recentCorpora")}
                            </h2>
                            <a href="#ca-create" if={window.permissions["ca-create"]} class="btn white-text" role="button">
                                {_("newCorpus")}
                            </a>
                        </div>
                    </div>
                    <corpus-history></corpus-history>
                </div>
            </div>

            <div if={!hideBanner}
                    class="banner center-align">
                <h5>If you use the corpora for your work, please cite the corresponding publication.</h5>
                <br>
                <a href="CITATION_LINK_PLACEHOLDER"
                        class="btn"
                        target="_blank">The list of publications recommended to cite</a>
                <br>
            </div>
            <!--div class="banner bigBanner center-align">
                <a class="btn btn-floating btn-flat right" onClick={onBannerToggleClick}>
                    <i class="material-icons notranslate bigBanner">keyboard_arrow_up</i>
                </a>
                <img src="{window.config.CDN_URL_PREFIX}images/boot_camp.png" loading="lazy">
                <h5>2 days of corpus searching &amp; corpus building</h5>
                <div>Learn to work with Sketch Engine like a pro!</div>
                <br>
                <a href={externalLink("bootCamp")}
                        class="btn"
                        target="_blank">{_("detailsAndReg")}</a>
                <br>
            </div>
            <div class="banner smallBanner center-align" onClick={onBannerToggleClick}>
                <a class="btn btn-floating btn-flat right">
                    <i class="material-icons notranslate smallBanner">keyboard_arrow_down</i>
                </a>
                <h5>Master the interface in 2 days!</h5>
                <div>March & April 2020</div>
            </div-->
        </div>
        <div class="col s12" if={isFullAccount}>
            <div class="card dashboardCard history">
                <ui-tabs tabs={tabs} name="tabs-history"></ui-tabs>
            </div>
        </div>
    </div>


    <script>
        require("./page-dashboard.scss")
        require("./corpus-history.tag")
        require("./result-list.tag")
        const {AppStore} = require("core/AppStore.js")
        const {Url} = require("core/url.js")
        const {Auth} = require("core/Auth.js")
        const {CAStore} = require("ca/castore.js")

        this.mixin("tooltip-mixin")

        this.isFullAccount = Auth.isFullAccount() && Auth.hasSkeLicence()
        this.bannerExpanded = true
        this.hideBanner = window.config.HIDE_DASHBOARD_BANNER
        this.bannerId = Math.ceil(Math.random() * 3)

        _isBitermsActive(){
            return this.corpus.aligned_with_biterms.length > 0
        }

        startCompilationProgressChecking () {
            if(this.corpus && this.corpus.isCompiling && window.permissions["ca-compile"]){
                CAStore.checkCorpusStatus(this.corpus.id)
            }
        }

        _updateItems() {
            this.corpus = AppStore.get("corpus")
            this.ready = AppStore.get("ready")
            this.startCompilationProgressChecking()
            let wlattr = AppStore.getFirstWlattr()
            let features = AppStore.get("features")
            let p = window.permissions
            this.items = [
                {
                    page: "concordance",
                    id: "concordance",
                    active: p.concordance && features.concordance
                }, {
                    page: "wordlist",
                    id: "wordlist",
                    active: p.wordlist && features.wordlist
                }, {
                    page: "keywords",
                    id: "keywords",
                    active: p.keywords && features.keywords
                }, {
                    page: "text-type-analysis",
                    query: this.corpus ? `?corpname=${this.corpus.corpname}&wlminfreq=1&include_nonwords=1&showresults=1&wlicase=1&wlnums=frq&wlattr=${wlattr}` : "",
                    iconClass: "material-icons rotate180",
                    icon: "donut_small",
                    id: "tta",
                    name: _("tta"),
                    desc: _("ttaDesc"),
                    active: p.tta && features.wordlist && wlattr
                }
            ]
        }
        this._updateItems()

        _updateUrl(){
            let urlQuery = Url.getQuery()
            if(this.corpus && this.corpus.corpname){
                urlQuery.corpname = this.corpus.corpname
            }
            history.replaceState(null, null, Url.create("dashboard", urlQuery))
        }

        this.tabs = [{
            tabId: "history",
            labelId: "db.recentResults",
            tag: "features-tab-history"
        }, {
            tabId: "annotations",
            labelId: "an.annotations",
            tag: "features-tab-annotations"
        }]

        getClasses(item){
            return{
                card: 1,
                small: 1,
                horizontal: 1,
                active: item.active,
                inactive: !item.active,
                hover: item.active,
                tooltipped: !item.active,
            }
        }

        getTooltipText(item) {
            if (isDef(window.permissions[item.id]) && !window.permissions[item.id]) {
                if (window.config.NO_SKE) {
                    return _("NAInNoSkeP", ['<a target=\"_blank\" href=\"https://sketchengine.eu\">Sketch Engine</a>']);
                } else {
                    return _("availableAfterLogin");
                }
            } else if (!item.active) {
                return item.tooltip ? item.tooltip : _("db.featureNotAvailable");
            } else {
                return null;
            }
        }

        onCardClick(evt){
            let item = evt.item.item
            if(!item.active){
                evt.preventDefault()
                return
            }
            Dispatcher.trigger("RESET_STORE", item.page)
        }

        onBannerToggleClick(evt){
            evt.preventUpdate = true
            this.bannerExpanded = !this.bannerExpanded
            $(this.root).toggleClass("bannerExpanded", this.bannerExpanded)
        }

        getInactiveItemTooltip(item){
            let name = item.name || getFeatureLabel(item.id)
            let desc = item.desc || _("db." + item.id + "Desc")
            return `<b>${name}</b><br>${desc}`
        }

        getCompilationProgress(){
            let progress = this.corpus && isDef(this.corpus.progress) ? this.corpus.progress : 0
            return Math.max(0, Math.min(100, progress))
        }

        this.on("update", this._updateItems)

        this.on("updated", this._updateUrl)

        this.on("mount", () => {
            this._updateUrl()
            this.startCompilationProgressChecking()
            AppStore.on("corpusChanged", this.update)
            AppStore.on("corpusStatusChanged", this.update)
            AppStore.on("languageListLoaded", this.update)
        })

        this.on("unmount", () => {
            AppStore.off("corpusChanged", this.update)
            AppStore.off("corpusStatusChanged", this.update)
            AppStore.off("languageListLoaded", this.update)
        })

    </script>
    </main>
</page-dashboard>
