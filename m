Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5FDC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79CCD408B0;
	Wed, 22 Jul 2026 15:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gvVZV65x8Oko; Wed, 22 Jul 2026 15:07:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D78F40904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732858;
	bh=wSlVLJVQ+Ovh6Fv+iyNZZ1npz3ZWI8kItZNobcoa8UY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Rop9PSjKcG4a8/CoIhDGRRzQWp3LYu0JxUqFW+QX82ipXKmDAI8nMKiAv/zbvsK03
	 wktlr4i9xhNFT1vvMYUaPRBpzMsQ94ksYIaIVqM++1lYNm3KJVFNKw9ynsL7InVNVz
	 BiLBJt8RxJHpBDIIP5hgDWRUROB2iSwHgj0MD5q6hN409foUzmwzsgsW/FIM8xRRLM
	 KkpYfcRvyitGgtlTvQmUhfy/Giwr46+g8VJvdFKivfHScFQz2dz312TwTZtExUcVGQ
	 eu+SxHU3JnubSQXfrjmJiK3yrWzvTYM+Y0ME8HEiIeZKpvXHFT45KzU7pFxP0jqGj2
	 83UUw9DuUYBvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D78F40904;
	Wed, 22 Jul 2026 15:07:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 069B9788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECE0A400BD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3lluYR5lk17x for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:07:36 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A47B5400B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A47B5400B8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A47B5400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A7A8494B; Wed, 22 Jul 2026 17:07:34 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA44F848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:07:31 +0200 (CEST)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so9177738a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732850; x=1785337650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wSlVLJVQ+Ovh6Fv+iyNZZ1npz3ZWI8kItZNobcoa8UY=;
 b=o9f5rZU0O1Brk8txNjDjR8R4YhAlxwkG+iYfEz8wgya/MEQgl3pTQbybBUPFukk50M
 AvUczDxY+aBvwukrlyoUi9nyptb2oaH9ZJee2Ts42jyh2+xrlV8GebO2Ver6/kR0v0qX
 u1ibosvFL66FL2xadXG+RPcS9vCg6la0vU7YbRm8+wN/2vN0uBeOj7w9QqWLyqfIHemr
 81r+Re/j4HCBPhMiPDsrEWoX0n6gA0sDXuUDFi2LgQU7ndC04u+6+iCAS0pliN6oJ7H2
 vMvWGzHmq5O1J59NSx3yDSReMuISy7ZpqvoYb7oMs49DBLhBV74gQDDhWZuXG5WMGchI
 3Ibg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro16CEl5vCgEYmSCpPTuhYh3M93clYQtmYv558JRCSwukow1riRg/YGUO+mvPv42ZB+phlbxAQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx98dh1YSgGI44edUxQ4bj5PnBA9kBl1MqHyKS94iss1j9CKhuq
 Nw2G0LyMF9TKuBF/TmctqMw3yrRivt4GQKHsWDvVqhEc9I7EKtAO6lVO1o/+9Yv2nQk=
X-Gm-Gg: AR+sD11g/jG5xTrfWSAgXtVJoLhNhP7xh4grOPHThLgXQyxTatJAUDyiN0Xyee4nG44
 YeCGnmS7kUusuQdw8vMmIS/AR2Ke28/OvGdn5/Tjmmj8cK0PBrImK488ChcHINa8AqAxXg9uYmP
 tu4Da/DnKaTz4de2KrfPDs7qrblC2lZozgUZNLDoxFcGA3eB5CHyodinLpdM9LoJQ8UBc6Nu7d0
 ktoZiVE5JXegYZCkeVhRvxIEZPweOFJfDeT3/UoCQXaCc/YOCCPR/7P2gxuMI4/7RbbfU9bAVTb
 bhicmjs5crv0WpvRHW8M9Bg7nsP0hXJjU83xbgdt9j1Dm6zPJsXwXbiPR3/HQ2DplDTobt2utHQ
 ok9xiXOPMND4wNaMHoRoW6vpz1YrZhI3049Lp/62iEv/lFOADU7EdPpXAAX2Van7a9+LXubihpq
 QizdXcTyiNW4m9Re1u2AjSp2rYFiiRsSmy8L6ladRc/R3cyURyEPWZEZsdbLoAPWb1pKQHhR4F9
 Coi6Hb3wawOi6wQkaDui2lMiazcWRLHkHDeUnKEcoo=
X-Received: by 2002:a05:6a20:6a0a:b0:3b4:7d99:a23f with SMTP id
 adf61e73a8af0-3c3ad8b3abbmr28353733637.45.1784732849893; 
 Wed, 22 Jul 2026 08:07:29 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:07:29 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:06:58 +0800
Subject: [PATCH v5 2/9] pinctrl: k1: add IO power domain configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-m4-v5-2-c41a951e5157@riscstar.com>
References: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
In-Reply-To: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
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
 Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732850; x=1785337650;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wSlVLJVQ+Ovh6Fv+iyNZZ1npz3ZWI8kItZNobcoa8UY=;
 b=lW4Uy8Qxk7E86hhR8dSyb5mWy1pmb6OUtjijqmTX+wHbahnFwTND9QG1dQOIiynveB
 IcRoBIRfYi4FamEAihIewp71rNDfP8OZPAvct35Vf+MGp/HxCzs2gQFw5YVEIuglMYJX
 3si6+7W7QaIQZRulRCt307BFyRlwpwbYUFLxwJ3cqQNx3zkIXV3cGSi/OACMyRQgVRK0
 mw74B4x2FWia15YR3h/SJlYmIJYeYCYQPWC07JFzk764tm29PG9Rwanna5JNEFJSaETh
 DKxZVCrZ7sv1FZ7L0VhYaKd8hA8NiLSCod0L2u1B0NIs98BijTDCZiQwEBYA7irzImph
 g4mg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=lW4Uy8Qx
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="lW4Uy8Qx"; 
 dkim-atps=neutral
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
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
v5:
- Use tabs for macro definition alignment.
- Fix the missing power source argument.
v3:
- Add SYSCON dependency in Kconfig.
- Fix not sorted issue in the driver.
---
 drivers/pinctrl/spacemit/Kconfig      |  2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c | 86 +++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 4 deletions(-)

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
index 3ebc397213b..c8455ff84a7 100644
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
@@ -452,10 +522,14 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
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
@@ -485,6 +559,11 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
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
@@ -512,6 +591,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

