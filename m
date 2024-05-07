Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C80C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9181A883EE;
	Tue,  7 May 2024 19:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rMu5iLcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B956C88551; Tue,  7 May 2024 19:56:17 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08299883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c974a0647bso1115242b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104573; x=1715709373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qloB1RfBaPrdCsbd5/9CzOeNdKF2ZGSi2o4OuoIOQ3o=;
 b=rMu5iLcn7OKUYNNvM9GyVE/9DNFtzAhW48DFWc8tI+ObDuTavKba4LllFn3SNZFa3x
 N4xCD1XSCWkuf6AbUkwXX32CianobJMnIgjYM8W5yUcnXfhWwh7GjLh+4fcqDFldl6vN
 n20J0GxoyPf62+f1Ak56T1rIkYqXu/Dl+WvWcUdZ2s+ZSKWqTWGg0Gh/ob4U4jNCXw/W
 jtj3m7sQoRwU0epPTl1rydevcqVUaNgY0lYDcf5zfKXuBEvY7EC6pRedUih63VJaTyRh
 JbXrCUko322GVv5qqdcj7AQmbZiGIX6QZqqY1A+lmqg6MS5Iri+959/8uO5H0ps+wN8z
 vMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104573; x=1715709373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qloB1RfBaPrdCsbd5/9CzOeNdKF2ZGSi2o4OuoIOQ3o=;
 b=Wmf6HrsuIPWXSkLVnAOHc8ho5+7LMwpvoRuGXk5BnUtKInsojnTVlf0jA0VgnNWfek
 QfWLpbXCeRemVSBbMEwO5MctMVXh1sJcOPyDvXSmJFxZ/HnK+Lq4f9Lg/QCx5eKGnUg+
 DGCWabrNVdH3UanvHnh2KVvr544K84pPTmc9N34JRg2bl2koPEisjYtq1o3Uleb/swkw
 ZXWg/Op0LhSdFXf56qReNq2PIzGtM4AIaUgw9NOzluaeazJiWPlde0z9UbZQ/ntjRUKY
 i0ZGNfhoHsNw4VyMwDBKYLUx+lZnLm0g7yi6Q2rqJGdYHeeEJ1g8xKyWdlVU4iWlaCSu
 jluw==
X-Gm-Message-State: AOJu0YxUwhfWPQxWl4rXmelIr03qjSQWTzqjvBMVqTsSLaq7/vhwExPf
 qCTIVLVuwwhs8UmNH4otF59C0b0gXQLwrlHSMvgoqa2vzLPjvsn5lPoSEXLyeTqllSQxr9nvK49
 J
X-Google-Smtp-Source: AGHT+IEH859B7sXaE38AB036TiW723eJCu7ClafycaCIJJUdZHjSD4zx6T1rBch8O6Z6RBf4oxGOWQ==
X-Received: by 2002:a05:6808:4187:b0:3c9:736b:401c with SMTP id
 5614622812f47-3c9852fadcfmr270234b6e.39.1715104573649; 
 Tue, 07 May 2024 10:56:13 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:56:13 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 10/28] hash: integrate hash on mbedtls
Date: Tue,  7 May 2024 10:50:52 -0700
Message-Id: <20240507175132.1456512-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Integrate common/hash.c on the hash shim layer so that hash APIs
from mbedtls can be leveraged by boot/image and efi_loader.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Use the original head files instead of creating new ones.

 common/hash.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index 3d6b84de473..6b8815da237 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -36,6 +36,132 @@
 #include <u-boot/sha512.h>
 #include <u-boot/md5.h>
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+
+static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
+
+	mbedtls_sha1_init(ctx);
+	ret = mbedtls_sha1_starts(ctx);
+	if (!ret) {
+		*ctxp = ctx;
+	} else {
+		mbedtls_sha1_free(ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_update_sha1(struct hash_algo *algo, void *ctx, const void *buf,
+			    unsigned int size, int is_last)
+{
+	return mbedtls_sha1_update((mbedtls_sha1_context *)ctx, buf, size);
+}
+
+static int
+hash_finish_sha1(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+{
+	int ret;
+
+	if (size < algo->digest_size)
+		return -1;
+
+	ret = mbedtls_sha1_finish((mbedtls_sha1_context *)ctx, dest_buf);
+	if (!ret) {
+		mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_init_sha256(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	int is224 = algo->digest_size == SHA224_SUM_LEN ? 1 : 0;
+	mbedtls_sha256_context *ctx = malloc(sizeof(mbedtls_sha256_context));
+
+	mbedtls_sha256_init(ctx);
+	ret = mbedtls_sha256_starts(ctx, is224);
+	if (!ret) {
+		*ctxp = ctx;
+	} else {
+		mbedtls_sha256_free(ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_update_sha256(struct hash_algo *algo, void *ctx, const void *buf,
+			      uint size, int is_last)
+{
+	return mbedtls_sha256_update((mbedtls_sha256_context *)ctx, buf, size);
+}
+
+static int
+hash_finish_sha256(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+{
+	int ret;
+
+	if (size < algo->digest_size)
+		return -1;
+
+	ret = mbedtls_sha256_finish((mbedtls_sha256_context *)ctx, dest_buf);
+	if (!ret) {
+		mbedtls_sha256_free((mbedtls_sha256_context *)ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_init_sha512(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	int is384 = algo->digest_size == SHA384_SUM_LEN ? 1 : 0;
+	mbedtls_sha512_context *ctx = malloc(sizeof(mbedtls_sha512_context));
+
+	mbedtls_sha512_init(ctx);
+	ret = mbedtls_sha512_starts(ctx, is384);
+	if (!ret) {
+		*ctxp = ctx;
+	} else {
+		mbedtls_sha512_free(ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_update_sha512(struct hash_algo *algo, void *ctx, const void *buf,
+			      uint size, int is_last)
+{
+	return mbedtls_sha512_update((mbedtls_sha512_context *)ctx, buf, size);
+}
+
+static int
+hash_finish_sha512(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+{
+	int ret;
+
+	if (size < algo->digest_size)
+		return -1;
+
+	ret = mbedtls_sha512_finish((mbedtls_sha512_context *)ctx, dest_buf);
+	if (!ret) {
+		mbedtls_sha512_free((mbedtls_sha512_context *)ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+#else /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
 static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
 {
 	sha1_context *ctx = malloc(sizeof(sha1_context));
@@ -144,6 +270,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
 static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
 {
 	uint16_t *ctx = malloc(sizeof(uint16_t));
@@ -268,10 +396,16 @@ static struct hash_algo hash_algo[] = {
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
 		.hash_finish	= hw_sha_finish,
+#else
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_init	= hash_init_sha512,
+		.hash_update	= hash_update_sha512,
+		.hash_finish	= hash_finish_sha512,
 #else
 		.hash_init	= hash_init_sha384,
 		.hash_update	= hash_update_sha384,
 		.hash_finish	= hash_finish_sha384,
+#endif
 #endif
 	},
 #endif
-- 
2.25.1

