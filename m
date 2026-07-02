Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C371C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A19B84A0E;
	Thu,  2 Jul 2026 12:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BF984409; Thu,  2 Jul 2026 12:09:00 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0570E849E5
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:08:58 +0200 (CEST)
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
Date: Thu, 2 Jul 2026 18:08:37 +0800
Subject: [PATCH 4/4] pinctrl: aspeed: Add AST2700 SoC1 pinconf support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260702-pinctrl-v1-4-4d2bd89fc213@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782986917; l=7766;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=2PslQbC+FQQlZiNLicOTAsp+IkB3LVudqfto9cjpOZo=;
 b=EdtI2fuDWA+Z7I6mrhOCxiiLJnoyQOvjCwEgYRK1umpfYk7rMlJua+Dtz8x1OUoKyRVMBpuPP
 t2liaNyTY+6AMQl0D1Qh7VYebQhVsZdntwCFm10FAK3JpToXRGzm0JT
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

The SoC1 SCU provides a bias enable bit per pin in the registers at
0x480 (setting the bit disables the bias; the pull direction is fixed
in silicon) and 2-bit drive strength fields at 0x4C0 selecting 4 mA to
16 mA in 4 mA steps. The pin-to-field mapping of the drive strength
registers is sparse and non-linear, so it is kept in a lookup table
mirroring the Linux driver; pins without an entry reject
drive-strength with -ENOTSUPP.

Support the bias-disable, bias-pull-down, bias-pull-up and
drive-strength properties per pin and per group, and select PINCONF so
the generic pinctrl framework parses them.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pinctrl/Kconfig                       |   1 +
 drivers/pinctrl/aspeed/pinctrl_ast2700_soc1.c | 147 ++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c371d94ee6a..40e14d5ec49 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -391,6 +391,7 @@ config ASPEED_AST2700_SOC0_PINCTRL
 config ASPEED_AST2700_SOC1_PINCTRL
 	bool "Aspeed AST2700 SoC1 pin control driver"
 	depends on DM && PINCTRL_GENERIC && ASPEED_AST2700
+	select PINCONF
 	default y
 	help
 	  Support pin multiplexing control on Aspeed ast2700 SoC1. The driver
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2700_soc1.c b/drivers/pinctrl/aspeed/pinctrl_ast2700_soc1.c
index 9d65064d44c..05656c38ad2 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2700_soc1.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2700_soc1.c
@@ -20,6 +20,17 @@
 #define AST2700_SOC1_MUX_BITS_PER_PIN	4
 #define AST2700_SOC1_MUX_PINS_PER_REG	8
 
+#define AST2700_SOC1_BIAS_BASE		0x480
+#define AST2700_SOC1_BIAS_PINS_PER_REG	32
+
+#define AST2700_SOC1_DRV_BASE		0x4c0
+#define AST2700_SOC1_DRV_MASK		0x3
+#define AST2700_SOC1_DRV_BITS_PER_PIN	2
+#define AST2700_SOC1_DRV_PINS_PER_REG	16
+#define AST2700_SOC1_DRV_STEP_MA	4
+#define AST2700_SOC1_DRV_MIN_MA		4
+#define AST2700_SOC1_DRV_MAX_MA		16
+
 enum {
 	C16,
 	C14,
@@ -1456,6 +1467,138 @@ ast2700_soc1_pinctrl_gpio_request_enable(struct udevice *dev,
 	return 0;
 }
 
+/*
+ * Drive strength is controlled by 2-bit fields in the registers at
+ * DRV_BASE, but the mapping from pins to fields is sparse and
+ * non-linear: only a subset of the pins supports drive strength
+ * selection. The table stores (field index + 1) so that the implicit
+ * zero initialization marks the unsupported pins.
+ */
+static const u8 ast2700_soc1_drv_map[] = {
+	[C16] = 1,   [C14] = 2,   [C11] = 3,   [D9] = 4,    [F14] = 5,
+	[D10] = 6,   [C12] = 7,   [C13] = 8,   [W25] = 9,   [Y23] = 10,
+	[Y24] = 11,  [W21] = 12,  [AA23] = 13, [AC22] = 14, [AB22] = 15,
+	[Y21] = 16,  [AE20] = 17, [AF19] = 18, [Y22] = 19,  [AA20] = 20,
+	[AA22] = 21, [AB20] = 22, [AF18] = 23, [AE19] = 24, [AD20] = 25,
+	[AC20] = 26, [AA21] = 27, [AB21] = 28, [AC19] = 29, [AE18] = 30,
+	[AD19] = 31, [AD18] = 32, [U25] = 33,  [U26] = 34,  [Y26] = 35,
+	[AA24] = 36, [R25] = 37,  [AA26] = 38, [R26] = 39,  [Y25] = 40,
+	[B16] = 41,  [D14] = 42,  [B15] = 43,  [B14] = 44,  [C17] = 45,
+	[B13] = 46,  [E14] = 47,  [C15] = 48,  [D24] = 49,  [B23] = 50,
+	[B22] = 51,  [C23] = 52,  [B18] = 53,  [B21] = 54,  [M15] = 55,
+	[B19] = 56,  [B26] = 57,  [A25] = 58,  [A24] = 59,  [B24] = 60,
+	[E26] = 61,  [A21] = 62,  [A19] = 63,  [A18] = 64,  [D26] = 65,
+	[C26] = 66,  [A23] = 67,  [A22] = 68,  [B25] = 69,  [F26] = 70,
+	[A26] = 71,  [A14] = 72,  [E10] = 73,  [E13] = 74,  [D12] = 75,
+	[F10] = 76,  [E11] = 77,  [F11] = 78,  [F13] = 79,  [N15] = 80,
+	[C20] = 81,  [C19] = 82,  [A8] = 83,   [R14] = 84,  [A7] = 85,
+	[P14] = 86,  [D20] = 87,  [A6] = 88,   [B6] = 89,   [N14] = 90,
+	[B7] = 91,   [B8] = 92,   [B9] = 93,   [M14] = 94,  [J11] = 95,
+	[E7] = 96,   [D19] = 97,  [B11] = 98,  [D15] = 99,  [B12] = 100,
+	[B10] = 101, [P13] = 102, [C18] = 103, [C6] = 104,  [C7] = 105,
+	[D7] = 106,  [N13] = 107, [C8] = 108,  [C9] = 109,  [C10] = 110,
+	[M16] = 111, [A15] = 112, [E9] = 113,  [F9] = 114,  [F8] = 115,
+	[M13] = 116, [F7] = 117,  [D8] = 118,  [E8] = 119,  [L12] = 120,
+};
+
+static struct ast2700_soc1_field
+ast2700_soc1_bias_field_from_pin(unsigned int pin)
+{
+	return (struct ast2700_soc1_field){
+		.reg = AST2700_SOC1_BIAS_BASE +
+		       (pin / AST2700_SOC1_BIAS_PINS_PER_REG) * sizeof(u32),
+		.shift = pin % AST2700_SOC1_BIAS_PINS_PER_REG,
+		.mask = 0x1,
+	};
+}
+
+static struct ast2700_soc1_field
+ast2700_soc1_drv_field_from_idx(unsigned int idx)
+{
+	return (struct ast2700_soc1_field){
+		.reg = AST2700_SOC1_DRV_BASE +
+		       (idx / AST2700_SOC1_DRV_PINS_PER_REG) * sizeof(u32),
+		.shift = (idx % AST2700_SOC1_DRV_PINS_PER_REG) *
+			 AST2700_SOC1_DRV_BITS_PER_PIN,
+		.mask = AST2700_SOC1_DRV_MASK,
+	};
+}
+
+static const struct pinconf_param ast2700_soc1_pinconf_params[] = {
+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
+	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
+};
+
+static int ast2700_soc1_pinctrl_pinconf_set(struct udevice *dev,
+					    unsigned int selector,
+					    unsigned int param,
+					    unsigned int arg)
+{
+	struct ast2700_soc1_pinctrl_priv *priv = dev_get_priv(dev);
+	struct ast2700_soc1_field field;
+	unsigned int val, idx;
+
+	if (selector > AC24)
+		return -EINVAL;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_PULL_UP:
+		/*
+		 * One bias enable bit per pin; the pull direction is fixed
+		 * in silicon. Setting the bit disables the bias.
+		 */
+		field = ast2700_soc1_bias_field_from_pin(selector);
+		val = param == PIN_CONFIG_BIAS_DISABLE ? 1 : 0;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		if (selector >= ARRAY_SIZE(ast2700_soc1_drv_map) ||
+		    !ast2700_soc1_drv_map[selector])
+			return -ENOTSUPP;
+		if (arg < AST2700_SOC1_DRV_MIN_MA ||
+		    arg > AST2700_SOC1_DRV_MAX_MA ||
+		    arg % AST2700_SOC1_DRV_STEP_MA)
+			return -EINVAL;
+		idx = ast2700_soc1_drv_map[selector] - 1;
+		field = ast2700_soc1_drv_field_from_idx(idx);
+		val = arg / AST2700_SOC1_DRV_STEP_MA - 1;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	clrsetbits_le32(ast2700_soc1_reg(priv, field.reg),
+			field.mask << field.shift, val << field.shift);
+
+	return 0;
+}
+
+static int ast2700_soc1_pinctrl_pinconf_group_set(struct udevice *dev,
+						  unsigned int selector,
+						  unsigned int param,
+						  unsigned int arg)
+{
+	const struct ast2700_soc1_group *group;
+	unsigned int i;
+	int ret;
+
+	if (selector >= ARRAY_SIZE(ast2700_soc1_groups))
+		return -EINVAL;
+
+	group = &ast2700_soc1_groups[selector];
+	for (i = 0; i < group->npins; i++) {
+		ret = ast2700_soc1_pinctrl_pinconf_set(dev, group->pins[i],
+						       param, arg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ast2700_soc1_pinctrl_probe(struct udevice *dev)
 {
 	struct ast2700_soc1_pinctrl_priv *priv = dev_get_priv(dev);
@@ -1478,6 +1621,10 @@ static const struct pinctrl_ops ast2700_soc1_pinctrl_ops = {
 	.get_function_name = ast2700_soc1_pinctrl_get_function_name,
 	.pinmux_group_set = ast2700_soc1_pinctrl_group_set,
 	.gpio_request_enable = ast2700_soc1_pinctrl_gpio_request_enable,
+	.pinconf_num_params = ARRAY_SIZE(ast2700_soc1_pinconf_params),
+	.pinconf_params = ast2700_soc1_pinconf_params,
+	.pinconf_set = ast2700_soc1_pinctrl_pinconf_set,
+	.pinconf_group_set = ast2700_soc1_pinctrl_pinconf_group_set,
 };
 
 static const struct udevice_id ast2700_soc1_pinctrl_ids[] = {

-- 
2.34.1

