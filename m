Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DBDCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C32740D94;
	Fri,  2 Oct 2026 16:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5UkVVnU9G4_Q; Fri,  2 Oct 2026 16:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 74AC040D7A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959635;
	b=bPM1tbhoS7VBCb3G44YsU7rip4Ns5zb7ZwQ3R2T97qcfLvgLzxEZdI2xT3rk0NYSEBFV
	 GIXkG+KsfpVzcddJC6FubxbxPxEE1pJtvR+LN/0ufCXGgmHhVlybbcy7vZaRqhDkWxBm5
	 Babvxc6/Mv85D3hLFwfA+tAcC4A6kFOe3r4C9bK9eHERHnME0lplsvleL+88QQbQQ0Ig7
	 ZzIIeoK90UqGMKEBe17w3FYBSuA5z0cosgTJwqRf+xSsnbmwJe/JSrWr10PqnFeeA44MS
	 +Wip0f0xVzuODDKeB6lZkQ/OzI0vDlNE65kUGKtYrr9LOciqEpy6iSh/ecmjnLineUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TVssLY57V0feOx4jem1L0HFOnmQNXElMSjNe487TMNg=;
	b=ZR7rC9JhH4rIbcb0pWJAUm+yMDoZRfeueEOWosfvWM6FCTbY/S63nRj2Zdh8hkbcKAAG
	 kJakbF4Qv/VGDmpB9moJuJv8PZo/gsgOx/mg0HYMulG0vr56UxMYenig4Aj9YRYYoLf1L
	 lQtV0/dyNSk1LN7wRw2c8fl6GKrOxijiKlhAWlZen+c/JkrrDUa0UHn5OWt4e6kAdIVTz
	 yaTAtrD8mMmUdmsfGixK9Z74yi6MiWo1Ew/IyGc3S0EcQ/lBc4wgLLoDUzOMIOptYT34V
	 tVruwcGmH3hAuiYDvKUVhZ12dQ0EI7sUXo4rPAqjMKRuB21mKeBLJmHhbXWE6oD6S2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959635;
	bh=TVssLY57V0feOx4jem1L0HFOnmQNXElMSjNe487TMNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MiCPSuXIzkOAvAGpW49F6HwSejkGVWGaRGn1d91y9YMv7uwBKevq4ErvasuUgaP4j
	 GNfvAL+PyfKjESs45QWQL4UALm3dN3Y7HMF3iEd72dz/ZAA89TGInWDXv8kT2zzgXm
	 KOYtDkf0U+QoBAria9YDv2ZX2kkEvWY+5iDJvKXnHHkHcxVqDRZIAJcN2AvokPeypx
	 ClhfAqooeUuM2dKicMPkFPUeK2iwIZ7YjuH52A47i8dP5/Nzevm6p0C0ADyd+CUGU9
	 Wf6QlWF2+4pcd3kW8hCCBmaIzrD3DIaO+kbWGty818rl1HWwdSjwqRBbJCadtJMRrE
	 1X4KQDHgQrYlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74AC040D7A;
	Fri,  2 Oct 2026 16:47:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3910732F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AE6B8105C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YwEnoMQy2Fn for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3F8A580D85
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790957784;
 b=qYWymog7HJsSc/y1hgHxLOFUUebzeneLMI4CJcDXA4bCgWl43W6cvFuAcwrREZo3PLBu
 iDG+RolDALIOHJnnQ5u6cHwY5/qS4Sai+mE3L41lATB+0leXFhl+PDC5nQCUXDek8Wway
 Nzfq0KjHh27EcGwzhqYS9VgAcd31+9jCeZ0+fT6vOU7vUxnGQS9nO8o0PrFGXmsq45flk
 fOQL5urHQH7uqc/pxj6RbOboA64wp1ePVLp/MzwqX+uIpDbWHAvARztJEleOg05pp7ud2
 ZeA7j0wTms54jh+n3uw0B8tnyXmk7aPd+7pNNalKctcumCrQp8fgbVY59e7kvU4itSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790957784;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=TVssLY57V0feOx4jem1L0HFOnmQNXElMSjNe487TMNg=;
 b=lG/Exw2CzmZUI9gaODWakOrWBXC2tzJ1ycFlPqGcDznYqLVzguAa7RUnZOdknYNyLmUd
 y3Nz1CvheIUrL2km7KkpF/eBgCATVMPoi5n3fJojZpsY4AKr/qV16fsD5lMc9fiVRN+fW
 NARU2EEiCJdZOnSmZxBoCOSt0MwF/qYho3CiO+Sej/SxwOTWmAl6ZXAvmmmFK8IUdwGqu
 PIDBxri3gnGNbhSu3KDmEp3TOYRTEPnOHk/RxgO+IkFPj8YNPbObdBCpXDiTpKFer0aiD
 OGYI75SOWQDe4zI7E4+ztK2zq7YDZSaaNV9hfhPqQXX0MVmTZ4ST5Rjhy0O/YUlmx+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=SHstqRVT; 
 arc=none smtp.remote-ip=117.135.210.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=SHstqRVT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F8A580D85
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TV
 ssLY57V0feOx4jem1L0HFOnmQNXElMSjNe487TMNg=; b=SHstqRVTlXBxjc3jVg
 CmjM86F9jjer6l8Rwvlytkpisy6MX6P46T7makkrX+Y8tNMU3wuw713+ntzExfZR
 aJHpQUmJCx6MzWYSmDJcgfEz8esn0kwwXvNwlZEjf4G2nPXC98Dg38g3nh/lyUfO
 rN+sAnO69ZdMwIBPA39n/N0KY=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wDXvWbI2L9qGvUkCA--.16429S3; 
 Sat, 03 Oct 2026 00:16:09 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v2 1/2] lib: add memzero_explicit() and use it for the HMAC
 key schedules
Date: Sat,  3 Oct 2026 00:16:06 +0800
Message-ID: <20261002161607.688-2-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002161607.688-1-18102059357@163.com>
References: <20261002161607.688-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXvWbI2L9qGvUkCA--.16429S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1kZryUKF13uF4UurWxWFg_yoWrAF13pF
 ZrKFyrJF4UJrn2gFyFkw1xAr15Gws3GF1UKFW5Zw18JFW7X34ktF1j9FWFgr9xZr4vva4I
 kayrCFyj9F9rX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zESoGgUUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7QnyjWq-2Mlc7AAA3v
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:13 +0000
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

sha1_hmac(), sha256_hmac() and the mbedTLS sha1 shim build the HMAC key
schedule in local arrays and clear them with memset() just before they
return. The buffers die with the frame, so the stores are dead and GCC
removes them from -O1 up, leaving the caller's key on the stack as
0x36 ^ key and 0x5c ^ key.

Those functions are generic; in U-Boot the caller is the TPM 1.2 code,
where the key is the usage auth of a TPM key.

Take memzero_explicit() from the Linux kernel, where it is a static inline
in include/linux/string.h, and use it for the three key schedules. Plain
memset() stays where a buffer is only being initialised.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 include/linux/string.h | 21 +++++++++++++++++++++
 lib/mbedtls/sha1.c     |  8 ++++----
 lib/sha1.c             |  8 ++++----
 lib/sha256.c           | 10 +++++-----
 4 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 986499dfc..a51b39e5d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/compiler.h>	/* for barrier_data() */
 
 #ifdef __cplusplus
 extern "C" {
@@ -106,6 +107,26 @@ extern void kfree_const(const void *x);
 
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
+
+/**
+ * memzero_explicit - Fill a region of memory (e.g. sensitive
+ *		      keying data) with 0s.
+ * @s: Pointer to the start of the area.
+ * @count: The size of the area.
+ *
+ * Note: usually using memset() is just fine (!), but in cases
+ * where clearing out _local_ data at the end of a scope is
+ * necessary, memzero_explicit() should be used instead in
+ * order to prevent the compiler from optimising away zeroing.
+ *
+ * memzero_explicit() doesn't need an arch-specific version as
+ * it just invokes the one of memset() implicitly.
+ */
+static inline void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
 #endif
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
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
-- 
2.43.0

