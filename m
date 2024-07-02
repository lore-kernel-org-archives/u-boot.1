Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50ABC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF6B87D33;
	Tue,  2 Jul 2024 20:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QxWlBsI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1847988746; Tue,  2 Jul 2024 20:27:16 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE7F87D0A
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4464b843e37so22766511cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944832; x=1720549632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tzZpPH6FUU0oBc6qSB40oD/BcxocmsYfFcRPw38OhY=;
 b=QxWlBsI9MfL+fzXssOWL7CXIZJHO03Ruw+8rEsmsQKsGUfGHp92BkugyalfXnP4u8x
 CCyow0WFLe9K67ckC9e20l0NLLiILPoV2uZy487qZu/gH2SlBR43Ar4f/GENhERgOBR1
 WKYvJPuiNqao0c/693PL6XI+wEeFoWZd8TaqF2CkqtjU5bh7GrbYK1Oc0Xut2l3U1OkX
 +6dCVs7GRsq4C27+/FIhvV9BCXaxIfEWc1Pv9jkT4j0ppHOxNyT2S+Pxvyth7uXuJbJE
 /uSmK7AlzJGN9793PCXG+DPq0N7rPuGh7cBtVAdCZ4eT3HyELSWKCNPzwb2sLwhOHDhZ
 QkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944832; x=1720549632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tzZpPH6FUU0oBc6qSB40oD/BcxocmsYfFcRPw38OhY=;
 b=My0g43f3ZRnjYd8DQFqWGL5lQtQsp5zw22bp5caRvE6ODSII+M8zX/QPpCo+zGhrny
 gDNmI4JwR1i05t+dZYi95IEZZ+SDSxgZueRU+pBi5zVzb3sOqY4MlKesgwyWgbYQqFU8
 EJaXuYWUrLI+1/U2bjyzGk6PhrDCZRnsawYZmiJfX/Sc7dfcpvTJVa79xfEjlD9N5v6r
 5I8z4vcAZVOEWaW1KI4JaiWuqQBiOSTUWvmjpjez5NjEopS8S2mqFONi2mH346TJo4fe
 pFv6PMsn10JsHMv76zYj9hzLP7uZkcMEXEH5bVV+5JbMqk9JtK1Nmwa9vGcoM0NQW9xr
 uCOA==
X-Gm-Message-State: AOJu0YyN5pQJytUswHcJd1CyjzD29DCu3eNzldjfpfiUbuFNYiKPzrJT
 HrykR3X50ueB96T457Vphw31RYonQvVmkPX9Ry4BIKy+aroEVRpkeuVK3ABiLkkqfzEse0h/33n
 l
X-Google-Smtp-Source: AGHT+IGPJTOkOKQ7dTrcfOUiTtjnDjjK9dUBTM0Pzhj/hX69/rsbRsLgfJgQ/OM0XxKen6cm08GCiA==
X-Received: by 2002:ac8:570d:0:b0:441:207b:51b4 with SMTP id
 d75a77b69052e-44662e65739mr105284931cf.63.1719944832320; 
 Tue, 02 Jul 2024 11:27:12 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:27:11 -0700 (PDT)
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
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 08/29] hash: integrate hash on mbedtls
Date: Tue,  2 Jul 2024 11:22:44 -0700
Message-Id: <20240702182325.2904421-9-raymond.mao@linaro.org>
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

 common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index ac63803fed9..96caf074374 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -35,6 +35,141 @@
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
@@ -143,6 +278,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
 static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
 {
 	uint16_t *ctx = malloc(sizeof(uint16_t));
@@ -267,10 +404,16 @@ static struct hash_algo hash_algo[] = {
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

