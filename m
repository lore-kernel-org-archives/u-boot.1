Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFF2C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1582588324;
	Mon,  3 Jun 2024 14:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="0XsPJKu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E650A8832D; Mon,  3 Jun 2024 14:07:02 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E696A88245
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a20ccafc6so3492331a12.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1717416420; x=1718021220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGZQr5gMXTO24jjNQa2TisTD9GuXgfgrd9V3/R/4sAI=;
 b=0XsPJKu14LFc9yQvLWhIf6yEbWfX+CYYkVhGrKeZMx6tq0UntpeTnX8wWvq8KTlr2U
 N9jiYMOC52XQzFHfS3+XhZ3ef0i3oNPJZfZ1E7CsHV0Uh1BkoXHcAZgF/6DUW+Co7J8P
 oe2kZGvzlRLmQEG4He9KV9NI2eldNRtX3I/V82qCggA5B1OWomGHWwzrHt43gKVTwofc
 7J9wWA+9fIDO8PUPiekbh6QyxLyAj20/OuyQj5w+9b/RGC6PC3djhAuAD0u376pfQGe7
 qerdGvNPUMBPwDml/SO+3mN1vhfxloHCeyz3nan/ATBa8533WiWEON9Xcd9DBoWaKy2/
 kz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717416420; x=1718021220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGZQr5gMXTO24jjNQa2TisTD9GuXgfgrd9V3/R/4sAI=;
 b=Mcg3ryGnP6fq8nO9aLfqL7AjRV/u8h5wpEWG00LBjLq/jABGLGXN06FFfivC+cbK7E
 Kc7ch29p+9VOJZ0Nz0oFXfIN47115eRKEvEAg7HRAY3eTuy3UH2VAxDUdkjVsFRHBpDR
 NQ/zHeM8nlea8caYpqamkWb7pL6o4mFQCZVtugj8sWP8voWJnNPgbzBJBsp50AR7gANv
 fg8754B3jf481u4furW/RAAaKGHdQkSCNK3De4QmqJmsacNRYPdGi48VRfh7dFMhcT4n
 hK09iNUaGQTAc8Pq8hsPgIRjnpfRGoI8txjXg9Rru5kfgIX2wxXmRvAmbC08TOEjula8
 wO9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPoofxj7kRwrqhWFlx/06HSTL0BJUS19UHYaAtfOn45c3N7N/RwT9GIgU2se3tJnb+RM03ypUZy2X32DcyV0RU+J6lng==
X-Gm-Message-State: AOJu0YxAMozwg2RIcLTCicLM+zYuHxDtCfKUA0IbV1re7tCr1n8Cx9al
 po7d8GZDXE6+XfuYRrVczsuiJjuHEPK6Spb4qsAllHtStFPW4RVcfqYYbdyOwEc=
X-Google-Smtp-Source: AGHT+IE6fcvhleBAs53eyAQz+Bhk13s3yszF6CMN3sjgzlt6Qm4D8/iBLHbXT8q2BwuHci7I0r2RNA==
X-Received: by 2002:a50:cd04:0:b0:57a:2fc1:e838 with SMTP id
 4fb4d7f45d1cf-57a363aed39mr6109799a12.22.1717416420157; 
 Mon, 03 Jun 2024 05:07:00 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-221.dynamic.amis.hr. [188.129.45.221])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5cbece23sm2380391a12.61.2024.06.03.05.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:06:59 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 5/5] arm: dts: add IPQ4019 ESS EDMA U-Boot additions
Date: Mon,  3 Jun 2024 14:06:16 +0200
Message-ID: <20240603120651.154670-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603120651.154670-1-robert.marko@sartura.hr>
References: <20240603120651.154670-1-robert.marko@sartura.hr>
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

