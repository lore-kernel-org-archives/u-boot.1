Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FA4C54791
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 233F387EE7;
	Sat,  9 Mar 2024 22:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+xG8D/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B624A87D5F; Sat,  9 Mar 2024 18:53:54 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A63987DA5
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 18:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c1ea425a0fso1594577b6e.3
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 09:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710006830; x=1710611630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z32EY2y6QXPfQNHcFE741J3BfP7rF/3PQ4I4lgnnOQ0=;
 b=i+xG8D/SGyGUDwn9f58xU0ulrJ8+1oK6ZxCxMghdHOno+PBZi+YXqU0mRDAjILBeqW
 ptyZK/Jjg8ptx2sPUuz5/huk3SejISjscQ7ANhjavXgbCYT7RTuHrubGel+0xlYhzcIM
 LWyWgr2RZ1KLC+/Ge9EYSm7ne6xHKA8LteqlDLPyjJGFGFBdbqvtL1SMjAfRX7nt5g4C
 ZY+cflPcIA4EUdgJwgmbXQfwKpE2+PWdwOqyI4NHF119p8XcAtN9JOFmHJ2gPwQacP8O
 q87byWcYRVyElH+8fZjH0iek7e7pVUlVfUqxvU9W0gUXUHI+dYUIQxQoQ4iQIZdE1z64
 ss8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006830; x=1710611630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z32EY2y6QXPfQNHcFE741J3BfP7rF/3PQ4I4lgnnOQ0=;
 b=YY7nJ4IDVvvx2Q/6sD9o9FEriobF0cf+cSaPGn738+I3Rkf9nMpS5CmyDgg0WxODyN
 zLkEDn395r+HhXSP2yj6WkxguKTkM8cpZZ3/af/4zBCJSOGwOS7JlAlpMybPv2qAbwj2
 uccopD1Ake/097MNmTHt351WX0LAopy0PIoRLGoAsYRHZMaV19LnEZHGvPF0oK+GYTIo
 WUrdSls5vcbrmODQAHfSTkuLXSNbPqc10079h66bf83f3DiyjEu8r65Ubf4dFnlUbQI7
 c3/1e+BPJCGjqckYq0AdpAoApIfzz5sMWbprkFuCn/nZD7cBJ9AJgfAgekEfTp+jerFs
 2Exw==
X-Gm-Message-State: AOJu0Yx9MbGlBzAAitIdprO7J1twWNDKRYC8wi3AxMsuOUUVpR2EvK3B
 cJsCFIIBsYp8T0PQnIHNa0PeA9YeLi8DHXzk/b8PZnEJf8Z+ZiWqaXJ6YX3ztLMdaQ==
X-Google-Smtp-Source: AGHT+IE89i+8rNGgWi3WE+mQ6z/lsU03hhab10p1T6Wt2ABp6dtewPI/TI/rGEJXM22OvEIWR3eFPw==
X-Received: by 2002:a05:6808:10c2:b0:3c2:214d:9b42 with SMTP id
 s2-20020a05680810c200b003c2214d9b42mr3341819ois.40.1710006829915; 
 Sat, 09 Mar 2024 09:53:49 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a631e02000000b005d7994a08dcsm1530651pge.36.2024.03.09.09.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:53:49 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] mmc: cv1800b: Add sdhci driver support for cv1800b SoC
Date: Sun, 10 Mar 2024 01:51:55 +0800
Message-ID: <20240309175330.79267-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309175330.79267-1-seashell11234455@gmail.com>
References: <20240309175330.79267-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

Changes in v2:
- Refactored and simplified some of the code.

 drivers/mmc/Kconfig         |  13 ++++
 drivers/mmc/Makefile        |   1 +
 drivers/mmc/cv1800b_sdhci.c | 116 ++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/mmc/cv1800b_sdhci.c

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index cef05790dd..f7fe6d1042 100644
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
index 0000000000..2275c53777
--- /dev/null
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <dm.h>
+#include <mmc.h>
+#include <sdhci.h>
+#include <linux/delay.h>
+
+#define SDHCI_PHY_TX_RX_DLY  0x240
+#define MMC_MAX_CLOCK        375000000
+#define TUNE_MAX_PHCODE      128
+
+struct cv1800b_sdhci_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+};
+
+static void cv1800b_set_tap_delay(struct sdhci_host *host, u16 tap)
+{
+	sdhci_writel(host, tap << 16, SDHCI_PHY_TX_RX_DLY);
+}
+
+static void cv1800b_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask)
+		udelay(10);
+}
+
+static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = dev_get_priv(mmc->dev);
+
+	u16 tap;
+
+	int current_size = 0;
+	int max_size = 0;
+	int max_window = 0;
+
+	for (tap = 0; tap < TUNE_MAX_PHCODE; tap++) {
+		cv1800b_set_tap_delay(host, tap);
+
+		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+			current_size = 0;
+		} else {
+			current_size++;
+			if (current_size > max_size) {
+				max_size = current_size;
+				max_window = tap;
+			}
+		}
+	}
+
+	cv1800b_sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	cv1800b_set_tap_delay(host, max_window - max_size / 2);
+
+	return 0;
+}
+
+const struct sdhci_ops cv1800b_sdhci_sd_ops = {
+	.platform_execute_tuning = cv1800b_execute_tuning,
+};
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
+	struct sdhci_host *host = dev_get_priv(dev);
+	int ret;
+
+	host->name = dev->name;
+	host->ioaddr = devfdt_get_addr_ptr(dev);
+
+	upriv->mmc = &plat->mmc;
+	host->mmc = &plat->mmc;
+	host->mmc->priv = host;
+	host->mmc->dev = dev;
+	host->ops = &cv1800b_sdhci_sd_ops;
+	host->max_clk = MMC_MAX_CLOCK;
+
+	ret = mmc_of_parse(dev, &plat->cfg);
+	if (ret)
+		return ret;
+
+	ret = sdhci_setup_cfg(&plat->cfg, host, 0, 200000);
+	if (ret)
+		return ret;
+
+	return sdhci_probe(dev);
+}
+
+static const struct udevice_id cv1800b_sdhci_match[] = {
+	{ .compatible = "sophgo,cv1800b-dwcmshc" },
+	{ }
+};
+
+U_BOOT_DRIVER(cv1800b_sdhci) = {
+	.name = "sdhci-cv1800b",
+	.id = UCLASS_MMC,
+	.of_match = cv1800b_sdhci_match,
+	.bind = cv1800b_sdhci_bind,
+	.probe = cv1800b_sdhci_probe,
+	.priv_auto = sizeof(struct sdhci_host),
+	.plat_auto = sizeof(struct cv1800b_sdhci_plat),
+	.ops = &sdhci_ops,
+};
-- 
2.41.0

