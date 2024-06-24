Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E0C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE4088403;
	Mon, 24 Jun 2024 23:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HdqE5/OH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4568488387; Mon, 24 Jun 2024 23:04:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F07883D2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421757d217aso52890225e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263067; x=1719867867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eFXbWzKKLkmGQpE+YbS152r2t08PRpPi4kBpt6cBr94=;
 b=HdqE5/OHQYFju8ZjV3kOa41otwqZUlj0wnuqVXGd5W6X/4M58Mcd/NJSrIdc/vRNp6
 6rfyFaoQm0EBj8etELq/OvbtFpQRXfrPAoFZ83HmRPOtL92e/fc+iYKdzKqfj+GWKlMK
 Bv9C99Jzy/IXfQhXh98qEsuDbxKFoS5+pPzwOZ6w7PVLY0gKvWCox/Q07nL/miM9lk2f
 uaZtAW4SB42iHx61jLLXTPVbIySEGi6OnHo1BmUyNY3wzfwHBFNSBjxhH4b/g5vMJl14
 xXaYmddMHVhgInKExiycc9BaUObM1AqhsqiRvHoR+lDLOMNGGfgvjpMUFPFYoNPW97jJ
 qXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263067; x=1719867867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFXbWzKKLkmGQpE+YbS152r2t08PRpPi4kBpt6cBr94=;
 b=FSyZjvH7FYvYdaKBT1WnZ4LZyq5i/vrz9DCCO95kvFFNXnVhTdAixR5O8vT0z829lm
 06zm0HRiQmZAZ39UpO8KltoPJe4UQHo52m9yrZbH8TumpQzIpug4l2c62S+nMi993G+x
 fd3HX1NuwE9A1gai1VebwC3RUF89YtP6OpwYxVZn2lIYnjvspfI3Qi7RMqKkiAxS0m7R
 vmgqMT3/TRN7cn2Tg1RI1Jn1wTCglUpq84kqQ/iCbT4dlcJhfsqPNgVtHsgswc/Wqkzz
 eQu1o6XyNb2XHJojbHlaMhY+FTs7EPWytV5I2EtJ1EQFcoyJDVJG5ZobOoMKxbl3oF8L
 7hIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwZ2nCiEg0V4iLyOHSwVJZSGklyrw+Z1jriQkEnin8fGoVyU3cvbn9aFKy94Zlaxc+DZDCC3eYs/YL5JXdfBLBvurzuA==
X-Gm-Message-State: AOJu0Yzgh8DuLvmH7yJe7VfMmRSZs7BCKRHmOeERBcOuJ0GBOU3VM+9h
 fA5Nj/iJ/1oOoPhZmV/W2XLZK3tEs8H/hQQKM8NWxUcrw3cLvEbO
X-Google-Smtp-Source: AGHT+IHvNenFk0lvoCoTnBmsN+KGQS1hYet9nTfFhwwtM78wb0hVarXv6AkeULLXQVAvha2fcbd0rQ==
X-Received: by 2002:a5d:59a4:0:b0:366:f48e:c6b with SMTP id
 ffacd0b85a97d-366f48e0e2emr3589120f8f.45.1719263067418; 
 Mon, 24 Jun 2024 14:04:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 01/14] phy: phy-mtk-tphy: add support for phy type switch
Date: Mon, 24 Jun 2024 23:03:27 +0200
Message-ID: <20240624210418.19324-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for PHY type switch via the mediatek topmisc syscon.

This is needed on mt7981 to make the PCIe correctly work and display
LinkUp.

Follow the same implementation done on Linux kernel with the usage of
the mediatek,syscon-type property.

Example:

u3port0: usb-phy@11e10700 {
	reg = <0x11e10700 0x900>;
	clocks = <&topckgen CK_TOP_USB3_PHY_SEL>;
	clock-names = "ref";
	#phy-cells = <1>;
	mediatek,syscon-type = <&topmisc 0x218 0>;
	status = "okay";
};

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/phy/Kconfig        |  2 +
 drivers/phy/phy-mtk-tphy.c | 80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 8f767877e73..e12347e8a03 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -263,6 +263,8 @@ config PHY_MTK_TPHY
 	bool "MediaTek T-PHY Driver"
 	depends on PHY
 	depends on ARCH_MEDIATEK || SOC_MT7621
+	select REGMAP
+	select SYSCON
 	help
 	  MediaTek T-PHY driver supports usb2.0, usb3.0 ports, PCIe and
 	  SATA, and meanwhile supports two version T-PHY which have
diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/phy-mtk-tphy.c
index 6f9ac1528e8..0a45dc58629 100644
--- a/drivers/phy/phy-mtk-tphy.c
+++ b/drivers/phy/phy-mtk-tphy.c
@@ -10,6 +10,8 @@
 #include <generic-phy.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <regmap.h>
+#include <syscon.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
@@ -215,6 +217,14 @@
 #define ANA_EQ_EYE_CTRL_SIGNAL5		0xdc
 #define RG_CDR_BIRLTD0_GEN3_MSK		GENMASK(4, 0)
 
+/* PHY switch between pcie/usb3/sgmii/sata */
+#define USB_PHY_SWITCH_CTRL	0x0
+#define RG_PHY_SW_TYPE		GENMASK(3, 0)
+#define RG_PHY_SW_PCIE		0x0
+#define RG_PHY_SW_USB3		0x1
+#define RG_PHY_SW_SGMII		0x2
+#define RG_PHY_SW_SATA		0x3
+
 enum mtk_phy_version {
 	MTK_TPHY_V1 = 1,
 	MTK_TPHY_V2,
@@ -257,6 +267,10 @@ struct mtk_phy_instance {
 	u32 index;
 	u32 type;
 
+	struct regmap *type_sw;
+	u32 type_sw_reg;
+	u32 type_sw_index;
+
 	u32 eye_vrt;
 	u32 eye_term;
 	u32 discth;
@@ -616,6 +630,67 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
 				FIELD_PREP(PA6_RG_U2_PRE_EMP, instance->pre_emphasis));
 }
 
+/* type switch for usb3/pcie/sgmii/sata */
+static int phy_type_syscon_get(struct udevice *dev, struct mtk_phy_instance *instance,
+			       ofnode dn)
+{
+	struct ofnode_phandle_args args;
+	int err;
+
+	if (!ofnode_read_bool(dn, "mediatek,syscon-type"))
+		return 0;
+
+	err = ofnode_parse_phandle_with_args(dn, "mediatek,syscon-type",
+					     NULL, 2, 0, &args);
+	if (err)
+		return err;
+
+	instance->type_sw_reg = args.args[0];
+	instance->type_sw_index = args.args[1] & 0x3; /* <=3 */
+	instance->type_sw = syscon_node_to_regmap(args.node);
+	if (IS_ERR(instance->type_sw))
+		return PTR_ERR(instance->type_sw);
+
+	debug("phy-%s.%d: type_sw - reg %#x, index %d\n",
+	      dev->name, instance->index, instance->type_sw_reg,
+	      instance->type_sw_index);
+
+	return 0;
+}
+
+static int phy_type_set(struct mtk_phy_instance *instance)
+{
+	int type;
+	u32 offset;
+
+	if (!instance->type_sw)
+		return 0;
+
+	switch (instance->type) {
+	case PHY_TYPE_USB3:
+		type = RG_PHY_SW_USB3;
+		break;
+	case PHY_TYPE_PCIE:
+		type = RG_PHY_SW_PCIE;
+		break;
+	case PHY_TYPE_SGMII:
+		type = RG_PHY_SW_SGMII;
+		break;
+	case PHY_TYPE_SATA:
+		type = RG_PHY_SW_SATA;
+		break;
+	case PHY_TYPE_USB2:
+	default:
+		return 0;
+	}
+
+	offset = instance->type_sw_index * BITS_PER_BYTE;
+	regmap_update_bits(instance->type_sw, instance->type_sw_reg,
+			   RG_PHY_SW_TYPE << offset, type << offset);
+
+	return 0;
+}
+
 static int mtk_phy_init(struct phy *phy)
 {
 	struct mtk_tphy *tphy = dev_get_priv(phy->dev);
@@ -746,6 +821,7 @@ static int mtk_phy_xlate(struct phy *phy,
 	}
 
 	phy_parse_property(tphy, instance);
+	phy_type_set(instance);
 
 	return 0;
 }
@@ -807,6 +883,10 @@ static int mtk_tphy_probe(struct udevice *dev)
 						     &instance->da_ref_clk);
 		if (err)
 			return err;
+
+		err = phy_type_syscon_get(dev, instance, subnode);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.45.1

