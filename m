Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1EBD767F9
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 19:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5E7892A2;
	Thu, 31 Oct 2024 20:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E441A892CD; Thu, 31 Oct 2024 20:13:51 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E87A89245
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 20:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1t6ac9-000000001kj-2rTl; Thu, 31 Oct 2024 19:13:49 +0000
Date: Thu, 31 Oct 2024 19:13:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, John Crispin <john@phrozen.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 3/3] bootmenu: add reprint check
Message-ID: <ZyPW5hnfhdqiXy1Q@pidgin.makrotopia.org>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
 <bcc2bfd8917197707929bd1aa86d8012a7675a66.1730194901.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc2bfd8917197707929bd1aa86d8012a7675a66.1730194901.git.weijie.gao@mediatek.com>
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

On Tue, Oct 29, 2024 at 05:47:22PM +0800, Weijie Gao wrote:
> Record the last active menu item and check if it equals to the
> current selected item before reprint.
> 
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  cmd/bootmenu.c | 16 +++++++++++++++-
>  include/menu.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
> index c99605f3398..ffa63a4628d 100644
> --- a/cmd/bootmenu.c
> +++ b/cmd/bootmenu.c
> @@ -103,11 +103,13 @@ static char *bootmenu_choice_entry(void *data)
>  
>  		switch (key) {
>  		case BKEY_UP:
> +			menu->last_active = menu->active;
>  			if (menu->active > 0)
>  				--menu->active;
>  			/* no menu key selected, regenerate menu */
>  			return NULL;
>  		case BKEY_DOWN:
> +			menu->last_active = menu->active;
>  			if (menu->active < menu->count - 1)
>  				++menu->active;
>  			/* no menu key selected, regenerate menu */
> @@ -133,6 +135,17 @@ static char *bootmenu_choice_entry(void *data)
>  	return NULL;
>  }
>  
> +static bool bootmenu_need_reprint(void *data)
> +{
> +	struct bootmenu_data *menu = data;
> +	bool need_reprint;
> +
> +	need_reprint = menu->last_active != menu->active;
> +	menu->last_active = menu->active;
> +
> +	return need_reprint;
> +}
> +
>  static void bootmenu_destroy(struct bootmenu_data *menu)
>  {
>  	struct bootmenu_entry *iter = menu->first;
> @@ -332,6 +345,7 @@ static struct bootmenu_data *bootmenu_create(int delay)
>  
>  	menu->delay = delay;
>  	menu->active = 0;
> +	menu->last_active = -1;
>  	menu->first = NULL;
>  
>  	default_str = env_get("bootmenu_default");
> @@ -506,7 +520,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
>  
>  	menu = menu_create(NULL, bootmenu->delay, 1, menu_display_statusline,
>  			   bootmenu_print_entry, bootmenu_choice_entry,
> -			   NULL, bootmenu);
> +			   bootmenu_need_reprint, bootmenu);
>  	if (!menu) {
>  		bootmenu_destroy(bootmenu);
>  		return BOOTMENU_RET_FAIL;
> diff --git a/include/menu.h b/include/menu.h
> index 79643af272b..6cede89b950 100644
> --- a/include/menu.h
> +++ b/include/menu.h
> @@ -40,6 +40,7 @@ int menu_show(int bootdelay);
>  struct bootmenu_data {
>  	int delay;			/* delay for autoboot */
>  	int active;			/* active menu entry */
> +	int last_active;		/* last active menu entry */
>  	int count;			/* total count of menu entries */
>  	struct bootmenu_entry *first;	/* first menu entry */
>  };
> -- 
> 2.45.2
> 
