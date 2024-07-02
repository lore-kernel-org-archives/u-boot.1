Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04343C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D6D87D0A;
	Tue,  2 Jul 2024 20:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rzXkLTrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DED87F8C; Tue,  2 Jul 2024 20:26:33 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BE187C68
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-444fdb6c1cfso28417001cf.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944789; x=1720549589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuCpFHGUDou197RK3J6iadrgfvGbnEfawRmScVLoYFE=;
 b=rzXkLTrWrLuFzm9Y52ovpt2J2J+w5Z/U9L35LYRh3xuU1wsgadu0C3ovn9Y3uAyLhn
 kHhaB85eRYXeRa7hfAMP9zOWGk4oRGdZhuam3HDOtKBugtaQukH2Xf2bNW8hs3cY2G7S
 JW7PwwGXVhIOOM70YAMOuQ+AExc0fpQ3EzA29qFrBKm43GBD7pfrEmJIKPsGDvSfXUpA
 SoknOd/p/mXf+ll8DY4GYsNQNqnw2PlkQrKmu9/meCVeejYfGAJT/lpS5cmLMiWU0dKw
 KQJXr8oS09xF77H1HP0L6wIbUHCRg58z29amSrEyFLmVE9eRWz906dvChqUanuc2XIPH
 6vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944789; x=1720549589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuCpFHGUDou197RK3J6iadrgfvGbnEfawRmScVLoYFE=;
 b=YJQTOS0g/E3f7PrVt7+IEL47ejRGRGtOpRgsMNnaRn6dh7L8zzlkJrCSrcYu77FWIW
 Uh8HN8y9x1RXDhxFMXdr8LzO5MDAhJ4NpnnNVH63bJoZcgF6H0D39909oD5IUZ/M/UOk
 P4j/irb0GgxifYep8KIh7DvhgenabqRqSbAyK2tXrParPTiRFSG/XS3EWwynhaBHEEpD
 eSwy4T9qkmal0iRocWlLkiLk27ZqQsDlUk2wYepN8AWOSIHBOf4ugv6LUSolHERNqcfP
 YVjsMIjHwnVQM0OHufIDlN5apFxEPSkSTDVQWP/Pz09UWnXvK4w5BBY1qfyUAZK9MKhA
 VTXQ==
X-Gm-Message-State: AOJu0YwaEFNV6Y0gHpSEWHyY/aVIeYqZcS0CgWS8EqgH8jTEFeiH1Tbn
 WF0KqrbBDzxyU63cBk3twJ43yolhZF7XzCny0Edvw8Gm6jXoNei4W9qovEyM9bZBECVZT+5NJzi
 1
X-Google-Smtp-Source: AGHT+IGYeYk6yz7WzTsM3RDxMvGKOKotRMs90k5k1+tHSLVAn9hPrSxSDy2B5zdBLgWN8ZrYx6f9hA==
X-Received: by 2002:ac8:58ca:0:b0:440:6345:257f with SMTP id
 d75a77b69052e-44662f48304mr140415911cf.60.1719944789331; 
 Tue, 02 Jul 2024 11:26:29 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:26:28 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 06/29] sha1: Remove sha1 non-watchdog API
Date: Tue,  2 Jul 2024 11:22:42 -0700
Message-Id: <20240702182325.2904421-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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
---
Changes in v4
- Initial patch.

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

