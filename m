Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459F6C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CACD4406C4;
	Wed, 19 Aug 2026 03:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwzOtFD60quc; Wed, 19 Aug 2026 03:55:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111755;
	bh=EC3ioCr3Yv0tsDHITlP0Y23ChL9+XcoaBfllPajdQNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bB/wgPux+RVDJxKjCivNNM4zTeVpi5U7kaIhirxd51FGRBLjaZILwbAVuzzaO6iuq
	 4Bk0GnlGW2h61KpitiDMwAVYOIkxERZtUHTwROqvDV2iGcPbkilolcl6g3vMYa9Eid
	 BxGofxT8tVExBe1hHhWwNWVemuI2d41G0ZOm2UJO7WqtnogJAZcf9U+/phznpyFD17
	 5iuD7xa9u5UObZyO6oSoMYDHq6oXj6lBrcwsKK+bUgIr//seeJsi8lH5jVMOeSUpuL
	 1Zzet4hdfL1mcbgiEyvL4cRS/0g4s8fdkChAQq65vfDuLIPfVRRgwG4VFIuS75lsQW
	 hDXR7Ss/6n2cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65B2A4065D;
	Wed, 19 Aug 2026 03:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65B851460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B5FE4065D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1jfovy5Yb7Ft for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:55:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=xzBNZncy
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85ADB40654
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:53 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cf52d15d88so4261395ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111752; x=1787716552;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EC3ioCr3Yv0tsDHITlP0Y23ChL9+XcoaBfllPajdQNA=;
 b=xzBNZncyXgH4zovn4hqErL92raXiU607MUDARI0hL3F2d8GlMXd3/IVzk+32PYb5Cj
 ZkNlWd4pl3dD8JlLCF6dmMhsoikSBELGnpJIMSNgJcaby2Fg7o/2cOPVEoG16vKNHGss
 8Mct6MmiU3BaT1FBOM2h/PzB9rguzH21xrHagclH2mXin70MnRWIhCWwn3re7+W3gceq
 Q/J9oJMQ6GMOkyuL9mOZs52Oewu1TM2RRmYd8aF5yqVdH5ACAUWhRCCZgTI8qXmjGIZE
 BfM4a9AGZ8bva5Wxzi7/rDICyvoLUjEb7Dk/rDIyJUVMLQn6wGcZSvKKJNkmTWmVR+NK
 LGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111752; x=1787716552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EC3ioCr3Yv0tsDHITlP0Y23ChL9+XcoaBfllPajdQNA=;
 b=HH8B7ApmMmnYb6flc750HmcXC5Be+E3ahScowi/ChR9xU0j88NmO4NhXkZWlO5HGIg
 fnZbpNIzIpw961gwDKdmKhRp8d+CPbv/lnsdbsfpOEjIbyC2nVMK2fdyHjvL5FiMbJuZ
 YcB4O6d2Mm7NsOEQV9NiUKXteT0pXgshklyl0vC7vW+aWNyvAb7U84WV1M5ahtoq6dkL
 JZVNLMee2sQvGrkVS454a6gqzOyWeCKaQVVX8bIA8a/k8X7qNFywjJdpnwNYhceni5Zu
 eMFIb5bBdi1gedfa7AxKOR0jP9A8edS6nWVzBLZvVWk13/BZi0+IJ5NIMazwOe4JQxoe
 lLFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSWIJcrdpDKSWKTip34fIGz3ZgnpC651WVLX4kjESjqglOTvF/NipnSA276PAca44T9m4HOe8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzI8UveafyVHT24fBNNh6CBLKv3u9cD8wrhbjjrzhRgFQEPJORJ
 T5AVgoSeo6QT389MDYXlz9hYWXJSJ02x4Aq+wmO6415Qt6igGNHG0elVwmdpsq/oQoA=
X-Gm-Gg: AR+sD114vj5+wWBlu+0FyFj5dd2GKRkrnMP3oz+p7pvVc2Of7IvkHT6XuG0NtpprGyq
 F9LJcLwKf/qPXus8vd4y1fBTJV2jJm8ewovGlR1pvg3sdE4u8vp5VJDVX/+650DNpufbLcsi2tg
 eVTMNGtvFjR53Goq+JtCWnqtqoNaluH/SuvJFMi+fVlnIV1rTmfOFxKKorBwjsLOtguTtTr2DKp
 1H/ite0rqlpZbea7hMnOU0h07x0C3xB/j8Tp6R60EcH5orYP5QAuVLBSr6FDQcWASFQ5NkXq1Pc
 RpClG3pIYzLNvq9TX2pyYOv0Wx6i/ueORyJBhAt9k/gU/tWP9B2APFA23rLY9Br4FcWqIn6NpSL
 fvFe0SERboBaBkhHybeFyvIP5dE4tNh3PeatVj0+Be5Ep116zm0BkmUSd8ZYeOyPbYjW0kXOyTf
 CErW+BakCh+h9W53y6LIWxdaWt6WEvDM4PneZ7gEVV9+hAKl5AZv4imvrGvyvaN9s/5MdKyAxPp
 fp3St6ZomxnR7J8r42ji9+49FrpsjRUFgkMoKTgFd67wcxOz+LIQtl3gjymSB+kr7R8LzHxfl1j
 KXIp9fBUR5TBH9vghCfJexAYBPMtz0hP9f/v
X-Received: by 2002:a17:90b:3804:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-395813f549amr2816077a91.12.1787111752347; 
 Tue, 18 Aug 2026 20:55:52 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:55:51 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:45 +0800
Subject: [PATCH v9 03/19] pinctrl: k1: add IO power domain configuration
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-3-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
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
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
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

Dual-voltage GPIO banks default to 3.3V, but when externally supplied
with 1.8V the internal logic must be explicitly reconfigured to match.

Add the ability to program IO power domain control registers through the
APBC block. These registers require unlocking the AIB Secure Access
Register (ASAR) before every read/write, since configuring a 1.8V domain
while 3.3V is externally supplied can cause back-powering and pin damage.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Yixun Lan <dlan@kernel.org>

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
index 9ca4ef7c771e..6cb71b44b3a6 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -12,6 +12,7 @@
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <regmap.h>
 
 /*
  * +---------+----------+-----------+--------+--------+----------+--------+
@@ -34,8 +35,23 @@
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
@@ -60,12 +76,14 @@ struct spacemit_pinctrl_data {
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
@@ -196,6 +214,28 @@ static int k1_get_io_type(struct udevice *dev, unsigned int selector)
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
@@ -400,6 +440,35 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
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
@@ -414,6 +483,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
 		return -EINVAL;
+
 	addr = data->pin_to_reg(dev, pin_selector);
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -455,10 +525,14 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
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
@@ -471,6 +545,7 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv;
 	struct clk_bulk clks;
+	struct ofnode_phandle_args args;
 	size_t size;
 	int ret;
 
@@ -488,6 +563,19 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
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
@@ -515,6 +603,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

