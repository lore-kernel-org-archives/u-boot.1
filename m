Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C2C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADD2846FD;
	Sun,  5 Jul 2026 08:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="UhHrraQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B094D846FD; Sun,  5 Jul 2026 08:08:33 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F14A83314
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c966b9ee9cbso823395a12.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231709; x=1783836509;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AZBEebU/y5DKJN+5b+EqTSOLyAELftxAHJY7IyswGKI=;
 b=UhHrraQy99yWyRgl+eN7giWhwb8iLKABQua4t0M4WVSyTDQtUNyD9fOoKIyNGwbCY5
 F2Pl2ht5v2sdGeMzj0il6syP4uYKGf/LgSRHefhYtm1/dAvF20ePu6ee6eH1fxrjwaZG
 Q+sq7B+dwYagoS29yiNBzw6KXnBuydefdAfsq/Yic3FjIk5jbOXVc7V7uu+9JpUgvZIi
 0+tH1F8icDv9C2PXWNiY2gUZyFS9yjrATC70FAe/ywJAFOWLYBGrLIR44ktadrEXzAAQ
 pB+i+TvPdNO1i/p3UGaoQ5wwSeaiUmdFs/T9jtk6FRzc0W/3aUxu0caJ4TCq1VImPiZL
 FFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231709; x=1783836509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AZBEebU/y5DKJN+5b+EqTSOLyAELftxAHJY7IyswGKI=;
 b=AQdCy9zfbnMLLCT63A1/CtbnF3bWstlUSm2mRRRJcqQrIhiHEeCJgWj3Npyy6EG1Eh
 PQSxCphKNGYySSfHzm/5OpmF1wg2xfkfYghEALptKxPvFz8WekQarlncWPoxn1LMd6Wt
 vUP9Vszwmk7LL2yHezx/vbnfDcZIOKZueFE1WgIx0uVOQbvd4gHJ7MC+1rUO4R5l6uRZ
 tZRQ668qCQ/lFkjuuGr1WJLdgkwS7qHx1a9xjFGnRaghuMOED6aMzJhIBx8al59DSQqo
 xAfjmiUYHfn9AwB38CtlaxqzThmdsGzr44twWx7KvZbxsNzX/ObbyNDHFDhpNEIS6ngG
 CBrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zJAjHKmlJ1IRGWadoBNueTfaAaq3rzY3UWhCrdxB08FyGuLCXk+fDtmbxdcXIM5bYDo4kf2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw6ZoyffEmOH0sFfvIjGycQcOIJ92uXw0CuRI8JujHM2nOWf52
 ZngqHZWLCFtpRM6raSmLRh1PStaW0CGgwoTPMMgjmFQJ1GAnsNphQ9RXGOw4ZZpqumA=
X-Gm-Gg: AfdE7cnvS9FleU8KasSVfOvUl0gJYpaHe1bymgYnxLFhOw5bWWCP+slCaWVB7i5XhG2
 23aq2Vu+hBpvy18Vzud4oInM+Tm/NYvz3JtWfcu3S3cvYX4KUAVNwANeP0hrtY6TfhUqBB1SuYD
 b2O7/LMVHqcreWSF+EcB1la0THQEEfi16c5u8t+IdtU1/VzrUQIEz0WFqk8LNEDBhF1GIF1GtaY
 SgiUpiTHE60RIdrmbSZ9FhIJP86cNzLcuMiyL3NJZtBohaid8Sk8+ausdFuugMbTm/GrMJSyYjG
 tXieDjitZ7eczho2rA9sdZkKXvjHYIkT36qlnfcQLd0vbwZnxblox0GNL/ZksFmRP8LvVNXWfy8
 7dsANM0p9HsE/IeQh0jI9+4YsLMg72QImNsnNi1jty8v+x+2G5PXCSLMuFoJnV7yR/Ye2dYhqG6
 YfQrpHD65Rhhs742pieDtFXZ+esF26hcNmqiDvTSYlSc1Gi+4VzaQDDpENja3aRP/9anFdYlCJE
 QWMx3zcu3rwg4r5VDlSMRMN/ZrmD6/rQLWZ3pvzzGam9NSeVk/uOA==
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c04:a813 with SMTP id
 adf61e73a8af0-3c03e4cef93mr5811790637.52.1783231709601; 
 Sat, 04 Jul 2026 23:08:29 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:08:29 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:07:53 +0800
Subject: [PATCH v3 2/9] pinctrl: k1: add IO power domain configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-2-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
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

