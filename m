Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25752C25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 20:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5447A8831D;
	Sat, 25 May 2024 22:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 015BE882A3; Sat, 25 May 2024 22:00:56 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB99882AF
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 22:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sAxZS-0045NF-O1;
 Sat, 25 May 2024 20:00:50 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v5 1/2] tpm-v2: add support for mapping algorithm names to
 algos
Date: Sat, 25 May 2024 13:00:48 -0700
Message-Id: <20240525200049.3904124-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

replace tpm2_supported_algorithms with an array of structures
relating algorithm names, to TCG id's, digest length and mask values.

While at it fix the tpm2_algorithm_to_mask to return the proper value.

Fixes: 97707f12fdab ("tpm: Support boot measurements")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v5:
 - use hash_len from struct vs calling more expensive tpm2_algorithm_to_mask function
 - collected rb tag
v4:
 - new patch

merge: replace various calls to tomp2_algorithm_to_mask to struct dereference
---
 include/tpm-v2.h          | 77 ++++++++++++++++++++++++++++++++++--
 lib/efi_loader/efi_tcg2.c |  6 +--
 lib/tpm-v2.c              | 82 +++++++++++++++++++++++++--------------
 3 files changed, 129 insertions(+), 36 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 33dd103767c4..c9d5cb6d3e5a 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -386,7 +386,54 @@ enum tpm2_algorithms {
 	TPM2_ALG_SM3_256	= 0x12,
 };
 
-extern const enum tpm2_algorithms tpm2_supported_algorithms[4];
+/**
+ * struct digest_info - details of supported digests
+ *
+ * @hash_name:			hash name
+ * @hash_alg:			hash algorithm id
+ * @hash_mask:			hash registry mask
+ * @hash_len:			hash digest length
+ */
+struct digest_info {
+	const char *hash_name;
+	u16 hash_alg;
+	u32 hash_mask;
+	u16 hash_len;
+};
+
+/* Algorithm Registry */
+#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
+#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
+#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
+#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
+#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
+
+static const struct digest_info hash_algo_list[] = {
+	{
+		"sha1",
+		TPM2_ALG_SHA1,
+		TCG2_BOOT_HASH_ALG_SHA1,
+		TPM2_SHA1_DIGEST_SIZE,
+	},
+	{
+		"sha256",
+		TPM2_ALG_SHA256,
+		TCG2_BOOT_HASH_ALG_SHA256,
+		TPM2_SHA256_DIGEST_SIZE,
+	},
+	{
+		"sha384",
+		TPM2_ALG_SHA384,
+		TCG2_BOOT_HASH_ALG_SHA384,
+		TPM2_SHA384_DIGEST_SIZE,
+	},
+	{
+		"sha512",
+		TPM2_ALG_SHA512,
+		TCG2_BOOT_HASH_ALG_SHA512,
+		TPM2_SHA512_DIGEST_SIZE,
+	},
+};
 
 static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
 {
@@ -404,8 +451,6 @@ static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
 	}
 }
 
-#define tpm2_algorithm_to_mask(a)	(1 << (a))
-
 /* NV index attributes */
 enum tpm_index_attrs {
 	TPMA_NV_PPWRITE		= 1UL << 0,
@@ -965,4 +1010,30 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
  */
 u32 tpm2_auto_start(struct udevice *dev);
 
+/**
+ * tpm2_name_to_algorithm() - Return an algorithm id given a supported
+ *			      algorithm name
+ *
+ * @name: algorithm name
+ * Return: enum tpm2_algorithms or -EINVAL
+ */
+enum tpm2_algorithms tpm2_name_to_algorithm(const char *name);
+
+/**
+ * tpm2_algorithm_name() - Return an algorithm name string for a
+ *			   supported algorithm id
+ *
+ * @algorithm_id: algorithm defined in enum tpm2_algorithms
+ * Return: algorithm name string or ""
+ */
+const char *tpm2_algorithm_name(enum tpm2_algorithms);
+
+/**
+ * tpm2_algorithm_to_mask() - Get a TCG hash mask for algorithm
+ *
+ * @hash_alg: TCG defined algorithm
+ * Return: TCG hashing algorithm bitmaps (or 0 if algo not supported)
+ */
+u32 tpm2_algorithm_to_mask(enum tpm2_algorithms);
+
 #endif /* __TPM_V2_H */
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b07e0099c27e..945aafb847d8 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -414,10 +414,10 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 	}
 
 	digest_list->count = 0;
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
-		u16 hash_alg = tpm2_supported_algorithms[i];
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		u16 hash_alg = hash_algo_list[i].hash_alg;
 
-		if (!(active & tpm2_algorithm_to_mask(hash_alg)))
+		if (!(active & hash_algo_list[i].hash_mask))
 			continue;
 		switch (hash_alg) {
 		case TPM2_ALG_SHA1:
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 68eaaa639f89..a67daed2f3c1 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -22,13 +22,6 @@
 
 #include "tpm-utils.h"
 
-const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
-	TPM2_ALG_SHA1,
-	TPM2_ALG_SHA256,
-	TPM2_ALG_SHA384,
-	TPM2_ALG_SHA512,
-};
-
 int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
 {
 	u32 supported = 0;
@@ -82,14 +75,11 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 		return rc;
 
 	digest_list->count = 0;
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
-		u32 mask =
-			tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
-
-		if (!(active & mask))
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!(active & hash_algo_list[i].hash_mask))
 			continue;
 
-		switch (tpm2_supported_algorithms[i]) {
+		switch (hash_algo_list[i].hash_alg) {
 		case TPM2_ALG_SHA1:
 			sha1_starts(&ctx);
 			sha1_update(&ctx, input, length);
@@ -116,12 +106,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 			break;
 		default:
 			printf("%s: unsupported algorithm %x\n", __func__,
-			       tpm2_supported_algorithms[i]);
+			       hash_algo_list[i].hash_alg);
 			continue;
 		}
 
 		digest_list->digests[digest_list->count].hash_alg =
-			tpm2_supported_algorithms[i];
+			hash_algo_list[i].hash_alg;
 		memcpy(&digest_list->digests[digest_list->count].digest, final,
 		       len);
 		digest_list->count++;
@@ -198,7 +188,6 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 	u32 count = 0;
 	u32 log_size;
 	u32 active;
-	u32 mask;
 	size_t i;
 	u16 len;
 	int rc;
@@ -208,13 +197,11 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 		return rc;
 
 	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
-		mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
-
-		if (!(active & mask))
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!(active & hash_algo_list[i].hash_mask))
 			continue;
 
-		switch (tpm2_supported_algorithms[i]) {
+		switch (hash_algo_list[i].hash_alg) {
 		case TPM2_ALG_SHA1:
 		case TPM2_ALG_SHA256:
 		case TPM2_ALG_SHA384:
@@ -253,17 +240,15 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 	put_unaligned_le32(count, &ev->number_of_algorithms);
 
 	count = 0;
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
-		mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
-
-		if (!(active & mask))
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!(active & hash_algo_list[i].hash_mask))
 			continue;
 
-		len = tpm2_algorithm_to_len(tpm2_supported_algorithms[i]);
+		len = hash_algo_list[i].hash_len;
 		if (!len)
 			continue;
 
-		put_unaligned_le16(tpm2_supported_algorithms[i],
+		put_unaligned_le16(hash_algo_list[i].hash_alg,
 				   &ev->digest_sizes[count].algorithm_id);
 		put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
 		count++;
@@ -304,7 +289,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
 		pos = offsetof(struct tcg_pcr_event2, digests) +
 			offsetof(struct tpml_digest_values, count);
 		count = get_unaligned_le32(log + pos);
-		if (count > ARRAY_SIZE(tpm2_supported_algorithms) ||
+		if (count > ARRAY_SIZE(hash_algo_list) ||
 		    (digest_list->count && digest_list->count != count))
 			return 0;
 
@@ -407,7 +392,7 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 		return 0;
 
 	count = get_unaligned_le32(&event->number_of_algorithms);
-	if (count > ARRAY_SIZE(tpm2_supported_algorithms))
+	if (count > ARRAY_SIZE(hash_algo_list))
 		return 0;
 
 	calc_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
@@ -1110,7 +1095,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 	 * We only support 5 algorithms for now so check against that
 	 * instead of TPM2_NUM_PCR_BANKS
 	 */
-	if (pcrs.count > ARRAY_SIZE(tpm2_supported_algorithms) ||
+	if (pcrs.count > ARRAY_SIZE(hash_algo_list) ||
 	    pcrs.count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs.count);
 		return -EMSGSIZE;
@@ -1555,3 +1540,40 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 
 	return 0;
 }
+
+enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (!strcasecmp(name, hash_algo_list[i].hash_name))
+			return hash_algo_list[i].hash_alg;
+	}
+	printf("%s: unsupported algorithm %s\n", __func__, name);
+
+	return -EINVAL;
+}
+
+const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		if (hash_algo_list[i].hash_alg == algo)
+			return hash_algo_list[i].hash_name;
+	}
+
+	return "";
+}
+
+u32 tpm2_algorithm_to_mask(enum tpm2_algorithms algo)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		if (hash_algo_list[i].hash_alg == algo)
+			return hash_algo_list[i].hash_mask;
+	}
+
+	return 0;
+}
-- 
2.25.1

