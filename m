Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE03C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F39187A0B;
	Wed, 17 Jan 2024 23:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mhcq+jG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1948187B30; Wed, 17 Jan 2024 23:24:43 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C98887AEC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 26D36CE1D68;
 Wed, 17 Jan 2024 22:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61F21C43394;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530274;
 bh=O3Y6mXwkMS1vFMCpsv0b78t+j3Ra2FeF3BuIt2aGebE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=mhcq+jG1u0wVNYGQjx1xCoIm9Ga+ebMRE/QXXxFoVpz/O5j3x3ivc65NxNSE2YkvX
 mi1GCJp957cfE4FxcIbFUV/ISvRyqOJIxGhrLGojr6leM4805lH5HLd7uP9W1wSxMx
 6aQm9bjEVZsIBum5XSld9zGWVr1yVjca53hB6mu3H6XZXFp/kmwN0o3bdUL+v1eC+l
 Yv3MftqZxxkzfoqqB2MNJ2+nlFlpXgZEGdDjtQmXHp68IDRytqxscl2F5gyCMGLIHR
 qLelkClFaDclcE5hLvxrd+jCt+ZAXW8yqWOsSkbDlkFic278+Mmzxjy4M8EQ9oxeLj
 6VZ6tmtfoc1cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4A404C47DB3;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:24:29 +0100
Subject: [PATCH RFC 3/6] lib/charset: Map cp437 low chars (0x01 - 0x1f)
 from unicode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-vidconsole-utf8-uefi-v1-3-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3963; i=j@jannau.net;
 h=from:subject:message-id; bh=+oAhNnSjkUtN5/UJBFWcC8rmhHfrdjvs7JZOS2V5hgU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVwQsulTed6f2uWndwicqTrGMyPb6dRR9MrZ/tvWEgo
 PWjIrCzo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQifzEyfEpeM0t44wVer3sm
 Jju+xlwSfF0SID8nN91HZznPGz1xHUaGBROD046IZuce0Gbfw/zX6YFzucyGO41OfhHvrjfnBMt
 zAAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Add mappings for code points 1 - 31 as those code points in code page 437
are graphics.
Thios fixes rendering issues of various EFI boot loaders (grub2,
sd-boot, ...) using EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/charset.h                      |  2 +-
 include/cp1250.h                       | 12 ++++++++++--
 include/cp437.h                        | 12 ++++++++++--
 lib/charset.c                          |  9 ++++++---
 lib/efi_loader/efi_unicode_collation.c |  2 +-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/charset.h b/include/charset.h
index 714382e1c1..c51c29235f 100644
--- a/include/charset.h
+++ b/include/charset.h
@@ -16,7 +16,7 @@
 /*
  * codepage_437 - Unicode to codepage 437 translation table
  */
-extern const u16 codepage_437[128];
+extern const u16 codepage_437[160];
 
 /**
  * console_read_unicode() - read Unicode code point from console
diff --git a/include/cp1250.h b/include/cp1250.h
index adacf8a958..b762c78d9f 100644
--- a/include/cp1250.h
+++ b/include/cp1250.h
@@ -1,10 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 
 /*
- * Constant CP1250 contains the Unicode code points for characters 0x80 - 0xff
- * of the code page 1250.
+ * Constant CP1250 contains the Unicode code points for characters 0x00 - 0x1f
+ * and 0x80 - 0xff of the code page 1250.
  */
 #define CP1250 { \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
+	0x0000, 0x0000, 0x0000, 0x0000, \
 	0x20ac, 0x0000, 0x201a, 0x0000, \
 	0x201e, 0x2026, 0x2020, 0x2021, \
 	0x0000, 0x2030, 0x0160, 0x2039, \
diff --git a/include/cp437.h b/include/cp437.h
index 0b2b97132e..5093130f5e 100644
--- a/include/cp437.h
+++ b/include/cp437.h
@@ -1,10 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 
 /*
- * Constant CP437 contains the Unicode code points for characters 0x80 - 0xff
- * of the code page 437.
+ * Constant CP437 contains the Unicode code points for characters 0x00 - 0x1f
+ * and 0x80 - 0xff of the code page 437.
  */
 #define CP437 { \
+	0x0000, 0x263a, 0x263b, 0x2665, \
+	0x2666, 0x2663, 0x2660, 0x2022, \
+	0x25d8, 0x25cb, 0x25d9, 0x2642, \
+	0x2640, 0x266a, 0x266b, 0x263c, \
+	0x25ba, 0x25c4, 0x2195, 0x203c, \
+	0x00b6, 0x00a7, 0x25ac, 0x21a8, \
+	0x2191, 0x2193, 0x2192, 0x2190, \
+	0x221f, 0x2194, 0x25b2, 0x25bc, \
 	0x00c7, 0x00fc, 0x00e9, 0x00e2, \
 	0x00e4, 0x00e0, 0x00e5, 0x00e7, \
 	0x00ea, 0x00eb, 0x00e8, 0x00ef, \
diff --git a/lib/charset.c b/lib/charset.c
index 5e4c4f948a..1f8480150a 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -16,7 +16,7 @@
 /**
  * codepage_437 - Unicode to codepage 437 translation table
  */
-const u16 codepage_437[128] = CP437;
+const u16 codepage_437[160] = CP437;
 
 static struct capitalization_table capitalization_table[] =
 #ifdef CONFIG_EFI_UNICODE_CAPITALIZATION
@@ -517,9 +517,12 @@ int utf_to_cp(s32 *c, const u16 *codepage)
 		int j;
 
 		/* Look up codepage translation */
-		for (j = 0; j < 0x80; ++j) {
+		for (j = 0; j < 0xA0; ++j) {
 			if (*c == codepage[j]) {
-				*c = j + 0x80;
+				if (j < 0x20)
+					*c = j;
+				else
+					*c = j + 0x60;
 				return 0;
 			}
 		}
diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi_unicode_collation.c
index c4c7572063..4b2c52918a 100644
--- a/lib/efi_loader/efi_unicode_collation.c
+++ b/lib/efi_loader/efi_unicode_collation.c
@@ -257,7 +257,7 @@ static void EFIAPI efi_fat_to_str(struct efi_unicode_collation_protocol *this,
 	for (i = 0; i < fat_size; ++i) {
 		c = (unsigned char)fat[i];
 		if (c > 0x80)
-			c = codepage[c - 0x80];
+			c = codepage[c - 0x60];
 		string[i] = c;
 		if (!c)
 			break;

-- 
2.43.0

