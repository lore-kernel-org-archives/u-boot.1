Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A57CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 17:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAADD881A4;
	Thu, 28 Mar 2024 18:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A7188196; Thu, 28 Mar 2024 18:01:17 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AEC6881AF
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rpt7o-005EYh-J5;
 Thu, 28 Mar 2024 17:01:12 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Cc: slee@gateworks.com,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] tpm-v2: allow algoirthm name to be configured for pcr_read
 and pcr_extend
Date: Thu, 28 Mar 2024 10:01:10 -0700
Message-Id: <20240328170110.1960631-1-tharvey@gateworks.com>
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
v2:
 - use tpm2_algorithm_to_len
 - use enum tpm2_algorithms
 - make function names and parameter names more consistent with existing
   tpm-v2 functions
 - fix various spelling errors
---
 cmd/tpm-v2.c     | 49 ++++++++++++++++++++++++++++++++++--------------
 include/tpm-v2.h | 18 ++++++++++++++++++
 lib/tpm-v2.c     | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 14 deletions(-)

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
index 33dd103767c4..933882fcbf97 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -965,4 +965,22 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
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
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 68eaaa639f89..19b2535682e1 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -29,6 +29,13 @@ const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
 	TPM2_ALG_SHA512,
 };
 
+const char *tpm2_supported_algorithm_names[4] = {
+	"sha1",
+	"sha256",
+	"sha384",
+	"sha512",
+};
+
 int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
 {
 	u32 supported = 0;
@@ -1555,3 +1562,30 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 
 	return 0;
 }
+
+enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
+{
+	enum tpm2_algorithms algo;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
+		algo = tpm2_supported_algorithms[i];
+		if (!strcasecmp(name, tpm2_supported_algorithm_names[i]))
+			return algo;
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
+	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
+		if (tpm2_supported_algorithms[i] == algo)
+			return tpm2_supported_algorithm_names[i];
+	}
+
+	return "";
+}
-- 
2.25.1

