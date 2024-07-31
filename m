Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E7EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BD387DDF;
	Wed, 31 Jul 2024 19:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KY8Okfiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B7088A05; Wed, 31 Jul 2024 19:28:24 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC69B86FB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a20b8fa6dcso62216985a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722446901; x=1723051701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPQFentpBQ3fPxytJToVg99R3o0cGaCA87K+xs0gW8Q=;
 b=KY8OkfizVK6OUwlo9C6rCdRXFb4dqUlsd/bKKyov6rhhL8RJ8tI//vFWN/yjN+Tuay
 a+k2Bqh8hC5MUau0LGrUhzD0IdIUVD9hJtZ5W08hqPCZL2qg1hERrvsOY4FPwIAVzeAk
 qCtObajmNkIrzRjtqxdyMKepqyPaWep2CUYM8DUXg8Mi+8kSNO+RXY3zd/AebjEJRGNL
 LM8MOu7/uxniKGIokHrJKfhoo0vg2h1nY0FgVxpneimskxmQ1plwIHZzRBnNVrW0GX3A
 BQ4Dmr8Z62sHhb0mDsR46S4RIh8Z1xoGnahrBhkzIjLtIS/GAtea+InwcTTviyVOinqc
 jkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446901; x=1723051701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPQFentpBQ3fPxytJToVg99R3o0cGaCA87K+xs0gW8Q=;
 b=dslvYjEpZ5v/xUDUwDRpJ5iYSUYaD2b9cf5mJOIXJ2FxO26tR587oYiJ1FI6+i1K6M
 SnbpCdhrfk4+xL0wms7xqTKcnRIDlqyWvznNnFx49n59JP9dC8k6T0x1i/YHz/iX/mRm
 uNjzj8uUnOyDwt/6gqcH04WqrbPEz+Xfwwzw1HK3jrRs0mlcJBTxf67HWGkgPnEmFVdP
 CQ03YnKRgQMatnUyhNXfBAD7+/6Pzcc696OUVJeHWPs66mxdrhqBttMkD29m5RAtRuCd
 Ob09RiIHyderrHoDqBsqqOKKAgZSbR22nYGLFsoeM21/piFL6Ycb8yFhsXFWYKpCVOID
 BUrg==
X-Gm-Message-State: AOJu0YxTuFE1nXIGVFDPmxF6C/88FP0ihS/vRVKwZQwquIcq9G8rRqYF
 +miisif41Z3aGs+Wr2ofjmVTx9ZDR7Xq10DNwl1ZVJ7oLaGVAWAj7sNjSCwbGM2Qkr3gjrVQLFJ
 CkSI=
X-Google-Smtp-Source: AGHT+IHToJPv2ODs+05MmklKq/3DdiFhlY2U2zew+M4+FkUyMwsuY1jbrw7Hcee26YRQhsUu3FuiPA==
X-Received: by 2002:a05:620a:28ce:b0:79f:6bc:d98 with SMTP id
 af79cd13be357-7a1e525f3c9mr1873647285a.36.1722446901289; 
 Wed, 31 Jul 2024 10:28:21 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:28:21 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 05/27] sha1: Remove sha1 non-watchdog API
Date: Wed, 31 Jul 2024 10:25:15 -0700
Message-Id: <20240731172556.1348487-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

We don't need an API specially for non-watchdog since sha1_csum_wd
supports it by disabling CONFIG_HW_WATCHDOG and CONFIG_WATCHDOG.
Set 0x10000 as default chunk size for SHA1.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Initial patch.
Changes in v5
- None.

 board/gdsys/a38x/hre.c |  2 +-
 include/u-boot/sha1.h  | 12 ++----------
 lib/sha1.c             | 13 -------------
 lib/tpm-v1.c           |  2 +-
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/board/gdsys/a38x/hre.c b/board/gdsys/a38x/hre.c
index f303793b63b..06856ea36d3 100644
--- a/board/gdsys/a38x/hre.c
+++ b/board/gdsys/a38x/hre.c
@@ -166,7 +166,7 @@ static int find_key(struct udevice *tpm, const uint8_t auth[20],
 			return -1;
 		if (err)
 			continue;
-		sha1_csum(buf, buf_len, digest);
+		sha1_csum_wd(buf, buf_len, digest, SHA1_DEF_CHUNK_SZ);
 		if (!memcmp(digest, pubkey_digest, 20)) {
 			*handle = key_handles[i];
 			return 0;
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index ab88134fb98..36c3db15e22 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -39,6 +39,8 @@ extern "C" {
 #define SHA1_SUM_LEN	20
 #define SHA1_DER_LEN	15
 
+#define SHA1_DEF_CHUNK_SZ 0x10000
+
 extern const uint8_t sha1_der_prefix[];
 
 #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
@@ -81,16 +83,6 @@ void sha1_update(sha1_context *ctx, const unsigned char *input,
  */
 void sha1_finish( sha1_context *ctx, unsigned char output[20] );
 
-/**
- * \brief	   Output = SHA-1( input buffer )
- *
- * \param input    buffer holding the  data
- * \param ilen	   length of the input data
- * \param output   SHA-1 checksum result
- */
-void sha1_csum(const unsigned char *input, unsigned int ilen,
-		unsigned char *output);
-
 /**
  * \brief	   Output = SHA-1( input buffer ), with watchdog triggering
  *
diff --git a/lib/sha1.c b/lib/sha1.c
index 7ef536f4b5d..81412283b49 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -304,19 +304,6 @@ void sha1_finish (sha1_context * ctx, unsigned char output[20])
 	PUT_UINT32_BE (ctx->state[4], output, 16);
 }
 
-/*
- * Output = SHA-1( input buffer )
- */
-void sha1_csum(const unsigned char *input, unsigned int ilen,
-	       unsigned char *output)
-{
-	sha1_context ctx;
-
-	sha1_starts (&ctx);
-	sha1_update (&ctx, input, ilen);
-	sha1_finish (&ctx, output);
-}
-
 /*
  * Output = SHA-1( input buffer ). Trigger the watchdog every 'chunk_sz'
  * bytes of input processed.
diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
index e66023da5e6..a6727c575fd 100644
--- a/lib/tpm-v1.c
+++ b/lib/tpm-v1.c
@@ -871,7 +871,7 @@ u32 tpm1_find_key_sha1(struct udevice *dev, const u8 auth[20],
 			return -1;
 		if (err)
 			continue;
-		sha1_csum(buf, buf_len, digest);
+		sha1_csum_wd(buf, buf_len, digest, SHA1_DEF_CHUNK_SZ);
 		if (!memcmp(digest, pubkey_digest, 20)) {
 			*handle = key_handles[i];
 			return 0;
-- 
2.25.1

