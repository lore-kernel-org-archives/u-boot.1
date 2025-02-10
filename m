Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E610C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9657A80A23;
	Mon, 10 Feb 2025 07:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="sWpRxgy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C51DE80AE3; Mon, 10 Feb 2025 07:52:24 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635E380BAD
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170342; x=1770706342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xUE9juqY7dSSd+ReZyaL0MWTIuTlMxlm3SDcYyp2bDU=;
 b=sWpRxgy87dljrBc1dvluRhOp9/TFKOeOd7b7surbfrsHkf/Lkm4bhZjh
 bJz7ATJHjmsawWxnXChpjiS0Q3JDWxB7VqP4k26+yx9erUseN2SkUYtLK
 YgutOafcxvxqKey9zYh9hqVNrJymas5t5T4YZkLtR+GS83KGI9eoCVCRm
 lJfRFp5mFyeNLlScB2AlyCOjw22z4CUEBA2XGubRaU1qfmCT/lsm5npf0
 OnxriNnSrE3vfJf0Kn+sEW9vo/efFyJ/dePGkIofg5z9BzzQgAyOzExWD
 QVQ9NIWXWeSYkZq+hFvUbEWpZ8JpZ7/hqKTTtXn6yY1F515aOApPld4CA Q==;
X-CSE-ConnectionGUID: l7eC6ISbRG2IhJavUmxzKw==
X-CSE-MsgGUID: OrKT4c15TLm+lXZFwzJI6w==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072172"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:51:52 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:51:50 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 1/7] ARM: dts: at91: sam9x60: Add AIC node
Date: Mon, 10 Feb 2025 12:21:37 +0530
Message-ID: <20250210065143.313553-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210065143.313553-1-manikandan.m@microchip.com>
References: <20250210065143.313553-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add Advanced Interrupt Controller node and define it as interrupt
parent in sam9x60 SoC DT.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/dts/sam9x60.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 3b684fc63d5..4ff10857a09 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -17,6 +17,7 @@
 /{
 	model = "Microchip SAM9X60 SoC";
 	compatible = "microchip,sam9x60";
+	interrupt-parent = <&aic>;
 
 	aliases {
 		serial0 = &dbgu;
@@ -199,6 +200,14 @@
 				reg = <0xffffea00 0x100>;
 			};
 
+			aic: interrupt-controller@fffff100 {
+				compatible = "microchip,sam9x60-aic";
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0xfffff100 0x100>;
+				atmel,external-irqs = <31>;
+			};
+
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-- 
2.25.1

