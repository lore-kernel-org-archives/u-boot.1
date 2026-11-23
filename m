Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD7606A338
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jZkrZ8ti;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xtP2rc7e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63F2B40635;
	Mon, 23 Nov 2026 14:23:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vvi0CjdS-CV8; Mon, 23 Nov 2026 14:23:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15A34406E1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443795;
	b=QKtQRtUVGBsIqEr0TKnNrcfKWNtxaL8g9IX7VLuY/FsafYBGDia2gIVArRhgNJfi/1zW
	 EJKQiJEgb+hpG4ILhEdI/MRxDYevjMCuQmzosKsv72qoYaFGEf6mJ5orzIOVhh4/wxqYC
	 nK9rUALupe0cD77QesVbznRrZudJ5xK2r4qdRvOjdUFIKLYhii7dBZTTGCeia9IvjjVUu
	 OaghgSpgyh3xG3ZYKmhwMfB9lR9oB/OqQTGX6SzJvNQ1LrGVrDzQk700eGHXAf3T7tY+t
	 2Iu9Swt4VV5ns91G1pyewtreJUt4cpwyD4WeGPLHwJt/XPB9i+QMI5NqVSOt8e2YU6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NcnnvGD/Kx2VhULsIhcMaqCTywcNG9QiBn2KNOG4pqU=;
	b=gH9ZDH4AjMvr67A6/MteFc6vj4guQTbGJxAMCViq3SQaY4qaHi7Svp5fg1XjuyWUt1nd
	 ml+ATmM6eKErP04rFlUhe5HklMKhkWYC3t8Cj/b88x3wq4tQGkJ8YlHSjY6Mxs6xzH0Jh
	 hBitYRAnRGmzFMRZEwCga6VnhFskYB/Uo6BgcaaV+5F91xOr3p2OF0bMutZlOLjiO2MF0
	 KG25qPQ2DUCOBEsVtzI3CZ0GMFvpgnnPms58PnaeKGYOV2BAUk/a07VMvppyGX4K8R7F6
	 x8+c5EANALbM3l76DKw7zsYF3AP/e1sDccRjpnnQWl2Zntryz7oKAv1DIVIuJySLHhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443795;
	bh=NcnnvGD/Kx2VhULsIhcMaqCTywcNG9QiBn2KNOG4pqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZkrZ8tiXQB5j/HRTsniyviapmqXJlQnkDBD1fsOFFmfzJj4x9N+MQLF5dJECb51j
	 NxCKSVs67WFyrztsOoWBIfpqEm1CztLlr2yLu5BthnhpPoXOyAiP7gu004hDYsc2FN
	 vURIiwaN4CIpfmnLcRWHF/QuOkADYm1lJnn2opOtkBqg0MTO2+3C+kUREjhSi3Ud7T
	 UdeFOqvXCy8FZQ1QWt+u8VSexycWZG5tnZ388QKkbXS5hLWlIBy7Vlvjz1pgUd5lxP
	 UdnhpVGvNB7AFgbP9rl9Fm8jl+5Hl2zZfN3e4yFmS1FKynlUbV6bWbVVJs1nBNfoiV
	 xRDxxhGn11tpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15A34406E1;
	Mon, 23 Nov 2026 14:23:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D74CF371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD756400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWoHd3AHaHS2 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:23:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 91F3540060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=xtP2rc7e
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91F3540060
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 1FEFEC69161;
 Mon, 23 Nov 2026 14:23:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 18CB2601E1;
 Mon, 23 Nov 2026 14:23:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C65C11E6A528; Mon, 23 Nov 2026 15:23:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NcnnvGD/Kx2VhULsIhcMaqCTywcNG9QiBn2KNOG4pqU=;
 b=xtP2rc7evUkoURN2mGvNWBk39/6Oi8rdo/golgmQX4NGxN+gCYD8CBUZiMALYuLhHDVz3l
 Io2Cb2VbuXnDtSzZmZo7utuY8Reo2K1xc5NqKC3J9WZJaYbEMqF+7zVHOxu2Mgg20dukUq
 PB4mBFfDwurakgclvQdZGQqtZ2qLU3j+Xxm02Ecqgr1jAlCjVvI8Ga00fU1mf8CegX4xx4
 pPWF01lmhqRDoHylKcR7c4gYx5sueUOhgqPQDV+zfma8XL2zBjBNlgczZkZrnSHlmL1Ib5
 y8OpZKHtf29BbqKHLacrZAoBpNInWk0iahdmr+lZUxZsbjlbzlyTV9ndDnTU+A==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:04 +0100
Subject: [PATCH v2 5/8] clk: synaptics: add Synaptics sl2610 family clock
 drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sl2619_base-v2-5-9e3b28c77cda@bootlin.com>
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

Introduce Synaptics sl2619 clock driver.

The code is based on Linux driver by Jisheng Zhang:
https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/
It has been kept as close as possible to the original Linux code, thanks
to U-Boot CCF.

The main difference is for sl2610_soc_clks_probe, where we force_probe
sl2610_aio_clk and sl2610_system_clk, to resolve dependencies.

NB: this driver has no compatible string because it is bound by the
system controller driver

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 drivers/clk/Kconfig                   |   1 +
 drivers/clk/Makefile                  |   1 +
 drivers/clk/synaptics/Kconfig         |  12 +
 drivers/clk/synaptics/Makefile        |   1 +
 drivers/clk/synaptics/clk-sl2610.c    | 438 ++++++++++++++++++++++++++++++++++
 drivers/clk/synaptics/sl-clk.c        | 266 +++++++++++++++++++++
 drivers/clk/synaptics/sl-clk.h        |  29 +++
 drivers/clk/synaptics/sl-sysmgr-clk.c |  76 ++++++
 drivers/clk/synaptics/sl-sysmgr-clk.h |  44 ++++
 drivers/clk/synaptics/sl2610-pll.c    | 127 ++++++++++
 drivers/clk/synaptics/sl2610-pll.h    |  12 +
 11 files changed, 1007 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3f39b36949a6..d977727ab2a8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -297,6 +297,7 @@ source "drivers/clk/spacemit/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/stm32/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
+source "drivers/clk/synaptics/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/thead/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4b241a9240ac..d860e64fff53 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(PHASE_)CLK_RS9_PCIE) += clk-renesas-pcie.o
 obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
+obj-$(CONFIG_CLK_SL2610) += synaptics/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
 obj-$(CONFIG_CLK_SPACEMIT) += spacemit/
 obj-$(CONFIG_CLK_SUNXI) += sunxi/
diff --git a/drivers/clk/synaptics/Kconfig b/drivers/clk/synaptics/Kconfig
new file mode 100644
index 000000000000..295a126ccea5
--- /dev/null
+++ b/drivers/clk/synaptics/Kconfig
@@ -0,0 +1,12 @@
+config CLK_SL2610
+	bool "Synaptics SL2610 clock driver"
+	depends on CLK && ARCH_SYNAPTICS
+	select SOC_SL2610_SYSCON
+	select CLK_CCF
+	select CLK_AUTO_ID
+	help
+	  This enables support for clock driver for SL2610 Synaptics SoCs.
+	  The driver handles clocks from soc, cpu, aio and system manager
+	  domains.
+	  The clock controller generates and supplies clocks to various
+	  peripherals within the SoC.
diff --git a/drivers/clk/synaptics/Makefile b/drivers/clk/synaptics/Makefile
new file mode 100644
index 000000000000..e2c922166a90
--- /dev/null
+++ b/drivers/clk/synaptics/Makefile
@@ -0,0 +1 @@
+obj-y += clk-sl2610.o sl2610-pll.o sl-clk.o sl-sysmgr-clk.o
diff --git a/drivers/clk/synaptics/clk-sl2610.c b/drivers/clk/synaptics/clk-sl2610.c
new file mode 100644
index 000000000000..19e3bf58bacb
--- /dev/null
+++ b/drivers/clk/synaptics/clk-sl2610.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * Author: Richard Genoud <richard.genoud@bootlin.com>
+ *
+ * From Linux: drivers/clk/berlin/sl2610-clks.c
+ *    Copyright (C) 2025 Synaptics Incorporated
+ *    Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <clk-uclass.h>
+#include <div64.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/read.h>
+#include <dm/uclass.h>
+#include <dt-bindings/clock/syna,sl2610.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <malloc.h>
+
+#include "sl2610-pll.h"
+#include "sl-clk.h"
+#include "sl-sysmgr-clk.h"
+
+#define REG_CLKENABLE		0x0420
+
+#define CLK_GATE_CTRL0		0x0600
+
+#define SYSPLL0_OFFSET		0x0200
+#define SYSPLL1_OFFSET		0x0220
+#define CPUPLL_OFFSET		0x2000
+#define APLL0_OFFSET		0x0008
+#define APLL1_OFFSET		0x0030
+
+enum {
+	SYSPLL0_OUT, SYSPLL0_OUTF,
+	SYSPLL1_OUT, SYSPLL1_OUTF,
+	CPUPLL_OUT, CPUPLL_OUTF,
+	APLL0_OUT, APLL0_OUTF,
+	APLL1_OUT, APLL1_OUTF,
+};
+
+static const char * const clk_names[] = {
+	[SYSPLL0_OUT]		= "syspll0_out",
+	[SYSPLL0_OUTF]		= "syspll0_outf",
+	[SYSPLL1_OUT]		= "syspll1_out",
+	[SYSPLL1_OUTF]		= "syspll1_outf",
+	[CPUPLL_OUT]		= "cpupll_out",
+	[CPUPLL_OUTF]		= "cpupll_outf",
+	[APLL0_OUT]		= "apll0_out",
+	[APLL0_OUTF]		= "apll0_outf",
+	[APLL1_OUT]		= "apll1_out",
+	[APLL1_OUTF]		= "apll1_outf",
+};
+
+static const struct sl_gateclk_desc sl2610_gates[] = {
+	{ "usb0coreclk",	"perifsysclk",	CLK_USB0CORE,		0 },
+	{ "sdiosysclk",		"perifsysclk",	CLK_SDIOSYS,		1 },
+	{ "emmcsysclk",		"perifsysclk",	CLK_EMMCSYS,		2 },
+	{ "gpuaxiclk",		"hpcclk",	CLK_GPUAXI,		3 },
+	{ "gethrgmiisysclk",	"perifsysclk",	CLK_GETHRGMIISYS,	4 },
+	{ "sdio1sysclk",	"perifsysclk",	CLK_SDIO1SYS,		5 },
+	{ "usb1coreclk",	"perifsysclk",	CLK_USB1CORE,		6 },
+	{ "gethrgmii1sysclk",	"perifsysclk",	CLK_GETHRGMII1SYS,	7 },
+	{ "usb0phyrefclk",	"perifsysclk",	CLK_USB0PHYREF,		8 },
+	{ "usb1phyrefclk",	"perifsysclk",	CLK_USB1PHYREF,		9 },
+	{ "apbuart0clk",	"apbcoreclk",	CLK_APBUART0,		10 },
+	{ "apbuart1clk",	"apbcoreclk",	CLK_APBUART1,		11 },
+	{ "apbuart2clk",	"apbcoreclk",	CLK_APBUART2,		12 },
+	{ "apbuart3lck",	"apbcoreclk",	CLK_APBUART3,		13 },
+	{ "apbi2c0clk",		"apbcoreclk",	CLK_APBI2C0,		14 },
+	{ "apbi2c1lck",		"apbcoreclk",	CLK_APBI2C1,		15 },
+	{ "apbspi0clk",		"apbcoreclk",	CLK_APBSPI0,		16 },
+	{ "apbspi1clk",		"apbcoreclk",	CLK_APBSPI1,		17 },
+	{ "apbspi2clk",		"apbcoreclk",	CLK_APBSPI2,		18 },
+	{ "apbspi3clk",		"apbcoreclk",	CLK_APBSPI3,		19 },
+	{ "apbgpioclk",		"apbcoreclk",	CLK_APBGPIO,		20 },
+	{ "apbtimersclk",	"apbcoreclk",	CLK_APBTIMERS,		21 },
+	{ "apbsyscntclk",	"apbcoreclk",	CLK_APBSYSCNT,		22 },
+	{ "apbwdtclk",		"apbcoreclk",	CLK_APBWDT,		23 },
+	{ "apbdmaclk",		"apbcoreclk",	CLK_APBDMA,		24 },
+};
+
+static const struct sl_clk_desc sl2610_descs[] = {
+	{ "cpufastrefclk",	CLK_CPUFASTREF,		0x440, CLK_IS_CRITICAL },
+	{ "memfastrefclk",	CLK_MEMFASTREF,		0x444, CLK_IS_CRITICAL },
+	{ "cfgclk",		CLK_CFG,		0x448, CLK_IS_CRITICAL },
+	{ "sysclk",		CLK_SYS,		0x44c, CLK_IS_CRITICAL },
+	{ "perifsysclk",	CLK_PERIFSYS,		0x450, CLK_IS_CRITICAL },
+	{ "apbcoreclk",		CLK_APBCORE,		0x454, CLK_IS_CRITICAL },
+	{ "apbserclk",		CLK_APBSER,		0x458, CLK_IS_CRITICAL },
+	{ "atbclk",		CLK_ATB,		0x45c },
+	{ "hpcclk",		CLK_HPC,		0x460, CLK_IS_CRITICAL },
+	{ "emmcclk",		CLK_EMMC,		0x464 },
+	{ "sd0clk",		CLK_SD0,		0x468 },
+	{ "sd1clk",		CLK_SD1,		0x46c },
+	{ "gethrgmiiclk",	CLK_GETHRGMII,		0x470 },
+	{ "gethrgmii1clk",	CLK_GETHRGMII1,		0x474 },
+	{ "ge0_ptp_refclk",	CLK_GE0_PTP_REF,	0x478 },
+	{ "ge1_ptp_refclk",	CLK_GE1_PTP_REF,	0x47c },
+	{ "usb2testclk",	CLK_USB2TEST,		0x480 },
+	{ "usb2test480mg0clk",	CLK_USB2TEST480MG0,	0x484 },
+	{ "usb2test480mg1clk",	CLK_USB2TEST480MG1,	0x488 },
+	{ "usb2test480mg2clk",	CLK_USB2TEST480MG2,	0x48c },
+	{ "usb2test100mg0clk",	CLK_USB2TEST100MG0,	0x490 },
+	{ "usb2test100mg1clk",	CLK_USB2TEST100MG1,	0x494 },
+	{ "usb2test100mg2clk",	CLK_USB2TEST100MG2,	0x498 },
+	{ "usb2test100mg3clk",	CLK_USB2TEST100MG3,	0x49c },
+	{ "periftest125mg0clk",	CLK_PERIFTEST125MG0,	0x4a0 },
+	{ "periftest200mg0clk",	CLK_PERIFTEST200MG0,	0x4a4 },
+	{ "periftest200mg1clk",	CLK_PERIFTEST200MG1,	0x4a8 },
+	{ "gpuclk",		CLK_GPU,		0x4ac },
+	{ "npuclk",		CLK_NPU,		0x4b0 },
+	{ "aviosysclk",		CLK_AVIOSYS,		0x4b4, CLK_IS_CRITICAL },
+	{ "aiosysclk",		CLK_AIOSYS,		0x4b8, CLK_IS_CRITICAL },
+	{ "avio_lcdc2scanclk",	CLK_AVIO_LCDC2SCAN,	0x4bc },
+	{ "avio_ipiclk",	CLK_AVIO_IPI,		0x4c0 },
+	{ "avio_pclk",		CLK_AVIO_P,		0x4c4 },
+	{ "avio_dphyrxtxescclk", CLK_AVIO_DPHYRXTXESC,	0x4c8 },
+	{ "aviofpllclk",	CLK_AVIOFPLL,		0x4cc },
+	{ "avio_rx_scanbyteclk", CLK_AVIO_RX_SCANBYTE,	0x4d0 },
+	{ "avio_rx_scantestclk", CLK_AVIO_RX_SCANTEST,	0x4d4 },
+};
+
+static const char * const default_parent_names[] = {
+	"syspll0_out",
+	"apll0_out",
+	"syspll0_outf",
+	"apll0_outf",
+	"syspll1_out",
+	"syspll1_outf",
+};
+
+static const char * const ge_ptp_refclk_parent_names[] = {
+	"osc",
+	"apll0_outf",
+	"syspll1_out",
+	"syspll0_out",
+	"clk_mcu_axi",
+};
+
+static int sl2610_soc_clk_setup(struct udevice *dev)
+{
+	const char * const *parent_names;
+	int num_parents;
+	void __iomem *base;
+	struct clk *clk;
+	int n, ret;
+	u32 id;
+
+	base = dev_read_addr_ptr(dev_get_parent(dev));
+	if (!base)
+		return -ENODEV;
+
+	/* sysplls */
+	ret = sl2610_pll_register(dev, base + SYSPLL0_OFFSET,
+				  clk_names[SYSPLL0_OUT], clk_names[SYSPLL0_OUTF]);
+	if (ret)
+		return ret;
+	ret = sl2610_pll_register(dev, base + SYSPLL1_OFFSET,
+				  clk_names[SYSPLL1_OUT], clk_names[SYSPLL1_OUTF]);
+	if (ret)
+		return ret;
+
+	/* normal clocks */
+	for (n = 0; n < ARRAY_SIZE(sl2610_descs); n++) {
+		const struct sl_clk_desc *cd = &sl2610_descs[n];
+
+		id = cd->id;
+		if (id == CLK_GE0_PTP_REF || id == CLK_GE1_PTP_REF) {
+			parent_names = ge_ptp_refclk_parent_names;
+			num_parents = ARRAY_SIZE(ge_ptp_refclk_parent_names);
+		} else {
+			parent_names = default_parent_names;
+			num_parents = ARRAY_SIZE(default_parent_names);
+		}
+		clk = sl_clk_register(dev, base + cd->offset, cd->name,
+				      parent_names, num_parents, cd->flags);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		dev_clk_dm(dev, id, clk);
+	}
+
+	/* gate clocks */
+	for (n = 0; n < ARRAY_SIZE(sl2610_gates); n++) {
+		const struct sl_gateclk_desc *gd = &sl2610_gates[n];
+
+		clk = clk_register_gate(dev, gd->name, gd->parent_name,
+					gd->flags, base + REG_CLKENABLE,
+					gd->bit_idx, 0, NULL);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		dev_clk_dm(dev, gd->id, clk);
+	}
+
+	return 0;
+}
+
+static int sl2610_cpu_clk_setup(struct udevice *dev)
+{
+	struct clk *clk;
+	void __iomem *base;
+	int ret;
+
+	base = dev_read_addr_ptr(dev_get_parent(dev));
+	if (!base)
+		return -ENODEV;
+
+	/* cpupll */
+	ret = sl2610_pll_register(dev, base + CPUPLL_OFFSET,
+				  clk_names[CPUPLL_OUT], clk_names[CPUPLL_OUTF]);
+	if (ret)
+		return ret;
+
+	/* TODO: support cpupll bypass */
+	clk = clk_register_fixed_factor(dev, "cpu0", clk_names[CPUPLL_OUTF], 0, 1, 1);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	dev_clk_dm(dev, CLK_CPU0, clk);
+
+	clk = clk_register_fixed_factor(dev, "cpu1", clk_names[CPUPLL_OUTF], 0, 1, 1);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	dev_clk_dm(dev, CLK_CPU1, clk);
+
+	clk = clk_register_fixed_factor(dev, "dsu", clk_names[CPUPLL_OUT], 0, 1, 1);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	dev_clk_dm(dev, CLK_DSU, clk);
+
+	return 0;
+}
+
+static int sl2610_aio_clk_setup(struct udevice *dev)
+{
+	void __iomem *base;
+	int ret;
+
+	base = dev_read_addr_ptr(dev_get_parent(dev));
+	if (!base)
+		return -ENODEV;
+
+	ret = sl2610_pll_register(dev, base + APLL0_OFFSET,
+				  clk_names[APLL0_OUT], clk_names[APLL0_OUTF]);
+	if (ret)
+		return ret;
+	ret = sl2610_pll_register(dev, base + APLL1_OFFSET,
+				  clk_names[APLL1_OUT], clk_names[APLL1_OUTF]);
+	if (ret)
+		return ret;
+
+	/* TODO aio clks */
+
+	return 0;
+}
+
+static const struct sl_sysmgr_fixedclk_desc sl2610_sysmgr_fixeds[] = {
+	{ "clk_mcu_ref",	CLK_MCU_REF,	25000000 },
+	{ "clk_mcu_pll",	CLK_MCU_PLL,	400000000 },
+	{ "clk_mcu_io_pll",	CLK_MCU_IO_PLL,	300000000 },
+	{ "clk_mcu_apb",	CLK_MCU_APB,	100000000 },
+	{ "clk_mcu_axi",	CLK_MCU_AXI,	200000000 },
+};
+
+static const struct sl_sysmgr_gateclk_desc sl2610_sysmgr_gates[] = {
+	{ "clk_cfg_uart0",	"clk_mcu_apb",	CLK_CFG_UART0,	0 },
+	{ "clk_ser_uart0",	"clk_mcu_ref",	CLK_SER_UART0,	1 },
+	{ "clk_cfg_uart1",	"clk_mcu_apb",	CLK_CFG_UART1,	2 },
+	{ "clk_cfg_uart2",	"clk_mcu_apb",	CLK_CFG_UART2,	3 },
+	{ "clk_cfg_uart3",	"clk_mcu_apb",	CLK_CFG_UART3,	4 },
+	{ "clk_cfg_gpio",	"clk_mcu_apb",	CLK_CFG_GPIO,	5 },
+	{ "clk_cfg_i2cm0",	"clk_mcu_apb",	CLK_CFG_I2CM0,	6 },
+	{ "clk_cfg_i2cm1",	"clk_mcu_apb",	CLK_CFG_I2CM1,	7 },
+	{ "clk_cfg_spim",	"clk_mcu_apb",	CLK_CFG_SPIM,	8 },
+	{ "clk_cfg_spis",	"clk_mcu_apb",	CLK_CFG_SPIS,	9 },
+	{ "clk_cfg_i3c",	"clk_mcu_apb",	CLK_CFG_I3C,	10 },
+	{ "clk_cfg_xspi",	"clk_mcu_apb",	CLK_CFG_XSPI,	11 },
+	{ "clk_axi_xspi",	"clk_mcu_axi",	CLK_AXI_XSPI,	12 },
+	{ "clk_cfg_pvt",	"clk_mcu_apb",	CLK_CFG_PVT,	13 },
+	{ "clk_cfg_adc",	"clk_mcu_apb",	CLK_CFG_ADC,	14 },
+	{ "clk_cfg_pwm",	"clk_mcu_apb",	CLK_CFG_PWM,	15 },
+	{ "clk_bus_can0",	"clk_mcu_axi",	CLK_BUS_CAN0,	16 },
+	{ "clk_bus_can1",	"clk_mcu_axi",	CLK_BUS_CAN1,	17 },
+	{ "clk_cfg_pdm",	"clk_mcu_apb",	CLK_CFG_PDM,	18 },
+};
+
+static const struct sl_sysmgr_clk_desc sl2610_sysmgr_clks[] = {
+	{ "clk_ser_uart1",	"clk_mcu_pll",	CLK_SER_UART1,	0x604,	4 },
+	{ "clk_ser_uart2",	"clk_mcu_pll",	CLK_SER_UART2,	0x608,	4 },
+	{ "clk_ser_uart3",	"clk_mcu_pll",	CLK_SER_UART3,	0x60c,	4 },
+	{ "clk_deb_gpio",	"clk_mcu_pll",	CLK_DEB_GPIO,	0x610,	4 },
+	{ "clk_ser_i2cm0",	"clk_mcu_pll",	CLK_SER_I2CM0,	0x614,	4 },
+	{ "clk_ser_i2cm1",	"clk_mcu_pll",	CLK_SER_I2CM1,	0x618,	4 },
+	{ "clk_ser_spim",	"clk_mcu_pll",	CLK_SER_SPIM,	0x61c,	4 },
+	{ "clk_ser_spis",	"clk_mcu_pll",	CLK_SER_SPIS,	0x620,	4 },
+	{ "clk_ser_i3c",	"clk_mcu_pll",	CLK_SER_I3C,	0x624,	4 },
+	{ "clk_ser_xspi",	"clk_mcu_io_pll", CLK_SER_XSPI,	0x628,	4 },
+	{ "clk_hs_pvt",		"clk_mcu_pll",	CLK_HS_PVT,	0x62c,	4 },
+	{ "clk_core_adc",	"clk_mcu_pll",	CLK_CORE_ADC,	0x630,	8 },
+	{ "clk_ser_pwm",	"clk_mcu_pll",	CLK_SER_PWM,	0x634,	4 },
+	{ "clk_ser_can0",	"clk_mcu_pll",	CLK_SER_CAN0,	0x638,	4 },
+	{ "clk_ser_can1",	"clk_mcu_pll",	CLK_SER_CAN1,	0x63c,	4 },
+	{ "clk_ser_pdm",	"clk_mcu_pll",	CLK_SER_PDM,	0x640,	8 },
+	{ "clk_ref_calib",	"clk_mcu_pll",	CLK_REF_CALIB,	0x644,	8 },
+};
+
+static int sl2610_sysmgr_clk_setup(struct udevice *dev)
+{
+	return sl_sysmgr_clk_setup(dev, sl2610_sysmgr_fixeds, ARRAY_SIZE(sl2610_sysmgr_fixeds),
+				   sl2610_sysmgr_gates, ARRAY_SIZE(sl2610_sysmgr_gates),
+				   CLK_GATE_CTRL0,
+				   sl2610_sysmgr_clks, ARRAY_SIZE(sl2610_sysmgr_clks));
+}
+
+static int sl2610_clk_force_probe(const struct driver *drv)
+{
+	struct udevice *dev;
+
+	return uclass_get_device_by_driver(UCLASS_CLK, drv, &dev);
+}
+
+static int sl2610_soc_clks_probe(struct udevice *dev)
+{
+	int ret;
+
+	/*
+	 * parents clocks apll0_out, apll0_outf are from aio
+	 * and clk_mcu_axi is from system.
+	 */
+	ret = sl2610_clk_force_probe(DM_DRIVER_GET(sl2610_aio_clk));
+	if (ret)
+		return ret;
+
+	ret = sl2610_clk_force_probe(DM_DRIVER_GET(sl2610_system_clk));
+	if (ret)
+		return ret;
+
+	ret = sl2610_soc_clk_setup(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sl2610_cpu_clks_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = sl2610_cpu_clk_setup(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sl2610_aio_clks_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = sl2610_aio_clk_setup(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sl2610_system_clks_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = sl2610_sysmgr_clk_setup(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sl2610_clk_of_xlate(struct clk *clock,
+			       struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1) {
+		debug("Invalid clock args_count (%d)\n", args->args_count);
+		return -EINVAL;
+	}
+
+	clock->id = CLK_ID(clock->dev, args->args[0]);
+	clock->data = 0;
+
+	return 0;
+}
+
+static const struct clk_ops sl2610_clk_ops = {
+	.of_xlate = sl2610_clk_of_xlate,
+	.set_rate = ccf_clk_set_rate,
+	.get_rate = ccf_clk_get_rate,
+	.set_parent = ccf_clk_set_parent,
+	.enable = ccf_clk_enable,
+	.disable = ccf_clk_disable,
+};
+
+U_BOOT_DRIVER(sl2610_soc_clk) = {
+	.name = "syna-sl2610-soc-clk",
+	.id = UCLASS_CLK,
+	.ops = &sl2610_clk_ops,
+	.probe = sl2610_soc_clks_probe,
+};
+
+U_BOOT_DRIVER(sl2610_cpu_clk) = {
+	.name = "syna-sl2610-cpu-clk",
+	.id = UCLASS_CLK,
+	.ops = &sl2610_clk_ops,
+	.probe = sl2610_cpu_clks_probe,
+};
+
+U_BOOT_DRIVER(sl2610_aio_clk) = {
+	.name = "syna-sl2610-aio-clk",
+	.id = UCLASS_CLK,
+	.ops = &sl2610_clk_ops,
+	.probe = sl2610_aio_clks_probe,
+};
+
+U_BOOT_DRIVER(sl2610_system_clk) = {
+	.name = "syna-sl2610-system-clk",
+	.id = UCLASS_CLK,
+	.ops = &sl2610_clk_ops,
+	.probe = sl2610_system_clks_probe,
+};
diff --git a/drivers/clk/synaptics/sl-clk.c b/drivers/clk/synaptics/sl-clk.c
new file mode 100644
index 000000000000..17ecb5bdba21
--- /dev/null
+++ b/drivers/clk/synaptics/sl-clk.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * From Linux drivers/clk/berlin/sl-clk.c:
+ *    Copyright (C) 2018 Synaptics Incorporated
+ *    Copyright (c) 2015 Marvell Technology Group Ltd.
+ *    Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/uclass.h>
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/clk-provider.h>
+#include <linux/compat.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#define SL_CLK_EN		BIT(0)
+#define SL_CLK_PLL_SEL		GENMASK(3, 1)
+#define SL_CLK_PLL_SWITCH	BIT(4)
+#define SL_CLK_DIV_SWITCH	BIT(5)
+#define SL_CLK_DIV3_SWITCH	BIT(6)
+#define SL_CLK_DIV_SEL		GENMASK(9, 7)
+#define SL_MAX_PARENTS	6
+
+struct sl_clk {
+	struct clk hw;
+	void __iomem *reg;
+	spinlock_t *lock;
+	struct udevice *dev;
+	unsigned int num_parents;
+	const char *const *parent_names;
+};
+
+#define to_sl_clk(_hw) container_of(_hw, struct sl_clk, hw)
+
+static const unsigned int sl_clk_values[] = { 1, 2, 3, 4, 6, 8, 12 };
+
+static unsigned int sl_clk_value(u32 val)
+{
+	static const u8 div_table[] = { 0, 2, 4, 6, 8, 12, 0, 0 };
+
+	if (val & SL_CLK_DIV3_SWITCH)
+		return 3;
+	if (!(val & SL_CLK_DIV_SWITCH))
+		return 1;
+
+	return div_table[FIELD_GET(SL_CLK_DIV_SEL, val)];
+}
+
+static ulong sl_clk_get_rate(struct clk *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned int divisor = sl_clk_value(readl_relaxed(clk->reg));
+	unsigned long parent_rate = clk_get_parent_rate(&clk->hw);
+
+	if (WARN_ON_ONCE(!divisor))
+		return 0;
+
+	return parent_rate / divisor;
+}
+
+static unsigned int sl_clk_best(unsigned long parent_rate,
+				unsigned long rate)
+{
+	unsigned long best_diff = ULONG_MAX;
+	unsigned int best = 1, i;
+
+	for (i = 0; i < ARRAY_SIZE(sl_clk_values); i++) {
+		unsigned long candidate = parent_rate / sl_clk_values[i];
+		unsigned long diff = candidate > rate ? candidate - rate :
+							     rate - candidate;
+
+		if (diff < best_diff) {
+			best_diff = diff;
+			best = sl_clk_values[i];
+		}
+	}
+
+	return best;
+}
+
+static ulong sl_clk_set_rate(struct clk *hw, unsigned long rate)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long parent_rate = clk_get_parent_rate(&clk->hw);
+	unsigned int divisor, select;
+	unsigned long flags;
+	u32 val;
+
+	divisor = sl_clk_best(parent_rate, rate);
+	if (parent_rate / divisor != rate)
+		return 0;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	val &= ~(SL_CLK_DIV3_SWITCH | SL_CLK_DIV_SWITCH | SL_CLK_DIV_SEL);
+	if (divisor == 3) {
+		val |= SL_CLK_DIV3_SWITCH;
+	} else if (divisor != 1) {
+		switch (divisor) {
+		case 2:
+			select = 1;
+			break;
+		case 4:
+			select = 2;
+			break;
+		case 6:
+			select = 3;
+			break;
+		case 8:
+			select = 4;
+			break;
+		case 12:
+			select = 5;
+			break;
+		default:
+			spin_unlock_irqrestore(clk->lock, flags);
+			return 0;
+		}
+		val |= SL_CLK_DIV_SWITCH |
+			FIELD_PREP(SL_CLK_DIV_SEL, select);
+	}
+	writel_relaxed(val, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return parent_rate / divisor;
+}
+
+static u8 sl_clk_get_parent(struct sl_clk *clk)
+{
+	u32 val = readl_relaxed(clk->reg);
+	u8 selector;
+	unsigned int index;
+
+	if (!(val & SL_CLK_PLL_SWITCH))
+		return 0;
+
+	selector = FIELD_GET(SL_CLK_PLL_SEL, val);
+	index = selector + 1;
+	if (index < clk->num_parents)
+		return index;
+
+	dev_warn(clk->dev, "%s: unsupported parent selector %u\n",
+		 clk_hw_get_name(&clk->hw), selector);
+	return 0;
+}
+
+static int sl_clk_set_parent(struct clk *hw, struct clk *parent)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long flags;
+	u32 val;
+	int index;
+
+	for (index = 0; index < clk->num_parents; index++)
+		if (!strcmp(clk->parent_names[index], clk_hw_get_name(parent)))
+			break;
+
+	if (index == clk->num_parents || index >= SL_MAX_PARENTS)
+		return -EINVAL;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	if (!index) {
+		val &= ~SL_CLK_PLL_SWITCH;
+	} else {
+		val &= ~SL_CLK_PLL_SEL;
+		val |= SL_CLK_PLL_SWITCH |
+			FIELD_PREP(SL_CLK_PLL_SEL, index - 1);
+	}
+	writel_relaxed(val, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static int sl_clk_enable(struct clk *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	writel_relaxed(val | SL_CLK_EN, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static int sl_clk_disable(struct clk *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	writel_relaxed(val & ~SL_CLK_EN, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops sl_clk_ops = {
+	.get_rate = sl_clk_get_rate,
+	.set_rate = sl_clk_set_rate,
+	.set_parent = sl_clk_set_parent,
+	.enable = sl_clk_enable,
+	.disable = sl_clk_disable,
+};
+
+struct clk *sl_clk_register(struct udevice *dev, void __iomem *reg,
+			    const char *name, const char * const *parent_names,
+			    unsigned int num_parents, unsigned long flags)
+{
+	struct sl_clk *clk;
+	struct clk *hw;
+	unsigned int i;
+	int ret;
+
+	if (!dev || !reg || !name || !parent_names || !num_parents ||
+	    num_parents > SL_MAX_PARENTS)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < num_parents; i++)
+		if (!parent_names[i])
+			return ERR_PTR(-EINVAL);
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	clk->dev = dev;
+	clk->reg = reg;
+	/* clk->lock is initialized here for Linux driver */
+	clk->parent_names = parent_names;
+	clk->num_parents = num_parents;
+
+	hw = &clk->hw;
+	hw->flags = flags;
+
+	ret = clk_register(hw, "sl2610_sl_clk", name,
+			   parent_names[sl_clk_get_parent(clk)]);
+	if (ret) {
+		kfree(clk);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+U_BOOT_DRIVER(sl2610_sl_clk) = {
+	.name = "sl2610_sl_clk",
+	.id = UCLASS_CLK,
+	.ops = &sl_clk_ops,
+};
+
diff --git a/drivers/clk/synaptics/sl-clk.h b/drivers/clk/synaptics/sl-clk.h
new file mode 100644
index 000000000000..f2cf99332c83
--- /dev/null
+++ b/drivers/clk/synaptics/sl-clk.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SL_CLK_H
+#define __SL_CLK_H
+
+#include <linux/compiler_types.h>
+
+struct clk;
+struct udevice;
+
+struct sl_clk_desc {
+	const char	*name;
+	u32		id;
+	u32		offset;
+	unsigned long	flags;
+};
+
+struct sl_gateclk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u8		bit_idx;
+	unsigned long	flags;
+};
+
+struct clk *sl_clk_register(struct udevice *dev, void __iomem *reg,
+			    const char *name, const char * const *parent_names,
+			    unsigned int num_parents, unsigned long flags);
+
+#endif /* __SL_CLK_H */
diff --git a/drivers/clk/synaptics/sl-sysmgr-clk.c b/drivers/clk/synaptics/sl-sysmgr-clk.c
new file mode 100644
index 000000000000..a2b6de7d1de8
--- /dev/null
+++ b/drivers/clk/synaptics/sl-sysmgr-clk.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * From Linux: drivers/clk/berlin/sl-sysmgr-clk.c
+ *    Copyright (C) 2026 Synaptics Incorporated
+ *    Author: Jisheng Zhang <jszhang@kernel.org>
+ *
+ */
+
+#include <dm/device.h>
+#include <dm/read.h>
+
+#include <linux/clk-provider.h>
+
+#include "sl-sysmgr-clk.h"
+
+#define SL_SYSMGR_DIV_SHIFT	2
+
+int sl_sysmgr_clk_setup(struct udevice *dev,
+			const struct sl_sysmgr_fixedclk_desc *fdescs,
+			int fclk_n,
+			const struct sl_sysmgr_gateclk_desc *gdescs,
+			int gclk_n,
+			u32 gclk_offset,
+			const struct sl_sysmgr_clk_desc *descs,
+			int clk_n)
+{
+	void __iomem *base;
+	struct udevice *parent;
+	struct clk *clk;
+	int i;
+
+	parent = dev_get_parent(dev);
+	if (!parent)
+		return -ENODEV;
+
+	base = dev_read_addr_ptr(parent);
+	if (!base)
+		return -ENODEV;
+
+	for (i = 0; i < fclk_n; i++) {
+		clk = clk_register_fixed_rate(NULL, fdescs[i].name,
+					      fdescs[i].rate);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		dev_clk_dm(dev, fdescs[i].id, clk);
+	}
+
+	for (i = 0; i < gclk_n; i++) {
+		clk = clk_register_gate(dev, gdescs[i].name,
+					gdescs[i].parent_name, 0,
+					base + gclk_offset, gdescs[i].bit_idx,
+					0, NULL);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		dev_clk_dm(dev, gdescs[i].id, clk);
+	}
+
+	for (i = 0; i < clk_n; i++) {
+		clk = clk_register_divider(dev, descs[i].name,
+					   descs[i].parent_name, 0,
+					   base + descs[i].offset,
+					   SL_SYSMGR_DIV_SHIFT,
+					   descs[i].div_bits, 0);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		dev_clk_dm(dev, descs[i].id, clk);
+	}
+
+	return 0;
+}
+
diff --git a/drivers/clk/synaptics/sl-sysmgr-clk.h b/drivers/clk/synaptics/sl-sysmgr-clk.h
new file mode 100644
index 000000000000..647e469bcc75
--- /dev/null
+++ b/drivers/clk/synaptics/sl-sysmgr-clk.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * From Linux: drivers/clk/berlin/sl-sysmgr-clk.h
+ *    Copyright (C) 2026 Synaptics Incorporated
+ *    Author: Jisheng Zhang <jszhang@kernel.org>
+ *
+ */
+
+#ifndef __SL_SYSMGR_CLK_H
+#define __SL_SYSMGR_CLK_H
+
+struct sl_sysmgr_clk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u32		offset;
+	u8		div_bits;
+	/* TODO flags */
+};
+
+struct sl_sysmgr_gateclk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u8		bit_idx;
+	/* TODO flags */
+};
+
+struct sl_sysmgr_fixedclk_desc {
+	const char	*name;
+	u32		id;
+	unsigned long	rate;
+};
+
+int sl_sysmgr_clk_setup(struct udevice *dev,
+			const struct sl_sysmgr_fixedclk_desc *fdescs,
+			int fclk_n,
+			const struct sl_sysmgr_gateclk_desc *gdescs,
+			int gclk_n,
+			u32 gclk_offset,
+			const struct sl_sysmgr_clk_desc *descs,
+			int clk_n);
+
+#endif
diff --git a/drivers/clk/synaptics/sl2610-pll.c b/drivers/clk/synaptics/sl2610-pll.c
new file mode 100644
index 000000000000..1ee421faa540
--- /dev/null
+++ b/drivers/clk/synaptics/sl2610-pll.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * Author: Richard Genoud <richard.genoud@bootlin.com>
+ *
+ * From Linux drivers/clk/berlin/sl2610-pll.c:
+ *    Copyright (C) 2019-2021 Synaptics Incorporated
+ *    Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <clk-uclass.h>
+#include <div64.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+
+#define FRAC_BITS		24
+
+#define CTRLC			0x08
+#define DIVR_MASK		GENMASK(8, 0)
+#define CTRLD			0x0c
+#define DIVF_MASK		GENMASK(8, 0)
+#define CTRLE			0x10
+#define DIVFF_MASK		GENMASK(23, 0)
+#define CTRLF			0x14
+#define DIVQ_MASK		GENMASK(4, 0)
+#define CTRLG			0x18
+#define DIVQF_MASK		GENMASK(2, 0)
+
+struct sl2610_pll {
+	void __iomem	*ctrl;
+	struct clk	pllout;
+	struct clk	plloutf;
+};
+
+#define to_pllout(_clk)		container_of(_clk, struct sl2610_pll, pllout)
+#define to_plloutf(_clk)	container_of(_clk, struct sl2610_pll, plloutf)
+
+static unsigned long sl2610_pll_recalc_rate(struct sl2610_pll *pll,
+					    unsigned long parent_rate, bool fractional_output)
+{
+	u32 dm, dn, frac, dp;
+	u64 rate;
+
+	dm = (readl_relaxed(pll->ctrl + CTRLC) & DIVR_MASK) + 1;
+	dn = (readl_relaxed(pll->ctrl + CTRLD) & DIVF_MASK) + 1;
+	frac = readl_relaxed(pll->ctrl + CTRLE) & DIVFF_MASK;
+
+	if (fractional_output)
+		dp = (readl_relaxed(pll->ctrl + CTRLG) & DIVQF_MASK) + 1;
+	else
+		dp = ((readl_relaxed(pll->ctrl + CTRLF) & DIVQ_MASK) + 1) * 2;
+
+	rate = (u64)parent_rate * dn;
+	rate += ((u64)parent_rate * frac + BIT_ULL(FRAC_BITS - 1)) >> FRAC_BITS;
+	rate = DIV_ROUND_CLOSEST_ULL(rate * 4, (u64)dm * dp);
+
+	return rate;
+}
+
+static unsigned long sl2610_pllout_recalc_rate(struct clk *clk)
+{
+	return sl2610_pll_recalc_rate(to_pllout(clk), clk_get_parent_rate(clk),
+				      false);
+}
+
+static unsigned long sl2610_plloutf_recalc_rate(struct clk *clk)
+{
+	return sl2610_pll_recalc_rate(to_plloutf(clk), clk_get_parent_rate(clk),
+				      true);
+}
+
+static const struct clk_ops sl2610_pllout_ops = {
+	.get_rate = sl2610_pllout_recalc_rate,
+};
+
+static const struct clk_ops sl2610_plloutf_ops = {
+	.get_rate = sl2610_plloutf_recalc_rate,
+};
+
+int sl2610_pll_register(struct udevice *dev, void __iomem *ctrl,
+			const char *out, const char *outf)
+{
+	struct sl2610_pll *pll;
+	struct clk clk;
+	int ret;
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return ret;
+
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return -ENOMEM;
+
+	pll->ctrl = ctrl;
+	pll->pllout.flags = CLK_GET_RATE_NOCACHE;
+	pll->plloutf.flags = CLK_GET_RATE_NOCACHE;
+
+	ret = clk_register(&pll->pllout, "sl2610_pll_out", out,
+			   clk.dev->name);
+	if (ret)
+		return ret;
+
+	ret = clk_register(&pll->plloutf, "sl2610_pll_outf", outf,
+			   clk.dev->name);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(sl2610_pll_out) = {
+	.name = "sl2610_pll_out",
+	.id = UCLASS_CLK,
+	.ops = &sl2610_pllout_ops,
+};
+
+U_BOOT_DRIVER(sl2610_pll_outf) = {
+	.name = "sl2610_pll_outf",
+	.id = UCLASS_CLK,
+	.ops = &sl2610_plloutf_ops,
+};
diff --git a/drivers/clk/synaptics/sl2610-pll.h b/drivers/clk/synaptics/sl2610-pll.h
new file mode 100644
index 000000000000..7ee1764b3b9f
--- /dev/null
+++ b/drivers/clk/synaptics/sl2610-pll.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SL2610_PLL_H
+#define __SL2610_PLL_H
+
+#include <linux/io.h>
+
+struct udevice;
+
+int sl2610_pll_register(struct udevice *dev, void __iomem *ctrl,
+			const char *out, const char *outf);
+
+#endif /* __SL2610_PLL_H */

-- 
2.55.0

