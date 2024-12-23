Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8496CE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDF480741;
	Mon, 23 Dec 2024 15:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LZUhZNGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986C18074B; Mon, 23 Dec 2024 15:48:27 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F367806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso38587836d6.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965303; x=1735570103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2jQlqIo1MCHB4o9rmvhucZMe+0BwXjA8f/z7PT+ohA=;
 b=LZUhZNGRIPWpGzTFK6AbwCEvS7orn2noDc1n9ORgUEVlxAejDeAscX/gAQz0aCGj7x
 yeZbr8/Gz0OGY5jatC72lDoCWlgWzmW0gmOtXWkXeeTuRLGL06ivqLJxnpkqUyfb6frM
 pBa5i4Wk21GvFjuIFGrsKBa+0O3qxISh7McaW50Y1Lg08vftORnDPKyswZJ7eY9toWHj
 REdDlgfMnmqNvrU00JD5UHIrSR1Cv+CtCc5DclqR92oQvj3R2+1dlhYNB8rV4yjQgn8g
 TqXhFJ2nAc71pNhRNIUicsy75cZcBonuAWWZ1OcX5WzKELQS4mh6JOj1jjaILlFRm4Sr
 OTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965303; x=1735570103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2jQlqIo1MCHB4o9rmvhucZMe+0BwXjA8f/z7PT+ohA=;
 b=D2Uv6IyUfK2e75RC/gOU2rbAWi6ffVWimIG4OvoO1harvFQl0DexChn12APpox3DiY
 iLXbDyVe2GNPTiZEdbv81SgPsKRMBHFAJAu3CqgHtHXIArUM9n8pAwECgzr8dQiFiC8V
 gWOKSovPiaS32+0kZtEq0vHB47hqgnhsSnWKnEny93Je2K6ahqZAo+7ZeM6SftCqaGZu
 FKCGmLoKaGcBDch0BPPdUWQfAgq5iUENf+kiM23aifk/NKXx8QE4dwcg2SvwfaNKYey4
 5QTcs/NN3A7llXxwX/hGh+8x/F2v9JJQ2U3I3zm/CuBqRPWo1icOm6IgwChUO21aEXsm
 gGVw==
X-Gm-Message-State: AOJu0Yx/lPUcSQWPBVinL3Lgg0YDF7sU8S7iYOETImcHrm0yhORevxwU
 cfU8G4mr9qjmFR2k6zXNFUcuHOg1UOd/+xGpV7WvTuan2L53jkiR2LhKi2vLa7AMLXRAQTYGOS/
 s
X-Gm-Gg: ASbGncvBYKAsoEFwPjJFM6CT8pNFUwhuw1P/Xp7il4lVeVAPlk/hU7ilHG/+ZFmRMqa
 YKUD9rYv0vJpm89TsrgAl+8Y3M+Qzr8j7gs+ZenSmhCA1kwocclItQtiyre8GFvYZCupkCp2WsC
 Drdcd3kgFrXsYs13Y5agkiV3gZU/PIA8PbRWsUfGAIcdx3vr9yFeqSLQxaNR9ZKDlHVsTQ357wE
 fBm/h/2rQOljbu5VnLHCPnYU2ZGgPIFk0AqsksODG/TYgzcIQpRVnKvpi90IxwNTYIu3WBO2Y7l
 bvTyGm5rgQIa+w3vo4h+ldreRAyMHNifyPsaKiN5Vt/+ZNSR65cEUTs=
X-Google-Smtp-Source: AGHT+IHphCjp4YbQWmm9kQy1qRHrHHkOtWFFbHpt+07NKkidQmR5cQPacCfXxk5nXfNckovfW94jcQ==
X-Received: by 2002:a05:6214:21e3:b0:6dd:d3b:de27 with SMTP id
 6a1803df08f44-6dd2333255emr261114136d6.18.1734965303595; 
 Mon, 23 Dec 2024 06:48:23 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:23 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 05/11] tpm: add flag in hash_algo_list and API to check if
 algorithm is supported
Date: Mon, 23 Dec 2024 06:47:27 -0800
Message-Id: <20241223144737.554992-6-raymond.mao@linaro.org>
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

Add a bool var into hash_algo_list to indicate whether the algorithm
is supported or not and move the IS_ENABLED to only cover this var.
So that we can have the name, hash, mask and size no matter the
digest kconfigs are enabled or not.

In before, tpm2_algorithm_to_len() and tcg2_algorithm_to_mask() are used to
identify an unsupported algorithm when they return 0.
It is not the case now when hash_algo_list always provides algorithm size
and mask, thus a new API is introduced to check if an algorithm is
supported by U-Boot.

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/tpm-v2.h | 37 +++++++++++++++++++++++++++++--------
 lib/tpm-v2.c     | 14 +++++++++++++-
 lib/tpm_tcg2.c   | 17 +++++++++--------
 3 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 87b2c614ad..c49eadda26 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -268,6 +268,7 @@ struct digest_info {
 	u16 hash_alg;
 	u32 hash_mask;
 	u16 hash_len;
+	bool supported;
 };
 
 /* Algorithm Registry */
@@ -278,38 +279,50 @@ struct digest_info {
 #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
 
 static const struct digest_info hash_algo_list[] = {
-#if IS_ENABLED(CONFIG_SHA1)
 	{
 		"sha1",
 		TPM2_ALG_SHA1,
 		TCG2_BOOT_HASH_ALG_SHA1,
 		TPM2_SHA1_DIGEST_SIZE,
-	},
+#if IS_ENABLED(CONFIG_SHA1)
+		true,
+#else
+		false,
 #endif
-#if IS_ENABLED(CONFIG_SHA256)
+	},
 	{
 		"sha256",
 		TPM2_ALG_SHA256,
 		TCG2_BOOT_HASH_ALG_SHA256,
 		TPM2_SHA256_DIGEST_SIZE,
-	},
+#if IS_ENABLED(CONFIG_SHA256)
+		true,
+#else
+		false,
 #endif
-#if IS_ENABLED(CONFIG_SHA384)
+	},
 	{
 		"sha384",
 		TPM2_ALG_SHA384,
 		TCG2_BOOT_HASH_ALG_SHA384,
 		TPM2_SHA384_DIGEST_SIZE,
-	},
+#if IS_ENABLED(CONFIG_SHA384)
+		true,
+#else
+		false,
 #endif
-#if IS_ENABLED(CONFIG_SHA512)
+	},
 	{
 		"sha512",
 		TPM2_ALG_SHA512,
 		TCG2_BOOT_HASH_ALG_SHA512,
 		TPM2_SHA512_DIGEST_SIZE,
-	},
+#if IS_ENABLED(CONFIG_SHA512)
+		true,
+#else
+		false,
 #endif
+	},
 };
 
 /* NV index attributes */
@@ -704,6 +717,14 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
  */
 const char *tpm2_algorithm_name(enum tpm2_algorithms);
 
+/**
+ * tpm2_algorithm_supported() -  Check if the algorithm supported by U-Boot
+ *
+ * @algorithm_id: algorithm defined in enum tpm2_algorithms
+ * Return: true if supported, otherwise false
+ */
+bool tpm2_algorithm_supported(enum tpm2_algorithms algo);
+
 /**
  * tpm2_algorithm_to_len() - Return an algorithm length for supported algorithm id
  *
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 0edb0aa90c..96c164f2a5 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -884,6 +884,18 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
 	return "";
 }
 
+bool tpm2_algorithm_supported(enum tpm2_algorithms algo)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (hash_algo_list[i].hash_alg == algo)
+			return hash_algo_list[i].supported;
+	}
+
+	return false;
+}
+
 u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
 {
 	size_t i;
@@ -908,7 +920,7 @@ bool tpm2_check_active_banks(struct udevice *dev)
 
 	for (i = 0; i < pcrs.count; i++) {
 		if (tpm2_is_active_bank(&pcrs.selection[i]) &&
-		    !tpm2_algorithm_to_len(pcrs.selection[i].hash))
+		    !tpm2_algorithm_supported(pcrs.selection[i].hash))
 			return false;
 	}
 
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 16f41cbfd1..4682f7664f 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -37,16 +37,17 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank
 		return ret;
 
 	for (i = 0; i < pcrs.count; i++) {
-		u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
+		struct tpms_pcr_selection *sel = &pcrs.selection[i];
+		u32 hash_mask = tcg2_algorithm_to_mask(sel->hash);
 
-		if (hash_mask) {
+		if (tpm2_algorithm_supported(sel->hash))
 			*supported_bank |= hash_mask;
-			if (tpm2_is_active_bank(&pcrs.selection[i]))
-				*active_bank |= hash_mask;
-		} else {
-			printf("%s: unknown algorithm %x\n", __func__,
-			       pcrs.selection[i].hash);
-		}
+		else
+			log_warning("%s: unknown algorithm %x\n", __func__,
+				    sel->hash);
+
+		if (tpm2_is_active_bank(sel))
+			*active_bank |= hash_mask;
 	}
 
 	*bank_num = pcrs.count;
-- 
2.25.1

