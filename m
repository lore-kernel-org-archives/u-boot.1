Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED92C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 06:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3980586557;
	Thu, 31 Aug 2023 08:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dsWIfNul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA66F8652C; Thu, 31 Aug 2023 08:02:57 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3628286561
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37V62jg2108785;
 Thu, 31 Aug 2023 01:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693461765;
 bh=RszWl1wNz+KHEg/rhRePhUYM1dc8+4XESr7zDYdQGXs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dsWIfNul/BXBRSTMWuy0IuVH2RowcjhtvB5sXKVGfch0vhmxwditI5+M7KiC/BQ5n
 vfK4QzjgPPH7pYbUYWxJe5uezIlozfi+SRxTCBvimLoibW7m7fjLyExkPKEU/fP7T4
 S6LYSKxRwRf9h/fEjT34HWbd4H8tKlzPbhUF/NAk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37V62jFm005190
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Aug 2023 01:02:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 01:02:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 01:02:45 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37V62eX8043484;
 Thu, 31 Aug 2023 01:02:41 -0500
Message-ID: <d04cf2fd-92d0-46d1-5041-9ec4480bd6fd@ti.com>
Date: Thu, 31 Aug 2023 11:32:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/19] boot: Move fdt_support to boot/
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-9-sjg@chromium.org>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230824195917.1687886-9-sjg@chromium.org>
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

Hi Simon,

On 25/08/23 01:28, Simon Glass wrote:
> This relates to booting since it fixes up the devicetree for the OS. Move
> it into the boot/ directory.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  boot/Makefile                  | 3 +++
>  {common => boot}/fdt_support.c | 0
>  common/Makefile                | 2 --
>  3 files changed, 3 insertions(+), 2 deletions(-)
>  rename {common => boot}/fdt_support.c (100%)
> 
> diff --git a/boot/Makefile b/boot/Makefile
> index 10f015722378..f15a161614ff 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_QFW) += bootmeth_qfw.o
>  endif
>  
>  obj-y += image.o image-board.o
> +
>  obj-$(CONFIG_ANDROID_AB) += android_ab.o
>  obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
>  
> @@ -37,6 +38,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
>  obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
>  endif
>  
> +obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
> +
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o

Can this be,
obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o image-fdt.o ?

Regards
Devarsh

>  obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
>  obj-$(CONFIG_$(SPL_TPL_)FIT) += image-fit.o
> diff --git a/common/fdt_support.c b/boot/fdt_support.c
> similarity index 100%
> rename from common/fdt_support.c
> rename to boot/fdt_support.c
> diff --git a/common/Makefile b/common/Makefile
> index 0a3f75f2f1c8..0948721d0b47 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
>  
>  obj-$(CONFIG_FDT_SIMPLEFB) += fdt_simplefb.o
> -obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
>  obj-$(CONFIG_MII) += miiphyutil.o
>  obj-$(CONFIG_CMD_MII) += miiphyutil.o
>  obj-$(CONFIG_PHYLIB) += miiphyutil.o
> @@ -51,7 +50,6 @@ ifdef CONFIG_SPL_DFU
>  obj-$(CONFIG_DFU_OVER_USB) += dfu.o
>  endif
>  obj-$(CONFIG_SPL_NET) += miiphyutil.o
> -obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
>  
>  obj-$(CONFIG_SPL_USB_HOST) += usb.o usb_hub.o
>  obj-$(CONFIG_SPL_USB_STORAGE) += usb_storage.o
