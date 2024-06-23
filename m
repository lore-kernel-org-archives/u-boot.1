Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3BFC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273DD882B8;
	Sun, 23 Jun 2024 13:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZAKkytzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB3D882B8; Sun, 23 Jun 2024 13:49:20 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8E48855C
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d203d4682so4068395a12.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143356; x=1719748156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pw5H0u0c48y+4fn8JouCrrGyjr+gXdfIWa2gd781q3U=;
 b=ZAKkytzbrCNKEvNbRd+qc31vNIOogicUxcz2ylv9HZ6BmJD+sdxrn+xbCYRR/RxGml
 /TJPGFH18cz9IStiapOqipRS4yfVtmy5TXP1yHAeJ/ool42BsJnYKUyuXtao/j3mL3rX
 0FPDoiKeA7vU/cdiilL4CiGAXDo6hD/JfHKqJ+4aG6EWO6jfHvkbvjdaoffKB6NXzr/P
 GrOTiOj5ldhc92XdDNbBBC0yj7W30h3HBXQvEXYGYkvs+vfOIyos9XUcf+Ex92sl0t0U
 j4dHrFgaJy5sllGo1DjcMKidv8oszhidSlz+Ye9cwPKu1bTiF/NBGnYOgRFZ2hd9QxtP
 ctpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143356; x=1719748156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pw5H0u0c48y+4fn8JouCrrGyjr+gXdfIWa2gd781q3U=;
 b=etEzqWo+JHFS5uOCtwtDsVGwTpRDxMMtsFg+rvSwUJJi/l11q4ACxOY5So1FkQfMdy
 kldxAu+hG+bR+iltM1U8077zMSPmEE8d/vjihwhn1bjURBbQx2OSszedkToM9CmAqqwZ
 X6kfxq8DiXQyLm3l1hCVGvayvyFP0A1ZWnSy3T8+Vze/5Qv3jni72mhWklA6bGA7qjIz
 lKb/Qy1qH5Z9I5zIOd/8rteKN8RGYf2SGh4/d65oOAlROghSCAoVF13okyK+GCcyAbXN
 s9B5Ify8q36PeAt9UViVeceOx+wxYhxKX5jQa7Syht/GuOAAidOBDkAoBbwsL49WVgV3
 w7Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1t/ONqz23RSSH26JqhfvFP2lctBFJCwsKhuEeQs4da+CXKj0fnf0Ap7mpKG7kjuEeuhOnn/I392y7oI4s1I7A8bO+5A==
X-Gm-Message-State: AOJu0YzcJdOvYm/Q/AKrAJu8W2UYx3KHg0ZI+dhdLlPitpZ8JCo5OAkK
 PWOwJRdMcDb/A2QVY3f3Ha/+wLnl0UUl+UsmrrH7v9xDXVSE2XmEUQuA4evNF7pt/cgj+3MMfCF
 uARg=
X-Google-Smtp-Source: AGHT+IH78uzZL4tsYDhoqjV4RBKA3ucdeOVa/KJFyr31tY91G+goXbkFO0x8JbpNmg9KALG+zxedXw==
X-Received: by 2002:a50:9318:0:b0:57c:71a4:3142 with SMTP id
 4fb4d7f45d1cf-57d45791e60mr2073564a12.11.1719143356274; 
 Sun, 23 Jun 2024 04:49:16 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:49:15 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 8/8] tpm: allow the user to select the compiled algorithms
Date: Sun, 23 Jun 2024 14:48:18 +0300
Message-ID: <20240623114838.14639-9-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
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

Simon reports that after enabling all algorithms on the TPM some boards
fail since they don't have enough storage to accommodate the ~5KB growth.

The choice of hash algorithms is determined by the platform and the TPM
configuration. Failing to cap a PCR in a bank which the platform left
active is a security vulnerability. It might allow  unsealing of secrets
if an attacker can replay a good set of measurements into an unused bank.

If MEASURED_BOOT or EFI_TCG2_PROTOCOL is enabled our Kconfig will enable
all supported hashing algorithms. We still want to allow users to add a
TPM and not enable measured boot via EFI or bootm though and at the same
time, control the compiled algorithms for size reasons.

So let's add a function tpm2_allow_extend() which checks the TPM active
PCRs banks against the one U-Boot was compiled with. We only allow
extending PCRs if the algorithms selected during build match the TPM
configuration.

It's worth noting that this is only added for TPM2.0, since TPM1.2 is
lacking a lot of code at the moment to read the available PCR banks.
We unconditionally enable SHA1 when a TPM is selected, which is the only
hashing algorithm v1.2 supports.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/Kconfig     |  4 ++++
 include/tpm-v2.h | 59 +++++++++++++++++++++++++++++++++++-------------
 lib/Kconfig      |  6 ++---
 lib/tpm-v2.c     | 40 +++++++++++++++++++++++++++++---
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6f..b061891e109c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
 config MEASURED_BOOT
 	bool "Measure boot images and configuration when booting without EFI"
 	depends on HASH && TPM_V2
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index aedf2c0f4f5c..4fd19c52fd70 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -278,48 +278,40 @@ struct digest_info {
 #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
 
 static const struct digest_info hash_algo_list[] = {
+#if IS_ENABLED(CONFIG_SHA1)
 	{
 		"sha1",
 		TPM2_ALG_SHA1,
 		TCG2_BOOT_HASH_ALG_SHA1,
 		TPM2_SHA1_DIGEST_SIZE,
 	},
+#endif
+#if IS_ENABLED(CONFIG_SHA256)
 	{
 		"sha256",
 		TPM2_ALG_SHA256,
 		TCG2_BOOT_HASH_ALG_SHA256,
 		TPM2_SHA256_DIGEST_SIZE,
 	},
+#endif
+#if IS_ENABLED(CONFIG_SHA384)
 	{
 		"sha384",
 		TPM2_ALG_SHA384,
 		TCG2_BOOT_HASH_ALG_SHA384,
 		TPM2_SHA384_DIGEST_SIZE,
 	},
+#endif
+#if IS_ENABLED(CONFIG_SHA512)
 	{
 		"sha512",
 		TPM2_ALG_SHA512,
 		TCG2_BOOT_HASH_ALG_SHA512,
 		TPM2_SHA512_DIGEST_SIZE,
 	},
+#endif
 };
 
-static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
-{
-	switch (a) {
-	case TPM2_ALG_SHA1:
-		return TPM2_SHA1_DIGEST_SIZE;
-	case TPM2_ALG_SHA256:
-		return TPM2_SHA256_DIGEST_SIZE;
-	case TPM2_ALG_SHA384:
-		return TPM2_SHA384_DIGEST_SIZE;
-	case TPM2_ALG_SHA512:
-		return TPM2_SHA512_DIGEST_SIZE;
-	default:
-		return 0;
-	}
-}
-
 /* NV index attributes */
 enum tpm_index_attrs {
 	TPMA_NV_PPWRITE		= 1UL << 0,
@@ -712,6 +704,41 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
  */
 const char *tpm2_algorithm_name(enum tpm2_algorithms);
 
+/**
+ * tpm2_algorithm_to_len() - Return an algorithm length for supported algorithm id
+ *
+ * @algorithm_id: algorithm defined in enum tpm2_algorithms
+ * Return: len or 0 if not supported
+ */
+u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
+
+/*
+ * When measured boot is enabled via EFI or bootX commands all the algorithms
+ * above are selected by our Kconfigs. Due to U-Boots nature of being small there
+ * are cases where we need some functionality from the TPM -- e.g storage or RNG
+ * but we don't want to support measurements.
+ *
+ * The choice of hash algorithms are determined by the platform and the TPM
+ * configuration. Failing to cap a PCR in a bank which the platform left
+ * active is a security vulnerability. It permits the unsealing of secrets
+ * if an attacker can replay a good set of measurements into an unused bank.
+ *
+ * On top of that a previous stage bootloader (e.g TF-A), migh pass an eventlog
+ * since it doesn't have a TPM driver, which U-Boot needs to replace. The algorit h
+ * choice is a compile time option in that case and we need to make sure we conform.
+ *
+ * Add a variable here that sums the supported algorithms U-Boot was compiled
+ * with so we can refuse to do measurements if we don't support all of them
+ */
+
+/**
+ * tpm2_allow_extend() - Check if extending PCRs is allowed and safe
+ *
+ * @dev: TPM device
+ * Return: true if allowed
+ */
+bool tpm2_allow_extend(struct udevice *dev);
+
 /**
  * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
  *			  supports the algorithm add it on the active ones
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa1..b3baa4b85b07 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -439,9 +439,6 @@ config TPM
 	depends on DM
 	imply DM_RNG
 	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
@@ -449,6 +446,9 @@ config TPM
 	  command to interactive the TPM. Driver model support is provided
 	  for the low-level TPM interface, but only one TPM is supported at
 	  a time by the TPM library.
+	  For size reasons only SHA1 is selected which is supported on TPM1.2.
+	  If you want a fully functional TPM enable all hashing algorithms.
+	  If you enabled measured boot all hashing algorithms are selected.
 
 config SPL_TPM
 	bool "Trusted Platform Module (TPM) Support in SPL"
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 36aace03cf4e..59e6cbafafaa 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -196,6 +196,11 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 
 	if (!digest)
 		return -EINVAL;
+
+	if (!tpm2_allow_extend(dev)) {
+		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
+		return -EINVAL;
+	}
 	/*
 	 * Fill the command structure starting from the first buffer:
 	 *     - the digest
@@ -409,11 +414,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 
 	pcrs->count = get_unaligned_be32(response);
 	/*
-	 * We only support 5 algorithms for now so check against that
+	 * We only support 4 algorithms for now so check against that
 	 * instead of TPM2_NUM_PCR_BANKS
 	 */
-	if (pcrs->count > ARRAY_SIZE(hash_algo_list) ||
-	    pcrs->count < 1) {
+	if (pcrs->count > 4 || pcrs->count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
 		return -EMSGSIZE;
 	}
@@ -880,3 +884,33 @@ const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
 	return "";
 }
 
+u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (hash_algo_list[i].hash_alg == algo)
+			return hash_algo_list[i].hash_len;
+	}
+
+	return 0;
+}
+
+bool tpm2_allow_extend(struct udevice *dev)
+{
+	struct tpml_pcr_selection pcrs;
+	size_t i;
+	int rc;
+
+	rc = tpm2_get_pcr_info(dev, &pcrs);
+	if (rc)
+		return false;
+
+	for (i = 0; i < pcrs.count; i++) {
+		if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
+		    !tpm2_algorithm_to_len(pcrs.selection[i].hash))
+			return false;
+	}
+
+	return true;
+}
-- 
2.45.2

