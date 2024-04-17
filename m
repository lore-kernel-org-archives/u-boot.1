Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9EFC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F9B8844E;
	Wed, 17 Apr 2024 02:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Qrm+5maO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE5088447; Wed, 17 Apr 2024 02:26:22 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA4838836E
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240417002609epoutp0352c8db67c21895ebed90ded28c19de66~G6Z03s01Z0687306873epoutp03h
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 00:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240417002609epoutp0352c8db67c21895ebed90ded28c19de66~G6Z03s01Z0687306873epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713313569;
 bh=v6dGVzB8ATyglSy7hN9VYTFGAwHI+m/VohosKdwQexY=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Qrm+5maOU8fdKe0ND1gzeG6FiPFtr64BlHsUjujpXUkMocNn2X3NERLrJlx6Mgerq
 J2a5q8eHazcnHHApz40poOXU8I2XgKiTC3g9FFbeHZjj8+k5KGy+B7/9OtpsfgACcF
 6wGev5CpKDk58JZCtmyCrMmfUKQvHOTEeMrjKD0k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240417002609epcas1p42c70705a2e08241c821b5c932136266c~G6Z0Q6xAl1594415944epcas1p4w;
 Wed, 17 Apr 2024 00:26:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.132]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VK1sq3dfSz4x9QB; Wed, 17 Apr
 2024 00:26:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 24.20.10076.F171F166; Wed, 17 Apr 2024 09:26:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240417002607epcas1p4fe222dfdba803d8b4278f47153d73451~G6ZyWLcZT1594315943epcas1p41;
 Wed, 17 Apr 2024 00:26:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240417002606epsmtrp1422bcf1276e6a5bef30774eee09fe30f~G6ZyVPhtL1885918859epsmtrp1B;
 Wed, 17 Apr 2024 00:26:06 +0000 (GMT)
X-AuditID: b6c32a39-59dff7000000275c-df-661f171ffeac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.73.08924.E171F166; Wed, 17 Apr 2024 09:26:06 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417002606epsmtip1dabb49652aaf84e4b01161c021a79575~G6ZyCm_AF2938829388epsmtip1f;
 Wed, 17 Apr 2024 00:26:06 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Greg Malysa'" <greg.malysa@timesys.com>, <u-boot@lists.denx.de>,
 "'Peng Fan'" <peng.fan@nxp.com>
Cc: "'Nathan Barrett-Morrison'" <nathan.morrison@timesys.com>, "'Ian
 Roberts'" <ian.roberts@timesys.com>, "'Jonas	Karlman'" <jonas@kwiboo.se>,
 "'Kever Yang'" <kever.yang@rock-chips.com>, "'Marek	Vasut'"
 <marek.vasut+renesas@mailbox.org>, "'Oleksandr Suvorov'"
 <oleksandr.suvorov@foundries.io>, "'Paul Barker'"
 <paul.barker.ct@bp.renesas.com>, "'Peter Geis'" <pgwipeout@gmail.com>,
 "'Sean	Anderson'" <sean.anderson@seco.com>, "'Simon Glass'"
 <sjg@chromium.org>, "'Stefan	Roese'" <sr@denx.de>, "'Tom Rini'"
 <trini@konsulko.com>
In-Reply-To: <20240326022812.2723-1-greg.malysa@timesys.com>
Subject: RE: [PATCH] mmc: Support 32-bit only ADMA on 64-bit platforms
Date: Wed, 17 Apr 2024 09:26:06 +0900
Message-ID: <002f01da905d$d69cf5e0$83d6e1a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI/ZxEXxf/1Z52TLmv5YJygJB1fqgJ9TMmHsI4DGsA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRj2Oz29gCmeFXSfJIZSIBkssBZoPSXFoBvkKM6ghmQQTXeAA+0o
 bdOW6RZNqgUcjAwcAbaCSwfUBTS4sa10ymWy7IKMSelgEIa4BJBii6wyLipgywHl3/s87/Ne
 nu/CYfBcrFCOUm2gdGpSJWAForZb0XGxYXvD8oUO88v4gHcMxV1TvyB4v3sExW31ayy8tPUx
 C3dedAJ8xn0Oxf/pX2Xiq21LTHxwNh2/MFWC4MvXbADvb19E8NqzV9m4p7ucnfIC0TrXwCYa
 jA6UuGC+hxJ9I+VM4oZ5kk3M32xjE/eqhxFi8LEdEDcaehDiyoIdIdbNvSgxu7HMJro7V5EM
 bnahTEGReZSOT6lzNXlKdUGyIP19+UG5WCIUxYqk+KsCvposopIFh97OiE1Tqny2BPzjpKrY
 R2WQer3gwGsynabYQPEVGr0hWUBp81RasTZOTxbpi9UFcWrKkCQSCuPFPuHRQkXN+jjQWqM/
 7luZZxrBn+EVIIADsUQ42n2WVQECOTzMDqDtwSZKAy+Ap71PERosA/jZUzdzp2SgonU70Q2g
 19bIoIELwJ8edAK/ioXFwc2mi74EhxOCKeBlN8tPM7CvUOgY3uOPAzAZbK55hPrjYCwN1l+a
 2tKgWBS8Y2ln+GMuJoWe6wtMOt4D+89Po3SfMNjpaWTQC/Hh2szXW5oQLAl2zM0CWhMCG8rL
 tnaD2OkA+MS6yaYLDsHa3ya23QTD+bvXtvlQ6KoqY9MFJgCtLT8yaVAJ4IbxEYtWJcBeaw3i
 d8bAouF33x+gpwXBhWeVTD8NMS48Vcaj1ZFw+HcXstN/cnpzey4BvTcH0GoQbt7lzbzLm3mX
 B/P/wywAbQMvUVp9UQGlF2nF/113rqaoA2y9+RipHdR7FuP6AMIBfQByGIIQbknwK/k8bh55
 4iSl08h1xSpK3wfEvtP+khH6Yq7G92nUBrkoUSpMlMQnJOIiiUiwl3v/4XGKhxWQBqqQorSU
 bqcO4QSEGhH18+Mmj7Rl38MkeSX20UhwdPDkiaXl6nMdurWmuszwsJM2iWnZ+3plQWq9tGm0
 V5ZymCjtDkqLwCYnlEcyumbulvzV+IR5JsGU75janyVKnZjhn7p0hAwMAW8uxXyqMlr2OYJ6
 yHjp+vUoE2raH5F/h/tFtvPoB26L8ofIVFnOMOOT6Zaxz986Np4zkc1697Ikq254ZWwj6UOr
 Mdv5TXGmWDg0lNnjeXY/6ucqueN2+3t/WFyJ5K/Od2q7nrPlWyU1Z65Kzw9WdTVvljZXfKsb
 io+x54IrdY6Y2mTu7cOROW8oRCtlWTIeuh5qLDx20C5dWzTVRKBzMPPvlNFb6f0CVK8gRTEM
 nZ78FxnP2fl8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSnK6cuHyawZOfJhanP91gsXh5/x6T
 xck3V1kstk3/yWbRuvIOm8XlhZcZLZ6+mcFi8efkD1aLH6u+sFqcfeZtMe9+C5PFty3bGC1O
 rvvAZDF10mZ2i7d7O9kd+D1WvpjN7jG74SKLx7xZJ1g8Dl3tZPXYOesuu8erA6vYPU5MuMTk
 cfbODkaPnbP3MXlsfLeDyePvrP0sHs/+fWP32Lv9B1MAbxSXTUpqTmZZapG+XQJXxuS/NxkL
 lmpWHPr+irWB8bNiFyMnh4SAicTprpVMXYxcHEICuxklHl14zgKRkJL4/HQqWxcjB5AtLHH4
 cDFEzXNGid03foDVsAnoSfxftJAZxBYRyJLo/voHzGYWWMwisWJZCURDL9DQhumsIAlOARuJ
 xZOvgzULC7hJTF9+nw3EZhFQlTi2YB1YM6+ApcTbre9YIWxBiZMzn7BADNWWeHrzKZQtL7H9
 7RxmiEMVJH4+XcYKcYSVxKYXzxghakQkZne2MU9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXF
 uem5xYYFhnmp5XrFibnFpXnpesn5uZsYwfGupbmDcfuqD3qHGJk4GA8xSnAwK4nwtgjLpgnx
 piRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpgsgqvzwjUT1BJ
 NS3Zd//qHIk1mZOzLG/aHsiWrPrJoHZj6q9Ne64rnea8Frt3pbpg3+THEXlWu6WPi3nVTHij
 t/1pWVN1dLHKL4Uzv5U9rvverdmzMK7yT/YjLdUQtoX216q49NbOWsd55HUr75t9alc2VG0o
 urp+WuCXS18vlL87tljtF59cYsTq7JSPRfc+5x1/5uZ/OfQiW5D2zen3r5bt/+gsbCL5ZJ+R
 Sc72c83vcm9vPvmt5vT8hCy+bdUbjucqS6jujfz26cQM10uSPbc7iy/fnWGdup354GMRE9mf
 N96fdFKW3vPE5LaPqObb62r5HOL+dR3cwgWL93UuiNDOkdrB+mT/xYdHxURNXJRYijMSDbWY
 i4oTAZi2Oc9mAwAA
X-CMS-MailID: 20240417002607epcas1p4fe222dfdba803d8b4278f47153d73451
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326023017epcas1p3db77245c4ac988f6a7a6b658140a074d
References: <CGME20240326023017epcas1p3db77245c4ac988f6a7a6b658140a074d@epcas1p3.samsung.com>
 <20240326022812.2723-1-greg.malysa@timesys.com>
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



> -----Original Message-----
> From: Greg Malysa <greg.malysa@timesys.com>
> Sent: Tuesday, March 26, 2024 11:28 AM
> To: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Greg Malysa <greg.malysa@timesys.com>; Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Ian
> Roberts <ian.roberts@timesys.com>; Jonas Karlman <jonas@kwiboo.se>; Kever Yang <kever.yang@rock-
> chips.com>; Marek Vasut <marek.vasut+renesas@mailbox.org>; Oleksandr Suvorov
> <oleksandr.suvorov@foundries.io>; Paul Barker <paul.barker.ct@bp.renesas.com>; Peter Geis
> <pgwipeout@gmail.com>; Sean Anderson <sean.anderson@seco.com>; Simon Glass <sjg@chromium.org>; Stefan
> Roese <sr@denx.de>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH] mmc: Support 32-bit only ADMA on 64-bit platforms
> 
> Some arm64 platforms may include SDIO host controllers that
> only support 32-bit ADMA. While the Linux kernel detects which
> size is supported and adjusts the descriptor size used dynamically,
> the previous u-boot implementation statically selected between the
> two depending on whether DMA_ADDR_T_64BIT was defined. Because the
> static selection is already in place and effective for most platforms,
> this patch logically separates "64 bit addresses are used for DMA on
> this platform" and "64 bit addresses are used by the SDIO host
> controller for ADMA" in order to support the small number of platforms
> where these statements are not equivalent.
> 
> Using 32 bits is opt-in and existing 64 bit platforms should be
> unaffected by this change.
> 
> Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com> 

Best Regards,
Jaehoon Chung

> 
> ---
> 
> 
> ---
>  drivers/mmc/Kconfig      | 18 ++++++++++++++++++
>  drivers/mmc/sdhci-adma.c |  2 +-
>  drivers/mmc/sdhci.c      |  9 ++++-----
>  include/sdhci.h          |  4 ++--
>  4 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index cef05790dd..4538286c64 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -495,6 +495,24 @@ config SPL_MMC_SDHCI_ADMA
>  	  This enables support for the ADMA (Advanced DMA) defined
>  	  in the SD Host Controller Standard Specification Version 3.00 in SPL.
> 
> +config MMC_SDHCI_ADMA_FORCE_32BIT
> +	bool "Force 32 bit mode for ADMA on 64 bit platforms"
> +	help
> +	  This forces SDHCI ADMA to be built for 32 bit descriptors, even
> +	  on a 64 bit platform where they would otherwise be assumed to
> +	  be 64 bits. This is necessary for certain hardware platforms
> +	  that are 64-bit but include only 32-bit support within the selected
> +	  SD host controller IP.
> +
> +config MMC_SDHCI_ADMA_64BIT
> +	bool "Use SHDCI ADMA with 64 bit descriptors"
> +	depends on !MMC_SDHCI_ADMA_FORCE_32BIT
> +	default y if DMA_ADDR_T_64BIT
> +	help
> +	  This selects 64 bit descriptors for SDHCI ADMA. It is enabled by
> +	  default on 64 bit systems, but can be disabled if one of these
> +	  systems includes 32-bit ADMA.
> +
>  config FIXED_SDHCI_ALIGNED_BUFFER
>  	hex "SDRAM address for fixed buffer"
>  	depends on SPL && MVEBU_SPL_BOOT_DEVICE_MMC
> diff --git a/drivers/mmc/sdhci-adma.c b/drivers/mmc/sdhci-adma.c
> index 8213223d3f..474647c3fd 100644
> --- a/drivers/mmc/sdhci-adma.c
> +++ b/drivers/mmc/sdhci-adma.c
> @@ -22,7 +22,7 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
>  	desc->len = len;
>  	desc->reserved = 0;
>  	desc->addr_lo = lower_32_bits(addr);
> -#ifdef CONFIG_DMA_ADDR_T_64BIT
> +#ifdef CONFIG_MMC_SDHCI_ADMA_64BIT
>  	desc->addr_hi = upper_32_bits(addr);
>  #endif
>  }
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 0178ed8a11..b27ce57d96 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -900,11 +900,10 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>  	host->adma_desc_table = sdhci_adma_init();
>  	host->adma_addr = (dma_addr_t)host->adma_desc_table;
> 
> -#ifdef CONFIG_DMA_ADDR_T_64BIT
> -	host->flags |= USE_ADMA64;
> -#else
> -	host->flags |= USE_ADMA;
> -#endif
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_ADMA_64BIT))
> +		host->flags |= USE_ADMA64;
> +	else
> +		host->flags |= USE_ADMA;
>  #endif
>  	if (host->quirks & SDHCI_QUIRK_REG32_RW)
>  		host->version =
> diff --git a/include/sdhci.h b/include/sdhci.h
> index a1b74e3bd7..07b84d6715 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -294,7 +294,7 @@ struct sdhci_ops {
>  };
> 
>  #define ADMA_MAX_LEN	65532
> -#ifdef CONFIG_DMA_ADDR_T_64BIT
> +#ifdef CONFIG_MMC_SDHCI_ADMA_64BIT
>  #define ADMA_DESC_LEN	16
>  #else
>  #define ADMA_DESC_LEN	8
> @@ -319,7 +319,7 @@ struct sdhci_adma_desc {
>  	u8 reserved;
>  	u16 len;
>  	u32 addr_lo;
> -#ifdef CONFIG_DMA_ADDR_T_64BIT
> +#ifdef CONFIG_MMC_SDHCI_ADMA_64BIT
>  	u32 addr_hi;
>  #endif
>  } __packed;
> --
> 2.43.2


