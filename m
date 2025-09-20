Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C2CCAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694358004F;
	Sat, 20 Sep 2025 18:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=easynet.dev header.i=@easynet.dev header.b="sK2F8Wf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF4E82B07; Sat, 20 Sep 2025 18:36:09 +0200 (CEST)
Received: from smtp04.easynet.dev (smtp04.easynet.dev
 [IPv6:2a00:ece1:2:10::1:113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF688003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@easynet.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=easynet.dev; s=mail;
 t=1758386166; bh=sj+nOlF1S4pcpB+1oFK56NVRHw07avxgxBx+q1Xbq1M=;
 h=From:To:Cc:Subject:Date:From;
 b=sK2F8Wf+2MMvqCzJqeZ6/MJpFLZXT58hvGfwhuSMSLYsluObVBvb3WQTm9mPG+Yh3
 iUIH2KcRqtdLWFtarrvKgkpgELXi1tTe/k06lAy4b4eb0uizQ0P1lannilIuwNcKeO
 4Rn/aOYS3x5BnSQLK2zPzd4LRlXxpv5l9n7la/PiMnzejGLpJaaB+4B4Za/WR0LbGt
 HIGHNNfjG2vffcq6m1F33GbP/+qnZaqOx728iwpFQKQk6f87qFnGygnDEHI5h/f+2V
 mXFOaZU8OYs7TBUIn1YqPxbmxByM8B07uXAGT6DDv+ZYvTjikD/UJEpnTMdzl5Y7GV
 XfP2aJFISfVEw==
Received: from Ryzen5900X.easynet.dev (unknown
 [IPv6:2001:171b:2267:5ac1:f86e:749b:e8ed:f7dc])
 (Authenticated sender: adrian@easynet.dev)
 by smtp1.easynet.dev (Postfix) with ESMTPSA id 2B055600FF;
 Sat, 20 Sep 2025 19:36:06 +0300 (EEST)
From: EasyNetDev <devel@easynet.dev>
To: u-boot@lists.denx.de
Cc: EasyNetDev <devel@easynet.dev>
Subject: [PATCH] MT7988 add LED Blue/Green + WPS/Reset Button
Date: Sat, 20 Sep 2025 18:35:33 +0200
Message-ID: <20250920163536.1096800-1-devel@easynet.dev>
X-Mailer: git-send-email 2.51.0
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

MT7988 is missing LED Blue and Green from DTS.
EEPROM is hard wired to LED Green and you can't use it without
LED support.
WPS/Reset button is just for future customization of the U-Boot booting.

Signed-off-by: EasyNetDev <devel@easynet.dev>
---
 arch/arm/dts/mt7988-rfb.dts    | 23 +++++++++++++++++++++++
 arch/arm/dts/mt7988-sd-rfb.dts | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 1694ef8d9c3..1a2a0bd7d70 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -38,6 +38,29 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		wps {
+			label = "wps/reset";
+				gpios = <&pio 14 GPIO_ACTIVE_LOW>;
+			};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_status_green: green {
+			label = "green:status";
+			gpios = <&pio 79 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_status_blue: blue {
+			label = "blue:status";
+			gpios = <&pio 63 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart0 {
diff --git a/arch/arm/dts/mt7988-sd-rfb.dts b/arch/arm/dts/mt7988-sd-rfb.dts
index 63e923137c2..de24ae2d1c4 100644
--- a/arch/arm/dts/mt7988-sd-rfb.dts
+++ b/arch/arm/dts/mt7988-sd-rfb.dts
@@ -29,6 +29,29 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		wps {
+			label = "wps/reset";
+				gpios = <&pio 14 GPIO_ACTIVE_LOW>;
+			};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_status_green: green {
+			label = "green:status";
+			gpios = <&pio 79 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_status_blue: blue {
+			label = "blue:status";
+			gpios = <&pio 63 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.51.0

