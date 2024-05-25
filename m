Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A5DC25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 20:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F0E882AF;
	Sat, 25 May 2024 22:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30D2882CD; Sat, 25 May 2024 22:00:55 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA963882A3
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 22:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sAxZT-0045NF-9V;
 Sat, 25 May 2024 20:00:51 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v5 2/2] tpm-v2: allow algorithm name to be configured for
 pcr_read and pcr_extend
Date: Sat, 25 May 2024 13:00:49 -0700
Message-Id: <20240525200049.3904124-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240525200049.3904124-1-tharvey@gateworks.com>
References: <20240525200049.3904124-1-tharvey@gateworks.com>
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

Additionally update test_tpm2.py for the changes in output in pcr_read
which now shows the algo and algo length in the output.

A follow-on to this could be to extend all PCR banks with the detected
algo when the <digest_algo> argument is 'auto'.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v5:
 - fix typo in commit description
 - collected rb tag
v4:
 - update test_tpm2.py as required by changes in pcr_read output
 - split out moving algos to an array of structs to its own patch
   and encorporate a fix for tpm2_algorithm_to_mask
v3:
 - replace tpm2_supported_algorithms with struct and use this to
   relate hash algoirthm details
v2:
 - use tpm2_algorithm_to_len
 - use enum tpm2_algorithms
 - make function names and parameter names more consistent with existing
   tpm-v2 functions
 - fix various spelling errors
---
 cmd/tpm-v2.c               | 49 +++++++++++++++++++++++++++-----------
 test/py/tests/test_tpm2.py |  2 +-
 2 files changed, 36 insertions(+), 15 deletions(-)

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
diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index 1d654cd4a23b..75f5d31fc675 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -257,7 +257,7 @@ def test_tpm2_pcr_read(u_boot_console):
     updates = int(re.findall(r'\d+', str)[0])
 
     # Check the output value
-    assert 'PCR #10 content' in read_pcr
+    assert 'PCR #10 sha256 32 byte content' in read_pcr
     assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
-- 
2.25.1

