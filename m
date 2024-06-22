Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C409AC27C78
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84D388261;
	Sat, 22 Jun 2024 16:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h7jvv0LT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE1C878E2; Sat, 22 Jun 2024 16:36:52 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F54D881C1
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7245453319so5514966b.1
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719067009; x=1719671809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHixSKTgHr1vQBMgBi4j0zUifCR88z9fhOUh+rxTU5o=;
 b=h7jvv0LT2aZBqjfjZDxt472EyfhR/i+aD17tTmYSRXXU10m8AT1ZwFxleq+oukcaTe
 oboHOnV/tE50zNk9PPSSNUU9shUtlC4/PF5er/9WV4AcCjM8vsQWxGLuz54cIXV+tbh9
 li/REQ6SQ3EvqHfZkq12fx1mV77e25PCaO7IFXy2fs/UBnFP5zu380vMWlfWq+3CRpfv
 ZCE4RVb/QQsEP+AK/KSqxBszXNXzNn9ECidueI7q9Lh2m/OC5BvY1EQ90pwwS/9ePtUH
 h2HE+L6i7YrZytvQ4kxq0WOTI070yU+j8bD+hJGDoAuYXCWEM9KzO7HChR/8QedV2OVG
 81pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719067009; x=1719671809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHixSKTgHr1vQBMgBi4j0zUifCR88z9fhOUh+rxTU5o=;
 b=a1k2lRnKQ9c+LSm9xMBrRQKzHuPghjSrMHdTZFMsbdIbOqJZzDMcpzx36i+3ltRw/D
 gQ2UC6bk1gAb/6+koK6wNv3BvQ+TmJxdQT8GI8cevDcYYqn9X2KRmaR+lCNC75RAHoXy
 KLQiZM1C7sZte158vhezOobfJByFB4o4q0my1NaK8oIhmUMIjswIdfPXg+2q3Ag16ZcA
 wX4aYYC9Q/N5ggDDGMEVCDkihFRWDZMBonM+3GZ71u3dkQkIuEz6Q2dI9UyHnWTtlAoS
 rbGZtQ8lx9Dod6udmvXvCMNDMAEbwD3fQjOF3zEV2ccHAoV0ylUEBOEOSrm9AtTPIzjH
 w07g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQgNnNxxiTZOHUiJDTKQUI/JPYD5iI9WusOwi0ki/WoOgNsWe1frVc9vSCONhLSyeKk3x4OYr18aTJT59OtuMOaJal9w==
X-Gm-Message-State: AOJu0Yz+jkTOtBZPYhivFa4IJzBrrLYJHdn2HC/R2laFP9SxrM7GhqT1
 g3tDt0REscNvX/kJByMVQkEo+uB61AtTXiU4hZ+354fXqxD9DtJKN/hHzeduQSU=
X-Google-Smtp-Source: AGHT+IFZirEYUcQTfmZRcy/0qxadtThtruNl13e0KBTZiZ5r2vF0jzR6ddI3qMCU65rLoZHGDwkx4Q==
X-Received: by 2002:a17:906:34c7:b0:a6f:e151:75ca with SMTP id
 a640c23a62f3a-a700e707029mr99623966b.30.1719067009487; 
 Sat, 22 Jun 2024 07:36:49 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:48 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 7/7] tpm: allow the user to select the compiled algorithms
Date: Sat, 22 Jun 2024 17:35:43 +0300
Message-ID: <20240622143601.187723-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
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

The choice of hash algorithms are determined by the platform and the TPM
configuration. Failing to cap a PCR in a bank which the platform left
active is a security vulnerability. It might allow  unsealing of secrets
if an attacker can replay a good set of measurements into an unused bank.

If MEASURED_BOOT or EFI_TCG2_PROTOCOL is enabled our Kconfig will enable
all supported hashing algorithms. We still want to allow users to add a
TPM and not enable measured boot via EFI or bootm though and at the same
time, control the compiled algorithms for size reasons.

So let's add a function tpm2_allow_extend() which checks the TPM active
PCRs banks against the one U-Boot was compiled with.
If all the active PCRs banks are not enabled refuse to extend a PCR but
otherwise leave the TPM functional.

It's worth noting that this is only added on TPM2.0, since TPM1.2 is
lacking a lot of code at the moment to read the available PCRs.
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
index eac04d1c6831..fccb07fa4695 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -277,48 +277,40 @@ struct digest_info {
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
@@ -711,6 +703,41 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
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

