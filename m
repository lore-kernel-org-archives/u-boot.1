Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF3CFC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1934C88D72;
	Sat, 14 Sep 2024 03:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kmtbd8gX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F2188706; Fri, 13 Sep 2024 18:06:49 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D97887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6c51d1df755so17296316d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243606; x=1726848406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5C6Kk5xBoPTZs1C91omu+eFS45kcwxUwMMkbcH3+Gc=;
 b=Kmtbd8gX1yy3ENW8sSJmWFrrsGhgx7hLjaNdUTyUWUZNRaPt83RgPrEUQb78X7QBdx
 Uw57oWftxUfw0WfN4Vqb/YmmSWfrFdH9VkpCvrwW9TrKSw9PZXdpjLKXXJiUebuBZypP
 Ow3y6qUyaJ12U8EUzZtAtRz+oa3vow0jQd5NwRUO3f0/ctatjQzWSUHiC3+iLYF5FnXG
 8To5iWb/IrZ7rE4nNkvowAJ/dg1aUviK8ddnS/0DRx/ejJXUBalxedoOuMGh7MaYpDLX
 dsZUtUHhmFT9TGYZi+r9elImAnahtA1b9cQ3fjAYHQ8kpRiicanPI5BSNLouWAgQwA4K
 u38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243606; x=1726848406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5C6Kk5xBoPTZs1C91omu+eFS45kcwxUwMMkbcH3+Gc=;
 b=Tv6A3ZMA3TPSoDocV2SDrRJySTJ9N9NfB6ue2/UYhvPjfrh88Otdm6ocFNV/IDyiyt
 BHMTLroi1lDJdER0C1tPzvJapq0VG1/+g+iEurtIgsp9uZkn6WRNqwPHitvB2o1F4lA5
 uBb2oDCjUf72pPdJAU6/8FxYOJv5Zgy/ucpRVyPgEudit2xXmK8BeNz8wBxMkHyavUeK
 whJuoEejBcoidNbDN72LLlaCyKc8y1u9GIwre1xH/8vSuOnBdIhGH+ADWTK4MnCESSIi
 YPUIyWvh0g6z5pAlffs894V7CA95/Yae5O870rHWnK6w++uUAt2K0iL4x8NKyXDwcsUf
 Eojg==
X-Gm-Message-State: AOJu0Yzf0rfIYlM/X3TCYa4YTIHjtj3P1crdKM/YO0CFcZ6AzzS/yRau
 DKpB/zsr9N/ENZxMhPN0LImBzwsQGtkKXMLWF+lN7hcC0lv3VkfTHWAVTdDgMG1GJ9NKWQ6hkrv
 y
X-Google-Smtp-Source: AGHT+IEEVCUS5nHlQHkZNUIJHqAT6brFuWqCLAFnljKNOHItP5qfK3bCg4n+AWeXRlH97ELiLBJd3Q==
X-Received: by 2002:a0c:fde7:0:b0:6c5:7b99:cab with SMTP id
 6a1803df08f44-6c57b990caemr50735676d6.8.1726243606068; 
 Fri, 13 Sep 2024 09:06:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:06:45 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 05/27] sha1: Remove sha1 non-watchdog API
Date: Fri, 13 Sep 2024 09:03:22 -0700
Message-Id: <20240913160408.2199558-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

