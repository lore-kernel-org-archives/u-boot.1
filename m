Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C841C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1DD80F0E;
	Sat, 29 Mar 2025 16:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hzU6YG5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5BA81DCC; Sat, 29 Mar 2025 16:06:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CED780F0E
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260801; bh=DiPL602+OMb2ficq1Ein9zquT28v2n3Rc8WxoW1r11k=;
 b=hzU6YG5qqOvziBI1Gc5Lv7wZ2Ouc3L97CDLTkFVsCRRPCgvkwzOOT7XW4RqZXoxJwnew+lNa6
 Fag7EjZlnsblXKpq+ppv+OnKE78Xr1zjXr9TUe/s68e7J9xvmWG/MgCvPlfoobzOSIh2UWVQ7xt
 EcDZ5j+pLjekzcjvmafnOUa7OaMXHsGtBX7U49gxzynifQtD29ZCCDGLqMVJbZGTCwWwr8uXIJ4
 nS9s6aByCvZWDLyjc9YQtvZ7NSviPhtCTsf6Tk20LyEODMSMErVslEz6BiLIOTtjKk9SIXjbS0/
 Y2F1idB+UAYwU+28PVWfqnoAAllsdz5shN3sJZGsRQDA==
X-Forward-Email-ID: 67e80c7f21787eb134711f07
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v4 02/10] rockchip: binman: Factor out arch and compression
Date: Sat, 29 Mar 2025 15:06:05 +0000
Message-ID: <20250329150626.2879942-3-jonas@kwiboo.se>
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

Declare arch and compression at the top of the file to avoid needing
ifdefs in every usage.

Add a few comments to help with the remaining #ifdefs.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index e9ed1d4b5738..2b01dc660562 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -5,6 +5,20 @@
 
 #include <config.h>
 
+#ifdef CONFIG_ARM64
+#define ARCH	"arm64"
+#else
+#define ARCH	"arm"
+#endif
+
+#if defined(CONFIG_SPL_GZIP)
+#define COMP	"gzip"
+#elif defined(CONFIG_SPL_LZMA)
+#define COMP	"lzma"
+#else
+#define COMP	"none"
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -51,26 +65,12 @@
 					description = "U-Boot";
 					type = "standalone";
 					os = "u-boot";
-#ifdef CONFIG_ARM64
-					arch = "arm64";
-#else
-					arch = "arm";
-#endif
-#if defined(CONFIG_SPL_GZIP)
-					compression = "gzip";
-#elif defined(CONFIG_SPL_LZMA)
-					compression = "lzma";
-#else
-					compression = "none";
-#endif
+					arch = ARCH;
+					compression = COMP;
 					load = <CONFIG_TEXT_BASE>;
 					entry = <CONFIG_TEXT_BASE>;
 					u-boot-nodtb {
-#if defined(CONFIG_SPL_GZIP)
-					compress = "gzip";
-#elif defined(CONFIG_SPL_LZMA)
-					compress = "lzma";
-#endif
+					compress = COMP;
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 					hash {
@@ -84,7 +84,7 @@
 					fit,operation = "split-elf";
 					description = "ARM Trusted Firmware";
 					type = "firmware";
-					arch = "arm64";
+					arch = ARCH;
 					os = "arm-trusted-firmware";
 					compression = "none";
 					fit,load;
@@ -103,7 +103,7 @@
 					fit,operation = "split-elf";
 					description = "TEE";
 					type = "tee";
-					arch = "arm64";
+					arch = ARCH;
 					os = "tee";
 					compression = "none";
 					fit,load;
@@ -119,11 +119,11 @@
 					};
 #endif
 				};
-#else
+#else /* !CONFIG_ARM64 */
 				op-tee {
 					description = "OP-TEE";
 					type = "tee";
-					arch = "arm";
+					arch = ARCH;
 					os = "tee";
 					compression = "none";
 					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
@@ -137,7 +137,7 @@
 					};
 #endif
 				};
-#endif
+#endif /* CONFIG_ARM64 */
 
 				@fdt-SEQ {
 					description = "fdt-NAME";
-- 
2.49.0

