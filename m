Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBB7C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 06:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2410E8655E;
	Thu, 31 Aug 2023 08:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X0y467za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FBF86554; Thu, 31 Aug 2023 08:13:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31F38655A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37V6Co9Y039484;
 Thu, 31 Aug 2023 01:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693462370;
 bh=tFQoy8FGWl4bjllkBZHhHt/eVkcipS5RyDRJvXUmBrA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=X0y467zaqlinSb2vA3ukSvPEpvUQmFdGxwfAodhjCXtxqQUdFDUWQXEWlO7v4O2BP
 hO9VwdCZIpEv+C6hqd8Impe7NXf3WiK8JzNBy/vRS6e3uTbd+I+bULRGHNDxHF6FVI
 nDrhke8whvRcfMxThDC0L8g7KZIlwuoCGxJc4abE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37V6CoR8008849
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Aug 2023 01:12:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 01:12:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 01:12:50 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37V6Cjuu052418;
 Thu, 31 Aug 2023 01:12:45 -0500
Message-ID: <ccdadecf-4169-32ea-d1b6-ded2fe27b4b4@ti.com>
Date: Thu, 31 Aug 2023 11:42:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/19] Move fdt_simplefb to boot/
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>, "Bhatia, Aradhya"
 <a-bhatia1@ti.com>, "Luthra, Jai" <j-luthra@ti.com>
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-10-sjg@chromium.org>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230824195917.1687886-10-sjg@chromium.org>
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



On 25/08/23 01:29, Simon Glass wrote:
> This relates to booting, so move it there. Create a new Kconfig menu for
> things related to devicetree fixup.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> 
>  boot/Kconfig                    | 16 ++++++++++++++++
>  boot/Makefile                   |  1 +
>  {common => boot}/fdt_simplefb.c |  0
>  common/Kconfig                  |  9 ---------
>  common/Makefile                 |  1 -
>  5 files changed, 17 insertions(+), 10 deletions(-)
>  rename {common => boot}/fdt_simplefb.c (100%)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 5e2d4286aeaa..1b2ac7451a61 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1535,6 +1535,22 @@ config SPL_IMAGE_PRE_LOAD_SIG
>  
>  endmenu
>  
> +if OF_LIBFDT
> +
> +menu "Devicetree fixup"
> +
> +config FDT_SIMPLEFB
> +	bool "FDT tools for simplefb support"
> +	help
> +	  Enable the fdt tools to manage the simple fb nodes in device tree.
> +	  These functions can be used by board to indicate to the OS
> +	  the presence of the simple frame buffer with associated reserved
> +	  memory
> +
> +endmenu
> +
> +endif # OF_LIBFDT
> +
>  config USE_BOOTARGS
>  	bool "Enable boot arguments"
>  	help
> diff --git a/boot/Makefile b/boot/Makefile
> index f15a161614ff..6ce983b83fa4 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
>  endif
>  
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
> +obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) += fdt_simplefb.o
>  
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
>  obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
> diff --git a/common/fdt_simplefb.c b/boot/fdt_simplefb.c
> similarity index 100%
> rename from common/fdt_simplefb.c
> rename to boot/fdt_simplefb.c
> diff --git a/common/Kconfig b/common/Kconfig
> index 2f46fdb3f62c..9693c0ac426f 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1156,14 +1156,5 @@ config VPL_IMAGE_SIGN_INFO
>  
>  endif
>  
> -config FDT_SIMPLEFB
> -	bool "FDT tools for simplefb support"
> -	depends on OF_LIBFDT
> -	help
> -	  Enable the fdt tools to manage the simple fb nodes in device tree.
> -	  These functions can be used by board to indicate to the OS
> -	  the presence of the simple frame buffer with associated reserved
> -	  memory
> -
>  config IO_TRACE
>  	bool
> diff --git a/common/Makefile b/common/Makefile
> index 0948721d0b47..5c1617206f07 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -17,7 +17,6 @@ obj-y += board_r.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
>  
> -obj-$(CONFIG_FDT_SIMPLEFB) += fdt_simplefb.o
>  obj-$(CONFIG_MII) += miiphyutil.o
>  obj-$(CONFIG_CMD_MII) += miiphyutil.o
>  obj-$(CONFIG_PHYLIB) += miiphyutil.o
