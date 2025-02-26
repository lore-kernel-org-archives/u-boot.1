Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF90DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FE281277;
	Wed, 26 Feb 2025 18:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjHzIUKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5640880F88; Wed, 26 Feb 2025 18:33:13 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F3F810F6
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e5db2d767f2so5544945276.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591189; x=1741195989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxMY+BsJnIRchAALN3amoblILPhupV5FYwEvFhz4rGc=;
 b=mjHzIUKKUkME9oMP5uXXAZdrzOCRZ4F7fqMF90Mr04mhaDm8WWxdWCrqetH09OaDYF
 5RH0UmZE48TjYO88bfxuA965hRfyyyE05F6oaG6vPnGUdHtGHNHjBsI8qgDW+2LrIBBI
 gvEkwndLmtBaByVfdjhGqFlDXeInmNrEY75Gx+KhtlBLVbOZ15vzPLthf6UiqYRcdXRH
 OuDSnbJpJsYN0TCZ2wh3DxPlDHlm0o/xStLCfQmgRqt5QuPKiYIpf9/jFGP8NgrXVHAF
 IulbojZ2aZcnBNuYePZP96D+wKrbfJjpGAWfxSBUFn72388FuXX2InrrWBD14gBJ5zzH
 usPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591189; x=1741195989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxMY+BsJnIRchAALN3amoblILPhupV5FYwEvFhz4rGc=;
 b=gT8n7dfqivJ9iHX0SmtNDOEmZ0KJPWMS+MoI9UjLqbRQd0O5R6DnXfBmEn3ZodEa6T
 dkpwljJn6ZIutXL//mX3tg2HzdWkKQK+vB12iSSghdC31SbyMf1j6Snxt2YfZQ8l6OZB
 JUNKdajpTt+DQkQKq2otqmGj4psXR208Fr28dZT1fvrh0cvOY7oB8dcREGggw7jyAZKg
 OqoQ/LC25QQYfnImGbaOx1tYphQC79zKYhTQ2qqWLZRtxmQZOLnSZz7Ia0Lp50jwvnag
 JsYl3BGs/AuLXWJM7WNUvqLFkE+GDskyO63grtTrVx4Mykm+Qmgs0mHS2ymcuw5tpJOy
 y6Ug==
X-Gm-Message-State: AOJu0YzCUjXkPlG9IFy9OB/mLqeqe7i3pJN/BGbNmsCuQHAf47Y3kMah
 6O/P8+Pvy6W19AKykzKxRiXmEg6/DP8R9k4BPEJmScSuZnVxQgXbWdDmheI=
X-Gm-Gg: ASbGnctBR/RyZ/byhdITli4YOy0c5yjYuIOGYHjeokGMx8CI3o2F1FShL15xjclfV0A
 6iMNHFc+CDCRT4FFvV4le+qM1LqVOcX8Ahqymy0SJ8CfzFedKWe/f9OmbvFzQI5UUhjkRGjJHm0
 nToWQo6aL5Hgte4k7KQe1KO7JV+3gujLokyoyr/Mw+9Pey3IJmHXEhTI4IRavwBBP9bBN47GRGP
 u+SqTSV/Rsh9+rFcIYTVS3CUW1S9Omt0zQ6INh+TAYAU0oTRreScwSiymBOB+jkzxyYJwoRzq0x
 g0PqmfptLlzv98Jj+f+pqgFdbtTmAbGbQ0Ah/6gysw==
X-Google-Smtp-Source: AGHT+IEeklvuVCkmIzJDstK7+yZdREcMByKDaoBMsgOREhOq9BHHFi79tIfCxVlCRrYyOGBRmCfu2A==
X-Received: by 2002:a05:6902:1882:b0:e5b:42c7:8f28 with SMTP id
 3f1490d57ef6-e608a80dc3dmr4022941276.35.1740591189436; 
 Wed, 26 Feb 2025 09:33:09 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:33:08 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/12] mmc: Add support for ADI SC5XX-family processor
 SDHCI peripherals
Date: Wed, 26 Feb 2025 12:30:34 -0500
Message-ID: <20250226173150.13198-13-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

Co-developed-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

---

Changes in v3:
- Removed struct adi_sdhc and replaced with the struct that was its only
  member

 MAINTAINERS             |   1 +
 drivers/mmc/Kconfig     |   9 +++
 drivers/mmc/Makefile    |   1 +
 drivers/mmc/adi_sdhci.c | 148 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 drivers/mmc/adi_sdhci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 889695c1edd..31adefd9f9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,6 +636,7 @@ F:	drivers/dma/adi_dma.c
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
+F:	drivers/mmc/adi_sdhci.c
 F:	drivers/net/dwc_eth_qos_adi.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/remoteproc/adi_sc5xx_rproc.c
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4827834b4aa..ab56bd3939f 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -292,6 +292,15 @@ config MMC_DW_ROCKCHIP
 	  SD 3.0, SDIO 3.0 and MMC 4.5 and supports common eMMC chips as well
 	  as removeable SD and micro-SD cards.
 
+config MMC_SDHCI_ADI
+	bool "ADI SD/MMC controller support"
+	depends on ARCH_SC5XX
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
index 90e76f90769..94ed28ead71 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MMC_SDHCI_MV)		+= mv_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PIC32)		+= pic32_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_SNPS)		+= snps_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c
new file mode 100644
index 00000000000..65a22cefb71
--- /dev/null
+++ b/drivers/mmc/adi_sdhci.c
@@ -0,0 +1,148 @@
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
+/* Check if an operation crossed a boundary of size ADMA_BOUNDARY_ALIGN */
+#define ADMA_BOUNDARY_ALGN SZ_128M
+#define BOUNDARY_OK(addr, len) \
+	(((addr) | (ADMA_BOUNDARY_ALGN - 1)) == (((addr) + (len) - 1) | \
+	(ADMA_BOUNDARY_ALGN - 1)))
+
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
+void adi_dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
+				 dma_addr_t addr, int len, bool end)
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
+	struct sdhci_host *host = dev_get_priv(dev);
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
+	host->mmc->priv = host;
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
+	.priv_auto	= sizeof(struct sdhci_host),
+	.plat_auto	= sizeof(struct adi_sdhc_plat),
+};
-- 
2.45.2

