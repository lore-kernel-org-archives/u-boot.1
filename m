Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DDCCD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5D283B23;
	Sun, 16 Nov 2025 15:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC11839A8; Sun, 16 Nov 2025 15:45:28 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A781683B32
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 8720033FE60;
 Sun, 16 Nov 2025 14:45:21 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:43:59 +0000
Subject: [PATCH 08/11] pinctrl: sunxi: a733: add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-8-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3955; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=HDyc5YUoyBmV7ty/1L17/kBQv9ffeo/AlwydyIsreuE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeNPNy0h7S+uuRrr4SC89yCRvJDzcg5DYEII7
 E3rgJ16+0yJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjT18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277SKVD/91uGzUraWkc0I5mo
 QaC5aNK3ZRFF7ids/7vuVXodqGCyRXGfYhlPqTCZQfqhcWFugGHFLu06VRB0DX0iM+tu91lv7pH
 BbAZaIeEEjSLz/vLm5SB1hp3LK4p3HOA9x4e4aw2xG76N69kq2glboPObjzssmf8di1wE9gxiDH
 OA2kw1sJbuYlPA8L2rCBqAL3Q6B7iSUE3M575UQTb8tevFkRZmWtaIkHLEKXLBsl2XF20cc9L8W
 duHM6Zr92+oXIR2YLhF/TNlwFRnHwwqLVc1MruFLXlycBDckZ5phiq9y3hySXgqhJbRCFGW1Ai0
 87Q1GOOaT3WIE3mK8EuSZXcHb8h4/+/FPAqMop056ditmpYXA7AAPGmHFhsUhMvHo3ZQMIOAKJq
 ZKu8uJMFLloP/vROj9jAEawUDgZ6s5cczuHuM8vtqvQOmnZph7sx+2+KCGQakszx5eVjGMf4J96
 x6uVhTAhiWOM/JUnHA9AdP8WCA2u5KbS0Rr043CeX4Zjzl4ZEW5Ps63xFsNQZMy6Krzzpyh4Zla
 +qFKQT+IKcnw9H6iZjY9Ivcn3SAlcAHjfnBiAxtSM+yCN1a7dGhZrLLIR4Jt803bLc32FLE+7I/
 piNhqtVMD26ZRZ6mUP/IpoeuQ11CoayCpMEcOCohTXvGx0Eb9WItaxR5wof9C4Goi3Mg==
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
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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
index fd357ab0d4e..c628109511e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -197,6 +197,10 @@ static int sunxi_pinctrl_bind(struct udevice *dev)
 
 	plat->base = dev_read_addr_ptr(dev);
 
+	/* offset 0x80 as virtual PA port */
+	if (device_is_compatible(dev, "allwinner,sun60i-a733-pinctrl"))
+		plat->base += 0x80;
+
 	ret = device_bind_driver_to_node(dev, "gpio_sunxi", dev->name,
 					 dev_ofnode(dev), &gpio_dev);
 	if (ret)
@@ -782,6 +786,31 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_pinctrl_desc =
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
+	.num_functions	= ARRAY_SIZE(sun60i_a733_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_A,
+	.num_banks	= 11,
+};
+
 static const struct sunxi_pinctrl_function sun50i_h616_r_pinctrl_functions[] = {
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
@@ -847,6 +876,21 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_r_pinctrl_desc
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
@@ -1034,6 +1078,19 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
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

