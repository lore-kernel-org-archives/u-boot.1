Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73524C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066D78752A;
	Fri, 16 Aug 2024 23:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d552r9iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D92874AC; Fri, 16 Aug 2024 23:46:50 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E54388AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf6606363fso13360456d6.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844807; x=1724449607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLMApzFn732Xv6c8hiYeWRRUiO3PVWyUO8qMudZ2w/M=;
 b=d552r9iGSb9N0h1N9p8dybm87eIaXbofe+eTB6EMrUW9dUfqpgRj7swvTR6hq51YuH
 T0aSOapK9k6fejr3l7H7rC7vXv91R/GeyTW1ckgQunw/qb87gYibFyCGXQFEvmiYNQdo
 xSsu+iBKFGyB1Pe07mYpHoER6yCOWFbwW+NzI/+tLt/X0+GwOeQ303aVtpuhgKS3lwZd
 vZb0e9yuMRnoOWYglM+U4cJEv0goFxbrOcdg/8hEZ6jIzD43Xl17X64X0QTq56h2AkJe
 xFSFzZK49dzW8pm6p+EILs7WLwPw85kDZaJ9BfV3k/Wq5N+FGOVWVH1nJTmNHg58gLbh
 DHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844807; x=1724449607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLMApzFn732Xv6c8hiYeWRRUiO3PVWyUO8qMudZ2w/M=;
 b=T4Wp4F6V3xDQ1VHADBX4B3lWlK6Wg6whnrgsd0s21Y8g3VjYCTRp6Gv5NDPWL4M2Os
 sG+QAlVvm9wln1c9GsC9BqAI6Ra2mfUp8awcoyCJsvZYnzbYWedUQjEEH6hOEv5K5cSc
 yyiTiipftrrWZ1bZQxxr/ymNXq2JWg9RCiEei4cZypj4bjzbu8OMrPBNHvfOoZTG9a/9
 bA4JK7kXJIKzRC5itsbuTpH/PJSLPdZ3jiwqMYVTdxc0xJ9lHWbf0y6TT2z6I57koQwh
 z/fpGU6n+/wUPNzSEA+y+VwB4TVmtqBpCHLH1Pwe4FqdlA4XdukIGqtYP/f8opMQKBKE
 Zzkg==
X-Gm-Message-State: AOJu0YxQ2fau70ldyQe0w/nZiN+brOtFUUpRtHoM+o4+acELC8GzapK9
 aXbMbxN/WwF/x2YVDIW3Xxe018Evzn1Z+EMcUsu5agMBtIW+AarZ5gzuDxQLVT1ICVx5bqVvImE
 r5pQ=
X-Google-Smtp-Source: AGHT+IEUL70dgsVcZQnbOxDHe1uSfJVJPvAmsUIvSv5GrwXlIM56Mv2o+eQH4gAHqAyhdXpFR4ORcQ==
X-Received: by 2002:ad4:4501:0:b0:6bf:7fe5:39ea with SMTP id
 6a1803df08f44-6bf7fe53aeamr33064896d6.44.1723844807004; 
 Fri, 16 Aug 2024 14:46:47 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:46:46 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 05/28] sha1: Remove sha1 non-watchdog API
Date: Fri, 16 Aug 2024 14:43:54 -0700
Message-Id: <20240816214436.1877263-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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
Changes in v6
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

