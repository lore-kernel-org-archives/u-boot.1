Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BF606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MKOfOXQZ;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=zNB9H35m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DFE860E82;
	Fri, 13 Nov 2026 02:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JIMGIXbwInq; Fri, 13 Nov 2026 02:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC9C460E7E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537206;
	b=NMl1f1lHpBHavopWOWUHtjcaPCnTs+9MkPt4YyvbTeSnPobf4V+87P/E3peO2YXs2G8d
	 VMBI07Ihu4EKpE1ST6IkMrXFzq7sLoa4Cv+WpT3ZjUJz+70BgZUaXXUimwFMhYL+4e2hC
	 yrUbUtLcNNxXb+OqTwnTQ8Du9hNT1m/RtJVteOa4BeBG1iXubokKm1wOa0PTEokMaao48
	 u0mPDJE0QxczkpUtpY8zp3nEz+04qfAaUQ0D8DVbjsArGe7MVvF6NBcEOED1kXdnru1e1
	 LTqv+Wxsfoad4LLv+Zhio/k0+gmiD9kHoCs40q2QiUZX6OF/7O9w4UQ+7Gkdvd1SpjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3Kw18U5aea9de7ML3mHxIHFfpWiLhJ4Ox+sYqQ2CYmE=;
	b=KV4hy3u8rq+1mgYxp1Y2/ZfKoc3zu8pYg2gi89q8FyFpWahFks6Sx2M54+kjNiMbh6WG
	 9cPh6LOfAIWjkH6Nnk+oGFAAnh/THncBoT1TOCuUfj+UlJk5s1dx8COdP36YVFTJIAbrd
	 Ht2Y42EZ0GsDgURjcOK1/i4uIjp/WDSA/JrNSaTermaqrCjn9+i5xfSbkj8nbWD5++kPQ
	 hy8laca5LG5kzw5uQNqOaJTCVnl84j9KgNaNx8URghl4j9cJMfkTjBSR+jl5ih4Dm3bTa
	 CzZQH8nt6IIp2icK8fCmKsbxT0xTRW4NPrbLHJeySHAN5ba+QTvumAj0N5Fenab+ANQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537206;
	bh=3Kw18U5aea9de7ML3mHxIHFfpWiLhJ4Ox+sYqQ2CYmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKOfOXQZQzb4IHlc4yKHSBqKXtIlTxhuECM+8QFEWzpyvSXvUxHRKHgiZ2gRgSeEz
	 4DlFzr3gC1lKVbKO2liByZZSOZsZc43/n1engyCsik/GouVwprUuDyT1PAs4anQBrj
	 KLy8Btc0g1LJAemrBy2dE2Z0lPmMw6mbEqr3y0ayMvY1q4LWeI6mX/g6/ZZixnP94Y
	 Mms++sBXtzg5DDndV9Ou/qaA16WB7kmEuV4DlBLq7077Xd2+wHjsm+bMYNjneCGoox
	 H99unE1lTbvyLdLvDE/xcp3luFSKUO9yaUvf+qsRm1/1wUaC9eh4rCxQ/wGWge1LKd
	 0e2oPZIz/NVBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC9C460E7E;
	Fri, 13 Nov 2026 02:33:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A10F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1555140D2E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4fcb16COCwNC for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D445640B22
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=zNB9H35m
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D445640B22
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:22 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 3BCEE45733;
 Fri, 13 Nov 2026 13:33:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kw18U5aea9de7ML3mHxIHFfpWiLhJ4Ox+sYqQ2CYmE=;
 b=zNB9H35mFOaF/tFy1uri0prq9trhrsgPn66xkhrDIJU7sAoGraLvo1Fq0rr9NSRgqdq+yP
 ukh0ghEzLUmzHde1q1fVuSqHHfh5poDJ7TxjB5sm0dRlwormHo4VoIGvtzTvQh4FN9wjZX
 E+j8AGUyT2VNzZ9ugmSx2JzyzrT0pc2pn2h6gKRI+tEdlxnTADWCkmaYmaqtvWQ70INW/9
 0m/hmn0Z36XWhdj6Sa5T1qUCg+ql3JKm1CjlSDH/AHBXMRdUjs97pLJJ6kbMuHrLX2zKCR
 L9mfLNaFg0TjgjIy/0oJYWQZ5LuypZMxX4cuY42P1h9Sx/A/WmycOPloMLhpOQ==
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
Subject: [PATCH 07/26] pinctrl: sunxi: a733: add initial support
Date: Fri, 13 Nov 2026 13:32:17 +1100
Message-ID: <20261113023236.569054-8-alastair@d-silva.org>
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

Add pin controller support for Allwinner A733 SoC, covering both main
PIO (allwinner,sun60i-a733-pinctrl) and R-PIO
(allwinner,sun60i-a733-r-pinctrl).

Because A733 main PIO starts Port B at offset 0x100 with a 0x80-byte
bank stride while R-PIO retains a 0x30-byte bank stride from offset 0x0,
track per-controller bank_offset and bank_size in sunxi_pinctrl_desc.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-7-f19dcd098f60@gentoo.org
[Alastair: add per-controller bank_size so R-PIO Bank M keeps 0x30
 stride, select SUNXI_A733_PINCTRL and add UART0_PORT_B0 mux]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/pinctrl/sunxi/Kconfig         | 18 +++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 98 ++++++++++++++++++++++++---
 2 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 54314992299..c1cd8dc05d6 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -149,4 +149,22 @@ config PINCTRL_SUN55I_A523_R
 	default MACH_SUN55I_A523
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN60I_A733
+	bool "Support for the Allwinner A733 PIO"
+	depends on MACH_SUN60I_A733
+	default MACH_SUN60I_A733
+	select PINCTRL_SUNXI
+	select SUNXI_A733_PINCTRL if SUNXI_GPIO
+	help
+	  Select this to enable the main pin controller (PIO) driver on
+	  Allwinner A733 and T736 SoCs.
+
+config PINCTRL_SUN60I_A733_R
+	bool "Support for the Allwinner A733 R-PIO"
+	default MACH_SUN60I_A733
+	select PINCTRL_SUNXI
+	help
+	  Select this to enable the PRCM pin controller (R-PIO) driver on
+	  Allwinner A733 and T736 SoCs.
+
 endif
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index ab4e88c9918..920c15ab864 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -33,12 +33,23 @@ struct sunxi_pinctrl_desc {
 	u8					num_functions;
 	u8					first_bank;
 	u8					num_banks;
+	u16					bank_offset;
+	u16					bank_size;
 };
 
 struct sunxi_pinctrl_plat {
 	void __iomem *base;
 };
 
+static void *sunxi_pinctrl_bank_regs(struct sunxi_pinctrl_plat *plat,
+				     const struct sunxi_pinctrl_desc *desc,
+				     uint bank)
+{
+	u16 stride = desc->bank_size ? desc->bank_size : SUNXI_PINCTRL_BANK_SIZE;
+
+	return plat->base + desc->bank_offset + bank * stride;
+}
+
 static int sunxi_pinctrl_get_pins_count(struct udevice *dev)
 {
 	const struct sunxi_pinctrl_desc *desc = dev_get_priv(dev);
@@ -87,7 +98,7 @@ static int sunxi_pinctrl_pinmux_set(struct udevice *dev, uint pin_selector,
 	      sunxi_pinctrl_get_function_name(dev, func_selector),
 	      desc->functions[func_selector].mux);
 
-	sunxi_gpio_set_cfgbank(plat->base + bank * SUNXI_PINCTRL_BANK_SIZE,
+	sunxi_gpio_set_cfgbank(sunxi_pinctrl_bank_regs(plat, desc, bank),
 			       pin, desc->functions[func_selector].mux);
 
 	return 0;
@@ -100,20 +111,24 @@ static const struct pinconf_param sunxi_pinctrl_pinconf_params[] = {
 	{ "drive-strength",	PIN_CONFIG_DRIVE_STRENGTH,	10 },
 };
 
-static int sunxi_pinctrl_pinconf_set_pull(struct sunxi_pinctrl_plat *plat,
+static int sunxi_pinctrl_pinconf_set_pull(struct udevice *dev,
 					  uint bank, uint pin, uint bias)
 {
-	void *regs = plat->base + bank * SUNXI_PINCTRL_BANK_SIZE;
+	const struct sunxi_pinctrl_desc *desc = dev_get_priv(dev);
+	struct sunxi_pinctrl_plat *plat = dev_get_plat(dev);
+	void *regs = sunxi_pinctrl_bank_regs(plat, desc, bank);
 
 	sunxi_gpio_set_pull_bank(regs, pin, bias);
 
 	return 0;
 }
 
-static int sunxi_pinctrl_pinconf_set_drive(struct sunxi_pinctrl_plat *plat,
+static int sunxi_pinctrl_pinconf_set_drive(struct udevice *dev,
 					   uint bank, uint pin, uint drive)
 {
-	void *regs = plat->base + bank * SUNXI_PINCTRL_BANK_SIZE;
+	const struct sunxi_pinctrl_desc *desc = dev_get_priv(dev);
+	struct sunxi_pinctrl_plat *plat = dev_get_plat(dev);
+	void *regs = sunxi_pinctrl_bank_regs(plat, desc, bank);
 
 	if (drive < 10 || drive > 40)
 		return -EINVAL;
@@ -127,7 +142,6 @@ static int sunxi_pinctrl_pinconf_set_drive(struct sunxi_pinctrl_plat *plat,
 static int sunxi_pinctrl_pinconf_set(struct udevice *dev, uint pin_selector,
 				     uint param, uint val)
 {
-	struct sunxi_pinctrl_plat *plat = dev_get_plat(dev);
 	int bank = pin_selector / SUNXI_GPIOS_PER_BANK;
 	int pin  = pin_selector % SUNXI_GPIOS_PER_BANK;
 
@@ -135,9 +149,9 @@ static int sunxi_pinctrl_pinconf_set(struct udevice *dev, uint pin_selector,
 	case PIN_CONFIG_BIAS_DISABLE:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_UP:
-		return sunxi_pinctrl_pinconf_set_pull(plat, bank, pin, val);
+		return sunxi_pinctrl_pinconf_set_pull(dev, bank, pin, val);
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		return sunxi_pinctrl_pinconf_set_drive(plat, bank, pin, val);
+		return sunxi_pinctrl_pinconf_set_drive(dev, bank, pin, val);
 	}
 
 	return -EINVAL;
@@ -146,10 +160,12 @@ static int sunxi_pinctrl_pinconf_set(struct udevice *dev, uint pin_selector,
 static int sunxi_pinctrl_get_pin_muxing(struct udevice *dev, uint pin_selector,
 					char *buf, int size)
 {
+	const struct sunxi_pinctrl_desc *desc = dev_get_priv(dev);
 	struct sunxi_pinctrl_plat *plat = dev_get_plat(dev);
 	int bank = pin_selector / SUNXI_GPIOS_PER_BANK;
 	int pin	 = pin_selector % SUNXI_GPIOS_PER_BANK;
-	int mux  = sunxi_gpio_get_cfgbank(plat->base + bank * SUNXI_PINCTRL_BANK_SIZE, pin);
+	void *regs = sunxi_pinctrl_bank_regs(plat, desc, bank);
+	int mux  = sunxi_gpio_get_cfgbank(regs, pin);
 
 	switch (mux) {
 	case SUNXI_GPIO_INPUT:
@@ -207,7 +223,7 @@ static int sunxi_pinctrl_bind(struct udevice *dev)
 		if (!gpio_plat)
 			return -ENOMEM;
 
-		gpio_plat->regs = plat->base + i * SUNXI_PINCTRL_BANK_SIZE;
+		gpio_plat->regs = sunxi_pinctrl_bank_regs(plat, desc, i);
 		gpio_plat->bank_name[0] = 'P';
 		gpio_plat->bank_name[1] = 'A' + desc->first_bank + i;
 		gpio_plat->bank_name[2] = '\0';
@@ -784,6 +800,41 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_pinctrl_desc =
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
+	{ "pcie",	6 },	/* PD20 */
+	{ "spi0",	5 },	/* PC2-PC4, PC7, PC12 */
+#if IS_ENABLED(CONFIG_UART0_PORT_F)
+	{ "uart0",	3 },	/* PF2, PF4 */
+#elif IS_ENABLED(CONFIG_UART0_PORT_B0)
+	{ "uart0",	3 },	/* PB0, PB1 */
+#else
+	{ "uart0",	2 },	/* PB9, PB10 */
+#endif
+	{ "uart1",	2 },	/* PG6, PG7 */
+};
+
+/*
+ * A733 main PIO omits Port A physically; Port B begins at offset 0x100 with a
+ * 0x80-byte bank stride, so .first_bank = SUNXI_GPIO_A reserves a virtual PA
+ * slot at +0x80 to keep linear bank indices aligned with Port B..K.
+ */
+static const struct sunxi_pinctrl_desc __maybe_unused sun60i_a733_pinctrl_desc = {
+	.functions	= sun60i_a733_pinctrl_functions,
+	.num_functions	= ARRAY_SIZE(sun60i_a733_pinctrl_functions),
+	.first_bank	= SUNXI_GPIO_A,
+	.num_banks	= 11,
+	.bank_offset	= SUN60I_A733_PINCTRL_BANK_OFFSET,
+	.bank_size	= SUN60I_A733_PINCTRL_BANK_SIZE,
+};
+
 static const struct sunxi_pinctrl_function sun50i_h616_r_pinctrl_functions[] = {
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
@@ -849,6 +900,21 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun55i_a523_r_pinctrl_desc
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
@@ -1035,6 +1101,18 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
 		.compatible = "allwinner,sun55i-a523-r-pinctrl",
 		.data = (ulong)&sun55i_a523_r_pinctrl_desc,
 	},
+#endif
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
 #endif
 	{}
 };
-- 
2.53.0

