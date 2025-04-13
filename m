Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16474C369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 20:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C1782ABA;
	Sun, 13 Apr 2025 22:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XBByv1/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4402828D0; Sun, 13 Apr 2025 22:00:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415D282917
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 22:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744574402; bh=fFMEZMag/ho0lHLHLx95U6wN7577ed02q5JQRWgyFxY=;
 b=XBByv1/qC0+Su0sggZHRbKBfIH5jb9nrG/xZKG4hsxq2HLwbaKP5NMAxTNYuRjLZ36ambqkCJ
 cgReuBdARGKtoyd3iCgcm2u808VU1owIuVh65f58+0uS29exrOr55SrikgzDTvjhYd1SkArRiZ4
 3uVQbgWjC4bi2CIjd1cOvjG19pfUOaEi14K7jLLrk5Jj76ev9kWOKB5nP7bp1VXlT3D4OW+0/jE
 SptEETwiyg9crmublMX3iuKeC5yJtxoG3C+MCo/Tb6YdicszdQlbChJGkFspAYqPR+iC4Xb8NrS
 dIvcW6+JChJcenL7pLRy4qVCjz+7ln1iFRDNQk2lJO9Q==
X-Forward-Email-ID: 67fc17c16900761fb15162a6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v6 2/7] rockchip: binman: Factor out arch and compression
Date: Sun, 13 Apr 2025 19:59:34 +0000
Message-ID: <20250413195949.432730-3-jonas@kwiboo.se>
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

Declare arch and compression at the top of the file to avoid needing
ifdefs in every usage.

Add a few comments to help with the remaining #ifdefs.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v6:
- No change

Changes in v5:
- Rename ARCH to FIT_ARCH
- Rename COMP to FIT_UBOOT_COMP
- Collect r-b tag

Changes in v4:
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index e9ed1d4b5738..943d7d87a068 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -5,6 +5,20 @@
 
 #include <config.h>
 
+#ifdef CONFIG_ARM64
+#define FIT_ARCH		"arm64"
+#else
+#define FIT_ARCH		"arm"
+#endif
+
+#if defined(CONFIG_SPL_GZIP)
+#define FIT_UBOOT_COMP		"gzip"
+#elif defined(CONFIG_SPL_LZMA)
+#define FIT_UBOOT_COMP		"lzma"
+#else
+#define FIT_UBOOT_COMP		"none"
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
+					arch = FIT_ARCH;
+					compression = FIT_UBOOT_COMP;
 					load = <CONFIG_TEXT_BASE>;
 					entry = <CONFIG_TEXT_BASE>;
 					u-boot-nodtb {
-#if defined(CONFIG_SPL_GZIP)
-					compress = "gzip";
-#elif defined(CONFIG_SPL_LZMA)
-					compress = "lzma";
-#endif
+					compress = FIT_UBOOT_COMP;
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 					hash {
@@ -84,7 +84,7 @@
 					fit,operation = "split-elf";
 					description = "ARM Trusted Firmware";
 					type = "firmware";
-					arch = "arm64";
+					arch = FIT_ARCH;
 					os = "arm-trusted-firmware";
 					compression = "none";
 					fit,load;
@@ -103,7 +103,7 @@
 					fit,operation = "split-elf";
 					description = "TEE";
 					type = "tee";
-					arch = "arm64";
+					arch = FIT_ARCH;
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
+					arch = FIT_ARCH;
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

