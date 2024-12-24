Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6031E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC238081A;
	Tue, 24 Dec 2024 17:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jWOb/TFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C186C80352; Tue, 24 Dec 2024 17:02:07 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB59801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d8edad9932so35061026d6.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056124; x=1735660924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HW2HlEX4l0bFEEf3u5gO/ZxP5rRhv9uAXpNoxO31agQ=;
 b=jWOb/TFbFETEa3d6ZQ7qaXjOfxobpJDfQgQj1BFI73F1aws1lxuDNHDr8kpQ5E3vha
 +TqohwZn1vi3HHhuFbZ0O+GyKk8Fsy2si2vwbVSdQZyuWFAv0Qqt90EWVbezb4oKR4aC
 3xFOHhZ3UA5LjrmFoYbryydOrbZJprmuyCOoVCELih5R6S6vhTnRdwyw2secGqddu7lo
 lEBbsfnbeOwWmcamt7DUIVvgNQSYSDTVTwu81W2y6GlITgUbTlYpPPVjJkPPGVNkgkET
 hMCTnNcEvi6PyiJe3aV6an9CPd+nltrvdZkyaLq8kDV2ywhUqC3I0Ft8UexlJ2qWPMwr
 +O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056124; x=1735660924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HW2HlEX4l0bFEEf3u5gO/ZxP5rRhv9uAXpNoxO31agQ=;
 b=oRaV0+ZHV1qT7gLAaUfPxOlhvlb8Pe7uW01iDiGJ+snGGAD6zlGH73OcREtRUS/Rs7
 KxL6K51KxqGiePJU4RXlaOHTuyuaEvAMKBSh5tkHjzd/2xcXVlhu3+ByzrX2h+kl7JYo
 biHX+8RAMJdXyQEW+laQKxjaYc9XK/6VRwX2ncTv0X6EO22T5HG0jY23UWBxlyTD6BdM
 D0HA9Ct1FSPKrsfLIxjy8kbNbOE79EiewvVbItaLxUG024bPCKtBM2q5+2irwzvJrQur
 gBvoJxqQ37mhHDK/TC2OGlkoVpW/cE2jfL7r13NLEYLb35L8BCYroAsok3OLbowoQrdk
 eztg==
X-Gm-Message-State: AOJu0YzivwEupk/vURDi0mBM89dnn3t17DOJ+dsKfffmNEdQAYqXapje
 ndAoVy3kNMY4MRLBxsDvtRRtwWUnEShMqlQPwEEiNDFvIFEWAD1tUzYFt7U/aCKuTOJCWkpIfPW
 J
X-Gm-Gg: ASbGnctR1GBQ2VJe2R0DbCKLPyzerxWd2vfPGFqDv22XTYaS1XE70WNbpOXmIlWuXrC
 G8xpQPM/HFt+DgSN7FJFVOFAxZZ0WX3Q7K5MNjFlOncpLk1a43tXkQwwPOvAlyhyJnx+pLnbVJA
 5HBBQ12STWjsYzkpV3sjg2yU61eIdXWipzOMmPC3FdW4tKOhXaUVsYS/feoE/KRA79RddEY73YY
 vsWL1adhDOgri0ftWWLIbRR3SWnxYXZ+3xJx7N0H1VIRLpX907BryXg0GQoYGVynWhN0qXjfnLp
 DFFftNeXQlrmx0QP0PFmFbqhUmDbgqEQAcqMOhx0ALz44VrY4NUtZjg=
X-Google-Smtp-Source: AGHT+IGf4HNIG0tVYU5CARAnOZkeb3w8RBgljR7klUhhNjdYOGA21Z020yTOButjmgiCCbhLXCZJLg==
X-Received: by 2002:a05:6214:4187:b0:6d8:a027:9077 with SMTP id
 6a1803df08f44-6dd2331f1dfmr295374506d6.5.1735056123230; 
 Tue, 24 Dec 2024 08:02:03 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:02:02 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 05/11] tpm: add flag in hash_algo_list and API to check if
 algorithm is supported
Date: Tue, 24 Dec 2024 08:01:07 -0800
Message-Id: <20241224160118.675977-6-raymond.mao@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.

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
index 0e267ff0a7..99671804e3 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -36,16 +36,17 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank
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

