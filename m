Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C430DC25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D2E880A1;
	Thu,  9 May 2024 16:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kygEi6IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2A98811C; Thu,  9 May 2024 16:38:16 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD5187FD7
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78f049ddd7dso59769885a.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715265492; x=1715870292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsXUyduIsiybDRSmNqaNgdd7zCBc1LDlv1tDwe3Y2z0=;
 b=kygEi6ICs/POptfjFOqLBfRaiRr1XZNWGwNxCM3xwZUBO1dHOqPXEVlTvD4+iQwYcV
 Pb38wPxUro4TSpFeeNObfoNojoEkMzX5UQs0sz72hfFQylwNXR8V+aLA20qoA1R0ca8c
 ySlfYmvvigRwKDNQThIPuzzXNg1tO3G7ZGg4+yV73OTopWtD5J68qBeq0fVfC/uyVC5c
 MzBsUPEYb7J4NSLEkEks3wwFS0BcGTweTmiIgyRPPQ/n9DNauuV+hIpC80vE81DS2eUY
 ckzULmiL/okMu+H6ZYpjINz3+3/U5MYf+VTxoiexBzn1Vvw1Sn5L40t1lvIJnL4xYaAq
 26CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715265492; x=1715870292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsXUyduIsiybDRSmNqaNgdd7zCBc1LDlv1tDwe3Y2z0=;
 b=RkYrshrJQu4RSkICrSiM97a5cz7cQgJQIsCOn0ioKKfYy87ZoEWCUuQTlw0tLF6mw7
 0SWFBeAXuZ90ze6KFWnZXEPNd/Idu/9gpbnIpV5kk8CZe/+JKHekxZ2LOT+EVMHuSH80
 EOyPyOx2IgcHdDgWqEsJrGPrzl5hQPFzcem4LXNcSR7haBOFnbLIZv81QQVHm0QJGqVb
 ofp+Xjftf94UE2kkXXl8kni4w6RVUzyDg4Jwhe9gtHUEEtGlXVCOXAwQfoQ1ENIAB1PK
 qwyScizj/FArcFB/wfKsrHoYgskuU8IUjpcfrTrruv9pA8FbxeD1bAhW6Qh8Kw8gvfKe
 Y9iQ==
X-Gm-Message-State: AOJu0YwwdPkPWvCdRqdRjKpaZwDcGjUb6WNBdUpGy1ZWl5SjAN524bPL
 CZhBRuKehtHZ6PVMKo07M349zprSZkjIsC7y2cSB4IPMU6z87iqMD/FZd/i+pHKUokingoq3g3i
 R
X-Google-Smtp-Source: AGHT+IG4EObKn2k2k6rd/oxICBo1JwGUjF5j4/W2EehHVOy4KJgO6k8y6LbGHYyFzAbmgmGk1Vw2Kw==
X-Received: by 2002:a05:620a:4606:b0:790:ec9c:cc7d with SMTP id
 af79cd13be357-792b27b2a6bmr653715585a.14.1715265492676; 
 Thu, 09 May 2024 07:38:12 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf275b07sm74563685a.24.2024.05.09.07.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:38:12 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 3/4] md5: Use typedef for MD5 context
Date: Thu,  9 May 2024 07:37:40 -0700
Message-Id: <20240509143743.1496210-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509143743.1496210-1-raymond.mao@linaro.org>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
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

Use of typedef is beneficial for porting with other crypto libs
without changing the API callers.
Secondly, it is for the code consistency with other digest libs.
SHA1, SHA256 and SHA512 are all using typedef for their context.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 drivers/crypto/hash/hash_sw.c |  8 ++++----
 include/u-boot/md5.h          | 10 +++++-----
 lib/md5.c                     | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
index d8065d68ea4..a5033677930 100644
--- a/drivers/crypto/hash/hash_sw.c
+++ b/drivers/crypto/hash/hash_sw.c
@@ -51,17 +51,17 @@ static void hash_finish_crc32(void *ctx, void *obuf)
 /* MD5 */
 static void hash_init_md5(void *ctx)
 {
-	MD5Init((struct MD5Context *)ctx);
+	MD5Init((MD5Context *)ctx);
 }
 
 static void hash_update_md5(void *ctx, const void *ibuf, uint32_t ilen)
 {
-	MD5Update((struct MD5Context *)ctx, ibuf, ilen);
+	MD5Update((MD5Context *)ctx, ibuf, ilen);
 }
 
 static void hash_finish_md5(void *ctx, void *obuf)
 {
-	MD5Final(obuf, (struct MD5Context *)ctx);
+	MD5Final(obuf, (MD5Context *)ctx);
 }
 
 /* SHA1 */
@@ -159,7 +159,7 @@ static struct sw_hash_impl sw_hash_impl[HASH_ALGO_NUM] = {
 		.init = hash_init_md5,
 		.update = hash_update_md5,
 		.finish = hash_finish_md5,
-		.ctx_alloc_sz = sizeof(struct MD5Context),
+		.ctx_alloc_sz = sizeof(MD5Context),
 	},
 
 	[HASH_ALGO_SHA1] = {
diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index d61364c0ae3..c465925ea8d 100644
--- a/include/u-boot/md5.h
+++ b/include/u-boot/md5.h
@@ -10,18 +10,18 @@
 
 #define MD5_SUM_LEN	16
 
-struct MD5Context {
+typedef struct MD5Context {
 	__u32 buf[4];
 	__u32 bits[2];
 	union {
 		unsigned char in[64];
 		__u32 in32[16];
 	};
-};
+} MD5Context;
 
-void MD5Init(struct MD5Context *ctx);
-void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len);
-void MD5Final(unsigned char digest[16], struct MD5Context *ctx);
+void MD5Init(MD5Context *ctx);
+void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
+void MD5Final(unsigned char digest[16], MD5Context *ctx);
 
 /*
  * Calculate and store in 'output' the MD5 digest of 'len' bytes at
diff --git a/lib/md5.c b/lib/md5.c
index faf3f78ab1e..34343cf8e23 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -55,7 +55,7 @@ byteReverse(unsigned char *buf, unsigned longs)
  * initialization constants.
  */
 void
-MD5Init(struct MD5Context *ctx)
+MD5Init(MD5Context *ctx)
 {
 	ctx->buf[0] = 0x67452301;
 	ctx->buf[1] = 0xefcdab89;
@@ -71,7 +71,7 @@ MD5Init(struct MD5Context *ctx)
  * of bytes.
  */
 void
-MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
+MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
 {
 	register __u32 t;
 
@@ -120,7 +120,7 @@ MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
  * 1 0* (64-bit count of bits processed, MSB-first)
  */
 void
-MD5Final(unsigned char digest[16], struct MD5Context *ctx)
+MD5Final(unsigned char digest[16], MD5Context *ctx)
 {
 	unsigned int count;
 	unsigned char *p;
@@ -269,7 +269,7 @@ MD5Transform(__u32 buf[4], __u32 const in[16])
 void
 md5 (unsigned char *input, int len, unsigned char output[16])
 {
-	struct MD5Context context;
+	MD5Context context;
 
 	MD5Init(&context);
 	MD5Update(&context, input, len);
@@ -286,7 +286,7 @@ void
 md5_wd(const unsigned char *input, unsigned int len, unsigned char output[16],
 	unsigned int chunk_sz)
 {
-	struct MD5Context context;
+	MD5Context context;
 #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
 	const unsigned char *end, *curr;
 	int chunk;
-- 
2.25.1

