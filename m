Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5A9E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD8A807A7;
	Tue, 24 Dec 2024 17:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rvsl8HkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D4D80817; Tue, 24 Dec 2024 17:03:42 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43DDE80352
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso75600766d6.2
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056219; x=1735661019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slwFkaLgVc5VgH4orJIvGMWHBrrjU/4aFDO9O04a4KU=;
 b=Rvsl8HkFoh19oNsAx5fO/oROe9JwZ5/Zq7ln+La3S3AKbJzaiBq1QRJAnZxRk0rpkc
 B3cB/PFM3TTD7Eh0QlZGrR6XttOHUCJmFQdTSHFZCc5w40+406y9/bm5N8eq8vl2yh++
 jLHOwyIKYQiBu4G2yRftchbtr9gsugW4mCKHddam3zCNYRtMtXNh7Xw8e2K4YUcRBXxh
 4K19sHDsz9TWFiyJEsgUcvsDhiMemoxoAQvvi7Wup2JToDLnCIn8st63chRsNYu3vM8T
 72QXLTK2RWwHpNGzUA1pCkib7wGjYNU1ZABg2Z/wvAIfuD8rFD1Zi6vaj0Dpf9Bp9BOn
 r0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056219; x=1735661019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slwFkaLgVc5VgH4orJIvGMWHBrrjU/4aFDO9O04a4KU=;
 b=t/gPlEtZHJstpV9hVnAGCUZxxvLu1R5dk4KfTitz5M2KbF3zLV0K3DWrCOgIElRm2U
 TIqPrqa/IxRSfsCahKOsmFzG44kYSOW0o2PjYRa4sU7f8kijy9avH5AhruQiDLnc/LBq
 nzM8XQoO35vzib5KjPS0hQ0y2yfointV6CX0Ye/XGGg6kxgYrV1aTJlUAR8Fr1hJGGw3
 L6NkVZEzziBqwoL6RTach3GHrDWeta6rN1sX+oezYeDRoaThZKDlEKBqNrccGZN7UkdS
 CrR3U/Lod9yLrN4U3tQTBC72YzaSiR0aThCd/LsgesIwMRm6d2pKPJeafUqFigEfSzRl
 jvXw==
X-Gm-Message-State: AOJu0YyKgq7SUA4q9m4n8CBMAzrTtJWgY1DXSVojjTHk9hrLrxVH+VDZ
 HlCvMReUNUZM+LlLH8re325WmIMDaqc4ecFZgC33DCKGQBRVVow0teHik+n3hMsGSgpq+FyQzcQ
 p
X-Gm-Gg: ASbGncvQSdIrZQCRlMxTgfSEb9fguppzHTdEdwMjs2pCZEsa235+k2I49soUHSbdaoT
 //1XgqH+Hjgs56rqD/zu5KGpK+IP+O07/3k54lqzj/93W8T/yCI4aE5iKkJQ32tM/71vwBlRCxZ
 ktVsx9j6wQUqDUbOCWY9BQEmzZ7G2u4UYIOLjPvQZJPiRqzr9beM4HCamcWdRMRzrRHVL5BTapf
 pU19XScqqbCXgTF6rmdzmjInVn2yo4jwTH1nWuFT+B+7n02vj2miX5JIcP8Hktm7sufx0EwPWf6
 46W38qNipBDK2N+vz0twzEjTAqtfow0ZXBdoRTewukswS+Yr7Q5Dkd0=
X-Google-Smtp-Source: AGHT+IHr/xhSLwPBU/nbaAEBmbNIcXVte73vt0qQuaqxTUut6+MxuNahdOaMoiivhwhei6r4dMricw==
X-Received: by 2002:a05:6214:1249:b0:6d8:981d:529 with SMTP id
 6a1803df08f44-6dd233a320fmr292925986d6.48.1735056215172; 
 Tue, 24 Dec 2024 08:03:35 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:03:34 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 11/11] tpm: add kconfig control in tcg2_create_digest()
Date: Tue, 24 Dec 2024 08:01:13 -0800
Message-Id: <20241224160118.675977-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224160118.675977-1-raymond.mao@linaro.org>
References: <20241224160118.675977-1-raymond.mao@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.

 lib/tpm_tcg2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 37818fcc85..4134d93a35 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -95,9 +95,15 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
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
 
@@ -105,30 +111,38 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
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

