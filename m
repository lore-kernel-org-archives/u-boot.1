Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127D9C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 06:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA5B86553;
	Thu, 31 Aug 2023 08:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J8ENnNKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E27DB86554; Thu, 31 Aug 2023 08:00:32 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B5F8652C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37V60JZg108118;
 Thu, 31 Aug 2023 01:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693461619;
 bh=Z5BpsIuCELZXZbbIohU+FPixh2kTQsuxYCV/dbk1AsA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=J8ENnNKZ/wqYefpYLC0j5OVMTUv7Ld0aa3J3YOxg19c72c21qHohX0yrKYswFMGO2
 CvM8TyXjOmgERmw+PQvenovr/60/RpSyqTeHHoQ1QA1ezkAKFcrtRihiiL13XloCM0
 cqt5JLaKOHlWqZUi9nqORXHt265hbriS+EMhsRVg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37V60JxS115465
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Aug 2023 01:00:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 01:00:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 01:00:19 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37V60DcZ040755;
 Thu, 31 Aug 2023 01:00:14 -0500
Message-ID: <016c0f45-d930-77fa-5031-8c69b4bf7c86@ti.com>
Date: Thu, 31 Aug 2023 11:30:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/19] video: Move BMP options and code to video directory
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>, Nikhil M Jain
 <n-jain1@ti.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>, "Luthra,
 Jai" <j-luthra@ti.com>, "Bhatia, Aradhya" <a-bhatia1@ti.com>, "Bajjuri,
 Praneeth" <praneeth@ti.com>
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-5-sjg@chromium.org>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230824195917.1687886-5-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 25/08/23 01:28, Simon Glass wrote:
> Put the options and the common BMP code with the other related Kconfig
> options in the drivers/video directory.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> 
>  common/Kconfig                  | 11 -----------
>  common/Makefile                 |  1 -
>  drivers/video/Kconfig           | 11 +++++++++++
>  drivers/video/Makefile          |  2 ++
>  {common => drivers/video}/bmp.c |  0
>  5 files changed, 13 insertions(+), 12 deletions(-)
>  rename {common => drivers/video}/bmp.c (100%)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 844531a59eda..2f46fdb3f62c 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1167,14 +1167,3 @@ config FDT_SIMPLEFB
>  
>  config IO_TRACE
>  	bool
> -
> -config BMP
> -	bool # Enable bmp image display
> -	help
> -	  Enable bmp functions to display bmp image and get bmp info.
> -
> -config SPL_BMP
> -	bool # Enable bmp image display at SPL
> -	depends on SPL_VIDEO
> -	help
> -	  Enable bmp functions to display bmp image and get bmp info at SPL.
> diff --git a/common/Makefile b/common/Makefile
> index f5c3d90f0675..0a3f75f2f1c8 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -45,7 +45,6 @@ endif # !CONFIG_SPL_BUILD
>  
>  obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
>  obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
> -obj-$(CONFIG_$(SPL_)BMP) += bmp.o
>  
>  ifdef CONFIG_SPL_BUILD
>  ifdef CONFIG_SPL_DFU
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 09f2cb1a7321..a4befd6b655c 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -682,6 +682,11 @@ config BACKLIGHT_LM3533
>  	  LM3533 Lighting Power chip. Only Bank A is supported as for now.
>  	  Supported backlight level range is from 2 to 255 with step of 1.
>  
> +config BMP
> +	bool # Enable bmp image display
> +	help
> +	  Enable bmp functions to display bmp image and get bmp info.
> +
>  source "drivers/video/ti/Kconfig"
>  
>  source "drivers/video/exynos/Kconfig"
> @@ -1117,6 +1122,12 @@ config SPL_VIDEO_REMOVE
>  	  if this  option is enabled video driver will be removed at the end of
>  	  SPL stage, before loading the next stage.
>  
> +config SPL_BMP
> +	bool # Enable bmp image display at SPL
> +	depends on SPL_VIDEO
> +	help
> +	  Enable bmp functions to display bmp image and get bmp info at SPL.
> +
>  if SPL_SPLASH_SCREEN
>  
>  config SPL_SPLASH_SCREEN_ALIGN
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index d13af9f3b19b..a3182dca734b 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -3,6 +3,8 @@
>  # (C) Copyright 2000-2007
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>  
> +obj-$(CONFIG_$(SPL_)BMP) += bmp.o
> +
>  ifdef CONFIG_DM
>  obj-$(CONFIG_$(SPL_TPL_)BACKLIGHT) += backlight-uclass.o
>  obj-$(CONFIG_BACKLIGHT_GPIO) += backlight_gpio.o
> diff --git a/common/bmp.c b/drivers/video/bmp.c
> similarity index 100%
> rename from common/bmp.c
> rename to drivers/video/bmp.c
