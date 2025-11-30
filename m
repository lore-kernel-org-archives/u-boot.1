Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926E0D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2012783984;
	Sun, 30 Nov 2025 22:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2683C8312A; Sun, 30 Nov 2025 22:46:30 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B105839A8
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id D6DA8340E31;
 Sun, 30 Nov 2025 21:46:23 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 30 Nov 2025 21:45:16 +0000
Subject: [PATCH v2 07/10] pinctrl: sunxi: a733: add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-01-a733-soc-support-v2-7-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4191; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=NhBFzSveKOfqS2sIXvSvaq0RHxKaLXQsxdi5YN0b5uc=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLsL8dcBqVMfIzOCxe9q261gyTTYcfTCkLiwb
 6pcJXAaqYeJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy7C18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277SleD/9CnpHF3AvgjeRcwm
 M64Cu5VB03J6j8NxqB8R0QXRtVSc1HxpWTPXaMlp7hy0XgK/lNIXcf11G0gKALJxXEOvbIM6xXx
 9cbcygr62QPzd9uS2ZLA3xt5jGucvNMhA37s+M5GcfpOF7IozEZsR2b2pp0QesUKt0UHRghEDUC
 kOZv9xMfjwUEntNN1osfXa1S8rhoRAsB3Mf2LP5m2BDJZwrAqDwOvQLMbM8tw0VEJ37BvyUZYvk
 r+UrRY922ZPYCJLQ0tKE/puM8ASzPdbddm/eSAQMJjh1CJd1TGigmJVefdW5xWtqa4JoOvmEK5S
 goW5XwaPK1ak8hEf19iKbNJoeSipBiaN8i3ogkmkTLqf95pmWFs90zAVq8T5bwXhhwNdj6iuOhh
 1XKMWxDHsrbUeuDoeK55LMunGRPYxScWS4VHfmkqEPbW8GSthhtWWe7pma370jDhiZVdO4xBBlZ
 SgM7GyXHhj+/Z3KlIil4UIuk4Ij78P9DSV+IxBcISXow1wZyoNU52jdiK2aW4/P85TYJqYvP2zJ
 9lo2Odtn4mGHjxdwQXVy5uYmG7I283/HK0swOjqFotiieer1wxGQ4SL1fLE14wKZk8NJ24tXWqJ
 2bja4J+cANf8FaWsuCe6L6gIuwJgBC8j+rSTW5A5rYptor2oFPXF6CQFQh9UbjaMNIKA==
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

Introduce pinctrl driver for A733 SoC, but only limited devices are
supported which includes GMAC, MMC, SPI, UART.

Setup an offset 0x80 for virtual PA port, as A733 changes the register
layout, with this adjustment, all other ports can be found correctly.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/pinctrl/sunxi/Kconfig         | 10 ++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 57 ++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 54314992299..0e48a71e8b5 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -149,4 +149,14 @@ config PINCTRL_SUN55I_A523_R
 	default MACH_SUN55I_A523
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN60I_A733
+	bool "Support for the Allwinner A733 PIO"
+	default MACH_SUN60I_A733
+	select PINCTRL_SUNXI
+
+config PINCTRL_SUN60I_A733_R
+	bool "Support for the Allwinner A733 R-PIO"
+	default MACH_SUN60I_A733
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index fd357ab0d4e..b6c901f14c1 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -30,6 +30,7 @@ struct sunxi_pinctrl_function {
 
 struct sunxi_pinctrl_desc {
 	const struct sunxi_pinctrl_function	*functions;
+	u32					pio_offset;
 	u8					num_functions;
 	u8					first_bank;
 	u8					num_banks;
@@ -195,7 +196,7 @@ static int sunxi_pinctrl_bind(struct udevice *dev)
 		return -EINVAL;
 	dev_set_priv(dev, desc);
 
-	plat->base = dev_read_addr_ptr(dev);
+	plat->base = dev_read_addr_ptr(dev) + desc->pio_offset;
 
 	ret = device_bind_driver_to_node(dev, "gpio_sunxi", dev->name,
 					 dev_ofnode(dev), &gpio_dev);
@@ -782,6 +783,32 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_pinctrl_desc =
 	.num_banks	= 11,
 };
 
+static const struct sunxi_pinctrl_function sun60i_a733_pinctrl_functions[] = {
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "gmac0",	5 },	/* PH0-PH15 */
+	{ "gmac1",	5 },	/* PJ0-PJ15 */
+	{ "mmc0",	2 },	/* PF0-PF5 */
+	{ "mmc1",	2 },	/* PG0-PG5 */
+	{ "mmc2",	3 },	/* PC0, PC1, PC5, PC6, PC8-PC11, PC13-PC16 */
+	{ "mmc3",	4 },	/* PC0, PC1, PC5, PC6, PC8-PC11, PC13-PC16 */
+	{ "spi0",	5 },	/* PC2-PC4, PC7, PC12 */
+#if IS_ENABLED(CONFIG_UART0_PORT_F)
+	{ "uart0",	3 },	/* PF2, PF4 */
+#else
+	{ "uart0",	2 },	/* PB9, PB10 */
+#endif
+	{ "uart1",	2 },	/* PG6, PG7 */
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun60i_a733_pinctrl_desc = {
+	.functions	= sun60i_a733_pinctrl_functions,
+	.pio_offset	= SUNXI_PIO_OFFSET,
+	.num_functions	= ARRAY_SIZE(sun60i_a733_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_A,
+	.num_banks	= 11,
+};
+
 static const struct sunxi_pinctrl_function sun50i_h616_r_pinctrl_functions[] = {
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
@@ -847,6 +874,21 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_r_pinctrl_desc
 	.num_banks	= 2,
 };
 
+static const struct sunxi_pinctrl_function sun60i_a733_r_pinctrl_functions[] = {
+	{ "gpio_in",	0 },
+	{ "gpio_out",	1 },
+	{ "r_i2c0",	2 },	/* PL0-PL1 */
+	{ "r_uart0",	3 },	/* PL2-PL3 */
+	{ "r_uart1",	2 },	/* PL2-PL3 */
+};
+
+static const struct sunxi_pinctrl_desc __maybe_unused sun60i_a733_r_pinctrl_desc = {
+	.functions	= sun60i_a733_r_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun60i_a733_r_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_L,
+	.num_banks	= 2,
+};
+
 static const struct udevice_id sunxi_pinctrl_ids[] = {
 #ifdef CONFIG_PINCTRL_SUNIV_F1C100S
 	{
@@ -1034,6 +1076,19 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
 		.data = (ulong)&sun55i_a523_r_pinctrl_desc,
 	},
 #endif
+
+#ifdef CONFIG_PINCTRL_SUN60I_A733
+	{
+		.compatible = "allwinner,sun60i-a733-pinctrl",
+		.data = (ulong)&sun60i_a733_pinctrl_desc,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_SUN60I_A733_R
+	{
+		.compatible = "allwinner,sun60i-a733-r-pinctrl",
+		.data = (ulong)&sun60i_a733_r_pinctrl_desc,
+	},
+#endif
 	{}
 };
 

-- 
2.51.2

