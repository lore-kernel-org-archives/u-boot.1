Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7414C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E9C080E09;
	Mon, 24 Aug 2026 08:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQKC1uztaTKY; Mon, 24 Aug 2026 08:14:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787559267;
	bh=HJNC/BCyyEKRMdhfXYv0AExGqLku0FnlXQlIZFlhtms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NHIFjd5XSaFbPwpcj9p9b4VSwDWPXPqlQDiysEWZQMxeLcPvMk44BMs9eM8ld8un+
	 yd3JrFk3Z7urXQ9SjCJSMDFtoTRUj/KpjyDgSeesnyJfyd5zFyswAZN5TxDWPZXVEn
	 ZzVXlvRUWvEFEHs0qSLHsRkjgpqKHoXHdUxz/LmJZdeRPLi47Aw8a5NmfLpRjZmIba
	 L5pNlAH0g7I+8XouTOXrEKnitC9Pogz1LoFeTkMy6MmsfkpA+d7Mg7nWrl7U2TBZ/O
	 XCsY3qPCZrNqlN1IKqoH6K0+Sbm2rd/fk6sDmz8H4tDxLWvgI1aYUn3QgZ5xrmqNvT
	 2pF0LLNTOV/SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A686480DF3;
	Mon, 24 Aug 2026 08:14:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 826CD3DA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 745E84005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AnlR1pxBDYDO for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:14:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=DZjigq3u
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D51D400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:22 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso4411896a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787559262; x=1788164062;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HJNC/BCyyEKRMdhfXYv0AExGqLku0FnlXQlIZFlhtms=;
 b=DZjigq3udt2waDe7Baw57kW2e3RTOon81uZ8XpVhDb1NEpCXt4AFWsbFYHF2dNk1vX
 nZBVuIF2trHERiUGJ3IXVNzcZYebV6hEvZ5y5dbMZ9M78TJm7ugiaobFcFWqq+fBYjED
 RIL9Nl9/amLL2WkJsAWa8+d1GzRbZz+PQzAbYLgOhWZQg1TA1Zl5GvXs0+4TSkrYrdNm
 +xH10lP6oQsNzjq84AK2zJhF/RAs2Q0kBe8kIrEug6w1lo+mCCdFMQyHWTITdSvRHUOQ
 oCmjGPitaYJ4arzGGATKrGWbe6QL+XvXC7wNWo/x0HPIHNlxGV3+XalkGVJYkzFyEsN/
 TfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787559262; x=1788164062;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HJNC/BCyyEKRMdhfXYv0AExGqLku0FnlXQlIZFlhtms=;
 b=GpSbVb3f+WoQR/d4KfvMGwqSk4rY4vuORcgGxROUFMn6VNnPkzT/Yl9MASemTHq8mZ
 GWA+Ukm61WTCjiJdTQJKv6kSRqMqxj1afW4aT9ra9OrxJd/rfPdBQ/xE/pOJUK1blCFz
 a2b9S04P04yu54fphHkioJwl+qD2L7BvXfJukx8bsJG96CDuLSVH9R/2D+tj4XC5hcCB
 5NhrIAtViRKMgrS5WKnk42K5+8kcOmuWdBPadVsORF4EBzyB1StiYPSEeoNO3X46p0eI
 xyyvquoSge0ln4JVl1+M31545e/ZZ+2PRLqJi5q/dxrAjCtJkdW9BYzMSGrFFxVfm69q
 UgZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp98M2uWLH9IoWG1PFd4JCBlNNyG6/mq5pwzPpSFLnJxQMlvojKIeDxUy6O0B6OFIQEUkj59vE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lAW1gMsR2Q9PihdavHOOedk3XzHLmlbw7dTMC921XBN/OOyE4L
 wHxpOhXcUwiwAk6qWSWKemeBCnZ38SDBmnrY0ry1GD07XiLzsaFGdJlF1V222Ds9c/g=
X-Gm-Gg: AR+sD13jyFUJetWyjvY8ZNbxFpabljIPAwgbmZRFnJKF2VADULOq1kgqOPVywKhwXrL
 wswVbboIqvHLvPxXsL9FW0Nvh1+SHsXsymS7Ws8Bosd1WL/gb5w7ea7j45iGe6OaieUqQXNncvw
 NvSZ81dN3nPNEzdh2rytn7BRP51IjnR4KhG8RNkIJ9ak2O2sVlnTTaI0795P/YetweDbFrhb2KQ
 dEYSvvrOcSxwTOjFTqZNjvBmigKOrEcvwPDs2WRvtmnc54GwWwNA/N4lERMgLwadPYTHBcbpjGF
 HjK1KcYZzHLS/UrbqKs1kHVVosnD9ano+TQjMdqxbCBXrRj85iY34njP4yN0w01bYafaH19+fgU
 6aejYfBWkejaJzgIx7SJz5ZAHGITzcFIRJsav6m9/OBk6dQSffPa3yH4LHDiA+riXCl/ywZj4C0
 08VLm8esKTNeG8v5pDv7cP8ilaKae0s2vm5PBz4bTgpoPHMsopQKaCEW74ww0HTHw3z5jhPBwYt
 dKhjh5s+OpYrriczY0My8Z8cBKP2EP9GffAdb9i8TWXhvVWs/vmxLV7LsJ5qBRXlqRCvei5YnSk
 IG5wYubJ2a8/WHu6OoHfBixEcQ==
X-Received: by 2002:a17:90b:3b4d:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-395c39b1750mr41145575a91.10.1787559262064; 
 Mon, 24 Aug 2026 01:14:22 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141860df25csm21408153c88.5.2026.08.24.01.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:14:21 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:14:00 +0800
Subject: [PATCH 2/2] pinctrl: k1: add IO power domain configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pinctrl-v1-2-e02ed7e9309f@riscstar.com>
References: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
In-Reply-To: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>
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
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 95 +++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 6ed511879daf..ccfe26af310b 100644
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
@@ -418,6 +487,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
 		return -EINVAL;
+
 	addr = data->pin_to_reg(dev, pin_selector);
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -460,10 +530,14 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
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
@@ -476,6 +550,7 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv;
 	struct clk_bulk clks;
+	struct ofnode_phandle_args args;
 	size_t size;
 	int ret;
 
@@ -493,6 +568,19 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
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
@@ -520,6 +608,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

