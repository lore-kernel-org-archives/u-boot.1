Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C7C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C76849F3;
	Thu,  2 Jul 2026 12:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91768849F3; Thu,  2 Jul 2026 12:08:58 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F8084994
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:08:55 +0200 (CEST)
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
Date: Thu, 2 Jul 2026 18:08:35 +0800
Subject: [PATCH 2/4] pinctrl: aspeed: Add AST2700 SoC0 pinconf support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-pinctrl-v1-2-4d2bd89fc213@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782986917; l=8510;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=mCiI5AYE/WQJCwiP77O1jFu7v9FVZx1APxTNyms2CI4=;
 b=O3nEvlLp8oB56W/HfXu2IQUNTgx+2F6X9hkdcqRAtJLS1gR4KPsR1Gc74QN12HALSeXOIjmwv
 k18WGfT+paVDJ33SILyNWVn8gBcu5PQ9QPqPMFz9xJbJ01KoyoF+OKG
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

Each GPIO18A/GPIO18B ball has its own IO control register starting at
SCU 0x480, providing a 4-bit drive strength selector (3 mA to 41 mA in
hardware-defined steps), a bias enable bit and a pull direction bit.

Extend the group table with the pin members of the ball-backed groups
so bias-disable, bias-pull-down, bias-pull-up and drive-strength
properties can be applied per group as well as per pin. The routing
groups (USB, JTAG, PCIe RC) have no package balls and reject pin
configuration with -ENOTSUPP.

Select PINCONF so the generic pinctrl framework parses the pin
configuration properties.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pinctrl/Kconfig                       |   1 +
 drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c | 205 +++++++++++++++++++++-----
 2 files changed, 172 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 35b3f3afa66..254da75d144 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -381,6 +381,7 @@ config ASPEED_AST2600_PINCTRL
 config ASPEED_AST2700_SOC0_PINCTRL
 	bool "Aspeed AST2700 SoC0 pin control driver"
 	depends on DM && PINCTRL_GENERIC && ASPEED_AST2700
+	select PINCONF
 	default y
 	help
 	  Support pin multiplexing control on Aspeed ast2700 SoC0. The driver
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c b/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c
index 9a973285b0b..b5111d7ee15 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2700_soc0.c
@@ -18,6 +18,24 @@
 #define SCU404			0x404
 #define SCU408			0x408
 #define SCU410			0x410
+/* One IO control register per ball, GPIO18A0..GPIO18B3 */
+#define SCU480			0x480
+
+/* Indexes into ast2700_soc0_pins[], in GPIO18A0..GPIO18B3 order */
+enum {
+	AC14,
+	AE15,
+	AD14,
+	AE14,
+	AF14,
+	AB13,
+	AB14,
+	AF15,
+	AF13,
+	AC13,
+	AD13,
+	AE13,
+};
 
 #define USB_PORTA_ROUTE	BIT(9)
 #define USB_PORTB_ROUTE	BIT(10)
@@ -62,38 +80,72 @@ struct ast2700_soc0_pinctrl_priv {
 	void __iomem *base;
 };
 
-static const char * const ast2700_soc0_groups[] = {
-	"EMMCG1",
-	"EMMCG4",
-	"EMMCG8",
-	"EMMCWPN",
-	"EMMCCDN",
-	"VGADDC",
-	"VB1",
-	"VB0",
-	"TSPRSTN",
-	"UFSCLKI",
-	"USB3A",
-	"USB3AAP",
-	"USB3ABP",
-	"USB3B",
-	"USB3BAP",
-	"USB3BBP",
-	"USB2A",
-	"USB2AAP",
-	"USB2ABP",
-	"USB2ADAP",
-	"USB2AH",
-	"USB2AHAP",
-	"USB2B",
-	"USB2BBP",
-	"USB2BAP",
-	"USB2BDBP",
-	"USB2BH",
-	"USB2BHBP",
-	"JTAG0",
-	"PCIERC0PERST",
-	"PCIERC1PERST",
+struct ast2700_soc0_group {
+	const char *name;
+	const u8 *pins;
+	unsigned int npins;
+};
+
+static const u8 ast2700_soc0_emmcg1_pins[] = { AC14, AE15, AD14 };
+static const u8 ast2700_soc0_emmcg4_pins[] = {
+	AC14, AE15, AD14, AE14, AF14, AB13,
+};
+
+static const u8 ast2700_soc0_emmcg8_pins[] = {
+	AC14, AE15, AD14, AE14, AF14, AB13, AF13, AC13, AD13, AE13,
+};
+
+static const u8 ast2700_soc0_emmcwpn_pins[] = { AF15 };
+static const u8 ast2700_soc0_emmccdn_pins[] = { AB14 };
+static const u8 ast2700_soc0_vgaddc_pins[] = { AD13, AE13 };
+static const u8 ast2700_soc0_vb1_pins[] = { AC14, AE15, AD14, AE14 };
+static const u8 ast2700_soc0_vb0_pins[] = { AF15, AB14, AF13, AC13 };
+static const u8 ast2700_soc0_tsprstn_pins[] = { AF13 };
+static const u8 ast2700_soc0_ufsclki_pins[] = { AC13 };
+
+#define AST2700_SOC0_GROUP(_name, _pins)				\
+	{								\
+		.name = _name,						\
+		.pins = _pins,						\
+		.npins = ARRAY_SIZE(_pins),				\
+	}
+
+/*
+ * The USB, JTAG and PCIe RC groups control internal routing only; they
+ * have no package balls, hence no group pins to configure.
+ */
+static const struct ast2700_soc0_group ast2700_soc0_groups[] = {
+	AST2700_SOC0_GROUP("EMMCG1", ast2700_soc0_emmcg1_pins),
+	AST2700_SOC0_GROUP("EMMCG4", ast2700_soc0_emmcg4_pins),
+	AST2700_SOC0_GROUP("EMMCG8", ast2700_soc0_emmcg8_pins),
+	AST2700_SOC0_GROUP("EMMCWPN", ast2700_soc0_emmcwpn_pins),
+	AST2700_SOC0_GROUP("EMMCCDN", ast2700_soc0_emmccdn_pins),
+	AST2700_SOC0_GROUP("VGADDC", ast2700_soc0_vgaddc_pins),
+	AST2700_SOC0_GROUP("VB1", ast2700_soc0_vb1_pins),
+	AST2700_SOC0_GROUP("VB0", ast2700_soc0_vb0_pins),
+	AST2700_SOC0_GROUP("TSPRSTN", ast2700_soc0_tsprstn_pins),
+	AST2700_SOC0_GROUP("UFSCLKI", ast2700_soc0_ufsclki_pins),
+	{ "USB3A" },
+	{ "USB3AAP" },
+	{ "USB3ABP" },
+	{ "USB3B" },
+	{ "USB3BAP" },
+	{ "USB3BBP" },
+	{ "USB2A" },
+	{ "USB2AAP" },
+	{ "USB2ABP" },
+	{ "USB2ADAP" },
+	{ "USB2AH" },
+	{ "USB2AHAP" },
+	{ "USB2B" },
+	{ "USB2BBP" },
+	{ "USB2BAP" },
+	{ "USB2BDBP" },
+	{ "USB2BH" },
+	{ "USB2BHBP" },
+	{ "JTAG0" },
+	{ "PCIERC0PERST" },
+	{ "PCIERC1PERST" },
 };
 
 static const char * const ast2700_soc0_functions[] = {
@@ -354,7 +406,7 @@ static int ast2700_soc0_pinctrl_get_groups_count(struct udevice *dev)
 static const char *ast2700_soc0_pinctrl_get_group_name(struct udevice *dev,
 						       unsigned int selector)
 {
-	return ast2700_soc0_groups[selector];
+	return ast2700_soc0_groups[selector].name;
 }
 
 static int ast2700_soc0_pinctrl_get_functions_count(struct udevice *dev)
@@ -383,7 +435,7 @@ static int ast2700_soc0_pinctrl_group_set(struct udevice *dev,
 		return -EINVAL;
 
 	function = ast2700_soc0_functions[func_selector];
-	group = ast2700_soc0_groups[group_selector];
+	group = ast2700_soc0_groups[group_selector].name;
 
 	for (i = 0; i < ARRAY_SIZE(ast2700_soc0_pinmuxes); i++) {
 		pinmux = &ast2700_soc0_pinmuxes[i];
@@ -458,6 +510,87 @@ static int ast2700_soc0_pinctrl_get_pin_muxing(struct udevice *dev,
 	return 0;
 }
 
+/* Drive strength in mA selectable by the IO control register [3:0] */
+static const u8 ast2700_soc0_drv_ma[] = {
+	3, 6, 8, 11, 16, 18, 20, 23, 30, 32, 33, 35, 37, 38, 39, 41,
+};
+
+static const struct pinconf_param ast2700_soc0_pinconf_params[] = {
+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
+	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
+};
+
+static int ast2700_soc0_pinctrl_pinconf_set(struct udevice *dev,
+					    unsigned int selector,
+					    unsigned int param,
+					    unsigned int arg)
+{
+	struct ast2700_soc0_pinctrl_priv *priv = dev_get_priv(dev);
+	u32 mask, val, i;
+
+	if (selector >= ARRAY_SIZE(ast2700_soc0_pins))
+		return -EINVAL;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		mask = BIT(5);
+		val = 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		mask = GENMASK(5, 4);
+		val = 2 << 4;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		mask = GENMASK(5, 4);
+		val = 3 << 4;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		for (i = 0; i < ARRAY_SIZE(ast2700_soc0_drv_ma); i++) {
+			if (ast2700_soc0_drv_ma[i] == arg)
+				break;
+		}
+		if (i == ARRAY_SIZE(ast2700_soc0_drv_ma))
+			return -EINVAL;
+		mask = GENMASK(3, 0);
+		val = i;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	clrsetbits_le32(priv->base + SCU480 + selector * 4, mask, val);
+
+	return 0;
+}
+
+static int ast2700_soc0_pinctrl_pinconf_group_set(struct udevice *dev,
+						  unsigned int selector,
+						  unsigned int param,
+						  unsigned int arg)
+{
+	const struct ast2700_soc0_group *group;
+	u32 i;
+	int ret;
+
+	if (selector >= ARRAY_SIZE(ast2700_soc0_groups))
+		return -EINVAL;
+
+	group = &ast2700_soc0_groups[selector];
+	if (!group->npins)
+		return -ENOTSUPP;
+
+	for (i = 0; i < group->npins; i++) {
+		ret = ast2700_soc0_pinctrl_pinconf_set(dev, group->pins[i],
+						       param, arg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct pinctrl_ops ast2700_soc0_pinctrl_ops = {
 	.set_state = pinctrl_generic_set_state,
 	.get_pins_count = ast2700_soc0_pinctrl_get_pins_count,
@@ -469,6 +602,10 @@ static const struct pinctrl_ops ast2700_soc0_pinctrl_ops = {
 	.get_function_name = ast2700_soc0_pinctrl_get_function_name,
 	.pinmux_group_set = ast2700_soc0_pinctrl_group_set,
 	.gpio_request_enable = ast2700_soc0_pinctrl_gpio_request_enable,
+	.pinconf_num_params = ARRAY_SIZE(ast2700_soc0_pinconf_params),
+	.pinconf_params = ast2700_soc0_pinconf_params,
+	.pinconf_set = ast2700_soc0_pinctrl_pinconf_set,
+	.pinconf_group_set = ast2700_soc0_pinctrl_pinconf_group_set,
 };
 
 static const struct udevice_id ast2700_soc0_pinctrl_ids[] = {

-- 
2.34.1

