Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA2FCFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8C288FBB;
	Fri,  4 Oct 2024 06:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ooWjnZWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B411288C6D; Thu,  3 Oct 2024 23:54:11 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E10A588D47
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-84ea1042bbeso480312241.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992446; x=1728597246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5r+9tRB7APM2jiVAI+pmgct29TVYNYxqEGW8lH6YA8=;
 b=ooWjnZWNvnjUavENsXRAprwZ2K5EAtW9sEQcwkV3M203Db50fE6urJeTqs3A6ltsPr
 9uSbOvWLvh8bgyE+8xkppY9YMwYoMPvnAObyvSpgQ5uDTnxQOMAy22sQHC+8y+nYEVxQ
 GK+LPeNbRoE2OSfs/BOmQykA+Uf4U0+X1EkLGrJ+bKRyl9FDsYxnAyb67LXv6f5NdkDN
 dNLMbVwyRoO4E2Pf4ora1/HyO1r3RuRIZkBIoDX0mvBzU/6RkXYgYPIWfmhBBqPN0S4w
 aTogZO5vETCjC6Q3lYZRQSb86/cpV7iVA3/PHFEgBZPjGVJw84Z0sqLYxR/efwNhf9k8
 K7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992446; x=1728597246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5r+9tRB7APM2jiVAI+pmgct29TVYNYxqEGW8lH6YA8=;
 b=mFWQQtanc4ruyaAoBcjJyg48oqincheFOutX3CUfa4gFhV14S5fiE9w8izJ3pmtIaA
 RhuMk90256Q+iRCSXhLXH4Bb1sIx8ekysEjueJXxoVecK3ASVJVWqHlKQE9pyvdtN92U
 yGYJPBMqBSEXoKfdh7K330Oic/lRglbP/rcAeTmabf4UzdR0rdkzzSYMbDWXlO8glOsw
 y4mPBQ1l+97HKK0soIxXWhPueLZydSsparwJL3+orSFOPoGyW52zvFi9MjjUGRYgRZwt
 Y10UVhACcPWP2B8F0W3JTk4+3Ol6Umw9SKl9+OwGn0u6MXzqoeO3NoaO1/2hZFU8TvBh
 r2aQ==
X-Gm-Message-State: AOJu0YwkGMLHoG5wwulsNA8j4EnG58taq4xH/ujw4rr2JDG0/iCpKE6u
 BwTXUnaFgwXySXTCJjdcyB4qIH3YuDDY2mXW8mjCQZwnjvfJFcgesYKOZ0WxxtxPPhrfN9fe5tL
 i
X-Google-Smtp-Source: AGHT+IGwo7dibjy30hDKnYDILUB2LD1g4efjJSKMC/Nq9AytbYkLLSO6WVurHDQka9a987jEwFKx3Q==
X-Received: by 2002:a05:6102:a49:b0:4a3:3d4f:edd2 with SMTP id
 ada2fe7eead31-4a4057a029dmr920285137.17.1727992446429; 
 Thu, 03 Oct 2024 14:54:06 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:54:05 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 05/27] sha1: Remove sha1 non-watchdog API
Date: Thu,  3 Oct 2024 14:50:18 -0700
Message-Id: <20241003215112.3103601-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v7
- None.
Changes in v8
- None

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

