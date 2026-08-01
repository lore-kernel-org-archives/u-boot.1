Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF2BC55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C71A280E40;
	Sat,  1 Aug 2026 16:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFwES400orSb; Sat,  1 Aug 2026 16:41:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FC2B80E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602484;
	bh=b6SaWqbYVxfpYjCfcF45aTJH9aywMirvR4AC6g4E6fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kr50FH1p7csYspG/9UBYc+018vRlfLrU62h7hi6D43PduYME+51lHOp+boOB48kf+
	 EnnJe1kbUfcKtphs/zBRhbe9/Nd0GNQ9761pSpc5LAd+v2VZR04tubCuov+rwavr9s
	 8XklT/z071YlUOx1FoJtc41eQZeZ9xeA/VFogKQ7xB33Zu4Y2rHl4d72QEVRMazgZb
	 TV/0qxBuJd1MCDGZ+6I4Dy4ikvGVwyVRKr/whltjIkWGZD9wo1EqwhYXB23OvLgYCF
	 j1ohgVGGbLKRPjknzgRiF1YneHoivXz9TrKXP2prLJYgNdSMVWI6HEDTt97qvYDpcF
	 n34Lf6UNJXs2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FC2B80E19;
	Sat,  1 Aug 2026 16:41:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA2A532E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC6DC4064C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nwA82t6WNgW for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E737D40649
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E737D40649
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E737D40649
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:21 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cace91f112so22052085ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602481; x=1786207281;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b6SaWqbYVxfpYjCfcF45aTJH9aywMirvR4AC6g4E6fA=;
 b=dy9bITw4Pxi5WlUvpFdAiZEVdYR0E+pPEDnojPqqJlGatxEGNE/MvDx2o0BdPI1vEU
 DP8EGcAf68eqiY60oewbVj6jCMtVhn2lFd2oY0W2WHoi4pEruLrv7YYfTFM+lKM6fkeS
 UEif9LPESIME9uhiKlMpcu10FstCn2bHipcxWhrJ/QC3KqJWAnzvBBmv0h6FxAzFCPdI
 L7FT4aPkl1rkqlY/HeYOoS3qwxvoktcQ3YHoUZ7EXae5QvFLlpvmLe9Ga2mz8XZf8mLs
 LQdaIArcJoRZsNpNTNylVQkvrKifsC+q+V1cM2HNL5qgEFcX78G9dXbXks5SbLfHpizs
 GLJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/U6NbvyVUnaf1zsWPy2NDDfl6Q/M1Cc5R1O6RjdFDkLEYilPf3PMn83eVwOvzunDrCXCeY/g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyPg/7VVxwxhIO1pg6Y7PgiZAWQWQHt+D7ZmBKSR6yWlcU7DlEW
 5KKprbBG1yfpHFC3mhI2uuj1gAGtAjcAfrxFbnoeBrW5qH8SZ5822OEzJrjFl1zvVA0=
X-Gm-Gg: AR+sD11uc7oiQAwSPuaYvGIQ4XL1aEhlOicL/kHnOzTSX9fI7Hymt+OGh0T8DTGixZv
 hH6dtRmHSB+Zqmt3aap857LmD+ga12/2jmJpwTmLz21Y02vLbQp0TnfERx98WOSPyaJi4e1TYdh
 b7sF0u9+wAMTLgc1rmqu5TU0fJqxErwjbkDTJGA5xeR+G6juuRmIRKnRAv1P14FBI6cx1KNua+w
 1d8hnm6+Zx19HqmbEhkMZPFDIyxru6YlxaNccQR7z+4gYAzFWOl1bW97PtQtewJuCMe/CuZ7Bu6
 SB+v41NpiSz7wwBoYSY2nP+Uy0HkgriEPquM0ePt+qtTWW6k2WKONwzsFTNWO3cnYlvJZDDHQ1A
 tdOaTqQSjDnElZRY54AR3Ho0Mb2DwIdnGXAznsMkzR29uYczhNSRuBZuyKPlBk7FyDVe0GIk1/O
 OBsqfRiVQHfW59QpYx+mLYkcjc3mSm5BjRz6hdViCD0pjvhIqmwsoTrjPNoiLGGnyuUrR/NdirI
 ZrIrGAC7nhV8YoGQ2MaUEghv8Co9En7zdurgTBp9a45G7aGAIinMj6lBrCLWtPIrwD4fZwMmEWB
 /fuj0GI5eX4bET/aeDblCxAx/w==
X-Received: by 2002:a05:6a21:7303:b0:3bb:2883:a723 with SMTP id
 adf61e73a8af0-3c92a83b3ddmr3819787637.35.1785602481260; 
 Sat, 01 Aug 2026 09:41:21 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:20 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:45 +0800
Subject: [PATCH v8 04/11] pinctrl: k1: add IO power domain configuration
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-4-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602481; x=1786207281;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6SaWqbYVxfpYjCfcF45aTJH9aywMirvR4AC6g4E6fA=;
 b=G3GV+taiedpSxxfJ+PSL1MZJKrhjJ03BhhawCA36TZ1PlAHhzJE4cKxMaiBOqEzazJ
 VJE0Z/eWgJvekCxSpBSrD6H3KlFpRujwQBzzDcFn2qwCaDCSa3i5uoNOHbMRkSMVQ1e8
 LCj4siJ6+5c1uwt9T9R2Oe4WJQ4FGTSPQieyHdZZRDLH3igvMtxHg0eaDd+xGCbw6Ivm
 5ys9SKMt2lxyEaIYtPNqjeFoALcHDqdV4kjqFbnDCk4gNsbwpWnBd7CoVYm46h5krnjx
 A6sEjqwzzPQtduKXZfiztZ9xhlYigGLAgclB1AwxClnLs3COvs0tDJ7UHbnA6wBOZM7F
 z17w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=G3GV+tai
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Dual-voltage GPIO banks default to 3.3V, but when externally supplied
with 1.8V the internal logic must be explicitly reconfigured to match.

Add the ability to program IO power domain control registers through the
APBC block. These registers require unlocking the AIB Secure Access
Register (ASAR) before every read/write, since configuring a 1.8V domain
while 3.3V is externally supplied can cause back-powering and pin damage.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>

---
v7:
- Remove the dependency on SYSCON.
v6:
- Use dev_read_phandle_with_args() to fetch "spacemit,apbc" instead.
v5:
- Use tabs for macro definition alignment.
- Fix the missing power source argument.
v3:
- Add SYSCON dependency in Kconfig.
- Fix not sorted issue in the driver.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 95 +++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 4e65fad1e8c5..9c0fa4badc25 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <regmap.h>
 
 /*
  * +---------+----------+-----------+--------+--------+----------+--------+
@@ -35,8 +36,23 @@
 #define PAD_PULLUP		BIT(14)
 #define PAD_PULL_EN		BIT(15)
 
-#define PIN_POWER_STATE_1V8		1800
-#define PIN_POWER_STATE_3V3		3300
+#define IO_PWR_DOMAIN_OFFSET	0x800
+
+#define IO_PWR_DOMAIN_GPIO2_Kx	0x0c
+#define IO_PWR_DOMAIN_GPIO3_K1	0x10
+#define IO_PWR_DOMAIN_MMC_Kx	0x1c
+#define IO_PWR_DOMAIN_QSPI_K1	0x20
+
+#define IO_PWR_DOMAIN_V18EN	BIT(2)
+
+#define APBC_ASFAR		0x50
+#define APBC_ASSAR		0x54
+
+#define APBC_ASFAR_AKEY		0xbaba
+#define APBC_ASSAR_AKEY		0xeb10
+
+#define PIN_POWER_STATE_1V8	1800
+#define PIN_POWER_STATE_3V3	3300
 
 enum spacemit_pin_io_type {
 	IO_TYPE_NONE = 0,
@@ -61,12 +77,14 @@ struct spacemit_pinctrl_data {
 	int (*get_pins)(struct udevice *dev);
 	int (*get_functions)(struct udevice *dev);
 	int (*get_io_type)(struct udevice *dev, unsigned int pin);
+	unsigned int (*pin_to_io_pd_offset)(unsigned int pin);
 };
 
 struct spacemit_pinctrl_priv {
 	void __iomem		*regs;
 	struct spacemit_pin_io	*io_pins;
 	int			nr_io_pins;
+	struct regmap		*regmap;
 };
 
 struct spacemit_pin_mux_config {
@@ -197,6 +215,28 @@ static int k1_get_io_type(struct udevice *dev, unsigned int selector)
 	return -EINVAL;
 }
 
+static unsigned int spacemit_k1_pin_to_io_pd_offset(unsigned int pin)
+{
+	unsigned int offset = 0;
+
+	switch (pin) {
+	case 47 ... 52:
+		offset = IO_PWR_DOMAIN_GPIO3_K1;
+		break;
+	case 75 ... 80:
+		offset = IO_PWR_DOMAIN_GPIO2_Kx;
+		break;
+	case 98 ... 103:
+		offset = IO_PWR_DOMAIN_QSPI_K1;
+		break;
+	case 104 ... 109:
+		offset = IO_PWR_DOMAIN_MMC_Kx;
+		break;
+	}
+
+	return offset;
+}
+
 /* use IO high level output current as the table */
 static struct spacemit_pin_drv_strength spacemit_ds_1v8_tbl[4] = {
 	{ 0, 11 },
@@ -403,6 +443,35 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
 	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	U32_MAX },
 };
 
+static void spacemit_set_io_power_domain(struct udevice *dev,
+					 unsigned int pin,
+					 unsigned int io_type)
+{
+	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	struct spacemit_pinctrl_data *data;
+	unsigned int offset;
+	u32 val = 0;
+
+	if (!priv->regmap)
+		return;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->pin_to_io_pd_offset)
+		return;
+
+	offset = data->pin_to_io_pd_offset(pin);
+	if (!offset)
+		return;
+
+	if (io_type == IO_TYPE_1V8)
+		val = IO_PWR_DOMAIN_V18EN;
+
+	regmap_write(priv->regmap, APBC_ASFAR, APBC_ASFAR_AKEY);
+	regmap_write(priv->regmap, APBC_ASSAR, APBC_ASSAR_AKEY);
+
+	writel(val, priv->regs + IO_PWR_DOMAIN_OFFSET + offset);
+}
+
 static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 				unsigned int param, unsigned int argument)
 {
@@ -417,6 +486,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
 		return -EINVAL;
+
 	addr = data->pin_to_reg(dev, pin_selector);
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -459,10 +529,14 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			}
 			break;
 		}
-		if (!found && argument != PIN_POWER_STATE_1V8) {
+		if (!found && argument != PIN_POWER_STATE_1V8 &&
+		    argument != PIN_POWER_STATE_3V3) {
 			dev_err(dev, "Invalid power source (%d)\n", argument);
 			return -EINVAL;
 		}
+		if (found)
+			spacemit_set_io_power_domain(dev, pin_selector,
+						     priv->io_pins[i].io_type);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -475,6 +549,7 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv;
 	struct clk_bulk clks;
+	struct ofnode_phandle_args args;
 	size_t size;
 	int ret;
 
@@ -492,6 +567,19 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 		dev_err(dev, "Fail to allocate memory\n");
 		return -ENOMEM;
 	}
+	ret = dev_read_phandle_with_args(dev, "spacemit,apbc",
+					 NULL, 0, 0, &args);
+	if (ret) {
+		dev_warn(dev, "no APBC phandle found, disable IO power domain switching\n");
+		priv->regmap = NULL;
+	} else {
+		ret = regmap_init_mem(args.node, &priv->regmap);
+		if (ret) {
+			dev_warn(dev, "failed to get APBC regmap,"
+				 " disable IO power domain switching\n");
+			priv->regmap = NULL;
+		}
+	}
 
 	ret = clk_get_bulk(dev, &clks);
 	if (ret) {
@@ -519,6 +607,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

