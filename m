Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE2FFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6A384664;
	Mon,  4 May 2026 19:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sLMJWVEa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kQRmRHHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FD584671; Mon,  4 May 2026 19:50:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A0B80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g8TgX4rNGz9v0L;
 Mon,  4 May 2026 19:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777917000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HBPVKDkPtG5oL3icpyMXumvICW36BLNFwLGSwCiUOKQ=;
 b=sLMJWVEaLyNHA/GNwcQf5bq5H3hV6nBJj86NItwZvSUV6M4bepoVoO8wwKrwhz7M/b8AMQ
 1a7H9b/HplqaRhX0G09p4w7RKHmE15fNASfe5eYCOUYr/AnevcT1ZBJdjyLmT+YpYRARkB
 p/w8scG0aHxqc+qBd5dt1AM5h3McPoD5J7n3PPabyvT9wORQ15vsa6Eee2aNqZJZll6KTT
 qjl5F+qcEiF2wRIonBuIiWol7/3tKL+5IMIj1CvFxZ8ThtfSAslu4o4O6XiT7LPCz40Ycw
 PMS2LpfkLRSlO3GldeMjSvLLiSeuT18V8LBBbqEh0cekmC9xsMFfaH4MitaOvA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777916998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HBPVKDkPtG5oL3icpyMXumvICW36BLNFwLGSwCiUOKQ=;
 b=kQRmRHHVN1TfbETE0okimNJbi0BcGWTWerAcdtI9J7i3r1ic9FQSMadEWdchJKaypOX2q0
 6cFuN2VA33/ofHwsrmscxuYjCVzkUq7CGqV+17Mqnfyu/kbp32y5D9pRRSBfmJPEO9ELsf
 RsfLs3i2WCxpS+PPogB27CRhfqdKeTUUAsPMdce3TsnXMWckDNvpFKFOvDmwrHcr2mgOU9
 qUTm14ZZjRlEJYGJMpKW7JSZwn6ZArSfVYZTDTZU+J0E2MsgCVo33qACwB+kbhX5Bjs3YH
 017K9yWz1sD8Wyi+rwlFLvuIaOwNlSC4Kmv2/nZ9AZasziMkNXtZ5Tz6XXLuFQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] watchdog: Add Renesas R-Car Gen5 window watchdog driver
Date: Mon,  4 May 2026 19:49:39 +0200
Message-ID: <20260504174954.57841-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rgq34b4bga9n873psopafof1ogsaafn8
X-MBO-RS-ID: cac42ad4a831e2f6c00
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

Add support of Renesas R-Car Gen5 window watchdog timer. Timeout
configuration is derived from CONFIG_WATCHDOG_TIMEOUT_MSECS, which
is more accurate than the 1-second granularity 'timeout' passed to
.start callback.

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Pull CTL register base from DT via syscon phandle
V3: Add RB from Stefan
---
 drivers/watchdog/Kconfig        |   7 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/renesas_wwdt.c | 162 ++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/watchdog/renesas_wwdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 416d29d256a..9ea617f1e43 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -356,6 +356,13 @@ config WDT_RENESAS
 	help
 	  Enables Renesas SoC R8A779F0 watchdog timer support.
 
+config WDT_RENESAS_WWDT
+	bool "Renesas window watchdog timer support"
+	depends on WDT
+	select SYSCON
+	help
+	  Enables Renesas window watchdog timer support.
+
 config WDT_SANDBOX
 	bool "Enable Watchdog Timer support for Sandbox"
 	depends on SANDBOX && WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 02e2674f8af..84faefdb4c2 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_WDT_NPCM) += npcm_wdt.o
 obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
 obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
 obj-$(CONFIG_WDT_RENESAS) += renesas_wdt.o
+obj-$(CONFIG_WDT_RENESAS_WWDT) += renesas_wwdt.o
 obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
 obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
 obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
diff --git a/drivers/watchdog/renesas_wwdt.c b/drivers/watchdog/renesas_wwdt.c
new file mode 100644
index 00000000000..f6f508c95c2
--- /dev/null
+++ b/drivers/watchdog/renesas_wwdt.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm/device_compat.h>
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <wdt.h>
+
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
+#define RSIP_CTL_CFG4		0xc0
+#define RSIP_CTL_CFG4_OPWDEN	BIT(3)
+#define RSIP_CTL_CFG4_OPWDVAC	BIT(5)
+
+#define WDTA0_ACT_CODE		0xac
+#define WDTA0WDTE		0x0
+#define WDTA0EVAC		0x4
+#define WDTA0REF		0x8
+#define WDTA0MD			0xc
+#define WDTA0MD_OVF_MASK	GENMASK(6, 4)
+#define WDTA0MD_OVF(n)		field_prep(WDTA0MD_OVF_MASK, (n))
+#define WDTA0MD_NWIE		BIT(3)
+#define WDTA0MD_NERM		BIT(2)
+#define WDTA0MD_NVS_MASK	GENMASK(1, 0)
+#define WDTA0MD_NVS_75P		FIELD_PREP(WDTA0MD_NVS_MASK, 3)
+
+struct wwdt_priv {
+	void __iomem *base;
+	struct regmap *ctl;
+	unsigned int timeout;
+};
+
+/**
+ * wwdt_reset() - Reset or ping Window WDT
+ * @dev: Watchdog device
+ */
+static int wwdt_reset(struct udevice *dev)
+{
+	struct wwdt_priv *priv = dev_get_priv(dev);
+	const u32 cfg = readl(priv->ctl->ranges[0].start + RSIP_CTL_CFG4);
+	u32 rv;
+
+	/* WDT disabled, do nothing. */
+	if (!(cfg & RSIP_CTL_CFG4_OPWDEN))
+		return 0;
+
+	/* WDT with variable activation code */
+	if (cfg & RSIP_CTL_CFG4_OPWDVAC) {
+		rv = readb(priv->base + WDTA0REF);
+		rv = WDTA0_ACT_CODE - rv;
+		writeb(rv, priv->base + WDTA0EVAC);
+	} else {
+		writeb(WDTA0_ACT_CODE, priv->base + WDTA0WDTE);
+	}
+
+	return 0;
+}
+
+/**
+ * wwdt_start() - Start Window WDT
+ * @dev: Watchdog device
+ * @timeout: Watchdog timeout (not used)
+ * @flags: Flags (not used)
+ */
+static int wwdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct wwdt_priv *priv = dev_get_priv(dev);
+
+	clrsetbits_8(priv->base + WDTA0MD,
+		     WDTA0MD_OVF_MASK | WDTA0MD_NWIE |
+		     WDTA0MD_NERM | WDTA0MD_NVS_MASK,
+		     WDTA0MD_OVF(priv->timeout) | WDTA0MD_NWIE |
+		     WDTA0MD_NVS_75P);
+
+	wwdt_reset(dev);
+
+	return 0;
+}
+
+/**
+ * wwdt_probe() - Initialize Window WDT hardware
+ * @dev: Watchdog device
+ */
+static int wwdt_probe(struct udevice *dev)
+{
+	struct wwdt_priv *priv = dev_get_priv(dev);
+	struct udevice *syscon;
+	unsigned long rate;
+	struct clk *clk;
+	int ret;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "syscon", &syscon);
+	if (ret) {
+		dev_err(dev, "Failed to get syscon\n");
+		return ret;
+	}
+
+	priv->ctl = syscon_get_regmap(syscon);
+	if (!priv->ctl) {
+		dev_err(dev, "Failed to get regmap\n");
+		return -ENODEV;
+	}
+
+	clk = devm_clk_get(dev, "cnt");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_err(dev, "Failed to get counter clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(clk);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		clk_disable(clk);
+		return -ENOENT;
+	}
+
+	/*
+	 * Interval time is in "2^9..2^16 / clk_wdt" range. WDTA0OVFx is
+	 * in 0..7 range. The code below does the WDTA0OVFx calculation
+	 * from "interval_time = (1 << N) / clk_wdt" by caculating the N.
+	 * The N rounded down is MSbit of (interval_time * clk_wdt). The
+	 * result is then clamped to fit into the N in 9..16 range, and
+	 * decremented by 9 to fit into WDTA0OVFx in 0..7 range .
+	 */
+	priv->timeout = clamp(fls(CONFIG_WATCHDOG_TIMEOUT_MSECS * rate) - 1, 9, 16) - 9;
+
+	return 0;
+}
+
+static const struct wdt_ops wwdt_ops = {
+	.start = wwdt_start,
+	.reset = wwdt_reset,
+};
+
+static const struct udevice_id wwdt_ids[] = {
+	{ .compatible = "renesas,rcar-gen5-wwdt" },
+	{}
+};
+
+U_BOOT_DRIVER(wwdt_renesas) = {
+	.name = "wwdt_renesas",
+	.id = UCLASS_WDT,
+	.of_match = wwdt_ids,
+	.ops = &wwdt_ops,
+	.probe	= wwdt_probe,
+	.priv_auto = sizeof(struct wwdt_priv),
+};
-- 
2.53.0

