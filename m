Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A1CCD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 00:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA33882B1;
	Fri,  5 Apr 2024 02:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C467788382; Fri,  5 Apr 2024 02:17:28 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B99882AB
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 02:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rsXGl-00G89K-SP;
 Fri, 05 Apr 2024 00:17:23 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Cc: slee@gateworks.com,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3] tpm-v2: allow algoirthm name to be configured for pcr_read
 and pcr_extend
Date: Thu,  4 Apr 2024 17:17:22 -0700
Message-Id: <20240405001722.2876240-1-tharvey@gateworks.com>
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

For pcr_read and pcr_extend commands allow the digest algorithm to be
specified by an additional argument. If not specified it will default to
SHA256 for backwards compatibility.

A follow-on to this could be to extend all PCR banks with the detected
algo when the <digest_algo> argument is 'auto'.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - replace tpm2_supported_algorithms with struct and use this to relate hash algoirthm
   details
v2:
 - use tpm2_algorithm_to_len
 - use enum tpm2_algorithms
 - make function names and parameter names more consistent with existing
   tpm-v2 functions
 - fix various spelling errors
---
 cmd/tpm-v2.c              | 49 ++++++++++++++++++++--------
 include/tpm-v2.h          | 67 ++++++++++++++++++++++++++++++++++++++-
 lib/efi_loader/efi_tcg2.c |  4 +--
 lib/tpm-v2.c              | 62 +++++++++++++++++++++++-------------
 4 files changed, 143 insertions(+), 39 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 7e479b9dfe36..2343b4d9cb9e 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -99,11 +99,19 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct tpm_chip_priv *priv;
 	u32 index = simple_strtoul(argv[1], NULL, 0);
 	void *digest = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+	int algo = TPM2_ALG_SHA256;
+	int algo_len;
 	int ret;
 	u32 rc;
 
-	if (argc != 3)
+	if (argc < 3 || argc > 4)
 		return CMD_RET_USAGE;
+	if (argc == 4) {
+		algo = tpm2_name_to_algorithm(argv[3]);
+		if (algo < 0)
+			return CMD_RET_FAILURE;
+	}
+	algo_len = tpm2_algorithm_to_len(algo);
 
 	ret = get_tpm(&dev);
 	if (ret)
@@ -116,8 +124,12 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (index >= priv->pcr_count)
 		return -EINVAL;
 
-	rc = tpm2_pcr_extend(dev, index, TPM2_ALG_SHA256, digest,
-			     TPM2_DIGEST_LEN);
+	rc = tpm2_pcr_extend(dev, index, algo, digest, algo_len);
+	if (!rc) {
+		printf("PCR #%u extended with %d byte %s digest\n", index,
+		       algo_len, tpm2_algorithm_name(algo));
+		print_byte_string(digest, algo_len);
+	}
 
 	unmap_sysmem(digest);
 
@@ -127,15 +139,23 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
+	enum tpm2_algorithms algo = TPM2_ALG_SHA256;
 	struct udevice *dev;
 	struct tpm_chip_priv *priv;
 	u32 index, rc;
+	int algo_len;
 	unsigned int updates;
 	void *data;
 	int ret;
 
-	if (argc != 3)
+	if (argc < 3 || argc > 4)
 		return CMD_RET_USAGE;
+	if (argc == 4) {
+		algo = tpm2_name_to_algorithm(argv[3]);
+		if (algo < 0)
+			return CMD_RET_FAILURE;
+	}
+	algo_len = tpm2_algorithm_to_len(algo);
 
 	ret = get_tpm(&dev);
 	if (ret)
@@ -151,11 +171,12 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
 
-	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_ALG_SHA256,
-			   data, TPM2_DIGEST_LEN, &updates);
+	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
+			   data, algo_len, &updates);
 	if (!rc) {
-		printf("PCR #%u content (%u known updates):\n", index, updates);
-		print_byte_string(data, TPM2_DIGEST_LEN);
+		printf("PCR #%u %s %d byte content (%u known updates):\n", index,
+		       tpm2_algorithm_name(algo), algo_len, updates);
+		print_byte_string(data, algo_len);
 	}
 
 	unmap_sysmem(data);
@@ -415,14 +436,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "    <hierarchy> is one of:\n"
 "        * TPM2_RH_LOCKOUT\n"
 "        * TPM2_RH_PLATFORM\n"
-"pcr_extend <pcr> <digest_addr>\n"
-"    Extend PCR #<pcr> with digest at <digest_addr>.\n"
+"pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
+"    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\n"
 "    <pcr>: index of the PCR\n"
-"    <digest_addr>: address of a 32-byte SHA256 digest\n"
-"pcr_read <pcr> <digest_addr>\n"
-"    Read PCR #<pcr> to memory address <digest_addr>.\n"
+"    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
+"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
+"    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo>.\n"
 "    <pcr>: index of the PCR\n"
-"    <digest_addr>: address to store the a 32-byte SHA256 digest\n"
+"    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
 "get_capability <capability> <property> <addr> <count>\n"
 "    Read and display <count> entries indexed by <capability>/<property>.\n"
 "    Values are 4 bytes long and are written at <addr>.\n"
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 33dd103767c4..263f9529e55d 100644
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
@@ -965,4 +1012,22 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
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
 #endif /* __TPM_V2_H */
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b07e0099c27e..cf5d8de018a7 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -414,8 +414,8 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 	}
 
 	digest_list->count = 0;
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
-		u16 hash_alg = tpm2_supported_algorithms[i];
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		u16 hash_alg = hash_algo_list[i].hash_alg;
 
 		if (!(active & tpm2_algorithm_to_mask(hash_alg)))
 			continue;
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 68eaaa639f89..83f490c82541 100644
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
@@ -82,14 +75,14 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 		return rc;
 
 	digest_list->count = 0;
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
 		u32 mask =
-			tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
+			tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
 
 		if (!(active & mask))
 			continue;
 
-		switch (tpm2_supported_algorithms[i]) {
+		switch (hash_algo_list[i].hash_alg) {
 		case TPM2_ALG_SHA1:
 			sha1_starts(&ctx);
 			sha1_update(&ctx, input, length);
@@ -116,12 +109,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
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
@@ -208,13 +201,13 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 		return rc;
 
 	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
-		mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		mask = tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
 
 		if (!(active & mask))
 			continue;
 
-		switch (tpm2_supported_algorithms[i]) {
+		switch (hash_algo_list[i].hash_alg) {
 		case TPM2_ALG_SHA1:
 		case TPM2_ALG_SHA256:
 		case TPM2_ALG_SHA384:
@@ -253,17 +246,17 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 	put_unaligned_le32(count, &ev->number_of_algorithms);
 
 	count = 0;
-	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
-		mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
+		mask = tpm2_algorithm_to_mask(hash_algo_list[i].hash_alg);
 
 		if (!(active & mask))
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
@@ -304,7 +297,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
 		pos = offsetof(struct tcg_pcr_event2, digests) +
 			offsetof(struct tpml_digest_values, count);
 		count = get_unaligned_le32(log + pos);
-		if (count > ARRAY_SIZE(tpm2_supported_algorithms) ||
+		if (count > ARRAY_SIZE(hash_algo_list) ||
 		    (digest_list->count && digest_list->count != count))
 			return 0;
 
@@ -407,7 +400,7 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 		return 0;
 
 	count = get_unaligned_le32(&event->number_of_algorithms);
-	if (count > ARRAY_SIZE(tpm2_supported_algorithms))
+	if (count > ARRAY_SIZE(hash_algo_list))
 		return 0;
 
 	calc_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
@@ -1110,7 +1103,7 @@ int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 	 * We only support 5 algorithms for now so check against that
 	 * instead of TPM2_NUM_PCR_BANKS
 	 */
-	if (pcrs.count > ARRAY_SIZE(tpm2_supported_algorithms) ||
+	if (pcrs.count > ARRAY_SIZE(hash_algo_list) ||
 	    pcrs.count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs.count);
 		return -EMSGSIZE;
@@ -1555,3 +1548,28 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 
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
-- 
2.25.1

