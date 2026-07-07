Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BE7C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57315849F0;
	Tue,  7 Jul 2026 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="QNLZuUNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D997584A3E; Tue,  7 Jul 2026 17:22:22 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DDD84994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3817f800c8bso3230851a91.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437738; x=1784042538;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AZBEebU/y5DKJN+5b+EqTSOLyAELftxAHJY7IyswGKI=;
 b=QNLZuUNTVqnhTIszrMwxYiTsRgYG5js+Hd3SNlfV5N1aslY0fQTq5YYBnwNn1bZ4KR
 ycCexRa1x1jBtINKrE9UJOCFeJK874lpTqZh2wlzLZgZMVMW+T4XU/PSB5Jr7zOb7ybV
 fBWzHx1ZqkkC5NE8FP2fKXniOw9f8YRwKq0wCxVaWQQnRSP05eHV/b+pk55XD+Lb5xFb
 yDAw59LxNHBQ9DR35pky6kqNBt1jDf7g53/pnw5oNyXPY6KGA2Nc2W9rVzBmV20KRhyg
 EQwtckGU2pY3av1/AZri331/yZrl5a90DZYNUqutdOTSD9YOekqw4uAaefRkxjJ4ek46
 2BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437738; x=1784042538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AZBEebU/y5DKJN+5b+EqTSOLyAELftxAHJY7IyswGKI=;
 b=QUVkLGuzv+ksTtcTzcZkNL+RKgru0JrHDOZSrDcKJ2MAC5GvZDpNjn6uIAmNcfe1VN
 htb6MZmfd5L0CH7nfNI5rbq9pJxfy4QKiDp4lnymWSUD8eHt7EGIu59aFY95BjV+1GK8
 YA7aCz/dtNd0ikuZAyR32V7B5nalA8/3ieErzsWjtCcNNIISja4NU4WYUONDtetv12ZT
 tSezFuo6kyiqr1lLro3P2I440ikU9L9jckg/OJpYFeQf/Oy9D46LrHX8Sekp3koXNoX6
 ISGOPBpcv91RhwUd67h4OSFvBBc9XHLHRryDVoUgWHc2dqY55xPGoE7fgZHoYVsYtFgm
 ioyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfDvJ+vFEaOhSPBj/Igw8FMWi3xzgXba3q/qs4jDgdczrf2qkj4CBdGXC4bUuzKZ/yEt9CPBs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo4L8knOJG3DzbbLUKtPp13hDGJTLBjMuLtNgBInnOBRfFdv4+
 LdiMd6gSzBjfwVXlJc7xd5VwHsJt6qcLLWuY4AGA6okjNZP2l4/YnL1wyN1LTsPNaw8=
X-Gm-Gg: AfdE7clySYIR+zUubDpz12unPQEftv8CoaAhub6Hxth2/H2d9V6siLg4KTUDgbJ756U
 GZyk9rgL/oZef6DvdknC6C0DViVtTPfPVbj0ICQhOlx9uR4JTXKqkmPMrcwpDsigi49nECyvGk1
 I8F77vLTcNVRjWYA3ECNZqAo8lRZqdIAWbd3YLf/XU/4GVg93+1PiRBaRC9av6RvBJSLuq/2cwi
 298tHcBAX9xfZ3NCPVD8y8AwxIXOBtEzw5wQNRChuwYfweJSAeKBgA08MAquKsRn5TrYlM4so5d
 rnFOoXI/9YgXtC5ljVYgCuFNGcVZ2UrJoO6IJPk2i5FN8jJVjU2QDaX+WrgJQAY6IgZ7Dta6BNG
 FRm+WrkGr3z3ZuUtRsmZJrmzJGNxtojxhSUY9tn9Fc0ZR5t39rUGUCLvdvhLmpyRm8+AELP0BrW
 HhvrHH8fFIPjPVI7Nrb1JEVyV0eqHYsr3tGdnj0MZRAeOW5devu07oPrxJIE8bTejURxdr9Skqh
 ZjqSR1Ob438xDMZi7/HTeN65YjlBfhGaP8QN4T9wi5T9QqljfKNOQ==
X-Received: by 2002:a17:90b:270d:b0:37e:b6a:6cdf with SMTP id
 98e67ed59e1d1-387573b2d12mr5811720a91.20.1783437738266; 
 Tue, 07 Jul 2026 08:22:18 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:17 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:43 +0800
Subject: [PATCH v4 02/10] pinctrl: k1: add IO power domain configuration
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-2-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Dual-voltage GPIO banks default to 3.3V, but when externally supplied
with 1.8V the internal logic must be explicitly reconfigured to match.

Add the ability to program IO power domain control registers through the
APBC block. These registers require unlocking the AIB Secure Access
Register (ASAR) before every read/write, since configuring a 1.8V domain
while 3.3V is externally supplied can cause back-powering and pin damage.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v3:
- Add SYSCON dependency in Kconfig.
- Fix not sorted issue in the driver.
---
 drivers/pinctrl/spacemit/Kconfig      |  2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c | 83 ++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
index 6aab89e160c..ff754f5839c 100644
--- a/drivers/pinctrl/spacemit/Kconfig
+++ b/drivers/pinctrl/spacemit/Kconfig
@@ -1,6 +1,6 @@
 config PINCTRL_SPACEMIT_K1
 	bool "Spacemit K1 SoC pinctrl driver"
-	depends on PINCTRL_GENERIC && DM
+	depends on PINCTRL_GENERIC && DM && SYSCON
 	help
 	  Supports pin multiplexing control on Spacemit K1 SoCs.
 
diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 3ebc397213b..95344f4ec72 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -12,6 +12,8 @@
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <regmap.h>
+#include <syscon.h>
 
 /*
  * +---------+----------+-----------+--------+--------+----------+--------+
@@ -34,8 +36,23 @@
 #define PAD_PULLUP		BIT(14)
 #define PAD_PULL_EN		BIT(15)
 
-#define PIN_POWER_STATE_1V8		1800
-#define PIN_POWER_STATE_3V3		3300
+#define IO_PWR_DOMAIN_OFFSET	0x800
+
+#define IO_PWR_DOMAIN_GPIO2_Kx  0x0c
+#define IO_PWR_DOMAIN_GPIO3_K1  0x10
+#define IO_PWR_DOMAIN_MMC_Kx    0x1c
+#define IO_PWR_DOMAIN_QSPI_K1   0x20
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
@@ -60,12 +77,14 @@ struct spacemit_pinctrl_data {
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
@@ -196,6 +215,28 @@ static int k1_get_io_type(struct udevice *dev, unsigned int selector)
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
@@ -400,6 +441,35 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
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
@@ -456,6 +526,9 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			dev_err(dev, "Invalid power source (%d)\n", argument);
 			return -EINVAL;
 		}
+		if (found)
+			spacemit_set_io_power_domain(dev, pin_selector,
+						     priv->io_pins[i].io_type);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -485,6 +558,11 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 		dev_err(dev, "Fail to allocate memory\n");
 		return -ENOMEM;
 	}
+	priv->regmap = syscon_regmap_lookup_by_phandle(dev, "spacemit,apbc");
+	if (IS_ERR(priv->regmap)) {
+		dev_warn(dev, "no syscon found, disable IO power domain switching\n");
+		priv->regmap = NULL;
+	}
 
 	ret = clk_get_bulk(dev, &clks);
 	if (ret) {
@@ -512,6 +590,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

