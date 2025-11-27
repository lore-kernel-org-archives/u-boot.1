Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FA7D116F3
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679C18448F;
	Thu, 27 Nov 2025 18:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vTYMpw/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18EE84303; Thu, 27 Nov 2025 18:29:33 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C674D83B4A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 632CF4E41926;
 Thu, 27 Nov 2025 17:29:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 39C9060722;
 Thu, 27 Nov 2025 17:29:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CCFDA102F2B42; Thu, 27 Nov 2025 18:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764264570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EkJtEyA2nb69EEu7GymH1UOeoDJZ8xE29KlIZ9Lbfzs=;
 b=vTYMpw/RXGKEd4PX32yhnQnkaKW59jzfGtgJmSQvfYZQ8Iqg57bpt0I9pme18MHZ9xrU11
 2L+L1ViUXV4ttRPkw0FuicGE5xRWf+cltwqjM3gomZeS1avgXHh7sPAPzooBIWLr1621sh
 zh6As6G+0BmEqKPzy6ZOzOxSitt+Vumwbell5Aqr0niBREtRUtlGxV2i0nxTxrh4TMgO8p
 9MdsfMBmM9jC7t8EY826aZerywq/dIKnqEL5Sp5m5AVChEiHIqKkZXhc/7mnLg17maO76l
 7v2u8ahbfl61Qd7hUVSv+c/7TOahM1rXpYKmdh/Fhav6yBFSkhBYsgjpFn4VkQ==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?=
 <jeremie.dautheribes@bootlin.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Wahid Essid <wahid.essid@se.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH 2/2] imx93-u-boot: use nxp-imx9image etype for binman node
Date: Thu, 27 Nov 2025 18:29:20 +0100
Message-ID: <20251127172920.39740-3-jeremie.dautheribes@bootlin.com>
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

Similar to the imx95, use the nxp-imx9image etype for the binman node to
facilitate further modifications.

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 51 +++++++++++++---------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index 8d1a29d0bdb..dc86746ac90 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -43,43 +43,32 @@
 			};
 		};
 
-		spl {
-			filename = "spl.bin";
-
-			mkimage {
-				args = "-n spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000";
-
-				blob {
-					filename = "u-boot-spl-ddr.bin";
-				};
-			};
-		};
-
-		u-boot-container {
-			filename = "u-boot-container.bin";
-
-			mkimage {
-				args = "-n u-boot-container.cfgout -T imx8image -e 0x0";
-
-				blob {
-					filename = "u-boot.bin";
-				};
-			};
-		};
-
 		imx-boot {
 			filename = "flash.bin";
 			pad-byte = <0x00>;
 
-			spl: blob-ext@1 {
-				filename = "spl.bin";
-				offset = <0x0>;
-				align-size = <0x400>;
-				align = <0x400>;
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx93a1-ahab-container.img";
+				container;
+				image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
 			};
 
-			uboot: blob-ext@2 {
-				filename = "u-boot-container.bin";
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x204E0000";
+				image1 = "a55", "u-boot.bin", "0x80200000";
 			};
 		};
 	};
-- 
2.43.0

