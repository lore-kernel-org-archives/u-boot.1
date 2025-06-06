Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E3AC61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780C382998;
	Sat,  7 Jun 2025 00:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C07882A9E; Sat,  7 Jun 2025 00:46:51 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5F9828F8
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8F6A7B4C35AB;
 Sat,  7 Jun 2025 00:46:48 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 5/7] lib: use lowercase hex prefix style
Date: Fri,  6 Jun 2025 15:45:00 -0700
Message-ID: <20250606224558.1117422-6-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606224558.1117422-1-e@freeshell.de>
References: <20250606224558.1117422-1-e@freeshell.de>
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

Use consistent lowercase hex prefix style in lib/*

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../external/mbedtls/library/ecp_curves_new.c | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/library/ecp_curves_new.c b/lib/mbedtls/external/mbedtls/library/ecp_curves_new.c
index 035b23a1b41..0275661887b 100644
--- a/lib/mbedtls/external/mbedtls/library/ecp_curves_new.c
+++ b/lib/mbedtls/external/mbedtls/library/ecp_curves_new.c
@@ -4644,17 +4644,17 @@ static const mbedtls_mpi_sint curve25519_a24 = 0x01DB42;
 
 /* P = 2^255 - 19 */
 static const mbedtls_mpi_uint curve25519_p[] = {
-    MBEDTLS_BYTES_TO_T_UINT_8(0xED, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0X7F)
+    MBEDTLS_BYTES_TO_T_UINT_8(0xED, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F)
 };
 
 /* N = 2^252 + 27742317777372353535851937790883648493 */
 static const mbedtls_mpi_uint curve25519_n[] = {
-    MBEDTLS_BYTES_TO_T_UINT_8(0XED, 0XD3, 0XF5, 0X5C, 0X1A, 0X63, 0X12, 0X58),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XD6, 0X9C, 0XF7, 0XA2, 0XDE, 0XF9, 0XDE, 0X14),
-    MBEDTLS_BYTES_TO_T_UINT_8(0X00, 0X00, 0X00, 0X00, 0x00, 0x00, 0x00, 0x00),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xED, 0xD3, 0xF5, 0x5C, 0x1A, 0x63, 0x12, 0x58),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xD6, 0x9C, 0xF7, 0xA2, 0xDE, 0xF9, 0xDE, 0x14),
+    MBEDTLS_BYTES_TO_T_UINT_8(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
     MBEDTLS_BYTES_TO_T_UINT_8(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10)
 };
 
@@ -4698,26 +4698,26 @@ static const mbedtls_mpi_sint curve448_a24 = 0x98AA;
 
 /* P = 2^448 - 2^224 - 1 */
 static const mbedtls_mpi_uint curve448_p[] = {
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFE, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00)
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
 };
 
 /* N = 2^446 - 13818066809895115352007386748515426880336692474882178609894547503885 */
 static const mbedtls_mpi_uint curve448_n[] = {
-    MBEDTLS_BYTES_TO_T_UINT_8(0XF3, 0X44, 0X58, 0XAB, 0X92, 0XC2, 0X78, 0X23),
-    MBEDTLS_BYTES_TO_T_UINT_8(0X55, 0X8F, 0XC5, 0X8D, 0X72, 0XC2, 0X6C, 0X21),
-    MBEDTLS_BYTES_TO_T_UINT_8(0X90, 0X36, 0XD6, 0XAE, 0X49, 0XDB, 0X4E, 0XC4),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XE9, 0X23, 0XCA, 0X7C, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF),
-    MBEDTLS_BYTES_TO_T_UINT_8(0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0XFF, 0X3F),
-    MBEDTLS_BYTES_TO_T_UINT_8(0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00)
+    MBEDTLS_BYTES_TO_T_UINT_8(0xF3, 0x44, 0x58, 0xAB, 0x92, 0xC2, 0x78, 0x23),
+    MBEDTLS_BYTES_TO_T_UINT_8(0x55, 0x8F, 0xC5, 0x8D, 0x72, 0xC2, 0x6C, 0x21),
+    MBEDTLS_BYTES_TO_T_UINT_8(0x90, 0x36, 0xD6, 0xAE, 0x49, 0xDB, 0x4E, 0xC4),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xE9, 0x23, 0xCA, 0x7C, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF),
+    MBEDTLS_BYTES_TO_T_UINT_8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F),
+    MBEDTLS_BYTES_TO_T_UINT_8(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
 };
 
 /*
-- 
2.49.0

