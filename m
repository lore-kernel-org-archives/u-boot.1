Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE29C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A06B660770;
	Wed, 29 Jul 2026 14:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azKe9IqKJ6vG; Wed, 29 Jul 2026 14:49:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31296607BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336549;
	bh=b6SaWqbYVxfpYjCfcF45aTJH9aywMirvR4AC6g4E6fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zQ+kKm9Kfxk1ngm/k+zww9BCkXyiojZqjJOnVDQNHYyHZ0rrVy6fxVyCjAPAgOqmy
	 DUN9BJfm4vk6SZ9twq2LrIM8QZpsaBboYVCJsa/9x4013p3Z1mth1NVNDQLAb1uW2y
	 5Za9Tyyxpz3J09rKSpj7lqedsyUc1WcrN9fLVAPbFNUbaONaklTiTJAdCQy+GTTJkQ
	 xXpx7YFm4playvEplonlJ88U4FKK8zmiRhO0+SEC60xDbGy4/2JGy7B03wl0qS+kGP
	 VHbyNCZgC7y2zTyKw11ou4F1g4yP1C6WnxkLo09lMbyGMdLQw11tXJAGON1zVdGnSv
	 +WbSdVlO76NYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31296607BE;
	Wed, 29 Jul 2026 14:49:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBF973B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9A4D4081D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKZ1NvQE4x1C for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2E086406E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E086406E2
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E086406E2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:06 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so1234713b3a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336546; x=1785941346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b6SaWqbYVxfpYjCfcF45aTJH9aywMirvR4AC6g4E6fA=;
 b=Lq6jCERMgfHhz02pyQp2pJAe/UpGasgR3kwhLauheTePOx4VDith7KGuSVMIW0dgJq
 gp3XxdxMiuYGgfTQdf8Oqnkhuk+ufMF7UueF88LaK/MwVmaiW08wJa/PI+MpGLhPxhAx
 AG3UkVNz7hjncAuOxwGKUkxPfVzGWyDG6gB4j5bBoIi3h8Ln2p8WYygaty6qtTNj9NV2
 8xkxLd/VeBXWceLQgv15bZx83NJ1q7s0sJhqQdzKHRWbV1Uc5MigFuT3TbkhgomZMQ5Z
 dUdwaJBHiguYViBiA5VANNO/MdmP+wjdtlKTtZeRBA881fYVfC4wSNeBAjibTP3W69Gm
 VZug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7WUm0vCdgBo17novCfTeAf8URTB5MITtVGlMkjBFsge89nvoJQ4hf9P8GpU6zI7h98bz4j5U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzZ95btNBKOo13l/9iZjZEMrEPOEKWzt3eBohrLpd7KwTgtA5CV
 w0XNTyk+O70rrnTnSxMg5tc1Vlw+Tan8a8o/7X/yqzZo5QUdWNRN2c0erv3Uimm1y1c=
X-Gm-Gg: AR+sD13bTk9RUMuUaBg7eqTVJRt1Wu6ur219nL+MXzjtK818gV55eEV4RWFd3lNXvlx
 e5KJTlHcxyBNozdo3DYuz3CD6wXl53iFKbL7oEt18fROgTRh9y+HbNZDeUM5VOemLPf1ZP4eVmg
 5Ae8A/4ddQK3PvudwcZShyWr0/fQboWlgyo750pU4m59yhufqVxhtInSsaLI+pgMj3+q78nTo31
 XpaGv5dJdHJNkyKmR5E1wc90RMDKCOyyaBdUwqtSkTgnpZob6zTATXagAIQ48irKzPQCsI/cs9z
 UCIzRK21vLWvyONNxwC235Q2USNiCchnLxdVyfF1ae+CFCcd50tLeTBGLeDyvBIhONnUduHciFP
 Lq2wOPZQJoc5BiBrPScCjr2YdzsEkj6V5xA6yRa3sQ7iiaun8MKmveXka0HXkUalKKsPWTpQMvf
 l8yfsneNqGqo5O2+gLFhDabZ2XN5z1BdEtqQZohYMFWYQm81ASVYmcUEmfuwnIrVBSKBTBrCC5w
 rZITKTpchwbShHbyN75C411ffiBeNGja48njtHQ7NkGp0rXfg1Fhez+NNoiy7JlDnG0OWw371kv
 /dIG3UzpBHI83ueyVkMM27h3xg==
X-Received: by 2002:a05:6a20:cd96:b0:3c0:9c1b:d0b7 with SMTP id
 adf61e73a8af0-3c8ba66957amr8479787637.66.1785336546456; 
 Wed, 29 Jul 2026 07:49:06 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:05 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:22 +0800
Subject: [PATCH v7 04/11] pinctrl: k1: add IO power domain configuration
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-4-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336546; x=1785941346;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6SaWqbYVxfpYjCfcF45aTJH9aywMirvR4AC6g4E6fA=;
 b=LDjAudoDLC/czex9ae6kEnmR2i/ROJHydy/7jaocrArOxHo6/YlYRktmN8xfzcaT5i
 WQ/eVCojwBnDuWulV16WQvR+ASVQgEqV3gzk2/X+ViqSyB3SLUNqLTDyGmtj1Q6mCaUb
 v5EMzRM3yvZqIESIySskqswP0H15HOzb2EEyMGD4jhQLPJ8gDTkV39ykkMAclbNtTQuM
 8I2QZSkcYjPgrtiy6GUVCOQsKxke5vJfEa4qJEOeKbE53KH/34tl0sEoCCctOpWwX2EX
 tm1ha7uNe03xYCB1Jjrjehzq+XEOhIbFzL314ujQ7+ziZeS8/HVm+uX+sSJE691xxVlP
 UQ6A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LDjAudoD
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

