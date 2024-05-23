Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1022C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C99B8861E;
	Thu, 23 May 2024 19:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="Cevw8NVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83A3885F6; Thu, 23 May 2024 19:38:28 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1ED7885FB
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57822392a0dso4588352a12.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716485906; x=1717090706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGZQr5gMXTO24jjNQa2TisTD9GuXgfgrd9V3/R/4sAI=;
 b=Cevw8NVPRhgYZ8lmY03rCWyALo8GhpsJB0JFgUz+Y5aMPv5N1RxgNR4mFzqIsIm01j
 KhT9myA+pOwkXphCCXnZJvRSM+jwJWOccvmvB6Qv797jR9LgUWLlA5zgdelfrgalUvJu
 cThPxg9VqDKrblAKFTg9fElxFopo/iOkUxP20HiIurWO3CFKt0hUTZHi6mIAbYLEMT+h
 Nh+/4l+Mb+7aiLCVusmVTYjt9Zedf/icxzxRJAzGxgfTuSPe4uNavAMcH76jqktgZD9a
 7Og6Ubeol9DCUFMF4VeC3rjhEYvBEBiHS+/zoE3tT3g2u6NVvyplYtAf2P2jmQGLZTLF
 Ht5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716485906; x=1717090706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGZQr5gMXTO24jjNQa2TisTD9GuXgfgrd9V3/R/4sAI=;
 b=PAR0GVhvIBvk/8xfVSIuL2HYxzUllOITuOLUE2OLVUjibz09WTozXChaDMcSej+Ao9
 gsrSA8QCOJraGY9JAkk5PhGXNb6H1iB/ATGEHuH7IkNP2mUjHl5463+813WZXgLvKpSd
 JxiAZ1YGgJiUchhc9IICE/bH3timHJcXpUhGJksBplOTDT6MhnSfxhlDH+fwSzyF9exR
 0008yImMfwiT1Y/6sit9M8iaxga6YwxIonz/ccY21Sv9cy4e1tnvNjrA1xcdvDlrlwI1
 tymL/nWw+UqR4gvst6X70BZP4yjRLzR+AF7Mg8YWDygqpau3/sQRDg9bZdjNxxHJ6MHJ
 RsHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwLDof07M0naTCN7nZi9S+hNV1C+1y9rK/0nBcVfDAtpALuyneZoYCvoYD+3WrrIlAL2i0k0upiIPVkxEAqV3Y1hTPRA==
X-Gm-Message-State: AOJu0YyBheHUnA/kdfLIw3TtIxaVx27iSfsFwn4aYKeXinL9u96dv4QX
 9FKNzMPQi8NEgXvajnayi9F0GQTKUAkO+C/PaY+oTkbcQhdIpBTSXjJlZ6SCG+g=
X-Google-Smtp-Source: AGHT+IGF+YPPkJiNmIhEfoSyjOssmrKQID7u4iM6vC78C34sB+ymdjsDymy5E3d1Cto9jQGOjUpbEA==
X-Received: by 2002:a50:cd81:0:b0:575:c1a:494b with SMTP id
 4fb4d7f45d1cf-57832a08954mr3428940a12.9.1716485906365; 
 Thu, 23 May 2024 10:38:26 -0700 (PDT)
Received: from fedora.. ([188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-574f5a5b029sm12430366a12.7.2024.05.23.10.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:38:25 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 5/5] arm: dts: add IPQ4019 ESS EDMA U-Boot additions
Date: Thu, 23 May 2024 19:37:29 +0200
Message-ID: <20240523173815.63628-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523173815.63628-1-robert.marko@sartura.hr>
References: <20240523173815.63628-1-robert.marko@sartura.hr>
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

IPQ4019 ESS EDMA support is not yet in upstream Linux, so for now lets use
the latest pending Linux DTS node for wired networking.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Chanes in v2:
* Use the latest pending Linux DT node for EDMA instead

 arch/arm/dts/qcom-ipq4019-u-boot.dtsi | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/arm/dts/qcom-ipq4019-u-boot.dtsi

diff --git a/arch/arm/dts/qcom-ipq4019-u-boot.dtsi b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
new file mode 100644
index 0000000000..07aaaa9f41
--- /dev/null
+++ b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/ {
+	soc {
+		switch: switch@c000000 {
+			compatible = "qcom,ipq4019-ess";
+			reg = <0xc000000 0x80000>, <0x98000 0x800>, <0xc080000 0x8000>;
+			reg-names = "base", "psgmii_phy", "edma";
+			resets = <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESET>;
+			reset-names = "psgmii", "ess";
+			clocks = <&gcc GCC_ESS_CLK>;
+			clock-names = "ess";
+			mdio = <&mdio>;
+			interrupts = <GIC_SPI  65 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  66 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  67 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  68 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  69 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  70 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  71 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  72 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  73 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  74 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  75 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  76 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  77 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  78 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  79 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  80 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 240 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 242 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 243 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 246 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 249 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 252 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 253 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 254 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 255 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				swport1: port@1 { /* MAC1 */
+					reg = <1>;
+					label = "lan1";
+					phy-handle = <&ethphy0>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport2: port@2 { /* MAC2 */
+					reg = <2>;
+					label = "lan2";
+					phy-handle = <&ethphy1>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport3: port@3 { /* MAC3 */
+					reg = <3>;
+					label = "lan3";
+					phy-handle = <&ethphy2>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport4: port@4 { /* MAC4 */
+					reg = <4>;
+					label = "lan4";
+					phy-handle = <&ethphy3>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport5: port@5 { /* MAC5 */
+					reg = <5>;
+					label = "wan";
+					phy-handle = <&ethphy4>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+			};
+		};
+	};
+};
+
+&mdio {
+	psgmiiphy: psgmii-phy@5 {
+		reg = <5>;
+	};
+};
-- 
2.45.1

