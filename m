Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BC606A337
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kNJkpXZM;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=e43gjjys
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA90960E8D;
	Fri, 13 Nov 2026 02:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jeLWpfZTdzXO; Fri, 13 Nov 2026 02:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C6EB60E8A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537209;
	b=ZBYtXaRtNJJ+e/0ZJHTFTkJlAlxLK3snBnc4PCLueuvEt6zM8bTmUKAneNpIwsPvpuPZ
	 qLXuc7uiAX33jWGUa1EdCaLmw/NeWQh3q+ZEzfpgrI8MRg2O58CUJU8/m29SS1P4WCXIi
	 nSUcJos073GQRDjdC9RWDBNIGaAN1VPFAJ1xPaobZnjdJahkS8AQshb2Nszok1J24CI/j
	 Q7Bz2gTjHintbEpTVpC35Yy5Xwv2bzbtzYu2+9/j3xiGdHM2+2QRPaJuvnKnPjsHl/tUf
	 VTLf4RGOibEhGIxsYGUa0TsW4Iu6F12tTG2oVdroKYtJZmx8/O+KZWtwP9QfBVA4AnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ci033KVbNZNXa+5lnNgRZ7vQBCWDt/fuKsIENlJB7/g=;
	b=aPCd0nN0TUkJFypzQso/Y+ALpnpMi49YGIdr4KQlprKsrAQ6jHstXAfnbwHO6mQbjA4l
	 lJN4PtAraeWnKdXeaoI4YXlmDYO1SV6vbhI8E2KP/t9nRZ5VM6dTdc0cQrWyHpLEtndtA
	 fJWuFaK+lt27V/pbl1YKm7LBGi2PI9tKwxkJGiUgo9r/6+qsmvh4yrHQawoXOjLlSE2yr
	 tdWaE7X//m2/io+iZcgy37hLtljRB/+Cq6uzNin/T3p7NZTk2IiWp8Di3Fc7wYGDEVVsk
	 vX/PRHoyouHty/ioOOEYyQ/Wi0+rwx32ylmWR3tCm1wAJjYic1weOL9+UwRgnkF4uJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537209;
	bh=Ci033KVbNZNXa+5lnNgRZ7vQBCWDt/fuKsIENlJB7/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNJkpXZM6TABFvCiX4lkjpNwGj3bTL9E7Mgxf+VfHLaR2n6xYVRl/1U6qCeh9leu2
	 At6JQ+UDh9JdGCYHqiijrsRYA2eq+2fQKCg7W/6lCoLXujgTOZB3L8oHMt5MgDdqAw
	 GJs8QnwOuK6+n+zEz3xilQfozzwIOulSRwwPqvEkGQR2IWP9qDw6PBFjCPIxOeyk2N
	 W7Uo92HqCXjVQrm9QCtr/3ayexS6ULO1iCS4vE4/CbDswHsInIe06RL//baootoTmy
	 vaHYtEb+s1bW/4ewCIO2NImQjPqBSEAEu0I/GrIthDi8F3HrhtSYXPnMbA0/kGE1qk
	 zwnodJmWPNgDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C6EB60E8A;
	Fri, 13 Nov 2026 02:33:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF19B2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A128E40D44
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuKn6w2KCcQe for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78DCD40D2E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=e43gjjys
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78DCD40D2E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:25 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id B739645735;
 Fri, 13 Nov 2026 13:33:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ci033KVbNZNXa+5lnNgRZ7vQBCWDt/fuKsIENlJB7/g=;
 b=e43gjjyskPyC5//D9kuX+rnckHdNl15xR2Rlsc0f7pAUhif6tK9aGhAyy0++n9fQZEyWg5
 Feqlw7BF8vnFr1AqjviLWIrGvLqvxaex3rkQ6qXqOIQvi9+0qCU2LXbmSrpWWpNfL27FrG
 pLR0+cgChFIS0wsWxJB/yqjZqXSdvGUPMqsPwgZBo34BTWzGLNG+D3+8ViSQElt0fFZcTn
 IlgNfb0PnIAANJQf/rf/9gf2SY92VW4kCEuCN0y8hKQEnO6oF6aep1j8kGxixdkql5YQXM
 DqOcCDwplevPpNqgrBawi34F448HtjZulI65CX7H0aXvCdfQqRpF13kK/c6oiQ==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 08/26] clock: reset: a733: add initial support
Date: Fri, 13 Nov 2026 13:32:18 +1100
Message-ID: <20261113023236.569054-9-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Yixun Lan <dlan@gentoo.org>

Implement clock gate and reset driver support for the Allwinner A733
CCU and PRCM (R-CCU), using the v6 upstream Linux DT binding headers.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-5-f19dcd098f60@gentoo.org
[Alastair: update to v6 allwinner,sun60i-a733-ccu.h bindings, fix I2C2/3
 reset offsets, add MMC0-2/USB OTG/R_SPI gates, constify tables]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/clk/sunxi/Kconfig      |  14 ++++
 drivers/clk/sunxi/Makefile     |   2 +
 drivers/clk/sunxi/clk_a733.c   | 132 +++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk_a733_r.c |  45 +++++++++++
 drivers/clk/sunxi/clk_sunxi.c  |  10 +++
 5 files changed, 203 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk_a733.c
 create mode 100644 drivers/clk/sunxi/clk_a733_r.c

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 1c1cc82719c..9858f4546ea 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -143,4 +143,18 @@ config CLK_SUN55I_A523_R
 	  This enables common clock driver support for the PRCM
 	  in Allwinner A523/T527 SoCs.
 
+config CLK_SUN60I_A733
+	bool "Clock driver for Allwinner A733/T736"
+	default MACH_SUN60I_A733
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner A733/T736 SoC.
+
+config CLK_SUN60I_A733_R
+	bool "Clock driver for Allwinner A733 generation PRCM"
+	default MACH_SUN60I_A733
+	help
+	  This enables common clock driver support for the PRCM
+	  in Allwinner A733/T736 SoCs.
+
 endif # CLK_SUNXI
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 93b542cebcd..943e47612ce 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -27,3 +27,5 @@ obj-$(CONFIG_CLK_SUN50I_A64) += clk_a64.o
 obj-$(CONFIG_CLK_SUN50I_A100) += clk_a100.o
 obj-$(CONFIG_CLK_SUN55I_A523) += clk_a523.o
 obj-$(CONFIG_CLK_SUN55I_A523_R) += clk_a523_r.o
+obj-$(CONFIG_CLK_SUN60I_A733) += clk_a733.o
+obj-$(CONFIG_CLK_SUN60I_A733_R) += clk_a733_r.o
diff --git a/drivers/clk/sunxi/clk_a733.c b/drivers/clk/sunxi/clk_a733.c
new file mode 100644
index 00000000000..5c942fd5d58
--- /dev/null
+++ b/drivers/clk/sunxi/clk_a733.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025-2026 Yixun Lan <dlan@gentoo.org>
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#include <clk/sunxi.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/allwinner,sun60i-a733-ccu.h>
+#include <dt-bindings/reset/allwinner,sun60i-a733-ccu.h>
+
+static const struct ccu_clk_gate a733_gates[] = {
+	[CLK_SYS_24M]		= GATE_DUMMY,
+	[CLK_PLL_PERIPH0_200M]	= GATE_DUMMY,
+	[CLK_PLL_PERIPH0_300M]	= GATE_DUMMY,
+	[CLK_PLL_PERIPH1_300M]	= GATE_DUMMY,
+	[CLK_APB1]		= GATE_DUMMY,
+	[CLK_APB_UART]		= GATE_DUMMY,
+
+	[CLK_MBUS_GMAC0]	= GATE(0x05e4, BIT(11)),
+	[CLK_BUS_CE]		= GATE(0x0ac4, BIT(0)),
+
+	[CLK_MMC0]		= GATE(0x0d00, BIT(31)),
+	[CLK_BUS_MMC0]		= GATE(0x0d0c, BIT(0)),
+	[CLK_MMC1]		= GATE(0x0d10, BIT(31)),
+	[CLK_BUS_MMC1]		= GATE(0x0d1c, BIT(0)),
+	[CLK_MMC2]		= GATE(0x0d20, BIT(31)),
+	[CLK_BUS_MMC2]		= GATE(0x0d2c, BIT(0)),
+
+	[CLK_BUS_UART0]		= GATE(0x0e00, BIT(0)),
+	[CLK_BUS_UART1]		= GATE(0x0e04, BIT(0)),
+	[CLK_BUS_UART2]		= GATE(0x0e08, BIT(0)),
+	[CLK_BUS_UART3]		= GATE(0x0e0c, BIT(0)),
+	[CLK_BUS_UART4]		= GATE(0x0e10, BIT(0)),
+	[CLK_BUS_UART5]		= GATE(0x0e14, BIT(0)),
+	[CLK_BUS_UART6]		= GATE(0x0e18, BIT(0)),
+
+	[CLK_BUS_I2C0]		= GATE(0x0e80, BIT(0)),
+	[CLK_BUS_I2C1]		= GATE(0x0e84, BIT(0)),
+	[CLK_BUS_I2C2]		= GATE(0x0e88, BIT(0)),
+	[CLK_BUS_I2C3]		= GATE(0x0e8c, BIT(0)),
+	[CLK_BUS_I2C4]		= GATE(0x0e90, BIT(0)),
+	[CLK_BUS_I2C5]		= GATE(0x0e94, BIT(0)),
+	[CLK_BUS_I2C6]		= GATE(0x0e98, BIT(0)),
+	[CLK_BUS_I2C7]		= GATE(0x0e9c, BIT(0)),
+	[CLK_BUS_I2C8]		= GATE(0x0ea0, BIT(0)),
+	[CLK_BUS_I2C9]		= GATE(0x0ea4, BIT(0)),
+	[CLK_BUS_I2C10]		= GATE(0x0ea8, BIT(0)),
+	[CLK_BUS_I2C11]		= GATE(0x0eac, BIT(0)),
+	[CLK_BUS_I2C12]		= GATE(0x0eb0, BIT(0)),
+
+	[CLK_SPI0]		= GATE(0x0f00, BIT(31)),
+	[CLK_BUS_SPI0]		= GATE(0x0f04, BIT(0)),
+	[CLK_SPI1]		= GATE(0x0f08, BIT(31)),
+	[CLK_BUS_SPI1]		= GATE(0x0f0c, BIT(0)),
+	[CLK_SPI2]		= GATE(0x0f10, BIT(31)),
+	[CLK_BUS_SPI2]		= GATE(0x0f14, BIT(0)),
+
+	[CLK_GPADC0_24M]	= GATE(0x0fc0, BIT(31)),
+	[CLK_BUS_GPADC0]	= GATE(0x0fc4, BIT(0)),
+	[CLK_BUS_THS0]		= GATE(0x0fe4, BIT(0)),
+	[CLK_BUS_LRADC]		= GATE(0x1024, BIT(0)),
+
+	[CLK_USB_OHCI0]		= GATE(0x1300, BIT(31)),
+	[CLK_BUS_OHCI0]		= GATE(0x1304, BIT(0)),
+	[CLK_BUS_EHCI0]		= GATE(0x1304, BIT(4)),
+	[CLK_BUS_OTG]		= GATE(0x1304, BIT(8)),
+	[CLK_USB_OHCI1]		= GATE(0x1308, BIT(31)),
+	[CLK_BUS_OHCI1]		= GATE(0x130c, BIT(0)),
+	[CLK_BUS_EHCI1]		= GATE(0x130c, BIT(4)),
+
+	[CLK_GMAC0_PHY]		= GATE(0x1410, BIT(31)),
+	[CLK_BUS_GMAC0]		= GATE(0x141c, BIT(0)),
+};
+
+static const struct ccu_reset a733_resets[] = {
+	[RST_BUS_CE]		= RESET(0x0ac4, BIT(16)),
+
+	[RST_BUS_MMC0]		= RESET(0x0d0c, BIT(16)),
+	[RST_BUS_MMC1]		= RESET(0x0d1c, BIT(16)),
+	[RST_BUS_MMC2]		= RESET(0x0d2c, BIT(16)),
+
+	[RST_BUS_UART0]		= RESET(0x0e00, BIT(16)),
+	[RST_BUS_UART1]		= RESET(0x0e04, BIT(16)),
+	[RST_BUS_UART2]		= RESET(0x0e08, BIT(16)),
+	[RST_BUS_UART3]		= RESET(0x0e0c, BIT(16)),
+	[RST_BUS_UART4]		= RESET(0x0e10, BIT(16)),
+	[RST_BUS_UART5]		= RESET(0x0e14, BIT(16)),
+	[RST_BUS_UART6]		= RESET(0x0e18, BIT(16)),
+
+	[RST_BUS_I2C0]		= RESET(0x0e80, BIT(16)),
+	[RST_BUS_I2C1]		= RESET(0x0e84, BIT(16)),
+	[RST_BUS_I2C2]		= RESET(0x0e88, BIT(16)),
+	[RST_BUS_I2C3]		= RESET(0x0e8c, BIT(16)),
+	[RST_BUS_I2C4]		= RESET(0x0e90, BIT(16)),
+	[RST_BUS_I2C5]		= RESET(0x0e94, BIT(16)),
+	[RST_BUS_I2C6]		= RESET(0x0e98, BIT(16)),
+	[RST_BUS_I2C7]		= RESET(0x0e9c, BIT(16)),
+	[RST_BUS_I2C8]		= RESET(0x0ea0, BIT(16)),
+	[RST_BUS_I2C9]		= RESET(0x0ea4, BIT(16)),
+	[RST_BUS_I2C10]		= RESET(0x0ea8, BIT(16)),
+	[RST_BUS_I2C11]		= RESET(0x0eac, BIT(16)),
+	[RST_BUS_I2C12]		= RESET(0x0eb0, BIT(16)),
+
+	[RST_BUS_SPI0]		= RESET(0x0f04, BIT(16)),
+	[RST_BUS_SPI1]		= RESET(0x0f0c, BIT(16)),
+	[RST_BUS_SPI2]		= RESET(0x0f14, BIT(16)),
+
+	[RST_BUS_GPADC0]	= RESET(0x0fc4, BIT(16)),
+	[RST_BUS_THS0]		= RESET(0x0fe4, BIT(16)),
+	[RST_BUS_LRADC]		= RESET(0x1024, BIT(16)),
+
+	[RST_USB_PHY0]		= RESET(0x1300, BIT(30)),
+	[RST_BUS_OHCI0]		= RESET(0x1304, BIT(16)),
+	[RST_BUS_EHCI0]		= RESET(0x1304, BIT(20)),
+	[RST_BUS_OTG]		= RESET(0x1304, BIT(24)),
+	[RST_USB_PHY1]		= RESET(0x1308, BIT(30)),
+	[RST_BUS_OHCI1]		= RESET(0x130c, BIT(16)),
+	[RST_BUS_EHCI1]		= RESET(0x130c, BIT(20)),
+
+	[RST_BUS_GMAC0]		= RESET(0x141c, BIT(16)),
+	[RST_BUS_GMAC0_AXI]	= RESET(0x141c, BIT(17)),
+};
+
+const struct ccu_desc a733_ccu_desc = {
+	.gates		= a733_gates,
+	.resets		= a733_resets,
+	.num_gates	= ARRAY_SIZE(a733_gates),
+	.num_resets	= ARRAY_SIZE(a733_resets),
+};
diff --git a/drivers/clk/sunxi/clk_a733_r.c b/drivers/clk/sunxi/clk_a733_r.c
new file mode 100644
index 00000000000..ae02dd21de5
--- /dev/null
+++ b/drivers/clk/sunxi/clk_a733_r.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025-2026 Yixun Lan <dlan@gentoo.org>
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#include <clk/sunxi.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h>
+#include <dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h>
+
+static const struct ccu_clk_gate a733_r_gates[] = {
+	[CLK_R_AHB]		= GATE_DUMMY,
+	[CLK_R_APB0]		= GATE_DUMMY,
+	[CLK_R_APB1]		= GATE_DUMMY,
+	[CLK_R_SPI]		= GATE(0x150, BIT(31)),
+	[CLK_BUS_R_SPI]		= GATE(0x15c, BIT(0)),
+	[CLK_BUS_R_UART0]	= GATE(0x18c, BIT(0)),
+	[CLK_BUS_R_UART1]	= GATE(0x18c, BIT(1)),
+	[CLK_BUS_R_I2C0]	= GATE(0x19c, BIT(0)),
+	[CLK_BUS_R_I2C1]	= GATE(0x19c, BIT(1)),
+	[CLK_BUS_R_I2C2]	= GATE(0x19c, BIT(2)),
+	[CLK_BUS_R_RTC]		= GATE(0x20c, BIT(0)),
+	[CLK_BUS_R_CPUCFG]	= GATE(0x22c, BIT(0)),
+};
+
+static const struct ccu_reset a733_r_resets[] = {
+	[RST_BUS_R_SPI]		= RESET(0x15c, BIT(16)),
+	[RST_BUS_R_UART0]	= RESET(0x18c, BIT(16)),
+	[RST_BUS_R_UART1]	= RESET(0x18c, BIT(17)),
+	[RST_BUS_R_I2C0]	= RESET(0x19c, BIT(16)),
+	[RST_BUS_R_I2C1]	= RESET(0x19c, BIT(17)),
+	[RST_BUS_R_I2C2]	= RESET(0x19c, BIT(18)),
+	[RST_BUS_R_RTC]		= RESET(0x20c, BIT(16)),
+	[RST_BUS_R_CPUCFG]	= RESET(0x22c, BIT(16)),
+};
+
+const struct ccu_desc a733_r_ccu_desc = {
+	.gates		= a733_r_gates,
+	.resets		= a733_r_resets,
+	.num_gates	= ARRAY_SIZE(a733_r_gates),
+	.num_resets	= ARRAY_SIZE(a733_r_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index 046d5d1605a..6d55b4598a5 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -128,6 +128,8 @@ extern const struct ccu_desc r40_ccu_desc;
 extern const struct ccu_desc v3s_ccu_desc;
 extern const struct ccu_desc a523_ccu_desc;
 extern const struct ccu_desc a523_r_ccu_desc;
+extern const struct ccu_desc a733_ccu_desc;
+extern const struct ccu_desc a733_r_ccu_desc;
 
 static const struct udevice_id sunxi_clk_ids[] = {
 #ifdef CONFIG_CLK_SUN4I_A10
@@ -233,6 +235,14 @@ static const struct udevice_id sunxi_clk_ids[] = {
 #ifdef CONFIG_CLK_SUN55I_A523_R
 	{ .compatible = "allwinner,sun55i-a523-r-ccu",
 	  .data = (ulong)&a523_r_ccu_desc },
+#endif
+#ifdef CONFIG_CLK_SUN60I_A733
+	{ .compatible = "allwinner,sun60i-a733-ccu",
+	  .data = (ulong)&a733_ccu_desc },
+#endif
+#ifdef CONFIG_CLK_SUN60I_A733_R
+	{ .compatible = "allwinner,sun60i-a733-r-ccu",
+	  .data = (ulong)&a733_r_ccu_desc },
 #endif
 	{ }
 };
-- 
2.53.0

