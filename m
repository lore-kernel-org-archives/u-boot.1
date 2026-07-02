Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E59C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF25848DC;
	Thu,  2 Jul 2026 12:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6DE849F6; Thu,  2 Jul 2026 12:09:00 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91C38498C
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=billy_tsai@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 2 Jul
 2026 18:08:37 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Jul 2026 18:08:37 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 2 Jul 2026 18:08:34 +0800
Subject: [PATCH 1/4] pinctrl: aspeed: Add AST2700 SoC0 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-pinctrl-v1-1-4d2bd89fc213@aspeedtech.com>
References: <20260702-pinctrl-v1-0-4d2bd89fc213@aspeedtech.com>
In-Reply-To: <20260702-pinctrl-v1-0-4d2bd89fc213@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Peng Fan <peng.fan@nxp.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>, Sean Anderson
 <sean.anderson@linux.dev>, Michal Simek <michal.simek@amd.com>, "Leo Yu-Chi
 Liang" <ycliang@andestech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782986917; l=17678;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=xOXecqXYVfgG0c0xw5oYyEqGD3D2ETRcL53zRoHujLo=;
 b=obKGAO2CLSOB5MZypsUPFT/FR1wxNOAIt5ESvAn1A/oTYI4DyqUegGKjklDkVijdPVLE0cFKj
 hZGs6NplEAKCWw+t5majPuq12lpT36bBH8ehv7saphA6CVOJdrjspi7
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
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

The AST2700 is a dual-die BMC SoC: SoC0 (CPU die) and SoC1 (I/O die)
each have their own SCU with independent multi-function pin controls.

Add the pinctrl driver for the SoC0 die. The driver uses the generic
pinctrl framework and is compatible with the Linux kernel device tree
bindings, i.e. pin states are described with the same "function" and
"groups" properties and the same names as the Linux
aspeed,ast2700-soc0-pinctrl driver.

Unlike the older AST2500/AST2600 SCUs where each signal is enabled by
independent bits, the SoC0 mux selections mix single-bit enables
(eMMC, VGA DDC, VB strap), multi-bit selector fields (JTAG master port
select, USB2/USB3 port routing) and reset-control bits (PCIe RC
PERST). Model each (function, group) pair as one register
mask/value write so all of them fit a single flat table.

The gpio_request_enable hook releases the GPIO18A/GPIO18B pins to GPIO
mode by clearing every signal enable bit that claims the pin, matching
the Linux driver behaviour.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pinctrl/Kconfig                       |   9 +
 drivers/pinctrl/aspeed/Makefile               |   1 +
 drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c | 486 ++++++++++++++++++++++++++
 3 files changed, 496 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 578edbf8168..35b3f3afa66 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -378,6 +378,15 @@ config ASPEED_AST2600_PINCTRL
 	  uses Generic Pinctrl framework and is compatible with the Linux
 	  driver, i.e. it uses the same device tree configuration.
 
+config ASPEED_AST2700_SOC0_PINCTRL
+	bool "Aspeed AST2700 SoC0 pin control driver"
+	depends on DM && PINCTRL_GENERIC && ASPEED_AST2700
+	default y
+	help
+	  Support pin multiplexing control on Aspeed ast2700 SoC0. The driver
+	  uses Generic Pinctrl framework and is compatible with the Linux
+	  driver, i.e. it uses the same device tree configuration.
+
 config PINCTRL_K210
 	bool "Kendryte K210 Fully-Programmable Input/Output Array driver"
 	depends on DM && PINCTRL_GENERIC
diff --git a/drivers/pinctrl/aspeed/Makefile b/drivers/pinctrl/aspeed/Makefile
index a3e01ed1ca9..a0da1d7403d 100644
--- a/drivers/pinctrl/aspeed/Makefile
+++ b/drivers/pinctrl/aspeed/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ASPEED_AST2500_PINCTRL) += pinctrl_ast2500.o
 obj-$(CONFIG_ASPEED_AST2600_PINCTRL) += pinctrl_ast2600.o
+obj-$(CONFIG_ASPEED_AST2700_SOC0_PINCTRL) += pinctrl_ast2700_soc0.o
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c b/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c
new file mode 100644
index 00000000000..9a973285b0b
--- /dev/null
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <errno.h>
+#include <vsprintf.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#define SCU010			0x010
+#define SCU200			0x200
+#define SCU400			0x400
+#define SCU404			0x404
+#define SCU408			0x408
+#define SCU410			0x410
+
+#define USB_PORTA_ROUTE	BIT(9)
+#define USB_PORTB_ROUTE	BIT(10)
+
+#define PORTA_U3_MODE		GENMASK(1, 0)
+#define PORTA_U2_MODE		GENMASK(3, 2)
+#define PORTB_U3_MODE		GENMASK(5, 4)
+#define PORTB_U2_MODE		GENMASK(7, 6)
+#define PORTA_MODE		GENMASK(25, 24)
+#define PORTB_MODE		GENMASK(29, 28)
+
+#define PINMUX(_function, _group, _offset, _mask, _val)	\
+	{							\
+		.function = _function,				\
+		.group = _group,				\
+		.offset = _offset,				\
+		.mask = _mask,					\
+		.val = _val,					\
+	}
+
+struct ast2700_soc0_pinmux {
+	const char *function;
+	const char *group;
+	u32 offset;
+	u32 mask;
+	u32 val;
+};
+
+struct ast2700_soc0_sig {
+	u32 offset;
+	u32 mask;
+	const char *name;
+};
+
+struct ast2700_soc0_pin {
+	const char *name;
+	const struct ast2700_soc0_sig *sigs;
+	unsigned int nsigs;
+};
+
+struct ast2700_soc0_pinctrl_priv {
+	void __iomem *base;
+};
+
+static const char * const ast2700_soc0_groups[] = {
+	"EMMCG1",
+	"EMMCG4",
+	"EMMCG8",
+	"EMMCWPN",
+	"EMMCCDN",
+	"VGADDC",
+	"VB1",
+	"VB0",
+	"TSPRSTN",
+	"UFSCLKI",
+	"USB3A",
+	"USB3AAP",
+	"USB3ABP",
+	"USB3B",
+	"USB3BAP",
+	"USB3BBP",
+	"USB2A",
+	"USB2AAP",
+	"USB2ABP",
+	"USB2ADAP",
+	"USB2AH",
+	"USB2AHAP",
+	"USB2B",
+	"USB2BBP",
+	"USB2BAP",
+	"USB2BDBP",
+	"USB2BH",
+	"USB2BHBP",
+	"JTAG0",
+	"PCIERC0PERST",
+	"PCIERC1PERST",
+};
+
+static const char * const ast2700_soc0_functions[] = {
+	"EMMC",
+	"VB",
+	"TSPRSTN",
+	"UFSCLKI",
+	"VGADDC",
+	"USB3AXHD",
+	"USB3AXHPD",
+	"USB3AXH",
+	"USB3AXHP",
+	"USB3AXH2B",
+	"USB3AXHP2B",
+	"USB3BXHD",
+	"USB3BXHPD",
+	"USB3BXH",
+	"USB3BXHP",
+	"USB3BXH2A",
+	"USB3BXHP2A",
+	"USB2AXHD1",
+	"USB2AXHPD1",
+	"USB2AXH",
+	"USB2AXHP",
+	"USB2AXH2B",
+	"USB2AXHP2B",
+	"USB2AD1",
+	"USB2AHPD0",
+	"USB2AH",
+	"USB2AHP",
+	"USB2AD0",
+	"USB2BXHD1",
+	"USB2BXHPD1",
+	"USB2BXH",
+	"USB2BXHP",
+	"USB2BXH2A",
+	"USB2BXHP2A",
+	"USB2BD1",
+	"USB2BHPD0",
+	"USB2BH",
+	"USB2BHP",
+	"USB2BD0",
+	"JTAGPSP",
+	"JTAGSSP",
+	"JTAGTSP",
+	"JTAGDDR",
+	"JTAGUSB3A",
+	"JTAGUSB3B",
+	"JTAGPCIEA",
+	"JTAGPCIEB",
+	"JTAGM0",
+	"PCIERC0PERST",
+	"PCIERC1PERST",
+};
+
+static const struct ast2700_soc0_pinmux ast2700_soc0_pinmuxes[] = {
+	PINMUX("EMMC", "EMMCG1", SCU400, GENMASK(2, 0), GENMASK(2, 0)),
+	PINMUX("EMMC", "EMMCG4", SCU400, GENMASK(5, 0), GENMASK(5, 0)),
+	PINMUX("EMMC", "EMMCG8", SCU400,
+	       GENMASK(5, 0) | GENMASK(11, 8),
+	       GENMASK(5, 0) | GENMASK(11, 8)),
+	PINMUX("EMMC", "EMMCWPN", SCU400, BIT(7), BIT(7)),
+	PINMUX("EMMC", "EMMCCDN", SCU400, BIT(6), BIT(6)),
+	PINMUX("VB", "VB1", SCU404, GENMASK(3, 0), GENMASK(3, 0)),
+	PINMUX("VB", "VB0", SCU010, BIT(17), BIT(17)),
+	PINMUX("TSPRSTN", "TSPRSTN", SCU010, BIT(9), BIT(9)),
+	PINMUX("UFSCLKI", "UFSCLKI", SCU010, BIT(19), BIT(19)),
+	PINMUX("VGADDC", "VGADDC", SCU404, GENMASK(11, 10),
+	       GENMASK(11, 10)),
+
+	/*
+	 * The Linux driver models the USB2/USB3 routing with additional
+	 * virtual PHY pins (PORTA/PORTB_U2_PHY, PORTA/PORTB_U3_PHY) purely
+	 * to reject conflicting cross-coupled selections; they carry no
+	 * register writes. U-Boot applies the states given by the device
+	 * tree without strict conflict checking, so only the real selector
+	 * fields are programmed here while the group names stay identical.
+	 */
+	PINMUX("USB3AXHD", "USB3A", SCU410,
+	       PORTA_U3_MODE | USB_PORTA_ROUTE, USB_PORTA_ROUTE),
+	PINMUX("USB3AXHPD", "USB3A", SCU410,
+	       PORTA_U3_MODE | USB_PORTA_ROUTE, 0),
+	PINMUX("USB3AXH", "USB3AAP", SCU410,
+	       PORTA_U3_MODE | USB_PORTA_ROUTE, (2 << 0) | USB_PORTA_ROUTE),
+	PINMUX("USB3AXHP", "USB3AAP", SCU410,
+	       PORTA_U3_MODE | USB_PORTA_ROUTE, 2 << 0),
+	PINMUX("USB3AXH2B", "USB3ABP", SCU410,
+	       PORTA_U3_MODE | USB_PORTA_ROUTE, (3 << 0) | USB_PORTA_ROUTE),
+	PINMUX("USB3AXHP2B", "USB3ABP", SCU410,
+	       PORTA_U3_MODE | USB_PORTA_ROUTE, 3 << 0),
+
+	PINMUX("USB3BXHD", "USB3B", SCU410,
+	       PORTB_U3_MODE | USB_PORTB_ROUTE, USB_PORTB_ROUTE),
+	PINMUX("USB3BXHPD", "USB3B", SCU410,
+	       PORTB_U3_MODE | USB_PORTB_ROUTE, 0),
+	PINMUX("USB3BXH", "USB3BBP", SCU410,
+	       PORTB_U3_MODE | USB_PORTB_ROUTE, (2 << 4) | USB_PORTB_ROUTE),
+	PINMUX("USB3BXHP", "USB3BBP", SCU410,
+	       PORTB_U3_MODE | USB_PORTB_ROUTE, 2 << 4),
+	PINMUX("USB3BXH2A", "USB3BAP", SCU410,
+	       PORTB_U3_MODE | USB_PORTB_ROUTE, (3 << 4) | USB_PORTB_ROUTE),
+	PINMUX("USB3BXHP2A", "USB3BAP", SCU410,
+	       PORTB_U3_MODE | USB_PORTB_ROUTE, 3 << 4),
+
+	PINMUX("USB2AXHD1", "USB2A", SCU410,
+	       PORTA_U2_MODE | USB_PORTA_ROUTE, USB_PORTA_ROUTE),
+	PINMUX("USB2AXHPD1", "USB2A", SCU410,
+	       PORTA_U2_MODE | USB_PORTA_ROUTE, 0),
+	PINMUX("USB2AXH", "USB2AAP", SCU410,
+	       PORTA_U2_MODE | USB_PORTA_ROUTE, (2 << 2) | USB_PORTA_ROUTE),
+	PINMUX("USB2AXHP", "USB2AAP", SCU410,
+	       PORTA_U2_MODE | USB_PORTA_ROUTE, 2 << 2),
+	PINMUX("USB2AXH2B", "USB2ABP", SCU410,
+	       PORTA_U2_MODE | USB_PORTA_ROUTE, (3 << 2) | USB_PORTA_ROUTE),
+	PINMUX("USB2AXHP2B", "USB2ABP", SCU410,
+	       PORTA_U2_MODE | USB_PORTA_ROUTE, 3 << 2),
+	PINMUX("USB2AD1", "USB2ADAP", SCU410, PORTA_U2_MODE, 1 << 2),
+	PINMUX("USB2AHPD0", "USB2AH", SCU410, PORTA_MODE, 0),
+	PINMUX("USB2AH", "USB2AHAP", SCU410, PORTA_MODE, 2 << 24),
+	PINMUX("USB2AHP", "USB2AHAP", SCU410, PORTA_MODE, 3 << 24),
+	PINMUX("USB2AD0", "USB2AHAP", SCU410, PORTA_MODE, 1 << 24),
+
+	PINMUX("USB2BXHD1", "USB2B", SCU410,
+	       PORTB_U2_MODE | USB_PORTB_ROUTE, USB_PORTB_ROUTE),
+	PINMUX("USB2BXHPD1", "USB2B", SCU410,
+	       PORTB_U2_MODE | USB_PORTB_ROUTE, 0),
+	PINMUX("USB2BXH", "USB2BBP", SCU410,
+	       PORTB_U2_MODE | USB_PORTB_ROUTE, (2 << 6) | USB_PORTB_ROUTE),
+	PINMUX("USB2BXHP", "USB2BBP", SCU410,
+	       PORTB_U2_MODE | USB_PORTB_ROUTE, 2 << 6),
+	PINMUX("USB2BXH2A", "USB2BAP", SCU410,
+	       PORTB_U2_MODE | USB_PORTB_ROUTE, (3 << 6) | USB_PORTB_ROUTE),
+	PINMUX("USB2BXHP2A", "USB2BAP", SCU410,
+	       PORTB_U2_MODE | USB_PORTB_ROUTE, 3 << 6),
+	PINMUX("USB2BD1", "USB2BDBP", SCU410, PORTB_U2_MODE, 1 << 6),
+	PINMUX("USB2BHPD0", "USB2BH", SCU410, PORTB_MODE, 0),
+	PINMUX("USB2BH", "USB2BHBP", SCU410, PORTB_MODE, 2 << 28),
+	PINMUX("USB2BHP", "USB2BHBP", SCU410, PORTB_MODE, 3 << 28),
+	PINMUX("USB2BD0", "USB2BHBP", SCU410, PORTB_MODE, 1 << 28),
+
+	PINMUX("JTAGPSP", "JTAG0", SCU408, GENMASK(12, 5), 0x00 << 5),
+	PINMUX("JTAGSSP", "JTAG0", SCU408, GENMASK(12, 5), 0x41 << 5),
+	PINMUX("JTAGTSP", "JTAG0", SCU408, GENMASK(12, 5), 0x42 << 5),
+	PINMUX("JTAGDDR", "JTAG0", SCU408, GENMASK(12, 5), 0x43 << 5),
+	PINMUX("JTAGUSB3A", "JTAG0", SCU408, GENMASK(12, 5), 0x44 << 5),
+	PINMUX("JTAGUSB3B", "JTAG0", SCU408, GENMASK(12, 5), 0x45 << 5),
+	PINMUX("JTAGPCIEA", "JTAG0", SCU408, GENMASK(12, 5), 0x46 << 5),
+	PINMUX("JTAGPCIEB", "JTAG0", SCU408, GENMASK(12, 5), 0x47 << 5),
+	PINMUX("JTAGM0", "JTAG0", SCU408, GENMASK(12, 5), 0x08 << 5),
+	PINMUX("PCIERC0PERST", "PCIERC0PERST", SCU200, BIT(21), BIT(21)),
+	PINMUX("PCIERC1PERST", "PCIERC1PERST", SCU200, BIT(19), BIT(19)),
+};
+
+/*
+ * Signals muxable on each package ball, strongest first. A pin acts as
+ * GPIO when none of its signal enable bits are set; gpio_request_enable
+ * clears them all. The pin order follows the GPIO18A0..GPIO18B3 numbering
+ * used by the gpio-ranges of the SoC0 GPIO controller.
+ */
+static const struct ast2700_soc0_sig ast2700_soc0_ac14_sigs[] = {
+	{ SCU400, BIT(0), "EMMCCLK" },
+	{ SCU404, BIT(0), "VB1CS" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ae15_sigs[] = {
+	{ SCU400, BIT(1), "EMMCCMD" },
+	{ SCU404, BIT(1), "VB1CK" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ad14_sigs[] = {
+	{ SCU400, BIT(2), "EMMCDAT0" },
+	{ SCU404, BIT(2), "VB1MOSI" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ae14_sigs[] = {
+	{ SCU400, BIT(3), "EMMCDAT1" },
+	{ SCU404, BIT(3), "VB1MISO" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_af14_sigs[] = {
+	{ SCU400, BIT(4), "EMMCDAT2" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ab13_sigs[] = {
+	{ SCU400, BIT(5), "EMMCDAT3" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ab14_sigs[] = {
+	{ SCU400, BIT(6), "EMMCCDN" },
+	{ SCU010, BIT(17), "VB0CS" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_af15_sigs[] = {
+	{ SCU400, BIT(7), "EMMCWPN" },
+	{ SCU010, BIT(17), "VB0CK" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_af13_sigs[] = {
+	{ SCU010, BIT(9), "TSPRSTN" },
+	{ SCU400, BIT(8), "EMMCDAT4" },
+	{ SCU010, BIT(17), "VB0MOSI" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ac13_sigs[] = {
+	{ SCU010, BIT(19), "UFSCLKI" },
+	{ SCU400, BIT(9), "EMMCDAT5" },
+	{ SCU010, BIT(17), "VB0MISO" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ad13_sigs[] = {
+	{ SCU400, BIT(10), "EMMCDAT6" },
+	{ SCU404, BIT(10), "DDCCLK" },
+};
+
+static const struct ast2700_soc0_sig ast2700_soc0_ae13_sigs[] = {
+	{ SCU400, BIT(11), "EMMCDAT7" },
+	{ SCU404, BIT(11), "DDCDAT" },
+};
+
+#define AST2700_SOC0_PIN(_name, _sigs)					\
+	{								\
+		.name = _name,						\
+		.sigs = _sigs,						\
+		.nsigs = ARRAY_SIZE(_sigs),				\
+	}
+
+static const struct ast2700_soc0_pin ast2700_soc0_pins[] = {
+	AST2700_SOC0_PIN("AC14", ast2700_soc0_ac14_sigs),
+	AST2700_SOC0_PIN("AE15", ast2700_soc0_ae15_sigs),
+	AST2700_SOC0_PIN("AD14", ast2700_soc0_ad14_sigs),
+	AST2700_SOC0_PIN("AE14", ast2700_soc0_ae14_sigs),
+	AST2700_SOC0_PIN("AF14", ast2700_soc0_af14_sigs),
+	AST2700_SOC0_PIN("AB13", ast2700_soc0_ab13_sigs),
+	AST2700_SOC0_PIN("AB14", ast2700_soc0_ab14_sigs),
+	AST2700_SOC0_PIN("AF15", ast2700_soc0_af15_sigs),
+	AST2700_SOC0_PIN("AF13", ast2700_soc0_af13_sigs),
+	AST2700_SOC0_PIN("AC13", ast2700_soc0_ac13_sigs),
+	AST2700_SOC0_PIN("AD13", ast2700_soc0_ad13_sigs),
+	AST2700_SOC0_PIN("AE13", ast2700_soc0_ae13_sigs),
+};
+
+static int ast2700_soc0_pinctrl_probe(struct udevice *dev)
+{
+	struct ast2700_soc0_pinctrl_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_remap_addr(dev->parent);
+	if (!priv->base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int ast2700_soc0_pinctrl_get_groups_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(ast2700_soc0_groups);
+}
+
+static const char *ast2700_soc0_pinctrl_get_group_name(struct udevice *dev,
+						       unsigned int selector)
+{
+	return ast2700_soc0_groups[selector];
+}
+
+static int ast2700_soc0_pinctrl_get_functions_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(ast2700_soc0_functions);
+}
+
+static const char *ast2700_soc0_pinctrl_get_function_name(struct udevice *dev,
+							  unsigned int selector)
+{
+	return ast2700_soc0_functions[selector];
+}
+
+static int ast2700_soc0_pinctrl_group_set(struct udevice *dev,
+					  unsigned int group_selector,
+					  unsigned int func_selector)
+{
+	struct ast2700_soc0_pinctrl_priv *priv = dev_get_priv(dev);
+	const struct ast2700_soc0_pinmux *pinmux;
+	const char *function;
+	const char *group;
+	u32 i;
+
+	if (group_selector >= ARRAY_SIZE(ast2700_soc0_groups) ||
+	    func_selector >= ARRAY_SIZE(ast2700_soc0_functions))
+		return -EINVAL;
+
+	function = ast2700_soc0_functions[func_selector];
+	group = ast2700_soc0_groups[group_selector];
+
+	for (i = 0; i < ARRAY_SIZE(ast2700_soc0_pinmuxes); i++) {
+		pinmux = &ast2700_soc0_pinmuxes[i];
+		if (strcmp(pinmux->function, function) ||
+		    strcmp(pinmux->group, group))
+			continue;
+
+		clrsetbits_le32(priv->base + pinmux->offset, pinmux->mask,
+				pinmux->val);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ast2700_soc0_pinctrl_gpio_request_enable(struct udevice *dev,
+						    unsigned int selector)
+{
+	struct ast2700_soc0_pinctrl_priv *priv = dev_get_priv(dev);
+	const struct ast2700_soc0_pin *pin;
+	u32 i;
+
+	if (selector >= ARRAY_SIZE(ast2700_soc0_pins))
+		return -EINVAL;
+
+	pin = &ast2700_soc0_pins[selector];
+	for (i = 0; i < pin->nsigs; i++)
+		clrbits_le32(priv->base + pin->sigs[i].offset,
+			     pin->sigs[i].mask);
+
+	return 0;
+}
+
+static int ast2700_soc0_pinctrl_get_pins_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(ast2700_soc0_pins);
+}
+
+static const char *ast2700_soc0_pinctrl_get_pin_name(struct udevice *dev,
+						     unsigned int selector)
+{
+	if (selector >= ARRAY_SIZE(ast2700_soc0_pins))
+		return NULL;
+
+	return ast2700_soc0_pins[selector].name;
+}
+
+static int ast2700_soc0_pinctrl_get_pin_muxing(struct udevice *dev,
+					       unsigned int selector,
+					       char *buf, int size)
+{
+	struct ast2700_soc0_pinctrl_priv *priv = dev_get_priv(dev);
+	const struct ast2700_soc0_pin *pin;
+	const struct ast2700_soc0_sig *sig;
+	u32 i;
+
+	if (selector >= ARRAY_SIZE(ast2700_soc0_pins))
+		return -EINVAL;
+
+	pin = &ast2700_soc0_pins[selector];
+	for (i = 0; i < pin->nsigs; i++) {
+		sig = &pin->sigs[i];
+		if ((readl(priv->base + sig->offset) & sig->mask) ==
+		    sig->mask) {
+			snprintf(buf, size, "%s", sig->name);
+			return 0;
+		}
+	}
+
+	snprintf(buf, size, "GPIO");
+
+	return 0;
+}
+
+static const struct pinctrl_ops ast2700_soc0_pinctrl_ops = {
+	.set_state = pinctrl_generic_set_state,
+	.get_pins_count = ast2700_soc0_pinctrl_get_pins_count,
+	.get_pin_name = ast2700_soc0_pinctrl_get_pin_name,
+	.get_pin_muxing = ast2700_soc0_pinctrl_get_pin_muxing,
+	.get_groups_count = ast2700_soc0_pinctrl_get_groups_count,
+	.get_group_name = ast2700_soc0_pinctrl_get_group_name,
+	.get_functions_count = ast2700_soc0_pinctrl_get_functions_count,
+	.get_function_name = ast2700_soc0_pinctrl_get_function_name,
+	.pinmux_group_set = ast2700_soc0_pinctrl_group_set,
+	.gpio_request_enable = ast2700_soc0_pinctrl_gpio_request_enable,
+};
+
+static const struct udevice_id ast2700_soc0_pinctrl_ids[] = {
+	{ .compatible = "aspeed,ast2700-soc0-pinctrl" },
+	{ }
+};
+
+U_BOOT_DRIVER(pinctrl_ast2700_soc0) = {
+	.name = "aspeed_ast2700_soc0_pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = ast2700_soc0_pinctrl_ids,
+	.priv_auto = sizeof(struct ast2700_soc0_pinctrl_priv),
+	.ops = &ast2700_soc0_pinctrl_ops,
+	.probe = ast2700_soc0_pinctrl_probe,
+};

-- 
2.34.1

