Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415DECDD0FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 23:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43388905E;
	Wed, 23 Oct 2024 01:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="MD3zw595";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF5288FF6; Wed, 23 Oct 2024 01:04:49 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C48489251
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 01:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241022230432epoutp028575e737dcd99afbe05516eb6a168062~A6NhZ6O6X0356903569epoutp02w
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 23:04:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241022230432epoutp028575e737dcd99afbe05516eb6a168062~A6NhZ6O6X0356903569epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1729638272;
 bh=IiayqDU4D00Wv+L5Z0+AkhIPHjP9l0/FZSbXeSezphM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=MD3zw595121/0x3EhlBb+LG3KPF2xbD9In1JLlfu+8xVXEBMDezrbQwSQeqDbVpjE
 kuCIatQaFp1T8a8uSWlh9fkHjqZvLS2xoJYnwws5q44ob/aiPfSNNsUo8Jf5GN1E1K
 qx7UJHT9RaH4Pdf8osAoc7OJqKhBwqVFmj493Qsw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241022230432epcas1p1eba863d6961eb36b5d2a988596d23f7e~A6NhBKmVf0234302343epcas1p1v;
 Tue, 22 Oct 2024 23:04:32 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.235]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4XY76Q6BZQz4x9Pq; Tue, 22 Oct
 2024 23:04:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 4D.79.09406.E7F28176; Wed, 23 Oct 2024 08:04:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241022230430epcas1p2e14a0066a55853c97b5ea80ef4870ecd~A6Ne6_Ynn2257922579epcas1p2U;
 Tue, 22 Oct 2024 23:04:30 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241022230430epsmtrp1c98a57efb1f9954e97bf13ec5a3222c5~A6Ne5_kuc0808108081epsmtrp1X;
 Tue, 22 Oct 2024 23:04:30 +0000 (GMT)
X-AuditID: b6c32a35-aa3fa700000024be-b4-67182f7e70e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8A.16.07371.D7F28176; Wed, 23 Oct 2024 08:04:29 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241022230429epsmtip134c35efce63d5799dbf522fb282a835a~A6Neiym6m0180701807epsmtip1X;
 Tue, 22 Oct 2024 23:04:29 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <vasileios.bimpikas@analog.com>, "'Tom Rini'" <trini@konsulko.com>,
 "'Nathan Barrett-Morrison'" <nathan.morrison@timesys.com>, "'Greg Malysa'"
 <greg.malysa@timesys.com>, "'Ian	Roberts'" <ian.roberts@timesys.com>,
 "'Utsav Agarwal'" <utsav.agarwal@analog.com>, "'Arturs Artamonovs'"
 <arturs.artamonovs@analog.com>, "'Marek Vasut'" <marex@denx.de>, "'Heiko
 Schocher'" <hs@denx.de>, "'Joe Hershberger'" <joe.hershberger@ni.com>,
 "'Ramon Fried'" <rfried.dev@gmail.com>, "'Stefan Roese'" <sr@denx.de>,
 "'Jagan Teki'" <jagan@amarulasolutions.com>, "'Peng Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>, <adsp-linux@analog.com>, "'Oliver Gaskell'"
 <Oliver.Gaskell@analog.com>
In-Reply-To: <20241021-sc5xx-driver-series-v2-11-53e2472e11d0@analog.com>
Subject: RE: [PATCH v2 11/11] mmc: Add support for ADI SC5XX-family
 processor SDHCI peripherals
Date: Wed, 23 Oct 2024 08:04:29 +0900
Message-ID: <0a5001db24d6$bfdc2ac0$3f948040$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQKpFU005zUhxPm8td7XDMgb3SQ58AIcHCxQAksWjpiw1EW+0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjm3H7iVnYtHx7ZEsuNJgIDWkrZxYnZBiOX4ZYm/iCaMHYHh0Ja
 2qa36NiPpmSsIkP5EIzDYUYFFzuRwBAroVHQWDfRZJatMpASqGLpQEBcSoa6tle3/Xve9zzP
 +z7ve84RcsSD/HhhhdaIDFpaQ/A3cQevJaakmNKgStp2MpmsHRngkD2uixh5a/Uel7RPeTik
 zzONkWv9TXxy9fIcj/zTUgNIV6cLkOcaZvlkwLbGI689uS0gf76wjJFtLT8JyEXHEQHp+7of
 I0+7JO9tpnpWPDxq4bf3qdPtN7nU5fb7Amrhqk1A3Z6yA8o9dgmj+pbsGOW4FMCUkQfUu8sR
 XYoMEqQt0ZVWaFXZRMG+4pxiRaZUliLLIt8hJFq6EmUTuXuVKXkVmuAshOQgrakKppQ0wxBp
 e3YbdFVGJCnXMcZsAulLNXqFPpWhK5kqrSpVi4y7ZFJpuiJI/ExdfsI6B/QbeV+YAy0cM3Du
 qgeRQohnwN5mPy+ExbgdwMYb++vBpiBeBdDXfYXDHvwFoP+evB4Iw4KhaRPLcQDYMrrBYwMf
 gK1OBzck4OOp8IW1MyyOwe9w4XcdBSExB0fQ6o0LpSPxfNj0e5MghKNxGlqPOsMmuPgO+Ld/
 kB/CIjwLrtcdF7BGJXD9wdkwh4PHwFNHLC/LfwDb2pz8kAeIjwvhSmcXYI3mwnM9NKuNhgvO
 gZd14qGv0SJg+V8B2N01wmODBgCfm918liWHV7qPY6zpRNg7lMY2joJLTxt4bH0RrLOIWfZ2
 eNfvw17Vv+99wWMxBUd6bVx2h38AOOGQN4Ft7f8bof2/Bt8DzAbikJ6pVCFGppf9e40lusp+
 EH7ASQo7aF5cTh0FmBCMAijkEDEiwhirEotK6eovkUFXbKjSIGYUKIKLbObEx5bogj9AayyW
 ZWRJMzLT5RmkLFNGbBGNjR9EYlxFG5EaIT0yvNJhwsh4M/bu4PVp+xPhTvB4qhHizqhb9OFv
 d6LXHJ5J1LpOyQMB5dsJQ3d+LJpHZQOPPAVJazv211S9uRV/Zto62a0/M/wxtqf+lM4hXV4a
 9kr3rm8532e4EaV8GDHsOZZg77EwiUVdYHvfxNBTk9ucE/WDLHAym/v8otd73ZWyL7XG76jT
 mw55sZmyM2/NvRE7w1OvJJGxkkfntx2d7ytMNzuvVn/jqRtJXjqQ/9G835fZ0UklF00c+3zg
 0IXYiMIOT8Ldsmb3hzPunM2fVhtu8leePYwYm02LG/9kw1WbnT/5GDvs+WWj1Tbfn7v4+qQu
 UhH9IFddG29t/TXDwRTO5o6dzSO4TDktS+IYGPofDrKEuUkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTrdWXyLd4OBvK4uWg1uYLdZe3spk
 cfrTDRaLHXfuM1u8vH+PyeLLpglsFp92Pma1eNPWyGhxeeFlRouVPY/YLH6s+sJqcfjzWXaL
 k+s+MFlMnbSZ3eLt3k52i5etm5gs5l1WcBD0WPvxPqvHq6uOHvNmnWDx2DnrLrvHqwOr2D3O
 3tnB6HH9zHYmj43vdjB57N3+gymAM4rLJiU1J7MstUjfLoErY9qix4wFf9wqGn5MYm5gPG7V
 xcjBISFgIrHrXl0XIxeHkMBuRom7pzexdjFyAsWlJD4/ncoGUSMscfhwMUTNc0aJ7udbmUFq
 2AT0JP4vWsgMkhARuMUi0XZlMhNIglkgXeLF7X+sEB3XGCXerF0DNpVTwFNiwrUJ7CC2sEC8
 xPkZyxlBbBYBVYnfr7exgdi8ApYSPzsms0NcoSDx8+kyVoihIhKzO9vANosIOElMnXqcbQKj
 wCwkqQWMjKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYIjSUtjB+O9+f/0DjEycTAe
 YpTgYFYS4VUqEU0X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJ
 g1Oqgencwjcbva9scokQ1DbUXX/vztQXSkfjU77pTPB7l7pYavpF2VsLt/kYnPXNN192fLIW
 1wGFI4IBK3sOqfGyzPi9beO0GTUBal9efLZ/9mnJvDW/dM6faX6XaXBfutVq+2Zz5rT1192X
 +QnJOAYy1SXKfxQ4xuoteMHFbQLP/dmsU3qcJzzsnH7hvyyTo8m77rB1gtcnN61Paf718lyt
 QHi9v5refNWd0R6+J6aIuC9umXnq2WVdvsDNLjdLOY+0ndlq3Z84R+/fv39aa/4qXdHaKJBX
 xlHwsrugKujqmf7L96xttiVtvvg8d37VQ01WjrN/38jfNH4sd7Plv6bypKPz33lPWtcTLJVb
 e3amg/REJZbijERDLeai4kQASR92rRMDAAA=
X-CMS-MailID: 20241022230430epcas1p2e14a0066a55853c97b5ea80ef4870ecd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241021135602epcas1p2adb2cea636bd5cb23e9b762bd43195ca
References: <20241021-sc5xx-driver-series-v2-0-53e2472e11d0@analog.com>
 <CGME20241021135602epcas1p2adb2cea636bd5cb23e9b762bd43195ca@epcas1p2.samsung.com>
 <20241021-sc5xx-driver-series-v2-11-53e2472e11d0@analog.com>
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
> From: Vasileios Bimpikas via B4 Relay <devnull+vasileios.bimpikas.analog.com@kernel.org>
> Sent: Monday, October 21, 2024 10:55 PM
> To: Tom Rini <trini@konsulko.com>; Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>; Vasileios Bimpikas
> <vasileios.bimpikas@analog.com>; Utsav Agarwal <utsav.agarwal@analog.com>; Arturs Artamonovs
> <arturs.artamonovs@analog.com>; Marek Vasut <marex@denx.de>; Heiko Schocher <hs@denx.de>; Joe
> Hershberger <joe.hershberger@ni.com>; Ramon Fried <rfried.dev@gmail.com>; Stefan Roese <sr@denx.de>;
> Jagan Teki <jagan@amarulasolutions.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>
> Cc: u-boot@lists.denx.de; adsp-linux@analog.com; Oliver Gaskell <Oliver.Gaskell@analog.com>
> Subject: [PATCH v2 11/11] mmc: Add support for ADI SC5XX-family processor SDHCI peripherals
>
> From: Oliver Gaskell <Oliver.Gaskell@analog.com>
>
> Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
> ---
>  MAINTAINERS             |   1 +
>  drivers/mmc/Kconfig     |   9 +++
>  drivers/mmc/Makefile    |   1 +
>  drivers/mmc/adi_sdhci.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 165 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a553584fb7390adff2af78fe5d9461e99d0084e7..c59e061671e1bca03236211515bc4016306fdf68 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -616,6 +616,7 @@ F:	drivers/dma/adi_dma.c
>  F:	drivers/gpio/adp5588_gpio.c
>  F:	drivers/gpio/gpio-adi-adsp.c
>  F:	drivers/i2c/adi_i2c.c
> +F:	drivers/mmc/adi_sdhci.c
>  F:	drivers/net/dwc_eth_qos_adi.c
>  F:	drivers/pinctrl/pinctrl-adi-adsp.c
>  F:	drivers/remoteproc/adi_sc5xx_rproc.c
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 38817622fca1784703024c357b5d5ca11703afd6..b922765799bdbda991abb306e61969b4d9646e05 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -293,6 +293,15 @@ config MMC_DW_ROCKCHIP
>  	  SD 3.0, SDIO 3.0 and MMC 4.5 and supports common eMMC chips as well
>  	  as removeable SD and micro-SD cards.
>
> +config MMC_SDHCI_ADI
> +	bool "ADI SD/MMC controller support"
> +	depends on ARCH_SC5XX
> +	depends on DM_MMC && OF_CONTROL
> +	depends on MMC_SDHCI && MMC_SDHCI_ADMA
> +	help
> +	  This enables support for the SD/MMC controller included in some Analog
> +	  Devices SC5XX Socs.
> +
>  config MMC_DW_SOCFPGA
>  	bool "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
>  	depends on ARCH_SOCFPGA
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 868f3090ff24cc50cf9d71ac8f1f779efeb1471f..d4b747784b061996e218a2df6906d8c731732b9f 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_MMC_SDHCI_MV)		+= mv_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PIC32)		+= pic32_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
> +obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
> diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..311089a5f5230d827bbf8b5439064c94ada2b209
> --- /dev/null
> +++ b/drivers/mmc/adi_sdhci.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * (C) Copyright 2022 - Analog Devices, Inc.
> + *
> + * Written and/or maintained by Timesys Corporation
> + *
> + * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> + * Contact: Greg Malysa <greg.malysa@timesys.com>
> + *
> + * Based on Rockchip's sdhci.c file
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <malloc.h>
> +#include <sdhci.h>
> +#include <asm/cache.h>
> +
> +/* 400KHz is max freq for card ID etc. Use that as min */
> +#define EMMC_MIN_FREQ	400000
> +
> +/* Check if an operation crossed a boundary of size ADMA_BOUNDARY_ALIGN */
> +#define ADMA_BOUNDARY_ALGN SZ_128M
> +#define BOUNDARY_OK(addr, len) \
> +	(((addr) | (ADMA_BOUNDARY_ALGN - 1)) == (((addr) + (len) - 1) | \
> +	(ADMA_BOUNDARY_ALGN - 1)))
> +
> +/* We split a descriptor for every crossing of the ADMA alignment boundary,
> + * so we need an additional descriptor for every expected crossing.
> + * As I understand it, the max expected transaction size is:
> + *  CONFIG_SYS_MMC_MAX_BLK_COUNT * MMC_MAX_BLOCK_LEN
> + *
> + * With the way the SDHCI-ADMA driver is implemented, if ADMA_MAX_LEN was a
> + * clean power of two, we'd only ever need +1 descriptor as the first
> + * descriptor that got split would then bring the remaining DMA
> + * destination addresses into alignment. Unfortunately, it's currently
> + * hardcoded to a non-power-of-two value.
> + *
> + * If that ever becomes parameterized, ADMA max length can be set to
> + * 0x10000, and set this to 1.
> + */
> +#define ADMA_POTENTIAL_CROSSINGS \
> +	DIV_ROUND_UP((CONFIG_SYS_MMC_MAX_BLK_COUNT * MMC_MAX_BLOCK_LEN), \
> +		 ADMA_BOUNDARY_ALGN)
> +/* +1 descriptor for each crossing.
> + */

Could you change the above comment? I can't know where is relevant to this comment.

> +#define ADMA_TABLE_EXTRA_SZ (ADMA_POTENTIAL_CROSSINGS * ADMA_DESC_LEN)
> +
> +struct adi_sdhc_plat {
> +	struct mmc_config cfg;
> +	struct mmc mmc;
> +};
> +
> +struct adi_sdhc {
> +	struct sdhci_host host;
> +	void *base;
> +};
> +
> +void adi_dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> +				 dma_addr_t addr, int len, bool end)

Can it be static?

> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> +		sdhci_adma_write_desc(host, desc, addr, len, end);
> +		return;
> +	}
> +
> +	offset = addr & (ADMA_BOUNDARY_ALGN - 1);
> +	tmplen = ADMA_BOUNDARY_ALGN - offset;
> +	sdhci_adma_write_desc(host, desc, addr, tmplen, false);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	sdhci_adma_write_desc(host, desc, addr, len, end);
> +}
> +
> +struct sdhci_ops adi_dwcmshc_sdhci_ops = {
> +	.adma_write_desc = adi_dwcmshc_adma_write_desc,
> +};
> +
> +static int adi_dwcmshc_sdhci_probe(struct udevice *dev)
> +{
> +	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
> +	struct adi_sdhc_plat *plat = dev_get_plat(dev);
> +	struct adi_sdhc *prv = dev_get_priv(dev);
> +	struct sdhci_host *host = &prv->host;
> +	int max_frequency, ret;
> +	struct clk clk;
> +
> +	max_frequency = dev_read_u32_default(dev, "max-frequency", 0);
> +	ret = clk_get_by_index(dev, 0, &clk);
> +
> +	host->quirks = 0;
> +	host->max_clk = max_frequency;
> +	/*
> +	 * The sdhci-driver only supports 4bit and 8bit, as sdhci_setup_cfg
> +	 * doesn't allow us to clear MMC_MODE_4BIT.  Consequently, we don't
> +	 * check for other bus-width values.
> +	 */
> +	if (host->bus_width == 8)
> +		host->host_caps |= MMC_MODE_8BIT;
> +
> +	host->mmc = &plat->mmc;
> +	host->mmc->priv = &prv->host;
> +	host->mmc->dev = dev;
> +	upriv->mmc = host->mmc;
> +
> +	host->ops = &adi_dwcmshc_sdhci_ops;
> +	host->adma_desc_table = memalign(ARCH_DMA_MINALIGN,
> +					 ADMA_TABLE_SZ + ADMA_TABLE_EXTRA_SZ);
> +	host->adma_addr = virt_to_phys(host->adma_desc_table);
> +
> +	ret = sdhci_setup_cfg(&plat->cfg, host, 0, EMMC_MIN_FREQ);
> +	if (ret)
> +		return ret;
> +
> +	return sdhci_probe(dev);
> +}
> +
> +static int adi_dwcmshc_sdhci_of_to_plat(struct udevice *dev)
> +{
> +	struct sdhci_host *host = dev_get_priv(dev);
> +
> +	host->name = dev->name;
> +	host->ioaddr = dev_read_addr_ptr(dev);
> +	host->bus_width = dev_read_u32_default(dev, "bus-width", 4);
> +
> +	return 0;
> +}
> +
> +static int adi_sdhci_bind(struct udevice *dev)
> +{
> +	struct adi_sdhc_plat *plat = dev_get_plat(dev);
> +
> +	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
> +}
> +
> +static const struct udevice_id adi_dwcmshc_sdhci_ids[] = {
> +	{ .compatible = "adi,dwc-sdhci" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(adi_dwcmshc_sdhci_drv) = {
> +	.name		= "adi_sdhci",
> +	.id		= UCLASS_MMC,
> +	.of_match	= adi_dwcmshc_sdhci_ids,
> +	.of_to_plat	= adi_dwcmshc_sdhci_of_to_plat,
> +	.ops		= &sdhci_ops,
> +	.bind		= adi_sdhci_bind,
> +	.probe		= adi_dwcmshc_sdhci_probe,
> +	.priv_auto	= sizeof(struct adi_sdhc),
> +	.plat_auto	= sizeof(struct adi_sdhc_plat),
> +};
>
> --
> 2.34.1
>



