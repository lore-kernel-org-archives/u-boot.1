Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BF9C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 21:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB11E83E3A;
	Thu, 10 Apr 2025 23:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zvbDBiAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3405B83E3A; Thu, 10 Apr 2025 23:45:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7EB83ACE
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 23:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c990=W5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744321538; bh=+TIi/Vw3k4xUCPjF7q9r5KivUeIFyUenme8YnpvGaTw=;
 b=zvbDBiAtdsfdB92WbsMop0TWxdOknppkud1QBZRysyACUY9/YOj3zoRTo9BL/0Gsb5yFKbHiy
 ppoypyQ2w964JIPveko6FxPKVZEl/9oi2hLaVZc8oKKU9/Tr+smk1slsrmPxE6YgLfJesP1S1JM
 veLGxzkHl08Xe31/aDyaU1Sf3GEw/A6hcLsBmVcT0t0rPFj0PI2EWd6jQhGf89uD9k0d1JYqpec
 Im3G05c51cz89uGnW0UYEVbvnsvVBPsESQYHnf1cyz+K3LkithraHlC2sag1aPWoi7YcOO07JRV
 R2h0TZGAy4aMirbnY4VDZo4NRV5XzWtTYvw21vjAAQZg==
X-Forward-Email-ID: 67f83bff0ebe9f861dbcc3c5
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
Subject: [PATCH v5 7/7] rockchip: binman: Support use of crc32 hash for FIT
 images
Date: Thu, 10 Apr 2025 21:44:56 +0000
Message-ID: <20250410214506.3575404-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410214506.3575404-1-jonas@kwiboo.se>
References: <20250410214506.3575404-1-jonas@kwiboo.se>
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
consuming compared to when used on a ARMv8 SoC with Crypto Extensions.

Add support for use of the much faster CRC32 hash algo when SHA256 is
not supported in SPL. Also use a HAS_FIT_HASH to simplify the ifdefs
when no known hash algo has been compiled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v5:
- Update commit message and add comment that CRC32 hash algo should
  only be used for basic checksum validation.
- Collect r-b tag

Changes in v4:
- New patch

This patch can be skipped in case there is any objection against adding
crc32 as a checksum fallback algo, something that will be usefull in a
future rk3228 related series.
---
 arch/arm/dts/rockchip-u-boot.dtsi | 34 ++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index f60cc31fb1a6..18accef8bd44 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,10 +19,24 @@
 #define FIT_UBOOT_COMP		"none"
 #endif
 
+/*
+ * SHA256 should be enabled in SPL when signature validation is involved,
+ * CRC32 should only be used for basic checksum validation of FIT images.
+ */
+#if defined(CONFIG_SPL_SHA256)
+#define FIT_HASH_ALGO		"sha256"
+#elif defined(CONFIG_SPL_CRC32)
+#define FIT_HASH_ALGO		"crc32"
+#endif
+
 #if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
 #define HAS_FIT
 #endif
 
+#if defined(CONFIG_SPL_FIT_SIGNATURE) && defined(FIT_HASH_ALGO)
+#define HAS_FIT_HASH
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -55,9 +69,9 @@
 				u-boot-nodtb {
 					compress = FIT_UBOOT_COMP;
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_FIT_HASH
 				hash {
-					algo = "sha256";
+					algo = FIT_HASH_ALGO;
 				};
 #endif
 			};
@@ -76,9 +90,9 @@
 
 				atf-bl31 {
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_FIT_HASH
 				hash {
-					algo = "sha256";
+					algo = FIT_HASH_ALGO;
 				};
 #endif
 			};
@@ -96,9 +110,9 @@
 				tee-os {
 					optional;
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_FIT_HASH
 				hash {
-					algo = "sha256";
+					algo = FIT_HASH_ALGO;
 				};
 #endif
 			};
@@ -114,9 +128,9 @@
 
 				tee-os {
 				};
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_FIT_HASH
 				hash {
-					algo = "sha256";
+					algo = FIT_HASH_ALGO;
 				};
 #endif
 			};
@@ -126,9 +140,9 @@
 				description = "fdt-NAME";
 				compression = "none";
 				type = "flat_dt";
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+#ifdef HAS_FIT_HASH
 				hash {
-					algo = "sha256";
+					algo = FIT_HASH_ALGO;
 				};
 #endif
 			};
-- 
2.49.0

