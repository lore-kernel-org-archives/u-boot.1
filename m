Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC9DC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D32881A9;
	Sat, 22 Jun 2024 16:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QbAlDbXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821E5878E2; Sat, 22 Jun 2024 16:36:48 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D80881A9
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso144111166b.3
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719067005; x=1719671805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDtKkPsBCvsb9Fmpquo7/Ie0w6uQLXkc7J6e8RCnTlU=;
 b=QbAlDbXKnGa5G0d8VO7PQdPmT2LE0vsjp21E+6VCz4OgF6XRxbJWlBo9ZoThxl+WLn
 N7qRaME85yj/MyU2+X7sOiQHSYlCBk+cGVlAZJU+qeU+8hXBx2XJexea/prKcN3k+oye
 0kBVlQcjfnt0giQdr2LG0jnkuwUk+17ZVayS0JROu5ij3e9jGwvy7cR4K/0cZtLPvXtQ
 wXizH9clQKQw/PwVuQqnvnn2uI0i/GVvqrk9FZYBThPTc+bz8ukovhHIM2A138XOa+Q1
 Fd7TWtPEmVvpoO1BUCMODl3qOdWajrn8FtyzLSOkyo0y2fYBTp0FLOt+x5GL0S1OP4dI
 nonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719067005; x=1719671805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDtKkPsBCvsb9Fmpquo7/Ie0w6uQLXkc7J6e8RCnTlU=;
 b=OSJkIsF2IpXNHALsewjDaAnebSBueJwf+/B9UzPtP7RdrIIn7dY6zH1gqwRId8QTcA
 WcvQDmyxUJRYHvcyNT8b6fj7dUW00p/Qx27QzqbOBHQpTt1k2+CMPy41wqUXAcxnNodR
 EiJzSgVlqd58IwuvjUlvpYv4Q6OYuwPduUwJjHefLFxFVIk9V1wEkB4zXMEhT7MoKKDX
 zHtw83W/Nw2gY8OmmzorP83tct6ImbZbUWQo8trlgmcrUfVjoKpqr1d4ttERu7bgRlZP
 bWujo51izAcRdLsf+zpq2ltAuUfevUNDeV8orDKvLMUbBrEvwVmH5N0jUa8JNqQM5cp9
 gtow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUhuTr0lyzYKWdR546eM1iuyYEm7mgMoUbH9f4o8KKhjAOhyQFuHftEPrsVgwKJ2mu6E7BejtS+4lb29Phnag7IHJRLg==
X-Gm-Message-State: AOJu0YyfwWUW+1b1Vh/KrXo0YH5YOwRSgkoIs5dqHOT7X4VUT6uhkRHw
 SZh6/UuKEh+raZcgASP91VtS6A64Nk602eLq43gvL5F9wwPlIupYRif0hdF8ytA=
X-Google-Smtp-Source: AGHT+IG8HU8VAnJSt8Df/QRFHFwqZc/7tRlURBDbx+VuUEtWGQ3ymTaSsN5RpElZhVlhtaqMVEVXKQ==
X-Received: by 2002:a17:907:a809:b0:a70:7a10:de0b with SMTP id
 a640c23a62f3a-a7245b565b2mr1717566b.21.1719067005438; 
 Sat, 22 Jun 2024 07:36:45 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:44 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 6/7] tpm: Untangle tpm2_get_pcr_info()
Date: Sat, 22 Jun 2024 17:35:42 +0300
Message-ID: <20240622143601.187723-7-ilias.apalodimas@linaro.org>
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

This function was used on measured boot to retrieve the number of active
PCR banks and was designed to work with the TCG protocols.
Since we now have the need to retrieve the active PCRs outside the
measured boot context -- e.g use the in the command line, decouple the
function.

Create one that will only adheres to TCG TSS2.0 [0] specification called
tpm2_get_pcr_info() which can be used by the TPM2.0 APIs and a new one that
is called from the measured boot context called tcg2_get_pcr_info()

[0] https://trustedcomputinggroup.org/wp-content/uploads/TSS_Overview_Common_Structures_Version-0.9_Revision-03_Review_030918.pdf

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/tpm-v2.h          | 16 ++++++---
 include/tpm_tcg2.h        | 13 +++++++
 lib/efi_loader/efi_tcg2.c |  2 +-
 lib/tpm-v2.c              | 73 +++++++++++++--------------------------
 lib/tpm_tcg2.c            | 38 +++++++++++++++++++-
 5 files changed, 86 insertions(+), 56 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index c176e04c9952..eac04d1c6831 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -521,14 +521,11 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
  * tpm2_get_pcr_info() - get the supported, active PCRs and number of banks
  *
  * @dev:		TPM device
- * @supported_pcr:	bitmask with the algorithms supported
- * @active_pcr:		bitmask with the active algorithms
- * @pcr_banks:		number of PCR banks
+ * @pcrs:		struct tpml_pcr_selection of available PCRs
  *
  * @return 0 on success, code of operation or negative errno on failure
  */
-int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
-		      u32 *pcr_banks);
+int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs);
 
 /**
  * Issue a TPM2_DictionaryAttackLockReset command.
@@ -714,4 +711,13 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
  */
 const char *tpm2_algorithm_name(enum tpm2_algorithms);
 
+/**
+ * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
+ *			  supports the algorithm add it on the active ones
+ *
+ * @selection: PCR selection structure
+ * Return: True if the algorithm is active
+ */
+bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection);
+
 #endif /* __TPM_V2_H */
diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index 77afdbb03e77..a0557898865e 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -82,6 +82,19 @@ struct tcg_pcr_event {
 	u8 event[];
 } __packed;
 
+/**
+ * tcg2_get_pcr_info() - get the supported, active PCRs and number of banks
+ *
+ * @dev:		TPM device
+ * @supported_pcr:	bitmask with the algorithms supported
+ * @active_pcr:		bitmask with the active algorithms
+ * @pcr_banks:		number of PCR banks
+ *
+ * @return 0 on success, code of operation or negative errno on failure
+ */
+int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
+		      u32 *pcr_banks);
+
 /**
  * Crypto Agile Log Entry Format
  *
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index c654d2cbd704..2d2c015db053 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -279,7 +279,7 @@ efi_tcg2_get_capability(struct efi_tcg2_protocol *this,
 	/* Supported and active PCRs */
 	capability->hash_algorithm_bitmap = 0;
 	capability->active_pcr_banks = 0;
-	ret = tpm2_get_pcr_info(dev, &capability->hash_algorithm_bitmap,
+	ret = tcg2_get_pcr_info(dev, &capability->hash_algorithm_bitmap,
 				&capability->active_pcr_banks,
 				&capability->number_of_pcr_banks);
 	if (ret) {
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 62ab804b4b38..36aace03cf4e 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -395,48 +395,26 @@ static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
 	return 0;
 }
 
-static bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection)
-{
-	int i;
-
-	/*
-	 * check the pcr_select. If at least one of the PCRs supports the
-	 * algorithm add it on the active ones
-	 */
-	for (i = 0; i < selection->size_of_select; i++) {
-		if (selection->pcr_select[i])
-			return true;
-	}
-
-	return false;
-}
-
-int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
-		      u32 *pcr_banks)
+int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 {
 	u8 response[(sizeof(struct tpms_capability_data) -
 		offsetof(struct tpms_capability_data, data))];
-	struct tpml_pcr_selection pcrs;
 	u32 num_pcr;
 	size_t i;
 	u32 ret;
 
-	*supported_pcr = 0;
-	*active_pcr = 0;
-	*pcr_banks = 0;
-	memset(response, 0, sizeof(response));
 	ret = tpm2_get_capability(dev, TPM2_CAP_PCRS, 0, response, 1);
 	if (ret)
 		return ret;
 
-	pcrs.count = get_unaligned_be32(response);
+	pcrs->count = get_unaligned_be32(response);
 	/*
 	 * We only support 5 algorithms for now so check against that
 	 * instead of TPM2_NUM_PCR_BANKS
 	 */
-	if (pcrs.count > ARRAY_SIZE(hash_algo_list) ||
-	    pcrs.count < 1) {
-		printf("%s: too many pcrs: %u\n", __func__, pcrs.count);
+	if (pcrs->count > ARRAY_SIZE(hash_algo_list) ||
+	    pcrs->count < 1) {
+		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
 		return -EMSGSIZE;
 	}
 
@@ -444,7 +422,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < pcrs.count; i++) {
+	for (i = 0; i < pcrs->count; i++) {
 		/*
 		 * Definition of TPMS_PCR_SELECTION Structure
 		 * hash: u16
@@ -464,35 +442,20 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 			hash_offset + offsetof(struct tpms_pcr_selection,
 					       pcr_select);
 
-		pcrs.selection[i].hash =
+		pcrs->selection[i].hash =
 			get_unaligned_be16(response + hash_offset);
-		pcrs.selection[i].size_of_select =
+		pcrs->selection[i].size_of_select =
 			__get_unaligned_be(response + size_select_offset);
-		if (pcrs.selection[i].size_of_select > TPM2_PCR_SELECT_MAX) {
+		if (pcrs->selection[i].size_of_select > TPM2_PCR_SELECT_MAX) {
 			printf("%s: pcrs selection too large: %u\n", __func__,
-			       pcrs.selection[i].size_of_select);
+			       pcrs->selection[i].size_of_select);
 			return -ENOBUFS;
 		}
 		/* copy the array of pcr_select */
-		memcpy(pcrs.selection[i].pcr_select, response + pcr_select_offset,
-		       pcrs.selection[i].size_of_select);
-	}
-
-	for (i = 0; i < pcrs.count; i++) {
-		u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
-
-		if (hash_mask) {
-			*supported_pcr |= hash_mask;
-			if (tpm2_is_active_pcr(&pcrs.selection[i]))
-				*active_pcr |= hash_mask;
-		} else {
-			printf("%s: unknown algorithm %x\n", __func__,
-			       pcrs.selection[i].hash);
-		}
+		memcpy(pcrs->selection[i].pcr_select, response + pcr_select_offset,
+		       pcrs->selection[i].size_of_select);
 	}
 
-	*pcr_banks = pcrs.count;
-
 	return 0;
 }
 
@@ -880,6 +843,18 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 	return 0;
 }
 
+bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection)
+{
+	int i;
+
+	for (i = 0; i < selection->size_of_select; i++) {
+		if (selection->pcr_select[i])
+			return true;
+	}
+
+	return false;
+}
+
 enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
 {
 	size_t i;
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 865ef6e01ca9..55b7145a9677 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -20,6 +20,42 @@
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
 
+int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
+		      u32 *pcr_banks)
+{
+	u8 response[(sizeof(struct tpms_capability_data) -
+		offsetof(struct tpms_capability_data, data))];
+	struct tpml_pcr_selection pcrs;
+	size_t i;
+	u32 ret;
+
+	*supported_pcr = 0;
+	*active_pcr = 0;
+	*pcr_banks = 0;
+	memset(response, 0, sizeof(response));
+
+	ret = tpm2_get_pcr_info(dev, &pcrs);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < pcrs.count; i++) {
+		u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
+
+		if (hash_mask) {
+			*supported_pcr |= hash_mask;
+			if (tpm2_is_active_pcr(&pcrs.selection[i]))
+				*active_pcr |= hash_mask;
+		} else {
+			printf("%s: unknown algorithm %x\n", __func__,
+			       pcrs.selection[i].hash);
+		}
+	}
+
+	*pcr_banks = pcrs.count;
+
+	return 0;
+}
+
 int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
 {
 	u32 supported = 0;
@@ -27,7 +63,7 @@ int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
 	u32 active = 0;
 	int rc;
 
-	rc = tpm2_get_pcr_info(dev, &supported, &active, &pcr_banks);
+	rc = tcg2_get_pcr_info(dev, &supported, &active, &pcr_banks);
 	if (rc)
 		return rc;
 
-- 
2.45.2

