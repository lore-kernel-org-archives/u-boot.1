Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D9C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B7388279;
	Wed, 15 May 2024 14:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P5SYKren";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB4188279; Wed, 15 May 2024 14:33:33 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAA188253
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so2905916f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715776410; x=1716381210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MaMaR+3gTp15zOPExfmxdnZJ/rBSbp3cBCirHRkOLg=;
 b=P5SYKren1uA/FXP3t5D1ADn5syCzmvyR6rTi+fVqBCHTd95fA/99RkTH5qCWwkkik9
 iproMMqciR4Jr2yF/M564B62Z1JCeWbl7dADhgrRUwKBTRbhFxeLnB/4PkTfW9mka7Ml
 qyShhBUEs77VOb41iE4W+fseeUUPviKsVf5KRPwF4PagZfbI8FuhX3C9GCscs2XKYn3Q
 fy7FjFscfSxAlurx9dKXPEfulo91z67jgCySJj3wehO8rdlBwKe1S1/WyFu9lFBbBPpQ
 vm33+ahWn2E+zxkQC2PWaz/9/OlHu/v9dI9GQbez+mR5EDHZq+JPNLWpbMQayBAe5vWg
 /HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776410; x=1716381210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MaMaR+3gTp15zOPExfmxdnZJ/rBSbp3cBCirHRkOLg=;
 b=Oyw39jLnP4g/ef3IfOLHV05UKGyGMRj7XRtb7LMda7KaEoBdWfaAlQFrpnRymi+GCE
 8y9+grERLAb0tmJiixRIFBnKpSR0VxW8W1DLXnOVuNbXeBskfOXMP1iwte9fF1WOFdHc
 N0LvA4Xdd+NNcyN/MUAZguQdcjRT3loq5MZdZwikC8VGOqOEdhurkflehozKy9/0y/Dw
 ySB2Jnrjg1dwb3TySIMcBjNODxVxzNfEfy2kYh6axRPeKj3ANvryb+u3Exp0TteD7/YY
 W7XpGSRWwzMknzI2Y3vq9MG5CmhRhFqVymRiEpfCFeOKKDjF0WFpG5ANS7qYB1AS3KET
 U+3Q==
X-Gm-Message-State: AOJu0YyaDHUX8TSq0xAT4VUmUCgeDanxPL7cRW9e9QdbDc/WYRFUKSXV
 OCJRGk+uh2Yz3SUKgHyfkWC5A/fQaeMmdefeJEw708eIKpraHUwGXxU6+epxBGYZPRlvFSRTh7j
 N
X-Google-Smtp-Source: AGHT+IHdtEeBgvu69Ix9pBanYix3MZr6F+sG1JyETbLw3MtovpAhs7O5V0FAx97Md9AvYjY7p4BD4Q==
X-Received: by 2002:a05:6000:c91:b0:34d:e262:8b54 with SMTP id
 ffacd0b85a97d-3504a632fe9mr13220375f8f.7.1715776410313; 
 Wed, 15 May 2024 05:33:30 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad042sm16406896f8f.80.2024.05.15.05.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 05:33:29 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Walter Schweizer <swwa@users.sourceforge.net>, Phil Sutter <phil@nwl.cc>,
 Tony Dinh <mibodhi@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 3/4] md5: Use typedef for MD5 context
Date: Wed, 15 May 2024 05:31:58 -0700
Message-Id: <20240515123213.1701691-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515123213.1701691-1-raymond.mao@linaro.org>
References: <20240515123213.1701691-1-raymond.mao@linaro.org>
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

