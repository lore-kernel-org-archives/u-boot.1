Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D351D15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2DE88F82;
	Mon, 21 Oct 2024 17:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NohZ+ptQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C70E88F49; Mon, 21 Oct 2024 17:13:46 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FC888F4F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D8BA3FF805;
 Mon, 21 Oct 2024 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCKkgScG5AthTbRCF2CjOL1QX0+r8+hWHvdO3fLjKuw=;
 b=NohZ+ptQolZoJYxrjot84GpJTLjsVN1A+0Q05eIOKIKmQBnE3pGwymPzZgbw9hgZSje9MI
 Q+iDkeEJ6KfAps6BlRjv9Z65oCXeZWlIn+efUEhpjuc4IWcnAv956VYGpS0p/Bc1aBW3r3
 COj4mKksxQAfivB5kICBfpUVn7wGXYv7JpY5QXl4/5e+st6vZd02kuFfW0h0jlBEATQB/D
 KUUn7Tj0Xgha6eq0KNWx0YPfq6mTPeKXRc/QkMPItqLaV6DEFGtHMMPcq7kqiG7sYDgkJN
 0vRwZNksbiN04gVb/7n0PK5RJ/eMAc8TPoEh8YKRvYoGn2psk/iv+M/LqRaazg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 6/6] memory: ti-aemif-cs: Compute timing configuration from DT
 parsing
Date: Mon, 21 Oct 2024 17:13:30 +0200
Message-ID: <20241021151330.1860929-7-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

The Linux bindings of the AEMIF offer properties that specify the
transaction timings for each chips select.

Add parsing of these properties to calculate the chip select's
configuration from them and the rate of the AEMIF's reference clock.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif-cs.c | 122 +++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/memory/ti-aemif-cs.c b/drivers/memory/ti-aemif-cs.c
index 80166e3e6a..0fcfee6f0b 100644
--- a/drivers/memory/ti-aemif-cs.c
+++ b/drivers/memory/ti-aemif-cs.c
@@ -5,6 +5,7 @@
  */
 #include <asm/io.h>
 #include <clk.h>
+#include <div64.h>
 #include <dm.h>
 #include "ti-aemif-cs.h"
 
@@ -21,6 +22,20 @@
 #define AEMIF_CFG_TURN_AROUND(v)	(((v) & 0x03) << 2)
 #define AEMIF_CFG_WIDTH(v)		(((v) & 0x03) << 0)
 
+#define SSTROBE_EN			0x1
+#define EW_EN				0x1
+
+#define WSETUP_MAX			0xf
+#define WSTROBE_MAX			0x3f
+#define WHOLD_MAX			0x7
+#define RSETUP_MAX			0xf
+#define RSTROBE_MAX			0x3f
+#define RHOLD_MAX			0x7
+#define TA_MAX				0x3
+
+#define WIDTH_8BITS			0x0
+#define WIDTH_16BITS			0x1
+
 #define set_config_field(reg, field, val)				\
 	do {								\
 		if ((val) != -1) {					\
@@ -49,6 +64,111 @@ void aemif_cs_configure(int cs, struct aemif_config *cfg)
 	__raw_writel(tmp, cfg->base + AEMIF_CONFIG(cs));
 }
 
+struct ti_aemif_cs {
+	void __iomem *base;
+	struct clk *clk;
+};
+
+static unsigned int aemif_calc_cfg(ulong rate, u64 timing_ns, u32 max_cfg)
+{
+	u64 result;
+
+	if (!timing_ns)
+		return 0;
+
+	result = DIV_ROUND_UP_ULL(timing_ns * rate, 1000000000ULL);
+
+	if (result - 1 > max_cfg)
+		return max_cfg;
+
+	return result - 1;
+}
+
+static int aemif_cs_set_timings(struct udevice *dev)
+{
+	struct ti_aemif_cs *priv = dev_get_priv(dev);
+	ulong rate = clk_get_rate(priv->clk);
+	struct aemif_config cfg = {};
+	u32 val;
+	u32 cs;
+
+	if (dev_read_u32(dev, "ti,cs-chipselect", &cs))
+		return -EINVAL;
+
+/*
+ * On DaVinci SoCs, chipselect is in range [2-5]
+ * On Keystone SoCs, chipselect is in range [0-3]
+ * The logic to access the configuration registers expects the CS to be in the
+ * Keystone range so a -2 offset is applied on DaVinci SoCs
+ */
+	if (IS_ENABLED(CONFIG_ARCH_DAVINCI)) {
+		if (cs < 2 || cs > 5)
+			return -EINVAL;
+		cs -= 2;
+	} else if (IS_ENABLED(CONFIG_ARCH_KEYSTONE)) {
+		if (cs > 3)
+			return -EINVAL;
+	}
+
+	if (dev_read_bool(dev, "ti,cs-select-strobe-mode"))
+		cfg.select_strobe = SSTROBE_EN;
+
+	if (dev_read_bool(dev, "ti,cs-extended-wait-mode"))
+		cfg.extend_wait = EW_EN;
+
+	val = dev_read_u32_default(dev, "ti,cs-write-setup-ns", U32_MAX);
+	cfg.wr_setup = aemif_calc_cfg(rate, val, WSETUP_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-write-strobe-ns", U32_MAX);
+	cfg.wr_strobe = aemif_calc_cfg(rate, val, WSTROBE_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-write-hold-ns", U32_MAX);
+	cfg.wr_hold = aemif_calc_cfg(rate, val, WHOLD_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-read-setup-ns", U32_MAX);
+	cfg.rd_setup = aemif_calc_cfg(rate, val, RSETUP_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-read-strobe-ns", U32_MAX);
+	cfg.rd_strobe = aemif_calc_cfg(rate, val, RSTROBE_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-read-hold-ns", U32_MAX);
+	cfg.rd_hold = aemif_calc_cfg(rate, val, RHOLD_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-min-turnaround-ns", U32_MAX);
+	cfg.turn_around = aemif_calc_cfg(rate, val, TA_MAX);
+
+	val = dev_read_u32_default(dev, "ti,cs-bus-width", 8);
+	if (val == 16)
+		cfg.width = WIDTH_16BITS;
+	else
+		cfg.width = WIDTH_8BITS;
+
+	cfg.base = priv->base;
+	aemif_cs_configure(cs, &cfg);
+
+	return 0;
+}
+
+static int aemif_cs_probe(struct udevice *dev)
+{
+	struct ti_aemif_cs *priv = dev_get_priv(dev);
+	struct udevice *aemif;
+
+	aemif = dev_get_parent(dev);
+	if (!aemif)
+		return -ENODEV;
+
+	priv->base = dev_read_addr_ptr(aemif);
+	if (!priv->base)
+		return -EINVAL;
+
+	priv->clk = devm_clk_get(aemif, "aemif");
+	if (IS_ERR(priv->clk))
+		return -EINVAL;
+
+	return aemif_cs_set_timings(dev);
+}
+
 static const struct udevice_id aemif_cs_ids[] = {
 	{ .compatible = "ti,da850-aemif-cs", },
 	{},
@@ -58,4 +178,6 @@ U_BOOT_DRIVER(ti_aemif_cs) = {
 	.name = "ti_aemif_cs",
 	.id = UCLASS_MEMORY,
 	.of_match = aemif_cs_ids,
+	.probe = aemif_cs_probe,
+	.priv_auto = sizeof(struct ti_aemif_cs),
 };
-- 
2.47.0

