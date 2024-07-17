Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B725C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA5788A6E;
	Wed, 17 Jul 2024 16:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="GJkUmgQS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RckRbC1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E5788A6E; Wed, 17 Jul 2024 16:30:01 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C336388A6E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 0057B114013D;
 Wed, 17 Jul 2024 10:29:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 10:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226598;
 x=1721312998; bh=bfs7OfeR6QNgviHqAKNfvPTwrOd41fUXzV7fYHyvZSk=; b=
 GJkUmgQSBvrgQYmMS4wNumdwpf9NxXces3/D2nwSHRpC9lASM6ANBrJkGmUlAmaQ
 2JHcHP4Ap8EJbuHUdid37avr8vdCN27bOquyfekqWj1fsaV85n5ae8BNMKi7P1JZ
 xI6Uu5zdeyBdKKnoHdD87Ka3UjFIo+1AqT7M9Isu1o6zvHT8kcjI7DL+uwV1ISt5
 iHBS7P+QPVyUDMSS6zN2wnHXFs02ah3kU+umaSjo+vrE4iyAs2pDS9oU7wPpvxhF
 PsZWY8YIqYloq4iQ2aTVQ6wco8s8is0jbq6b0pD0gsfW8O1DawaJTp1nwxLjUiOW
 ETwgPM4T+ufvSAN9lNaOwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226598; x=
 1721312998; bh=bfs7OfeR6QNgviHqAKNfvPTwrOd41fUXzV7fYHyvZSk=; b=R
 ckRbC1HRnmOOGre6nVGjeVZDcNG+PTx2+3/p9Shwt2UIu1+MKLLbkVjiVTqzQKMU
 efwEH7osxj7Cii/9d3MboVe4raLenOAYzjdi6E1yiZZ/ab3sRsu5iVas+Qa2TZ9f
 3zUXnKrTQ8ZsxLJsg/pMwKH3BExlYtEhCGVKjbTvz/uANT48EbLO7ZlEhxJfSvEz
 L53tGAj7usTqN2XuGmxBD/rUx3PzwR/EY24aoBq3GkYd17tUnECT6gYyvo9MAd5p
 poy4WBoFAzhoT7Kwl2fNsOmClp2dlCA6svpGCwF3nkNciHwiF1kL/JGxYWu9Mke+
 80pnYmyPxOFsc/h4+qtow==
X-ME-Sender: <xms:ZdWXZuclL9EOU6YmQGw_ky64yvEM-ipJPuftRZwuSFx8sZlCS2ardg>
 <xme:ZdWXZoPJCvhsJgdM9Cxnwf9LUPfd3R4HADrL01Snk8OLgVN-VujrDEBoTtK-sk6KO
 4S-a9q8HE2By7SHhjc>
X-ME-Received: <xmr:ZdWXZvjWx6PwMPH1Mr0tOhZMPTZVAfiiq_fKvDA90-ToUWJJsXSu3mT9fSBJ9vNWOZxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ZdWXZr_DvMj8xo0uInwtFE_kPgZA3--jJuwsrqKGxuYaXDyxSoepUA>
 <xmx:ZdWXZqu2lGLYdvRTcOH1iMpmReNxCV2ChKiWvF0erj8CVhpT2GxarQ>
 <xmx:ZdWXZiEF-sVPatXVMmdQsEfAAZ2sS6wa3Mp29btAxVArAueExxvVAA>
 <xmx:ZdWXZpNmGbeWStdxjIgm75ncfJYQhRrXmM2fZLBYv8Gfwp6IiMrNpg>
 <xmx:ZtWXZn-6FXKzIupciAHf7slEyWiveN18BmAVVJ7NBXs2Us277Gt43VI3>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:55 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:18 +0800
Subject: [PATCH 07/18] lib/charset & efi: Fix possible unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-7-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=UoV5OA0KJnYMPxSIQrujV7NIZW/WfG8j4e2EHFdwG1s=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10aD0xbnSpl8fFm8D6r7zVF/B1r1pZPfyTJ1rdue
 vgT1kCpjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhI+2aG/8ltq999W2NnfY7r
 Rtg6k9eMTvoTPs4SMXqs67thZ2cZWz3D/5yYyE+tEb3yFbWuFbt5JedVqDmvudKhy8kX1N8g2Hy
 MBQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

As per armv7 arch spec, for A-profile CPU if translation is disabled,
then the default memory type is Device(-nGnRnE) instead of Normal,
which requires that alignment be enforced.

This means in some cases we can't perform unaligned access even after
allow_unaligned is called.

We do have many platforms that didn't have translation enabled in U-Boot,
and QEMU started to enforce this since 9.0.

Fix by using unaligned access helper for UTF-16 memory read/write to
ensure we don't do any unaligned access in U-Boot.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 lib/charset.c                    | 21 ++++++++++++---------
 lib/efi_loader/efi_device_path.c | 11 ++---------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/lib/charset.c b/lib/charset.c
index 182c92a50c48..af5f3ad16d9b 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -11,6 +11,7 @@
 #include <efi_loader.h>
 #include <errno.h>
 #include <malloc.h>
+#include <asm/unaligned.h>
 
 /**
  * codepage_437 - Unicode to codepage 437 translation table
@@ -215,7 +216,7 @@ s32 utf16_get(const u16 **src)
 		return -1;
 	if (!**src)
 		return 0;
-	code = **src;
+	code = get_unaligned_le16(*src);
 	++*src;
 	if (code >= 0xDC00 && code <= 0xDFFF)
 		return -1;
@@ -242,12 +243,12 @@ int utf16_put(s32 code, u16 **dst)
 	if ((code >= 0xD800 && code <= 0xDFFF) || code >= 0x110000)
 		return -1;
 	if (code < 0x10000) {
-		**dst = code;
+		put_unaligned_le16(code, *dst);
 	} else {
 		code -= 0x10000;
-		**dst = code >> 10 | 0xD800;
+		put_unaligned_le16(code >> 10 | 0xD800, *dst);
 		++*dst;
-		**dst = (code & 0x3ff) | 0xDC00;
+		put_unaligned_le16((code & 0x3ff) | 0xDC00, *dst);
 	}
 	++*dst;
 	return 0;
@@ -392,7 +393,7 @@ int __efi_runtime u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
 	int ret = 0;
 
 	for (; n; --n, ++s1, ++s2) {
-		ret = *s1 - *s2;
+		ret = get_unaligned_le16(s1) - get_unaligned_le16(s2);
 		if (ret || !*s1)
 			break;
 	}
@@ -403,7 +404,7 @@ int __efi_runtime u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
 size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
 {
 	size_t i;
-	for (i = 0; count-- && in[i]; i++);
+	for (i = 0; count-- && get_unaligned_le16(in + i); i++);
 	return i;
 }
 
@@ -417,8 +418,10 @@ u16 *u16_strcpy(u16 *dest, const u16 *src)
 	u16 *tmp = dest;
 
 	for (;; dest++, src++) {
-		*dest = *src;
-		if (!*src)
+		u16 code = get_unaligned_le16(src);
+
+		put_unaligned_le16(code, dest);
+		if (!code)
 			break;
 	}
 
@@ -463,7 +466,7 @@ uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size)
 	uint32_t code_high = 0;
 
 	while (size--) {
-		uint32_t code = *src++;
+		uint32_t code = get_unaligned_le16(src++);
 
 		if (code_high) {
 			if (code >= 0xDC00 && code <= 0xDFFF) {
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 0f684590f22a..97a3200574a1 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -18,7 +18,7 @@
 #include <efi_loader.h>
 #include <part.h>
 #include <uuid.h>
-#include <asm-generic/unaligned.h>
+#include <asm/unaligned.h>
 #include <linux/compat.h> /* U16_MAX */
 
 /* template END node: */
@@ -873,13 +873,6 @@ static void path_to_uefi(void *uefi, const char *src)
 {
 	u16 *pos = uefi;
 
-	/*
-	 * efi_set_bootdev() calls this routine indirectly before the UEFI
-	 * subsystem is initialized. So we cannot assume unaligned access to be
-	 * enabled.
-	 */
-	allow_unaligned();
-
 	while (*src) {
 		s32 code = utf8_get(&src);
 
@@ -889,7 +882,7 @@ static void path_to_uefi(void *uefi, const char *src)
 			code = '\\';
 		utf16_put(code, &pos);
 	}
-	*pos = 0;
+	put_unaligned_le16(0, pos);
 }
 
 /**

-- 
2.45.2

