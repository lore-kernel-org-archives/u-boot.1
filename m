Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7575DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D013488C21;
	Fri, 16 Aug 2024 23:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PUIisrFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EA688C3F; Fri, 16 Aug 2024 23:47:38 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2155A88C31
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5da440d059eso1536625eaf.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844854; x=1724449654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQZPR3BgqcXS6YdiXTTKQmHt0t3aVwOd+bqkQDJ5Hso=;
 b=PUIisrFJcPfrwGKLFiR3PKve29o6Q2OeQ76kl2DJ0hElf+Xp082TGL1+SXWgOzSsh/
 SAkXS7HCHr+b49VhWtTIOvtJ1v7t2tdjuFkCq3C2feOqcCPUUsw3V5h/M7Sb7VCd6TnL
 bC948qeLIJXB8bizcolR2UNJpdS7AgbXn38lwjDVjj1y1SQBhGhZnBNfpBFYNYfPJIKn
 qsDCcLtmT/Grs90uVvo9BtODrl+Ncu3QuXhI2AImW642fFmFCj31IfSLMZwrlYg2n66N
 Tp8IxkIOGyA0wsvdsVRALlt1uXWOhog8xOyGYoGpdCkPTA9fuWKY9T9dzN2wcYMiiiUM
 AppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844854; x=1724449654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQZPR3BgqcXS6YdiXTTKQmHt0t3aVwOd+bqkQDJ5Hso=;
 b=aQSUhEiaJ2+FDVqsGkBnFER3SvP1iQbxEx73EtZbupRFIhLG5Y2bAftjLBNs7Rnf8B
 JcKih1l+S+n1PpwxBI+CRsNNQty4x6N92/729elVdaLc2m62LDiTi67nOey+I8jGyYIQ
 c9RGSYPTvCQsn0pWlIM/GQ7U3zhPsOds9/mopoeCBqmICLXKkZweCcnQheMIKXbUZckd
 Ew/H5YLh5EKwUJIgZrrVeNyQv1SuqIFX/RupnHdgv/A1sbfuZSwShdhbOpC+a7FpQbVt
 ChoWB9fwH15vk4EEnHhTZ9leQSLBDNk7tKFrrdFKyc3IekmEkrzC/aL29CxTM06teHkE
 Br/A==
X-Gm-Message-State: AOJu0YwUbQtmI3lnILDiISjzfK/RSrYGytx4ES2ux2eBRtiKHgDW/lfA
 /95n8GTWz3lyoMrjqDf9SlRHuoqtVvVuU/S7HcNFFj8pvQwZZE9ablf2hvpeRdKbAdySphp8ycP
 OgWU=
X-Google-Smtp-Source: AGHT+IGmeIaHcRDqD6yyqwJB+nmrrc0rpxHdK+r0vtlUF4kAPniIqUxjhqlFVzmKpCEHMDD2jr+YWA==
X-Received: by 2002:a05:6358:478e:b0:1aa:bc07:a3da with SMTP id
 e5c5f4694b2df-1b3931c0af3mr594749255d.14.1723844854055; 
 Fri, 16 Aug 2024 14:47:34 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:47:33 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 07/28] hash: integrate hash on mbedtls
Date: Fri, 16 Aug 2024 14:43:56 -0700
Message-Id: <20240816214436.1877263-8-raymond.mao@linaro.org>
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
Changes in v6
- None.

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

