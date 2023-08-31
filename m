Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B53C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 10:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3785F8655F;
	Thu, 31 Aug 2023 12:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yawHPmkR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4fjF3Zhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799158656A; Thu, 31 Aug 2023 12:15:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5EF086558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=msuchanek@suse.de
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AA08721860;
 Thu, 31 Aug 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693476912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0mBq5NM/FtuQWtKBQJnQXsloKeJftIAHjp/S9PJfbc=;
 b=yawHPmkR+HD0yDH+NpoRkiA+99MXT7iZ14WJkrl/nR6621nahPZ14vbDh5eceYDhhcipKg
 ZdlElvZl+R5/9IpsS4VdH6zdLMjj1dnpx6yKIedebm2ZBZAfFjWfGigRHvccvhWhfPPgWv
 5IyHEt46TmoNcjMhGJclC0HNCOv/0vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693476912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0mBq5NM/FtuQWtKBQJnQXsloKeJftIAHjp/S9PJfbc=;
 b=4fjF3ZhbhhvYBq8yC0n719FTtoViCbveog3xPUTdb4fUGpDyzeI9uXLxIhZH3QOQ436YvW
 phIfvR88WcspttBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8E6FE2C142;
 Thu, 31 Aug 2023 10:15:12 +0000 (UTC)
Date: Thu, 31 Aug 2023 12:15:11 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Trevor Woerner <twoerner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] am33xx: ignore return value from usb_ether_init()
Message-ID: <20230831101511.GD8826@kitsune.suse.cz>
References: <20230831024951.22599-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831024951.22599-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Hello,

On Wed, Aug 30, 2023 at 10:49:50PM -0400, Trevor Woerner wrote:
> In 2cb43ef1c223 ("usb: ether: Fix error handling in usb_ether_init") the error
> handling of usb_ether_init() was changed. Not a single other call site of this
> function checks its return value, therefore follow suit in the am33xx code.

then there is the question what point is there in having a return value
in this function at all.

Anyway, it's fine to not check the return value in the caller if there
is no use for the error.

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

> 
> Do not cause the boot to halt if the usb gadget ethernet initialization fails:
> 
> 	initcall sequence 9ffdbd84 failed at call 808024b9 (err=-19)
> 	### ERROR ### Please RESET the board ###
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm/mach-omap2/am33xx/board.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
> index ecc0a592e993..8f772310a1a7 100644
> --- a/arch/arm/mach-omap2/am33xx/board.c
> +++ b/arch/arm/mach-omap2/am33xx/board.c
> @@ -270,11 +270,7 @@ int arch_misc_init(void)
>  		return ret;
>  
>  #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
> -	ret = usb_ether_init();
> -	if (ret) {
> -		pr_err("USB ether init failed\n");
> -		return ret;
> -	}
> +	usb_ether_init();
>  #endif
>  
>  	return 0;
> -- 
> 2.41.0.327.gaa9166bcc0ba
> 
