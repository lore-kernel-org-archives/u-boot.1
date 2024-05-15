Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2563C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE6D88361;
	Wed, 15 May 2024 23:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="TxtfehUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE6988377; Wed, 15 May 2024 23:59:39 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69D588356
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-61bb219737dso84159397b3.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810375; x=1716415175;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6S6Hvdjpi5P/3LRtNeZ0sFdseWgpWW13t+cPLmDABOI=;
 b=TxtfehUyaDZIo40TawiUWZ7Qt7nz4kcduQtmFDinuROd70OZs07C3jDiWwCKrXflVn
 7nWR5+qE488fgXaLijTr21QDj5qLgzXNdNgOBq1STKKE2xzm7k214drtcCpPrzStZD1I
 VDBQ5ekkj/lKpMZIngma8oBLJlSDwcsWPP5KWgkn7AZKyNkjmH++PidfMNN+zV+OqMbO
 i5gbLGnFNfg5znnS3/hQ4L0jmC7ac0HWJA4d6yjyz1aCgdV2II1UP1CtRMoQdLvAWpTW
 Fphybh7p+v6bpeWNdi56oWd05voWVNJVK7u0+FMIBBbQuaRtfagWFER9tmRost3lcKxS
 tUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810375; x=1716415175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S6Hvdjpi5P/3LRtNeZ0sFdseWgpWW13t+cPLmDABOI=;
 b=tddIIJOr042wF61eALZVdPyBO5Mzrp3059/hNPnukr2K6dGYrmTOAtwwJ0RG01FnX8
 6VclXJzRwkfhL1iePzWznU/URTWR88xEswzQvApV6dhfjtLQgpyGRsD5rSOdksAi41RU
 wZP3jKbE1jY7L2eNhVFNjwnIIabd7lcva/n99cGt50DxbHY7fqticrS3ch/DGagMSo6X
 a8kS4ajmEl2JSO/LKxBKCu7eJOiAxhIO8h5z4O+byMeaQ3l0Xu5bQEIPGfTbJ5gGV/Sf
 6l3y+V9zLHT3SeyDudZoIGyz9scNXLn6bV0mbShHPbe5gkrCdG4yi4CXCxyPvXZBq1gy
 6thA==
X-Gm-Message-State: AOJu0YztDKcza8buFkKuRxchoXLnyEDRdpNj+2yKMtqOR0eIQM3XpdSw
 t24TtzXlIb0n5UjpNdwURAnE3054GgUeIQAmbuGvzCqLOZHgtIgHNtPm1CZg1MjTDnwyij6yP+p
 EAg==
X-Google-Smtp-Source: AGHT+IEOQwXY+2sUKF6HgrNkvpc+VzZgKWtvPurxlIDhUo8I15O4Qm85O4mnOm8ady83fIoUbGpQ8A==
X-Received: by 2002:a05:690c:fc7:b0:615:3e2c:d318 with SMTP id
 00721157ae682-622affda599mr206334267b3.41.1715810375575; 
 Wed, 15 May 2024 14:59:35 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:34 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] mmc: Add support for ADI SC5XX-family processor SDHCI
 peripherals
Date: Wed, 15 May 2024 17:57:48 -0400
Message-ID: <20240515215837.14028-12-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

 MAINTAINERS             |   1 +
 drivers/mmc/Kconfig     |   8 +++
 drivers/mmc/Makefile    |   1 +
 drivers/mmc/adi_sdhci.c | 152 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/mmc/adi_sdhci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1131c85d22..b4c00c4d5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -614,6 +614,7 @@ F:	drivers/dma/adi_dma.c
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
+F:	drivers/mmc/adi_sdhci.c
 F:	drivers/net/dwc_eth_qos_adi.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/remoteproc/adi_sc5xx_rproc.c
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index d0944793c9..f32c8a3c13 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -283,6 +283,14 @@ config MMC_DW_ROCKCHIP
 	  SD 3.0, SDIO 3.0 and MMC 4.5 and supports common eMMC chips as well
 	  as removeable SD and micro-SD cards.
 
+config MMC_SDHCI_ADI
+	bool "ADI SD/MMC controller support"
+	depends on DM_MMC && OF_CONTROL
+	depends on MMC_SDHCI && MMC_SDHCI_ADMA
+	help
+	  This enables support for the SD/MMC controller included in some Analog
+	  Devices SC5XX Socs.
+
 config MMC_DW_SOCFPGA
 	bool "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
 	depends on ARCH_SOCFPGA
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 72c3fb66ce..eac8c28ee5 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_MMC_SDHCI_MV)		+= mv_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PIC32)		+= pic32_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c
new file mode 100644
index 0000000000..a8484e0e7a
--- /dev/null
+++ b/drivers/mmc/adi_sdhci.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Based on Rockchip's sdhci.c file
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <malloc.h>
+#include <sdhci.h>
+#include <asm/cache.h>
+
+/* 400KHz is max freq for card ID etc. Use that as min */
+#define EMMC_MIN_FREQ	400000
+
+#define ADMA_BOUNDARY_ALGN SZ_128M
+#define BOUNDARY_OK(addr, len) \
+	(((addr) | (ADMA_BOUNDARY_ALGN - 1)) == (((addr) + (len) - 1) | \
+	(ADMA_BOUNDARY_ALGN - 1)))
+/* We split a descriptor for every crossing of the ADMA alignment boundary,
+ * so we need an additional descriptor for every expected crossing.
+ * As I understand it, the max expected transaction size is:
+ *  CONFIG_SYS_MMC_MAX_BLK_COUNT * MMC_MAX_BLOCK_LEN
+ *
+ * With the way the SDHCI-ADMA driver is implemented, if ADMA_MAX_LEN was a
+ * clean power of two, we'd only ever need +1 descriptor as the first
+ * descriptor that got split would then bring the remaining DMA
+ * destination addresses into alignment. Unfortunately, it's currently
+ * hardcoded to a non-power-of-two value.
+ *
+ * If that ever becomes parameterized, ADMA max length can be set to
+ * 0x10000, and set this to 1.
+ */
+#define ADMA_POTENTIAL_CROSSINGS \
+	DIV_ROUND_UP((CONFIG_SYS_MMC_MAX_BLK_COUNT * MMC_MAX_BLOCK_LEN), \
+		 ADMA_BOUNDARY_ALGN)
+/* +1 descriptor for each crossing.
+ */
+#define ADMA_TABLE_EXTRA_SZ (ADMA_POTENTIAL_CROSSINGS * ADMA_DESC_LEN)
+
+struct adi_sdhc_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+};
+
+struct adi_sdhc {
+	struct sdhci_host host;
+	void *base;
+};
+
+void adi_dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
+			     dma_addr_t addr, int len, bool end)
+{
+	int tmplen, offset;
+
+	if (likely(!len || BOUNDARY_OK(addr, len))) {
+		sdhci_adma_write_desc(host, desc, addr, len, end);
+		return;
+	}
+
+	offset = addr & (ADMA_BOUNDARY_ALGN - 1);
+	tmplen = ADMA_BOUNDARY_ALGN - offset;
+	sdhci_adma_write_desc(host, desc, addr, tmplen, false);
+
+	addr += tmplen;
+	len -= tmplen;
+	sdhci_adma_write_desc(host, desc, addr, len, end);
+}
+
+struct sdhci_ops adi_dwcmshc_sdhci_ops = {
+	.adma_write_desc = adi_dwcmshc_adma_write_desc,
+};
+
+static int adi_dwcmshc_sdhci_probe(struct udevice *dev)
+{
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct adi_sdhc_plat *plat = dev_get_plat(dev);
+	struct adi_sdhc *prv = dev_get_priv(dev);
+	struct sdhci_host *host = &prv->host;
+	int max_frequency, ret;
+	struct clk clk;
+
+	max_frequency = dev_read_u32_default(dev, "max-frequency", 0);
+	ret = clk_get_by_index(dev, 0, &clk);
+
+	host->quirks = 0;
+	host->max_clk = max_frequency;
+	/*
+	 * The sdhci-driver only supports 4bit and 8bit, as sdhci_setup_cfg
+	 * doesn't allow us to clear MMC_MODE_4BIT.  Consequently, we don't
+	 * check for other bus-width values.
+	 */
+	if (host->bus_width == 8)
+		host->host_caps |= MMC_MODE_8BIT;
+
+	host->mmc = &plat->mmc;
+	host->mmc->priv = &prv->host;
+	host->mmc->dev = dev;
+	upriv->mmc = host->mmc;
+
+	host->ops = &adi_dwcmshc_sdhci_ops;
+	host->adma_desc_table = memalign(ARCH_DMA_MINALIGN,
+					 ADMA_TABLE_SZ + ADMA_TABLE_EXTRA_SZ);
+	host->adma_addr = virt_to_phys(host->adma_desc_table);
+
+	ret = sdhci_setup_cfg(&plat->cfg, host, 0, EMMC_MIN_FREQ);
+	if (ret)
+		return ret;
+
+	return sdhci_probe(dev);
+}
+
+static int adi_dwcmshc_sdhci_of_to_plat(struct udevice *dev)
+{
+	struct sdhci_host *host = dev_get_priv(dev);
+
+	host->name = dev->name;
+	host->ioaddr = dev_read_addr_ptr(dev);
+	host->bus_width = dev_read_u32_default(dev, "bus-width", 4);
+
+	return 0;
+}
+
+static int adi_sdhci_bind(struct udevice *dev)
+{
+	struct adi_sdhc_plat *plat = dev_get_plat(dev);
+
+	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
+}
+
+static const struct udevice_id adi_dwcmshc_sdhci_ids[] = {
+	{ .compatible = "adi,dwc-sdhci" },
+	{ }
+};
+
+U_BOOT_DRIVER(adi_dwcmshc_sdhci_drv) = {
+	.name		= "adi_sdhci",
+	.id		= UCLASS_MMC,
+	.of_match	= adi_dwcmshc_sdhci_ids,
+	.of_to_plat	= adi_dwcmshc_sdhci_of_to_plat,
+	.ops		= &sdhci_ops,
+	.bind		= adi_sdhci_bind,
+	.probe		= adi_dwcmshc_sdhci_probe,
+	.priv_auto	= sizeof(struct adi_sdhc),
+	.plat_auto	= sizeof(struct adi_sdhc_plat),
+};
-- 
2.43.2

