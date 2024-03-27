Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158E4C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 22:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C478803F;
	Wed, 27 Mar 2024 23:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3577F8808F; Wed, 27 Mar 2024 23:37:10 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE628801A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 23:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rpbtJ-004BEM-S3;
 Wed, 27 Mar 2024 22:37:05 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] tpm-v2: allow algo name to be conigured for pcr_read and
 pcr_extend
Date: Wed, 27 Mar 2024 15:37:04 -0700
Message-Id: <20240327223704.1883824-1-tharvey@gateworks.com>
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

For pcr_read and pcr_extend commands allow the digest algo to be
specified by an additional argument. If not specified it will default to
SHA256 for backwards compatibility.

A follow-on to this could be to extend all PCR banks with the detected
algo when the <digest_algo> argument is 'auto'.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 cmd/tpm-v2.c     | 51 +++++++++++++++++++++++++++++++++++-------------
 include/tpm-v2.h | 17 ++++++++++++++++
 lib/tpm-v2.c     | 46 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 7e479b9dfe36..52d232c3ea7d 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -99,11 +99,20 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct tpm_chip_priv *priv;
 	u32 index = simple_strtoul(argv[1], NULL, 0);
 	void *digest = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+	int algo_len = TPM2_SHA256_DIGEST_SIZE;
+	int algo = TPM2_ALG_SHA256;
 	int ret;
 	u32 rc;
 
-	if (argc != 3)
+	if (argc < 3 || argc > 4)
 		return CMD_RET_USAGE;
+	if (argc == 4) {
+		algo = tpm2_algo_len(argv[3], &algo_len);
+		if (algo < 0) {
+			printf("Error: invalid algo\n");
+			return CMD_RET_USAGE;
+		}
+	}
 
 	ret = get_tpm(&dev);
 	if (ret)
@@ -116,8 +125,12 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (index >= priv->pcr_count)
 		return -EINVAL;
 
-	rc = tpm2_pcr_extend(dev, index, TPM2_ALG_SHA256, digest,
-			     TPM2_DIGEST_LEN);
+	rc = tpm2_pcr_extend(dev, index, algo, digest, algo_len);
+	if (!rc) {
+		printf("PCR #%u extended with %d byte %s digest\n", index,
+		       algo_len, tpm2_algo_name(algo));
+		print_byte_string(digest, algo_len);
+	}
 
 	unmap_sysmem(digest);
 
@@ -127,6 +140,8 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 			   char *const argv[])
 {
+	int algo_len = TPM2_SHA256_DIGEST_SIZE;
+	int algo = TPM2_ALG_SHA256;
 	struct udevice *dev;
 	struct tpm_chip_priv *priv;
 	u32 index, rc;
@@ -134,8 +149,15 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	void *data;
 	int ret;
 
-	if (argc != 3)
+	if (argc < 3 || argc > 4)
 		return CMD_RET_USAGE;
+	if (argc == 4) {
+		algo = tpm2_algo_len(argv[3], &algo_len);
+		if (algo < 0) {
+			printf("Error: invalid algo\n");
+			return CMD_RET_USAGE;
+		}
+	}
 
 	ret = get_tpm(&dev);
 	if (ret)
@@ -151,11 +173,12 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
 
-	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, TPM2_ALG_SHA256,
-			   data, TPM2_DIGEST_LEN, &updates);
+	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
+			   data, algo_len, &updates);
 	if (!rc) {
-		printf("PCR #%u content (%u known updates):\n", index, updates);
-		print_byte_string(data, TPM2_DIGEST_LEN);
+		printf("PCR #%u %s %d byte content (%u known updates):\n", index,
+		       tpm2_algo_name(algo), algo_len, updates);
+		print_byte_string(data, algo_len);
 	}
 
 	unmap_sysmem(data);
@@ -415,14 +438,14 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
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
index 33dd103767c4..07d3ca5e6c83 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -965,4 +965,21 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
  */
 u32 tpm2_auto_start(struct udevice *dev);
 
+/**
+ * tpm2_algo_len() - Return an algo value and length given a algorithm name
+ *
+ * @name: algorithm name
+ * @rwlen: pointer to integer to populate with algorithm length if non-null
+ * Return: algorithm value
+ */
+int tpm2_algo_len(const char *name, int *rwlen);
+
+/**
+ * tpm2_algo_len() - Return an algoithm name string
+ *
+ * @algo: algorithm value
+ * Return: algorithm string
+ */
+const char *tpm2_algo_name(int algo);
+
 #endif /* __TPM_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 68eaaa639f89..6a090ce5810c 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -1555,3 +1555,49 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 
 	return 0;
 }
+
+int tpm2_algo_len(const char *name, int *rwlen)
+{
+	int algo = -EINVAL;
+	int len = 0;
+
+	if (!strcasecmp("sha1", name)) {
+		algo = TPM2_ALG_SHA1;
+		len = TPM2_SHA1_DIGEST_SIZE;
+	} else if (!strcasecmp("sha256", name)) {
+		algo = TPM2_ALG_SHA256;
+		len = TPM2_SHA256_DIGEST_SIZE;
+	} else if (!strcasecmp("sha384", name)) {
+		algo = TPM2_ALG_SHA384;
+		len = TPM2_SHA384_DIGEST_SIZE;
+	} else if (!strcasecmp("sha512", name)) {
+		algo = TPM2_ALG_SHA512;
+		len = TPM2_SHA512_DIGEST_SIZE;
+	} else if (!strcasecmp("sm3_256", name)) {
+		algo = TPM2_ALG_SM3_256;
+		len = TPM2_SM3_256_DIGEST_SIZE;
+	}
+
+	if (*rwlen)
+		*rwlen = len;
+
+	return algo;
+}
+
+const char *tpm2_algo_name(int algo)
+{
+	switch (algo) {
+	case TPM2_ALG_SHA1:
+		return "sha1";
+	case TPM2_ALG_SHA256:
+		return "sha256";
+	case TPM2_ALG_SHA384:
+		return "sha384";
+	case TPM2_ALG_SHA512:
+		return "sha512";
+	case TPM2_ALG_SM3_256:
+		return "sm3_256";
+	}
+
+	return "";
+}
-- 
2.25.1

