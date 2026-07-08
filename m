Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B30AC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 21:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B76884A1F;
	Wed,  8 Jul 2026 23:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="gPRsLVro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902588407E; Wed,  8 Jul 2026 23:52:57 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A9684A8D
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 23:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=642353e54=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1783547574; x=1815083574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y1JLaRNuCmN1io/CKl/4KnFJf/+y4tfn7iawCeLfS00=;
 b=gPRsLVroFCS0fyPV1cA6p6OziA6RtE1/lX5VhrvoJcE/s1+f49th8qx+
 ZPKklJ8TlPHNz9eIQ1s6iWtMteXKmau+So0f5K1MRGbLuWdOfsonKYNiQ
 FECKzLR8GBspRRQeAN9eLeKB5INOds47Q847EL/2qhq9HEGFKQQeSxF7d
 0CwbSk/3dnqI51gcwiGQ/NSyEYNgPRobXJY25Cj8WAMHpAHAv6hFa792Q
 LrhS3tkMwB49YXwpYDgk4fjD+rtFs4i/MdBp2qaYDX5OOhJnujk8z0N+K
 Q9zClTvhPHlaRbD75sMA0yOpJiF4KNot7sgcjpqzHel7dLOM13kRPYt04 Q==;
X-CSE-ConnectionGUID: UPsretLUTq60M2vnmkGGHQ==
X-CSE-MsgGUID: zKi/Udx2QVmPaT6mMOz47g==
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="69640506"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 08 Jul 2026 14:52:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 8 Jul 2026 14:52:51 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 8 Jul 2026 14:52:49 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>, "Peng
 Fan" <peng.fan@nxp.com>, Julien Stephan <jstephan@baylibre.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Peter Korsgaard <peter@korsgaard.com>, "Michael
 Trimarchi" <michael@amarulasolutions.com>, Johan Jonker <jbx6244@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 4/5] drivers: clk: add support for RPMI clocks
Date: Wed, 8 Jul 2026 14:51:41 -0700
Message-ID: <20260708215200.1331416-5-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708215200.1331416-1-charles.perry@microchip.com>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The RISC-V Platform Management Interface (RPMI) defines a service group
for control and monitoring of clocks [1]. This can be exposed as a
UCLASS_CLK driver.

[1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v2: (from Yao Zi review)
 - Reorder headers
 - Don't null check pointers before free()
 - Remove transition_latency from struct rpmi_clk_def as its unused
 - Simplify last return path of _rpmi_clk_enable_disable()
 - Move the call to _rpmi_clk_get_rate() from _rpmi_clk_set_rate() to
   rpmi_clk_set_rate()
---
 MAINTAINERS            |   1 +
 drivers/clk/Kconfig    |   7 +
 drivers/clk/Makefile   |   1 +
 drivers/clk/clk_rpmi.c | 344 +++++++++++++++++++++++++++++++++++++++++
 include/rpmi_proto.h   |  39 +++++
 5 files changed, 392 insertions(+)
 create mode 100644 drivers/clk/clk_rpmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 812942a2d8a7..1e8f57c93a55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1654,6 +1654,7 @@ F:	doc/README.rockusb
 RPMI
 M:	Charles Perry <charles.perry@microchip.com>
 S:	Maintained
+F:	drivers/clk/clk_rpmi.c
 F:	drivers/firmware/rpmi/
 F:	include/rpmi*
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index addcece4da36..9167ae11dc8c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -181,6 +181,13 @@ config CLK_OCTEON
 	help
 	  Enable this to support the clocks on Octeon MIPS platforms.
 
+config CLK_RPMI
+	bool "Enable RPMI clock driver"
+	depends on CLK && RPMI_FIRMWARE
+	help
+	  Enable this option if you want to support clock devices exposed
+	  by RISC-V Platform Management Interface (RPMI).
+
 config SANDBOX_CLK_CCF
 	bool "Sandbox Common Clock Framework [CCF] support"
 	depends on SANDBOX
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c37ef75d420f..e76b95bdfcd5 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
 obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
+obj-$(CONFIG_CLK_RPMI) += clk_rpmi.o
 obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
diff --git a/drivers/clk/clk_rpmi.c b/drivers/clk/clk_rpmi.c
new file mode 100644
index 000000000000..42b1616ee7ec
--- /dev/null
+++ b/drivers/clk/clk_rpmi.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_CLK
+
+#include <asm/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <linux/clk-provider.h>
+#include <rpmi.h>
+
+struct rpmi_get_num_clocks_rx {
+	__le32 status;
+	__le32 num_clocks;
+};
+
+struct rpmi_get_rate_rx {
+	__le32 status;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_get_config_rx {
+	__le32 status;
+	__le32 state;
+};
+
+struct rpmi_set_rate_tx {
+	__le32 clkid;
+	__le32 flags;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_set_config_tx {
+	__le32 clkid;
+	__le32 config;
+};
+
+struct rpmi_get_attrs_rx {
+	__le32 status;
+#define RPMI_CLK_TYPE_MASK GENMASK(1, 0)
+	__le32 flags;
+	__le32 num_rates;
+	__le32 transition_latency;
+	char name[RPMI_CLK_NAME_LEN];
+};
+
+struct rpmi_clk_def {
+	u32 num_rates;
+	enum rpmi_clock_type type;
+	char name[RPMI_CLK_NAME_LEN + 1];
+};
+
+struct rpmi_clk_priv {
+	struct rpmi_chan chan;
+	u32 num_clocks;
+	struct rpmi_clk_def *defs;
+};
+
+static int _rpmi_clk_enable_disable(struct rpmi_clk_priv *priv, u32 clkid,
+				    bool ena)
+{
+	struct rpmi_set_config_tx tx = {
+		.clkid = cpu_to_le32(clkid),
+		.config = cpu_to_le32(ena ? RPMI_CLK_STATE_ENABLED :
+					    RPMI_CLK_STATE_DISABLED),
+	};
+	__le32 rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_CONFIG, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx);
+
+	return rpmi_to_linux_error(status);
+}
+
+static ulong _rpmi_clk_get_rate(struct rpmi_clk_priv *priv, u32 clkid)
+{
+	__le32 tx = cpu_to_le32(clkid);
+	struct rpmi_get_rate_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_RATE, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	return (((u64)(le32_to_cpu(rx.hi)) << 32) | (u32)(le32_to_cpu(rx.lo)));
+}
+
+static __maybe_unused int _rpmi_clk_get_config(struct rpmi_clk_priv *priv,
+					       u32 clkid)
+{
+	__le32 tx = cpu_to_le32(clkid);
+	struct rpmi_get_config_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_CONFIG, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	return le32_to_cpu(rx.state);
+}
+
+static int _rpmi_clk_set_rate(struct rpmi_clk_priv *priv, u32 clkid,
+			      unsigned long rate)
+{
+	struct rpmi_set_rate_tx tx = {
+		.clkid = cpu_to_le32(clkid),
+		.flags = 0,
+		.lo = cpu_to_le32(lower_32_bits(rate)),
+		.hi = cpu_to_le32(upper_32_bits(rate)),
+	};
+	__le32 rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_RATE, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx);
+
+	return rpmi_to_linux_error(status);
+}
+
+static int _rpmi_clk_get_num_clocks(struct rpmi_clk_priv *priv)
+{
+	struct rpmi_get_num_clocks_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_NUM_CLOCKS,
+				  NULL, 0, &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	priv->num_clocks = le32_to_cpu(rx.num_clocks);
+
+	return 0;
+}
+
+static int rpmi_clk_enable(struct clk *clk)
+{
+	return _rpmi_clk_enable_disable(dev_get_plat(clk->dev),
+					clk->id & CLK_ID_MSK, true);
+}
+
+static int rpmi_clk_disable(struct clk *clk)
+{
+	return _rpmi_clk_enable_disable(dev_get_plat(clk->dev),
+					clk->id & CLK_ID_MSK, false);
+}
+
+static ulong rpmi_clk_get_rate(struct clk *clk)
+{
+	return _rpmi_clk_get_rate(dev_get_plat(clk->dev), clk->id & CLK_ID_MSK);
+}
+
+static ulong rpmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	int ret;
+
+	ret = _rpmi_clk_set_rate(dev_get_plat(clk->dev), clk->id & CLK_ID_MSK,
+				 rate);
+	if (ret)
+		return ret;
+
+	return _rpmi_clk_get_rate(dev_get_plat(clk->dev), clk->id & CLK_ID_MSK);
+}
+
+static __maybe_unused void rpmi_clk_dump(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+	struct rpmi_clk_def *def;
+	u64 clk_rate = 0;
+	int i, state;
+
+	printf("              Rate State  Id Name\n");
+	printf("--------------------------------------\n");
+
+	for (i = 0; i < priv->num_clocks; i++) {
+		def = &priv->defs[i];
+		clk_rate = _rpmi_clk_get_rate(priv, i);
+		state = _rpmi_clk_get_config(priv, i);
+		printf("%18lld %s %4i %s\n", clk_rate,
+		       (state == RPMI_CLK_STATE_ENABLED) ? "   ON" : "  OFF", i,
+		       def->name);
+	}
+}
+
+static int rpmi_clk_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	struct rpmi_clk_priv *priv = dev_get_plat(clk->dev);
+
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	if (args->args[0] >= priv->num_clocks)
+		return -EINVAL;
+
+	clk->id = CLK_ID(clk->dev, args->args[0]);
+	clk->data = 0;
+
+	return 0;
+}
+
+static int rpmi_clk_get_attrs(struct rpmi_clk_priv *priv, u32 clkid,
+			      struct rpmi_clk_def *def)
+{
+	__le32 tx = cpu_to_le32(clkid);
+	struct rpmi_get_attrs_rx rx;
+	u8 format;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_ATTRIBUTES, &tx,
+				  sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	format = le32_to_cpu(rx.flags) & RPMI_CLK_TYPE_MASK;
+	if (format >= RPMI_CLK_TYPE_MAX)
+		return -EINVAL;
+
+	def->type = format;
+	def->num_rates = le32_to_cpu(rx.num_rates);
+	memcpy(def->name, rx.name, RPMI_CLK_NAME_LEN);
+	def->name[RPMI_CLK_NAME_LEN] = '\0';
+
+	return 0;
+}
+
+static int rpmi_clk_probe(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+	struct rpmi_chan *chan = &priv->chan;
+	int ret, i;
+
+	ret = rpmi_open(chan);
+	if (ret)
+		return ret;
+
+	ret = rpmi_check_versions(chan, RPMI_MKVER(1, 0), RPMI_SRVGRP_CLOCK,
+				  RPMI_MKVER(1, 0));
+	if (ret)
+		goto err_out;
+
+	ret = _rpmi_clk_get_num_clocks(priv);
+	if (ret)
+		goto err_out;
+
+	priv->defs = calloc(priv->num_clocks, sizeof(struct rpmi_clk_def));
+	if (!priv->defs) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < priv->num_clocks; i++) {
+		ret = rpmi_clk_get_attrs(priv, i, &priv->defs[i]);
+		if (ret)
+			goto err_out;
+	}
+
+	dev_dbg(dev, "num clock = %i\n", priv->num_clocks);
+
+	return 0;
+
+err_out:
+	free(priv->defs);
+	rpmi_close(chan);
+
+	return ret;
+}
+
+static int rpmi_clk_remove(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+	struct rpmi_chan *chan = &priv->chan;
+
+	free(priv->defs);
+	rpmi_close(chan);
+
+	return 0;
+}
+
+static int rpmi_clk_to_plat(struct udevice *dev)
+{
+	struct rpmi_clk_priv *priv = (struct rpmi_clk_priv *)dev_get_plat(dev);
+
+	return rpmi_get_by_index(dev, 0, &priv->chan);
+}
+
+static struct clk_ops rpmi_clk_ops = {
+	.of_xlate = rpmi_clk_xlate,
+	.set_rate = rpmi_clk_set_rate,
+	.get_rate = rpmi_clk_get_rate,
+	.enable = rpmi_clk_enable,
+	.disable = rpmi_clk_disable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump = rpmi_clk_dump,
+#endif
+};
+
+static const struct udevice_id rpmi_clk_ids[] = {
+	{ .compatible = "riscv,rpmi-clock" },
+	{}
+};
+
+U_BOOT_DRIVER(rpmi_clk) = {
+	.name = "rpmi-clk",
+	.id = UCLASS_CLK,
+	.of_match = rpmi_clk_ids,
+	.probe = rpmi_clk_probe,
+	.remove = rpmi_clk_remove,
+	.ops = &rpmi_clk_ops,
+	.of_to_plat = rpmi_clk_to_plat,
+	.plat_auto = sizeof(struct rpmi_clk_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
index 4b557bfeedf5..dc0937ce7053 100644
--- a/include/rpmi_proto.h
+++ b/include/rpmi_proto.h
@@ -83,4 +83,43 @@ enum rpmi_message_type {
 	RPMI_MSG_NOTIFICATION = 0x3,
 };
 
+/* RPMI clock service IDs */
+enum rpmi_clock_service_id {
+	RPMI_CLK_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_CLK_SRV_GET_NUM_CLOCKS = 0x02,
+	RPMI_CLK_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_CLK_SRV_GET_SUPPORTED_RATES = 0x04,
+	RPMI_CLK_SRV_SET_CONFIG = 0x05,
+	RPMI_CLK_SRV_GET_CONFIG = 0x06,
+	RPMI_CLK_SRV_SET_RATE = 0x07,
+	RPMI_CLK_SRV_GET_RATE = 0x08,
+	RPMI_CLK_SRV_ID_MAX_COUNT
+};
+
+/** Clock rate match mode */
+enum rpmi_clock_rate_match {
+	RPMI_CLK_RATE_MATCH_PLATFORM	= 0,
+	RPMI_CLK_RATE_MATCH_ROUND_DOWN	= 1,
+	RPMI_CLK_RATE_MATCH_ROUND_UP	= 2,
+	RPMI_CLK_RATE_MATCH_MAX
+};
+
+/** Supported clock states */
+enum rpmi_clock_state {
+	RPMI_CLK_STATE_DISABLED	= 0,
+	RPMI_CLK_STATE_ENABLED	= 1,
+	RPMI_CLK_STATE_MAX
+};
+
+/** Clock type based on rate format */
+enum rpmi_clock_type {
+	RPMI_CLK_TYPE_DISCRETE	= 0,
+	RPMI_CLK_TYPE_LINEAR	= 1,
+	RPMI_CLK_TYPE_MAX
+};
+
+#define RPMI_CLK_NAME_LEN 16
+
+#define RPMI_CLOCK_RATE_INVALID		(-1ULL)
+
 #endif
-- 
2.47.3

