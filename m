Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361B8C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EFB849EE;
	Fri, 26 Jun 2026 23:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="k9AUrs8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F224884105; Fri, 26 Jun 2026 22:17:43 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B7383FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6300e006a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782505061; x=1814041061;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lVE+BD9YqM2zkxCcJ/h3javzbuODscxF6lKqAfNnC6g=;
 b=k9AUrs8AScgaXZOC4uA0Ay/x2SiG4qPhHz98jdAvkEDrMebhecHeHkrT
 a5tFZ8fxCqNoHe6NVzmZH2JayabgGxJ3Kq9PkjD2453BgdLlpNoTI198b
 JrSr06c0Q2Mcno3Bp+Rq6xR4GkB9jeulzGA9/cEMFMmV+qivT1raT5S1p
 sBa04SyX+rsV7h1hCSVATaKqbl9bwDhgANn8DlsWBMplyJrIMaVnCRxCY
 g8D0wOzTj8WlOGZHfRw4DXe5vPh/B48ulSylLCGtwlYcWE5qSdArGiDOo
 dtklFNA4nVmHd9EnPJxuhCncsx5xXSedIU8d5Y0WNIOg2UW/Uv63LzmnH w==;
X-CSE-ConnectionGUID: cVeUz46+Swy/llcUvVy4hw==
X-CSE-MsgGUID: mVav5+coSk+il0Gr4d5OxA==
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="60102578"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Jun 2026 13:17:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Jun 2026 13:17:38 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 13:17:23 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Philip Molloy
 <philip.molloy@analog.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 "Casey Connolly" <casey.connolly@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH 5/7] drivers: power: add support for RPMI power domains
Date: Fri, 26 Jun 2026 13:15:46 -0700
Message-ID: <20260626201613.1035208-6-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626201613.1035208-1-charles.perry@microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 26 Jun 2026 23:20:19 +0200
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

The RISC-V Platform Management Interface (RPMI) defines the device power
service group [1] that is used to control power domains. This is used to
implement a UCLASS_POWER_DOMAIN driver.

[1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.9)

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 MAINTAINERS                              |   1 +
 drivers/power/domain/Kconfig             |   7 +
 drivers/power/domain/Makefile            |   1 +
 drivers/power/domain/rpmi-power-domain.c | 229 +++++++++++++++++++++++
 include/rpmi_proto.h                     |  18 ++
 5 files changed, 256 insertions(+)
 create mode 100644 drivers/power/domain/rpmi-power-domain.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bf6582ef493..d2b18d9b13db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1694,6 +1694,7 @@ M:	Charles Perry <charles.perry@microchip.com>
 S:	Maintained
 F:	drivers/clk/clk_rpmi.c
 F:	drivers/firmware/rpmi/
+F:	drivers/power/domain/rpmi-power-domain.c
 F:	include/rpmi*
 
 SANDBOX
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 4112b777371d..e8484b193cad 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -106,6 +106,13 @@ config RENESAS_R8A78000_POWER_DOMAIN
 	  and reset driver. The MDLC is responsible for managing both
 	  power domains and resets on R-Car R8A78000 X5H SoC.
 
+config RPMI_POWER_DOMAIN
+	bool "Enable the RPMI Power domain driver"
+	depends on POWER_DOMAIN && RPMI_FIRMWARE
+	help
+	  Enable this option if you want to support power domains managed by
+	  the RISC-V Platform Management Interface (RPMI) protocol.
+
 config SANDBOX_POWER_DOMAIN
 	bool "Enable the sandbox power domain test driver"
 	depends on POWER_DOMAIN && SANDBOX
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 110153d5cf81..9c42160e18be 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
+obj-$(CONFIG_RPMI_POWER_DOMAIN) += rpmi-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
 obj-$(CONFIG_SCMI_POWER_DOMAIN) += scmi-power-domain.o
diff --git a/drivers/power/domain/rpmi-power-domain.c b/drivers/power/domain/rpmi-power-domain.c
new file mode 100644
index 000000000000..f00ebab86686
--- /dev/null
+++ b/drivers/power/domain/rpmi-power-domain.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <power-domain.h>
+#include <power-domain-uclass.h>
+#include <rpmi.h>
+#include <dm/device_compat.h>
+
+struct rpmi_get_num_pd_rx {
+	__le32 status;
+	__le32 num_pd;
+};
+
+struct rpmi_get_attrs_tx {
+	__le32 pd_id;
+};
+
+struct rpmi_get_attrs_rx {
+	__le32 status;
+	__le32 flags;
+	__le32 trans_latency;
+	char name[RPMI_DPWR_NAME_LEN];
+};
+
+struct rpmi_set_state_tx {
+	__le32 pd_id;
+	__le32 state;
+};
+
+struct rpmi_set_state_rx {
+	__le32 status;
+};
+
+struct rpmi_pd_def {
+	u32 transition_latency;
+	char name[RPMI_DPWR_NAME_LEN + 1];
+};
+
+struct rpmi_pd_priv {
+	struct rpmi_chan chan;
+	struct udevice *dev;
+	u32 num_pd;
+	struct rpmi_pd_def *defs;
+};
+
+static int rpmi_pd_get_attrs(struct rpmi_pd_priv *priv, u32 pd_id,
+			     struct rpmi_pd_def *def)
+{
+	struct rpmi_get_attrs_tx tx = {
+		.pd_id = cpu_to_le32(pd_id),
+	};
+	struct rpmi_get_attrs_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_DPWR_SRV_GET_ATTRIBUTES,
+				  &tx, sizeof(tx), &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	def->transition_latency = le32_to_cpu(rx.trans_latency);
+	memcpy(def->name, rx.name, RPMI_DPWR_NAME_LEN);
+	def->name[RPMI_DPWR_NAME_LEN] = '\0';
+
+	return 0;
+}
+
+static int rpmi_pd_set_state(struct rpmi_pd_priv *priv, u32 pd_id, u32 state)
+{
+	struct rpmi_set_state_tx tx = {
+		.pd_id = cpu_to_le32(pd_id),
+		.state = cpu_to_le32(state),
+	};
+	struct rpmi_set_state_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_DPWR_SRV_SET_DPWR_STATE,
+				  &tx, sizeof(tx), &rx, sizeof(rx), NULL);
+
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	return 0;
+}
+
+static int rpmi_power_domain_on(struct power_domain *power_domain)
+{
+	return rpmi_pd_set_state(dev_get_plat(power_domain->dev),
+				 power_domain->id, RPMI_DPWR_STATE_ON);
+}
+
+static int rpmi_power_domain_off(struct power_domain *power_domain)
+{
+	return rpmi_pd_set_state(dev_get_plat(power_domain->dev),
+				 power_domain->id, RPMI_DPWR_STATE_OFF);
+}
+
+static int rpmi_power_domain_xlate(struct power_domain *power_domain,
+				   struct ofnode_phandle_args *args)
+{
+	struct rpmi_pd_priv *priv = dev_get_plat(power_domain->dev);
+
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	if (args->args[0] >= priv->num_pd)
+		return -EINVAL;
+
+	power_domain->id = args->args[0];
+
+	return 0;
+}
+
+static int rpmi_pd_get_num_domains(struct rpmi_pd_priv *priv)
+{
+	struct rpmi_get_num_pd_rx rx;
+	int ret, status;
+
+	ret = rpmi_send_with_resp(&priv->chan, RPMI_DPWR_SRV_GET_NUM_DOMAINS,
+				  NULL, 0, &rx, sizeof(rx), NULL);
+	if (ret)
+		return ret;
+
+	status = le32_to_cpu(rx.status);
+	if (status)
+		return rpmi_to_linux_error(status);
+
+	priv->num_pd = le32_to_cpu(rx.num_pd);
+
+	return 0;
+}
+
+static int rpmi_pd_probe(struct udevice *dev)
+{
+	struct rpmi_pd_priv *priv = (struct rpmi_pd_priv *)dev_get_plat(dev);
+	struct rpmi_chan *chan = &priv->chan;
+	int ret, i;
+
+	priv->dev = dev;
+
+	ret = rpmi_open(chan);
+	if (ret)
+		return ret;
+
+	ret = rpmi_check_versions(chan, RPMI_MKVER(1, 0),
+				  RPMI_SRVGRP_DEVICE_POWER, RPMI_MKVER(1, 0));
+	if (ret)
+		goto err_out;
+
+	ret = rpmi_pd_get_num_domains(priv);
+	if (ret)
+		goto err_out;
+
+	priv->defs = calloc(priv->num_pd, sizeof(struct rpmi_pd_def));
+	if (!priv->defs) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < priv->num_pd; i++) {
+		ret = rpmi_pd_get_attrs(priv, i, &priv->defs[i]);
+		if (ret)
+			goto err_out;
+	}
+
+	dev_dbg(dev, "num pd = %i\n", priv->num_pd);
+
+	return 0;
+
+err_out:
+	if (priv->defs)
+		free(priv->defs);
+	rpmi_close(chan);
+
+	return ret;
+}
+
+static int rpmi_pd_remove(struct udevice *dev)
+{
+	struct rpmi_pd_priv *priv = (struct rpmi_pd_priv *)dev_get_plat(dev);
+	struct rpmi_chan *chan = &priv->chan;
+
+	if (priv->defs)
+		free(priv->defs);
+	rpmi_close(chan);
+
+	return 0;
+}
+
+static int rpmi_pd_to_plat(struct udevice *dev)
+{
+	struct rpmi_pd_priv *priv = (struct rpmi_pd_priv *)dev_get_plat(dev);
+
+	return rpmi_get_by_index(dev, 0, &priv->chan);
+}
+
+static const struct power_domain_ops rpmi_pd_ops = {
+	.of_xlate = rpmi_power_domain_xlate,
+	.on = rpmi_power_domain_on,
+	.off = rpmi_power_domain_off,
+};
+
+static const struct udevice_id rpmi_pd_ids[] = {
+	{ .compatible = "riscv,rpmi-device-power" },
+	{}
+};
+
+U_BOOT_DRIVER(rpmi_pd) = {
+	.name = "rpmi-device-power",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = rpmi_pd_ids,
+	.probe = rpmi_pd_probe,
+	.remove = rpmi_pd_remove,
+	.ops = &rpmi_pd_ops,
+	.of_to_plat = rpmi_pd_to_plat,
+	.plat_auto = sizeof(struct rpmi_pd_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/rpmi_proto.h b/include/rpmi_proto.h
index dc0937ce7053..d2512617f75c 100644
--- a/include/rpmi_proto.h
+++ b/include/rpmi_proto.h
@@ -122,4 +122,22 @@ enum rpmi_clock_type {
 
 #define RPMI_CLOCK_RATE_INVALID		(-1ULL)
 
+/* RPMI Device_Power (DPWR) service IDs */
+enum rpmi_dpwr_service_id {
+	RPMI_DPWR_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_DPWR_SRV_GET_NUM_DOMAINS = 0x02,
+	RPMI_DPWR_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_DPWR_SRV_SET_DPWR_STATE = 0x04,
+	RPMI_DPWR_SRV_GET_DPWR_STATE = 0x05,
+	RPMI_DPWR_SRV_ID_MAX,
+};
+
+enum rpmi_dpwr_state {
+	RPMI_DPWR_STATE_INVALID = -1,
+	RPMI_DPWR_STATE_ON = 0,
+	RPMI_DPWR_STATE_OFF = 3,
+};
+
+#define RPMI_DPWR_NAME_LEN 16
+
 #endif
-- 
2.47.3

