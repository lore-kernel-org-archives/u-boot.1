Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D37E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 11:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC16989481;
	Fri,  6 Dec 2024 12:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DYeE4FVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02547893A4; Fri,  6 Dec 2024 12:37:18 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C698953A
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 12:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BD87B3F789; 
 Fri,  6 Dec 2024 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733485035;
 bh=sZg3C0mlHPrVO1QMlez0eVzj0mAFBnagXwYOM1CGHzw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DYeE4FVTC81aWs+ezq7rpwtVTVxoz5q2IdxXPKPpNhm3kiChB4Yda+Lhv0AwPHZaX
 WKKBDN3l1I5/fQ3WqszUO2Kczj7Dx/JGsCjiD972jr2my5kOkE3yJQ6D7YNTL0deWI
 SyKfH3aJv20X6EMJGoX+vUcmROSdxhbNJA2187mAba16Y01IoTpeiScCg3PqcN1iIe
 UIGK/O6E20L7AeoKAWwgC5c2miOBWgB65o/iYBKei1UG95WQ8BVb7/1fPHq96CISv4
 ff9hCgsIrBRIsfYnjg+PaBGxr9QaPzXfNT6+ysseV4HlnWDPKesFfEbkKPRs1KNUze
 nbRs4OJcqWgfQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: disable MBEDTLS in SPL
Date: Fri,  6 Dec 2024 12:37:09 +0100
Message-ID: <20241206113710.11689-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Building SPL fails with MBEDTLS enabled.
Currently we don't need it there.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/u-boot/md5.h       |  6 ++++--
 include/u-boot/sha1.h      |  5 +++--
 include/u-boot/sha256.h    |  5 +++--
 include/u-boot/sha512.h    |  5 +++--
 lib/Makefile               |  2 +-
 lib/lwip/Makefile          |  2 +-
 lib/lwip/u-boot/lwipopts.h |  4 +++-
 lib/md5.c                  |  6 ++++--
 lib/sha1.c                 |  6 ++++--
 lib/sha256.c               |  6 ++++--
 lib/sha512.c               | 12 ++++++++----
 11 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index c98b1a58088..2a52e169051 100644
--- a/include/u-boot/md5.h
+++ b/include/u-boot/md5.h
@@ -6,7 +6,9 @@
 #ifndef _MD5_H
 #define _MD5_H
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#include <linux/kconfig.h>
+
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 #include <mbedtls/md5.h>
 #endif
 #include "compiler.h"
@@ -14,7 +16,7 @@
 #define MD5_SUM_LEN	16
 #define MD5_DEF_CHUNK_SZ 0x10000
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_md5_context MD5Context;
 #else
 typedef struct MD5Context {
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index 2fca7f1be16..dd66258bbe9 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -14,9 +14,10 @@
 #ifndef _SHA1_H
 #define _SHA1_H
 
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 /*
  * FIXME:
  * MbedTLS define the members of "mbedtls_sha256_context" as private,
@@ -47,7 +48,7 @@ extern "C" {
 
 extern const uint8_t sha1_der_prefix[];
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_sha1_context sha1_context;
 #else
 /**
diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index b58d5b58d39..44a9b528b48 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -1,9 +1,10 @@
 #ifndef _SHA256_H
 #define _SHA256_H
 
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 /*
  * FIXME:
  * MbedTLS define the members of "mbedtls_sha256_context" as private,
@@ -27,7 +28,7 @@ extern const uint8_t sha256_der_prefix[];
 /* Reset watchdog each time we process this many bytes */
 #define CHUNKSZ_SHA256	(64 * 1024)
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_sha256_context sha256_context;
 #else
 typedef struct {
diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 7e10f590a1d..92660d93357 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -1,9 +1,10 @@
 #ifndef _SHA512_H
 #define _SHA512_H
 
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 #include <mbedtls/sha512.h>
 #endif
 
@@ -16,7 +17,7 @@
 #define CHUNKSZ_SHA384	(16 * 1024)
 #define CHUNKSZ_SHA512	(16 * 1024)
 
-#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_sha512_context sha384_context;
 typedef mbedtls_sha512_context sha512_context;
 #else
diff --git a/lib/Makefile b/lib/Makefile
index dbcfa87ebd6..d24ed629732 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -97,7 +97,7 @@ obj-$(CONFIG_LIBAVB) += libavb/
 obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(PHASE_)OF_REAL) += fdtdec_common.o fdtdec.o
 
-obj-$(CONFIG_MBEDTLS_LIB) += mbedtls/
+obj-$(CONFIG_$(XPL_)MBEDTLS_LIB) += mbedtls/
 
 obj-$(CONFIG_NET_LWIP) += lwip/
 
diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
index 19e5c6897f5..fe2b64c9acc 100644
--- a/lib/lwip/Makefile
+++ b/lib/lwip/Makefile
@@ -54,5 +54,5 @@ obj-y += \
 	lwip/src/core/udp.o \
 	lwip/src/netif/ethernet.o
 
-obj-$(CONFIG_MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
+obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
 	lwip/src/apps/altcp_tls/altcp_tls_mbedtls_mem.o
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 88d6faf327a..edac74ff7a2 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -5,6 +5,8 @@
 #ifndef LWIP_UBOOT_LWIPOPTS_H
 #define LWIP_UBOOT_LWIPOPTS_H
 
+#include <linux/kconfig.h>
+
 #if defined(CONFIG_LWIP_DEBUG)
 #define LWIP_DEBUG 1
 #define LWIP_DBG_MIN_LEVEL              LWIP_DBG_LEVEL_ALL
@@ -154,7 +156,7 @@
 #define MEMP_MEM_INIT			1
 #define MEM_LIBC_MALLOC			1
 
-#if defined(CONFIG_MBEDTLS_LIB_TLS)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
 #define LWIP_ALTCP                      1
 #define LWIP_ALTCP_TLS                  1
 #define LWIP_ALTCP_TLS_MBEDTLS          1
diff --git a/lib/md5.c b/lib/md5.c
index 2d8977b2e85..e3eab8a9149 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -272,14 +272,16 @@ md5_wd(const unsigned char *input, unsigned int len, unsigned char output[16],
 	unsigned int chunk_sz)
 {
 	MD5Context context;
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	const unsigned char *end, *curr;
 	int chunk;
 #endif
 
 	MD5Init(&context);
 
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	curr = input;
 	end = input + len;
 	while (curr < end) {
diff --git a/lib/sha1.c b/lib/sha1.c
index a9d6497c4ce..be502c6126b 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -312,14 +312,16 @@ void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
 		  unsigned char *output, unsigned int chunk_sz)
 {
 	sha1_context ctx;
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	const unsigned char *end, *curr;
 	int chunk;
 #endif
 
 	sha1_starts (&ctx);
 
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	curr = input;
 	end = input + ilen;
 	while (curr < end) {
diff --git a/lib/sha256.c b/lib/sha256.c
index 329802fd827..fb195d988f1 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -273,7 +273,8 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz)
 {
 	sha256_context ctx;
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	const unsigned char *end;
 	unsigned char *curr;
 	int chunk;
@@ -281,7 +282,8 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha256_starts(&ctx);
 
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	curr = (unsigned char *)input;
 	end = input + ilen;
 	while (curr < end) {
diff --git a/lib/sha512.c b/lib/sha512.c
index ea555ff33eb..0e75c1a943b 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -288,7 +288,8 @@ void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz)
 {
 	sha512_context ctx;
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	const unsigned char *end;
 	unsigned char *curr;
 	int chunk;
@@ -296,7 +297,8 @@ void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha384_starts(&ctx);
 
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	curr = (unsigned char *)input;
 	end = input + ilen;
 	while (curr < end) {
@@ -351,7 +353,8 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz)
 {
 	sha512_context ctx;
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	const unsigned char *end;
 	unsigned char *curr;
 	int chunk;
@@ -359,7 +362,8 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha512_starts(&ctx);
 
-#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+#if !defined(USE_HOSTCC) && \
+    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
 	curr = (unsigned char *)input;
 	end = input + ilen;
 	while (curr < end) {
-- 
2.45.2

