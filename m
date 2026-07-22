Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDD4C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6588D608DC;
	Thu, 23 Jul 2026 00:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PItl3FThABJs; Thu, 23 Jul 2026 00:52:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87A78608C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767947;
	bh=AZMmtaueCoi388djaZM9F+2Y1pUpU8WEuVDrM1et1jk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ptFq0IYZLsiLygHPSSSv01J8L5ClLzWXC/S7Un5DOTPNcy7tVJ8JP+JmFilnup+MI
	 cIbX7uddcX8HJ2m24X15STcEbGlrZEcdkqLUu6hotpLCdSlD0wb374Az50gqavUcEQ
	 Z9MLXRARvdF6eXYADS2GbSUMP6+zoAKZH8DuJNgfHlv6Nwhqz9w23SYuZuGqE9xiVT
	 1vGCeZggBtFzMvgKbou6cElgdc4nbpcwvUjna3mpP3cUzyZOZK9bILtzIMAE8ddfKL
	 MIG6a7Esi3EofI506xBYBYO3SUXtE17yJZzr8yvFQDKQlriDK6pVVXArgioLuvXT7r
	 MgXxyFjfnZ6tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87A78608C5;
	Thu, 23 Jul 2026 00:52:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B96FB313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F9B4400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OCgDNRBV5rIE for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:14 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 575A540087
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 575A540087
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 575A540087
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CE284974; Wed, 22 Jul 2026 17:43:12 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1D0848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:43:09 +0200 (CEST)
X-CSE-ConnectionGUID: 5PVumhbPTFKS7fEtoezduw==
X-CSE-MsgGUID: V7A7K56oQmyyGDs+TpuPcw==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="61010803"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Jul 2026 08:43:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 08:43:06 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:43:04 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 3/6] rng: add Microchip PolarFire SoC hardware RNG driver
Date: Wed, 22 Jul 2026 16:45:46 +0100
Message-ID: <20260722154602.3373184-4-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784734990; x=1816270990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TR3lqq7MQIcXS8F2z8xPe19UDRG2kyS8MFmJ1UmdCdo=;
 b=tf6GnOBg5GYgsocX83WvbFJGXXbxBPdpFU2YZZ3n+876pinL7qa+TvvX
 ZWXpwWaKLCgetfpNg9iNWMo+bjd1DzQXFobBzwtGPk2++voeaELWK4o7e
 AU+WhTteaf50iEres0usLs7HaDOMpbvWWHZaJ1voHNU0xrPlZ91TzucaF
 6qSliucf3gLMPJtXzFdD/Bs4BRGbvhtNkkP/4WRVcQTwr6EePwq1CWlm1
 OoqtPii7MI+kLD5USB8XrWUVWjHm1cpu4VJ6+ZZ/dKBgGKv6xX7jJ9xt5
 UmIYf07+MHEE2Z/WLlQRbvq7bWNN54tkVfwSv6fA0rynTbjiC4vkGiyef
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=tf6GnOBg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="tf6GnOBg"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a U-Boot RNG driver for Microchip's PolarFire SoC (MPFS). The
hardware RNG is accessed indirectly via the MPFS system controller using
the mailbox interface.

The driver implements the UCLASS_RNG interface, requesting random data
from the system controller and returning it to the caller.

This allows use of the PolarFire SoC hardware RNG via the
standard 'rng' command and DM RNG API.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/rng/Kconfig    |   7 +++
 drivers/rng/Makefile   |   1 +
 drivers/rng/mpfs_rng.c | 101 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 drivers/rng/mpfs_rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 19b2b707677..856ffda2f5e 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -23,6 +23,13 @@ config RNG_MESON
 	  Enable support for hardware random number generator
 	  of Amlogic Meson SoCs.
 
+config RNG_MPFS
+	tristate "Microchip PolarFire SoC Random Number Generator support"
+	depends on DM_RNG && MPFS_SYSCONTROLLER
+	help
+	  Enable support for hardware random number generator
+	  of Microchip's PolarFire SoCs.
+
 config RNG_SANDBOX
 	bool "Sandbox random number generator"
 	depends on SANDBOX
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 30c58272d41..50622d4705f 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(PHASE_)DM_RNG) += rng-uclass.o
 obj-$(CONFIG_RNG_MESON) += meson-rng.o
+obj-$(CONFIG_RNG_MPFS) += mpfs_rng.o
 obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
 obj-$(CONFIG_RNG_MSM) += msm_rng.o
 obj-$(CONFIG_RNG_NPCM) += npcm_rng.o
diff --git a/drivers/rng/mpfs_rng.c b/drivers/rng/mpfs_rng.c
new file mode 100644
index 00000000000..820103a0202
--- /dev/null
+++ b/drivers/rng/mpfs_rng.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's PolarFire SoC (MPFS) System Controller Driver
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ *
+ * Author: Jamie Gibbons <jamie.gibbons@microchip.com>
+ *
+ */
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/printk.h>
+#include <mailbox.h>
+#include <malloc.h>
+#include <mpfs-mailbox.h>
+#include <rng.h>
+#include <string.h>
+
+#define CMD_OPCODE						0x21
+#define CMD_DATA_SIZE					0U
+#define CMD_DATA						NULL
+#define MBOX_OFFSET						0U
+#define RESP_OFFSET						0U
+#define RNG_RESP_BYTES					32U
+
+/**
+ * struct mpfs_rng_priv - Structure representing System Controller data.
+ * @mpfs_syscontroller_priv:	System Controller
+ */
+struct mpfs_rng_priv {
+	struct mpfs_syscontroller_priv *sys_controller;
+};
+
+static int mpfs_rng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct mpfs_rng_priv *rng_priv = dev_get_priv(dev);
+	u32 response_msg[RNG_RESP_BYTES / sizeof(u32)];
+	size_t count = 0, copy_size;
+	int ret;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = (u32 *)response_msg,
+		.resp_size = RNG_RESP_BYTES,
+	};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = CMD_OPCODE,
+		.cmd_data_size = CMD_DATA_SIZE,
+		.response = &response,
+		.cmd_data = CMD_DATA,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET,
+	};
+
+	while (count < len) {
+		ret = mpfs_syscontroller_run_service(rng_priv->sys_controller, &msg);
+		if (ret)
+			return ret;
+
+		ret = mpfs_syscontroller_recv_response(rng_priv->sys_controller, &msg, 1000);
+		if (ret)
+			return ret;
+
+		copy_size = (len - count > RNG_RESP_BYTES) ? RNG_RESP_BYTES : (len - count);
+		memcpy((u8 *)data + count, response_msg, copy_size);
+		count += copy_size;
+	}
+
+	return 0;
+}
+
+static int mpfs_rng_probe(struct udevice *dev)
+{
+	struct mpfs_rng_priv *rng_priv = dev_get_priv(dev);
+
+	rng_priv->sys_controller = mpfs_syscontroller_get(dev->parent);
+	if (IS_ERR(rng_priv->sys_controller)) {
+		dev_err(dev, "Failed to get system controller\n");
+		return PTR_ERR(rng_priv->sys_controller);
+	}
+
+	return 0;
+}
+
+static const struct dm_rng_ops mpfs_rng_ops = {
+	.read = mpfs_rng_read,
+};
+
+U_BOOT_DRIVER(mpfs_rng) = {
+	.name           = "mpfs_rng",
+	.id             = UCLASS_RNG,
+	.probe          = mpfs_rng_probe,
+	.priv_auto	    = sizeof(struct mpfs_rng_priv),
+	.ops            = &mpfs_rng_ops,
+};
-- 
2.43.0

