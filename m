Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC72D767FA
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 19:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3370D88B9E;
	Thu, 31 Oct 2024 20:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDED892D5; Thu, 31 Oct 2024 20:13:15 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F3788B0C
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 20:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1t6abV-000000001k5-0luK; Thu, 31 Oct 2024 19:13:09 +0000
Date: Thu, 31 Oct 2024 19:13:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, John Crispin <john@phrozen.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 2/3] menu: add support to check if menu needs to be
 reprinted
Message-ID: <ZyPWvHDdVm92NKoE@pidgin.makrotopia.org>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
 <7024b1fd05a36d8ce0d9a81697fef2333b85872a.1730194901.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7024b1fd05a36d8ce0d9a81697fef2333b85872a.1730194901.git.weijie.gao@mediatek.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Oct 29, 2024 at 05:47:16PM +0800, Weijie Gao wrote:
> This patch adds a new callback named need_reprint for menu.
> The need_reprint will be called before printing the menu. If the
> callback exists and returns FALSE, menu printing will be canceled.
> 
> This is very useful if the menu was not changed. It can save time
> for serial-based menu to handle more input data.
> 
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  boot/pxe_utils.c |  2 +-
>  cmd/bootmenu.c   |  2 +-
>  cmd/eficonfig.c  |  2 +-
>  common/menu.c    | 11 +++++++++++
>  include/menu.h   |  1 +
>  5 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index d6a4b2cb859..3ae17553c6d 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -1474,7 +1474,7 @@ static struct menu *pxe_menu_to_menu(struct pxe_menu *cfg)
>  	 * Create a menu and add items for all the labels.
>  	 */
>  	m = menu_create(cfg->title, DIV_ROUND_UP(cfg->timeout, 10),
> -			cfg->prompt, NULL, label_print, NULL, NULL);
> +			cfg->prompt, NULL, label_print, NULL, NULL, NULL);
>  	if (!m)
>  		return NULL;
>  
> diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
> index 977a04b7d76..c99605f3398 100644
> --- a/cmd/bootmenu.c
> +++ b/cmd/bootmenu.c
> @@ -506,7 +506,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
>  
>  	menu = menu_create(NULL, bootmenu->delay, 1, menu_display_statusline,
>  			   bootmenu_print_entry, bootmenu_choice_entry,
> -			   bootmenu);
> +			   NULL, bootmenu);
>  	if (!menu) {
>  		bootmenu_destroy(bootmenu);
>  		return BOOTMENU_RET_FAIL;
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index bea09e4ecc7..498653b778d 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -443,7 +443,7 @@ efi_status_t eficonfig_process_common(struct efimenu *efi_menu,
>  		efi_menu->menu_desc = menu_desc;
>  
>  	menu = menu_create(NULL, 0, 1, display_statusline, item_data_print,
> -			   item_choice, efi_menu);
> +			   item_choice, NULL, efi_menu);
>  	if (!menu)
>  		return EFI_INVALID_PARAMETER;
>  
> diff --git a/common/menu.c b/common/menu.c
> index 48ab7f0f398..5a2126aa01a 100644
> --- a/common/menu.c
> +++ b/common/menu.c
> @@ -43,6 +43,7 @@ struct menu {
>  	void (*display_statusline)(struct menu *);
>  	void (*item_data_print)(void *);
>  	char *(*item_choice)(void *);
> +	bool (*need_reprint)(void *);
>  	void *item_choice_data;
>  	struct list_head items;
>  	int item_cnt;
> @@ -117,6 +118,11 @@ static inline void *menu_item_destroy(struct menu *m,
>   */
>  static inline void menu_display(struct menu *m)
>  {
> +	if (m->need_reprint) {
> +		if (!m->need_reprint(m->item_choice_data))
> +			return;
> +	}
> +
>  	if (m->title) {
>  		puts(m->title);
>  		putc('\n');
> @@ -362,6 +368,9 @@ int menu_item_add(struct menu *m, char *item_key, void *item_data)
>   * item. Returns a key string corresponding to the chosen item or NULL if
>   * no item has been selected.
>   *
> + * need_reprint - If not NULL, will be called before printing the menu.
> + * Returning FALSE means the menu does not need reprint.
> + *
>   * item_choice_data - Will be passed as the argument to the item_choice function
>   *
>   * Returns a pointer to the menu if successful, or NULL if there is
> @@ -371,6 +380,7 @@ struct menu *menu_create(char *title, int timeout, int prompt,
>  				void (*display_statusline)(struct menu *),
>  				void (*item_data_print)(void *),
>  				char *(*item_choice)(void *),
> +				bool (*need_reprint)(void *),
>  				void *item_choice_data)
>  {
>  	struct menu *m;
> @@ -386,6 +396,7 @@ struct menu *menu_create(char *title, int timeout, int prompt,
>  	m->display_statusline = display_statusline;
>  	m->item_data_print = item_data_print;
>  	m->item_choice = item_choice;
> +	m->need_reprint = need_reprint;
>  	m->item_choice_data = item_choice_data;
>  	m->item_cnt = 0;
>  
> diff --git a/include/menu.h b/include/menu.h
> index 6571c39b143..79643af272b 100644
> --- a/include/menu.h
> +++ b/include/menu.h
> @@ -13,6 +13,7 @@ struct menu *menu_create(char *title, int timeout, int prompt,
>  				void (*display_statusline)(struct menu *),
>  				void (*item_data_print)(void *),
>  				char *(*item_choice)(void *),
> +				bool (*need_reprint)(void *),
>  				void *item_choice_data);
>  int menu_default_set(struct menu *m, char *item_key);
>  int menu_get_choice(struct menu *m, void **choice);
> -- 
> 2.45.2
> 
