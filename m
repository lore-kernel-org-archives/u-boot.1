Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B970C48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 12:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E15587E95;
	Sat, 10 Feb 2024 13:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tiR3TO85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A3087E8C; Sat, 10 Feb 2024 13:46:58 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C320787E98
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 13:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2AE3C60A69;
 Sat, 10 Feb 2024 12:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C43D4C43394;
 Sat, 10 Feb 2024 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707569212;
 bh=Ohwut3Y23I+ygNzHyA/MjoH3vkaubVC84woyvFlJxQM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tiR3TO85b5jNX06wfJTXkImic78DGMfoLotYVuuVKUM0R+l1gupBP8y4Zbo55Aroa
 +ew8/PgGWyhGFb3pZ49svOZgKiI+6HfBYTNS10vbyuTUIJzDi5mIy4qnM4RjMDW812
 2CysEUsAt3Ov98f4BIxjuLiekRSK7eQRWaa1DXKZf54eaqWcPegnP0eilHONUuQItK
 fqwwH3tp/tlUC0JRLjZHqBb+ORFvBx1kAAXS259rVsigtnPnxH3/P7/B8pNTShuOcH
 kzMxVJ7dQ6dov9RQUeV+1G/BnN7RmDAvXW1MGrFUI2NYUJPc0Qa2orzNIt/5KlipB0
 rjnnTG++Sbs1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id ABA57C48BC0;
 Sat, 10 Feb 2024 12:46:52 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 10 Feb 2024 13:46:41 +0100
Subject: [PATCH v2 3/6] lib/charset: Map Unicode code points to CP437 code
 points 0-31
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-vidconsole-utf8-uefi-v2-3-88c03db60de2@jannau.net>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021; i=j@jannau.net;
 h=from:subject:message-id; bh=CR8sMkzJo1FBNuRC4CaQGiSe6wg9Ori7fMDenOHKlQI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtTjBVaq3DnBsjcM1eZLPzMvn6p569edz3NePP+Qd45p+
 SMeEXenjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABOJ/sbwv/79LGZxnhOMDTLz
 Ivmf9xnprLd9adVUnt26zW/avr0taowMF48eZ2Jaf/PcG34l3UtRX6029Cz6y/H1dc+XOobXJ+P
 iGQA=
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

Code page 437 uses code points 1-31 for glyphs instead of control
characters. Map the appropriate Unicode code points to this code points.
Fixes rendering of grub2's menu as EFI application using the
EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL on a console with bitmap fonts.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/charset.h                      |  2 +-
 include/cp1250.h                       | 12 ++++++++++--
 include/cp437.h                        | 12 ++++++++++--
 lib/charset.c                          |  9 ++++++---
 lib/efi_loader/efi_unicode_collation.c |  2 +-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/charset.h b/include/charset.h
index f1050c903d..348bad5883 100644
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

