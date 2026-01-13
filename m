Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DB4D29DC7
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBF983942;
	Tue, 13 Jan 2026 05:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63AB83979; Tue, 13 Jan 2026 05:03:00 +0100 (CET)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB358393F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id B82253415DA;
 Tue, 13 Jan 2026 04:02:53 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 13 Jan 2026 12:01:59 +0800
Subject: [PATCH v3 5/9] clock: reset: a733: add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-01-a733-soc-support-v3-5-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17895; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=MHXMjs09LHyJoRK4Qj19cinvfmhirkO5ZK4whHGth8o=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcPNKnmq5uG7pvZhqYIHXrIM7jFDM1cX0cIhk
 w33BBHP1ruJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXDzRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3gIg//cGBsLYvFcY/9CVA6JjlkXhTKlViFWM8ALsU6t4srTBtUk011NW2dI
 LRTlr8KO2MHiBPLvg+W10HpbQeXxhsiF6SnrIOHM3rbc94iAYK7zT19Z/8UendN1BSc2Nr+H/dF
 oVB4JhQ++bH04jiJmGYnUE/lM+8/DDoaHYjgQucpAkVJE9o+w0+Scgy1B2iGSld/yYZs3kHTg1t
 7vqk/Z8vlShn27vOkzCExb/dyR5Q2ZGThbYhbGLlXjw/1dCHP1qcATbnNm5DNFaIcZldsdmwoxo
 kcQN7PPkptbNr/rRjEWbbAs03hr4ZwirAxAEVSy974XJasrShqq4zNpfxAiBI3/wqVoZZSYCTEF
 0ccHwdt0yu3MJH2HpQZtVTdwkkIkP1o9Bm4b/xIRZEVMQP5IexgZIvysqGzOXvD7ejnINeGq+TZ
 /P+IW1/FY/rYy1ZIUbGwuMqdXKPRYPujuD/YHDbVojtIgp7DxtjxbYewDQq3Ah2Go8yl5OJUJ7p
 WIN2Mr6JKs1RDvTWN1OsbVxsI6r/WCjtGLlJuqvaFez0ba++Dq7DNs/12FjWz1hJ5huKm9spQ4E
 NMLnNb0HKEyHKnGCBKILAOQFXVyKdzqOVae8Bjnc6xfaxeHzhrrvGIRIPnHURZQkDzek4MVNk0n
 JH/fCnrJIV3t4ZYFR6UZdRHdziTgxc=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add the clock and reset support to A733 SoC which cover
devices of gmac, mmc, I2C, SPI, uart, usb.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/clk/sunxi/Kconfig                     |  14 ++
 drivers/clk/sunxi/Makefile                    |   2 +
 drivers/clk/sunxi/clk_a733.c                  |  75 ++++++++++
 drivers/clk/sunxi/clk_a733_r.c                |  36 +++++
 drivers/clk/sunxi/clk_sunxi.c                 |  10 ++
 include/dt-bindings/clock/sun60i-a733-ccu.h   | 188 ++++++++++++++++++++++++++
 include/dt-bindings/clock/sun60i-a733-r-ccu.h |  34 +++++
 include/dt-bindings/reset/sun60i-a733-ccu.h   |  85 ++++++++++++
 include/dt-bindings/reset/sun60i-a733-r-ccu.h |  22 +++
 9 files changed, 466 insertions(+)

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 1c1cc82719c..03133ba86df 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -143,4 +143,18 @@ config CLK_SUN55I_A523_R
 	  This enables common clock driver support for the PRCM
 	  in Allwinner A523/T527 SoCs.
 
+config CLK_SUN60I_A733
+	bool "Clock driver for Allwinner A733"
+	default MACH_SUN60I_A733
+	help
+	  This enables common clock driver support for platforms based
+	  on Allwinner A733 SoC.
+
+config CLK_SUN60I_A733_R
+	bool "Clock driver for Allwinner A733 generation PRCM"
+	default MACH_SUN60I_A733
+	help
+	  This enables common clock driver support for the PRCM
+	  in Allwinner A733 SoCs.
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
index 00000000000..e83f616628a
--- /dev/null
+++ b/drivers/clk/sunxi/clk_a733.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <clk/sunxi.h>
+#include <linux/bitops.h>
+
+#include <dt-bindings/clock/sun60i-a733-ccu.h>
+#include <dt-bindings/reset/sun60i-a733-ccu.h>
+
+static struct ccu_clk_gate a733_gates[] = {
+	[CLK_PLL_PERIPH0_200M]	= GATE_DUMMY,
+	[CLK_APB1]			= GATE_DUMMY,
+	[CLK_MBUS_GMAC0]	= GATE(0x05e4, BIT(11)),
+	[CLK_BUS_MMC0]		= GATE(0x0d0c, BIT(0)),
+	[CLK_BUS_MMC1]		= GATE(0x0d1c, BIT(0)),
+	[CLK_BUS_MMC2]		= GATE(0x0d2c, BIT(0)),
+	[CLK_BUS_UART0]		= GATE(0x0e00, BIT(0)),
+	[CLK_BUS_UART1]		= GATE(0x0e04, BIT(0)),
+	[CLK_BUS_UART2]		= GATE(0x0e08, BIT(0)),
+	[CLK_BUS_UART3]		= GATE(0x0e0c, BIT(0)),
+	[CLK_BUS_UART4]		= GATE(0x0e10, BIT(0)),
+	[CLK_BUS_UART5]		= GATE(0x0e14, BIT(0)),
+	[CLK_BUS_I2C0]		= GATE(0x0e80, BIT(0)),
+	[CLK_BUS_I2C1]		= GATE(0x0e84, BIT(0)),
+	[CLK_BUS_I2C2]		= GATE(0x0e88, BIT(0)),
+	[CLK_BUS_I2C3]		= GATE(0x0e8c, BIT(0)),
+	[CLK_SPI0]			= GATE(0x0f00, BIT(31)),
+	[CLK_SPI1]			= GATE(0x0f08, BIT(31)),
+	[CLK_BUS_SPI0]		= GATE(0x0f04, BIT(0)),
+	[CLK_BUS_SPI1]		= GATE(0x0f0c, BIT(0)),
+	[CLK_GMAC0_PHY]		= GATE(0x1410, BIT(31)),
+	[CLK_BUS_GMAC0]		= GATE(0x141c, BIT(0)),
+	[CLK_USB_OHCI0]		= GATE(0x1300, BIT(31)),
+	[CLK_USB_OHCI1]		= GATE(0x1308, BIT(31)),
+	[CLK_BUS_OHCI0]		= GATE(0x1304, BIT(0)),
+	[CLK_BUS_OHCI1]		= GATE(0x130c, BIT(0)),
+	[CLK_BUS_EHCI0]		= GATE(0x1304, BIT(4)),
+	[CLK_BUS_EHCI1]		= GATE(0x130c, BIT(4)),
+	[CLK_USB_GATE0]		= GATE(0x1304, BIT(8)),
+	[CLK_USB_GATE1]		= GATE(0x130c, BIT(8)),
+};
+
+static struct ccu_reset a733_resets[] = {
+	[RST_BUS_MMC0]		= RESET(0x0d0c, BIT(16)),
+	[RST_BUS_MMC1]		= RESET(0x0d1c, BIT(16)),
+	[RST_BUS_MMC2]		= RESET(0x0d2c, BIT(16)),
+	[RST_BUS_UART0]		= RESET(0x0e00, BIT(16)),
+	[RST_BUS_UART1]		= RESET(0x0e04, BIT(16)),
+	[RST_BUS_UART2]		= RESET(0x0e08, BIT(16)),
+	[RST_BUS_UART3]		= RESET(0x0e0c, BIT(16)),
+	[RST_BUS_UART4]		= RESET(0x0e10, BIT(16)),
+	[RST_BUS_UART5]		= RESET(0x0e14, BIT(16)),
+	[RST_BUS_I2C0]		= RESET(0x0e80, BIT(16)),
+	[RST_BUS_I2C1]		= RESET(0x0e84, BIT(16)),
+	[RST_BUS_I2C2]		= RESET(0x0e8c, BIT(16)),
+	[RST_BUS_I2C3]		= RESET(0x0e10, BIT(16)),
+	[RST_BUS_SPI0]		= RESET(0x0f04, BIT(16)),
+	[RST_BUS_SPI1]		= RESET(0x0f0c, BIT(16)),
+	[RST_BUS_GMAC0]		= RESET(0x141c, BIT(16) | BIT(17)),
+	[RST_USB_PHY0]		= RESET(0x1300, BIT(30)),
+	[RST_USB_PHY1]		= RESET(0x1308, BIT(30)),
+	[RST_BUS_OHCI0]		= RESET(0x1304, BIT(16)),
+	[RST_BUS_OHCI1]		= RESET(0x130c, BIT(16)),
+	[RST_BUS_EHCI0]		= RESET(0x1304, BIT(20)),
+	[RST_BUS_EHCI1]		= RESET(0x130c, BIT(20)),
+};
+
+const struct ccu_desc a733_ccu_desc = {
+	.gates	= a733_gates,
+	.resets	= a733_resets,
+	.num_gates = ARRAY_SIZE(a733_gates),
+	.num_resets = ARRAY_SIZE(a733_resets),
+};
diff --git a/drivers/clk/sunxi/clk_a733_r.c b/drivers/clk/sunxi/clk_a733_r.c
new file mode 100644
index 00000000000..a500cd2831d
--- /dev/null
+++ b/drivers/clk/sunxi/clk_a733_r.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <clk/sunxi.h>
+#include <dt-bindings/clock/sun60i-a733-r-ccu.h>
+#include <dt-bindings/reset/sun60i-a733-r-ccu.h>
+#include <linux/bitops.h>
+
+static struct ccu_clk_gate a733_r_gates[] = {
+	[CLK_R_AHB]             = GATE_DUMMY,
+	[CLK_R_APB0]            = GATE_DUMMY,
+	[CLK_R_APB1]            = GATE_DUMMY,
+	[CLK_BUS_R_TWD]         = GATE(0x12c, BIT(0)),
+	[CLK_BUS_R_UART0]       = GATE(0x18c, BIT(0)),
+	[CLK_BUS_R_I2C0]        = GATE(0x19c, BIT(0)),
+	[CLK_BUS_R_I2C1]        = GATE(0x19c, BIT(1)),
+	[CLK_BUS_R_I2C2]        = GATE(0x19c, BIT(2)),
+	[CLK_BUS_R_RTC]         = GATE(0x20c, BIT(0)),
+};
+
+static struct ccu_reset a733_r_resets[] = {
+	[RST_BUS_R_TWD]         = RESET(0x12c, BIT(16)),
+	[RST_BUS_R_UART0]       = RESET(0x18c, BIT(16)),
+	[RST_BUS_R_I2C0]        = RESET(0x19c, BIT(16)),
+	[RST_BUS_R_I2C1]        = RESET(0x19c, BIT(17)),
+	[RST_BUS_R_I2C2]        = RESET(0x19c, BIT(18)),
+	[RST_BUS_R_RTC]         = RESET(0x20c, BIT(16)),
+};
+
+const struct ccu_desc a733_r_ccu_desc = {
+	.gates = a733_r_gates,
+	.resets = a733_r_resets,
+	.num_gates = ARRAY_SIZE(a733_r_gates),
+	.num_resets = ARRAY_SIZE(a733_r_resets),
+};
diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index 842a0541bd6..ad90a3744a2 100644
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
diff --git a/include/dt-bindings/clock/sun60i-a733-ccu.h b/include/dt-bindings/clock/sun60i-a733-ccu.h
new file mode 100644
index 00000000000..113738ebd7e
--- /dev/null
+++ b/include/dt-bindings/clock/sun60i-a733-ccu.h
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+
+#ifndef _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_
+#define _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_
+
+#define CLK_PLL_DDR0		0
+#define CLK_PLL_PERIPH0_4X	1
+#define CLK_PLL_PERIPH0_2X	2
+#define CLK_PLL_PERIPH0_800M	3
+#define CLK_PLL_PERIPH0_480M	4
+#define CLK_PLL_PERIPH0_600M	5
+#define CLK_PLL_PERIPH0_400M	6
+#define CLK_PLL_PERIPH0_300M	7
+#define CLK_PLL_PERIPH0_200M	8
+#define CLK_PLL_PERIPH0_160M	9
+#define CLK_PLL_PERIPH0_150M	10
+#define CLK_PLL_PERIPH1_4X	11
+#define CLK_PLL_PERIPH1_2X	12
+#define CLK_PLL_PERIPH1_800M	13
+#define CLK_PLL_PERIPH1_480M	14
+#define CLK_PLL_PERIPH1_600M	15
+#define CLK_PLL_PERIPH1_400M	16
+#define CLK_PLL_PERIPH1_300M	17
+#define CLK_PLL_PERIPH1_200M	18
+#define CLK_PLL_PERIPH1_160M	19
+#define CLK_PLL_PERIPH1_150M	20
+#define CLK_PLL_GPU		21
+#define CLK_PLL_VIDEO0_8X	22
+#define CLK_PLL_VIDEO0_4X	23
+#define CLK_PLL_VIDEO0_3X	24
+#define CLK_PLL_VIDEO1_8X	25
+#define CLK_PLL_VIDEO1_4X	26
+#define CLK_PLL_VIDEO1_3X	27
+#define CLK_PLL_VIDEO2_8X	28
+#define CLK_PLL_VIDEO2_4X	29
+#define CLK_PLL_VIDEO2_3X	30
+#define CLK_PLL_VIDEO3_8X	31
+#define CLK_PLL_VIDEO3_4X	32
+#define CLK_PLL_VIDEO3_3X	33
+#define CLK_PLL_VE		34
+#define CLK_PLL_AUDIO0_4X	35
+#define CLK_PLL_AUDIO0_2X	36
+#define CLK_PLL_AUDIO0		37
+#define CLK_PLL_NPU_4X		38
+#define CLK_PLL_NPU_2X		39
+#define CLK_PLL_NPU		40
+#define CLK_AHB			41
+#define CLK_APB0		42
+#define CLK_APB1		43
+#define CLK_MBUS		44
+#define CLK_DE			45
+#define CLK_BUS_DE		46
+#define CLK_DI			47
+#define CLK_BUS_DI		48
+#define CLK_G2D			49
+#define CLK_BUS_G2D		50
+#define CLK_GPU			51
+#define CLK_BUS_GPU		52
+#define CLK_CE			53
+#define CLK_BUS_CE		54
+#define CLK_BUS_CE_SYS		55
+#define CLK_VE			56
+#define CLK_BUS_VE		57
+#define CLK_BUS_DMA		58
+#define CLK_BUS_MSGBOX		59
+#define CLK_BUS_SPINLOCK	60
+#define CLK_HSTIMER0		61
+#define CLK_HSTIMER1		62
+#define CLK_HSTIMER2		63
+#define CLK_HSTIMER3		64
+#define CLK_HSTIMER4		65
+#define CLK_HSTIMER5		66
+#define CLK_BUS_HSTIMER		67
+#define CLK_BUS_DBG		68
+#define CLK_BUS_PWM0		69
+#define CLK_BUS_PWM1		70
+#define CLK_IOMMU		71
+#define CLK_BUS_IOMMU		72
+#define CLK_DRAM		73
+#define CLK_MBUS_DMA		74
+#define CLK_MBUS_VE		75
+#define CLK_MBUS_CE		76
+#define CLK_MBUS_CSI		77
+#define CLK_MBUS_ISP		78
+#define CLK_MBUS_GMAC0		79
+#define CLK_BUS_DRAM		80
+#define CLK_NAND0		81
+#define CLK_NAND1		82
+#define CLK_BUS_NAND		83
+#define CLK_MMC0		84
+#define CLK_MMC1		85
+#define CLK_MMC2		86
+#define CLK_BUS_SYSDAP		87
+#define CLK_BUS_MMC0		88
+#define CLK_BUS_MMC1		89
+#define CLK_BUS_MMC2		90
+#define CLK_BUS_UART0		91
+#define CLK_BUS_UART1		92
+#define CLK_BUS_UART2		93
+#define CLK_BUS_UART3		94
+#define CLK_BUS_UART4		95
+#define CLK_BUS_UART5		96
+#define CLK_BUS_UART6		97
+#define CLK_BUS_UART7		98
+#define CLK_BUS_I2C0		99
+#define CLK_BUS_I2C1		100
+#define CLK_BUS_I2C2		101
+#define CLK_BUS_I2C3		102
+#define CLK_BUS_I2C4		103
+#define CLK_BUS_I2C5		104
+#define CLK_BUS_CAN		105
+#define CLK_SPI0		106
+#define CLK_SPI1		107
+#define CLK_SPI2		108
+#define CLK_SPIFC		109
+#define CLK_BUS_SPI0		110
+#define CLK_BUS_SPI1		111
+#define CLK_BUS_SPI2		112
+#define CLK_BUS_SPIFC		113
+#define CLK_GMAC0_PHY		114
+#define CLK_EMAC1_25M		115
+#define CLK_BUS_GMAC0		116
+#define CLK_BUS_GMAC1		117
+#define CLK_IR_RX		118
+#define CLK_BUS_IR_RX		119
+#define CLK_IR_TX		120
+#define CLK_BUS_IR_TX		121
+#define CLK_GPADC0		122
+#define CLK_GPADC1		123
+#define CLK_BUS_GPADC0		124
+#define CLK_BUS_GPADC1		125
+#define CLK_BUS_THS		126
+#define CLK_USB_OHCI0		127
+#define CLK_USB_OHCI1		128
+#define CLK_BUS_OHCI0		129
+#define CLK_BUS_OHCI1		130
+#define CLK_BUS_EHCI0		131
+#define CLK_BUS_EHCI1		132
+#define CLK_BUS_OTG		133
+#define CLK_BUS_LRADC		134
+#define CLK_PCIE_AUX		135
+#define CLK_BUS_DISPLAY0_TOP	136
+#define CLK_BUS_DISPLAY1_TOP	137
+#define CLK_HDMI_24M		138
+#define CLK_HDMI_CEC_32K	139
+#define CLK_HDMI_CEC		140
+#define CLK_BUS_HDMI		141
+#define CLK_MIPI_DSI0		142
+#define CLK_MIPI_DSI1		143
+#define CLK_BUS_MIPI_DSI0	144
+#define CLK_BUS_MIPI_DSI1	145
+#define CLK_TCON_LCD0		146
+#define CLK_TCON_LCD1		147
+#define CLK_TCON_LCD2		148
+#define CLK_COMBOPHY_DSI0	149
+#define CLK_COMBOPHY_DSI1	150
+#define CLK_BUS_TCON_LCD0	151
+#define CLK_BUS_TCON_LCD1	152
+#define CLK_BUS_TCON_LCD2	153
+#define CLK_TCON_TV0		154
+#define CLK_TCON_TV1		155
+#define CLK_BUS_TCON_TV0	156
+#define CLK_BUS_TCON_TV1	157
+#define CLK_EDP			158
+#define CLK_BUS_EDP		159
+#define CLK_LEDC		160
+#define CLK_BUS_LEDC		161
+#define CLK_CSI_TOP		162
+#define CLK_CSI_MCLK0		163
+#define CLK_CSI_MCLK1		164
+#define CLK_CSI_MCLK2		165
+#define CLK_CSI_MCLK3		166
+#define CLK_BUS_CSI		167
+#define CLK_ISP			168
+#define CLK_DSP			169
+#define CLK_FANOUT_24M		170
+#define CLK_FANOUT_12M		171
+#define CLK_FANOUT_16M		172
+#define CLK_FANOUT_25M		173
+#define CLK_FANOUT_27M		174
+#define CLK_FANOUT_PCLK		175
+#define CLK_FANOUT0		176
+#define CLK_FANOUT1		177
+#define CLK_FANOUT2		178
+#define CLK_USB_GATE0		179
+#define CLK_USB_GATE1		180
+
+#endif /* _DT_BINDINGS_CLK_SUN60I_A733_CCU_H_ */
diff --git a/include/dt-bindings/clock/sun60i-a733-r-ccu.h b/include/dt-bindings/clock/sun60i-a733-r-ccu.h
new file mode 100644
index 00000000000..e16ee48968d
--- /dev/null
+++ b/include/dt-bindings/clock/sun60i-a733-r-ccu.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+
+#ifndef _DT_BINDINGS_CLK_SUN60I_A733_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN60I_A733_R_CCU_H_
+
+#define CLK_R_AHB		0
+#define CLK_R_APB0		1
+#define CLK_R_APB1		2
+#define CLK_R_TIMER0		3
+#define CLK_R_TIMER1		4
+#define CLK_R_TIMER2		5
+#define CLK_BUS_R_TIMER		6
+#define CLK_BUS_R_TWD		7
+#define CLK_R_PWMCTRL		8
+#define CLK_BUS_R_PWMCTRL	9
+#define CLK_R_SPI		10
+#define CLK_BUS_R_SPI		11
+#define CLK_BUS_R_SPINLOCK	12
+#define CLK_BUS_R_MSGBOX	13
+#define CLK_BUS_R_UART0		14
+#define CLK_BUS_R_UART1		15
+#define CLK_BUS_R_I2C0		16
+#define CLK_BUS_R_I2C1		17
+#define CLK_BUS_R_I2C2		18
+#define CLK_BUS_R_PPU0		19
+#define CLK_BUS_R_PPU1		20
+#define CLK_BUS_R_CPU_BIST	21
+#define CLK_R_IR_RX		22
+#define CLK_BUS_R_IR_RX		23
+#define CLK_BUS_R_DMA		24
+#define CLK_BUS_R_RTC		25
+#define CLK_BUS_R_CPUCFG	26
+
+#endif /* _DT_BINDINGS_CLK_SUN60I_A733_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun60i-a733-ccu.h b/include/dt-bindings/reset/sun60i-a733-ccu.h
new file mode 100644
index 00000000000..ed81633c80b
--- /dev/null
+++ b/include/dt-bindings/reset/sun60i-a733-ccu.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+
+#ifndef _DT_BINDINGS_RST_SUN60I_A733_CCU_H_
+#define _DT_BINDINGS_RST_SUN60I_A733_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_NSI		1
+#define RST_BUS_DE		2
+#define RST_BUS_DI		3
+#define RST_BUS_G2D		4
+#define RST_BUS_SYS		5
+#define RST_BUS_GPU		6
+#define RST_BUS_CE		7
+#define RST_BUS_SYS_CE		8
+#define RST_BUS_VE		9
+#define RST_BUS_DMA		10
+#define RST_BUS_MSGBOX		11
+#define RST_BUS_SPINLOCK	12
+#define RST_BUS_CPUXTIMER	13
+#define RST_BUS_DBG		14
+#define RST_BUS_PWM0		15
+#define RST_BUS_PWM1		16
+#define RST_BUS_DRAM		17
+#define RST_BUS_NAND		18
+#define RST_BUS_MMC0		19
+#define RST_BUS_MMC1		20
+#define RST_BUS_MMC2		21
+#define RST_BUS_SYSDAP		22
+#define RST_BUS_UART0		23
+#define RST_BUS_UART1		24
+#define RST_BUS_UART2		25
+#define RST_BUS_UART3		26
+#define RST_BUS_UART4		27
+#define RST_BUS_UART5		28
+#define RST_BUS_UART6		29
+#define RST_BUS_UART7		30
+#define RST_BUS_I2C0		31
+#define RST_BUS_I2C1		32
+#define RST_BUS_I2C2		33
+#define RST_BUS_I2C3		34
+#define RST_BUS_I2C4		35
+#define RST_BUS_I2C5		36
+#define RST_BUS_CAN		37
+#define RST_BUS_SPI0		38
+#define RST_BUS_SPI1		39
+#define RST_BUS_SPI2		40
+#define RST_BUS_SPIFC		41
+#define RST_BUS_GMAC0		42
+#define RST_BUS_GMAC1		43
+#define RST_BUS_IR_RX		44
+#define RST_BUS_IR_TX		45
+#define RST_BUS_GPADC0		46
+#define RST_BUS_GPADC1		47
+#define RST_BUS_THS		48
+#define RST_USB_PHY0		49
+#define RST_USB_PHY1		50
+#define RST_BUS_OHCI0		51
+#define RST_BUS_OHCI1		52
+#define RST_BUS_EHCI0		53
+#define RST_BUS_EHCI1		54
+#define RST_BUS_OTG		55
+#define RST_BUS_3		56
+#define RST_BUS_LRADC		57
+#define RST_BUS_PCIE_USB3	58
+#define RST_BUS_DISPLAY0_TOP	59
+#define RST_BUS_DISPLAY1_TOP	60
+#define RST_BUS_HDMI_MAIN	61
+#define RST_BUS_HDMI_SUB	62
+#define RST_BUS_MIPI_DSI0	63
+#define RST_BUS_MIPI_DSI1	64
+#define RST_BUS_TCON_LCD0	65
+#define RST_BUS_TCON_LCD1	66
+#define RST_BUS_TCON_LCD2	67
+#define RST_BUS_TCON_TV0	68
+#define RST_BUS_TCON_TV1	69
+#define RST_BUS_LVDS0		70
+#define RST_BUS_LVDS1		71
+#define RST_BUS_EDP		72
+#define RST_BUS_VIDEO_OUT0	73
+#define RST_BUS_VIDEO_OUT1	74
+#define RST_BUS_LEDC		75
+#define RST_BUS_CSI		76
+#define RST_BUS_ISP		77
+
+#endif /* _DT_BINDINGS_RST_SUN60I_A733_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun60i-a733-r-ccu.h b/include/dt-bindings/reset/sun60i-a733-r-ccu.h
new file mode 100644
index 00000000000..fbf48f883b7
--- /dev/null
+++ b/include/dt-bindings/reset/sun60i-a733-r-ccu.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+
+#ifndef _DT_BINDINGS_RST_SUN60I_A733_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN60I_A733_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_TWD		1
+#define RST_BUS_R_PWMCTRL	2
+#define RST_BUS_R_SPI		3
+#define RST_BUS_R_SPINLOCK	4
+#define RST_BUS_R_MSGBOX	5
+#define RST_BUS_R_UART0		6
+#define RST_BUS_R_UART1		7
+#define RST_BUS_R_I2C0		8
+#define RST_BUS_R_I2C1		9
+#define RST_BUS_R_I2C2		10
+#define RST_BUS_R_PPU1		11
+#define RST_BUS_R_IR_RX		12
+#define RST_BUS_R_RTC		13
+#define RST_BUS_R_CPUCFG	14
+
+#endif /* _DT_BINDINGS_RST_SUN60I_A733_R_CCU_H_ */

-- 
2.52.0

