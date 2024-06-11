Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D17C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE6B887DF;
	Tue, 11 Jun 2024 23:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="0Sx+xL5Q";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+wiXBF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06843887F6; Tue, 11 Jun 2024 23:04:46 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44FC8839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id D65141800146;
 Tue, 11 Jun 2024 17:04:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139881;
 x=1718226281; bh=otwHIc9B9p7Ai/6XPzCxqvv2fWhO9Xt5MMSb3eVmkQc=; b=
 0Sx+xL5QoMWiBkYUSeMCMKDzX8/Gae2yH3B7aebE+GLC03FXuvAnnrv20rwJfGoa
 3w0yTh16qncxwTyCky07N/5yOL/VlvJWS3N8DS2DMZLFVJ+dTvvAe5UqHYFUeqSa
 JOHhPZxMSGynvTIfhlItkPNIG03PNPmdVqwCFGrlDMZ2lDO8tW3ttyxYMH0Z9DW3
 ecJFdoeBqvh4+AuGaxr0ZDnPSbhatTR9v8TF9EJUbLH1dSyExmzQW3Cz5oM2Qpcv
 hM6+3wH60c2aAsxDRjySWxc80+zk2UPrJsqTtPA7oR3vPMXjZ2obpVptzVG7KfZE
 /l1wL7c1Ul06gtsdTqb6Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139881; x=
 1718226281; bh=otwHIc9B9p7Ai/6XPzCxqvv2fWhO9Xt5MMSb3eVmkQc=; b=A
 +wiXBF+La/YBnXkt0E9jEM1SYgfhjkmHe5Bg/irTJYehZ5hoh+oi5bedvR4PyJ7J
 PhaAuKrBXVJgdrLWMMh7JPmAviNHYc73ZuafMPJCX0T+8Os3hkxsFHLbOnlOoSnQ
 ngdVKgFOn4Yzu0DSm8/3OMwzOyR4DucHhyWV77XffiSJtIWrKogijDemJblGCUXg
 NynKmTdk8TSJc6CSt28j4qmxJMMU5S0OFfBV/0qrGRSI6BerqubOqzkqihrd0GCw
 v/3nCmDS0J4DZ7EqrqVf2iyp764TRuMGp6NM5uWlA4H9TRU2Ycy60IsXBW5ckfvs
 lyj+ZibwNXkrJ02of0xXA==
X-ME-Sender: <xms:6btoZpNezjMSpNi7qXkHqkysOIujAMJiP4RmlbMBmiz0czHTNrm_2g>
 <xme:6btoZr9yUGm-ztKWChyuEWbbr-F4lJXzkr5QbNbsJA9E632JjF_nvBz5cSiTKJxY0
 0Bn00p9TbSZNdKep20>
X-ME-Received: <xmr:6btoZoTNzH8cswzX71uQKZ0kfEyvzXC7DRnqpPGGPk__g_9FtOUdAJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:6btoZluFa517KT77mpn1U-d-Cy0qbJHDB11_3vlLgI7on-1XD-J7HA>
 <xmx:6btoZhdOv7a-mhPYQo98m-TRLxY9slEYynFtco9gaSsNH1y-xS1_WQ>
 <xmx:6btoZh2Gtx-pwY7zEdgXsWn8GMoe1am5sY72fYN-zLgOCDIrHhBSKw>
 <xmx:6btoZt-5-552yJ8MTy6fNt2PXkZE6TGhFfVw_Hjc5L5S-F3T69K48Q>
 <xmx:6btoZgwfGuTa1SKGpNk98P8cKSd-RrYX4X3PSUXU8_63QSNhiU6rCuQo>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:10 +0100
Subject: [PATCH 11/20] lib/charset & efi: Fix possible unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-11-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6307XR2ycUwCLiIRQ6xp2yh9Z3ivm0vghlJNEGyLpJg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WetSs1nm+l7RTDNPqEYwxSzQnz5pZTi/j2fzF7KO
 PUqeJt1lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwEQmVDMyrL7gUyhpFBzq1L/D
 OO6R3PRdn54UyfHeiskJ3PtRsi9gMsNfUc6Vs12zZ2/YUy589InDdffPC1KWGCs1HVO3FFGecWM
 HCwA=
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
index aec224d84662..481f9effdb6d 100644
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
@@ -867,13 +867,6 @@ static void path_to_uefi(void *uefi, const char *src)
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
 
@@ -883,7 +876,7 @@ static void path_to_uefi(void *uefi, const char *src)
 			code = '\\';
 		utf16_put(code, &pos);
 	}
-	*pos = 0;
+	put_unaligned_le16(0, pos);
 }
 
 /**

-- 
2.43.0

