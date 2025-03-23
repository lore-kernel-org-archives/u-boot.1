Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EF0C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A9B81EBB;
	Sun, 23 Mar 2025 12:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1253381F71; Sun, 23 Mar 2025 12:36:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 010EB81F0B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266781595;
 Sun, 23 Mar 2025 04:36:39 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CAC93F694;
 Sun, 23 Mar 2025 04:36:31 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 17/34] pinctrl: sunxi: add Allwinner A523 pinctrl description
Date: Sun, 23 Mar 2025 11:35:27 +0000
Message-ID: <20250323113544.7933-18-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The new DT pinctrl binding would allow us to read the pinmux values from
the DT, but it is actually easier to just continue with hardcoding the
mux values in the driver, and matching them against the "function" name.

Add the values for the primary and secondary pin controller on the A523.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/Kconfig         | 10 ++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 49 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 65e8192a99a..54314992299 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -139,4 +139,14 @@ config PINCTRL_SUN20I_D1
 	default MACH_SUN8I_R528
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN55I_A523
+	bool "Support for the Allwinner A523 PIO"
+	default MACH_SUN55I_A523
+	select PINCTRL_SUNXI
+
+config PINCTRL_SUN55I_A523_R
+	bool "Support for the Allwinner A523 R-PIO"
+	default MACH_SUN55I_A523
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index c38edf7d4f5..46b266a3a1d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -759,6 +759,29 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun50i_h616_pinctrl_desc =
 	.num_banks	= 9,
 };
 
+static const struct sunxi_pinctrl_function sun55i_a523_pinctrl_functions[] = {
+	{ "emac0",	5 },	/* PI0-PI16 */
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "mmc0",	2 },	/* PF0-PF5 */
+	{ "mmc1",	2 },	/* PG0-PG5 */
+	{ "mmc2",	3 },	/* PC0-PC16 */
+	{ "spi0",	4 },	/* PC0-PC7, PC15-PC16 */
+#if IS_ENABLED(CONFIG_UART0_PORT_F)
+	{ "uart0",	3 },	/* PF2-PF4 */
+#else
+	{ "uart0",	2 },	/* PH0-PH1 */
+#endif
+	{ "uart1",	2 },	/* PG6-PG7 */
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_pinctrl_desc = {
+	.functions	= sun55i_a523_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun55i_a523_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_A,
+	.num_banks	= 11,
+};
+
 static const struct sunxi_pinctrl_function sun50i_h616_r_pinctrl_functions[] = {
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
@@ -809,6 +832,20 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun50i_a100_r_pinctrl_desc
 	.num_banks	= 1,
 };
 
+static const struct sunxi_pinctrl_function sun55i_a523_r_pinctrl_functions[] = {
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "s_i2c",	2 },	/* PL0-PL1 */
+	{ "s_uart",	2 },	/* PL2-PL3 */
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_r_pinctrl_desc = {
+	.functions	= sun55i_a523_r_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun55i_a523_r_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_L,
+	.num_banks	= 2,
+};
+
 static const struct udevice_id sunxi_pinctrl_ids[] = {
 #ifdef CONFIG_PINCTRL_SUNIV_F1C100S
 	{
@@ -983,6 +1020,18 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
 		.compatible = "allwinner,sun50i-a100-r-pinctrl",
 		.data = (ulong)&sun50i_a100_r_pinctrl_desc,
 	},
+#endif
+#ifdef CONFIG_PINCTRL_SUN55I_A523
+	{
+		.compatible = "allwinner,sun55i-a523-pinctrl",
+		.data = (ulong)&sun55i_a523_pinctrl_desc,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_SUN55I_A523_R
+	{
+		.compatible = "allwinner,sun55i-a523-r-pinctrl",
+		.data = (ulong)&sun55i_a523_r_pinctrl_desc,
+	},
 #endif
 	{}
 };
-- 
2.46.3

