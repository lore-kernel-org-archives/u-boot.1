Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949A4CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C38F8489D;
	Wed, 10 Jun 2026 12:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="t54CHnpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA0F80086; Wed, 10 Jun 2026 12:52:58 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522B784874
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260610105250db6172cbbd00020739 for <u-boot@lists.denx.de>;
 Wed, 10 Jun 2026 12:52:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MFgwkcBl/9I+xjm7aga+8/MTk3bi6KyYm/eAkJ1bucs=;
 b=t54CHnprASCKVbAp1uD/G+rikZnt/w+AW36/iL1PG68UBMy37iOUqAXuhHvJNtr8EugzUv
 1XX/1+hGtUHywRe28GTYMU/C5uDl2HTJzFHEgoZz9Ku71tiTjEY3bU1x4jh49UQY1henNmxL
 HT8U7tkEJUtPR+WMDKansVgHIsHEGE4rEn1a/8r78NvMX8uH0JkWigtbf9L03HK3l62UtRVI
 prKruQ7gs9PnwAqhPW0NRdHsjUFglQE0k1mPKVvyy35CDIriQ45xpIyG6Edzcx3+GmmOxTIe
 aM/yniE4kv7EmwnvPglaIhmMJZiNgHb+6Vn8/KiiN3JNY4tR5FFOBRPw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] tpm: print all PCRs from pcr_read
Date: Wed, 10 Jun 2026 12:52:04 +0200
Message-ID: <20260610125204.v2.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
In-Reply-To: <20260610105243.193355-1-ludwig.nussel@siemens.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Output is now more similar to the Linux userspace tool "tpm2_pcrread".

The old semantics that require specifying one PCR number are
retained. In addition with no arguments the command now prints
contents of all PCR registers.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

Changes in v2:
- fix return value handling

 cmd/tpm-v2.c | 69 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 847b2691581..e9f4bc24e33 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <log.h>
 #include <mapmem.h>
+#include <malloc.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
 #include "tpm-user-utils.h"
@@ -150,10 +151,11 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	u32 index, rc;
 	int algo_len;
 	unsigned int updates;
-	void *data;
+	u8 *data;
 	int ret;
+	u32 pcr_start, pcr_end;
 
-	if (argc < 3 || argc > 4)
+	if (argc > 4)
 		return CMD_RET_USAGE;
 	if (argc == 4) {
 		algo = tpm2_name_to_algorithm(argv[3]);
@@ -168,25 +170,51 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	priv = dev_get_uclass_priv(dev);
 	if (!priv)
-		return -EINVAL;
-
-	index = simple_strtoul(argv[1], NULL, 0);
-	if (index >= priv->pcr_count)
-		return -EINVAL;
+		return CMD_RET_FAILURE;
 
-	data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+	if (argc >= 2) {
+		pcr_start = simple_strtoul(argv[1], NULL, 0);
+		if (pcr_start >= priv->pcr_count) {
+			log_err("Index %u out of range (max %u)\n", pcr_start, priv->pcr_count - 1);
+			return CMD_RET_FAILURE;
+		}
+		pcr_end = pcr_start + 1;
+	} else {
+		pcr_start = 0;
+		pcr_end = priv->pcr_count;
+	}
 
-	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
-			   data, algo_len, &updates);
-	if (!rc) {
-		printf("PCR #%u %s %d byte content (%u known updates):\n", index,
-		       tpm2_algorithm_name(algo), algo_len, updates);
-		print_byte_string(data, algo_len);
+	if (argc >= 3) {
+		data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+	} else {
+		data = malloc(algo_len);
+		if (!data) {
+			log_err("Failed to allocate %u bytes for PCR data\n", algo_len);
+			return CMD_RET_FAILURE;
+		}
 	}
 
-	unmap_sysmem(data);
+	printf("%8s:\n", tpm2_algorithm_name(algo));
+	for (index = pcr_start; index < pcr_end; ++index) {
+		printf("%6u: ", index);
+		rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
+				   data, algo_len, &updates);
+		if (rc == 0) {
+			printf("0x");
+			for (int i = 0; i < algo_len; ++i)
+				printf("%02X", data[i]);
+			printf(" (%u known updates)\n", updates);
+		} else {
+			log_err("PCR #%u read failed: %d\n", index, rc);
+			ret = report_return_code(rc);
+		}
+	}
+	if (argc >= 3)
+		unmap_sysmem(data);
+	else
+		free(data);
 
-	return report_return_code(rc);
+	return ret;
 }
 
 static int do_tpm_get_capability(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -548,10 +576,13 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\n"
 "    <pcr>: index of the PCR\n"
 "    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
-"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
+"pcr_read [<pcr> [<digest_addr> [<digest_algo>]]]\n"
 "    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo>.\n"
-"    <pcr>: index of the PCR\n"
-"    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
+"    With no arguments, print all PCR registers.\n"
+"    If only <pcr> is specified, a buffer is allocated internally.\n"
+"    <pcr>: index of the PCR (optional, defaults to all PCRs)\n"
+"    <digest_addr>: address of digest of digest_algo type (optional)\n"
+"    <digest_algo>: digest algorithm type (defaults to SHA256)\n"
 "get_capability <capability> <property> <addr> <count>\n"
 "    Read and display <count> entries indexed by <capability>/<property>.\n"
 "    Values are 4 bytes long and are written at <addr>.\n"
-- 
2.43.0

