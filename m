Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D02E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 23:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D84891B0;
	Thu,  5 Dec 2024 00:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XzJvln3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85D1891B0; Thu,  5 Dec 2024 00:37:16 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233FA890FD
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 00:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241204233702epoutp02b68541756a32840ee5798a559b2509d4~OHZLAYBLY1915819158epoutp02R
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 23:37:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241204233702epoutp02b68541756a32840ee5798a559b2509d4~OHZLAYBLY1915819158epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733355422;
 bh=qWP09Lvx1mzKZ1z727mhRixzQNc56kz+ZUjcbkedYQk=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=XzJvln3BizMHiJIx6BG1TlEA33F2KVUPSeAHlx2HLqaEyCUMKlCS0aB+IFQdG9YYi
 4oJaM5pllH0bGuECpCzMQ8aHXSEl5CvU4+ePsCVlQcdfTnMFHuXUiUC2Tx6y99T4lu
 K/3fO/q8N7HwVx08+IFM7s2RXu8d0pIXxC4QaiMI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241204233701epcas1p2c52edfb82b868035794097f3dcb7d7e8~OHZKF78p42348023480epcas1p2C;
 Wed,  4 Dec 2024 23:37:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.236]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Y3Yp45Blbz4x9Ps; Wed,  4 Dec
 2024 23:37:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.07.23425.C97E0576; Thu,  5 Dec 2024 08:37:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241204233700epcas1p2694cc1a77161eb860b1fc4e9329d0fb3~OHZIvuyzM1604816048epcas1p2a;
 Wed,  4 Dec 2024 23:37:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241204233700epsmtrp240c032cab43451965e8e4932d22b2af1~OHZIuuuLY1284512845epsmtrp2T;
 Wed,  4 Dec 2024 23:37:00 +0000 (GMT)
X-AuditID: b6c32a39-973e970000005b81-94-6750e79c2acd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A3.2A.33707.C97E0576; Thu,  5 Dec 2024 08:37:00 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241204233659epsmtip29508d12569c0bf265178ce0521efd965~OHZIXhyTp3214132141epsmtip2D;
 Wed,  4 Dec 2024 23:36:59 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <bigunclemax@gmail.com>
Cc: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Rick
 Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Wei Fu'" <wefu@redhat.com>, "'Yixun Lan'"
 <dlan@gentoo.org>, "'Peng Fan'" <peng.fan@nxp.com>, "'Ilias Apalodimas'"
 <ilias.apalodimas@linaro.org>, "'Simon Glass'" <sjg@chromium.org>, "'Sughosh
 Ganu'" <sughosh.ganu@linaro.org>, "'Jerome Forissier'"
 <jerome.forissier@linaro.org>, "'Neil Armstrong'"
 <neil.armstrong@linaro.org>, "'Greg Malysa'" <greg.malysa@timesys.com>,
 "'Raymond Mao'" <raymond.mao@linaro.org>, "'Heinrich	Schuchardt'"
 <xypron.glpk@gmx.de>, "'Linus Walleij'" <linus.walleij@linaro.org>,
 "'Kongyang Liu'" <seashell11234455@gmail.com>, "'Jonas Karlman'"
 <jonas@kwiboo.se>, "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>, "'Wei
 Liang Lim'" <weiliang.lim@starfivetech.com>, "'Kever Yang'"
 <kever.yang@rock-chips.com>, "'Kuan Lim Lee'"
 <kuanlim.lee@starfivetech.com>, <u-boot@lists.denx.de>
In-Reply-To: <20241201150704.44462-2-bigunclemax@gmail.com>
Subject: RE: [PATCH v1 1/3] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
Date: Thu, 5 Dec 2024 08:36:59 +0900
Message-ID: <02bf01db46a5$6a017470$3e045d50$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKWNLOKvs2bV1RfzKy+BBIXkYaGALLTr1IAnqvVcu0TmdKkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHd+5t7y3Mwk0BOUGHpRImyEsLFA5K3TJMd5MtC06nGR+EBm5a
 Bn1JW9z0izXyHggMwZcCYQzYhMQp4IASSgcmIAKZ65Q5oCSbGIG2vA0U3MS1FN2+/Z9z/v/z
 e85zcjg4z0AGcbJVekarkuUKCG9W153w6Ki6p6ly4dTIu+je1o8Esk3fwNDo6iMWun/hdxKV
 5/+No58Lmkg04njIQl1XNglU2rGEoep/vsdQQes0gZZMkwBttK2xkWOuno2cc+MADf2wQqJn
 t7sAmpkIRjVVnSRymktIlG+pZqGlvloS3alZBujxoB17H9J9o0acNhrKCbrW8AuL/vW5A6dN
 RhtJL6+cphd+aiPpu5VWjJ6e6CPo8ekeQJtq+zG6fbEHo5f6HxL0S6OFRU+Nc2lz9waWSqXl
 JCsYWRaj5TOqTHVWtkouEXx0PD0lXZwgFEWJklCigK+SKRmJ4OjHqVHS7FzXQAT8M7LcPNdS
 qkynE8QcSdaq8/QMX6HW6SUCRpOVqxFronUypS5PJY9WMfpDIqEwVuwyZuQo1ppWCc3k+a9K
 lqtZBtCoKAVeHEjFQ0fHLdKteVQPgIaiQ6XA26VXARy4ns96UzyzuQtPor18DPMkTAA2F/I8
 pnkA8y9sEO4NgoqGr75txN3an9oDL7/sAG4TTtlJ6Gy4uc3zog7Dyhd/st3ajzoJh43922EW
 FQprrJZtApdKgmulTWwPmQ83n3zH9hz6AXxhXd/uCKf8YW1JIe4GQKrTC9ZPD+8EjkLjH3U7
 2g8uDN8mPToI/rVoJjyBiwC2NA+wPUUZgFuG3wiPKw5aWi652uC4EOHwZm+Mh+YDF9fL2O5l
 SHFhsfv6bncotNrnsdfn22Zf7XBpaKrdID0jsgDobFsgKsE+4/8aN/5H+AZgbWA3o9Ep5YxO
 pBG/ectMtbIDbH+FiKQecMW5HD0IMA4YBJCDC/y5nx5MlfO4WbKz5xitOl2bl8voBoHYNcqv
 8aCATLXrL6n06aL4JGF8QmxcPBIliASB3LEHZxgeJZfpmRyG0TDa1zmM4xVkwPZVhJ56+8tB
 x5x0aoYMIK3lz/fuvx9J77lVNSDMEg/t5tRJ6Zhrvp0BEZ9AnxBfS6H+WHdx+8xYabjtyRcp
 YYelLdzCeMa+Nblr4UgrfcCfDGM/KippvwcyQgICP3tw/W5wceLmesJbEadO9AzHrUSqiyRV
 4HEOhzdXFi41XSxOti8dJM3el04cv4r7Ka8VRVYp+UPe0v2Xh5zJs4kN3qixuWtifqA36UBw
 q0qahjnV3XvZKavPHE8rT49nGH3qrLsKWF6MOTAj7+xAnOKcuX52OSymOTz4vHH0mK/dlt5A
 cxPyw27wJR82Vox8flLyHm+lI82meKchNFZW0RsiYOkUMlEErtXJ/gUNDWBTkwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvO6c5wHpBsuaOSxO/dvKZnH3zlom
 i9OfbrBYXGi8yW7R2/Kb2eJ862J2i5NvrrJYbJv+k82ia9N7Jospf5YzWbSuvMNm8X7nLUaL
 H6u+sFq8eTGX1eLti7OMFsfWfWS3+LZlG6PFvWtyFlMnbWa3eLu3k92iZf8UFov3e2azWxye
 +oHR4vGh10wOEh57Ts9i9pjV0MvmMbvhIovH5e9vmD12zrrL7vHhY5zHqwOr2D1OTLjE5HHn
 2h42j7N3djB67Jy9j8lj47sdTB7v911l8/g7az+Lx+2zvB57t/9gChCI4rJJSc3JLEst0rdL
 4Mr4svgTW8Gt+orOD1NYGhgXZnQxcnJICJhIbOw9w9TFyMUhJLCdUWLj0jOMEAkpic9Pp7J1
 MXIA2cIShw8Xg4SFBJ4zSiyZwAViswnoSfxftJAZxBYRkJaY9ncTI8gcZoHf7BK/Xp9ngWjY
 zShxv8MTxOYUsJaY8OsRK4gtLBAiMennSTYQm0VARWLqpf1MIDavgKXEl67FrBA3KEj8fLqM
 FWKBk8SvS1/BZjILiEjM7mxjnsAoMAuJu4CRcRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZG
 cCRrBe1gXLb+r94hRiYOxkOMEhzMSiK8QdoB6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6
 U4QE0hNLUrNTUwtSi2CyTBycUg1M7YkP6wPflK98v1cwfFlX4bLPM/8EzNE/L5MZZmbG6LrS
 tMfxnOypfhHNt2G9JwM4Tynv0q1zu/RIVnOv/+x1p+y3LFp+g+vnw+0HGZ0D47ylD2zjzV9l
 XJ93QOKoSKFWl+ui8pP3pjk6mNzI3c75/VHP3zdn7rKKrHl07H6W2YoF0V1TnB/qLPnh/LRw
 Mnt+Ml87u+SRoz8Fljhf8HLR3FMmbPk4m+XTm3zeL7Y+nhOY/OSz/4hYdC1VC/jvMLul1iPr
 wwfu4lO/LcO9w/7/YtX1L9R/+7lDSIyjWPlnab69aK0in+69C68OiARNO9l/xceCceUtrmOq
 hacaorU+Fqzla1ulZHRbMmHXwlQlluKMREMt5qLiRAANobG6UwMAAA==
X-CMS-MailID: 20241204233700epcas1p2694cc1a77161eb860b1fc4e9329d0fb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241201150730epcas1p18a5e2e7eb226f2ef589728704ce3faee
References: <20241201150704.44462-1-bigunclemax@gmail.com>
 <CGME20241201150730epcas1p18a5e2e7eb226f2ef589728704ce3faee@epcas1p1.samsung.com>
 <20241201150704.44462-2-bigunclemax@gmail.com>
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

Hi,

> -----Original Message-----
> From: bigunclemax@gmail.com <bigunclemax@gmail.com>
> Sent: Monday, December 2, 2024 12:07 AM
>
> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> Add support for DesignWare SDHCI host controller on Alibaba TH1520 SoC
>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>
> Changes since RFC:
> - fixed HS400ES mode
> - added ADMA support
>
>  drivers/mmc/Kconfig      |  12 +
>  drivers/mmc/Makefile     |   1 +
>  drivers/mmc/snps_sdhci.c | 494 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 507 insertions(+)
>  create mode 100644 drivers/mmc/snps_sdhci.c
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 38817622fc..f4fdf15242 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -732,6 +732,18 @@ config MMC_SDHCI_S5P
>
>  	  If unsure, say N.
>
> +config MMC_SDHCI_SNPS
> +	bool "Synopsys DesignWare SDHCI controller"
> +	depends on MMC_SDHCI
> +	depends on DM_MMC
> +	help
> +	  Support for DesignWare SDHCI host controller on Alibaba TH1520 SoC.
> +	  This is a highly configurable and programmable, high performance
> +	  Mobile Storage Host Controller (MSHC) with AXI as the bus interface
> +	  for data transfer.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_STI
>  	bool "SDHCI support for STMicroelectronics SoC"
>  	depends on MMC_SDHCI && OF_CONTROL
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 868f3090ff..90e76f9076 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PIC32)		+= pic32_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
> +obj-$(CONFIG_MMC_SDHCI_SNPS)		+= snps_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= tegra_mmc.o
> diff --git a/drivers/mmc/snps_sdhci.c b/drivers/mmc/snps_sdhci.c
> new file mode 100644
> index 0000000000..d4ac2b7faf
> --- /dev/null
> +++ b/drivers/mmc/snps_sdhci.c
> @@ -0,0 +1,494 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Maksim Kiselev <bigunclemax@gmail.com>
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <linux/bitfield.h>
> +#include <sdhci.h>
> +
> +/* DWCMSHC specific Mode Select value */
> +#define DWCMSHC_CTRL_HS400		0x7
> +/* 400KHz is max freq for card ID etc. Use that as min */
> +#define EMMC_MIN_FREQ	400000
> +#define SDHCI_TUNING_LOOP_COUNT		128
> +
> +/* PHY register area pointer */
> +#define DWC_MSHC_PTR_PHY_R		0x300
> +

...[snip]...

> +#define FLAG_IO_FIXED_1V8		BIT(0)
> +
> +#define BOUNDARY_OK(addr, len) \
> +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> +
> +struct snps_sdhci_plat {
> +	struct mmc_config cfg;
> +	struct mmc mmc;
> +	u16 delay_line;
> +	u16 flags;
> +};
> +
> +/*
> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that each DMA transfer doesn't exceed the boundary.
> + */
> +void snps_sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> +				dma_addr_t addr, int len, bool end)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> +		sdhci_adma_write_desc(host, desc, addr, len, end);
> +		return;
> +	}
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	sdhci_adma_write_desc(host, desc, addr, tmplen, false);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	sdhci_adma_write_desc(host, desc, addr, len, end);
> +}
> +
> +static void sdhci_phy_1_8v_init(struct sdhci_host *host)
> +{
> +	struct snps_sdhci_plat *plat = dev_get_plat(host->mmc->dev);
> +	u32 val;
> +
> +	/* deassert phy reset & set tx drive strength */
> +	val = PHY_CNFG_RSTN_DEASSERT;
> +	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> +	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> +	sdhci_writel(host, val, PHY_CNFG_R);
> +
> +	/* disable delay line */
> +	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> +
> +	/* set delay line */
> +	sdhci_writeb(host, plat->delay_line, PHY_SDCLKDL_DC_R);
> +	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> +
> +	/* enable delay lane */
> +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> +	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +
> +	/* configure phy pads */
> +	val = PHY_PAD_RXSEL_1V8;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	val = PHY_PAD_RXSEL_1V8;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +
> +	/* enable data strobe mode */
> +	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
> +		     PHY_DLLDL_CNFG_R);
> +
> +	/* enable phy dll */
> +	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +}
> +
> +static void sdhci_phy_3_3v_init(struct sdhci_host *host)
> +{
> +	struct snps_sdhci_plat *plat = dev_get_plat(host->mmc->dev);
> +	u32 val;
> +
> +	/* deassert phy reset & set tx drive strength */
> +	val = PHY_CNFG_RSTN_DEASSERT;
> +	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> +	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> +	sdhci_writel(host, val, PHY_CNFG_R);
> +
> +	/* disable delay line */
> +	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> +
> +	/* set delay line */
> +	sdhci_writeb(host, plat->delay_line, PHY_SDCLKDL_DC_R);
> +	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> +
> +	/* enable delay lane */
> +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> +	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +
> +	/* configure phy pads */
> +	val = PHY_PAD_RXSEL_3V3;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	val = PHY_PAD_RXSEL_3V3;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +
> +	/* enable phy dll */
> +	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +}
> +
> +static void snps_sdhci_set_phy(struct sdhci_host *host)
> +{
> +	struct snps_sdhci_plat *plat = dev_get_plat(host->mmc->dev);
> +	struct mmc *mmc = host->mmc;
> +
> +	/* Before power on, set PHY configs */
> +	if ((plat->flags & FLAG_IO_FIXED_1V8) ||
> +	    mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +		sdhci_phy_1_8v_init(host);
> +	else
> +		sdhci_phy_3_3v_init(host);


Well, if my reading is right, sdhci_phy_1_8v_init and sdhci_3_3v_init are different PHY_PAD_RXSEL_1V8 and PHY_PAD_RXSEL_3V3.
Also  enable data strobe mode part.

I'm not sure why mainline kernel code doesn't re-use some code.
It can be reducing code.
Even though There are no objection because of mainline kernel codes, frankly, it's not my preference.

I have posted the kernel patch to reuse code. (I'm not sure if can be accepted.)
https://patchwork.kernel.org/project/linux-mmc/patch/20241204100507.330025-1-jh80.chung@samsung.com/


> +
> +	sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
> +		     PHY_DLL_CNFG1_WAITCYCLE, PHY_DLL_CNFG1_R);
> +}
> +
> +static int snps_sdhci_set_ios_post(struct sdhci_host *host)
> +{
> +	struct snps_sdhci_plat *plat = dev_get_plat(host->mmc->dev);
> +	struct mmc *mmc = host->mmc;
> +	u32 reg;
> +
> +	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	reg &= ~SDHCI_CTRL_UHS_MASK;
> +
> +	switch (mmc->selected_mode) {
> +	case UHS_SDR50:
> +	case MMC_HS_52:
> +		reg |= SDHCI_CTRL_UHS_SDR50;
> +		break;
> +	case UHS_DDR50:
> +	case MMC_DDR_52:
> +		reg |= SDHCI_CTRL_UHS_DDR50;
> +		break;
> +	case UHS_SDR104:
> +	case MMC_HS_200:
> +		reg |= SDHCI_CTRL_UHS_SDR104;
> +		break;
> +	case MMC_HS_400:
> +	case MMC_HS_400_ES:
> +		reg |= DWCMSHC_CTRL_HS400;
> +		break;
> +	default:
> +		reg |= SDHCI_CTRL_UHS_SDR12;
> +	}
> +
> +	if ((plat->flags & FLAG_IO_FIXED_1V8) ||
> +	    mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +		reg |= SDHCI_CTRL_VDD_180;
> +	else
> +		reg &= ~SDHCI_CTRL_VDD_180;
> +
> +	sdhci_writew(host, reg, SDHCI_HOST_CONTROL2);
> +
> +	reg = sdhci_readw(host, P_VENDOR_SPECIFIC_AREA + DWCMSHC_EMMC_CONTROL);
> +
> +	if (IS_MMC(mmc))
> +		reg |= DWCMSHC_CARD_IS_EMMC;
> +	else
> +		reg &= ~DWCMSHC_CARD_IS_EMMC;
> +
> +	if (mmc->selected_mode == MMC_HS_400_ES)
> +		reg |= DWCMSHC_ENHANCED_STROBE;
> +	else
> +		reg &= ~DWCMSHC_ENHANCED_STROBE;
> +
> +	sdhci_writeb(host, reg, P_VENDOR_SPECIFIC_AREA + DWCMSHC_EMMC_CONTROL);
> +
> +	if (mmc->selected_mode == MMC_HS_400 ||
> +	    mmc->selected_mode == MMC_HS_400_ES)
> +		plat->delay_line = PHY_SDCLKDL_DC_HS400;
> +	else
> +		sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
> +
> +	snps_sdhci_set_phy(host);
> +
> +	return 0;
> +}
> +
> +static int snps_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
> +{
> +	struct sdhci_host *host = dev_get_priv(mmc->dev);
> +	char tuning_loop_counter = SDHCI_TUNING_LOOP_COUNT;
> +	struct mmc_cmd cmd;
> +	u32 ctrl, blk_size, val;
> +	int ret;
> +
> +	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL),
> +		     PHY_ATDL_CNFG_R);
> +	val = sdhci_readl(host, P_VENDOR_SPECIFIC_AREA + DWCMSHC_EMMC_ATCTRL);
> +
> +	/*
> +	 * configure tuning settings:
> +	 *  - center phase select code driven in block gap interval
> +	 *  - disable reporting of framing errors
> +	 *  - disable software managed tuning
> +	 *  - disable user selection of sampling window edges,
> +	 *    instead tuning calculated edges are used
> +	 */
> +	val &= ~(AT_CTRL_CI_SEL | AT_CTRL_RPT_TUNE_ERR | AT_CTRL_SW_TUNE_EN |
> +		 FIELD_PREP(AT_CTRL_WIN_EDGE_SEL_MASK, AT_CTRL_WIN_EDGE_SEL));
> +
> +	/*
> +	 * configure tuning settings:
> +	 *  - enable auto-tuning
> +	 *  - enable sampling window threshold
> +	 *  - stop clocks during phase code change
> +	 *  - set max latency in cycles between tx and rx clocks
> +	 *  - set max latency in cycles to switch output phase
> +	 *  - set max sampling window threshold value
> +	 */
> +	val |= AT_CTRL_AT_EN | AT_CTRL_SWIN_TH_EN | AT_CTRL_TUNE_CLK_STOP_EN;
> +	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, AT_CTRL_PRE_CHANGE_DLY);
> +	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY);
> +	val |= FIELD_PREP(AT_CTRL_SWIN_TH_VAL_MASK, AT_CTRL_SWIN_TH_VAL);
> +
> +	sdhci_writel(host, val, P_VENDOR_SPECIFIC_AREA + DWCMSHC_EMMC_ATCTRL);
> +	val = sdhci_readl(host, P_VENDOR_SPECIFIC_AREA + DWCMSHC_EMMC_ATCTRL);
> +
> +	/* perform tuning */
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl |= SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	blk_size = SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 64);
> +	if (opcode == MMC_CMD_SEND_TUNING_BLOCK_HS200 && mmc->bus_width == 8)
> +		blk_size = SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 128);
> +	sdhci_writew(host, blk_size, SDHCI_BLOCK_SIZE);
> +	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
> +
> +	cmd.cmdidx = opcode;
> +	cmd.resp_type = MMC_RSP_R1;
> +	cmd.cmdarg = 0;
> +
> +	do {
> +		ret = mmc_send_cmd(mmc, &cmd, NULL);
> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (ret || tuning_loop_counter-- == 0)
> +			break;
> +
> +	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
> +
> +	if (ret || tuning_loop_counter < 0 || !(ctrl & SDHCI_CTRL_TUNED_CLK)) {
> +		if (!ret)
> +			ret = -EIO;
> +		printf("%s: Tuning failed: %d\n", __func__, ret);
> +
> +		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +		ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +	}
> +
> +	return ret;
> +}
> +
> +static int snps_sdhci_set_enhanced_strobe(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static const struct sdhci_ops snps_sdhci_ops = {
> +	.set_ios_post = snps_sdhci_set_ios_post,
> +	.platform_execute_tuning = snps_sdhci_execute_tuning,
> +	.set_enhanced_strobe = snps_sdhci_set_enhanced_strobe,
> +#if CONFIG_IS_ENABLED(CONFIG_MMC_SDHCI_ADMA_HELPERS)

CONFIG_IS_ENABLED(MMC_SDHCI_ADMA_HELPERS) ?

> +	.adma_write_desc = snps_sdhci_adma_write_desc,
> +#endif
> +};
> +
> +static int snps_sdhci_probe(struct udevice *dev)
> +{
> +	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
> +	struct snps_sdhci_plat *plat = dev_get_plat(dev);
> +	struct mmc_config *cfg = &plat->cfg;
> +	struct sdhci_host *host = dev_get_priv(dev);
> +	struct clk clk;
> +	int ret;
> +
> +	plat->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> +
> +	host->max_clk = cfg->f_max;
> +	ret = clk_get_by_index(dev, 0, &clk);
> +	if (!ret) {
> +		ret = clk_set_rate(&clk, host->max_clk);
> +		if (IS_ERR_VALUE(ret))
> +			printf("%s clk set rate fail!\n", __func__);

Even though clock set rate is failed, it doesn't matter to be still going?

> +	} else {
> +		printf("%s fail to get clk\n", __func__);

Ditto?

> +	}
> +
> +	host->ops = &snps_sdhci_ops;
> +
> +	host->mmc = &plat->mmc;
> +	host->mmc->priv = host;
> +	host->mmc->dev = dev;
> +	upriv->mmc = host->mmc;
> +
> +	ret = sdhci_setup_cfg(cfg, host, cfg->f_max, EMMC_MIN_FREQ);
> +	if (ret)
> +		return ret;
> +
> +	if ((dev_read_bool(dev, "mmc-ddr-1_8v")) ||
> +	    (dev_read_bool(dev, "mmc-hs200-1_8v")) ||
> +	    (dev_read_bool(dev, "mmc-hs400-1_8v")))
> +		plat->flags |= FLAG_IO_FIXED_1V8;
> +	else
> +		plat->flags &= ~FLAG_IO_FIXED_1V8;
> +
> +	return sdhci_probe(dev);
> +}
> +
> +static int snps_sdhci_of_to_plat(struct udevice *dev)
> +{
> +	struct snps_sdhci_plat *plat = dev_get_plat(dev);
> +	struct mmc_config *cfg = &plat->cfg;
> +	struct sdhci_host *host = dev_get_priv(dev);
> +	int ret;
> +
> +	host->name = dev->name;
> +	host->ioaddr = dev_read_addr_ptr(dev);
> +
> +	ret = mmc_of_parse(dev, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Is it possible to use "return mmc_of_parse();"?

Best Regards,
Jaehoon Chung

> +}
> +
> +static int snps_sdhci_bind(struct udevice *dev)
> +{
> +	struct snps_sdhci_plat *plat = dev_get_plat(dev);
> +
> +	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
> +}
> +
> +static const struct udevice_id snps_sdhci_ids[] = {
> +	{ .compatible = "thead,th1520-dwcmshc" }
> +};
> +
> +U_BOOT_DRIVER(snps_sdhci_drv) = {
> +	.name		= "snps_sdhci",
> +	.id		= UCLASS_MMC,
> +	.of_match	= snps_sdhci_ids,
> +	.of_to_plat	= snps_sdhci_of_to_plat,
> +	.ops		= &sdhci_ops,
> +	.bind		= snps_sdhci_bind,
> +	.probe		= snps_sdhci_probe,
> +	.priv_auto = sizeof(struct sdhci_host),
> +	.plat_auto = sizeof(struct snps_sdhci_plat),
> +};
> --
> 2.45.2



