Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E91BC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 19:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA2487B1D;
	Sun, 28 Jan 2024 20:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IAdRmBG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C50187B13; Sun, 28 Jan 2024 20:23:39 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2030787A0E
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 20:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tekieli.lukasz@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a35b32bd055so28723066b.2
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706469816; x=1707074616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o+UPWuQkqpd7EuPzg51I0jh1yJQUkid/nl8KMNb5aM=;
 b=IAdRmBG1xwT0f3PLYsRY1RzkF3s3dNvqAjEmCP+rWknVnPRHTC1jVNUb2Rq/xReaRi
 QRvJPvOS8BI3pmpwmr3vlOnHjw0iYc/CdJHnr4KFN5U7667VhXgFjjj4wF8K6lPJnYLd
 wYljyzxUNKNlMXEScjsRcU/IugXRbd720pd4OyIQ2YXpwpqZeRpeoHlAPVZ4a/QO/QmR
 m0YCPrr6TFLRvkurHv7QTDBfsUzkkXqzCVhB/P1RXO/0i99Aa9X/QlE686EBfRHKmWOJ
 dIEaZPESs74fUpL1wv0jpLGb5/1MCFwVGssaGzD/qepoAPD8Z23IEjgJC5otQAQpbu9T
 MV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706469816; x=1707074616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o+UPWuQkqpd7EuPzg51I0jh1yJQUkid/nl8KMNb5aM=;
 b=IVsrg8LW5sSMbOEVZeiho4QpEq3It+GTqwvbdzEwbV66ORf28d7P/s7LQdjaNj7WGw
 lO0Pri+h1hRg/nqFqPlCY2FeDDc0wt/xQZNSCcwxyOa4PUNqkNqRUKDRvFsHorkK4EAG
 x4BaugF/zhcZipqORIl+ZvcIpSjWTjb/MYmymrIl/3eqlHTR+CWmsTYbbjHfXTjyiNlE
 Vyct0UsVgPLFVMTA9p6Q5eSISxCMRh+2JM8TBmgGJkhIHDLkqHlwFWf7d4XKJ/wBjFTr
 ziAi3s+M1QqNBS6sJcBV7PfdkUK39pu6gYlXVrfFYjOYDIcx0KpJ491GD27MIFUVwGsz
 DBew==
X-Gm-Message-State: AOJu0YwTkhWPW74rTtJBW+oZImAMiCTFS7ctRmOUK5rUH2OK4qPNo62+
 0vizmwmxiO7MnBAs+KHuGUJ0lbl5ZzPZYdPSrY5O0gvduROy8TRV
X-Google-Smtp-Source: AGHT+IFzbKbP5+1L8kq7AwZ2k+DcOY4gv3ujaBIALo7s3PWjh4+wQb9d7zwAEKvM2mQ37EmpCKUMAA==
X-Received: by 2002:a17:906:560a:b0:a35:74c1:272d with SMTP id
 f10-20020a170906560a00b00a3574c1272dmr1659213ejq.73.1706469816439; 
 Sun, 28 Jan 2024 11:23:36 -0800 (PST)
Received: from yoga7.fritz.box (ip5f5bff47.dynamic.kabel-deutschland.de.
 [95.91.255.71]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1709061c5100b00a3472da6696sm3107999ejg.159.2024.01.28.11.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 11:23:36 -0800 (PST)
From: Lukasz Tekieli <tekieli.lukasz@gmail.com>
To: yanhong.wang@starfivetech.com, trini@konsulko.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com
Cc: ycliang@andestech.com, sjg@chromium.org, chanho61.park@samsung.com,
 frattaroli.nicolas@gmail.com, u-boot@lists.denx.de,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>
Subject: [PATCH 1/2] net: phy: motorcomm: configure pad drive strength register
Date: Sun, 28 Jan 2024 20:22:47 +0100
Message-Id: <20240128192248.64407-2-tekieli.lukasz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128192248.64407-1-tekieli.lukasz@gmail.com>
References: <20240128192248.64407-1-tekieli.lukasz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 20:35:18 +0100
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

This ports the pad drive strength register configuration which can be
already found in the Linux driver for this PHY.

Signed-off-by: Lukasz Tekieli <tekieli.lukasz@gmail.com>
---
 drivers/net/phy/motorcomm.c | 130 ++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 8635a960d6e..a2c763c8791 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -23,6 +23,12 @@
 
 #define YTPHY_SYNCE_CFG_REG			0xA012
 
+#define YT8531_PAD_DRIVE_STRENGTH_CFG_REG		0xA010
+#define YT8531_RGMII_RXC_DS_MASK		GENMASK(15, 13)
+#define YT8531_RGMII_RXD_DS_HI_MASK		BIT(12)		/* Bit 2 of rxd_ds */
+#define YT8531_RGMII_RXD_DS_LOW_MASK		GENMASK(5, 4)	/* Bit 1/0 of rxd_ds */
+#define YT8531_RGMII_RX_DS_DEFAULT		0x3
+
 #define YTPHY_DTS_OUTPUT_CLK_DIS		0
 #define YTPHY_DTS_OUTPUT_CLK_25M		25000000
 #define YTPHY_DTS_OUTPUT_CLK_125M		125000000
@@ -114,6 +120,10 @@
 #define YT8531_CCR_RXC_DLY_EN			BIT(8)
 #define YT8531_CCR_RXC_DLY_1_900_NS		1900
 
+#define YT8531_CCR_CFG_LDO_MASK		GENMASK(5, 4)
+#define YT8531_CCR_CFG_LDO_3V3			0x0
+#define YT8531_CCR_CFG_LDO_1V8			0x2
+
 /* bits in struct ytphy_plat_priv->flag */
 #define TX_CLK_ADJ_ENABLED			BIT(0)
 #define AUTO_SLEEP_DISABLED			BIT(1)
@@ -224,6 +234,17 @@ static int ytphy_modify_ext(struct phy_device *phydev, u16 regnum, u16 mask,
 	return phy_modify(phydev, MDIO_DEVAD_NONE, YTPHY_PAGE_DATA, mask, set);
 }
 
+static int ytphy_read_ext(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return phy_read(phydev, MDIO_DEVAD_NONE, YTPHY_PAGE_DATA);
+}
+
 static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 {
 	struct ytphy_plat_priv	*priv = phydev->priv;
@@ -425,6 +446,111 @@ static int yt8511_config(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * struct ytphy_ldo_vol_map - map a current value to a register value
+ * @vol: ldo voltage
+ * @ds:  value in the register
+ * @cur: value in device configuration
+ */
+struct ytphy_ldo_vol_map {
+	u32 vol;
+	u32 ds;
+	u32 cur;
+};
+
+static const struct ytphy_ldo_vol_map yt8531_ldo_vol[] = {
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 0, .cur = 1200},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 1, .cur = 2100},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 2, .cur = 2700},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 3, .cur = 2910},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 4, .cur = 3110},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 5, .cur = 3600},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 6, .cur = 3970},
+	{.vol = YT8531_CCR_CFG_LDO_1V8, .ds = 7, .cur = 4350},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 0, .cur = 3070},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 1, .cur = 4080},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 2, .cur = 4370},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 3, .cur = 4680},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 4, .cur = 5020},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 5, .cur = 5450},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 6, .cur = 5740},
+	{.vol = YT8531_CCR_CFG_LDO_3V3, .ds = 7, .cur = 6140},
+};
+
+static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
+{
+	u32 val;
+
+	val = ytphy_read_ext(phydev, YT8531_CHIP_CONFIG_REG);
+	val = FIELD_GET(YT8531_CCR_CFG_LDO_MASK, val);
+
+	return val <= YT8531_CCR_CFG_LDO_1V8 ? val : YT8531_CCR_CFG_LDO_1V8;
+}
+
+static int yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
+{
+	u32 vol;
+	int i;
+
+	vol = yt8531_get_ldo_vol(phydev);
+	for (i = 0; i < ARRAY_SIZE(yt8531_ldo_vol); i++) {
+		if (yt8531_ldo_vol[i].vol == vol && yt8531_ldo_vol[i].cur == cur)
+			return yt8531_ldo_vol[i].ds;
+	}
+
+	return -EINVAL;
+}
+
+static int yt8531_set_ds(struct phy_device *phydev)
+{
+	u32 ds_field_low, ds_field_hi, val;
+	int ret, ds;
+
+	/* set rgmii rx clk driver strength */
+	if (!ofnode_read_u32(phydev->node, "motorcomm,rx-clk-drv-microamp", &val)) {
+		ds = yt8531_get_ds_map(phydev, val);
+		if (ds < 0) {
+			pr_warn("No matching current value was found.");
+			return -EINVAL;
+		}
+	} else {
+		ds = YT8531_RGMII_RX_DS_DEFAULT;
+	}
+
+	ret = ytphy_modify_ext(phydev,
+			       YT8531_PAD_DRIVE_STRENGTH_CFG_REG,
+			       YT8531_RGMII_RXC_DS_MASK,
+			       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	if (ret < 0)
+		return ret;
+
+	/* set rgmii rx data driver strength */
+	if (!ofnode_read_u32(phydev->node, "motorcomm,rx-data-drv-microamp", &val)) {
+		ds = yt8531_get_ds_map(phydev, val);
+		if (ds < 0) {
+			pr_warn("No matching current value was found.");
+			return -EINVAL;
+		}
+	} else {
+		ds = YT8531_RGMII_RX_DS_DEFAULT;
+	}
+
+	ds_field_hi = FIELD_GET(BIT(2), ds);
+	ds_field_hi = FIELD_PREP(YT8531_RGMII_RXD_DS_HI_MASK, ds_field_hi);
+
+	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
+	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
+
+	ret = ytphy_modify_ext(phydev,
+			       YT8531_PAD_DRIVE_STRENGTH_CFG_REG,
+			       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+			       ds_field_low | ds_field_hi);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int yt8531_config(struct phy_device *phydev)
 {
 	struct ytphy_plat_priv	*priv = phydev->priv;
@@ -487,6 +613,10 @@ static int yt8531_config(struct phy_device *phydev)
 			return ret;
 	}
 
+	ret = yt8531_set_ds(phydev);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.39.2

