Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61B6E7718D
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD2C807F3;
	Tue, 24 Dec 2024 17:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EoC/qt75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97374807F3; Tue, 24 Dec 2024 17:02:27 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B18D807A7
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso47435166d6.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056144; x=1735660944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2VhuhWev08n7KBuwrziMpMb5kDsTDxhBH5Dd01NiOE=;
 b=EoC/qt75n9dN5UJAxiISVXrXquMkZXGKQYJCdq6cC/R2+cIa/rGwHwmqJMabgICuIs
 GpmzjSMtSqnLEAMfb8nlCO6XVntWsS7qL6B1CmMK+ZgCKazNv7c4JcEjoRqIMz02a33o
 tjLEHn1Sg4D7f7eEq2QutSu+sxoiIC1UCIV8HXZj13+Tu5GDxgBYo956bMrpFwGn71k8
 VM05uVRFzGaX7d/c6uPjo1jbhabBb0ozPGoeVF7+RtUA3lExeXaPzOr/7inK6gCAEdhx
 hbCE9GN2wZaGeMmSTI8UVeHq7+iHEs7tqx3kG3Fa53D61ZG+JNOXXYg3IAKjZ3ShYp4V
 2HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056144; x=1735660944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d2VhuhWev08n7KBuwrziMpMb5kDsTDxhBH5Dd01NiOE=;
 b=qBjHi6nYZO/K8wlkrkC+QaOZw4OoVjw1OSjjHG+qnstwJkeJFUDbT/OstDX+62nkjK
 wZXL/2/4eVPPDn6rOvH5cDeygbpCPwrFD1ZhA3uyxtsXGKf1iKLhUr7fSWMLa55nL/et
 g3dW0dVbETuxj9jJviXf7iasDuge7H2RAl3jhvOa/TTR0psEPrDJOpKdr7pRRrV4HTh6
 GBlyGibDYMc1XyR9z2vlmStDAYID177pSijJLzml4W3N2xix1pOi85NvCBuAxxa7yF5h
 ekfJ7bKeIpoyHdm09MyPn3B2L7ioyCjhngUXSDQuzMqP/Bq0C8yaCH3UA38jOCQaFtQo
 xqBA==
X-Gm-Message-State: AOJu0YxideLZiBEAiTYGFsUIEFBVsg4x2tFzUWYtL7iCRTKb20k+OI40
 +MSLL6o2mMJi1nITfK0/SLJLUe6EtjSp91Y/2PZO65Dp3PM2kEv3o5nfr4wIMWMGiLtdZo9wGsk
 j
X-Gm-Gg: ASbGncu/4lYx21JgXhNPpUXa7JrdfdnPhcVCYQNo7i/zhtSfVN3Vgc0pUyUhqVbKJG1
 8meWcCoJ8GEo87BWCHRG2V983epzKIA4cxl0VwuAgE8/Q8uts5S51tsJdaZ18dzxc9FalzVgA0I
 T9ILf0b8kO6DRDNbQYyNuPu/kqpY7RJtts0lJdlwmsPQ3uyAbl+XOG8ysQlPdOJgd36lGArhQCe
 5I3PZ47GaF8sqHCZcJKozXEBxsxGxH79n8uCEKlR9B/tZ90W0xxLHEgLtUuenE12dhRokEAWAvN
 F6XC5sAPkW2XwN+bksQz4RUw+xRxiUbjSKO9NqIc79ZnuBBTub+Qy08=
X-Google-Smtp-Source: AGHT+IGzb9Dk/00IcKU+vjDMQkG0jpM7ycept6Udfx1VUWlb1JGmNqalYVYA8Yflebsz6SVqT0ckZA==
X-Received: by 2002:a05:6214:5199:b0:6d4:ac4:c1cd with SMTP id
 6a1803df08f44-6dd235aa23cmr267719436d6.8.1735056144217; 
 Tue, 24 Dec 2024 08:02:24 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:02:23 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 08/11] tpm: Simplify tcg2_create_digest()
Date: Tue, 24 Dec 2024 08:01:10 -0800
Message-Id: <20241224160118.675977-9-raymond.mao@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

A previous patch is storing the active PCR banks on the TPM private
data. Instead of parsing them on the fly use the stored values.
This allows us to simplify our checks during the log creation and
parsing.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 lib/tpm_tcg2.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index e77a904129..9e63204f24 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -93,25 +93,18 @@ u32 tcg2_event_get_size(struct tpml_digest_values *digest_list)
 int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 		       struct tpml_digest_values *digest_list)
 {
+	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
 	u8 final[sizeof(union tpmu_ha)];
 	sha256_context ctx_256;
 	sha512_context ctx_512;
 	sha1_context ctx;
-	u32 active;
 	size_t i;
 	u32 len;
-	int rc;
-
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
 
 	digest_list->count = 0;
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
+	for (i = 0; i < priv->active_bank_count; i++) {
 
-		switch (hash_algo_list[i].hash_alg) {
+		switch (priv->active_banks[i]) {
 		case TPM2_ALG_SHA1:
 			sha1_starts(&ctx);
 			sha1_update(&ctx, input, length);
@@ -138,12 +131,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 			break;
 		default:
 			printf("%s: unsupported algorithm %x\n", __func__,
-			       hash_algo_list[i].hash_alg);
+			       priv->active_banks[i]);
 			continue;
 		}
 
 		digest_list->digests[digest_list->count].hash_alg =
-			hash_algo_list[i].hash_alg;
+			priv->active_banks[i];
 		memcpy(&digest_list->digests[digest_list->count].digest, final,
 		       len);
 		digest_list->count++;
-- 
2.25.1

