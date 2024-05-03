Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B0C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 02:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822A788374;
	Fri,  3 May 2024 04:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="mj/RMMEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E46288302; Fri,  3 May 2024 04:30:19 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D4188BC4
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 04:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240503022954epoutp045dae6a52d5bfdff330c60ff840343c85~L2ab4yhfg0495204952epoutp04X
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 02:29:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240503022954epoutp045dae6a52d5bfdff330c60ff840343c85~L2ab4yhfg0495204952epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714703394;
 bh=fLA5kKUYdzRTXvvdr86QZmkZMegwgHqCy4oh5yi8NI4=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=mj/RMMECKFVfZip//LeqANRgQ/8V1ipjKdMcPFcp8Fw5BTsCfpuuQmpieNYNzvEFI
 K7zemwflrgPLUOnDuU3EUQ1QNJqHTn1IxZrVj/ff3n8ULZkWDXh4PVsJuIMRJBnGrf
 wI9JTY/oVH3OsugDJD5ORkzgmeFECzfxqDo22CFI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240503022954epcas1p1097db7ed028de954611f971661b1b64b~L2abp1ATE1872118721epcas1p1v;
 Fri,  3 May 2024 02:29:54 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.133]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VVvsF0g2nz4x9Pw; Fri,  3 May
 2024 02:29:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E1.A3.09662.02C44366; Fri,  3 May 2024 11:29:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240503022952epcas1p4009ad5eb33a9462bf8ff876795125d5b~L2aZ0DIiy1549315493epcas1p4k;
 Fri,  3 May 2024 02:29:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240503022952epsmtrp16d998439331d8174487ff929b5ce8575~L2aZzO37b2340423404epsmtrp1W;
 Fri,  3 May 2024 02:29:52 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-50-66344c20626a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 21.D4.09238.F1C44366; Fri,  3 May 2024 11:29:51 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240503022951epsmtip1498b60fef421842790b5016b326b4e7f~L2aZnX4gk2448324483epsmtip1b;
 Fri,  3 May 2024 02:29:51 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>, <u-boot@lists.denx.de>
Cc: "'Weijie Gao'" <weijie.gao@mediatek.com>, "'GSS_MTK_Uboot_upstream'"
 <GSS_MTK_Uboot_upstream@mediatek.com>, "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
Subject: RE: [PATCH 01/81] mmc: Migrate MMC_SUPPORTS_TUNING to Kconfig
Date: Fri, 3 May 2024 11:29:51 +0900
Message-ID: <0cfe01da9d01$c6e33c80$54a9b580$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwoKaIExPajO/gZphEj9uH2EwYrwHFBUoMscqZw4A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmvq6Cj0mawZ2DlharFzUwW/xY9YXV
 YuqkzewWb/d2sls0vDjN7MDq8erAKnaPs3d2MHq0nNzP4rHx3Q6mAJaobJuM1MSU1CKF1Lzk
 /JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoMVKCmWJOaVAoYDE4mIlfTub
 ovzSklSFjPziElul1IKUnALTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMtedPsBcs62es6H60
 hL2BcUJpFyMnh4SAicSe92vYuhi5OIQEdjBKPG6exArhfGKUODnpCiOE841RouXnSjaYlp/v
 jzGB2EICexklXrzjhyh6ySjRf+YtC0iCTUBP4v+ihcwgtoiArcS+uX/ZQYqYBSYySvxZ/xBo
 LAcHp4CVRGerGkiNsICbxMpVvWC9LAIqEksOvwFbxitgKdFyZBcrxGIFiZ9Pl7FCzLSSOLPh
 BTuIzSwgIjG7s40ZZL6EwC12iY5VK8DmSwi4SDzpToXoFZZ4dXwLO4QtJfGyv40dor6ZUWLp
 koOsEE4Po8S/hutQbxpL7F86mQlkELOApsT6XfoQy/gk3n3tYYWYzyvR0SYEUa0icen1SyaY
 +Xef/Ie62UPiVNdyaJD2MkocmbmTaQKj/Cwkd89C2LCAkWkVo1hqQXFuemqxYYEhPC6T83M3
 MYKTnJbpDsaJbz/oHWJk4mA8xCjBwawkwqs92ThNiDclsbIqtSg/vqg0J7X4EKMpMCQnMkuJ
 JucD02xeSbyhiaWBiZmRsYmFoZmhkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MXK/U8rjv
 cF78+XRVhuPKJ5u//PU5yDNNyeisHp/Xmg0TXx8ND5RdF+c0N9ktXZ/ns6egvJWr1butdx+K
 tsftvfPL4OYprcN23xj/LTfbP23SHPb9H1u25TH9flV+7tnngDUcJRPPhz8qMf4/b912zv+e
 Txrkf/PyK9l6WoUe69980JYn78FXpoVSzyeZC8TlPZy6QIThm55zom2VsOPck7NSksuMm8SE
 /pfe2K4op6VU8HFm/pXYN4cfcZr82ubaYZ3k4nvqMSO3pILBqqn7ZbVuZhQcyCr7ZXNWO9+p
 2+GHJ4eZf5pGXGWYaCLrmwncaSv+LT1yc03rWRa2mpbv9emiQUoaVRXe81wmzz+kxFKckWio
 xVxUnAgA9XWURvsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnK68j0mawZVDNharFzUwW/xY9YXV
 YuqkzewWb/d2sls0vDjN7MDq8erAKnaPs3d2MHq0nNzP4rHx3Q6mAJYoLpuU1JzMstQifbsE
 roy150+wFyzrZ6zofrSEvYFxQmkXIyeHhICJxM/3x5i6GLk4hAR2M0qsevCQCSIhJfH56VS2
 LkYOIFtY4vDhYoia54wSC+5sZwepYRPQk/i/aCEziC0iYC9xuKuTDaSIWWAyo8Sk/9MYQRJC
 At2MEu8+O4EM4hSwkuhsVQMJCwu4Saxc1csCYrMIqEgsOfyGDcTmFbCUaDmyixXiBgWJn0+X
 sULMt5I4s+EF2F5mARGJ2Z1tzBMYBWYhcRcwMq5ilEwtKM5Nz002LDDMSy3XK07MLS7NS9dL
 zs/dxAgOUS2NHYz35v/TO8TIxMF4iFGCg1lJhFd7snGaEG9KYmVValF+fFFpTmrxIUZpDhYl
 cV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUx8mpLSD1lN7s5Rf7M7RrQp8t6+nVF6DhbnLs02
 l/gw44dW+6vVofmGcRtDPv3/MvN5iegyWd18F/al62umCHHP2ZRx7HuNuTPDffnFGt2XX8RO
 /e27/WyLWDM/H4tB9c3r3TN3Jm/9+377I9Y7X00UVeTcQozfuuS+f738z7VH5/yjz5cy7Xg5
 J6ZK/k7oM9FgraCyF5ueWr2d+v22zte9d+92Zt4+mnIx1S9Jyn171br1a+LXMvxbuO7Rj4kS
 YsJ3KqaFBTw54aU6+cXFh7Me1Zm3uhzgnvypa/HVTvtFf0Ln6/THCydunmtSy3H0QIitknho
 8ea5s3i51hzd8uNsSgeLxJ5LX9Qn3fQ7VTfxuBJLcUaioRZzUXEiABM/nt/AAgAA
X-CMS-MailID: 20240503022952epcas1p4009ad5eb33a9462bf8ff876795125d5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240502013146epcas1p3dce70115dbffcbd41eb7f657d6188d2e
References: <CGME20240502013146epcas1p3dce70115dbffcbd41eb7f657d6188d2e@epcas1p3.samsung.com>
 <20240502013138.2383421-1-trini@konsulko.com>
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, May 2, 2024 10:30 AM
> To: u-boot@lists.denx.de
> Cc: Weijie Gao <weijie.gao@mediatek.com>; GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>;
> Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Subject: [PATCH 01/81] mmc: Migrate MMC_SUPPORTS_TUNING to Kconfig
>
> The constraints on the MMC_SUPPORTS_TUNING symbol can easily be
> expressed in Kconfig (with the addition of SPL_MMC_SUPPORTS_TUNING).
> Furthermore, in order to remove <common.h> from the MMC subsystem, the
> way this symbol is used today needs to be changed in order to continue
> functioning.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/arm/mach-mediatek/Kconfig     |  1 +
>  arch/mips/mach-mtmips/Kconfig      |  1 +
>  drivers/mmc/Kconfig                | 11 +++++++++++
>  drivers/mmc/am654_sdhci.c          |  6 +++---
>  drivers/mmc/fsl_esdhc.c            |  4 ++--
>  drivers/mmc/fsl_esdhc_imx.c        |  8 ++++----
>  drivers/mmc/mmc-uclass.c           |  2 +-
>  drivers/mmc/mmc.c                  | 12 ++++++------
>  drivers/mmc/mtk-sd.c               |  4 ++--
>  drivers/mmc/octeontx_hsmmc.c       | 12 ++++++------
>  drivers/mmc/omap_hsmmc.c           |  4 ++--
>  drivers/mmc/sdhci-cadence.c        |  2 +-
>  drivers/mmc/sdhci.c                |  4 ++--
>  include/configs/mt7621.h           |  3 ---
>  include/configs/mt7623.h           |  3 ---
>  include/configs/octeontx2_common.h |  5 -----
>  include/mmc.h                      |  9 +--------
>  17 files changed, 43 insertions(+), 48 deletions(-)
>
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 82018bd9d3e3..ff1fdee5c8da 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -23,6 +23,7 @@ config TARGET_MT7622
>  config TARGET_MT7623
>  	bool "MediaTek MT7623 SoC"
>  	select CPU_V7A
> +	select MMC_SUPPORTS_TUNING
>  	help
>  	  The MediaTek MT7623 is a ARM-based SoC with a quad-core Cortex-A7
>  	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
> diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
> index 15b2792e619b..3fcd0b8465b4 100644
> --- a/arch/mips/mach-mtmips/Kconfig
> +++ b/arch/mips/mach-mtmips/Kconfig
> @@ -80,6 +80,7 @@ config SOC_MT7621
>  	bool "MT7621"
>  	select MIPS_CM
>  	select MIPS_L2_CACHE
> +	select MMC_SUPPORTS_TUNING
>  	select SYS_CACHE_SHIFT_5
>  	select SYS_MIPS_CACHE_INIT_RAM_LOAD
>  	select PINCTRL_MT7621
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 549634891a36..d0944793c92d 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -147,9 +147,16 @@ config SPL_MMC_IO_VOLTAGE
>  	  support. For eMMC this not mandatory, but not enabling this option may
>  	  prevent the driver of using the faster modes.
>
> +config MMC_SUPPORTS_TUNING
> +	bool
> +
> +config SPL_MMC_SUPPORTS_TUNING
> +	bool
> +
>  config MMC_UHS_SUPPORT
>  	bool "enable UHS support"
>  	depends on MMC_IO_VOLTAGE
> +	select MMC_SUPPORTS_TUNING
>  	help
>  	  The Ultra High Speed (UHS) bus is available on some SDHC and SDXC
>  	  cards. The IO voltage must be switchable from 3.3v to 1.8v. The bus
> @@ -158,6 +165,7 @@ config MMC_UHS_SUPPORT
>  config SPL_MMC_UHS_SUPPORT
>  	bool "enable UHS support in SPL"
>  	depends on SPL_MMC_IO_VOLTAGE
> +	select SPL_MMC_SUPPORTS_TUNING
>  	help
>  	  The Ultra High Speed (UHS) bus is available on some SDHC and SDXC
>  	  cards. The IO voltage must be switchable from 3.3v to 1.8v. The bus
> @@ -193,6 +201,7 @@ config SPL_MMC_HS400_SUPPORT
>
>  config MMC_HS200_SUPPORT
>  	bool "enable HS200 support"
> +	select MMC_SUPPORTS_TUNING
>  	help
>  	  The HS200 mode is support by some eMMC. The bus frequency is up to
>  	  200MHz. This mode requires tuning the IO.
> @@ -200,6 +209,7 @@ config MMC_HS200_SUPPORT
>  config SPL_MMC_HS200_SUPPORT
>  	bool "enable HS200 support in SPL"
>  	depends on SPL_MMC
> +	select SPL_MMC_SUPPORTS_TUNING
>  	help
>  	  The HS200 mode is support by some eMMC. The bus frequency is up to
>  	  200MHz. This mode requires tuning the IO.
> @@ -347,6 +357,7 @@ config MMC_OCTEONTX
>  	bool "Marvell Octeon Multimedia Card Interface support"
>  	depends on (ARCH_OCTEON || ARCH_OCTEONTX || ARCH_OCTEONTX2)
>  	depends on DM_MMC
> +	select MMC_SUPPORTS_TUNING if ARCH_OCTEONTX2
>  	help
>  	  This selects the Octeon Multimedia card Interface.
>  	  If you have an OcteonTX/TX2 or MIPS Octeon board with a
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index fadab7d40bb7..ffb461c2f6c1 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> @@ -397,7 +397,7 @@ static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
>
>  	writeb(val, host->ioaddr + reg);
>  }
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  #define ITAPDLY_LENGTH 32
>  #define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
>
> @@ -500,7 +500,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>  }
>  #endif
>  const struct sdhci_ops am654_sdhci_ops = {
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.platform_execute_tuning = am654_sdhci_execute_tuning,
>  #endif
>  	.deferred_probe		= am654_sdhci_deferred_probe,
> @@ -560,7 +560,7 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
>  }
>
>  const struct sdhci_ops j721e_4bit_sdhci_ops = {
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.platform_execute_tuning = am654_sdhci_execute_tuning,
>  #endif
>  	.deferred_probe		= am654_sdhci_deferred_probe,
> diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
> index 595d88bd5625..5ac1c6a0e9e1 100644
> --- a/drivers/mmc/fsl_esdhc.c
> +++ b/drivers/mmc/fsl_esdhc.c
> @@ -1102,7 +1102,7 @@ static int fsl_esdhc_reinit(struct udevice *dev)
>  	return esdhc_init_common(priv, &plat->mmc);
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static int fsl_esdhc_execute_tuning(struct udevice *dev, uint32_t opcode)
>  {
>  	struct fsl_esdhc_plat *plat = dev_get_plat(dev);
> @@ -1175,7 +1175,7 @@ static const struct dm_mmc_ops fsl_esdhc_ops = {
>  	.get_cd		= fsl_esdhc_get_cd,
>  	.send_cmd	= fsl_esdhc_send_cmd,
>  	.set_ios	= fsl_esdhc_set_ios,
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.execute_tuning = fsl_esdhc_execute_tuning,
>  #endif
>  	.reinit = fsl_esdhc_reinit,
> diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
> index b74c01400205..8b2ef9391f3e 100644
> --- a/drivers/mmc/fsl_esdhc_imx.c
> +++ b/drivers/mmc/fsl_esdhc_imx.c
> @@ -635,7 +635,7 @@ static void set_sysctl(struct fsl_esdhc_priv *priv, struct mmc *mmc, uint clock)
>  	priv->clock = clock;
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static int esdhc_change_pinstate(struct udevice *dev)
>  {
>  	struct fsl_esdhc_priv *priv = dev_get_priv(dev);
> @@ -913,7 +913,7 @@ static int esdhc_set_ios_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
>  	int ret __maybe_unused;
>  	u32 clock;
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	/*
>  	 * call esdhc_set_timing() before update the clock rate,
>  	 * This is because current we support DDR and SDR mode,
> @@ -951,7 +951,7 @@ static int esdhc_set_ios_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
>  			esdhc_setbits32(&regs->sysctl, SYSCTL_PEREN | SYSCTL_CKEN);
>  	}
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	/*
>  	 * For HS400/HS400ES mode, make sure set the strobe dll in the
>  	 * target clock rate. So call esdhc_set_strobe_dll() after the
> @@ -1618,7 +1618,7 @@ static const struct dm_mmc_ops fsl_esdhc_ops = {
>  	.get_cd		= fsl_esdhc_get_cd,
>  	.send_cmd	= fsl_esdhc_send_cmd,
>  	.set_ios	= fsl_esdhc_set_ios,
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.execute_tuning	= fsl_esdhc_execute_tuning,
>  #endif
>  #if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 24170c59ecc1..0685b86af464 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -112,7 +112,7 @@ int mmc_getcd(struct mmc *mmc)
>  	return dm_mmc_get_cd(mmc->dev);
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static int dm_mmc_execute_tuning(struct udevice *dev, uint opcode)
>  {
>  	struct dm_mmc_ops *ops = mmc_get_ops(dev);
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 7b068c71ff37..4543d94c7205 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -329,7 +329,7 @@ int mmc_set_blocklen(struct mmc *mmc, int len)
>  				   MMC_QUIRK_RETRY_SET_BLOCKLEN, 4);
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static const u8 tuning_blk_pattern_4bit[] = {
>  	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
>  	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
> @@ -1621,7 +1621,7 @@ static inline int bus_width(uint cap)
>  }
>
>  #if !CONFIG_IS_ENABLED(DM_MMC)
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static int mmc_execute_tuning(struct mmc *mmc, uint opcode)
>  {
>  	return -ENOTSUPP;
> @@ -1702,7 +1702,7 @@ void mmc_dump_capabilities(const char *text, uint caps)
>  struct mode_width_tuning {
>  	enum bus_mode mode;
>  	uint widths;
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	uint tuning;
>  #endif
>  };
> @@ -1743,7 +1743,7 @@ static inline int mmc_set_signal_voltage(struct mmc *mmc, uint signal_voltage)
>  #if !CONFIG_IS_ENABLED(MMC_TINY)
>  static const struct mode_width_tuning sd_modes_by_pref[] = {
>  #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	{
>  		.mode = UHS_SDR104,
>  		.widths = MMC_MODE_4BIT | MMC_MODE_1BIT,
> @@ -1846,7 +1846,7 @@ static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
>  				mmc_set_clock(mmc, mmc->tran_speed,
>  						MMC_CLK_ENABLE);
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  				/* execute tuning if needed */
>  				if (mwt->tuning && !mmc_host_is_spi(mmc)) {
>  					err = mmc_execute_tuning(mmc,
> @@ -2224,7 +2224,7 @@ static int mmc_select_mode_and_width(struct mmc *mmc, uint card_caps)
>  				mmc_select_mode(mmc, mwt->mode);
>  				mmc_set_clock(mmc, mmc->tran_speed,
>  					      MMC_CLK_ENABLE);
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>
>  				/* execute tuning if needed */
>  				if (mwt->tuning) {
> diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
> index 296aaee73318..4bd66ecf93ad 100644
> --- a/drivers/mmc/mtk-sd.c
> +++ b/drivers/mmc/mtk-sd.c
> @@ -1011,7 +1011,7 @@ static int msdc_ops_get_wp(struct udevice *dev)
>  #endif
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static u32 test_delay_bit(u32 delay, u32 bit)
>  {
>  	bit %= PAD_DELAY_MAX;
> @@ -1760,7 +1760,7 @@ static const struct dm_mmc_ops msdc_ops = {
>  	.set_ios = msdc_ops_set_ios,
>  	.get_cd = msdc_ops_get_cd,
>  	.get_wp = msdc_ops_get_wp,
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.execute_tuning = msdc_execute_tuning,
>  #endif
>  	.wait_dat0 = msdc_ops_wait_dat0,
> diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
> index 7f9c4f4d36d4..3b5e12217325 100644
> --- a/drivers/mmc/octeontx_hsmmc.c
> +++ b/drivers/mmc/octeontx_hsmmc.c
> @@ -794,7 +794,7 @@ octeontx_mmc_get_cr_mods(struct mmc *mmc, const struct mmc_cmd *cmd,
>  	u8 desired_ctype = 0;
>
>  	if (IS_MMC(mmc)) {
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  		if (cmd->cmdidx == MMC_CMD_SEND_TUNING_BLOCK_HS200) {
>  			if (cmd->resp_type == MMC_RSP_R1)
>  				cr.rtype_xor = 1;
> @@ -1631,7 +1631,7 @@ static int octeontx_mmc_dev_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>  	return octeontx_mmc_send_cmd(dev_to_mmc(dev), cmd, data);
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static int octeontx_mmc_test_cmd(struct mmc *mmc, u32 opcode, int *statp)
>  {
>  	struct mmc_cmd cmd;
> @@ -2421,12 +2421,12 @@ static int octeontx_mmc_execute_tuning(struct udevice *dev, u32 opcode)
>
>  	return 0;
>  }
> -#else /* MMC_SUPPORTS_TUNING */
> +#else /* CONFIG_MMC_SUPPORTS_TUNING */
>  static void octeontx_mmc_set_emm_timing(struct mmc *mmc,
>  					union mio_emm_timing emm_timing)
>  {
>  }
> -#endif /* MMC_SUPPORTS_TUNING */
> +#endif /* CONFIG_MMC_SUPPORTS_TUNING */
>
>  /**
>   * Calculate the clock period with rounding up
> @@ -2573,7 +2573,7 @@ static int octeontx_mmc_set_ios(struct udevice *dev)
>
>  	err = octeontx_mmc_configure_delay(mmc);
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	if (!err && mmc->selected_mode == MMC_HS_400 && !slot->hs400_tuned) {
>  		debug("%s: Tuning HS400 mode\n", __func__);
>  		err = octeontx_tune_hs400(mmc);
> @@ -3776,7 +3776,7 @@ static const struct dm_mmc_ops octeontx_hsmmc_ops = {
>  	.set_ios = octeontx_mmc_set_ios,
>  	.get_cd = octeontx_mmc_get_cd,
>  	.get_wp = octeontx_mmc_get_wp,
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.execute_tuning = octeontx_mmc_execute_tuning,
>  #endif
>  };
> diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
> index 99f21b2c546a..118d9cd16fdb 100644
> --- a/drivers/mmc/omap_hsmmc.c
> +++ b/drivers/mmc/omap_hsmmc.c
> @@ -577,7 +577,7 @@ static uint32_t omap_hsmmc_set_capabilities(struct mmc *mmc)
>  	return val;
>  }
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static void omap_hsmmc_disable_tuning(struct mmc *mmc)
>  {
>  	struct hsmmc *mmc_base;
> @@ -1518,7 +1518,7 @@ static const struct dm_mmc_ops omap_hsmmc_ops = {
>  	.get_cd		= omap_hsmmc_getcd,
>  	.get_wp		= omap_hsmmc_getwp,
>  #endif
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.execute_tuning = omap_hsmmc_execute_tuning,
>  #endif
>  	.wait_dat0	= omap_hsmmc_wait_dat0,
> diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
> index c0a9f60b1496..0570dbca00d7 100644
> --- a/drivers/mmc/sdhci-cadence.c
> +++ b/drivers/mmc/sdhci-cadence.c
> @@ -274,7 +274,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
>  	host->ops = &sdhci_cdns_ops;
>  	host->quirks |= SDHCI_QUIRK_WAIT_SEND_CMD;
>  	sdhci_cdns_mmc_ops = sdhci_ops;
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	sdhci_cdns_mmc_ops.execute_tuning = sdhci_cdns_execute_tuning;
>  #endif
>
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index af654ea8d13c..d06f2c02bb7b 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -351,7 +351,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>  		return -ECOMM;
>  }
>
> -#if defined(CONFIG_DM_MMC) && defined(MMC_SUPPORTS_TUNING)
> +#if defined(CONFIG_DM_MMC) && CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  static int sdhci_execute_tuning(struct udevice *dev, uint opcode)
>  {
>  	int err;
> @@ -848,7 +848,7 @@ const struct dm_mmc_ops sdhci_ops = {
>  	.set_ios	= sdhci_set_ios,
>  	.get_cd		= sdhci_get_cd,
>  	.deferred_probe	= sdhci_deferred_probe,
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.execute_tuning	= sdhci_execute_tuning,
>  #endif
>  	.wait_dat0	= sdhci_wait_dat0,
> diff --git a/include/configs/mt7621.h b/include/configs/mt7621.h
> index bf2bc2d45c09..e6dba7071950 100644
> --- a/include/configs/mt7621.h
> +++ b/include/configs/mt7621.h
> @@ -14,9 +14,6 @@
>
>  #define CFG_SYS_INIT_SP_OFFSET		0x800000
>
> -/* MMC */
> -#define MMC_SUPPORTS_TUNING
> -
>  /* Serial SPL */
>  #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
>  #define CFG_SYS_NS16550_CLK		50000000
> diff --git a/include/configs/mt7623.h b/include/configs/mt7623.h
> index fca234a1dc71..6f42cd32d80f 100644
> --- a/include/configs/mt7623.h
> +++ b/include/configs/mt7623.h
> @@ -11,9 +11,6 @@
>
>  #include <linux/sizes.h>
>
> -/* MMC */
> -#define MMC_SUPPORTS_TUNING
> -
>  /* DRAM */
>  #define CFG_SYS_SDRAM_BASE		0x80000000
>
> diff --git a/include/configs/octeontx2_common.h b/include/configs/octeontx2_common.h
> index c4db38562d83..f415dffddbea 100644
> --- a/include/configs/octeontx2_common.h
> +++ b/include/configs/octeontx2_common.h
> @@ -19,9 +19,4 @@
>  					"loadaddr=20080000\0"	\
>  					"ethrotate=yes\0"
>
> -#if defined(CONFIG_MMC_OCTEONTX)
> -#define MMC_SUPPORTS_TUNING
> -/** EMMC specific defines */
> -#endif
> -
>  #endif /* __OCTEONTX2_COMMON_H__ */
> diff --git a/include/mmc.h b/include/mmc.h
> index 4b8327f1f93b..7f1900363b91 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -18,13 +18,6 @@
>
>  struct bd_info;
>
> -#if CONFIG_IS_ENABLED(MMC_HS200_SUPPORT)
> -#define MMC_SUPPORTS_TUNING
> -#endif
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
> -#define MMC_SUPPORTS_TUNING
> -#endif
> -
>  /* SD/MMC version bits; 8 flags, 8 major, 8 minor, 8 change */
>  #define SD_VERSION_SD	(1U << 31)
>  #define MMC_VERSION_MMC	(1U << 30)
> @@ -485,7 +478,7 @@ struct dm_mmc_ops {
>  	 */
>  	int (*get_wp)(struct udevice *dev);
>
> -#ifdef MMC_SUPPORTS_TUNING
> +#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	/**
>  	 * execute_tuning() - Start the tuning process
>  	 *
> --
> 2.34.1



