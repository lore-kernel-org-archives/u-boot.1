Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916D4E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149A38074B;
	Mon, 23 Dec 2024 15:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hRJPh57n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597A1806D4; Mon, 23 Dec 2024 15:48:54 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2792980772
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dd43b08674so6363006d6.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965331; x=1735570131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pXRDvtvikqOzhgTDXurgJCfUnLKfKJjdJgJ5RV1OWk=;
 b=hRJPh57nfOXPUfKYZArZiJ/9TmGGG7DliH48Nk5/fYij2FbKexKAp5aQ4jF/260O8T
 KXjrqvvXl2OjVuClHCj60nnKS1gdA7xXzarguQfPgkVSV3JmNwDd2RrvOQdqw5qA3vv1
 PdGhYCQBC1lEnOJJA3vl5hd7fLSf/DXMaXRxtRXQOwj78hcQ3GAlRJEUUh7kOXba1fF1
 GpT4OWG2ZnLu/CBX2rz/cL4HHXZZmkBWtZDVfG3/ffAcmVlVkLOormHNIiJTvVXIyn5Q
 33MpBDOyE2a1BpqV579/Mc141EZmlZyc0/EjT77WL+4b75JTQWXjixK11dBI4IlUfUKF
 4tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965331; x=1735570131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pXRDvtvikqOzhgTDXurgJCfUnLKfKJjdJgJ5RV1OWk=;
 b=dIvNq+bQUowARZBwdzdQZKrvpd8pGiqmJAwD3myYHRPbuVsdHmXg6eV8FpogS6FmG3
 v8Qu9fxWkY3eVcHG8GWSt2s+bpzH8ldRGZRvybmsIUX37Bj5oCzOY/ciqz1xCghTV44I
 4LLTG5wwilmsoKr22KCCb/PxPuYLi+gjXuR3FSRm3UmDgf4pTywCTo3UpMtFeXN5WhVn
 urLxk0dLHCBWjn83HOI2XOnCyAyZzwlETLbWpqIj8W3vDQ1LqvjmwriVGLrIQYklAhWK
 V2WgBUHFNGqNCnqTK9yRTpdK6Et8XeSkWpyJ0zxWKPzP6Xtyl5qUSFiUgzGyRQy+txoG
 jfQg==
X-Gm-Message-State: AOJu0Yxu1pa2LZBo6xG3tLoXvkRWb4jVNrbHDWDlcUix1oLW4fYBQUq5
 FC6q9tCv/ftExJ798ZW4l2fwqhH6VVnB9sS7tvZ8kN7EaGQV59E0Acv6whGxYvkZ/E1VeH54Uef
 M
X-Gm-Gg: ASbGncusJMhj9uMoAthg7QYXeAPcP94yA+UdpeJOyogwU+DihxT8oBiiCXU2oKy/5RL
 zZHDpFJrA0vKSnWssuP5ic2Tk5xUmVhIRJylpbZZqufl6oW5CWN+E7OHo5H8XU+wrT3PN5T/uPw
 rz9Ppbl6Zuqyn66BSPjFM3RuZTQGKy7+1348bViOyAIZA16w1Nj9pm4D+xi01vU2+Rp4AdECxpu
 dqiLEQcOi1Hf+P3TL6hFPBtGdDaeLyZN3cM50eW+jNSvXgd4bjZYl3T3vNsaPBUhnpyfJgLJQYU
 pri8xaZy50TzvmyBYrlJZDBepvI/e9XrGbHA3x+PPeuS6yYa523I14w=
X-Google-Smtp-Source: AGHT+IEa0luSMnr0f0DPPjGowzt4yLwfYW5WHDVBtWjQufPnZcLmyYrCxsr9KrrudFXoucC3zgb6uA==
X-Received: by 2002:a05:6214:2589:b0:6d8:a76d:b66c with SMTP id
 6a1803df08f44-6dd2339e08fmr199577346d6.30.1734965330915; 
 Mon, 23 Dec 2024 06:48:50 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:50 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 09/11] tpm: Simplify tcg2_log_init()
Date: Mon, 23 Dec 2024 06:47:31 -0800
Message-Id: <20241223144737.554992-10-raymond.mao@linaro.org>
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
 lib/tpm_tcg2.c | 42 +++++++-----------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 9bdbe411e9..72969923a9 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -208,37 +208,17 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
 
 static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 {
+	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
 	struct tcg_efi_spec_id_event *ev;
 	struct tcg_pcr_event *log;
 	u32 event_size;
 	u32 count = 0;
 	u32 log_size;
-	u32 active;
 	size_t i;
 	u16 len;
-	int rc;
-
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
 
+	count = priv->active_bank_count;
 	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		switch (hash_algo_list[i].hash_alg) {
-		case TPM2_ALG_SHA1:
-		case TPM2_ALG_SHA256:
-		case TPM2_ALG_SHA384:
-		case TPM2_ALG_SHA512:
-			count++;
-			break;
-		default:
-			continue;
-		}
-	}
-
 	event_size += 1 +
 		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count);
 	log_size = offsetof(struct tcg_pcr_event, event) + event_size;
@@ -265,19 +245,11 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 	ev->uintn_size = sizeof(size_t) / sizeof(u32);
 	put_unaligned_le32(count, &ev->number_of_algorithms);
 
-	count = 0;
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		len = hash_algo_list[i].hash_len;
-		if (!len)
-			continue;
-
-		put_unaligned_le16(hash_algo_list[i].hash_alg,
-				   &ev->digest_sizes[count].algorithm_id);
-		put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
-		count++;
+	for (i = 0; i < count; ++i) {
+		len = tpm2_algorithm_to_len(priv->active_banks[i]);
+		put_unaligned_le16(priv->active_banks[i],
+				   &ev->digest_sizes[i].algorithm_id);
+		put_unaligned_le16(len, &ev->digest_sizes[i].digest_size);
 	}
 
 	*((u8 *)ev + (event_size - 1)) = 0;
-- 
2.25.1

