Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B73C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9454288486;
	Thu, 16 May 2024 23:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uybExKRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A9288485; Thu, 16 May 2024 23:12:30 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BC888480
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-572a93890d1so4327467a12.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715893947; x=1716498747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVXcWaR/AYumEqnfsZykQKPepzLnsVM3Se8YLjNvPS0=;
 b=uybExKRiLdsGSRsPe6QlMhljgogBArLsX9fJ7lo6qX+uzkDUWlkHfBjm/iOc68Y0f5
 6YpLf3H9LoZ2nXx48e8x/EkIzsXfdEQDeIvagdD0AkgzXDOki3G6Dp0/BIGOMK3rqXkV
 6xkfyns7moVFXeNMeGOWnbn2JbO127nLlLFTYW/Sqcalv1aD9wx67CLxIfaOnBdof1eK
 Z2o+51uxK0uhgCd//stRQsXgWNOW84VLLR+iy5ip6qN7I6q9LMTPorUO6d8edwKAwwTU
 mejNGPaCYczaAPnAD+Tq7FSSdcAxO51qVceIV29B/tevl+pwaLcTikCZeHjafddQBEcQ
 m8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715893947; x=1716498747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVXcWaR/AYumEqnfsZykQKPepzLnsVM3Se8YLjNvPS0=;
 b=UB5Z5nKs3jCBMixyHbYmzbcDyFTdKfpbMhhEqN/PaD2iKXSkvHty8vumvVg/hnZICw
 Wupvwwz0TdKDw6lIrMyMOiWoaYflt7zbwx7hPplrnSsufOz5gWJ69LIxr28EVBxZHCgK
 xfpPLkiTrjT+xcolQi0s/FVti8kXBphGMjnmQQnfOnt9QdV1wYyNKwScWRDGqWq71CNV
 uwMg6JiCqP9qe7rEtg/XLQ4zkvD1A6nRc/W2xASc7igw5UMp/AiAlMeDd+qTkghTwbTe
 39u7x3R8B7cUaIhbgVopZWUFkYTzOCHLSEQmYO1I2g0fUAXpM+7OsAcHAQAxGqgi4k64
 IIZw==
X-Gm-Message-State: AOJu0YwWROqN5sVvpRRhOlOQmNI4Zq4HcnvdJg22q5AU4MM03boCQQ0v
 6FDK7Mn8dYd1/N8U6PXqHq/T5Lmn000i2DyFW0FIMMubRP/Wa8UjMoVMa78tHn6r7ui1UFHyXd4
 Z
X-Google-Smtp-Source: AGHT+IFaD151tRnu5iYdT8TW1279YjdqGa98q7X2fn6EQSATb8efDO2wTN8WbnPYPqu8u31rqXRaMQ==
X-Received: by 2002:a17:906:3c10:b0:a59:cc9b:d6f8 with SMTP id
 a640c23a62f3a-a5a2d5cca1cmr1833828666b.39.1715893947000; 
 Thu, 16 May 2024 14:12:27 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d09sm1021582266b.107.2024.05.16.14.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:12:26 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Tony Dinh <mibodhi@gmail.com>, Phil Sutter <phil@nwl.cc>,
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 3/4] md5: Use typedef for MD5 context
Date: Thu, 16 May 2024 14:11:51 -0700
Message-Id: <20240516211156.1819939-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516211156.1819939-1-raymond.mao@linaro.org>
References: <20240516211156.1819939-1-raymond.mao@linaro.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.
Changes in v3
- None.

 drivers/crypto/hash/hash_sw.c |  8 ++++----
 include/u-boot/md5.h          | 10 +++++-----
 lib/md5.c                     | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
index ffd4ab149ff..4590e225481 100644
--- a/drivers/crypto/hash/hash_sw.c
+++ b/drivers/crypto/hash/hash_sw.c
@@ -50,17 +50,17 @@ static void hash_finish_crc32(void *ctx, void *obuf)
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
@@ -158,7 +158,7 @@ static struct sw_hash_impl sw_hash_impl[HASH_ALGO_NUM] = {
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

