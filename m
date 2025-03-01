Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A8C282C5
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 00:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C89C5810ED;
	Sat,  1 Mar 2025 01:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V5RxMMiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73166810F4; Sat,  1 Mar 2025 01:59:20 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BD2809A5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 01:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5210xEXU2778602
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 28 Feb 2025 18:59:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740790754;
 bh=XLsFAZAc16HsZrn5oWBjNR8mNxcVTTh30mqOXA8HzKw=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=V5RxMMizlomPEgbS1M2AQ6gtqkBQdnmBe9n6fpqZxlZJcPlhCfoeCAdWFl0coqJDL
 V3EhuJJFHUWHEnkbll/seEfhja85BJUG6lK3BVSyxElfmcj/KQm5Vc7j90JtV2XKkT
 +52MXKf39eIXzk9x/icGJ5Xro0JQ9XGvx+4Hwbac=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5210xEfp020772;
 Fri, 28 Feb 2025 18:59:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 18:59:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 18:59:14 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5210xExK036667;
 Fri, 28 Feb 2025 18:59:14 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] configs: am62x_r5: introduce fragment for USB MSC boot
In-Reply-To: <20250226103504.1841697-2-s-vadapalli@ti.com>
References: <20250226103504.1841697-1-s-vadapalli@ti.com>
 <20250226103504.1841697-2-s-vadapalli@ti.com>
Date: Fri, 28 Feb 2025 18:59:14 -0600
Message-ID: <86eczhlg65.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Siddharth Vadapalli <s-vadapalli@ti.com> writes:

> Introduce the config fragment for enabling USB MSC boot. USB MSC boot
> involves fetching the next stage of the bootloader from a USB Mass Storage
> device such as a USB Flash Drive with the USB controller on the SoC acting
> as the USB Host.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  configs/am62x_r5_usbmsc.config | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 configs/am62x_r5_usbmsc.config
>
> diff --git a/configs/am62x_r5_usbmsc.config b/configs/am62x_r5_usbmsc.config
> new file mode 100644
> index 0000000000..2ce6afb662
> --- /dev/null
> +++ b/configs/am62x_r5_usbmsc.config
> @@ -0,0 +1,22 @@
> +CONFIG_USB=y
> +CONFIG_SPL_USB_HOST=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_MISC=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_DWC3=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_SPL_USB_STORAGE=y

Hi Siddharth,

You either need to set CONFIG_USB_STORAGE as well in
am62x_r5_usbmsc.config, or otherwise modify usb.h to include the
declaration of usb_stor_info().

Eg use:

#if defined CONFIG_SPL_USB_STORAGE || defined CONFIG_USB_STORAGE

instead of

#ifdef CONFIG_USB_STORAGE

See the build log:

spl_usb.c:41:29: error: implicit declaration of function usb_stor_scan

thanks
Jon

> +# CONFIG_SPL_MMC is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +# CONFIG_SPL_MTD is not set
> +# CONFIG_SPL_SPI is not set
> +# CONFIG_SPL_SYS_MALLOC is not set
> +# CONFIG_CMD_GPT is not set
> +# CONFIG_CMD_MMC is not set
> +# CONFIG_CMD_FAT is not set
> +# CONFIG_MMC_SDHCI is not set
> +# CONFIG_CMD_DFU is not set
> +# CONFIG_DFU is not set
> -- 
> 2.34.1
