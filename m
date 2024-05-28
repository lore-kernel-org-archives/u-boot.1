Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F7C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3446884FC;
	Tue, 28 May 2024 16:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S6/s9Zff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1B88851C; Tue, 28 May 2024 16:12:49 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C44987D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-794c3936b66so54865885a.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905566; x=1717510366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YH6pGTR04jOkufx3vSce8duSRIJA3VIAYX93jdSWZMY=;
 b=S6/s9ZffpU+0qtM/JyXc46Vsy41FtBB1GTEwEG8Mjqq7E1WqMWa1kzaQfdmqChlGu4
 GH4uraf88tfcOu02ehJFnam6ESu6FYe7grdvUvdtmlHSDMznK3KOBA82fKNuq5Ja+Prt
 SuLKl0oiGZAJfmAO2O5aCPBlTjLYdEeF/1gBChmKtFfJwbVYc3GjwAPlLj6K1VL6v5t4
 GSEOCeg6w+2hy9qTkyM4nO9IADqm2a8uLfdnGqk36Py56JC8NTLcixzTsOj4Pv0DpSlp
 PA38jMnxf+2Cyo/tpb6eKIr15GeyMGylUZNO6dGW4vYPTGzRA5t57TFZggXoUktN94Iw
 EE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905566; x=1717510366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YH6pGTR04jOkufx3vSce8duSRIJA3VIAYX93jdSWZMY=;
 b=FjM0QyoN3aCnCtp5vDusSuBYmUFImVB1ffxoMKAbmcSo8uGzrDpFp6GuSHx8eypiW1
 ihZum1QSKielW0HeQd/dA3oeuNRsZoxqkn0uQdSSYpszzBwa5cR0kuVQoz357DwtYzWx
 xTX3J1hXSa3Al/l/evN0INaOaA2BJ1FLjQogSMxXaCUd7XEOjZHSe71EfRR753jzPZbY
 fiBEEUUce0mc8P1JVgcmg7KNu+GEKhA747z3DswrViFBkk1Jed3yVTa9aPKAzafe32fW
 /0xJeG0r5nynQyq6nuFbSTW6kwb7bvZAxB3YKo0iAlSK6DoF7/RPZSv/Th4B8HPpmsGK
 qHkA==
X-Gm-Message-State: AOJu0YzaSNzaWpgUiE6F6p6dFmfXH3VD6w0ihhgU+KuD/yIGq2zrlNVw
 +jYYY7tNgKkp57L59WutI37iaYkjUXSTa1tFEMRd2uTFOCNrmu33xcY4GzjGIkXO43eqFoKLK27
 /E1o=
X-Google-Smtp-Source: AGHT+IFUQW/e3x8szMqKLPYsL07FoWY+eXVDEX+ao+X8OSq2qc8G5VhrFlUb89JVrxWlFZQqy6mUvg==
X-Received: by 2002:a05:620a:390e:b0:793:d0:e427 with SMTP id
 af79cd13be357-794ab080b95mr1658601285a.27.1716905566068; 
 Tue, 28 May 2024 07:12:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:12:45 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 07/25] hash: integrate hash on mbedtls
Date: Tue, 28 May 2024 07:09:18 -0700
Message-Id: <20240528140955.1960172-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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
Changes in v3
- Add handle checkers for malloc.

 common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index 3d6b84de473..1c8e7731afe 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -36,6 +36,141 @@
 #include <u-boot/sha512.h>
 #include <u-boot/md5.h>
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+
+static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
+
+	if (!ctx)
+		return -ENOMEM;
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
+	if (!ctx)
+		return -ENOMEM;
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
+	if (!ctx)
+		return -ENOMEM;
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
@@ -144,6 +279,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
 static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
 {
 	uint16_t *ctx = malloc(sizeof(uint16_t));
@@ -268,10 +405,16 @@ static struct hash_algo hash_algo[] = {
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

