Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D002FC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8723281703;
	Wed,  2 Apr 2025 00:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SzAs3Z1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B394C81FFC; Wed,  2 Apr 2025 00:52:42 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E724981F6B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so19355685e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547959; x=1744152759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rjYFk1rITbC53hgO74cOixGOld1i5av2OAHTIphe74U=;
 b=SzAs3Z1xtHp3wddfOYEXUcVbhRTa2mqjvb1o5YuRhZ2oJe808J/5D850SkRJpOkMCp
 YgiGaFcaSrGfJabqa6VsWPTaacNz2hPT1eYcTKF5umM4IOwtMnuEnO3Gf8jSg6ayvH8m
 GLVhvpvQS1Ypxem1ZlbBGhALEo4+14m+zqY0bzAJiW3Mx7saaNQeSE0o8P2hjmf5FT29
 K7TsL+WikD+XqX1HP1CLTk8xkp+/0uzlnDR/Wgou/vpNf0DeV7y7hkp5N6cLVHQxH3qQ
 A3z0u7SOCHbnBgOQtiRT2Yr8WrNhJRobZPz0fwanT28L5fqdQXM/Vb/u3zjl3//mEG4/
 hadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547959; x=1744152759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjYFk1rITbC53hgO74cOixGOld1i5av2OAHTIphe74U=;
 b=OVVEekII1zn4wtmVuseQdK2C6ud6V0udzKLo/vwg4Y8YqtmV8XaRqeHTm77yjvQ97j
 fZQBDGDD2qbmwoK8YA1WryBcOUfzr2uduIs/mGfrZEUNFrPMkriHvlibOraRI5Ngt7JP
 LHeuHB5F6g1o4Bee2DYT6zF0xntoZ+OHSjv+efep8ocnzy2sOEh6id19Ow2kHDEJdZHV
 vsg7knRBjp4mUGzZco5x6MyINGe6w15alllS0fZXsZU+unHVyyWQ8+5iWPRXbBpgH0vv
 v6ZtzHksR7W/fyEpSv+ZUTTrQMl7NsksZqXNwUdPil1Kdm0Du7N1CT8CLjwJCEXOQ3Bo
 8wvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAh9tIajRWQUo4oZamzcBoLXvvfkP09XAHvpVrhiHX7z3TyGBQ8dLEhSnMB6r0bxzBm0H5tu0=@lists.denx.de
X-Gm-Message-State: AOJu0YyeCHPdyeGMFbZ11Vbjgfikw77tV92Z1HBQwMgqylILurc2ygxD
 vLjSD0Ko02OimWWWZCg84rCPP3UcZmSSlsYlO8fCLI0PFCI56ZN3
X-Gm-Gg: ASbGncv22fiNAY98VCUblHcuG+Jc9GlsD+NlAyXP4JCsQICq+EjBbLFD1wHG5nKxcIy
 Or2DIRyoFeY0lpuSDLttSXROp4JxunuG7DyrND33Eepzclf2+yCPAmGeyEJ9VE+UaUCvkjXQ49R
 XZkWNQ4h28sDXLAFtxU5EP+TczTxuMRXlz7gtGOXOT4pR/C+13JVm4xHfyQXPiS6hl/KdtbeD5Y
 Vm1lKw15cz50OvWJqHdQ5zhto7nJOSVDzBVVsWAwyorzkqJGsu3y57kRJQTwOI4rw/g5+Ex3BGH
 L5Z36W4ajhN+wRuH8q4ds7LfhhYKhoOz7e8Oj9uJ1CwLxBwwW/qqAlS3wHz2RjQ+wGIPgoUAhDu
 eBcgLhzlGhN2Sd8KZWyyH0Vuc
X-Google-Smtp-Source: AGHT+IHi+8uY4/4Y5/mI6KXrdX+2YRLQFhEFTRrUUV9ztyGdHjgBDbf27CR4BYkaPH6b2Wlb9e5qsA==
X-Received: by 2002:a5d:5850:0:b0:391:48d4:bd02 with SMTP id
 ffacd0b85a97d-39c2976956cmr150922f8f.29.1743547959371; 
 Tue, 01 Apr 2025 15:52:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 04/14] arch: arm: dts: an7581: Add Ethernet nodes
Date: Wed,  2 Apr 2025 00:51:36 +0200
Message-ID: <20250401225156.25790-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Add Ethrnet nodes for Airoha AN7581 EVB board.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 9f8abfc3bcf..a569044195d 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <dt-bindings/reset/airoha,en7581-reset.h>
+
 / {
 	reserved-memory {
 		#address-cells = <2>;
@@ -17,9 +19,37 @@
 			compatible = "airoha,en7581-chip-scu", "syscon";
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
+
+		eth: ethernet@1fb50000 {
+			compatible = "airoha,en7581-eth";
+			reg = <0 0x1fb50000 0 0x2600>,
+				<0 0x1fb54000 0 0x2000>,
+				<0 0x1fb56000 0 0x2000>;
+			reg-names = "fe", "qdma0", "qdma1";
+
+			resets = <&scuclk EN7581_FE_RST>,
+				 <&scuclk EN7581_FE_PDMA_RST>,
+				 <&scuclk EN7581_FE_QDMA_RST>,
+				 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
+				 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
+				 <&scuclk EN7581_HSI_MAC_RST>,
+				 <&scuclk EN7581_XFP_MAC_RST>;
+			reset-names = "fe", "pdma", "qdma",
+				      "hsi0-mac", "hsi1-mac", "hsi-mac",
+				      "xfp-mac";
+		};
+
+		switch: switch@1fb58000 {
+			compatible = "airoha,en7581-switch";
+			reg = <0 0x1fb58000 0 0x8000>;
+		};
 	};
 };
 
+&scuclk {
+	compatible = "airoha,en7581-scu", "syscon";
+};
+
 &uart1 {
 	bootph-all;
 };
-- 
2.48.1

