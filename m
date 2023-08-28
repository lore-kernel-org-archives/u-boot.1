Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A20C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 14:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EAFC86430;
	Mon, 28 Aug 2023 16:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="pfPhyD1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B75864ED; Mon, 28 Aug 2023 16:41:13 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19643863E8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 16:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e893fc53-45b0-11ee-ac31-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e893fc53-45b0-11ee-ac31-005056994fde;
 Mon, 28 Aug 2023 16:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=MyYQaGhhV+zzYIz4aVhLaz04PDklFl18C6+SLxn2HJg=;
 b=pfPhyD1Tj2r5imrJHC5jFZVm1TOjbgyrzRNZKfhaTbv99Wy35TgLV4YTA9S5k7pV5x7BZKG2mpZTQ
 FO2VugH6ek8eY2dvblZ247A6o/19w1qa8PJwsP9dWiS9olbudyQgNpk1zMKsloOXnUd2WaArRu9hxc
 CVLigRgzR/u1HSoFOOhude+GusMaLwd6Yb+JXY0vYFcW8o2fYEB6O1CsZLH4EyP5VTQwkN5KG3ffC5
 /7c3ku0HW0JweJ9FxAfvWsfbjjABQF/zien9MB79lMWWO4cvDbXxaB82xOdbod63dHipCjtPGpV4IJ
 zF6S8tRciGZMUBmN25cy9+1SqYr7Urg==
X-KPN-MID: 33|N2zB2VsLQHKPngDIm8+gtvNEDIknwDl3nmZBleqecp5qc16c8L1g26rVytMa1Xr
 M3jHJy/0VDN4zjDnvBeMzuiTx+ERwqGWbH1bUYQlcHOc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HDu+taoSCC82fGWeesPhHwcx4ACp7h/pAjiQdu2x2BJ0KNQ3wR4ii7MPRu3ocTN
 8yJqqyF4sFUMNA24ouog6ig==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ece0365d-45b0-11ee-b743-00505699772e;
 Mon, 28 Aug 2023 16:41:09 +0200 (CEST)
Date: Mon, 28 Aug 2023 16:41:08 +0200
Message-Id: <87pm37qlff.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de,
 sjg@chromium.org
In-Reply-To: <20230824195917.1687886-18-sjg@chromium.org> (message from Simon
 Glass on Thu, 24 Aug 2023 13:59:08 -0600)
Subject: Re: [PATCH 17/19] Make DISTRO_DEFAULTS as deprecated
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-18-sjg@chromium.org>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Thu, 24 Aug 2023 13:59:08 -0600
> 
> Encourage people to move to distro boot. Add a short migration guide.

Doesn't this commit message say the exact opposite of what the patch does?

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  boot/Kconfig            |  7 ++++++-
>  doc/develop/bootstd.rst | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 02b33323d726..4742ee2027bd 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -781,7 +781,7 @@ config SYS_BOOT_RAMDISK_HIGH
>  endmenu		# Boot images
>  
>  config DISTRO_DEFAULTS
> -	bool "Select defaults suitable for booting general purpose Linux distributions"
> +	bool "(deprecated) 'Defaults suitable for booting general purpose Linux distributions"
>  	select BOOT_DEFAULTS
>  	select AUTO_COMPLETE
>  	select CMDLINE_EDITING
> @@ -789,6 +789,11 @@ config DISTRO_DEFAULTS
>  	select HUSH_PARSER
>  	select SYS_LONGHELP
>  	help
> +	  Note: These scripts have been replaced by Standard Boot. Do not use
> +	  them on new boards. See 'Migrating from distro_boot' at
> +	  doc/develop/bootstd.rst
> +
> +
>  	  Select this to enable various options and commands which are suitable
>  	  for building u-boot for booting general purpose Linux distributions.
>  
> diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
> index ec3136535783..8b2f0849a1c0 100644
> --- a/doc/develop/bootstd.rst
> +++ b/doc/develop/bootstd.rst
> @@ -458,6 +458,28 @@ ready    File was loaded and is ready for use. In this state the bootflow is
>  =======  =======================================================================
>  
>  
> +Migrating from distro_boot
> +--------------------------
> +
> +To migrate from distro_boot:
> +
> +#. Update your board header files to remove the BOOTENV and BOOT_TARGET_xxx
> +   defines. Standard boot finds available boot devices automatically.
> +
> +#. Remove the "boot_targets" variable unless you need it. Standard boot uses a
> +   default order from fastest to slowest, which generally matches the order used
> +   by boards.
> +
> +#. Make sure that CONFIG_BOOTSTD_DEFAULTS is enabled by your board, so it can
> +   boot common Linux distributions.
> +
> +An example patch is at migrate_patch_.
> +
> +If you are using custom boot scripts for your board, consider creating your
> +own bootmeth to hold the logic. There are various examples at
> +`boot/bootmeth_...`.
> +
> +
>  Theory of operation
>  -------------------
>  
> @@ -768,3 +790,4 @@ Other ideas:
>  .. _BootLoaderSpec: http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
>  .. _distro_boot: https://github.com/u-boot/u-boot/blob/master/boot/distro.c
>  .. _bootflow_h: https://github.com/u-boot/u-boot/blob/master/include/bootflow.h
> +.. _migrate_patch: https://patchwork.ozlabs.org/project/uboot/patch/20230727215433.578830-2-sjg@chromium.org/
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 
> 
