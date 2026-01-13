Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88583D29DC2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A488839D7;
	Tue, 13 Jan 2026 05:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C5383981; Tue, 13 Jan 2026 05:03:06 +0100 (CET)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAC683981
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 23E51340F21;
 Tue, 13 Jan 2026 04:02:59 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 13 Jan 2026 12:02:01 +0800
Subject: [PATCH v3 7/9] pinctrl: sunxi: a733: add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-01-a733-soc-support-v3-7-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4191; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=v4cmAUCWHJ7wl5gwYnVwiydN+jiMCqsmcg+HcBRgsc4=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcPUv8QW/siW1nkt4CxgzgyilVsFGqpSwV6dm
 sGr7s1SeIWJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXD1BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1tTg/9GtC9HdC+8lnI864cSnuanHbu5QEv+R6F1PmZbRcv6+BemTAkmXgtC
 PGX/ld9s/CG7E9cybIGBTJheyn/oplSZHZsMEwWi60Qo5khV3lMcA9cULDlzOTdeS+YrkzD/Jk6
 Z7ZIs0VFAGQ9BeV3fNPXc2tSpzRtppen8MDU2uNMAhoE6Ok5t90hMvLMsFZSG5XIlQ4PjdTs79A
 B6TOlfZ8KgkRS4cSmPDaFIBb3kQKAnR+hVZKcVSUK1qOXJWkVN1RESO/mqrd5gDEKuWkXu+7z8Q
 bRVyxlaDCEviwewZ7dg5YGcMHGB7vQRLaX+nBU0PCX5sRyWKqx5aBie3JQ1eU7RA8gNF2mmhF79
 DLcqZhNgOiUDWXKCzp6S0hoaFiTIO+8SHL6FaTeWhHbK7sUjBSYbT9ISUAOfRk8j8PDGUmJWUxj
 k3mS/e23v95H6MMTlx9DIcELX6n4fIgEMFlw3lPEZTJZai6I/bY0tj7grMa1OAjxOe7syHYtpgP
 6maU03M1s4FXmbliBjye58N6TQZ6hwLfCT2ga0OT4WGWjoqGpyFJxXxPAapAjgJ7cuXEoZWjavi
 gnRuvyukB/jZrCWOcs0mMc9pj8C4jrhOXdragmhC6IBamHXQDHnoQdVTtSlhO9Tmjb/3qJkvPbi
 WFcD/E4FU8uPu+4V4Pr/9VjcuunBgw=
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
2.52.0

