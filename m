Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F80D1714B
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC2788F5E;
	Tue, 22 Oct 2024 01:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sZDkFdJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74BCD88F99; Mon, 21 Oct 2024 15:56:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8591488F3F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 15:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+vasileios.bimpikas.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6062A5C5717;
 Mon, 21 Oct 2024 13:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16EBEC4CEEC;
 Mon, 21 Oct 2024 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729518958;
 bh=dsZlxSqpTdPI5kREpkyKe85EjVNxTE1IL2IBlNeI7ZE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=sZDkFdJpIfep0P/WueHN6jgUFolXC9E5NnUPmf697r6UYgVeohfeKf+MRVFD6JRqz
 1l9EsZjuczB0mIMsz/AqvvdI6wOTpItAoPRobkNmOxEKyEzdm4PFRIEEyroQ5wRsku
 fA70zkXJhopO+B3yQ1vc80jpWb7Or1zayO2hZ7s766WnE4QmosL4Rc2aYt9oS5BcqL
 XEzoa5VpUleXUl2r5MJOPgR3uI3um9uPUzMS0VGhadHv0Le6yl7wkLpGHYLQhy5Lqe
 +M+ov+IPZCvkb1zEHre7GbDzI83WjRL9D+S/VTo6POfQ4zU2meExcFjGAyX4NJf78o
 5rw6yG/FEieng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 09E52D15D9A;
 Mon, 21 Oct 2024 13:55:58 +0000 (UTC)
From: Vasileios Bimpikas via B4 Relay
 <devnull+vasileios.bimpikas.analog.com@kernel.org>
Date: Mon, 21 Oct 2024 14:54:42 +0100
Subject: [PATCH v2 11/11] mmc: Add support for ADI SC5XX-family processor
 SDHCI peripherals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-sc5xx-driver-series-v2-11-53e2472e11d0@analog.com>
References: <20241021-sc5xx-driver-series-v2-0-53e2472e11d0@analog.com>
In-Reply-To: <20241021-sc5xx-driver-series-v2-0-53e2472e11d0@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729518874; l=7504;
 i=vasileios.bimpikas@analog.com; s=20240927; h=from:subject:message-id;
 bh=wVlr+OyPnjDZv6oQ4REp64YmoS9XIEBQJPuZm7IL2q4=;
 b=sgEJcyU6zg0Rc/Zkw8zX4S8dNBcco5sxK+fgLUDGTBFgDZn9bVFHCJcsMnVLZuBxe7WRPiqFc
 4ig0HKELNnRDtMB8lNQWdHkApfrKIQlMRAmWmiCtQPqeOjAToUJk10U
X-Developer-Key: i=vasileios.bimpikas@analog.com; a=ed25519;
 pk=JkXh+NeXYCpTenwrB0gg5fMpKEnagLOXdsLFiUrqZRo=
X-Endpoint-Received: by B4 Relay for vasileios.bimpikas@analog.com/20240927
 with auth_id=220
X-Original-From: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
X-Mailman-Approved-At: Tue, 22 Oct 2024 01:45:50 +0200
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
Reply-To: vasileios.bimpikas@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS             |   1 +
 drivers/mmc/Kconfig     |   9 +++
 drivers/mmc/Makefile    |   1 +
 drivers/mmc/adi_sdhci.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a553584fb7390adff2af78fe5d9461e99d0084e7..c59e061671e1bca03236211515bc4016306fdf68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -616,6 +616,7 @@ F:	drivers/dma/adi_dma.c
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
+F:	drivers/mmc/adi_sdhci.c
 F:	drivers/net/dwc_eth_qos_adi.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/remoteproc/adi_sc5xx_rproc.c
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 38817622fca1784703024c357b5d5ca11703afd6..b922765799bdbda991abb306e61969b4d9646e05 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -293,6 +293,15 @@ config MMC_DW_ROCKCHIP
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
index 868f3090ff24cc50cf9d71ac8f1f779efeb1471f..d4b747784b061996e218a2df6906d8c731732b9f 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MMC_SDHCI_MV)		+= mv_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PIC32)		+= pic32_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_ROCKCHIP)	+= rockchip_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_ADI)		+= adi_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_S5P)		+= s5p_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_STI)		+= sti_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_TANGIER)		+= tangier_sdhci.o
diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c
new file mode 100644
index 0000000000000000000000000000000000000000..311089a5f5230d827bbf8b5439064c94ada2b209
--- /dev/null
+++ b/drivers/mmc/adi_sdhci.c
@@ -0,0 +1,154 @@
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
+struct adi_sdhc {
+	struct sdhci_host host;
+	void *base;
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
2.34.1


