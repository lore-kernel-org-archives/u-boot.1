Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3DDC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156A181DE3;
	Sat, 29 Mar 2025 16:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DXGzHBYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9469481DE3; Sat, 29 Mar 2025 16:06:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9367E805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260811; bh=P+xc2RR9ZDKn4paYvNrBsaXgAUEorlGw8JWadTm5dBY=;
 b=DXGzHBYd5zQa928xtmEypf7IByltUiq6UZFNxzx+5aI60BKnujCwd7lBx6sRBLjoxr/bYMJJT
 IvP5X/e9n2GN+8QFa3xaVokM/E7OpVH5Dg3MRHY01ur5HKjeybTq2azTxDUnUX0x5NylytA9SOd
 taK7gwDyxNBmB/WBVINu4uyQTYplYu+/5pLbfOctLzYv6GskHcTsd9Yw4DNqmFI0eKWtAxtXN+D
 t+9HeF+VoFlK04hW9qcCiUSU6q3AV5XI+izBVFLA2Sek334/iEG2Upqwgm2yHEFYv/znq2ar+Hp
 XJu/kE3Ed6AI6ITdOdNN9WIc2CZfqBrZ/FdjUu5lIXEQ==
X-Forward-Email-ID: 67e80c8621787eb134711f3d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 04/10] rockchip: binman: Create a template for the FIT
Date: Sat, 29 Mar 2025 15:06:07 +0000
Message-ID: <20250329150626.2879942-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150626.2879942-1-jonas@kwiboo.se>
References: <20250329150626.2879942-1-jonas@kwiboo.se>
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

From: Simon Glass <sjg@chromium.org>

Move the FIT description into a template so that it can (later) be used
in multiple places in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- Rename template label to fit_template
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"

Changes in v3:
- Use HAS_FIT for the SPI node also
- Leave fit { node open within #ifdef HAS_FIT
- Move placement of CONFIG_SPL_PAD_TO
- Keep the FIT filename
---
 arch/arm/dts/rockchip-u-boot.dtsi | 61 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8aea2e6f5713..9ef1ca6cd13a 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,6 +19,10 @@
 #define COMP	"none"
 #endif
 
+#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
+#define HAS_FIT
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -27,28 +31,9 @@
 
 #ifdef CONFIG_SPL
 &binman {
-	simple-bin {
-		filename = "u-boot-rockchip.bin";
-		pad-byte = <0xff>;
-
-		mkimage {
-			filename = "idbloader.img";
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
-			multiple-data-files;
-
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
-			};
-		};
-
-#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
-		fit: fit {
+#ifdef HAS_FIT
+	fit_template: template-1 {
+			type = "fit";
 #ifdef CONFIG_ARM64
 			description = "FIT image for U-Boot with bl31 (TF-A)";
 #else
@@ -56,10 +41,8 @@
 #endif
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
-			filename = "u-boot.itb";
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 			fit,align = <512>;
-			offset = <CONFIG_SPL_PAD_TO>;
 			images {
 				u-boot {
 					description = "U-Boot";
@@ -164,12 +147,38 @@
 					fit,loadables;
 				};
 			};
+	};
+#endif /* HAS_FIT */
+
+	simple-bin {
+		filename = "u-boot-rockchip.bin";
+		pad-byte = <0xff>;
+
+		mkimage {
+			filename = "idbloader.img";
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			multiple-data-files;
+
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+			rockchip-tpl {
+			};
+#elif defined(CONFIG_TPL)
+			u-boot-tpl {
+			};
+#endif
+			u-boot-spl {
+			};
 		};
+
+#ifdef HAS_FIT
+		fit {
+			filename = "u-boot.itb";
+			insert-template = <&fit_template>;
 #else
 		u-boot-img {
+#endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
-#endif
 
 		fdtmap {
 		};
@@ -196,7 +205,7 @@
 			};
 		};
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
+#ifdef HAS_FIT
 		fit {
 			type = "blob";
 			filename = "u-boot.itb";
-- 
2.49.0

