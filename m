Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D41FD111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30ED28445D;
	Thu, 27 Nov 2025 18:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="e6/GJ0UB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6409784459; Thu, 27 Nov 2025 18:29:32 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7256284303
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 37070C16A1F;
 Thu, 27 Nov 2025 17:29:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 12B2760722;
 Thu, 27 Nov 2025 17:29:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B2210103C8EE3; Thu, 27 Nov 2025 18:29:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764264569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WiZ3C3qsQNKkkFLOoAC7cgGhOId/l/U5uIQjrteBHZk=;
 b=e6/GJ0UBR7nCWZnbcRrV7LIWZBrJVXY/hWHJxIxaa99xJl5kJg91oE3ThGRVqLhk9lzEKR
 fbnguAPxYIC8tkAzgzjax40W6uqjCj66jRxdTb55DO5WSIqhEQq02R7hdjW/RtYjT+2gUE
 7zsT0dgskeLQQmdJNhzhaPFQs6a3KvpHf7s4TY9KNY5lUyOh4RTvYPPm1+rKKzdJR0wMyu
 cmCrNXY7DvJa4CEyqaZpAaCJVw1iVad2hXxbab0Qan37ITUsGcm2xBsGpn63fjvlhYwVkq
 chVkBqLiqW7zxVHXnZr7DTqEyHMkP3R4IanF98JttH/GQwe+DP0Etya2tUsWaQ==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?=
 <jeremie.dautheribes@bootlin.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Wahid Essid <wahid.essid@se.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH 1/2] imx93-u-boot: move binman description
Date: Thu, 27 Nov 2025 18:29:19 +0100
Message-ID: <20251127172920.39740-2-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127172920.39740-1-jeremie.dautheribes@bootlin.com>
References: <20251127172920.39740-1-jeremie.dautheribes@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Jérémie Dautheribes (Schneider Electric)" <jeremie.dautheribes@bootlin.com>

No functional changes, only cosmetic adjustments to prepare for the next
commit.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 126 ++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 64 deletions(-)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index b2b3d57318f..8d1a29d0bdb 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -6,93 +6,91 @@
 / {
 	binman: binman {
 		multiple-images;
-	};
-};
 
-&A55_0 {
-	clocks = <&clk IMX93_CLK_ARM_PLL>;
-};
+		u-boot-spl-ddr {
+			align = <4>;
+			align-size = <4>;
+			filename = "u-boot-spl-ddr.bin";
+			pad-byte = <0xff>;
 
-&A55_1 {
-	clocks = <&clk IMX93_CLK_ARM_PLL>;
-};
+			u-boot-spl {
+				align-end = <4>;
+				filename = "u-boot-spl.bin";
+			};
 
-&binman {
-	u-boot-spl-ddr {
-		align = <4>;
-		align-size = <4>;
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
+			ddr-1d-imem-fw {
+				filename = "lpddr4_imem_1d_v202201.bin";
+				align-end = <4>;
+				type = "blob-ext";
+			};
 
-		u-boot-spl {
-			align-end = <4>;
-			filename = "u-boot-spl.bin";
-		};
+			ddr-1d-dmem-fw {
+				filename = "lpddr4_dmem_1d_v202201.bin";
+				align-end = <4>;
+				type = "blob-ext";
+			};
 
-		ddr-1d-imem-fw {
-			filename = "lpddr4_imem_1d_v202201.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
+			ddr-2d-imem-fw {
+				filename = "lpddr4_imem_2d_v202201.bin";
+				align-end = <4>;
+				type = "blob-ext";
+			};
 
-		ddr-1d-dmem-fw {
-			filename = "lpddr4_dmem_1d_v202201.bin";
-			align-end = <4>;
-			type = "blob-ext";
+			ddr-2d-dmem-fw {
+				filename = "lpddr4_dmem_2d_v202201.bin";
+				align-end = <4>;
+				type = "blob-ext";
+			};
 		};
 
-		ddr-2d-imem-fw {
-			filename = "lpddr4_imem_2d_v202201.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
+		spl {
+			filename = "spl.bin";
+
+			mkimage {
+				args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000";
 
-		ddr-2d-dmem-fw {
-			filename = "lpddr4_dmem_2d_v202201.bin";
-			align-end = <4>;
-			type = "blob-ext";
+				blob {
+					filename = "u-boot-spl-ddr.bin";
+				};
+			};
 		};
-	};
 
-	spl {
-		filename = "spl.bin";
+		u-boot-container {
+			filename = "u-boot-container.bin";
 
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000";
+			mkimage {
+				args = "-n u-boot-container.cfgout -T imx8image -e 0x0";
 
-			blob {
-				filename = "u-boot-spl-ddr.bin";
+				blob {
+					filename = "u-boot.bin";
+				};
 			};
 		};
-	};
 
-	u-boot-container {
-		filename = "u-boot-container.bin";
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
 
-		mkimage {
-			args = "-n u-boot-container.cfgout -T imx8image -e 0x0";
+			spl: blob-ext@1 {
+				filename = "spl.bin";
+				offset = <0x0>;
+				align-size = <0x400>;
+				align = <0x400>;
+			};
 
-			blob {
-				filename = "u-boot.bin";
+			uboot: blob-ext@2 {
+				filename = "u-boot-container.bin";
 			};
 		};
 	};
+};
 
-	imx-boot {
-		filename = "flash.bin";
-		pad-byte = <0x00>;
-
-		spl: blob-ext@1 {
-			filename = "spl.bin";
-			offset = <0x0>;
-			align-size = <0x400>;
-			align = <0x400>;
-		};
+&A55_0 {
+	clocks = <&clk IMX93_CLK_ARM_PLL>;
+};
 
-		uboot: blob-ext@2 {
-			filename = "u-boot-container.bin";
-		};
-	};
+&A55_1 {
+	clocks = <&clk IMX93_CLK_ARM_PLL>;
 };
 
 &tmu {
-- 
2.43.0

