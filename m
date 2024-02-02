Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE58C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CFB87CEA;
	Fri,  2 Feb 2024 13:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KaW1s/7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3337875E9; Fri,  2 Feb 2024 10:44:40 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87299875B9
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ddb129350cso1417683b3a.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706867076; x=1707471876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxSdz3MnyReb9jdaS9lBVD67/79Bbq81ynigS77Jlag=;
 b=KaW1s/7JQVHKFma2jdReO8KBuXjDH0RCiZ+HDWfCrWY30xi/mpdPufZrUsR1QFXcEc
 B9uZOMCFpYqL4aInvvz8cWdcTp9zefKB+WAmnfal19FI3gZAFoGBDqNx2qVxlvfQ0jb9
 vdpXruNdy4iOdgv8s8WogoXrLjnJHFcYUJCklPggipL4vk8Qzd2H9gXtq921JLm95NvP
 8pLPdDYeX62HQkdZnM1Stfmi5ih+cCdciNlC9oHGfZd/Y2oRf5xaF/zxOSYq4cG5ZW0r
 BE7UNw0rgBrmIGGliiyOEVkgOPrtjle2QJi3nptMhspI08axtPPOmOsowBHXv2pM9WB8
 SGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706867076; x=1707471876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxSdz3MnyReb9jdaS9lBVD67/79Bbq81ynigS77Jlag=;
 b=qT+FBt0IXUuIMxoAADLXZ7UYIMZyClYDRBGVfhbwuNt1Pj1eB+oWpiNQkhKF4PQJw4
 jpfbf03REQgHtOFuIpTzCTWQKlnzMgGqhBWkZtGpw4CKl6Z5Ag9/Yh8CJWD9zDB4zv4L
 h5BfaKre0STdt32tA0qHgLMWhF4qx0fThR9Pd6X7woF3iccsVapbhZHAs44rQd+VcL92
 KRWBLVwSAFpXJfHKna/fcOkqHiMxDxiQQ/ejCRjDgooSGZpuIA68fpAb18ZBmGNxWaNC
 uCAuu4TU/3a0j8f2pawEBY2dEvVmHqkS4K1aUm9q/jYl3ZVqlf3opScufDWrWN+I/Xr6
 nf+g==
X-Gm-Message-State: AOJu0Yx5oD25mDLv9Iliq2vsleZiuLIGbQ5YHLjhi/3I2KGgvQcTvt4y
 EfvijHntzUv0pg76Fq3NjVCb1KCSYeWJGlxYHlX8OiT7vOeCSGryEphqW2bpMRU92gTk
X-Google-Smtp-Source: AGHT+IH0HLyA8JVui11Q8RVF2Pzz5mTPzVK2ImRZbHoDw4tbv5oirb89hA2BIlYe268dxyAJrRtriQ==
X-Received: by 2002:a05:6a20:7526:b0:19a:fad2:518b with SMTP id
 r38-20020a056a20752600b0019afad2518bmr7096101pzd.5.1706867076207; 
 Fri, 02 Feb 2024 01:44:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX45Gcb/mpI+F+Cg/yOwz+pnd+kshK1yZDHZr1FWktC+qfFSduySJuQKcHSgi9kjeqcwLCbtNYkMw+KLYOef6X4QfrlPkhKuGWq+fT3mk20ScR4sFt8P1rrfdzhH5EvHuCS8F03NoLWAIp42Sz3mlCpW/jhypgotKwNxkwx6TERjys0LGvfiirFvc+C1UFFFVsALDtAPmG93pRqcEJcR8Ofdun8Nt6L0FLrykfRiUjy9kAS5AMM2+XH8sHhdoMPdSIWGpZRnNdgOpFQNRJjMneLTrZen56MTykQrenwsUeuXVuFnD/aC1qr3nQs6cNpl/sHWy7i8LH9Eq0=
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 fn27-20020a056a002fdb00b006dd8985e7c6sm1190979pfb.1.2024.02.02.01.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:44:35 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] mmc: cv1800b: Add sdhci driver support for cv1800b SoC
Date: Fri,  2 Feb 2024 17:43:33 +0800
Message-ID: <20240202094418.334221-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202094418.334221-1-seashell11234455@gmail.com>
References: <20240202094418.334221-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

Add sdhci driver for cv1800b SoC.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 drivers/mmc/Kconfig         |  13 ++
 drivers/mmc/Makefile        |   1 +
 drivers/mmc/cv1800b_sdhci.c | 243 ++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 drivers/mmc/cv1800b_sdhci.c

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 17618c3bdc..6d5b997fa5 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -568,6 +568,19 @@ config MMC_SDHCI_CADENCE
 
 	  If unsure, say N.
 
+config MMC_SDHCI_CV1800B
+	bool "SDHCI support for the CV1800B SD/SDIO/eMMC controller"
+	depends on BLK && DM_MMC
+	depends on MMC_SDHCI
+	depends on OF_CONTROL
+	help
+	  This selects the CV1800B SD/SDIO/eMMC driver.
+
+	  If you have a controller with this interface,
+	  say Y here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_AM654
 	bool "SDHCI Controller on TI's Am654 devices"
 	depends on ARCH_K3
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index e9cf1fcc64..3374321e29 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_MMC_SDHCI_ATMEL)		+= atmel_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= bcm2835_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCMSTB)		+= bcmstb_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
+obj-$(CONFIG_MMC_SDHCI_CV1800B)		+= cv1800b_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_AM654)		+= am654_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= iproc_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_KONA)		+= kona_sdhci.o
diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
new file mode 100644
index 0000000000..0de1a2d916
--- /dev/null
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <dm.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/sizes.h>
+#include <linux/libfdt.h>
+#include <reset.h>
+#include <mmc.h>
+#include <sdhci.h>
+
+#define SDHCI_VENDOR_OFFSET  0x200
+#define SDHCI_PHY_TX_RX_DLY  (SDHCI_VENDOR_OFFSET + 0x40)
+#define SDHCI_PHY_CONFIG     (SDHCI_VENDOR_OFFSET + 0x4C)
+
+#define MMC_MAX_CLOCK            375000000
+#define MMC_MAX_CLOCK_DIV_VALUE  0x40009
+
+#define REG_CLOCK_BYPASS_SELECT  (void *)0x03002030
+#define REG_TOP_SD_PWRSW_CTRL    (void *)0x030001F4
+#define REG_PWRSW_AUTO BIT(3)
+#define REG_PWRSW_DISC BIT(2)
+/* REG_PWRSW_VSEL=1: 1.8V, REG_PWRSW_VSEL=0: 3.0V */
+#define REG_PWRSW_VSEL BIT(1)
+#define REG_EN_PWRSW   BIT(0)
+
+/* SD Tap Delay Config */
+#define MAX_TUNING_CMD_RETRY_COUNT 50
+#define TUNE_MAX_PHCODE            128
+#define TAP_WINDOW_THLD            20
+
+struct cv1800b_sdhci_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+};
+
+struct cv1800b_sdhci_host {
+	struct sdhci_host host;
+	u32 pll_index;
+	u64 pll_reg;
+	bool no_1_8_v;
+	bool reset_tx_rx_phy;
+	u32 mmc_fmax_freq;
+	u32 mmc_fmin_freq;
+};
+
+static inline void sdhci_setbits(struct sdhci_host *host, int reg, u32 mask)
+{
+	u32 val;
+
+	val = sdhci_readl(host, reg);
+	val |= mask;
+	sdhci_writel(host, val, reg);
+}
+
+static inline void sdhci_clrbits(struct sdhci_host *host, int reg, u32 mask)
+{
+	u32 val;
+
+	val = sdhci_readl(host, reg);
+	val &= ~mask;
+	sdhci_writel(host, val, reg);
+}
+
+static void cv1800b_set_tap_delay(struct sdhci_host *host, u16 tap)
+{
+	sdhci_clrbits(host, SDHCI_CLOCK_CONTROL, SDHCI_CLOCK_CARD_EN);
+
+	sdhci_writel(host, 0, SDHCI_VENDOR_OFFSET);
+	sdhci_writel(host, BIT(8) | tap << 16, SDHCI_PHY_TX_RX_DLY);
+	sdhci_writel(host, 0, SDHCI_PHY_CONFIG);
+
+	sdhci_setbits(host, SDHCI_CLOCK_CONTROL, SDHCI_CLOCK_CARD_EN);
+}
+
+int cv1800b_get_cd(struct sdhci_host *host)
+{
+	return sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT;
+}
+
+int cv1800b_general_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct cv1800b_sdhci_host *priv = dev_get_priv(mmc->dev);
+	struct sdhci_host *host = &priv->host;
+
+	int ret;
+
+	u16 tap = 0;
+	u32 retry_cnt = 0;
+
+	int cur_window_idx = -1;
+	int max_window_size = 0;
+	int cur_window_size = 0;
+	int final_tap = -1;
+
+	sdhci_clrbits(host, SDHCI_HOST_CONTROL2, SDHCI_CTRL_TUNED_CLK | SDHCI_CTRL_DRV_TYPE_MASK);
+
+	for (tap = 0; tap < TUNE_MAX_PHCODE; tap++) {
+		sdhci_writew(host, BIT(2), SDHCI_VENDOR_OFFSET);
+		cv1800b_set_tap_delay(host, tap);
+
+		for (retry_cnt = 0; retry_cnt < MAX_TUNING_CMD_RETRY_COUNT; retry_cnt++) {
+			ret = mmc_send_tuning(host->mmc, opcode, NULL);
+			if (ret)
+				break;
+		}
+
+		/* Find a final tap as median of maximum window */
+		if (ret) {
+			cur_window_idx = -1;
+			continue;
+		}
+
+		if (-1 == cur_window_idx) {
+			cur_window_idx = tap;
+			cur_window_size = 0;
+		}
+		cur_window_size++;
+
+		if (cur_window_size > max_window_size) {
+			max_window_size = cur_window_size;
+			if (max_window_size >= TAP_WINDOW_THLD)
+				final_tap = cur_window_idx + (max_window_size / 2);
+		}
+	}
+
+	sdhci_clrbits(host, SDHCI_INT_STATUS, SDHCI_INT_DATA_AVAIL);
+
+	sdhci_setbits(host, SDHCI_SOFTWARE_RESET, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))
+		;
+
+	cv1800b_set_tap_delay(host, final_tap);
+
+	sdhci_clrbits(host, SDHCI_HOST_CONTROL2, SDHCI_CTRL_EXEC_TUNING);
+
+	return ret;
+}
+
+const struct sdhci_ops cv1800b_sdhci_sd_ops = {
+	.get_cd = cv1800b_get_cd,
+	.platform_execute_tuning = cv1800b_general_execute_tuning,
+};
+
+static int cv1800b_ofdata_to_platdata(struct udevice *dev)
+{
+	struct cv1800b_sdhci_host *priv = dev_get_priv(dev);
+	struct sdhci_host *host = &priv->host;
+
+	host->name = strdup(dev->name);
+	host->ioaddr = (void *)devfdt_get_addr(dev);
+	host->bus_width = dev_read_s32_default(dev, "bus-width", 4);
+	host->max_clk = dev_read_u32_default(dev, "src-frequency", 0);
+
+	priv->mmc_fmin_freq = dev_read_u32_default(dev, "tap-frequency", 200000);
+	priv->mmc_fmax_freq = dev_read_u32_default(dev, "max-frequency", 0);
+	priv->reset_tx_rx_phy = dev_read_bool(dev, "reset_tx_rx_phy");
+	priv->no_1_8_v = dev_read_bool(dev, "no-1-8-v");
+	priv->pll_index = dev_read_u32_default(dev, "pll_index", 0);
+	priv->pll_reg = dev_read_u64_default(dev, "pll_reg", 0);
+
+	if (priv->no_1_8_v)
+		host->quirks |= SDHCI_QUIRK_NO_1_8_V;
+
+	if (host->ioaddr == (void *)FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int cv1800b_sdhci_bind(struct udevice *dev)
+{
+	struct cv1800b_sdhci_plat *plat = dev_get_plat(dev);
+
+	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
+}
+
+static int cv1800b_sdhci_probe(struct udevice *dev)
+{
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct cv1800b_sdhci_plat *plat = dev_get_plat(dev);
+	struct cv1800b_sdhci_host *priv = dev_get_priv(dev);
+	struct sdhci_host *host = &priv->host;
+	int ret;
+
+	upriv->mmc = &plat->mmc;
+	host->mmc = &plat->mmc;
+	host->mmc->priv = host;
+	host->mmc->dev = dev;
+	host->ops = &cv1800b_sdhci_sd_ops;
+
+	ret = sdhci_setup_cfg(&plat->cfg, host, priv->mmc_fmax_freq, priv->mmc_fmin_freq);
+
+	if (ret)
+		return ret;
+
+	if (cv1800b_get_cd(host)) {
+		/* Voltage switching flow (3.3) */
+		writel(REG_PWRSW_AUTO | REG_EN_PWRSW, REG_TOP_SD_PWRSW_CTRL);
+	} else {
+		/* Voltage close flow */
+		writel(REG_PWRSW_AUTO | REG_PWRSW_DISC | REG_PWRSW_VSEL, REG_TOP_SD_PWRSW_CTRL);
+	}
+
+	ret = sdhci_probe(dev);
+
+	if (host->max_clk == MMC_MAX_CLOCK) {
+		/* set IP clock to 375Mhz */
+		writel(MMC_MAX_CLOCK_DIV_VALUE, (void *)priv->pll_reg);
+		/* switch clock source to PLL */
+		writel(readl(REG_CLOCK_BYPASS_SELECT) & ~BIT(priv->pll_index),
+			REG_CLOCK_BYPASS_SELECT);
+	}
+
+	if (priv->reset_tx_rx_phy) {
+		/* Default value */
+		sdhci_writel(host, 2, SDHCI_VENDOR_OFFSET);
+		sdhci_writel(host, 0x01000100, SDHCI_PHY_TX_RX_DLY);
+		sdhci_writel(host, 0x00000001, SDHCI_PHY_CONFIG);
+	}
+
+	return ret;
+}
+
+static const struct udevice_id cv1800b_sdhci_match[] = {
+	{ .compatible = "sophgo,cv1800b-sdhci" },
+	{ }
+};
+
+U_BOOT_DRIVER(cv1800b_sdhci) = {
+	.name = "sdhci-cv1800b",
+	.id = UCLASS_MMC,
+	.of_match = cv1800b_sdhci_match,
+	.of_to_plat = cv1800b_ofdata_to_platdata,
+	.bind = cv1800b_sdhci_bind,
+	.probe = cv1800b_sdhci_probe,
+	.priv_auto = sizeof(struct cv1800b_sdhci_host),
+	.plat_auto = sizeof(struct cv1800b_sdhci_plat),
+	.ops = &sdhci_ops,
+};
-- 
2.41.0

