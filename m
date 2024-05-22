Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC5AC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBAC78881B;
	Wed, 22 May 2024 12:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="uq86MZS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B788883C; Wed, 22 May 2024 12:14:49 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C3B88831
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so7199876a12.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716372886; x=1716977686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3TvNyDGy713xrYvg9zoCEgGOgAzwLOZwIsEhawqa6o=;
 b=uq86MZS+5F0vQoOU8kwoaV4eRAPaunzse8wh8ilZu5z2Qz1Ttukjt4x2cbk1BHJf+y
 3dX0uaS4L/7OcUJd56aO3J9l+ayMJDtVuBbZOVsGOvTDDLim/UpOWjjXI5kZlYE6seYZ
 LXXe+RhqAjr7R1mI5bQvq3DahQ5AgegWknsmpUwBhVdRS7qw0K0QQEx41IQVfaDS5o0j
 nOBcSKCmij2HO4yk8hbBV1VuqbF6E9ZOYmFLMcsO4a/s/fp4vwFahc/6CnDWLklm1CPY
 Lr4JKDimbjIrE2NdiOtTGsT21g8lsfWqaLJPNQM//zOb9W/lrs15oziwWrLmFQ8Rhi+8
 Vdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372886; x=1716977686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3TvNyDGy713xrYvg9zoCEgGOgAzwLOZwIsEhawqa6o=;
 b=T9IYLe/544dP+powPKkuzD/sIWQtu7QYlYC+PtOjBb6gj2BliXHQtdzKNAVEtTwfsr
 YKHHhASVQUFZLhPj7ku6KTwSoVU9TbE/o2e4MyMFOt/sj+E+udabcFVIkF6ItlZd9FDR
 kLp18nzRiPmrLfape+61oQfw2j6XK3r8OD0Vu765Etz1cCLRM7S+0jGqhVayAIh2/I8L
 iga7/W6Id/wbzJCLZoaRXpFa9aSISKSVpuCV4SDjYPnrr3EYADbNILc2soqMnm503kCk
 D2rkaELL33YSl3hnc3WuOCPP87JJi6tgruY03rq4qG3y9DkAPI7QVxXEFM726P3jqIxw
 EV2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjTH3sdnCuj/sGsOK+UOnM2l0G1kBOGtF84YDNjJ27FN3idc3vY6l3r15TyTjBNAEc8D4NT2Rz50vBHgzp09PJA7KG7w==
X-Gm-Message-State: AOJu0Yw9Zb2uivFw6q1WA9IbWHJuaI5/mw0KsXcPB8VqlxopKrVR2RyM
 lKoSFGxm6bTJstzFpI2kN7hwJI7yCjpuiqSUK39HUeeAgSndjfmC4o98138M5aU=
X-Google-Smtp-Source: AGHT+IGyBwY+oI3QLEaXUKOKLF+UcyT2TEsBQDA9ll+R+wL0mGeKILDZgxDdJsBylqIaUNKaqCn5Xg==
X-Received: by 2002:a17:906:2bc1:b0:a5c:ec66:226d with SMTP id
 a640c23a62f3a-a622805d8dcmr112308666b.17.1716372885763; 
 Wed, 22 May 2024 03:14:45 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-65.dynamic.amis.hr. [188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a5a8b634cdcsm1081502166b.93.2024.05.22.03.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:14:44 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, j4g8y7@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 5/5] arm: dts: add IPQ4019 ESS EDMA U-Boot additions
Date: Wed, 22 May 2024 12:13:45 +0200
Message-ID: <20240522101437.225880-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522101437.225880-1-robert.marko@sartura.hr>
References: <20240522101437.225880-1-robert.marko@sartura.hr>
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

IPQ4019 ESS EDMA support is not yet in upstream Linux, and even when
eventually it is merged the node will not be compatible with U-Boot driver
as the Linux driver properly models the internal switch.

So, lets add the U-Boot additions DTSI for ESS EDMA for now.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/dts/qcom-ipq4019-u-boot.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/dts/qcom-ipq4019-u-boot.dtsi

diff --git a/arch/arm/dts/qcom-ipq4019-u-boot.dtsi b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
new file mode 100644
index 0000000000..f70ef5c9a5
--- /dev/null
+++ b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/ {
+	soc {
+		edma: edma@c080000 {
+			compatible = "qcom,ess-edma";
+			reg = <0xc080000 0x8000>, <0x98000 0x800>, <0xc000000 0x80000>;
+			reg-names = "edma", "psgmii_phy", "switch";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			resets = <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESET>;
+			reset-names = "psgmii", "ess";
+			clocks = <&gcc GCC_ESS_CLK>;
+			clock-names = "ess";
+			status = "disabled";
+
+			switch_ports: switch-ports {
+				phy-mode = "psgmii";
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

