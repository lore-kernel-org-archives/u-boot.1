Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MV0oqJ1O;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Uh+CWyUL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB2AE60783;
	Mon, 23 Nov 2026 14:23:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M9g_lOQ-ljhh; Mon, 23 Nov 2026 14:23:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B7F0605FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443791;
	b=OaKHKfpd/u/btD5orajv1E3DoVKLMfka1NXatUojdJ2LIdUDZRWpUld4PrPvuxKou7Zz
	 9+jL3A5eswHGFMAY2ymiGrEFS5wm7ZoyQVjonibC6ptBrf/h020shhBlPftubfUTzj945
	 QqZZBDB2rR7LQlfJMgLCco1zGGzPQwVP/Bt6Ht/8j1WOT6bOQA7vz9IHhSu3F25QPkNiI
	 Qx01Rvz1zkTTIFErnfx1JHuRsGXosaqb3LviivJiZp57Okw9cHlmp5rKydWyxVf9FVJIS
	 90xP7lhvRjJfORnd5LMx7oiH35cQLPgkoSNHdl56s+aieg9dbFZbZjY3xsYybBD4SGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D+Mm1kwxMGH5unkJ+QlBLJDqq/zG/HmMMbI93UsUWNw=;
	b=J0efTfuEf9rjykF630ZhzYyCOFFydU947bgeUFqhee9fuRCsFAwT6UNqDEzi6DKhRtZL
	 AxlrN2iUhqBBoLcco4Marc7jWYkFHjV8upHxGOEh31XxcMvFoGAG/EjROxXqnyg5miWMf
	 CblG/oQqu7pFQD5gkmhjxwTBEGrTUZv9Ci1Z+/lt2nhgGkAYVTmA/K4hga9kH1KYocGGR
	 jo09DPkgKrHEnlHH9vvdanO/lOBRsWWpMbiS9JBY+o5C3bURW3P7FXRvjt07x8+tnmrWA
	 n2xcbaTsmWo/iTSFRqss2wEvTNIlqBaDo9o0O+4OqW6KE4YeW8wcvtwYfv7T5JBOJPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443791;
	bh=D+Mm1kwxMGH5unkJ+QlBLJDqq/zG/HmMMbI93UsUWNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MV0oqJ1OdR4D31TwTrkykkxxaig7Jv8Kl7rZJ7a+AXwnQPAb8i410jr27I2foBQaW
	 Di8KGvofu/B3qEeT/O1MKU0oc6JznalJsiw4GdBeW5UhOJdkS2kr9ir4jXbF3YvP1e
	 ecHb2rSwbNbQwTt1tATWjWgRtzmgZW6PvB2OYvNUnF0QlXLo5/LBhMfhLVDF801m07
	 OT5XvNTRG9V7GJDegMhrX/ZiLuJwO9bSiPwapSArxzYsTRzuGusosWvtPfY0ukWbTc
	 XPRxbqBMot+2uR6cJJP91LULpmdTmDWJG1wxxOXWzw3aGziSC5sDkupAp7EEyTjzzI
	 1D0lzO6bZLNGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B7F0605FF;
	Mon, 23 Nov 2026 14:23:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4529B260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B06A400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0EKSuekG1LB for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E2FA140060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Uh+CWyUL
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2FA140060
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2C0ADC6914A;
 Mon, 23 Nov 2026 14:23:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1CB88601E1;
 Mon, 23 Nov 2026 14:23:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F269A11E68F3D; Mon, 23 Nov 2026 15:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=D+Mm1kwxMGH5unkJ+QlBLJDqq/zG/HmMMbI93UsUWNw=;
 b=Uh+CWyULnGYXTRrH0UF66Fh5iV2x1d5K+o+vTnQqXYnuHGaAeZDjVzoSldETbcYEozHrr4
 U0UK+GkphEIWGvOoRGkXdk6ULDQdznkVpGMvf+jXDTUcAJiA0IUz5js0JtkE5UBOnfAWJq
 AMcOY/Jn4mm8Mx/ZGj4Y2kWMz9/DA0wwiOcMytX1M/MBKnmscAdCkiFKi5R/UNsg6KhvGx
 98IRdktU4D8BdOEJvYx9wg+UCbhQSJR30RkwjOniIrbWS1SqlDIuAlYaJ28umORSbfg56y
 MOsucBULO1he8VG/WF+oHGgU3qsleB1eWsN87NkdDb03+dVC7/7cHZIuA65C2A==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:03 +0100
Subject: [PATCH v2 4/8] soc: synaptics: add sl2610 system controller
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sl2619_base-v2-4-9e3b28c77cda@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
In-Reply-To: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce Synaptics sl2610 family system controller driver.

The code is based on Linux driver by Jisheng Zhang:
https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/

Creates and binds the clock, reset and pin controller platform devices
implemented by each SL2610 system control block.
The platform device driver gets the block id (muc, soc, avio or cpu) as
argument to select the appropriate private data.

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 drivers/soc/Kconfig                   |   1 +
 drivers/soc/Makefile                  |   1 +
 drivers/soc/synaptics/Kconfig         |  11 ++++
 drivers/soc/synaptics/Makefile        |   2 +
 drivers/soc/synaptics/sl2610-syscon.c | 118 ++++++++++++++++++++++++++++++++++
 include/soc/synaptics/sl2610-syscon.h |  23 +++++++
 6 files changed, 156 insertions(+)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 8ef408d9ba1b..0d5990cdc381 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -50,6 +50,7 @@ config SOC_XILINX_VERSAL_NET
 
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/samsung/Kconfig"
+source "drivers/soc/synaptics/Kconfig"
 source "drivers/soc/ti/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 00e6a5ac8e2b..de28c93160d5 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
 obj-$(CONFIG_SOC_QCOM) += qcom/
 obj-$(CONFIG_SOC_SAMSUNG) += samsung/
+obj-$(CONFIG_SYNAPTICS_SL2619) += synaptics/
 obj-$(CONFIG_SOC_TI) += ti/
 obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
 obj-$(CONFIG_SOC_DEVICE_TI_K3) += soc_ti_k3.o
diff --git a/drivers/soc/synaptics/Kconfig b/drivers/soc/synaptics/Kconfig
new file mode 100644
index 000000000000..ae1c1e519cb5
--- /dev/null
+++ b/drivers/soc/synaptics/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SOC_SL2610_SYSCON
+	bool "Synaptics SL2610 system controller"
+	depends on ARCH_SYNAPTICS && OF_CONTROL && SYSCON
+	help
+	  Support the global and control register blocks on Synaptics SL2610
+	  SoCs. This binds the clock, reset and pin controllers provided by
+	  each register block.
+
+	  Say Y here to enable access to these functions on SL2610 systems.
diff --git a/drivers/soc/synaptics/Makefile b/drivers/soc/synaptics/Makefile
new file mode 100644
index 000000000000..13710fc58903
--- /dev/null
+++ b/drivers/soc/synaptics/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SOC_SL2610_SYSCON) += sl2610-syscon.o
diff --git a/drivers/soc/synaptics/sl2610-syscon.c b/drivers/soc/synaptics/sl2610-syscon.c
new file mode 100644
index 000000000000..60a141542517
--- /dev/null
+++ b/drivers/soc/synaptics/sl2610-syscon.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * Author: Richard Genoud <richard.genoud@bootlin.com>
+ *
+ * From Linux: drivers/soc/synaptics/sl2610-syscon.c
+ *    Copyright (C) 2026 Synaptics Incorporated
+ *    Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <linux/kernel.h>
+#include <soc/synaptics/sl2610-syscon.h>
+
+/**
+ * struct sl2610_syscon_cell - description of a system controller sub-device
+ * @drv_name: name of the U-Boot driver to bind the sub-device to
+ * @block: register block the sub-device belongs to, passed as driver data
+ */
+struct sl2610_syscon_cell {
+	const char *drv_name;
+	enum sl2610_syscon_block block;
+};
+
+struct sl2610_syscon_data {
+	const struct sl2610_syscon_cell *cells;
+	unsigned int num_cells;
+};
+
+static const struct sl2610_syscon_cell sl2610_soc_cells[] = {
+	{ "syna-sl2610-soc-clk",	SL2610_SYSCON_BLOCK_SOC },
+	{ "sl2610-reset",		SL2610_SYSCON_BLOCK_SOC },
+	{ "syna-pinctrl",		SL2610_SYSCON_BLOCK_SOC },
+};
+
+static const struct sl2610_syscon_cell sl2610_mcu_cells[] = {
+	{ "syna-sl2610-system-clk",	SL2610_SYSCON_BLOCK_MCU },
+	{ "sl2610-reset",		SL2610_SYSCON_BLOCK_MCU },
+	{ "syna-pinctrl",		SL2610_SYSCON_BLOCK_MCU },
+};
+
+static const struct sl2610_syscon_cell sl2610_avio_cells[] = {
+	{ "syna-sl2610-aio-clk",	SL2610_SYSCON_BLOCK_AVIO },
+};
+
+static const struct sl2610_syscon_cell sl2610_cpu_cells[] = {
+	{ "syna-sl2610-cpu-clk",	SL2610_SYSCON_BLOCK_CPU },
+};
+
+static const struct sl2610_syscon_data sl2610_soc_data = {
+	.cells = sl2610_soc_cells,
+	.num_cells = ARRAY_SIZE(sl2610_soc_cells),
+};
+
+static const struct sl2610_syscon_data sl2610_mcu_data = {
+	.cells = sl2610_mcu_cells,
+	.num_cells = ARRAY_SIZE(sl2610_mcu_cells),
+};
+
+static const struct sl2610_syscon_data sl2610_avio_data = {
+	.cells = sl2610_avio_cells,
+	.num_cells = ARRAY_SIZE(sl2610_avio_cells),
+};
+
+static const struct sl2610_syscon_data sl2610_cpu_data = {
+	.cells = sl2610_cpu_cells,
+	.num_cells = ARRAY_SIZE(sl2610_cpu_cells),
+};
+
+static int sl2610_syscon_bind(struct udevice *dev)
+{
+	const struct sl2610_syscon_data *data =
+		(const struct sl2610_syscon_data *)dev_get_driver_data(dev);
+	const struct sl2610_syscon_cell *cell;
+	struct driver *drv;
+	int ret;
+	int i;
+
+	for (i = 0; i < data->num_cells; i++) {
+		cell = &data->cells[i];
+
+		drv = lists_driver_lookup_name(cell->drv_name);
+		if (!drv) {
+			dev_err(dev, "cannot find driver '%s'\n", cell->drv_name);
+			return -ENOENT;
+		}
+
+		ret = device_bind_with_driver_data(dev, drv, cell->drv_name,
+						   cell->block, dev_ofnode(dev),
+						   NULL);
+		if (ret) {
+			dev_err(dev, "cannot bind '%s': %d\n",
+				cell->drv_name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct udevice_id sl2610_syscon_of_match[] = {
+	{ .compatible = "syna,sl2610-soc-syscon", .data = (ulong)&sl2610_soc_data },
+	{ .compatible = "syna,sl2610-mcu-syscon", .data = (ulong)&sl2610_mcu_data },
+	{ .compatible = "syna,sl2610-avio-syscon", .data = (ulong)&sl2610_avio_data },
+	{ .compatible = "syna,sl2610-cpu-syscon", .data = (ulong)&sl2610_cpu_data },
+	{ }
+};
+
+U_BOOT_DRIVER(sl2610_syscon) = {
+	.name		= "sl2610-syscon",
+	.id		= UCLASS_NOP,
+	.of_match	= sl2610_syscon_of_match,
+	.bind		= sl2610_syscon_bind,
+};
diff --git a/include/soc/synaptics/sl2610-syscon.h b/include/soc/synaptics/sl2610-syscon.h
new file mode 100644
index 000000000000..e192b9043370
--- /dev/null
+++ b/include/soc/synaptics/sl2610-syscon.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ */
+
+#ifndef __SOC_SYNAPTICS_SL2610_SYSCON_H__
+#define __SOC_SYNAPTICS_SL2610_SYSCON_H__
+
+/*
+ * The SL2610 SoC has several system controller register blocks. Each block
+ * bundles a set of sub-devices (clock, reset, pin controller). The block
+ * identity is passed as driver data when the system controller binds its
+ * sub-devices, and lets each sub-device driver select the register layout it
+ * has to use.
+ */
+enum sl2610_syscon_block {
+	SL2610_SYSCON_BLOCK_SOC,
+	SL2610_SYSCON_BLOCK_MCU,
+	SL2610_SYSCON_BLOCK_AVIO,
+	SL2610_SYSCON_BLOCK_CPU,
+};
+
+#endif /* __SOC_SYNAPTICS_SL2610_SYSCON_H__ */

-- 
2.55.0

