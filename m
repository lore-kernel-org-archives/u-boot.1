Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF4EE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA0F7807A7;
	Mon, 23 Dec 2024 15:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cz9WydMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E7E806D4; Mon, 23 Dec 2024 15:48:47 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D62B80771
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so33594856d6.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965324; x=1735570124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+Hdz8dkLhHoH8ZELugDuge1uFhydeRq0MapwYRfScA=;
 b=cz9WydMAC9ync5nTcHPzYMaxYMnmDRkZBzHdGeSlkBqcBqrUL4JviI/T3loc6WvQ74
 cZVF2PEmk5r3i5ds0tGlSP/q4ukKxNwUJf2SffywArW8mjSANptohhZL1DBsnJaPbWW3
 AVz7wIe3YFNbO/5W1IkeMVe1WRSRhuopt1FoH0FzX7f57xRCDo+JM0xOITwd9NU6kVJU
 CELgOfL1aiQsf+oinXgXQYUWZ2xc6wSN/A3sBlvcS2y8/qEGB2FUfJcz0ZPJaXXdbuhj
 7glSr0QFofMwu/NnbGqkqCW4ESJ7t8hIArPrZV3AaV7Wpm3eD/luXQ8ctyBYZKtArMkV
 fA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965324; x=1735570124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+Hdz8dkLhHoH8ZELugDuge1uFhydeRq0MapwYRfScA=;
 b=ioWBwECviJU6jp1dbcNX+YwmP4nIwt7/gYYY8u4b0lv/580SLiTmiqi8mY6u1ihV2p
 6C/x24SYODx/l151Y12BYCDcH7jS5iq/IlgAUB3B+/H4s0bm5pnNGFBe1UtTydsoPxMo
 g+CO2QMU+w8u11zKH8mKQEGSPmtbfPvgnZ0YyLXd7gQC+EpNL/CCnXW/F2isVDCyOk4Z
 zeFTGHp9gG7glBcZDgqwt2cgzSzmgAwmzxh6BaipHXpM2dyhQnqrpaFpEJEifNecibKK
 mcoY5XnLBQmv7p2S2TsTgpCOT8e5s8plCLC4VN2at6EU+NlGReZIOh/capQq6kvD0Olw
 U3Lw==
X-Gm-Message-State: AOJu0YxgZnO98M0IKI6rkP7ZaETWXUO1UeIf1rII5wdZrb+m8NTe1LLB
 QjBBevR0/rk0b7dFXBhWLmybXSMyqCljoeDDTiosk0Tym+0dJiVi9BbNAmx6aytZjvlzTHy/w/s
 b
X-Gm-Gg: ASbGnctOJNTzds2+ZW+2cEcP6ra+ItXuoTCYWOkt6+NuTl5aV3E1/E4mycItwD0dRe3
 TFMrKF5W78KsrdGt4zEo7DRGCxiqjx2byIrq9gziUpTn+NNklyauBKuWMQ0Emj823D/VBSLOk41
 mNHYreQWTrlAX099ar6uznprC/bzZLd+iDhEVTd/gU7clCFyTtRrbBtai1+JgoVnrvYsVhyzIrE
 v3WZngFwWc85/XzIDhFscwaYKAEKbhuDyWTJ1o30KUEvoLGk5SEHMqO9/rzgFC7pnUAqztvBI8D
 tSnfXCG7WQzl8SPd1uI8jDLlz+dLCjBnsy0nOsNhzDqhCrRvGOaB3z0=
X-Google-Smtp-Source: AGHT+IEG3t8JCNslAcYh+oR2ju0jWIYn4V7mgT6NHOSNIonlMR2uSjuqVGnjbkKNiQOqyxSzANG9sA==
X-Received: by 2002:a05:6214:2b0e:b0:6d8:9677:fbe4 with SMTP id
 6a1803df08f44-6dd2331f2f8mr253750366d6.9.1734965324264; 
 Mon, 23 Dec 2024 06:48:44 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:43 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 08/11] tpm: Simplify tcg2_create_digest()
Date: Mon, 23 Dec 2024 06:47:30 -0800
Message-Id: <20241223144737.554992-9-raymond.mao@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

A previous patch is storing the active PCR banks on the TPM private
data. Instead of parsing them on the fly use the stored values.
This allows us to simplify our checks during the log creation and
parsing.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/tpm_tcg2.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7ecd53106f..9bdbe411e9 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -94,25 +94,18 @@ u32 tcg2_event_get_size(struct tpml_digest_values *digest_list)
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
@@ -139,12 +132,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
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

