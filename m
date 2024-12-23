Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20359E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0255E806FC;
	Mon, 23 Dec 2024 15:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oYxkn78q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35366806FC; Mon, 23 Dec 2024 15:48:36 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FA6806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4679fc9b5f1so33024481cf.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965311; x=1735570111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkbLeLofMh2KBTZutmjFrgnp+wAuGYWaa2Tc92zGGX0=;
 b=oYxkn78q4tfnPDP6q+CKtQ0wPenThVnJcIbdZDNcTCwUDbmQCfQ06Lx1pOWYxMRXxb
 6oF1v8ZOVzbBjb0tuc9fGw32adrbxw8tdW0CALTSrwySKclLb0G6qlUr0VQ9bI/4j9si
 lXvhq8NSluO69NvML2VQMthXTf2GmCnv/QptOvQaQbAJ6LxpalPvSMGYqIjBq4lmh4UH
 A/+FfLSADVAjy2gK3GaYaEuLH9/1HdjJuLZskfbSrwvAAyuPWWTJm59VxxjiZsAOQwE9
 hwXBG5/2I4O6+QitRjT0BVY8rGbz6g/6up+4mqjRn+uI7bBwY5602AogPUeeUbxjYYem
 VULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965311; x=1735570111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkbLeLofMh2KBTZutmjFrgnp+wAuGYWaa2Tc92zGGX0=;
 b=jIYp3Mlb/a+D2FFWBb7AZcNNZpEjvhhC7WZ00IAyVDuEqzQRsra8McAZfpQyKVZ8DO
 kUlRiMT9RxKshhw4E22Kwj1W+Wj+Pbl6hf2Srv+k6hoN7Iadk7mTtMgccFkxbWPCoT0i
 674T13wCIwTgoOqFJGXMJuGkF0qarC6iWAaDPED5sVVo/YZwi4gn9IopCbh/w6692I4d
 tK/2D/1Ih6hfdo+oyPX9aq+vU221NZqAVw5zHvMhMsLXRSOR6DQ12yZijeN8qgbFdjOn
 /Cj4ld15yvgG4Wft4oS6v2sveEM9nPgETI2mUsmXiwP3w/77Z1fnmmjqh3zcmOGCUccW
 FCMw==
X-Gm-Message-State: AOJu0YxNWiYqXfRezp/slbeq/uf1ImPL0Ydc7rogdjPlUUQh8EK6jcDL
 7vWgBAAV6kpHPMpY0L7pbPIIVr0mmwdYtiEGN5OSj7v7zatkANORrwJf3Grq405KhmvwlCouT79
 p
X-Gm-Gg: ASbGncvPwfYvA8MQRTAqcGNewo++u7VSymOl3tzwdPIIr7dzl2sZ9lY/cw6VsBQxV6w
 XoIauKMdo7ldRhPSBvG8NU70TOo0uD2wykDRl2Tw2ytl6W9zNoxdCdjhg5Ltc+3u8rj+uHYAtfo
 DdR4bYxj1ESs0colu+M6eqLr3VD0mW9TsHbcHTaoHQFhKwTobFJW5tDO7RPyUHWtDZVMZoftvYD
 JgtG2W+SdelFiOiZxN5Q69+mtEeTQuc4hDwVUoRpqqPtz9y4XSOVZicSeM+47v7yT+E8ls+PSN8
 SG6VFq3PXEjSvjWdCoJ5DCWt0+z0H5RGH7LxNsFZdMueVtNdZiwmKyA=
X-Google-Smtp-Source: AGHT+IENppNRUjaf5MjG/h/cly9y+5uqt9I2SHikXtkJSCkIjdG5rveXC+VyrKQqmKD86HJOCnNLjw==
X-Received: by 2002:a05:622a:14c:b0:466:8616:2553 with SMTP id
 d75a77b69052e-46a4a9a3503mr222692571cf.48.1734965310861; 
 Mon, 23 Dec 2024 06:48:30 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:30 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 06/11] tpm: Don't create an EventLog if algorithms are
 misconfigured
Date: Mon, 23 Dec 2024 06:47:28 -0800
Message-Id: <20241223144737.554992-7-raymond.mao@linaro.org>
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

We already check the active banks vs what U-Boot was compiled with when
trying to extend a PCR and we refuse to do so if the TPM active ones
don't match the ones U-Boot supports.

Do the same thing for the EventLog creation since extending will fail
anyway and print a message so the user can figure out the missing
algorithms.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/tpm-v2.h |  7 +++++++
 lib/tpm-v2.c     | 23 +++++++++++++++++++++++
 lib/tpm_tcg2.c   | 27 ++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index c49eadda26..6b3f2175b7 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -770,4 +770,11 @@ bool tpm2_check_active_banks(struct udevice *dev);
  */
 bool tpm2_is_active_bank(struct tpms_pcr_selection *selection);
 
+/**
+ * tpm2_print_active_banks() - Print the active TPM PCRs
+ *
+ * @dev: TPM device
+ */
+void tpm2_print_active_banks(struct udevice *dev);
+
 #endif /* __TPM_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 96c164f2a5..bac6fd9101 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -926,3 +926,26 @@ bool tpm2_check_active_banks(struct udevice *dev)
 
 	return true;
 }
+
+void tpm2_print_active_banks(struct udevice *dev)
+{
+	struct tpml_pcr_selection pcrs;
+	size_t i;
+	int rc;
+
+	rc = tpm2_get_pcr_info(dev, &pcrs);
+	if (rc) {
+		log_err("Can't retrieve active PCRs\n");
+		return;
+	}
+
+	for (i = 0; i < pcrs.count; i++) {
+		if (tpm2_is_active_bank(&pcrs.selection[i])) {
+			const char *str;
+
+			str = tpm2_algorithm_name(pcrs.selection[i].hash);
+			if (str)
+				log_info("%s\n", str);
+		}
+	}
+}
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 4682f7664f..7ecd53106f 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -568,11 +568,36 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 			    bool ignore_existing_log)
 {
 	struct tcg2_event_log log;
-	int rc;
+	int rc, i;
 
 	elog->log_position = 0;
 	elog->found = false;
 
+	/*
+	 * Make sure U-Boot is compiled with all the active PCRs
+	 * since we are about to create an EventLog and we won't
+	 * measure anything if the PCR banks don't match
+	 */
+	if (!tpm2_check_active_banks(dev)) {
+		log_err("Cannot create EventLog\n");
+		log_err("Mismatch between U-Boot and TPM hash algos\n");
+		log_info("TPM:\n");
+		tpm2_print_active_banks(dev);
+		log_info("U-Boot:\n");
+		for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+			const struct digest_info *algo = &hash_algo_list[i];
+			const char *str;
+
+			if (!algo->supported)
+				continue;
+
+			str = tpm2_algorithm_name(algo->hash_alg);
+			if (str)
+				log_info("%s\n", str);
+		}
+		return -EINVAL;
+	}
+
 	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
 	if (!rc) {
 		log.log_position = 0;
-- 
2.25.1

