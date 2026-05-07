Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D145CD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667A384B67;
	Fri,  8 May 2026 01:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hg9m8GOd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VZwu0L7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DAD84BCF; Fri,  8 May 2026 01:24:43 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B7F84B58
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBSyJ6hgYz9tgG;
 Fri,  8 May 2026 01:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VbNnd1WAJFjX2Qhk2WTHpLhgyNtF1FhcEnJXs7s8u+Y=;
 b=Hg9m8GOdwS6vd+0Z0hZbM9KLeKF1zxmX9Hepky3Eelb3sgXV4Gj8LmXvY13GMR2WmRIztK
 0CgYoL6WtoNqwX/DQUJYREz+fIfvhgGDbgHCV/v97BFKOxE7TjMW5PPaHUrnloON+1wNvO
 mTzRQFwoup2t79WixPf43BqNS5bdxlX0a1GVH5019ItyMSUokuG5XXNsVmSvjPtgqtIIsS
 dw1tsfTjBPWIO6ddhCr19NSEZE9I14k2EwHhEokeR6JH89iVOoTtIqqSvJ3v5jN6l+v14n
 X5jaGuxuD9cBnMRsCyeTgy2UuGUdSKm2Mianq557MyDqyA+gKGzyVTQLW8MDOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VbNnd1WAJFjX2Qhk2WTHpLhgyNtF1FhcEnJXs7s8u+Y=;
 b=VZwu0L7g5sBnP7kyveLhEkOMhV/xFl2wmYVaZc3D1e9KWG2Xo2HmQ8lx8Y3s3qVHE0ENxb
 1Ixs96rtnGhjGlNZyuRL6Ib8cyc1gfXzgI6qKPuFhFsykEqKSnr47dVrMupo5I6hmTw0bp
 4feodkz12q4M6XZj1Zsu3DCZ7B9eWtuBJ3UhQhyEFOsCqnNLsY7IiD+QL9weLF0ky9/PF9
 6zTcg22Yc/IUK5ic8JQW1mYv9pfZzknd5UyQc4H3Ip/L/81Uqcm2ACaSPcOd2kYaBL1tmA
 97nDw1t2rprKsME+qGRZxGwtAjltsPWhbUXnev+psFekN4eKv9DHQZIayo1rrA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] clk: renesas: Add Renesas R-Car R8A78000 X5H CPG clock
 driver
Date: Fri,  8 May 2026 01:23:28 +0200
Message-ID: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: knsnm6njfatx4qn695mxytd8hx99nag6
X-MBO-RS-ID: 4bf8685cc5bdb86535f
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

Add Renesas R-Car R8A78000 X5H CPG clock driver, which serves as a
remap driver between DT clock IDs and SCMI clock IDs in case U-Boot
runs on the Cortex-A, and as a trivial clock driver for RSIP.

The R-Car X5H SCP firmware uses different SCMI clock IDs in different
versions of the SCP firmware, which makes this remapping necessary.
The SCMI base protocol version is updated for each new SCP firmware
version, it is therefore possible to determine which SCP firmware
version is running on the platform from the base protocol and then
determine which remapping table to use for DT clock ID to SCMI clock
ID remapping.

Currently supported versions are SCP 4.28, 4.31, 4.32 .

The DT clock ID to SCMI clock ID remap and call mechanism is a bit
complex. The driver looks up the SCMI clock protocol device on probe
and stores pointer to it in private data. On each clock request which
has to be remapped, the device sequence ID of this SCMI clock protocol
device is incremented by the remapped SCMI clock ID + 1 and used to
look up matching clock device by sequence number. If the device is
found, it is converted to clock, which can be used in regular clock
operations. This look up has to be done because the SCMI clock driver
registers a subdevice for each clock, and this look up is the only way
to find the correct SCMI clock subdevice. Since the SCMI device and
the clock subdevices are registered in the same function, we can depend
on the device sequence numbers to be monotonically incrementing, with
SCMI clock protocol device being sequence number N, the first SCMI
clock subdevice being sequence number N+1 and so on.

In case of RSIP, all clocks are already enabled by BootROM or early
SoC initialization code, the driver therefore only acts as a stub.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Clément Le Goffic <clegoffic@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/renesas/Kconfig        |   6 +
 drivers/clk/renesas/Makefile       |   1 +
 drivers/clk/renesas/r8a78000-cpg.c | 282 +++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 drivers/clk/renesas/r8a78000-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 51c87cc3606..72f99e9fa1b 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -157,6 +157,12 @@ config CLK_R8A779H0
 	help
 	  Enable this to support the clocks on Renesas R8A779H0 SoC.
 
+config CLK_R8A78000
+	bool "Renesas R8A78000 clock driver"
+	depends on CLK_RENESAS
+	help
+	  Enable this to support the clocks on Renesas R8A78000 SoC.
+
 config CLK_R9A06G032
 	bool "Renesas R9A06G032 clock driver"
 	depends on CLK_RENESAS
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 354035baf2d..fb8d4c1f2f6 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_CLK_R8A779A0) += r8a779a0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779F0) += r8a779f0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779G0) += r8a779g0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779H0) += r8a779h0-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A78000) += r8a78000-cpg.o
 obj-$(CONFIG_CLK_R9A06G032) += r9a06g032-clocks.o
 obj-$(CONFIG_CLK_RZG2L) += rzg2l-cpg.o
 obj-$(CONFIG_CLK_R9A07G044) += r9a07g044-cpg.o
diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
new file mode 100644
index 00000000000..e9ca06476f6
--- /dev/null
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Renesas R-Car Gen5 CPG driver
+ *
+ * Copyright (C) 2026 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/clk-provider.h>
+
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
+
+#include <dt-bindings/clock/r8a78000-clock-scmi.h>
+
+#if IS_ENABLED(CONFIG_CLK_SCMI)
+struct gen5_clk_priv {
+	struct udevice	*clk;
+	u32		basever;
+};
+
+static struct clk *gen5_clk_get_by_scmi_id(struct clk *clk)
+{
+	struct gen5_clk_priv *priv = dev_get_priv(clk->dev);
+	struct udevice *sdev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(UCLASS_CLK, sdev, uc)
+		if (sdev->seq_ == priv->clk->seq_ + clk->id + 1)
+			return dev_get_clk_ptr(sdev);
+
+	return NULL;
+}
+
+static ulong gen5_clk_round_rate(struct clk *clk, ulong rate)
+{
+	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
+
+	if (!scmi)
+		return -ENODEV;
+
+	return clk_round_rate(scmi, rate);
+}
+
+static ulong gen5_clk_get_rate(struct clk *clk)
+{
+	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
+
+	if (!scmi)
+		return -ENODEV;
+
+	return clk_get_rate(scmi);
+}
+
+static ulong gen5_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
+
+	if (!scmi)
+		return -ENODEV;
+
+	return clk_set_rate(scmi, rate);
+}
+
+static int gen5_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
+
+	if (!scmi)
+		return -ENODEV;
+
+	return clk_set_parent(scmi, parent);
+}
+
+static int gen5_clk_enable(struct clk *clk)
+{
+	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
+
+	if (!scmi)
+		return -ENODEV;
+
+	return clk_enable(scmi);
+}
+
+static int gen5_clk_disable(struct clk *clk)
+{
+	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
+
+	if (!scmi)
+		return -ENODEV;
+
+	return clk_disable(scmi);
+}
+
+struct clk_map_in {
+	u16 dt_id;	/* DT binding clock ID */
+	u16 fw_id;	/* SCMI firmware clock ID */
+};
+
+#define GEN5_SCMI_SDK_4_28		0x010a0000
+#define GEN5_SCMI_SDK_4_29		0x010b0000
+#define GEN5_SCMI_SDK_4_30		0x010c0000
+#define GEN5_SCMI_SDK_4_31		0x010d0000
+#define GEN5_SCMI_SDK_4_32		0x010e0000
+
+static const struct clk_map_in gen5_clk_map_dt_sdk_4_28[] = {
+	{ SCP_CLOCK_ID_MDLC_UFS0, 202 },
+	{ SCP_CLOCK_ID_MDLC_UFS1, 203 },
+	{ SCP_CLOCK_ID_MDLC_SDHI0, 204 },
+	{ SCP_CLOCK_ID_MDLC_XPCS0, 316 },
+	{ SCP_CLOCK_ID_MDLC_XPCS1, 317 },
+	{ SCP_CLOCK_ID_MDLC_XPCS2, 318 },
+	{ SCP_CLOCK_ID_MDLC_XPCS3, 319 },
+	{ SCP_CLOCK_ID_MDLC_XPCS4, 320 },
+	{ SCP_CLOCK_ID_MDLC_XPCS5, 321 },
+	{ SCP_CLOCK_ID_MDLC_XPCS6, 322 },
+	{ SCP_CLOCK_ID_MDLC_XPCS7, 323 },
+	{ SCP_CLOCK_ID_MDLC_RSW3, 324 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSN, 325 },
+	{ SCP_CLOCK_ID_MDLC_RSW3AES, 326 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES0, 327 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES1, 328 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES2, 329 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES3, 330 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES4, 331 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES5, 332 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES6, 333 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES7, 334 },
+	{ SCP_CLOCK_ID_MDLC_RSW3MFWD, 335 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY01, 344 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY11, 345 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY21, 346 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY31, 347 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY02, 348 },
+	{ SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN, 1691 },
+};
+
+static const struct clk_map_in gen5_clk_map_dt_sdk_4_31[] = {
+	{ SCP_CLOCK_ID_MDLC_UFS0, 198 },
+	{ SCP_CLOCK_ID_MDLC_UFS1, 199 },
+	{ SCP_CLOCK_ID_MDLC_SDHI0, 200 },
+	{ SCP_CLOCK_ID_MDLC_XPCS0, 312 },
+	{ SCP_CLOCK_ID_MDLC_XPCS1, 313 },
+	{ SCP_CLOCK_ID_MDLC_XPCS2, 314 },
+	{ SCP_CLOCK_ID_MDLC_XPCS3, 315 },
+	{ SCP_CLOCK_ID_MDLC_XPCS4, 316 },
+	{ SCP_CLOCK_ID_MDLC_XPCS5, 317 },
+	{ SCP_CLOCK_ID_MDLC_XPCS6, 318 },
+	{ SCP_CLOCK_ID_MDLC_XPCS7, 319 },
+	{ SCP_CLOCK_ID_MDLC_RSW3, 320 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSN, 321 },
+	{ SCP_CLOCK_ID_MDLC_RSW3AES, 322 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES0, 323 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES1, 324 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES2, 325 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES3, 326 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES4, 327 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES5, 328 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES6, 329 },
+	{ SCP_CLOCK_ID_MDLC_RSW3TSNTES7, 330 },
+	{ SCP_CLOCK_ID_MDLC_RSW3MFWD, 331 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY01, 340 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY11, 341 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY21, 342 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY31, 343 },
+	{ SCP_CLOCK_ID_MDLC_MPPHY02, 344 },
+	{ SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN, 1687 },
+};
+
+static int gen5_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	struct gen5_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct clk_map_in *map;
+	unsigned int map_size;
+	int i;
+
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (priv->basever == GEN5_SCMI_SDK_4_28) {
+		map = gen5_clk_map_dt_sdk_4_28;
+		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_28);
+	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
+		   priv->basever == GEN5_SCMI_SDK_4_32) {
+		map = gen5_clk_map_dt_sdk_4_31;
+		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_31);
+	} else {
+		printf("Unsupported SCMI base protocol version %x\n", priv->basever);
+		return -EINVAL;
+	}
+
+	clk->id = -1;
+	for (i = 0; i < map_size; i++) {
+		if (map[i].dt_id != args->args[0])
+			continue;
+		clk->id = map[i].fw_id;
+		break;
+	}
+
+	if (clk->id == -1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct clk_ops gen5_clk_ops = {
+	.round_rate	= gen5_clk_round_rate,
+	.get_rate	= gen5_clk_get_rate,
+	.set_rate	= gen5_clk_set_rate,
+	.set_parent	= gen5_clk_set_parent,
+	.enable		= gen5_clk_enable,
+	.disable	= gen5_clk_disable,
+	.of_xlate	= gen5_clk_of_xlate,
+};
+
+static int gen5_clk_probe(struct udevice *dev)
+{
+	struct gen5_clk_priv *priv = dev_get_priv(dev);
+	struct udevice *agent;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SCMI_AGENT, 0, &agent);
+	if (ret)
+		return ret;
+
+	if (!agent)
+		return -ENODEV;
+
+	priv->basever = scmi_impl_version(agent);
+
+	return uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(scmi_clock),
+					   &priv->clk);
+}
+#else
+static int gen5_clk_enable(struct clk *clk)
+{
+	return 0;
+}
+
+static int gen5_clk_disable(struct clk *clk)
+{
+	return 0;
+}
+
+static int gen5_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	clk->id = args->args[0];
+
+	return 0;
+}
+
+static const struct clk_ops gen5_clk_ops = {
+	.enable		= gen5_clk_enable,
+	.disable	= gen5_clk_disable,
+	.of_xlate	= gen5_clk_of_xlate,
+};
+#endif
+
+static const struct udevice_id r8a78000_mdlc_ids[] = {
+	{ .compatible = "renesas,r8a78000-cpg", },
+	{ }
+};
+
+U_BOOT_DRIVER(clk_gen5) = {
+	.name		= "clk_gen5",
+	.id		= UCLASS_CLK,
+	.of_match	= r8a78000_mdlc_ids,
+	.priv_auto	= CONFIG_IS_ENABLED(CLK_SCMI, (sizeof(struct gen5_clk_priv)), (0)),
+	.ops		= &gen5_clk_ops,
+	.probe		= CONFIG_IS_ENABLED(CLK_SCMI, (gen5_clk_probe), (NULL)),
+	.flags          = DM_FLAG_OS_PREPARE | DM_FLAG_VITAL,
+};
-- 
2.53.0

