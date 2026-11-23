Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A1606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZV0GxeMp;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WDhH4dRE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FEE26079B;
	Mon, 23 Nov 2026 14:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKKzUya7jk_f; Mon, 23 Nov 2026 14:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 254C16078A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443803;
	b=dXqEYuH9zhpxUhId7XdmGGjmOG2I5Lf1Y0Bgr2DIJmPiI3DlehPIizT4rxGuRxz/PyLy
	 ny0RL4TktHmom0dub8zMNLk0cMwAwNwXx4BNRe9dotFChFefYoAnKZ1N4y4VXGP3iBuXH
	 Gq4/UlxITxJ4WksuYSZUKJwvb0rh7rFbYQWtxFF98GOFY+3BDTVRLpYJCLlOwqo9HDiKZ
	 6yNmVsY+1IBSv3TFk+yV4se0q0Q4yhnTyJmNPDdTrDwz92AB0IpUleEZegXfKUMkxsbQ9
	 9/96/LKv4RWPn1VOoVHJ6mUctZ2al1eVliaHGaNH/1C0EO4erTbH42vO9t8VyJI567Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SfiofeSrrfZ77fzf6EIfT5gp6ax/ReWAfo5Xaye5bLE=;
	b=dTqom9RZIfiJucki3Zxb428rr3MIFVMo7EvR/dacZP61wElMb7wAjuu18jQWnsZd6clp
	 bQWkcarnzPhMrUTsGx9IriTaiDOx1cGDoRDoSk5LrCP7TEGsmZ8DZ6i+M9YSbnFE1zzwa
	 Ua40I31xujacAwGnEPJQlrbmjdpCyrdPUnWrnYyhkYnu5cpvr0TkJY19Mwa/xsfIUW5bq
	 L7Io+TYqZTm8SO+8YKWC/JIclrWh3TC3cHVBsyx+ZGdMN92hBN2F9E23atyZaaexxAmy/
	 y0zUZOb7nWLS1KElOEPOm8deVSgCGk9v7x/emQG13t3fgAfZPzfEYDPkk5HlGX1G68Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443803;
	bh=SfiofeSrrfZ77fzf6EIfT5gp6ax/ReWAfo5Xaye5bLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZV0GxeMpvSCfmX5oUgvFQkfcOozTnVATTq0FRj/xZRJETnATzD52jdJtf9BbU31MP
	 hiFCCQXX5K7haCgzLvlvc531x0haFFdQlrmGC7kagn31p8sYBLGogRRyTGjc+X6+FB
	 EJtjFivv3pHIQzJDRdaPmgc+faEbWvSU9aahNPW5pRQbJKsUp6m6mbVfZHfy6HdSKG
	 DBM1sFGh1tWmD2slAPxaPeG6GvHnFzwoRZqcX/Myd1qad+PUCVW/yaUXAKDpOf/CiC
	 gGcTZj4evixw55glDEumbiVANpp0ues2zDHr3Ed0YIk9B2xxmGQysAOTm1TWIu22Ve
	 xvaJ7LJmRhJxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 254C16078A;
	Mon, 23 Nov 2026 14:23:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D25C759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83CF180B08
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1Z7p-IGeTf1 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4E29809CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=WDhH4dRE
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4E29809CF
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0C8CD1A16D7;
 Mon, 23 Nov 2026 14:23:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D3776601E1;
 Mon, 23 Nov 2026 14:23:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 002E011E6A506; Mon, 23 Nov 2026 15:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SfiofeSrrfZ77fzf6EIfT5gp6ax/ReWAfo5Xaye5bLE=;
 b=WDhH4dREXVYz4nPYxhi2EmdRgBrPVlRicQ4+kPS3bIYldh8X2NjcyUCbJf9rn63pa+c1DY
 2nkaA3NinzHcTPOMHDEIehp8g/TtJAiIUbkMq/431YqcOw0y6pHPa1P15eKQfGHTALDcNd
 qE1+NrmWYlm0ac0OaQ6SWTQ/b+mBJ4p/0IaMz19W4q0SRrENa0kYxANmsLh8AkyNv/Kzsj
 g1Qkpk4JSgvfLe3p2Qo2Jfy/KKoU826k8OEA6vV0zH2tSIh2G5khO99tZUPV6hkSERByHs
 1Zg//Ja7B+PT5wr7i1sDC1fezwcborshdjATob7A9fLy49E46UZQocJeIY6Yvg==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:06 +0100
Subject: [PATCH v2 7/8] reset: synaptics: add sl2610 reset driver support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sl2619_base-v2-7-9e3b28c77cda@bootlin.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce Synaptics sl2610 family reset driver.

The code is based on Linux driver by Jisheng Zhang:
https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/

There's two kind of reset bits here:
- the so-called sticky bits that can be asserted and de-asserted, and
  are active low.
- the non-sticky bits (aka pulse bits) that generate a 640ns pulse and
  are active high.

rst_assert(), rst_deassert() and rst_reset() are implemented for sticky
bits.
But for pulse bits, rst_assert()/rst_deassert() don't fit, because we
can't keep them asserted, nor de-assert them.

So, only rst_assert() is implemented for pulse bits, and delay is
ignored.

NB: this driver has no compatible string because it is bound by the
system controller driver

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 drivers/reset/Kconfig        |   8 ++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-sl2610.c | 283 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ad61ebf344a6..921453ca07a8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -248,6 +248,14 @@ config RESET_SCMI
 	  devices exposed by a SCMI agent based on SCMI reset domain
 	  protocol communication with a SCMI server.
 
+config RESET_SL2610
+	bool "Synaptics SL2610 Reset Driver"
+	depends on DM_RESET && ARCH_SYNAPTICS
+	select SOC_SL2610_SYSCON
+	help
+	  This enables the reset controller driver that can be found in
+	  Synaptics SL2610 product family.
+
 config RESET_ZYNQMP
 	bool "Reset Driver for Xilinx ZynqMP & Versal SoC's"
 	depends on DM_RESET && ZYNQMP_FIRMWARE
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 959aafe4d709..06aa541587df 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_HISILICON) += reset-hisilicon.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_SIFIVE) += reset-sifive.o
+obj-$(CONFIG_RESET_SL2610) += reset-sl2610.o
 obj-$(CONFIG_RESET_SYSCON) += reset-syscon.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
diff --git a/drivers/reset/reset-sl2610.c b/drivers/reset/reset-sl2610.c
new file mode 100644
index 000000000000..015a54d31635
--- /dev/null
+++ b/drivers/reset/reset-sl2610.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics SL2610 reset driver
+ *
+ * Copyright (C) 2026 Synaptics Incorporated
+ * Author: Richard Genoud <richard.genoud@bootlin.com>
+ *
+ * Based on Linux driver reset-sl2610.c:
+ *	Author: Jisheng Zhang <jszhang@kernel.org>
+ *	Copyright (C) 2026 Synaptics Incorporated
+ *
+ *  There's two kind of reset bits here:
+ *  - the so-called sticky bits that can be asserted and de-asserted, and
+ *    are active low.
+ *  - the non-sticky bits (aka pulse bits) that generate a 640ns pulse and
+ *    are active high.
+ *
+ *  rst_assert(), rst_deassert() and rst_reset() are implemented for sticky
+ *  bits.
+ *  But for pulse bits, rst_assert()/rst_deassert() don't fit, because we
+ *  can't keep them asserted, or de-assert them.
+ *  So, only rst_assert() is implemented for pulse bits, and delay is
+ *  ignored.
+ *
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dt-bindings/reset/syna,sl2610-reset.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <reset-uclass.h>
+#include <soc/synaptics/sl2610-syscon.h>
+#include <syscon.h>
+
+/*
+ * sticky reset bits are active low, whereas
+ * non-sticky resets bits are active high.
+ */
+
+/* SL2610 ACPU subsystem */
+#define SL2610_GBL_PERIFRESET			0x350
+#define SL2610_GBL_PERIFSTICKYRESET		0x360
+#define SL2610_GBL_APBPERIFRESET		0x370
+#define SL2610_GBL_TOPSTICKYRESET		0x378
+#define SL2610_GBL_AVIOSTICKYRESET		0x37c
+
+/* SL2610 system subsystem */
+#define SL2610_SMGBL_STICKYRST0			0x400
+
+#define SL2610_RESET(id, reg, bit, sticky)[id] = { reg, BIT(bit), sticky }
+
+struct sl2610_reset_cfg {
+	u32 reg;
+	u32 bit;
+	bool sticky;
+};
+
+struct sl2610_reset_data {
+	const struct sl2610_reset_cfg *cfgs;
+	size_t num;
+};
+
+struct sl2610_reset_priv {
+	struct regmap *regmap;
+	const struct sl2610_reset_data *data;
+};
+
+static const struct sl2610_reset_cfg sl2610_reset_cfgs[] = {
+	SL2610_RESET(RST_SOC_SDIO0, SL2610_GBL_PERIFRESET, 2, false),
+	SL2610_RESET(RST_SOC_USB0, SL2610_GBL_PERIFRESET, 4, false),
+	SL2610_RESET(RST_SOC_EMMC, SL2610_GBL_PERIFRESET, 5, false),
+	SL2610_RESET(RST_SOC_GETH0, SL2610_GBL_PERIFRESET, 6, false),
+	SL2610_RESET(RST_SOC_SDIO1, SL2610_GBL_PERIFRESET, 7, false),
+	SL2610_RESET(RST_SOC_USB1, SL2610_GBL_PERIFRESET, 8, false),
+	SL2610_RESET(RST_SOC_GETH1, SL2610_GBL_PERIFRESET, 9, false),
+	SL2610_RESET(RST_SOC_USB0PHY, SL2610_GBL_PERIFSTICKYRESET, 0, true),
+	SL2610_RESET(RST_SOC_USB0CORE, SL2610_GBL_PERIFSTICKYRESET, 1, true),
+	SL2610_RESET(RST_SOC_USB0MAHB, SL2610_GBL_PERIFSTICKYRESET, 2, true),
+	SL2610_RESET(RST_SOC_USB1PHY, SL2610_GBL_PERIFSTICKYRESET, 3, true),
+	SL2610_RESET(RST_SOC_USB1CORE, SL2610_GBL_PERIFSTICKYRESET, 4, true),
+	SL2610_RESET(RST_SOC_USB1MAHB, SL2610_GBL_PERIFSTICKYRESET, 5, true),
+	SL2610_RESET(RST_SOC_UART0, SL2610_GBL_APBPERIFRESET, 0, false),
+	SL2610_RESET(RST_SOC_UART1, SL2610_GBL_APBPERIFRESET, 1, false),
+	SL2610_RESET(RST_SOC_UART2, SL2610_GBL_APBPERIFRESET, 2, false),
+	SL2610_RESET(RST_SOC_UART3, SL2610_GBL_APBPERIFRESET, 3, false),
+	SL2610_RESET(RST_SOC_I2C0, SL2610_GBL_APBPERIFRESET, 4, false),
+	SL2610_RESET(RST_SOC_I2C1, SL2610_GBL_APBPERIFRESET, 5, false),
+	SL2610_RESET(RST_SOC_SPI0, SL2610_GBL_APBPERIFRESET, 6, false),
+	SL2610_RESET(RST_SOC_SPI1, SL2610_GBL_APBPERIFRESET, 7, false),
+	SL2610_RESET(RST_SOC_SPI2, SL2610_GBL_APBPERIFRESET, 8, false),
+	SL2610_RESET(RST_SOC_SPI3, SL2610_GBL_APBPERIFRESET, 9, false),
+	SL2610_RESET(RST_SOC_APBTIMERS, SL2610_GBL_APBPERIFRESET, 10, false),
+	SL2610_RESET(RST_SOC_APBSYSCNT, SL2610_GBL_APBPERIFRESET, 11, false),
+	SL2610_RESET(RST_SOC_APBWDT, SL2610_GBL_APBPERIFRESET, 12, false),
+	SL2610_RESET(RST_SOC_APBGPIO, SL2610_GBL_APBPERIFRESET, 13, false),
+	SL2610_RESET(RST_SOC_APBDMA, SL2610_GBL_APBPERIFRESET, 14, false),
+	SL2610_RESET(RST_SOC_GPUCORE, SL2610_GBL_TOPSTICKYRESET, 0, true),
+	SL2610_RESET(RST_SOC_NPUCORE, SL2610_GBL_TOPSTICKYRESET, 1, true),
+	SL2610_RESET(RST_SOC_AVIOAIOG, SL2610_GBL_AVIOSTICKYRESET, 0, true),
+	SL2610_RESET(RST_SOC_AVIOVPPG, SL2610_GBL_AVIOSTICKYRESET, 1, true),
+	SL2610_RESET(RST_SOC_AVIOVIPG, SL2610_GBL_AVIOSTICKYRESET, 2, true),
+};
+
+static const struct sl2610_reset_cfg sl2610_system_reset_cfgs[] = {
+	SL2610_RESET(RST_SM_ADCCORE, SL2610_SMGBL_STICKYRST0, 0, true),
+	SL2610_RESET(RST_SM_ADCPRST, SL2610_SMGBL_STICKYRST0, 1, true),
+	SL2610_RESET(RST_SM_CAN0PRST, SL2610_SMGBL_STICKYRST0, 2, true),
+	SL2610_RESET(RST_SM_CAN0SRST, SL2610_SMGBL_STICKYRST0, 3, true),
+	SL2610_RESET(RST_SM_CAN1PRST, SL2610_SMGBL_STICKYRST0, 4, true),
+	SL2610_RESET(RST_SM_CAN1SRST, SL2610_SMGBL_STICKYRST0, 5, true),
+	SL2610_RESET(RST_SM_GPIOPRST, SL2610_SMGBL_STICKYRST0, 6, true),
+	SL2610_RESET(RST_SM_GPIOSRST, SL2610_SMGBL_STICKYRST0, 7, true),
+	SL2610_RESET(RST_SM_I2CM0PRST, SL2610_SMGBL_STICKYRST0, 8, true),
+	SL2610_RESET(RST_SM_I2CM0SRST, SL2610_SMGBL_STICKYRST0, 9, true),
+	SL2610_RESET(RST_SM_I2CM1PRST, SL2610_SMGBL_STICKYRST0, 10, true),
+	SL2610_RESET(RST_SM_I2CM1SRST, SL2610_SMGBL_STICKYRST0, 11, true),
+	SL2610_RESET(RST_SM_I3CPRST, SL2610_SMGBL_STICKYRST0, 12, true),
+	SL2610_RESET(RST_SM_I3CSRST, SL2610_SMGBL_STICKYRST0, 13, true),
+	SL2610_RESET(RST_SM_PDMPRST, SL2610_SMGBL_STICKYRST0, 14, true),
+	SL2610_RESET(RST_SM_PDMSRST, SL2610_SMGBL_STICKYRST0, 15, true),
+	SL2610_RESET(RST_SM_PVTHSRST, SL2610_SMGBL_STICKYRST0, 16, true),
+	SL2610_RESET(RST_SM_PVTPRST, SL2610_SMGBL_STICKYRST0, 17, true),
+	SL2610_RESET(RST_SM_PWMPERIRST, SL2610_SMGBL_STICKYRST0, 18, true),
+	SL2610_RESET(RST_SM_PWMPRST, SL2610_SMGBL_STICKYRST0, 19, true),
+	SL2610_RESET(RST_SM_SPIMPRST, SL2610_SMGBL_STICKYRST0, 20, true),
+	SL2610_RESET(RST_SM_SPIMSRST, SL2610_SMGBL_STICKYRST0, 21, true),
+	SL2610_RESET(RST_SM_SPISPRST, SL2610_SMGBL_STICKYRST0, 22, true),
+	SL2610_RESET(RST_SM_SPISSRST, SL2610_SMGBL_STICKYRST0, 23, true),
+	SL2610_RESET(RST_SM_UART0PRST, SL2610_SMGBL_STICKYRST0, 24, true),
+	SL2610_RESET(RST_SM_UART0SRST, SL2610_SMGBL_STICKYRST0, 25, true),
+	SL2610_RESET(RST_SM_UART1PRST, SL2610_SMGBL_STICKYRST0, 26, true),
+	SL2610_RESET(RST_SM_UART1SRST, SL2610_SMGBL_STICKYRST0, 27, true),
+	SL2610_RESET(RST_SM_UART2PRST, SL2610_SMGBL_STICKYRST0, 28, true),
+	SL2610_RESET(RST_SM_UART2SRST, SL2610_SMGBL_STICKYRST0, 29, true),
+	SL2610_RESET(RST_SM_UART3PRST, SL2610_SMGBL_STICKYRST0, 30, true),
+	SL2610_RESET(RST_SM_UART3SRST, SL2610_SMGBL_STICKYRST0, 31, true),
+};
+
+static const struct sl2610_reset_data sl2610_reset_data = {
+	.cfgs = sl2610_reset_cfgs,
+	.num = ARRAY_SIZE(sl2610_reset_cfgs),
+};
+
+static const struct sl2610_reset_data sl2610_system_reset_data = {
+	.cfgs = sl2610_system_reset_cfgs,
+	.num = ARRAY_SIZE(sl2610_system_reset_cfgs),
+};
+
+static const
+struct sl2610_reset_cfg *sl2610_get_cfg(struct sl2610_reset_priv *priv,
+					unsigned long id)
+{
+	if (id >= priv->data->num)
+		return NULL;
+
+	return &priv->data->cfgs[id];
+}
+
+static int sl2610_reset_assert(struct reset_ctl *rst)
+{
+	struct sl2610_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct sl2610_reset_cfg *cfg = sl2610_get_cfg(priv, rst->id);
+
+	if (!cfg)
+		return -EINVAL;
+
+	/*
+	 * non-sticky bits are auto-deasserted, the reset is triggered for
+	 * 640ns, and deasserted.
+	 * So user should use rst_reset instead.
+	 */
+	if (!cfg->sticky)
+		return -EINVAL;
+
+	/* sticky reset bits are active low */
+	return regmap_clear_bits(priv->regmap, cfg->reg, cfg->bit);
+}
+
+static int sl2610_reset_deassert(struct reset_ctl *rst)
+{
+	struct sl2610_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct sl2610_reset_cfg *cfg = sl2610_get_cfg(priv, rst->id);
+
+	if (!cfg)
+		return -EINVAL;
+
+	if (!cfg->sticky)
+		return -EINVAL;
+
+	/* sticky reset bits are active low */
+	return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);
+}
+
+static int sl2610_reset_reset(struct reset_ctl *rst, ulong delay_us)
+{
+	struct sl2610_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct sl2610_reset_cfg *cfg = sl2610_get_cfg(priv, rst->id);
+	int err;
+
+	if (!cfg)
+		return -EINVAL;
+
+	/*
+	 * We should not use regmap_set_bits() for pulse-bits since it would
+	 * reset again the devices behind every bits that where not cleared
+	 * from a previous reset.
+	 */
+	if (!cfg->sticky)
+		return regmap_write(priv->regmap, cfg->reg, cfg->bit);
+
+	/* sticky reset bits are active low */
+	err = regmap_clear_bits(priv->regmap, cfg->reg, cfg->bit);
+	if (err)
+		return err;
+
+	udelay(delay_us);
+
+	return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);
+}
+
+static int sl2610_reset_status(struct reset_ctl *rst)
+{
+	struct sl2610_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct sl2610_reset_cfg *cfg = sl2610_get_cfg(priv, rst->id);
+	u32 val;
+	int err;
+
+	if (!cfg)
+		return -EINVAL;
+
+	/* reset from non sticky bits is self-deasserting */
+	if (!cfg->sticky)
+		return 0;
+
+	err = regmap_read(priv->regmap, cfg->reg, &val);
+	if (err)
+		return err;
+
+	/* sticky reset bits are active low */
+	return !(val & cfg->bit);
+}
+
+static int sl2610_reset_probe(struct udevice *dev)
+{
+	struct sl2610_reset_priv *priv = dev_get_priv(dev);
+	const struct sl2610_reset_data *data;
+
+	priv->regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	switch (dev_get_driver_data(dev)) {
+	case SL2610_SYSCON_BLOCK_SOC:
+		data = &sl2610_reset_data;
+		break;
+	case SL2610_SYSCON_BLOCK_MCU:
+		data = &sl2610_system_reset_data;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	priv->data = data;
+
+	return 0;
+}
+
+static const struct reset_ops sl2610_reset_ops = {
+	.rst_assert = sl2610_reset_assert,
+	.rst_deassert = sl2610_reset_deassert,
+	.rst_reset = sl2610_reset_reset,
+	.rst_status = sl2610_reset_status,
+};
+
+U_BOOT_DRIVER(sl2610_reset) = {
+	.name		= "sl2610-reset",
+	.id		= UCLASS_RESET,
+	.probe		= sl2610_reset_probe,
+	.ops		= &sl2610_reset_ops,
+	.priv_auto	= sizeof(struct sl2610_reset_priv),
+};

-- 
2.55.0

