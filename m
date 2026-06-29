Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77359C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEAB84A30;
	Mon, 29 Jun 2026 17:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="US+lYHOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39BC884942; Mon, 29 Jun 2026 17:51:57 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A2384A30
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso7353884c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748313; x=1783353113;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z6ieNH3nfWXGSwe5tVaHJIeGa72rJw/IQq5dCT0NKMI=;
 b=US+lYHOuL8nMaq7AfQo4F5u+pETW7s6QBT9pf4Lw5K8nDyq3GwE4SxxmjEZSeGDmWl
 ORtY+WixXdRdOmdBTFKAOCrhOz6diLkqhidEKZslK9Ctf2zJ4Fq6fesYHSzF5d5VnAbS
 nc7EhKpVq/x8zvR3FeuIxOlWGejgouHxSwm9El4F7vQaCW5ajZqRKTe0JG8UlIfZw2Vz
 SrO+Vj+N93GYVZ7+c76Ojbk7heopssXtpD54Z+EPo13tQNEZlm6KT78CzYDw2GhCP/kj
 /S8pkA30huMWu+zxxY4mUWNol4MJmx4bohxFnw/4cjfXHQUlAo7V9vN4FHrw9TGHHdE6
 btGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748313; x=1783353113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z6ieNH3nfWXGSwe5tVaHJIeGa72rJw/IQq5dCT0NKMI=;
 b=CLSWGQD6js8OufxkzgjD4HXn2cykiBSXOhbnEMYtcHpJT7JVzmVs8mZKa7xBAct27Q
 fM2ulQqzIJPBMAyH1OH/VVfQcwMp5IiV5QvW5k9+mBsAp/jUJRirs+/MdCSDEp5JEt9r
 aXG53zVmxyyz/UVk01wlfF0OyH6mym1NSgAfRyYEDTkwJlXUYDjbs4YIy61+o7+iEWLw
 8mk84BSOqrMANbq0kZ1WgZsC6uLuJNlc6fzrrFwLLn9z0n4jHr61RSuVnCuHY42HsHRI
 01vO+4IwGGx6r92z7lC6rRLLPQh3KfgCoUMlZrzox6Km7ap0aa/k+565gD/LF7VLX8aN
 yVCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iC1ou3mfF7kZ8xjjKCA5/wV2lEtIzfVda+qcPWqT+x+QhRZj00bEaT3nMcfWAtLZhTIwN5wk=@lists.denx.de
X-Gm-Message-State: AOJu0YwOn+WdpGBWkf2i9NtySS4oknFwymz/a7bXgzgyq8wKnjOT5haC
 2RYCasPB5m0whbIjWptRKtv9v1RRoVVvvv3JaTcSsR0PsJ9JWndlECVX1zkqaJjHlcY=
X-Gm-Gg: AfdE7cnRVtJVoDAkR60T+B3ZelVvyeFFaxhS+uNDhkCHpAWfFlNFmCvtUbDyWjbw8uA
 0/EqjnOj/gzhrPETQ8KLEg7z57yrGUvfZt29a1px1yTf2UQ8vhWtPJ98MmTBeysDjnQYP8JvHoI
 UqrayLy5EhaY5rHLsVU6H/xo3Nelk6KUuZpog3a72FlewvYyAUYyW189PYIhC2M5bH0/1h3G5Xg
 PXVPcDhMZWz2yKCl8KgQu+K8thUUXic+/mHLGr/5rm098whm98Z9k7lL+vdiR9j7i91ZlabRG8j
 oN26drACxPIcLCndQ+atLIhW+l5C7oO4TNGmDsswMOsrDO56ofCh3DEd0LYSh8SeLzJiEQ0bPUH
 raN0fSukn37+tUBbCg5PFjmzIZXCRcrsOgUXOfV6TrKCpO+3Xy4vgVayIPVs/UPZiisnGsKC0PN
 BU19Bc02EuGk5LdeXbjoB4jvdQ4XmT+K57qweJUs8gX9jLTvqfmykJgquAD7RO6IlRZTKzObTq1
 AXaOpkXkaziQh5/wUEtxqur2jjZTohwDSs1By8bKnE03M60ECfRig==
X-Received: by 2002:a05:7022:60a1:b0:13a:225:e191 with SMTP id
 a92af1059eb24-13b2271d3a7mr746404c88.41.1782748312848; 
 Mon, 29 Jun 2026 08:51:52 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:51:52 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:15 +0800
Subject: [PATCH v2 v2 1/8] pinctrl: k1: add IO power domain configuration
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-1-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
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
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
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
 drivers/pinctrl/spacemit/pinctrl-k1.c | 84 ++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 3ebc397213b..5d3236aac94 100644
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
@@ -34,8 +36,24 @@
 #define PAD_PULLUP		BIT(14)
 #define PAD_PULL_EN		BIT(15)
 
-#define PIN_POWER_STATE_1V8		1800
-#define PIN_POWER_STATE_3V3		3300
+#define IO_PWR_DOMAIN_OFFSET	0x800
+
+#define IO_PWR_DOMAIN_GPIO2_Kx  0x0c
+#define IO_PWR_DOMAIN_MMC_Kx    0x1c
+
+#define IO_PWR_DOMAIN_GPIO3_K1  0x10
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
@@ -60,12 +78,14 @@ struct spacemit_pinctrl_data {
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
@@ -196,6 +216,28 @@ static int k1_get_io_type(struct udevice *dev, unsigned int selector)
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
@@ -400,6 +442,35 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
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
@@ -456,6 +527,9 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
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

