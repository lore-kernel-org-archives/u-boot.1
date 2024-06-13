Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8669BC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14073888FC;
	Thu, 13 Jun 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWgwPau4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A927B888FC; Thu, 13 Jun 2024 13:10:16 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21961888F2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a30dbdb7fso1060556a12.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277013; x=1718881813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oJ0+CuhEyFd/RiaRyTVjA4SgSyF7IXaxBtDPRgYd6fk=;
 b=MWgwPau4PsfLkv9ykbW0cWyAPHrCglfLObFN1ZnS+I1dtoQ0MY+vgaUGpoaFpHi4I2
 ego7sf5JZFRBFtf9G8wCWF8CWu4ENGALuPE8ndAbI9H8XwkeJcleaRl9L9ByT7K/Tr9w
 oH77cXoscn+IqURzzPlcgSPuVsjsnfvD7tgti9rU/v/s7ZC2zdTOwN5cTXnv8GI5280W
 cg11zpwNmcswpdjdEihKsCrG6xdYsw6Ps3wISxlG5OQoNOzrbHJoOmzWgObKk1IL/nvS
 Li1Y6KXazrdoheJbK0tHni7VIebeLQecs4T6C6x1O/buzsrvm3KrtaN568Vh/7X2Uvgw
 jXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277013; x=1718881813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJ0+CuhEyFd/RiaRyTVjA4SgSyF7IXaxBtDPRgYd6fk=;
 b=rL51w8rerwI2Di5qz64AqymDSQdHW+P1ILJijkLa+rpXyQRJoUKTU9vgHLOdiJ3eM+
 FTN4mhcCp5eYobW4PJ5xjaHe7det1gx0uuJS3UsQ8OI1U2XpTI3MP4bg8zQm6d03GTJN
 mJR7RFApyn4efe+07L2OArjUvoKzIlBrSmDFlHuZvZGvOXeTeJR2/sh1w0vGz92h68Dd
 exeUry8W5YRY4JESPaIzjuOTyIBtWqAshNg8K6GC78OKVat78dBS3DI3SgjLiCk+jEci
 9+1H2mVOoKtLCdhneaOzH9Iz0rJGL5bS/rzIWtsPYn588eUpAPFYt4yvVdJxjfAUbYqT
 PC6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9bFKfPJIj58KCKlDtStCUezOnpS75WZsjRwNuMyEv826YEstE8Y75FAuM/M43/KgBK8W2V9IUJ+tzYivqsjO/+cEVSg==
X-Gm-Message-State: AOJu0YzqkCR/rZMnzjYch2MCMVDeQi0FcwNDy3dtCpoLZQI+XmyPv8sP
 MSNm9U3irc/khrWt8Y0V+ZRpUM9TcS2hyxxjmekau/ZGlBBPjcY2
X-Google-Smtp-Source: AGHT+IFhL48Uie/CeAPJu5WCJuCFDPBhfql+bzwlO1zTJHJsgv4molqxmVV5wHxSRq9wvOAXmcZCKA==
X-Received: by 2002:a17:906:e24b:b0:a6f:308d:48c8 with SMTP id
 a640c23a62f3a-a6f48025c42mr266352666b.69.1718277012995; 
 Thu, 13 Jun 2024 04:10:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:12 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 01/14] phy: phy-mtk-tphy: add support for phy type switch
Date: Thu, 13 Jun 2024 13:09:19 +0200
Message-ID: <20240613110949.11076-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

