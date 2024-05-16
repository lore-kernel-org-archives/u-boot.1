Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9DEC25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83A788486;
	Thu, 16 May 2024 23:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715895091;
	bh=J0WeK3nKKt+rn5Fuaud2rERERTgTU+Ecr+6pMbmAXhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hOdDATMsA3KMJF9iQesrRTVeAhHOQTSCCC/9yaXYCAEimtTni5oAYYapB1XGxxjm7
	 w9JJWNQNR05TDgyLEPWs+lnefoXWBQ0q1RBnTf8Qk43Y0Y2HmHV6SNe8YXpVcDXJow
	 fuvOdr8Rqc+Jr1qnqfSVBbtJpp3D1v69i2NHT+1SbWNsNXHHRpKaQzH7KJFZcfo0Q8
	 10i8Stm8zJdQ/cpJeMh5FpXgEPQziMReJY2Ldl2qDVjYZgRkZHHW07uP7YxT1K7LcC
	 o0AdHvE+i2NMBmTbD3fAjmTI7LcCyIOQKss4zxj3x5uIYmZ8iItBCrb0oJkUzGVxtF
	 WcUu5fy+eeTyA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3B4FD8844D;
 Thu, 16 May 2024 23:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715895090;
 bh=J0WeK3nKKt+rn5Fuaud2rERERTgTU+Ecr+6pMbmAXhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bVHM7Z4sIPG3BdqBWQ1KyayRUllHyVFJVJ8WXYFdwfBcwgKkld8S8FAtGqNwvY1i4
 80aec0xvTJ6IUOXQ6vT7wmUDM9lX70Bn0Fh0u/sJTlNgKkGoJn89osW1tkHKQRZ4mM
 vpttXqIRXS+UMfCKTEQkgOO5gXAP+e8ZS9olPSWGOAcq7KaD/CzdTho759TK64w5/g
 kkcO7noer1sD1ClKenwopzL4SzFxxJ6bDTvVeLJtzUiU9W6fVcUQFio/E6ofni1S+U
 CW9Huf/g7KZz6YwpvEwEHPM2Wi/GWB4JWT/VVHmzHmESeF69bOKuOW0JYl5B5NlnNN
 7/wZdUXYX30wg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: anton.gres@ifm.com, ch@denx.de, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: [PATCH v3 2/4] ARM: dts: imx: Introduce SPL and FIT labels to i.MX8M
 DTs binman nodes
Date: Thu, 16 May 2024 23:28:40 +0200
Message-ID: <20240516213036.89016-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516213036.89016-1-marex@denx.de>
References: <20240516213036.89016-1-marex@denx.de>
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

Add binman_imx_spl and binman_imx_fit labels to nxp-imx8mimage {} and fit {}
nodes respectively, so they can be referened in board DTs no matter how deep
in the top level binman image description they are. Update current board DTs
to use those labels.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: New patch
V3: No change
---
 arch/arm/dts/imx8mm-u-boot.dtsi               |   4 +-
 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |   8 +-
 arch/arm/dts/imx8mn-u-boot.dtsi               |   4 +-
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         | 124 +++++++++---------
 arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi    |  26 ++--
 arch/arm/dts/imx8mp-u-boot.dtsi               |   4 +-
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi    |  10 +-
 arch/arm/dts/imx8mq-u-boot.dtsi               |   4 +-
 8 files changed, 84 insertions(+), 100 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 6ab8f66256e..b9b1193823a 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -54,7 +54,7 @@
 		};
 #endif
 
-		nxp-imx8mimage {
+		binman_imx_spl: nxp-imx8mimage {
 			filename = "u-boot-spl-mkimage.bin";
 			nxp,boot-from = "sd";
 			nxp,rom-version = <1>;
@@ -98,7 +98,7 @@
 			};
 		};
 
-		fit {
+		binman_imx_fit: fit {
 			description = "Configuration to load ATF before U-Boot";
 #ifndef CONFIG_IMX_HAB
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 90183aff8bc..183de46f66a 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -35,12 +35,8 @@
 	bootph-pre-ram;
 };
 
-&binman {
-	section {
-		fit {
-			offset = <0x5fc00>;
-		};
-	};
+&binman_imx_fit {
+	offset = <0x5fc00>;
 };
 
 &gpio1 {
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index ba9967dbe4a..c9fb33cfb73 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -103,7 +103,7 @@
 		};
 #endif
 
-		nxp-imx8mimage {
+		binman_imx_spl: nxp-imx8mimage {
 			filename = "u-boot-spl-mkimage.bin";
 			nxp,boot-from = "sd";
 			nxp,rom-version = <2>;
@@ -169,7 +169,7 @@
 			};
 		};
 
-		fit {
+		binman_imx_fit: fit {
 			description = "Configuration to load ATF before U-Boot";
 #ifndef CONFIG_IMX_HAB
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index cb37e28f28f..c065fb82994 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -135,73 +135,69 @@
 	bootph-pre-ram;
 };
 
-&binman {
-	section {
-		fit {
-			images {
-				fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast {
-					description = "imx8mp-dhcom-som-overlay-eth1xfast";
-					type = "flat_dt";
-					compression = "none";
-
-					blob-ext {
-						filename = "imx8mp-dhcom-som-overlay-eth1xfast.dtbo";
-					};
-				};
-
-				fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast {
-					description = "imx8mp-dhcom-som-overlay-eth2xfast";
-					type = "flat_dt";
-					compression = "none";
-
-					blob-ext {
-						filename = "imx8mp-dhcom-som-overlay-eth2xfast.dtbo";
-					};
-				};
-
-				fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast {
-					description = "imx8mp-dhcom-pdk-overlay-eth2xfast";
-					type = "flat_dt";
-					compression = "none";
-
-					blob-ext {
-						filename = "imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo";
-					};
-				};
-
-				fdt-dto-imx8mp-dhcom-som-overlay-rev100 {
-					description = "imx8mp-dhcom-som-overlay-rev100";
-					type = "flat_dt";
-					compression = "none";
-
-					blob-ext {
-						filename = "imx8mp-dhcom-som-overlay-rev100.dtbo";
-					};
-				};
-
-				fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 {
-					description = "imx8mp-dhcom-pdk3-overlay-rev100";
-					type = "flat_dt";
-					compression = "none";
-
-					blob-ext {
-						filename = "imx8mp-dhcom-pdk3-overlay-rev100.dtbo";
-					};
-				};
+&binman_imx_fit {
+	images {
+		fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast {
+			description = "imx8mp-dhcom-som-overlay-eth1xfast";
+			type = "flat_dt";
+			compression = "none";
+
+			blob-ext {
+				filename = "imx8mp-dhcom-som-overlay-eth1xfast.dtbo";
 			};
+		};
+
+		fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast {
+			description = "imx8mp-dhcom-som-overlay-eth2xfast";
+			type = "flat_dt";
+			compression = "none";
+
+			blob-ext {
+				filename = "imx8mp-dhcom-som-overlay-eth2xfast.dtbo";
+			};
+		};
+
+		fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast {
+			description = "imx8mp-dhcom-pdk-overlay-eth2xfast";
+			type = "flat_dt";
+			compression = "none";
+
+			blob-ext {
+				filename = "imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo";
+			};
+		};
 
-			configurations {
-				default = "@config-DEFAULT-SEQ";
-
-				@config-SEQ {
-					fdt = "fdt-1",
-					      "fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast",
-					      "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
-					      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast",
-					      "fdt-dto-imx8mp-dhcom-som-overlay-rev100",
-					      "fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100";
-				};
+		fdt-dto-imx8mp-dhcom-som-overlay-rev100 {
+			description = "imx8mp-dhcom-som-overlay-rev100";
+			type = "flat_dt";
+			compression = "none";
+
+			blob-ext {
+				filename = "imx8mp-dhcom-som-overlay-rev100.dtbo";
+			};
+		};
+
+		fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 {
+			description = "imx8mp-dhcom-pdk3-overlay-rev100";
+			type = "flat_dt";
+			compression = "none";
+
+			blob-ext {
+				filename = "imx8mp-dhcom-pdk3-overlay-rev100.dtbo";
 			};
 		};
 	};
+
+	configurations {
+		default = "@config-DEFAULT-SEQ";
+
+		@config-SEQ {
+			fdt = "fdt-1",
+			      "fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast",
+			      "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
+			      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast",
+			      "fdt-dto-imx8mp-dhcom-som-overlay-rev100",
+			      "fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100";
+		};
+	};
 };
diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
index aff5dcf615d..21eff6d6ad4 100644
--- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
@@ -135,21 +135,17 @@
 	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_400M>;
 };
 
-&binman {
-	section {
-		fit {
-			images {
-				fip {
-					description = "Trusted Firmware FIP";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					load = <0x40310000>;
-
-					fip_blob: blob-ext{
-						filename = "fip.bin";
-					};
-				};
+&binman_imx_fit {
+	images {
+		fip {
+			description = "Trusted Firmware FIP";
+			type = "firmware";
+			arch = "arm64";
+			compression = "none";
+			load = <0x40310000>;
+
+			fip_blob: blob-ext{
+				filename = "fip.bin";
 			};
 		};
 	};
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index c4c1a177102..8b5ac3faf1c 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -86,7 +86,7 @@
 	section {
 		pad-byte = <0x00>;
 
-		nxp-imx8mimage {
+		binman_imx_spl: nxp-imx8mimage {
 			filename = "u-boot-spl-mkimage.bin";
 			nxp,boot-from = "sd";
 			nxp,rom-version = <2>;
@@ -129,7 +129,7 @@
 			};
 		};
 
-		fit {
+		binman_imx_fit: fit {
 			description = "Configuration to load ATF before U-Boot";
 #ifndef CONFIG_IMX_HAB
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
diff --git a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
index 1a4568dac65..98da015a444 100644
--- a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
@@ -10,14 +10,10 @@
 	bootph-pre-ram;
 };
 
-&binman {
+&binman_imx_spl {
 	section {
-		nxp-imx8mimage {
-			section {
-				signed-hdmi-imx8m {
-					filename = "signed_dp_imx8m.bin";
-				};
-			};
+		signed-hdmi-imx8m {
+			filename = "signed_dp_imx8m.bin";
 		};
 	};
 };
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 48dbe94f0c4..72da674d245 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -38,7 +38,7 @@
 	section {
 		pad-byte = <0x00>;
 
-		nxp-imx8mimage {
+		binman_imx_spl: nxp-imx8mimage {
 			filename = "u-boot-spl-mkimage.bin";
 			nxp,boot-from = "sd";
 			nxp,rom-version = <1>;
@@ -87,7 +87,7 @@
 			};
 		};
 
-		fit {
+		binman_imx_fit: fit {
 			description = "Configuration to load ATF before U-Boot";
 #ifndef CONFIG_IMX_HAB
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-- 
2.43.0

