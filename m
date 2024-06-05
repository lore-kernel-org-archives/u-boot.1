Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDEC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87D1883AA;
	Wed,  5 Jun 2024 21:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RkeFYJ3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF21881E5; Wed,  5 Jun 2024 21:03:43 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2536882E2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so611505e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614219; x=1718219019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oJ0+CuhEyFd/RiaRyTVjA4SgSyF7IXaxBtDPRgYd6fk=;
 b=RkeFYJ3iJ9CmhO3E8AT9teUrj249x0dtPPMIOdn8n046LVkLhx9TNEVpG2GA7trkvZ
 zQ2PJ8BT5hg+sz30NwHB49D2PlPZwjFMhCNrTRqI1V3L3zhMM674aE01RjcIFyRyALl2
 H4qCv1aWMLs+U9miP1nkl94xLQFL4PMrRWID0FtsQUZp2VEr824QDQV0iGaPV4RUZ+BU
 KYfQKLuUQAK8eHvmhM+/OFAuEB2hxiyLhm+ZKE/LeIRlf6wrgykQ1/umZI+9i3twUdSY
 T77nIAyHImSKIVWhGGHARbi7pY5h4d9QDDurePnnHWAxxUN9Q8i0nZfUslRFiYmeSgUv
 ceMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614219; x=1718219019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJ0+CuhEyFd/RiaRyTVjA4SgSyF7IXaxBtDPRgYd6fk=;
 b=LpDXEqXQzA7WXPaOhquBIuxGeCIsINKKP7Hi4Q3KfHxrch/JxzriDot39Y/tJzN0YO
 CyN6o2jw93L6cE/0CkGfl0TQp2ycG7KYK+P+V/i/ZSXMTE/B1dJ2HAHzrSyoMS4zwckP
 hwyQU2LCiUzgPvnS2wx8AYC7LShGskXrzW9fEYEkkFDJ2enfcvPGodKrgKN+d6xvi3pS
 bB742fKAK4eDSADB4ANh4j0xtPd8mccjFewxrXeQ6CJIrNVYBZE0V8iKb6M10127Olvt
 tq/+khOwq4X5nNz48RgjtD3vjIxuIH8sgfQJWnN+8Leu4jr/x7o88DeJhopkkORBSS+x
 mtuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4Nd6XS+hZXt0D41Kd/IWnO8LkJQlqIWwmeZ1A5NW1Hjhd2BrDUmzfJ7ukur8nGBvzX2r86qzZUXFCSoYEKYEn6L7kw==
X-Gm-Message-State: AOJu0YwXGwYIPonO3vXyuvojjsFAIIgty9eCE19BMnwTA+K5+AZz3whp
 AdvvxTD3URKpipbFAIXxpoojsTuXBNNUHhPRc44A5TwpzFrMYygW
X-Google-Smtp-Source: AGHT+IFrK1ZLIrHTVsiF8tBjckKs9TM+u5fVkbAXyAguJSyt2dxJJ6axbdTh5hYDOoJHLiPQLUYt5g==
X-Received: by 2002:a05:600c:138e:b0:41f:dc27:a7c1 with SMTP id
 5b1f17b1804b1-4215ace036bmr4621265e9.5.1717614219340; 
 Wed, 05 Jun 2024 12:03:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:39 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 01/11] phy: phy-mtk-tphy: add support for phy type switch
Date: Wed,  5 Jun 2024 21:02:08 +0200
Message-ID: <20240605190220.17616-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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
 drivers/phy/phy-mtk-tphy.c | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/phy-mtk-tphy.c
index ea9edf212c6..24938c8d2e3 100644
--- a/drivers/phy/phy-mtk-tphy.c
+++ b/drivers/phy/phy-mtk-tphy.c
@@ -11,6 +11,8 @@
 #include <generic-phy.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <regmap.h>
+#include <syscon.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
@@ -216,6 +218,14 @@
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
@@ -258,6 +268,10 @@ struct mtk_phy_instance {
 	u32 index;
 	u32 type;
 
+	struct regmap *type_sw;
+	u32 type_sw_reg;
+	u32 type_sw_index;
+
 	u32 eye_vrt;
 	u32 eye_term;
 	u32 discth;
@@ -617,6 +631,67 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
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
@@ -747,6 +822,7 @@ static int mtk_phy_xlate(struct phy *phy,
 	}
 
 	phy_parse_property(tphy, instance);
+	phy_type_set(instance);
 
 	return 0;
 }
@@ -808,6 +884,10 @@ static int mtk_tphy_probe(struct udevice *dev)
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
2.43.0

