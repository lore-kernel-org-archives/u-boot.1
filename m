Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD1C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 617CD60664;
	Mon, 27 Jul 2026 06:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nALWN72zx6Zh; Mon, 27 Jul 2026 06:59:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DE9460602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135585;
	bh=tF0oi2spaQ0vZtP+IL/qGA06OoMkdlzyVXeeHH96XYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/ehOS3RL3KfGNilb5UyekK3Awt9NRUw/Obmv0FYmo+MfvV850FHZ6ap90PYVYI0G
	 wWkXGysRw6KR+sSyShxc8hEVUMkC7uAXU5/YmczdqLZyHhta15sPJvkxju8A61edyI
	 qd33+8vg1ACPOxWbShymU4NxxD0LBva8pcmqrztYBCMYHf0Wz61KwMJPoAqN+hXvnL
	 nVxj1JhWWBML+rgmmIpyyFvGbVY1FWiqaYtkYzn5Y2dS2GnMJosTadoPxLgK1z4ddk
	 corZcHg9yuEpTRY2RHHaXiZMT9bRWqnx/pmAEU70zni3rpNZ9mQeBLcdh9E67tUIZ5
	 JWAfwxz/LH76g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DE9460602;
	Mon, 27 Jul 2026 06:59:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAAA44C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A15654062F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFU3vNSVbxLr for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:59:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E2BED4060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2BED4060E
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2BED4060E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:42 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c981c2c37cbso1749868a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135582; x=1785740382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tF0oi2spaQ0vZtP+IL/qGA06OoMkdlzyVXeeHH96XYI=;
 b=UFqxb89mo/YEqqf6G5pUp71Gf/Ylh8lU1K7pmE+va9Y3hra/qVBW/iFpZ9DRW4rJJw
 i70XQ+xoTM4XoWIEvvL0Qnoh+RCX5ed4GDzNQJCD+LG9gBxUCeyuxz+OV3BCHiFf9teH
 I77OHJRcNaDhXssnDQAMGivteZufduACVjygFJRrXFn5+MMPSwF451vXSdwYl5fM76dv
 ++IvdYJF/hyw+uFplKmg58z+Je/0kg/u50r6JRExD5J3AuGwBxSiMvqqjRk9DRlEZ+tu
 nXZEuqvS0JFIQG1IkOJv5QSuoZQrZvk/JYCcqRAxnIsxmLx/grbXzbL4wH0+3OV6w05E
 2yPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr65fiszUa69pB/SBfwqXDZYIdCjrMZvAj5WPQbHDaDIz8HOM2vgCvLoh9835Lj9mIiDswe3yE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx48urPEgi8C9gHYOis1w7tq/BQPvDJzSDUCG9PmjGcF7vJwW5W
 W0Ix4Na0czv3JbAJpWy+O55ej8USlenBWLWli4Q2akfuCHqdc5Khm8FZw4SW3/KUfMA=
X-Gm-Gg: AR+sD11ntCkswatmVCzfd5dDdzvxqlhQqJBAIlX82n53u8FNe9OGsxh97W1JPL9b0Xk
 sQkgaWFTrtl6DU7kX0L7wQUb74Ze9zMUGFYTfGndOzlyCEMROhcPILSYGTSNIdnC7dG3uap+GKC
 I7ZXrdACTn5K6n5utRud5hv/cEynAB1GzVYp9RneOVpvqkua/VYmehevELMkaHG0XseKZUXTzWx
 qsTywl9eKQJbjlhvfN1hD/OfnGlgqP5DeM27MEQ9vqYEYBX6DWUwfYJ+He8OSkkrtUx7kMZrupa
 VFv3SM6ReL+SS9Im3zXuRPqPaMYDMNJD2WtCzJygCL6G5c3K1kyhIzIRx0wU8Itxnnucu8ZvX8j
 9Esy8uWSlzHxb8FReV5WsCN+SjwSrUnHbra+JQCXGZ9tUOmtqaphEiTvNCwf8x3CLYpT5Hff0Q5
 pMLuCgHnThakuXf1qDAjRlaNHLlW2cYBSkSkNuFOvtvNTbQSvBtG/JLsgQx5d+IL7wl/t9D16J7
 IwzMQ1L6uZfTOsIfIEIfheyaBB8tyAaqrOb+ppqi0M=
X-Received: by 2002:a05:6a20:db97:b0:3c3:7891:6523 with SMTP id
 adf61e73a8af0-3c67daecd14mr7220795637.34.1785135582159; 
 Sun, 26 Jul 2026 23:59:42 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:59:41 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:06 +0800
Subject: [PATCH v6 04/11] pinctrl: k1: add IO power domain configuration
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-4-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135582; x=1785740382;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tF0oi2spaQ0vZtP+IL/qGA06OoMkdlzyVXeeHH96XYI=;
 b=eK+b6MnYLALajTLCTBr+hIE79Thj7FhdHGA3Jm611UpJNCg/sEjLExEG9ePgF3Scqu
 hFwdEvHoB+L5R0SOJ48KGav5vVxDu4RoqptZ9WARj9Zf1WnFyBTl3BMuoDHFmWwKThcR
 tiLwWPGt4ywbbVhrx3P00dNkMBTnB0pktfMjaiFukajDppZn09pBGPWOvYSvoELcfRb8
 XHiVhgNQomrfZAwuZPBqazW77BUa7l+FFeYdRjN4vt1rEvYOc/MHadq0LHRajplN6aaU
 lCwsiwV3G2PvI+CPshR29ZHOaaPJXq+HzNvwCdkPYwW6wZPpJAXO0RkwHR/lX64d5Cmf
 BNJQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=eK+b6MnY
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
v6:
- Use dev_read_phandle_with_args() to fetch "spacemit,apbc" instead.
v5:
- Use tabs for macro definition alignment.
- Fix the missing power source argument.
v3:
- Add SYSCON dependency in Kconfig.
- Fix not sorted issue in the driver.
---
 drivers/pinctrl/spacemit/Kconfig      |  2 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c | 96 +++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 4 deletions(-)

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
index 454bc307ba3..c5e71e902b4 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -13,6 +13,8 @@
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <regmap.h>
+#include <syscon.h>
 
 /*
  * +---------+----------+-----------+--------+--------+----------+--------+
@@ -35,8 +37,23 @@
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
@@ -61,12 +78,14 @@ struct spacemit_pinctrl_data {
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
@@ -197,6 +216,28 @@ static int k1_get_io_type(struct udevice *dev, unsigned int selector)
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
@@ -403,6 +444,35 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
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
@@ -418,6 +488,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
 		return -EINVAL;
+
 	addr = data->pin_to_reg(dev, pin_selector);
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -466,10 +537,14 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
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
@@ -482,6 +557,7 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv;
 	struct clk_bulk clks;
+	struct ofnode_phandle_args args;
 	size_t size;
 	int ret;
 
@@ -499,6 +575,19 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
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
@@ -526,6 +615,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

