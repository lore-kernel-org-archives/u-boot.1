Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C642C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D842E88A6D;
	Wed, 31 Jul 2024 19:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wATmy1vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8854088A65; Wed, 31 Jul 2024 19:29:06 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBA988A65
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a1d81dc0beso388868285a.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722446943; x=1723051743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnLbfXKv1AJHt2CR5ZXQUpg0a9kEsH43x0Byt2m4HGw=;
 b=wATmy1volVWhzuvfK4hx0eCG3QIaPGVgIQaUqNuLKbmIHDkhZgiMCTqAaQABIRxISm
 Qy19PlTIpXAf+fyoHsP7BpOJkI88HDUxHeuGhI4ZW6EzwGc8LWPZpzVl0JAFIYfr2WFE
 URGCTrpmk3JYg0d8eRb1p5t7KNjfWqXrYRjNcg29jsVfZxskJIKCVU1fiG2A7/v9tQvF
 MoI+afxFDo3qjqf7mmrpLDDOfZwOCiZOkVjlWcJ/J5dA+zPm3+K4JwLrzCM7rtideIV0
 ofmYb2G9NqO7Xn6uTOm7kFi3g0xo84LAjkOLrW9EIAVHlweKrhen2vsOIeYeBziU1s9k
 p59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446943; x=1723051743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnLbfXKv1AJHt2CR5ZXQUpg0a9kEsH43x0Byt2m4HGw=;
 b=aoxRc33hqIe96UmJ0aTbWqUmqDMekG9uUJGYJkFE2sEHQChbQcBIqRINhVfVdX88QI
 zZTMPM1q7aa2NOw3L38nVexD9Y7Tzc2cGPS9uETVYZmM4B/giGmY77S7EhOqERitLWv1
 zpUwMyzzxdV2utYq5fGhsxS0xF0XCWj41W1/JMILXtqJkyPGwifyFmccJGqZIBMlcYsT
 0XcIURUbHzhtKZ5g5w4zYn/Ks81YdZRb1ytkdEv2+Fn1XpOhYhQddkxxievVy1GXPJb6
 A01FYIF6PFU5xGeoVeYBrXnWD4pYcnjVQK5UX3/y0AKajIghEG29dJppyrCSldmbyIv+
 QxTQ==
X-Gm-Message-State: AOJu0YwFzGgqzk6rX1J0Zr9jCtjSudK1dEFtiCXBxnDqBRwbtIJWzK93
 e5ZpEJgn78sL0WRL77V8hLzDF4PBHtGbxOHk4QzqgtENdKKoUnQrnahMm9wu+yrvvhVDSFNyI1k
 e3io=
X-Google-Smtp-Source: AGHT+IG5oZe2MHuk9sjCXS8SVrRbKyvP49s3SHxuvtC4ga7VwBfYs9dMHMhi/xMwsHYKLhdnpHo+uw==
X-Received: by 2002:a05:620a:1a88:b0:7a2:d64:1cbc with SMTP id
 af79cd13be357-7a20d641d43mr258978685a.26.1722446942954; 
 Wed, 31 Jul 2024 10:29:02 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:29:02 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 07/27] hash: integrate hash on mbedtls
Date: Wed, 31 Jul 2024 10:25:17 -0700
Message-Id: <20240731172556.1348487-8-raymond.mao@linaro.org>
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

Integrate common/hash.c on the hash shim layer so that hash APIs
from mbedtls can be leveraged by boot/image and efi_loader.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Use the original head files instead of creating new ones.
Changes in v3
- Add handle checkers for malloc.
Changes in v4
- None.
Changes in v5
- Add __maybe_unused to solve linker errors in some platforms.
- replace malloc with calloc.

 common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index ac63803fed9..d25fc4854c7 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -35,6 +35,144 @@
 #include <u-boot/sha512.h>
 #include <u-boot/md5.h>
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+
+static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	mbedtls_sha1_context *ctx = calloc(1, sizeof(*ctx));
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
+static int __maybe_unused hash_update_sha1(struct hash_algo *algo, void *ctx,
+					   const void *buf, unsigned int size,
+					   int is_last)
+{
+	return mbedtls_sha1_update((mbedtls_sha1_context *)ctx, buf, size);
+}
+
+static int __maybe_unused
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
+static int __maybe_unused hash_init_sha256(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	int is224 = algo->digest_size == SHA224_SUM_LEN ? 1 : 0;
+	mbedtls_sha256_context *ctx = calloc(1, sizeof(*ctx));
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
+static int __maybe_unused hash_update_sha256(struct hash_algo *algo, void *ctx,
+					     const void *buf, uint size,
+					     int is_last)
+{
+	return mbedtls_sha256_update((mbedtls_sha256_context *)ctx, buf, size);
+}
+
+static int __maybe_unused
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
+static int __maybe_unused hash_init_sha512(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	int is384 = algo->digest_size == SHA384_SUM_LEN ? 1 : 0;
+	mbedtls_sha512_context *ctx = calloc(1, sizeof(*ctx));
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
+static int __maybe_unused hash_update_sha512(struct hash_algo *algo, void *ctx,
+					     const void *buf, uint size,
+					     int is_last)
+{
+	return mbedtls_sha512_update((mbedtls_sha512_context *)ctx, buf, size);
+}
+
+static int __maybe_unused
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
@@ -143,6 +281,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
 static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
 {
 	uint16_t *ctx = malloc(sizeof(uint16_t));
@@ -267,10 +407,16 @@ static struct hash_algo hash_algo[] = {
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

