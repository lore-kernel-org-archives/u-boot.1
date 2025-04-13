Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8699C369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 20:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB6382AF6;
	Sun, 13 Apr 2025 22:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h5sYOb66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CA482AE9; Sun, 13 Apr 2025 22:00:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF3882ACF
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 22:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744574407; bh=7N9MMzH1cZ+FqexQHaCsXXUH46X/jYgIL2s7kUcPtH0=;
 b=h5sYOb666XyxN/L/mwI2HSnztElLqc+VyuIc1xSMBqWprLbS5rUxrj0KGgJ57IMTH6C/IexhF
 PV6WmB56xHk3DgyFfMpV7tAHuHODPzOs+Bzxod83U/SBT98hOzBWesZysezNgKbkfzBejNmaQad
 FUZRb24q7ePBlKmVYoMuKNY1+tGQdPa1g4cfKr9snlTiTf5oEdFdLDNgjF6lAZNe6eJivbOOZVW
 qJH0zYAytv5UL0UY05kMnYlBstaUG4Kuj2Z7l9gv30rCfzZ9JIsOwzo4gsMBqHu8jJBl6rdZRho
 deNkIp4EcW5owN/0b0WiVV+It/BNUcOpd4nYn4zywIBg==
X-Forward-Email-ID: 67fc17c56900761fb15162bb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v6 3/7] rockchip: binman: Create a template for the FIT
Date: Sun, 13 Apr 2025 19:59:35 +0000
Message-ID: <20250413195949.432730-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413195949.432730-1-jonas@kwiboo.se>
References: <20250413195949.432730-1-jonas@kwiboo.se>
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

Move the FIT description into a template so that it can be used in both
the simple-bin and the simple-bin-spi images.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v6:
- No change

Changes in v5:
- Merge patch to use template for simple-bin-spi image
- Collect r-b tags

Changes in v4:
- Rename template label to fit_template
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"

Changes in v3:
- Use HAS_FIT for the SPI node also
- Leave fit { node open within #ifdef HAS_FIT
- Move placement of CONFIG_SPL_PAD_TO
- Keep the FIT filename
---
 arch/arm/dts/rockchip-u-boot.dtsi | 64 +++++++++++++++++--------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 943d7d87a068..0c074c0ec6b9 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,6 +19,10 @@
 #define FIT_UBOOT_COMP		"none"
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
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -193,10 +202,9 @@
 			};
 		};
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
+#ifdef HAS_FIT
 		fit {
-			type = "blob";
-			filename = "u-boot.itb";
+			insert-template = <&fit_template>;
 #else
 		u-boot-img {
 #endif
-- 
2.49.0

