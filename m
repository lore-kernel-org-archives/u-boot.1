Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0C3E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35652807C9;
	Mon, 23 Dec 2024 15:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tpSjP0lZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88FC807BC; Mon, 23 Dec 2024 15:49:06 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A77480780
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d92e457230so42417166d6.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965343; x=1735570143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eclQxymw/S+bCamyttK+McfCBzcGgTXc9jiWnFi/xQM=;
 b=tpSjP0lZPvOt9tWGxfydV50/6OTnMMljIYCvAJGCJf65GxuxBoLdm4//vZ5aNCgwpf
 EjZ8aMFWfscMoOfD+SAGZljga5liIhigovnVIp8pDfZgMrs6eeum7LKzsxzZI0RVRQmk
 aBUSPaZC6oEwj/mC0pk8TaLwzbtAjUEUE4cTkhmpApfF5g/KyFYFDBJHlC8mihMvE0FU
 fdAcw7XoBdLT3UtLD9Ir18LySi3yJe5hGfwgj0I/W0KZcvn+lANIWcZCnGZVhWdwjAqr
 w/suT8RpmIel/IbutgwH8P875i6M0fSUrgDzAkUDQh5TvlicncfIVx7xCjnSPhqO3gKb
 YYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965343; x=1735570143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eclQxymw/S+bCamyttK+McfCBzcGgTXc9jiWnFi/xQM=;
 b=tvNrKou5sD0LSqN5N5vbFX2+0YB9lr5Zd145UPSaAytdIpwuwwi00IE+07u61m+Qm0
 Xo/Qv6+xm06qMOkvs8Hpq3h0Ce+P/qak9Pd+RIJN9LY6G9xA8/kbKZNy7vkDrvtDCvHc
 VV/lXow/FsF50XlflDCnAyPvww11pfUm0gW9FEF7XuZJ9cDhQ6aXMGGPMrgNF8I6u6fg
 5wjX6sN5TZB8tK/A1V35aPq3xl2uZJUrJACXIXwFfZm6AIM8mDXhegGp3BwWzBYW66xH
 sDb3uFmj3QyUaoYyjPvWHbb9NnXEjMRjjWqaHjGCogCyXIVDoM26g7pEDg/h9C99Q4JG
 Ve3g==
X-Gm-Message-State: AOJu0YyhIUZJER41SXf8a5hPFh6faUwk59SV84ZStIFldFm33J5Xwo88
 W7jnyaGZpTZHGrN8wPkBilel5vegqlV+g7dSVXSzcYmU7Oj6RtHY+XPmWkMR48VpSSptGoQ09Ed
 i
X-Gm-Gg: ASbGncvAkZQrwQX2VsoFHF/2154BifFtjb4FcvlpMosvAytlEa0+4Q6VChKFWcnOWNX
 BjfB/1Wpx9Sjsy1k5QK3+Vkqok9BzkwHM5jBW6SscYeoLQq4By57G359Y7XyCTUdaN1xJmfMkwo
 7qyqkWza5s+8q6bpastn9ykJykWRGxWPckVuG8r+5O09vUxfZGNZtKMbfWjLxAH9Ja+5vXQi5Bq
 sut9ejVfbEsq/NVxsjMsga+6XRDyUJ4ftbsiVhrEOLUrmwOp9J/IkKvkelbSuCikII9ocsMD7qn
 pnzGhJkcUe2wWamzcSNYpy8ylwaZ0+pLZa+zOW2UWeFZCVwautUwBCk=
X-Google-Smtp-Source: AGHT+IE/dn+ZEOgU9gyoEdHYHFbEHNnVECrK5CD8zgQskCsDVgarvZhqzqJ0vdIYWNLlevDrf74aVg==
X-Received: by 2002:ad4:5d4e:0:b0:6d8:8b9d:1500 with SMTP id
 6a1803df08f44-6dd2339dfb3mr204034576d6.36.1734965343154; 
 Mon, 23 Dec 2024 06:49:03 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:49:02 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 11/11] tpm: add kconfig control in tcg2_create_digest()
Date: Mon, 23 Dec 2024 06:47:33 -0800
Message-Id: <20241223144737.554992-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
References: <20241223144737.554992-1-raymond.mao@linaro.org>
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

To allow disabling algorithms for tcg2, in function
tcg2_create_digest(), each hash algorithm operations should under
the hash kconfig control to avoid building errors when the algorithm
is disabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/tpm_tcg2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 64563d7871..85f9d3c9c5 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -96,9 +96,15 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 {
 	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
 	u8 final[sizeof(union tpmu_ha)];
+#if IS_ENABLED(CONFIG_SHA256)
 	sha256_context ctx_256;
+#endif
+#if IS_ENABLED(CONFIG_SHA512)
 	sha512_context ctx_512;
+#endif
+#if IS_ENABLED(CONFIG_SHA1)
 	sha1_context ctx;
+#endif
 	size_t i;
 	u32 len;
 
@@ -106,30 +112,38 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 	for (i = 0; i < priv->active_bank_count; i++) {
 
 		switch (priv->active_banks[i]) {
+#if IS_ENABLED(CONFIG_SHA1)
 		case TPM2_ALG_SHA1:
 			sha1_starts(&ctx);
 			sha1_update(&ctx, input, length);
 			sha1_finish(&ctx, final);
 			len = TPM2_SHA1_DIGEST_SIZE;
 			break;
+#endif
+#if IS_ENABLED(CONFIG_SHA256)
 		case TPM2_ALG_SHA256:
 			sha256_starts(&ctx_256);
 			sha256_update(&ctx_256, input, length);
 			sha256_finish(&ctx_256, final);
 			len = TPM2_SHA256_DIGEST_SIZE;
 			break;
+#endif
+#if IS_ENABLED(CONFIG_SHA384)
 		case TPM2_ALG_SHA384:
 			sha384_starts(&ctx_512);
 			sha384_update(&ctx_512, input, length);
 			sha384_finish(&ctx_512, final);
 			len = TPM2_SHA384_DIGEST_SIZE;
 			break;
+#endif
+#if IS_ENABLED(CONFIG_SHA512)
 		case TPM2_ALG_SHA512:
 			sha512_starts(&ctx_512);
 			sha512_update(&ctx_512, input, length);
 			sha512_finish(&ctx_512, final);
 			len = TPM2_SHA512_DIGEST_SIZE;
 			break;
+#endif
 		default:
 			printf("%s: unsupported algorithm %x\n", __func__,
 			       priv->active_banks[i]);
-- 
2.25.1

