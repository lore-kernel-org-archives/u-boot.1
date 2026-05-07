Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D11ACD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC74F84C19;
	Fri,  8 May 2026 01:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SsHw4SSR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mKgnY5Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A26D84C18; Fri,  8 May 2026 01:24:48 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDD484B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBSyQ0XSqz9ttL;
 Fri,  8 May 2026 01:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LAM/tfYaICjijClZ9aRtAkeT4Gbz4OQMfGAtWwFFm4=;
 b=SsHw4SSRLRqXvUWqD0Ac9Nx6Y+122UAR3gYnKlXbgeGzkKPcDKM+km/hltnaTaNY5H6xfa
 UKQcj42LPtgQ9ESN3OSxjoibjswKda5e0oaRi8egxO6jQCXpOfWpCn5NeSsZhE5Nn3V0jr
 cG38DCBHuoKDqrigpHV9MkemMPk3RbnvhEVEYhtSztYSgCybbcoWjih8jJejtUSxSxRT/D
 pULQP+pExwlg514oz8MP5KKXzgWfE6ciL2UgybMl+T+vggIlBcI/GL5GDaPtgrTvSp9mhJ
 LaD1sn0Ks/6AJ7GsTGmeC0dLyoI9tvmK7keKW1k26CUBJGAaAZyUkcYgx9OmlA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mKgnY5Jl;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LAM/tfYaICjijClZ9aRtAkeT4Gbz4OQMfGAtWwFFm4=;
 b=mKgnY5Jla4Saath5nRz7MH4vQqODMBa4ac/8b+AxgNxMz+AObgRbBxyWJevnfUtq+SnyEb
 eroM1rMe9X0rXZPi6ecEowoLvNwO/8Ss7rKQld9DIP/54OiRs8algYAGJZ9LQ9JyS5mzIj
 1jILSVT59oyaHeFFkU1QcQ0v1EbCif1ar42Z0du7Ah7YPG8njbGT7R9qG4iG3/AkHv6xSd
 fHh0lnQBXU1QMBwdZoQBQp1W/W8Jqa8y5OnI1otiVaxpVrXxr+L0iXocoEB0YMLkRwRzvI
 BEDl34ye+nmHw96x9AGv1BHLiYXglsc+ZacD26TG6PSzlYA4EK++gp4y2/GPjA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] power: domain: Add Renesas R-Car R8A78000 X5H MDLC power
 domain and reset driver
Date: Fri,  8 May 2026 01:23:30 +0200
Message-ID: <20260507232424.304154-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
References: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wqae4q1u4jgbbrhhaha1oyr7o8ta6ejf
X-MBO-RS-ID: 293409cb59f93e3b29d
X-Rspamd-Queue-Id: 4gBSyQ0XSqz9ttL
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

Add Renesas R-Car R8A78000 X5H MDLC power domain and reset driver,
which serves as a remap driver between DT power domain and reset IDs
and SCMI power domain and reset IDs in case U-Boot runs on Cortex-A,
and as a direct hardware access driver for RSIP.

The R-Car X5H SCP firmware uses different SCMI power domain and
reset IDs in different versions of the SCP firmware, which makes
this remapping necessary. The SCMI base protocol version is updated
for each new SCP firmware version, it is therefore possible to
determine which SCP firmware version is running on the platform
from the base protocol and then determine which remapping table to
use for DT power domain and reset ID to SCMI power domain and reset
ID remapping.

Currently supported versions are SCP 4.28, 4.31, 4.32 .

The DT power domain and reset ID to SCMI power domain and reset ID
remap and call mechanism is simple. Unlike SCMI clock protocol driver,
the SCMI reset and power domain protocol drivers register only a single
device. This driver looks up that single device, obtains its reset or
power domain ops, sets up struct reset_ctl or struct power_domain with
remapped SCMI ID, and invokes operations directly on the device.

In case of RSIP, all power domains are already enabled by BootROM or
early SoC initialization code, the driver therefore only acts as a
stub for the power domain part. The reset part operates as a direct
hardware access reset driver.

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
 drivers/power/domain/Kconfig                  |   8 +
 drivers/power/domain/Makefile                 |   1 +
 .../domain/renesas-r8a78000-power-domain.c    | 427 ++++++++++++++++++
 3 files changed, 436 insertions(+)
 create mode 100644 drivers/power/domain/renesas-r8a78000-power-domain.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 012d7762384..4112b777371 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -98,6 +98,14 @@ config QCOM_RPMH_POWER_DOMAIN
 	  The RPMH power domain driver is responsible for managing power
 	  domains on Qualcomm SoCs.
 
+config RENESAS_R8A78000_POWER_DOMAIN
+	bool "Enable the Renesas R-Car MDLC Power domain and reset driver"
+	depends on POWER_DOMAIN && ARCH_RENESAS
+	help
+	  Enable support for Renesas R-Car R8A78000 X5H MDLC Power domain
+	  and reset driver. The MDLC is responsible for managing both
+	  power domains and resets on R-Car R8A78000 X5H SoC.
+
 config SANDBOX_POWER_DOMAIN
 	bool "Enable the sandbox power domain test driver"
 	depends on POWER_DOMAIN && SANDBOX
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index f373fc01395..110153d5cf8 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
+obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
 obj-$(CONFIG_SCMI_POWER_DOMAIN) += scmi-power-domain.o
diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
new file mode 100644
index 00000000000..d621373f90d
--- /dev/null
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas R-Car Gen5 MDLC driver
+ *
+ * Copyright (C) 2026 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <power-domain-uclass.h>
+#include <reset-uclass.h>
+
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
+
+#include <dt-bindings/power/r8a78000-power-scmi.h>
+#include <dt-bindings/reset/r8a78000-reset-scmi.h>
+
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
+#define PKC_PROT_LOCK			0xa5a5a500
+#define PKC_PROT_UNLOCK			0xa5a5a501
+
+#define MDLC_MSRESS_STANDBY		0
+#define MDLC_MSRESS_RESET		1
+#define MDLC_MSRESS_STOP		2
+#define MDLC_MSRESS_RUN			3
+
+#define MDLC_MSRES00			0x900
+#define MDLC_MSRESS00			0x960
+#define MDLC_PKCPROT1			0xcf4
+
+struct gen5_mdlc_priv {
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
+	struct udevice	*pd;
+#endif
+#if IS_ENABLED(CONFIG_RESET_SCMI)
+	struct udevice	*rst;
+#endif
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN) || IS_ENABLED(CONFIG_RESET_SCMI)
+	u32		basever;
+#endif
+#if !IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN) && !IS_ENABLED(CONFIG_RESET_SCMI)
+	void __iomem	*base;
+#endif
+};
+
+static int gen5_pd_of_xlate(struct power_domain *power_domain,
+			    struct ofnode_phandle_args *args)
+{
+	/* Perform direct remap until the bindings stabilize. */
+	power_domain->id = args->args[0];
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN)
+static int gen5_pd_on(struct power_domain *power_domain)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(power_domain->dev->parent);
+	struct power_domain_ops *ops = (struct power_domain_ops *)priv->pd->driver->ops;
+	struct power_domain scmi = {
+		.dev = priv->pd,
+		.id = power_domain->id
+	};
+
+	return ops->on(&scmi);
+}
+
+static int gen5_pd_off(struct power_domain *power_domain)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(power_domain->dev->parent);
+	struct power_domain_ops *ops = (struct power_domain_ops *)priv->pd->driver->ops;
+	struct power_domain scmi = {
+		.dev = priv->pd,
+		.id = power_domain->id
+	};
+
+	return ops->off(&scmi);
+}
+
+static const struct power_domain_ops pd_gen5_ops = {
+	.on = gen5_pd_on,
+	.off = gen5_pd_off,
+	.of_xlate = gen5_pd_of_xlate,
+};
+
+static int gen5_pd_probe(struct udevice *dev)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(dev->parent);
+	struct udevice *agent;
+	int ret;
+
+	if (!priv->basever) {
+		ret = uclass_get_device(UCLASS_SCMI_AGENT, 0, &agent);
+		if (ret)
+			return ret;
+
+		if (!agent)
+			return -ENODEV;
+
+		priv->basever = scmi_impl_version(agent);
+	}
+
+	return uclass_get_device_by_driver(UCLASS_POWER_DOMAIN,
+					   DM_DRIVER_GET(scmi_power_domain),
+					   &priv->pd);
+}
+
+U_BOOT_DRIVER(pd_gen5) = {
+	.name		= "pd_gen5",
+	.id		= UCLASS_POWER_DOMAIN,
+	.ops		= &pd_gen5_ops,
+	.probe		= gen5_pd_probe,
+	.flags		= DM_FLAG_OS_PREPARE | DM_FLAG_VITAL,
+};
+#else
+static const struct power_domain_ops pd_gen5_ops = {
+	.of_xlate = gen5_pd_of_xlate,
+};
+
+U_BOOT_DRIVER(pd_gen5) = {
+	.name		= "pd_gen5",
+	.id		= UCLASS_POWER_DOMAIN,
+	.ops		= &pd_gen5_ops,
+	.flags		= DM_FLAG_OS_PREPARE | DM_FLAG_VITAL,
+};
+#endif
+
+#if IS_ENABLED(CONFIG_RESET_SCMI)
+static int gen5_reset_assert(struct reset_ctl *reset_ctl)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(reset_ctl->dev->parent);
+	struct reset_ops *ops = (struct reset_ops *)priv->rst->driver->ops;
+	struct reset_ctl scmi = {
+		.dev = priv->rst,
+		.id = reset_ctl->id
+	};
+
+	return ops->rst_assert(&scmi);
+}
+
+static int gen5_reset_deassert(struct reset_ctl *reset_ctl)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(reset_ctl->dev->parent);
+	struct reset_ops *ops = (struct reset_ops *)priv->rst->driver->ops;
+	struct reset_ctl scmi = {
+		.dev = priv->rst,
+		.id = reset_ctl->id
+	};
+
+	return ops->rst_deassert(&scmi);
+}
+
+struct rst_map_in {
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
+static const struct rst_map_in gen5_rst_map_dt_sdk_4_28[] = {
+	{ SCP_RESET_DOMAIN_ID_UFS0, 202 },
+	{ SCP_RESET_DOMAIN_ID_UFS1, 203 },
+	{ SCP_RESET_DOMAIN_ID_XPCS0, 316 },
+	{ SCP_RESET_DOMAIN_ID_XPCS1, 317 },
+	{ SCP_RESET_DOMAIN_ID_XPCS2, 318 },
+	{ SCP_RESET_DOMAIN_ID_XPCS3, 319 },
+	{ SCP_RESET_DOMAIN_ID_XPCS4, 320 },
+	{ SCP_RESET_DOMAIN_ID_XPCS5, 321 },
+	{ SCP_RESET_DOMAIN_ID_XPCS6, 322 },
+	{ SCP_RESET_DOMAIN_ID_XPCS7, 323 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY01, 344 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY11, 345 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY21, 346 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY31, 347 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY02, 348 },
+};
+
+static const struct rst_map_in gen5_rst_map_dt_sdk_4_31[] = {
+	{ SCP_RESET_DOMAIN_ID_UFS0, 198 },
+	{ SCP_RESET_DOMAIN_ID_UFS1, 199 },
+	{ SCP_RESET_DOMAIN_ID_XPCS0, 312 },
+	{ SCP_RESET_DOMAIN_ID_XPCS1, 313 },
+	{ SCP_RESET_DOMAIN_ID_XPCS2, 314 },
+	{ SCP_RESET_DOMAIN_ID_XPCS3, 315 },
+	{ SCP_RESET_DOMAIN_ID_XPCS4, 316 },
+	{ SCP_RESET_DOMAIN_ID_XPCS5, 317 },
+	{ SCP_RESET_DOMAIN_ID_XPCS6, 318 },
+	{ SCP_RESET_DOMAIN_ID_XPCS7, 319 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY01, 340 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY11, 341 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY21, 342 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY31, 343 },
+	{ SCP_RESET_DOMAIN_ID_MPPHY02, 344 },
+};
+
+static int gen5_reset_of_xlate(struct reset_ctl *reset_ctl,
+			       struct ofnode_phandle_args *args)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(reset_ctl->dev->parent);
+	const struct rst_map_in *map;
+	unsigned int map_size;
+	int i;
+
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (priv->basever == GEN5_SCMI_SDK_4_28) {
+		map = gen5_rst_map_dt_sdk_4_28;
+		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_28);
+	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
+		   priv->basever == GEN5_SCMI_SDK_4_32) {
+		map = gen5_rst_map_dt_sdk_4_31;
+		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_31);
+	} else {
+		printf("Unsupported SCMI base protocol version %x\n", priv->basever);
+		return -EINVAL;
+	}
+
+	reset_ctl->id = -1;
+	for (i = 0; i < map_size; i++) {
+		if (map[i].dt_id != args->args[0])
+			continue;
+		reset_ctl->id = map[i].fw_id;
+		break;
+	}
+
+	return 0;
+}
+
+static const struct reset_ops rst_gen5_ops = {
+	.rst_assert = gen5_reset_assert,
+	.rst_deassert = gen5_reset_deassert,
+	.of_xlate = gen5_reset_of_xlate,
+};
+
+static int gen5_rst_probe(struct udevice *dev)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(dev->parent);
+	struct udevice *agent;
+	int ret = 0;
+
+	if (!priv->basever) {
+		ret = uclass_get_device(UCLASS_SCMI_AGENT, 0, &agent);
+		if (ret)
+			return ret;
+
+		if (!agent)
+			return -ENODEV;
+
+		priv->basever = scmi_impl_version(agent);
+	}
+
+	return uclass_get_device_by_driver(UCLASS_RESET,
+					   DM_DRIVER_GET(scmi_reset_domain),
+					   &priv->rst);
+}
+#else
+static int mdlc_wait_for_reset(struct reset_ctl *reset_ctl)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(reset_ctl->dev->parent);
+	const u32 offset = (reset_ctl->id / 16) * 4;
+	void __iomem *res = priv->base + MDLC_MSRES00 + offset;
+	void __iomem *stat = priv->base + MDLC_MSRESS00 + offset;
+	u32 val;
+	int ret;
+
+	/* Wait 100ms for reset controller to synchronize. */
+	ret = readl_poll_timeout(res, val, val == readl(stat), 100000);
+	if (ret < 0)
+		dev_err(reset_ctl->dev, "Reset controller out of sync!\n");
+
+	return ret;
+}
+
+static void mdlc_rmw_msres(struct reset_ctl *reset_ctl, const int val)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(reset_ctl->dev->parent);
+	const u32 offset = (reset_ctl->id / 16) * 4;
+	const u32 mask = 3 << ((reset_ctl->id % 16) * 2);
+	void __iomem *prot = priv->base + MDLC_PKCPROT1;
+	void __iomem *res = priv->base + MDLC_MSRES00 + offset;
+	u32 reg;
+
+	reg = readl(res);
+	reg &= ~mask;
+	reg |= field_prep(mask, val);
+
+	writel(PKC_PROT_UNLOCK, prot);
+	writel(reg, res);
+	writel(PKC_PROT_LOCK, prot);
+}
+
+static int gen5_reset_toggle(struct reset_ctl *reset_ctl, const u8 step1,
+			     const u8 step2, const u8 step3, const u8 step4)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(reset_ctl->dev->parent);
+	const u32 offset = (reset_ctl->id / 16) * 4;
+	const u32 mask = 3 << ((reset_ctl->id % 16) * 2);
+	void __iomem *stat = priv->base + MDLC_MSRESS00 + offset;
+	u32 status;
+	int ret;
+
+	ret = mdlc_wait_for_reset(reset_ctl);
+	if (ret)
+		return ret;
+
+	status = field_get(mask, readl(stat));
+	if (status == step1) {
+		mdlc_rmw_msres(reset_ctl, step2);
+		ret = mdlc_wait_for_reset(reset_ctl);
+		if (ret)
+			return ret;
+		status = field_get(mask, readl(stat));
+	}
+
+	if (status == step2 || status == step3) {
+		mdlc_rmw_msres(reset_ctl, step4);
+		ret = mdlc_wait_for_reset(reset_ctl);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int gen5_reset_assert(struct reset_ctl *reset_ctl)
+{
+	return gen5_reset_toggle(reset_ctl,
+				 MDLC_MSRESS_STOP, MDLC_MSRESS_STANDBY,
+				 MDLC_MSRESS_RUN, MDLC_MSRESS_RESET);
+}
+
+static int gen5_reset_deassert(struct reset_ctl *reset_ctl)
+{
+	return gen5_reset_toggle(reset_ctl,
+				 MDLC_MSRESS_STANDBY, MDLC_MSRESS_RESET,
+				 MDLC_MSRESS_STOP, MDLC_MSRESS_RUN);
+}
+
+static int gen5_reset_of_xlate(struct reset_ctl *reset_ctl,
+			       struct ofnode_phandle_args *args)
+{
+	/* Perform direct remap until the bindings stabilize. */
+	reset_ctl->id = args->args[0];
+
+	return 0;
+}
+
+static const struct reset_ops rst_gen5_ops = {
+	.rst_assert = gen5_reset_assert,
+	.rst_deassert = gen5_reset_deassert,
+	.of_xlate = gen5_reset_of_xlate,
+};
+
+static int gen5_rst_probe(struct udevice *dev)
+{
+	struct gen5_mdlc_priv *priv = dev_get_priv(dev->parent);
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	return 0;
+}
+#endif
+
+U_BOOT_DRIVER(rst_gen5) = {
+	.name		= "rst_gen5",
+	.id		= UCLASS_RESET,
+	.ops		= &rst_gen5_ops,
+	.probe		= gen5_rst_probe,
+	.flags		= DM_FLAG_OS_PREPARE | DM_FLAG_VITAL,
+};
+
+int gen5_mdlc_bind(struct udevice *parent)
+{
+	struct udevice *pdev, *rdev;
+	struct driver *pdrv, *rdrv;
+	int ret;
+
+	pdrv = lists_driver_lookup_name("pd_gen5");
+	if (!pdrv)
+		return -ENOENT;
+
+	rdrv = lists_driver_lookup_name("rst_gen5");
+	if (!rdrv)
+		return -ENOENT;
+
+	ret = device_bind_with_driver_data(parent, pdrv, "pd_gen5", 0,
+					   dev_ofnode(parent), &pdev);
+	if (ret)
+		return ret;
+
+	ret = device_bind_with_driver_data(parent, rdrv, "rst_gen5", (ulong)pdev,
+					   dev_ofnode(parent), &rdev);
+	if (ret)
+		device_unbind(pdev);
+
+	return ret;
+}
+
+static const struct udevice_id r8a78000_mdlc_ids[] = {
+	{ .compatible = "renesas,r8a78000-mdlc", },
+	{ }
+};
+
+U_BOOT_DRIVER(mdlc_gen5) = {
+	.name		= "mdlc_gen5",
+	.id		= UCLASS_NOP,
+	.of_match	= r8a78000_mdlc_ids,
+	.bind		= gen5_mdlc_bind,
+	.priv_auto	= sizeof(struct gen5_mdlc_priv),
+};
-- 
2.53.0

