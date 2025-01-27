Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064EC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BB68142D;
	Mon, 27 Jan 2025 14:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lk6hl7e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660DF8128B; Mon, 27 Jan 2025 14:41:21 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AB081265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2256730f8f.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985279; x=1738590079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5cMlDsQGmg58TbUVZ1JU14W7977ZPednDF6MDXte7ek=;
 b=Lk6hl7e6jdJAQt5uUMafyixX0jYLexOmhrd+SWeaKGBN4vxeNZaLla6lAIVf7+734T
 uy+qlWMfOObZI952w4jUJ3PNsuCCvOp3dtbKqycs2lL0Y3/HLZViyEUPgM9bOw6Ftl1S
 6ha1/GCvKo+HtIfrFvKBF/r+hIFGJI15PkLIjFI1Pkd4qXvolvdycHJyvekEuSB2HoeJ
 YyHeuRxuaTGqo4V6aUwsWmQUxGBGu6ciO9v8QrZ3dAGcglQ1gLv0ECCiMBywD71szJx1
 vpXeaAVmXq9of25/tv4zqRrkD3XuaxOJPSqA3mgLDItGHlgLcBLwixZ8KuRfSGh88+bW
 28rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985279; x=1738590079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cMlDsQGmg58TbUVZ1JU14W7977ZPednDF6MDXte7ek=;
 b=RTe6mk9PrHzR+SLdp+IgDQ88hfS9cOBGJa+kcQEdCEGOB/gFHbF5BDMZl7ic8VKHhY
 g6hicLoM5Sw6jekS24VJ1dpCpE2cEidDqkY8Cw173pCxCsS3NmDuNXmeZeCFzuywLnzs
 fbCnShiLLB2I3FpzcE5csTNr5txZ6xRPT+lZT8n+LYOHaxcckvMx2vXXG00JC423NJ0X
 4wXblCBH4LHfCso2b6RAH45w5Gd+hBcX/xUSQs90pQ7qmbk+62zK0BLYbzKaRRyM43/9
 eiHFrMNLCbzUhvRyhYGnINufN+AnO+biuiWzfF9vEOxSnanGhO5K3wcv5FjIF/eXiNQd
 g7Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFEdGr+mdaIrr8Zh4rl4Nen1pPV2UwsMt4jm/kXithHGnxIANtpA1WgNINFqBLmZifxjYjNds=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp5HaU0O4Qnnzxdg8ahmjMRBEkddUbPxCCrRSoKYd8Fk475o/h
 Ylmbs/yms5QwxGV+JL37ywTJ6bziwJQhhZczXXSg/RrN1PmOj/EF
X-Gm-Gg: ASbGncsfDVUTnB18LvD3jfrn8pha7x+oYihrlCoZoIkzADkJ9cQgo85ca1HHMulYsPX
 g9fz0towj1NZ5Mmwrg5kBXd0dotHM9v3Ppv2CF6Ssk6I7Lu8Z7/ZQ+7lnvHQbNA6J0Q95wRmFEr
 JMK020ZMXo0S/du3HWfGi5yBisxBDnvcpgrdZ+RkpLVlHzm7+U+3T3h/8FfyzRktXK8ojhEVedp
 agpboaMfL/gU/cD1Xpu9PVQzrH4WSM1AeJDPCSG5sGkiCXMXIlRwvcjnTiI8XGI3GDyiK+BZMJl
 VkZRlI55iaX1lOvgJEeMU8IvfaO+ULjYYPdh3yXzGNVhgrgemg==
X-Google-Smtp-Source: AGHT+IF6HRJP4hbrSxoWQnztbThhg9apiJskwVAqeQ0tO22QA8MJ5bajZW0X4m23EV8FtxCLjM0QUw==
X-Received: by 2002:a5d:64e2:0:b0:38b:ef2b:422 with SMTP id
 ffacd0b85a97d-38bf57a9615mr32878442f8f.36.1737985278650; 
 Mon, 27 Jan 2025 05:41:18 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:18 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 7/8] arm: dts: mediatek: add USB nodes for MT7981
Date: Mon, 27 Jan 2025 14:40:44 +0100
Message-ID: <20250127134046.26345-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

From: John Crispin <john@phrozen.org>

Add USB PHY nodes for MT7981. These are needed for USB support and also
for PCIe support as the u3 PHY can also be used for PHY.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index b2c4cd7b54a..2360c6bbdca 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/clock/mt7981-clk.h>
 #include <dt-bindings/reset/mt7629-reset.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
@@ -315,4 +316,51 @@
 		status = "disabled";
 	};
 
+	xhci: xhci@11200000 {
+		compatible = "mediatek,mt7981-xhci",
+			     "mediatek,mtk-xhci";
+		reg = <0x11200000 0x2e00>,
+		      <0x11203e00 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&u2port0 PHY_TYPE_USB2>,
+		       <&u3port0 PHY_TYPE_USB3>;
+		clocks = <&infracfg CLK_INFRA_IUSB_SYS_CK>,
+			 <&infracfg CLK_INFRA_IUSB_CK>,
+			 <&infracfg CLK_INFRA_IUSB_133_CK>,
+			 <&infracfg CLK_INFRA_IUSB_66M_CK>,
+			 <&topckgen CLK_TOP_U2U3_XHCI_SEL>;
+		clock-names = "sys_ck",
+			      "ref_ck",
+			      "mcu_ck",
+			      "dma_ck",
+			      "xhci_ck";
+		mediatek,u3p-dis-msk = <0x1>;
+		status = "okay";
+	};
+
+	usbtphy: usb-phy@11e10000 {
+		compatible = "mediatek,mt7981",
+			     "mediatek,generic-tphy-v2";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		status = "okay";
+
+		u2port0: usb-phy@11e10000 {
+			reg = <0x11e10000 0x700>;
+			clocks = <&topckgen CLK_TOP_USB_FRMCNT_SEL>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port0: usb-phy@11e10700 {
+			reg = <0x11e10700 0x900>;
+			clocks = <&topckgen CLK_TOP_USB3_PHY_SEL>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			mediatek,syscon-type = <&topmisc 0x218 0>;
+			status = "okay";
+		};
+	};
 };
-- 
2.47.1

