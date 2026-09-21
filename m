Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7AFC982FA
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 23:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76BA580AEF;
	Mon, 21 Sep 2026 23:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sL9gBguS-ugm; Mon, 21 Sep 2026 23:08:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 76FC080A54
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790032084;
	b=FQBW9DW2cUnxsVVY5yvZoskpS1HwYMaLTR5bqDR4qY3tdQjpKGKiQlkhqYoTSp2Hb9wR
	 gI3u2D0nAns69f/Njhyv/nF8oI6fU2E3DQsDUc4Q+3yc76Retwrn0DcZ4yTeSyG89d1Uh
	 HdddUbH4N1cJBRYOiiQgzzaZ5wleLPaG843LDc5EUMH6BaQlne0fwngAnNc2Qwhqfdig6
	 93Qm8BP59y44mtNCrM8vaqPKlThd8Rz4c+oz43dmwxv7adUfUCSb7jChmznGlNcpiyinq
	 c/U4hRcHKmXoYuQTdvbmMJ5WWedlivRy6HtDEDAXUmm7d2AdD0nC3SISxoMefE8XViw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790032084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YncDQ22z606eS9biT9XUVkxquoPa7g66Kns049lsLVI=;
	b=VWq4Cd6lv6SLrIcMrmvj7I4D7vFqwvTGwQJI+zvkzvdsk7WohJhCLVPgsA+c4vYuvRBr
	 7WlHdkHyMBBLoj73BDr3RpLR6t1/SQHBGireVsBHF4cDRVrs+wYu+9Xk9oQqIV480DtSb
	 copw/KhS/5lujs8RXEfmpSjHTcZUaWqqUHVoPaYuKeQ03DcMkk9fT6fB7uv6VxYIxJi++
	 Nq9X+wsWUYUJfjCTtcVCYHTf7Sf8rtTs/pafsYclunKYezZciqu0OrRfiT7GqK6QMfM5q
	 Cv2KkBQI0QNwhVujf6eDXngYxh/eOW4AMqnKcrFMIElPtaKHed+8TOzTHgZH/141A/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790032084;
	bh=YncDQ22z606eS9biT9XUVkxquoPa7g66Kns049lsLVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXm5TVQ3A3V7Fstmri74AiyBIZcSEDykYc/FV0muPUKcGm4SWg2Dnb3S0u5XL2GTf
	 HTvmi06vBbbHDJfoHpF/BE4PKT8HX4Euck5kfbZUiuDS63Vj860ZUfoMwDz7iMzCxR
	 BDwf7MTU5ESJ0dfcY/8OZXr+B4TfPd8FGuaOiiApizSLkFKR+bzstaJdmN7ISqW+Sn
	 MI0YV/QKO9vtkjzEr3IlfXhEMSWPzMxYdtr/t1m6Vb3dJS3wjiU2zN1U2nfWOxhlUL
	 YL4GTQ35Mlszm/H7csZS6/33rgL4GvmkTkzU3Gq+6RE83JH9VtUp3ooTvzqd9K82RX
	 86O71Gzn64xYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76FC080A54;
	Mon, 21 Sep 2026 23:08:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DEB63A5
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B533401B1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id At20sQ-V6RUF for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 985FC401B0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790003618;
 b=WFzrGxLTu2nlRVKbgbsyeP9I/7IA6zTixUQia3mWJnNsIsOtiMu4SZ+wjKBWCxeNPEnE
 /469u1mJOItxavKiL1UqouedMhbKn6cyIcgjdL39BD02wfIGQ4DTd58702+VgUhMu83PN
 JBf6farruQpNwzaBkeLSYndxi8TK68lUpmi+E3/0rF5e59iNfa6mXINXyx2WSO5nzBpk4
 i5r2lLMswfitwwUFEBZtbJTRN5nW6tXh1yCt7inKbdGvmTjDaKQ1Q8PD/sEd8nY7hg917
 qlY/MCpCZlFzwUbjKlErwja1eRYbqwRskoez213xKM0wATyrvMa/KQamSBCX+19l6PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790003618;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=YncDQ22z606eS9biT9XUVkxquoPa7g66Kns049lsLVI=;
 b=AHRE5ThyMZxSvTTKM4CXiYDg1fhJJ3trC41B7r3i3aYYHMmKCYQoyObTlIwS4hvSVtvd
 i9RKLT5Nq2GFUfEosFmpX55GnvjYrBu8tN+bJ1pqaRhTGW3iEhMqfv/lTlSnz/qbk7iR4
 tk4O2x2WASlNnew60YaAX5TL11jPuhxCSEBVmGrsxWA988wJMTa3cmJsKbleuDAgJYH1H
 p+Pc7PeSDjUrPWkCocvlC7YpTnXR/to+VfqnyqEBpoSEsbC2VAxoO7HiE38h4rVmQuVon
 gxUyf4+yP1IAP3snAPg2LUwQZ85ClgcHX3JfAVAac2zQHp6yV1p4fP6jaMccao0MWDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=Hq4exVys; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=Hq4exVys
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 985FC401B0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yn
 cDQ22z606eS9biT9XUVkxquoPa7g66Kns049lsLVI=; b=Hq4exVysYM3He2/WSN
 6HR3CGmFFefXAnWWY04RPycr7FcGLJa1WnA7E8anf6dUquUBHjFyCCCptibz7CXU
 7HNoQMFGVF86rEO8utlVNBoB/yECwfBIqXDnAYXFqyZnm5ghYsYmWOE/89JS5zQ1
 NkusykJxqFe8Y/pq+RL4pBiXQ=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wBXPaWPSbFq0xQ+CA--.40149S3; 
 Mon, 21 Sep 2026 23:13:20 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH 1/2] lib: add memzero_explicit() and use it for the HMAC key
 schedules
Date: Mon, 21 Sep 2026 23:13:14 +0800
Message-ID: <20260921151315.1167-2-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921151315.1167-1-18102059357@163.com>
References: <20260921151315.1167-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXPaWPSbFq0xQ+CA--.40149S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr15tF4DZF1ruw47Cr43Awb_yoW7ZFWfpF
 ZxKFn8GF4DXr97WFyku3WxJ34Utan3GF17KF43uw1UZFW7Xr9aqFyUKFWYgr9xZr4vvryI
 ya1rGFy29r9rX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zETa0gUUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7RF9GGqxSZFLCwAA3a
X-Mailman-Approved-At: Mon, 21 Sep 2026 23:08:02 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

memset() is enough for correctness but not for security. When the buffer
being cleared dies right after the clear - a local that goes out of
scope, or a block that is freed - the store is dead as far as the
compiler is concerned, and dead store elimination removes it. The buffer
then keeps whatever it held, and the clear only looks like it happened.

sha1_hmac(), sha256_hmac() and the mbedTLS sha1 shim all build the HMAC key
schedule in local arrays and clear them with memset() before returning:

	lib/sha1.c:376-379	  k_ipad, k_opad, tmpbuf, ctx
	lib/sha256.c:310-314	  k_ipad, k_opad, tmpbuf, keybuf, ctx
	lib/mbedtls/sha1.c:95-98  k_ipad, k_opad, tmpbuf, ctx

Those buffers hold the caller's key: it is XORed into the two 64-byte
pads, so once the clear is gone the key can be read back out of the stack
frame with the padding constants (key[i] = k_ipad[i] ^ 0x36). In U-Boot
the caller is the TPMv1 code, where the key is the usage auth of a TPM
key, but the functions themselves are generic. That the intent is real is
not in doubt: the same tree already zeroizes a hash context with a
comment saying "In case it's sensitive" (lib/md5.c) and clears the SM3
schedule under "Zeroize sensitive information." (lib/sm3.c).

GCC deletes the four stores in lib/sha1.c and the five in lib/sha256.c from
-O1 up; -fdump-tree-dse-details names them:

	Deleted dead call: memset (&k_ipad, 0, 64);
	Deleted dead call: memset (&k_opad, 0, 64);

Add memzero_explicit(), which is a memset() the compiler may not remove,
and use it for those buffers. Plain memset() stays where a buffer is only
being initialised. This changes no behaviour: it is a clear that now
actually happens.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 include/linux/string.h |  7 +++++++
 lib/mbedtls/sha1.c     |  8 ++++----
 lib/sha1.c             |  8 ++++----
 lib/sha256.c           | 10 +++++-----
 lib/string.c           | 21 +++++++++++++++++++++
 5 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 986499dfc..f902b2b5a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -126,6 +126,13 @@ extern void * memchr(const void *,int,__kernel_size_t);
 void *memchr_inv(const void *, int, size_t);
 #endif
 
+/*
+ * memset() that the compiler may not remove. Use it for buffers that must
+ * not be left behind, where the buffer dies right after the clear: a local
+ * that goes out of scope, or a block that is freed.
+ */
+void memzero_explicit(void *s, size_t count);
+
 /**
  * memdup() - allocate a buffer and copy in the contents
  *
diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
index 2aee50377..c6b92fbe7 100644
--- a/lib/mbedtls/sha1.c
+++ b/lib/mbedtls/sha1.c
@@ -92,8 +92,8 @@ void sha1_hmac(const unsigned char *key, int keylen,
 	sha1_update(&ctx, tmpbuf, sizeof(tmpbuf));
 	sha1_finish(&ctx, output);
 
-	memset(k_ipad, 0, sizeof(k_ipad));
-	memset(k_opad, 0, sizeof(k_opad));
-	memset(tmpbuf, 0, sizeof(tmpbuf));
-	memset(&ctx, 0, sizeof(sha1_context));
+	memzero_explicit(k_ipad, sizeof(k_ipad));
+	memzero_explicit(k_opad, sizeof(k_opad));
+	memzero_explicit(tmpbuf, sizeof(tmpbuf));
+	memzero_explicit(&ctx, sizeof(sha1_context));
 }
diff --git a/lib/sha1.c b/lib/sha1.c
index be502c612..94f20fb40 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -373,10 +373,10 @@ void sha1_hmac(const unsigned char *key, int keylen,
 	sha1_update (&ctx, tmpbuf, 20);
 	sha1_finish (&ctx, output);
 
-	memset (k_ipad, 0, 64);
-	memset (k_opad, 0, 64);
-	memset (tmpbuf, 0, 20);
-	memset (&ctx, 0, sizeof (sha1_context));
+	memzero_explicit(k_ipad, 64);
+	memzero_explicit(k_opad, 64);
+	memzero_explicit(tmpbuf, 20);
+	memzero_explicit(&ctx, sizeof(sha1_context));
 }
 
 #ifdef SELF_TEST
diff --git a/lib/sha256.c b/lib/sha256.c
index c2e77c854..226af9b2d 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -307,11 +307,11 @@ int sha256_hmac(const unsigned char *key, int keylen,
 	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
 	sha256_finish(&ctx, output);
 
-	memset(k_ipad, 0, sizeof(k_ipad));
-	memset(k_opad, 0, sizeof(k_opad));
-	memset(tmpbuf, 0, sizeof(tmpbuf));
-	memset(keybuf, 0, sizeof(keybuf));
-	memset(&ctx, 0, sizeof(sha256_context));
+	memzero_explicit(k_ipad, sizeof(k_ipad));
+	memzero_explicit(k_opad, sizeof(k_opad));
+	memzero_explicit(tmpbuf, sizeof(tmpbuf));
+	memzero_explicit(keybuf, sizeof(keybuf));
+	memzero_explicit(&ctx, sizeof(sha256_context));
 
 	return 0;
 }
diff --git a/lib/string.c b/lib/string.c
index dbf2ce340..8ccb7c17e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -808,3 +808,24 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 	return check_bytes8(start, value, bytes % 8);
 }
 #endif
+
+/**
+ * memzero_explicit - clear a buffer that the compiler may not remove
+ * @s: the buffer to clear
+ * @count: the number of bytes to write
+ *
+ * memset() is enough for correctness but not for security. When the buffer
+ * being cleared dies right after the clear - a local that goes out of scope,
+ * or a block that is freed - the store is dead as far as the compiler is
+ * concerned and dead store elimination removes it, so the buffer keeps
+ * whatever it held. The barrier below tells the compiler that the memory may
+ * be read, which stops that.
+ *
+ * Use it for key material and for any other data that must not outlive its
+ * use; keep plain memset() for buffers that are only being initialised.
+ */
+void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
-- 
2.43.0

