Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E965C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4217A8752D;
	Fri,  3 Nov 2023 01:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Emsui5Fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491778752D; Fri,  3 Nov 2023 01:03:17 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE2E87559
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231103000302epoutp01c46c8a323219100e5130d16c476fb78a~T9AQM8oSL0671106711epoutp01h
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 00:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231103000302epoutp01c46c8a323219100e5130d16c476fb78a~T9AQM8oSL0671106711epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698969782;
 bh=juKD+gv2dtYeSpck7CAMTKNkwqROh71x9Iv4FQYL+Yk=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Emsui5FrsS1t436VBUx5GJlB5uz4P63Rhf23WKWCRWz3NzImLQ2n3jBgPNttsNw86
 64wKdAXNuTWWfg0+fN+JLgTNzoMCewrHC+/t7myIDOxTSJfYFrD1d+TkGYVJ6b3YiG
 KfXQOsiaqWL6ruTIFw7Wb0tlE24LeE2TS45s5974=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231103000302epcas1p26ce72437a505a32255b50bf5de940487~T9AP6uPT01424514245epcas1p2o;
 Fri,  3 Nov 2023 00:03:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
 (Postfix) with ESMTP id 4SM1Cp2N2cz4x9Q7; Fri,  3 Nov 2023 00:03:02 +0000
 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231101001948epcas1p21f7980fd9ab6a99e884eeb08409b1f48~TV8UzFCp41970119701epcas1p21;
 Wed,  1 Nov 2023 00:19:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101001948epsmtrp1e3ca5358325ad3c929454b3ba5f3c001~TV8UyOwUM3058230582epsmtrp1b;
 Wed,  1 Nov 2023 00:19:48 +0000 (GMT)
X-AuditID: b6c32a28-7d1ff70000001cc8-4b-654199a4334a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.B9.07368.4A991456; Wed,  1 Nov 2023 09:19:48 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101001948epsmtip1cec8ae8d69b020c3fe1129aa07deaa0f~TV8Uk3fTI1861418614epsmtip1z;
 Wed,  1 Nov 2023 00:19:48 +0000 (GMT)
Message-ID: <1891546521.01698969782305.JavaMail.epsvc@epcpadp4>
Date: Wed, 1 Nov 2023 09:19:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: Add support for Cadence sdmmc v6
Content-Language: en-US
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Cc: yuklin.soo@starfivetech.com, weiliang.lim@starfivetech.com, Kuan Lim Lee
 <kuanlim.lee@linux.starfivetech.com>, cpgs@samsung.com
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231003072320.2008-1-kuanlim.lee@starfivetech.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnO6SmY6pBvtfG1m8PKRpMXk7s0XX
 pvdMFm/3drJbvN8zm91iy/ITzA5sHhN+unicvbOD0aNvyypGj9tneQNYorhsUlJzMstSi/Tt
 ErgyDi5cxVTQO4GxYvMC9wbGN8VdjJwcEgImEjdX7WUHsYUEdjNK3F1lDxGXkvj8dCpbFyMH
 kC0scfgwUDkXUMlbRonjS7Yzg9TwCthJXPi9GqyXRUBFYv20F4wQcUGJkzOfsIDYogLyEvdv
 zQCrERbwlDjz9hNYDbOAuMStJ/OZQGwRAVeJGQcbmEAWMAu0Mkq8WHiOFeIgB4nbn9vYQGw2
 AR2J7d+OgzVwCjhKNP+9ywRyHLOAusT6eUIQM+Ultr+dwzyBUWgWkjNmIVk3C6FjFpKOBYws
 qxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxguNCS2MH4735//QOMTJxMB5ilOBgVhLh
 PWzqkCrEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHpxTQt1sP
 vW87Ye9wZ3JIzbsX7H1N8kEC0dtut1Xtbq062PqxbE+P0t1dtxZ+sBK5f7zyW94cg4KX87/J
 Pa/Uv3Lo9dkVVeKrpU48qK29ZZ76J1lIwWlC6crKtMleFk/8dwfF9xyV6nt88rn409NZS1do
 Crn9ClyxcOVaowmtfDNsg46ZJ3TaGnrdUyixvPQmer5LobeCPkNuMsfU5Xve7rBVedokmiR+
 5sbb1iiXrceezjl65fvsf8qF5a5eXzUrPOovhrBW9XX/e+7E/9PW3HxtG/fBauG4IwvrwxRj
 Tka6R32VFNKU5mz/e3bbNXYene/bb65jP5vKNS1N4ZFsSmP7DOXi3rIFdznCJTfoq8gpsRRn
 JBpqMRcVJwIA/4lCefoCAAA=
X-CMS-MailID: 20231101001948epcas1p21f7980fd9ab6a99e884eeb08409b1f48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20231101001948epcas1p21f7980fd9ab6a99e884eeb08409b1f48
References: <20231003072320.2008-1-kuanlim.lee@starfivetech.com>
 <CGME20231101001948epcas1p21f7980fd9ab6a99e884eeb08409b1f48@epcas1p2.samsung.com>
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

Hi

On 10/3/23 16:22, Kuan Lim Lee wrote:
> From: Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>
> 
> Cadence SDMMC v6 controller has a lot of changes on initialize
> compared to v4 controller. PHY is needed by v6 controller.
> 
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Reviewed-by: Alex Soo <yuklin.soo@starfivetech.com>
> Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>

I didn't see their Reviewed-by tag in mailing list.

> ---
>  drivers/mmc/Kconfig              |  13 ++
>  drivers/mmc/Makefile             |   1 +
>  drivers/mmc/sdhci-cadence.c      |  63 ++-----
>  drivers/mmc/sdhci-cadence.h      |  68 +++++++
>  drivers/mmc/sdhci-cadence6-phy.c | 302 +++++++++++++++++++++++++++++++
>  5 files changed, 396 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/mmc/sdhci-cadence.h
>  create mode 100644 drivers/mmc/sdhci-cadence6-phy.c
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index de01b9687b..cec881d862 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -573,6 +573,19 @@ config MMC_SDHCI_CADENCE
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_CADENCE_V6
> +	bool "SDHCI support for the Cadence SD/SDIO/eMMC controller & driver version 6"
> +	depends on BLK && DM_MMC
> +	depends on MMC_SDHCI
> +	depends on OF_CONTROL
> +	select MMC_SDHCI_CADENCE
> +	help
> +	  This selects the Cadence SD/SDIO/eMMC driver version 6.
> +
> +	  If you have a controller with this interface, say Y here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_AM654
>  	bool "SDHCI Controller on TI's Am654 devices"
>  	depends on ARCH_K3
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 2c65c4765a..cdcce55b8b 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_MMC_SDHCI_ATMEL)		+= atmel_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= bcm2835_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_BCMSTB)		+= bcmstb_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
> +obj-$(CONFIG_MMC_SDHCI_CADENCE_V6)	+= sdhci-cadence6-phy.o
>  obj-$(CONFIG_MMC_SDHCI_AM654)		+= am654_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)		+= iproc_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_KONA)		+= kona_sdhci.o
> diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
> index 327a05ad11..d7a270e74c 100644
> --- a/drivers/mmc/sdhci-cadence.c
> +++ b/drivers/mmc/sdhci-cadence.c
> @@ -17,56 +17,7 @@
>  #include <linux/libfdt.h>
>  #include <mmc.h>
>  #include <sdhci.h>
> -
> -/* HRS - Host Register Set (specific to Cadence) */
> -#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> -#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
> -#define   SDHCI_CDNS_HRS04_RD			BIT(25)
> -#define   SDHCI_CDNS_HRS04_WR			BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
> -#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
> -#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
> -
> -#define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
> -#define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
> -#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
> -#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
> -#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
> -#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
> -#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
> -#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
> -#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
> -#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
> -
> -/* SRS - Slot Register Set (SDHCI-compatible) */
> -#define SDHCI_CDNS_SRS_BASE		0x200
> -
> -/* PHY */
> -#define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
> -#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
> -#define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
> -#define SDHCI_CDNS_PHY_DLY_UHS_SDR25	0x03
> -#define SDHCI_CDNS_PHY_DLY_UHS_SDR50	0x04
> -#define SDHCI_CDNS_PHY_DLY_UHS_DDR50	0x05
> -#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
> -#define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
> -#define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
> -#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
> -#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
> -#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
> -
> -/*
> - * The tuned val register is 6 bit-wide, but not the whole of the range is
> - * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
> - * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
> - */
> -#define SDHCI_CDNS_MAX_TUNING_LOOP	40
> -
> -struct sdhci_cdns_plat {
> -	struct mmc_config cfg;
> -	struct mmc mmc;
> -	void __iomem *hrs_addr;
> -};
> +#include "sdhci-cadence.h"
>  
>  struct sdhci_cdns_phy_cfg {
>  	const char *property;
> @@ -112,8 +63,11 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_plat *plat,
>  }
>  
>  static int sdhci_cdns_phy_init(struct sdhci_cdns_plat *plat,
> -				const void *fdt, int nodeoffset)
> +			       const void *fdt, int nodeoffset)

Is there any reason to touch this?


>  {
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
> +		return sdhci_cdns6_phy_init(plat, SDHCI_CDNS_HRS06_MODE_SD);
> +
>  	const fdt32_t *prop;
>  	int ret, i;
>  
> @@ -163,6 +117,9 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
>  	tmp &= ~SDHCI_CDNS_HRS06_MODE;
>  	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
>  	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS06);
> +
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
> +		sdhci_cdns6_phy_init(plat, mode);
>  }
>  
>  static const struct sdhci_ops sdhci_cdns_ops = {
> @@ -172,6 +129,9 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
>  				   unsigned int val)
>  {
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
> +		return sdhci_cdns6_set_tune_val(plat, val);
> +
>  	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS06;
>  	u32 tmp;
>  	int i, ret;
> @@ -301,6 +261,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
>  static const struct udevice_id sdhci_cdns_match[] = {
>  	{ .compatible = "socionext,uniphier-sd4hc" },
>  	{ .compatible = "cdns,sd4hc" },
> +	{ .compatible = "cdns,sd6hc" },
>  	{ /* sentinel */ }
>  };
>  
> diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
> new file mode 100644
> index 0000000000..2c42cff2f3
> --- /dev/null
> +++ b/drivers/mmc/sdhci-cadence.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 Starfive.
> + *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>


Does it right Copyright and author? the below codes are taken from sdhci-cadence.c.

> + */
> +
> +#ifndef SDHCI_CADENCE_H_
> +#define SDHCI_CADENCE_H_
> +
> +/* HRS - Host Register Set (specific to Cadence) */
> +/* PHY access port */
> +#define SDHCI_CDNS_HRS04		0x10
> +/* Cadence V4 HRS04 Description*/
> +#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
> +#define   SDHCI_CDNS_HRS04_RD			BIT(25)
> +#define   SDHCI_CDNS_HRS04_WR			BIT(24)
> +#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
> +#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
> +#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
> +
> +#define SDHCI_CDNS_HRS05		0x14
> +
> +/* eMMC control */
> +#define SDHCI_CDNS_HRS06		0x18
> +#define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
> +#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
> +#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
> +#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
> +
> +/* SRS - Slot Register Set (SDHCI-compatible) */
> +#define SDHCI_CDNS_SRS_BASE		0x200
> +
> +/* Cadence V4 PHY Setting*/
> +#define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
> +#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR25	0x03
> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR50	0x04
> +#define SDHCI_CDNS_PHY_DLY_UHS_DDR50	0x05
> +#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
> +#define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
> +#define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
> +#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
> +#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
> +#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
> +
> +/*
> + * The tuned val register is 6 bit-wide, but not the whole of the range is
> + * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
> + * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
> + */
> +#define SDHCI_CDNS_MAX_TUNING_LOOP	40
> +
> +struct sdhci_cdns_plat {
> +	struct mmc_config cfg;
> +	struct mmc mmc;
> +	void __iomem *hrs_addr;
> +};
> +
> +int sdhci_cdns6_phy_init(struct sdhci_cdns_plat *plat, u32 mode);
> +int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val);
> +
> +#endif
> diff --git a/drivers/mmc/sdhci-cadence6-phy.c b/drivers/mmc/sdhci-cadence6-phy.c
> new file mode 100644
> index 0000000000..dd3df27dc8
> --- /dev/null
> +++ b/drivers/mmc/sdhci-cadence6-phy.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-or-platform_driver
> +/*
> + * Copyright (C) 2022 Starfive.

s/2022/2023?

> + *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <asm/global_data.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/sizes.h>
> +#include <linux/libfdt.h>
> +#include <mmc.h>
> +#include <sdhci.h>
> +#include "sdhci-cadence.h"
> +
> +/* IO Delay Information */
> +#define SDHCI_CDNS_HRS07		0X1C
> +#define   SDHCI_CDNS_HRS07_RW_COMPENSATE		GENMASK(20, 16)
> +#define   SDHCI_CDNS_HRS07_IDELAY_VAL			GENMASK(4, 0)
> +
> +#define SDHCI_CDNS_HRS09		0x24		/* PHY Control and Status */
> +#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
> +#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
> +#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
> +#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
> +#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
> +#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
> +
> +#define SDHCI_CDNS_HRS10		0x28		/* SDCLK adjustment */
> +#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
> +
> +#define SDHCI_CDNS_HRS16		0x40		/* CMD/DAT output delay */
> +
> +/* PHY Special Function Registers */
> +//#define DLL_PHY_REG_BASE		0x2000
> +
> +/* register to control the DQ related timing */
> +#define PHY_DQ_TIMING_REG_ADDR		0x2000
> +
> +/* register to control the DQS related timing */
> +#define PHY_DQS_TIMING_REG_ADDR		0x2004
> +
> +/* register to control the gate and loopback control related timing */
> +#define PHY_GATE_LPBK_CTRL_REG_ADDR	0x2008
> +
> +/* register to control the Master DLL logic */
> +#define PHY_DLL_MASTER_CTRL_REG_ADDR	0x200C
> +
> +/* register to control the Slave DLL logic */
> +#define PHY_DLL_SLAVE_CTRL_REG_ADDR	0x2010
> +#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
> +#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
> +
> +/* register to control the global settings for PHY */
> +#define PHY_CTRL_REG_ADDR		0x2080
> +
> +struct phy_reg {
> +	u32 phy_dqs_timing;
> +	u32 phy_gate_lpbk_ctrl;
> +	//u32 phy_dll_master_ctrl;

Remove unused code.

> +	u32 phy_dll_slave_ctrl;
> +	//u32 phy_ctrl;

ditto

> +	u32 phy_dq_timing;
> +	//cp_sw_half_cycle_shift; ASIC

Ditto

> +};
> +
> +struct controller_reg {
> +	u32 hrs07;
> +	u32 hrs09;
> +	u32 hrs10;
> +	u32 hrs16;
> +};


As some reg values can be re-used. I don't know what its value means.
e.g) 0x00380004 is sued sd_ds/emmc_sdr/emmc_ddr/emmc_hs200.

I don't want to use a magic code. If you can add some macros, it's more readable.

> +
> +static struct phy_reg sd_ds_phy_cfg = {
> +	0x00380004,
> +	0x01A00040,
> +	0x00000000,
> +	0x00000001,
> +};
> +
> +static struct phy_reg emmc_sdr_phy_cfg = {
> +	0x00380004,
> +	0x01A00040,
> +	0x00000000,
> +	0x00000001,
> +};
> +
> +static struct phy_reg emmc_ddr_phy_cfg = {
> +	0x00380004,
> +	0x01A00040,
> +	0x00000000,
> +	0x10000001,
> +};
> +
> +static struct phy_reg emmc_hs200_phy_cfg = {
> +	0x00380004,
> +	0x01A00040,
> +	0x00DADA00,
> +	0x00000001,
> +};
> +
> +static struct phy_reg emmc_hs400_phy_cfg = {
> +	0x00280004,
> +	0x01A00040,
> +	0x00DAD800,
> +	0x00000001,
> +};
> +
> +static struct controller_reg sd_ds_ctrl_cfg = {
> +	0x00080000,
> +	0x0001800C,
> +	0x00020000,
> +	0x00000000,
> +};
> +
> +static struct controller_reg emmc_sdr_ctrl_cfg = {
> +	0x00080000,
> +	0x0001800C,
> +	0x00030000,
> +	0x00000000,
> +};
> +
> +static struct controller_reg emmc_ddr_ctrl_cfg = {
> +	0x00090001,
> +	0x0001800C,
> +	0x00020000,
> +	0x11000001,
> +};
> +
> +static struct controller_reg emmc_hs200_ctrl_cfg = {
> +	0x00090000,
> +	0x00018000,
> +	0x00080000,
> +	0x00000000,
> +};
> +
> +static struct controller_reg emmc_hs400_ctrl_cfg = {
> +	0x00080000,
> +	0x00018000,
> +	0x00080000,
> +	0x11000000,
> +};
> +
> +static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_plat *plat, 
> +					     u32 addr)
> +{
> +	u32 data = 0;
> +
> +	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
> +	data = readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
> +	return data;
> +}
> +
> +static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, 
> +				      u32 addr, u32 data)
> +{
> +	u32 readdat = 0;
> +
> +	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
> +	writel(data, plat->hrs_addr + SDHCI_CDNS_HRS05);
> +	readdat = readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
> +
> +	if (readdat != data) {
> +		pr_err("Error, %s: Writing failed!: address: 0x%x, value : 0x%x, 
> +		       readval: 0x%x\n", __func__, addr, data, readdat);


Doesn't need to return error value? 


> +	}
> +}
> +
> +static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, 
> +				     unsigned int reset)
> +{
> +	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
> +	u32 tmp;
> +	int ret;
> +
> +	tmp = readl(reg);
> +	tmp &= ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
> +
> +	if (reset)	/* Switch On DLL Reset */


	/* Swithc On DLL Reset */
	if (reset)
		...
	else
		...


> +		tmp |= FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 0);
> +	else		/* Switch Off DLL Reset */
> +		tmp |= FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 1);
> +
> +	writel(tmp, reg);
> +
> +	if (!reset) {
> +		ret = readl_poll_timeout(reg, tmp, 
> +					 (tmp & SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
> +					 3000);

Add a comment why it needs to poll during 3000.

> +	}
> +
> +	return ret;
> +}
> +
> +int sdhci_cdns6_phy_init(struct sdhci_cdns_plat *plat, u32 mode)
> +{
> +	struct phy_reg *phy_cfgs;
> +	struct controller_reg *ctrl_cfgs;
> +	void __iomem *reg = NULL;
> +	u32 tmp;
> +	int ret;
> +
> +	switch (mode) {
> +	case SDHCI_CDNS_HRS06_MODE_SD:
> +		phy_cfgs = &sd_ds_phy_cfg;
> +		ctrl_cfgs = &sd_ds_ctrl_cfg;
> +		break;
> +
> +	case SDHCI_CDNS_HRS06_MODE_MMC_SDR:
> +		phy_cfgs = &emmc_sdr_phy_cfg;
> +		ctrl_cfgs = &emmc_sdr_ctrl_cfg;
> +		break;
> +
> +	case SDHCI_CDNS_HRS06_MODE_MMC_DDR:
> +		phy_cfgs = &emmc_ddr_phy_cfg;
> +		ctrl_cfgs = &emmc_ddr_ctrl_cfg;
> +		break;
> +
> +	case SDHCI_CDNS_HRS06_MODE_MMC_HS200:
> +		phy_cfgs = &emmc_hs200_phy_cfg;
> +		ctrl_cfgs = &emmc_hs200_ctrl_cfg;
> +		break;
> +
> +	case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
> +		phy_cfgs = &emmc_hs400_phy_cfg;
> +		ctrl_cfgs = &emmc_hs400_ctrl_cfg;
> +		break;


If there is no matched mod, phy_cfgs and ctrl_cfgs should be NULL.

> +	}
> +
> +	/* Switch On the DLL Reset */
> +	sdhci_cdns6_reset_phy_dll(plat, 1);
> +
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, 
> +				  phy_cfgs->phy_dqs_timing);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, 
> +				  phy_cfgs->phy_gate_lpbk_ctrl);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, 
> +				  phy_cfgs->phy_dll_slave_ctrl);
> +
> +	/* Switch Off the DLL Reset */
> +	ret = sdhci_cdns6_reset_phy_dll(plat, 0);
> +	if (ret) {
> +		printf("sdhci_cdns6_reset_phy is not completed\n");
> +		return ret;
> +	}
> +
> +	/* Set PHY DQ TIMING control register */
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, 
> +				  phy_cfgs->phy_dq_timing);
> +
> +	/* Set HRS09 register */
> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
> +	tmp = readl(reg);


I'm not suer why plat-hrs_addr assigned to reg.
How about using the below?

hrs_base_addr = plat->hrs_addr;

readl(hrs_base_addr + SDHCI_CDNS_HRS10);

Then you can change the below code like

readl(hrs_base_addr + SDHCI_CDNS_HRS16);
readl(hrs_base_addr + SDHCI_CDNS_HRS07);

Otherwise, readl(plat->hrs_addr + SDHCI_xxx);


> +	tmp &= ~(SDHCI_CDNS_HRS09_EXTENDED_WR_MODE |
> +		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
> +		 SDHCI_CDNS_HRS09_RDDATA_EN |
> +		 SDHCI_CDNS_HRS09_RDCMD_EN);
> +	tmp |= ctrl_cfgs->hrs09;
> +	writel(tmp, reg);
> +
> +	/* Set HRS10 register */
> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS10;
> +	tmp = readl(reg);
> +	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
> +	tmp |= ctrl_cfgs->hrs10;
> +	writel(tmp, reg);
> +
> +	/* Set HRS16 register */
> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS16;
> +	tmp = ctrl_cfgs->hrs16;
> +	writel(tmp, reg);
> +
> +	/* Set HRS07 register */
> +	reg = plat->hrs_addr + SDHCI_CDNS_HRS07;
> +	tmp = ctrl_cfgs->hrs07;
> +	writel(tmp, reg);
> +
> +	return 0;
> +}
> +
> +int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, 
> +			     unsigned int val)
> +{
> +	u32 tmp, tuneval;

Ditto.

Best Regards,
Jaehoon Chung

> +
> +	tuneval = (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
> +
> +	tmp = sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
> +	tmp &= ~(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY |
> +		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
> +	tmp |= FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval) |
> +		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
> +
> +	return 0;
> +}


