Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588EBC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3BB8073F;
	Fri, 17 Jan 2025 02:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B578280761; Fri, 17 Jan 2025 02:47:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3410F80786
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081A111FB;
 Thu, 16 Jan 2025 17:47:42 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3491A3F673;
 Thu, 16 Jan 2025 17:47:12 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 5/8] pinctrl: sunxi: add Allwinner A100/A133 pinctrl
 description
Date: Fri, 17 Jan 2025 01:45:34 +0000
Message-ID: <20250117014537.22513-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250117014537.22513-1-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
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

The Allwinner A100 SoC has been around for a while, and has now seemingly
been replaced with its close sibling A133.

Add the required mapping between the pinmux group strings and their
respective mux value, as far as used by U-Boot proper. Linux has some
basic (clock and pinctrl) support for a while, so we can build on the
names already used there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/Kconfig         | 10 ++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 47 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index cbd61795986..65e8192a99a 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -124,6 +124,16 @@ config PINCTRL_SUN50I_H616_R
 	default MACH_SUN50I_H616
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_A100
+	bool "Support for the Allwinner A100/A133 PIO"
+	default MACH_SUN50I_A133
+	select PINCTRL_SUNXI
+
+config PINCTRL_SUN50I_A100_R
+	bool "Support for the Allwinner A100/A133 R-PIO"
+	default MACH_SUN50I_A133
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN20I_D1
 	bool "Support for the Allwinner D1/R528 PIO"
 	default MACH_SUN8I_R528
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 37ea93715d1..c38edf7d4f5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -774,6 +774,41 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun50i_h616_r_pinctrl_desc
 	.num_banks	= 1,
 };
 
+static const struct sunxi_pinctrl_function sun50i_a100_pinctrl_functions[] = {
+	{ "emac0",	5 },	/* PH0-PH16 */
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "mmc0",	2 },	/* PF0-PF5 */
+	{ "mmc1",	2 },	/* PG0-PG5 */
+	{ "mmc2",	3 },	/* PC0-PC16 */
+	{ "spi0",	4 },	/* PC2-PC4, PC7, PC12, PC15-PC16 */
+#if IS_ENABLED(CONFIG_UART0_PORT_F)
+	{ "uart0",	3 },	/* PF2-PF4 */
+#else
+	{ "uart0",	2 },	/* PB9-PB10 */
+#endif
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun50i_a100_pinctrl_desc = {
+	.functions	= sun50i_a100_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun50i_a100_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_A,
+	.num_banks	= 8,
+};
+
+static const struct sunxi_pinctrl_function sun50i_a100_r_pinctrl_functions[] = {
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "s_i2c0",	2 },
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun50i_a100_r_pinctrl_desc = {
+	.functions	= sun50i_a100_r_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun50i_a100_r_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_L,
+	.num_banks	= 1,
+};
+
 static const struct udevice_id sunxi_pinctrl_ids[] = {
 #ifdef CONFIG_PINCTRL_SUNIV_F1C100S
 	{
@@ -936,6 +971,18 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
 		.compatible = "allwinner,sun50i-h616-r-pinctrl",
 		.data = (ulong)&sun50i_h616_r_pinctrl_desc,
 	},
+#endif
+#ifdef CONFIG_PINCTRL_SUN50I_A100
+	{
+		.compatible = "allwinner,sun50i-a100-pinctrl",
+		.data = (ulong)&sun50i_a100_pinctrl_desc,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_SUN50I_A100_R
+	{
+		.compatible = "allwinner,sun50i-a100-r-pinctrl",
+		.data = (ulong)&sun50i_a100_r_pinctrl_desc,
+	},
 #endif
 	{}
 };
-- 
2.46.2

