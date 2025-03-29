Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33093C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B11381F6B;
	Sat, 29 Mar 2025 16:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="x0Rw0VSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E9E805C8; Sat, 29 Mar 2025 16:07:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B7881F0D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260826; bh=YuMKu2Ohfum+SybodP0MnevaG46fdjlxatSMn5VmTdA=;
 b=x0Rw0VSYH5rf6qpVe//q+cuxYFg9Qy58D4T3doehrTKJGPJ0tqNjDJA142Xgkv/X8Jqory6qX
 0XJShJFZIiZgm7YqM+CsxhcNq6tBtjO5Sy+p4uvmduySXKxkUCN431nPzqCT0Di8COV8kyQPzY0
 0kCxVUUxRfjuDQvcunwlL1h6Dd2mobYLfSVcoKpF3vsdf0gZ8Lnfii8AtLFYH/eZAco8MR5xNcY
 lCTpyEzmx4YBMf1ffpm6PCRgn5FaGz3S965h/LEte8PYMTwL0311iTJVIpwH00oJ0Tc9kz0fqfZ
 5XpBvKNppnCZlPn/I/6Cs1ImFzQ6BLWuK0BB1IWJ9Ruw==
X-Forward-Email-ID: 67e80c9721787eb134711fb6
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
Subject: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
Date: Sat, 29 Mar 2025 15:06:12 +0000
Message-ID: <20250329150626.2879942-10-jonas@kwiboo.se>
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

Use of SHA256 checksum validation on ARMv7 SoCs can be very time
consuming compared to ARMv8 SoCs with Crypto Extensions.

Add support for use of the crc32 hash algo when SHA256 is not supported.
Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
compiled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- New patch
---
 arch/arm/dts/rockchip-u-boot.dtsi | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 65b81bf58626..0dfd45bb9bed 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,10 +19,20 @@
 #define COMP	"none"
 #endif
 
+#if defined(CONFIG_SPL_SHA256)
+#define HASH	"sha256"
+#elif defined(CONFIG_SPL_CRC32)
+#define HASH	"crc32"
+#endif
+
 #if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
 #define HAS_FIT
 #endif
 
+#if defined(CONFIG_SPL_FIT_SIGNATURE) && defined(HASH)
+#define HAS_HASH
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -55,9 +65,9 @@
 				u-boot-nodtb {
 					compress = COMP;
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_HASH
 				hash {
-					algo = "sha256";
+					algo = HASH;
 				};
 #endif
 			};
@@ -76,9 +86,9 @@
 
 				atf-bl31 {
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_HASH
 				hash {
-					algo = "sha256";
+					algo = HASH;
 				};
 #endif
 			};
@@ -96,9 +106,9 @@
 				tee-os {
 					optional;
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_HASH
 				hash {
-					algo = "sha256";
+					algo = HASH;
 				};
 #endif
 			};
@@ -114,9 +124,9 @@
 
 				tee-os {
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_HASH
 				hash {
-					algo = "sha256";
+					algo = HASH;
 				};
 #endif
 			};
@@ -126,9 +136,9 @@
 				description = "fdt-NAME";
 				compression = "none";
 				type = "flat_dt";
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_HASH
 				hash {
-					algo = "sha256";
+					algo = HASH;
 				};
 #endif
 			};
-- 
2.49.0

