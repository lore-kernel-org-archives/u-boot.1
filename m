Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F6FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 11:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDE884852;
	Wed, 29 Apr 2026 13:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="Geo83Kkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50D48483A; Wed, 29 Apr 2026 13:43:16 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5250D84836
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202604291143117e354aeef1000207a6 for <u-boot@lists.denx.de>;
 Wed, 29 Apr 2026 13:43:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AHIgTov4iH2cbkVIYbiUnveFllqjEuDgGcUg/08aCeI=;
 b=Geo83KkgrmJKxXJPowEeS1yS3PwraB3oUD511aUw5l81Mp7xeEQZLW3Uu+WAO/GZz0JAPC
 O6hA9C6fYb/zhwytuESa5CinfRUvjHqMaP0htGQW0BY4ImwC+aUaiixuJyId5yhXhaUXq12a
 Vdyqbk4umLBN7apOrai+yvbPSybOmww5wKQ4aR8ZV99suC+FHwBAozMtHwqVKKwtY39q0ipm
 YxkXPhG7FARjJ50R4QTvbDZUU8J6+PdsADU46Eqt89v5ZqYHmNm+TgmkfVDtJdoXJOSrR4To
 dlkFfPRLMlLizYRfAivNaZdRL2Xs8ZbEfp07oubfroX4rqUt/i1/JEuw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] tpm: make pcr_read command more useful
Date: Wed, 29 Apr 2026 13:41:42 +0200
Message-ID: <20260429134142.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
In-Reply-To: <20260429114250.791663-1-ludwig.nussel@siemens.com>
References: <20260429114250.791663-1-ludwig.nussel@siemens.com>
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

Output now more similar to Linux userspace tool "tpm2_pcrread".

Without arguments the command now prints contents of all PCR registers

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

 cmd/tpm-v2.c | 54 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 847b2691581..3bcb11a8de6 100644
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
@@ -164,28 +166,44 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	ret = get_tpm(&dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	priv = dev_get_uclass_priv(dev);
 	if (!priv)
-		return -EINVAL;
-
-	index = simple_strtoul(argv[1], NULL, 0);
-	if (index >= priv->pcr_count)
-		return -EINVAL;
-
-	data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+		goto out;
 
-	rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
-			   data, algo_len, &updates);
-	if (!rc) {
-		printf("PCR #%u %s %d byte content (%u known updates):\n", index,
-		       tpm2_algorithm_name(algo), algo_len, updates);
-		print_byte_string(data, algo_len);
+	if (argc >= 2) {
+		pcr_start = simple_strtoul(argv[1], NULL, 0);
+		if (pcr_start >= priv->pcr_count)
+			return -EINVAL;
+		pcr_end = pcr_start + 1;
+	} else {
+		pcr_start = 0;
+		pcr_end = priv->pcr_count;
 	}
 
-	unmap_sysmem(data);
+	if (argc >= 3)
+		data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
+	else
+		data = malloc(algo_len);
+
+	printf("%8s:\n", tpm2_algorithm_name(algo));
+	for (index = pcr_start; index < pcr_end; ++index) {
+		rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
+				   data, algo_len, &updates);
+		if (!rc) {
+			printf("%6u: 0x", index);
+			for (int i = 0; i < algo_len; ++i)
+				printf("%02X", data[i]);
+			printf(" (%u known updates)\n", updates);
+		}
+	}
+	if (argc >= 3)
+		unmap_sysmem(data);
+	else
+		free(data);
 
+out:
 	return report_return_code(rc);
 }
 
@@ -548,7 +566,7 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\n"
 "    <pcr>: index of the PCR\n"
 "    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
-"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
+"pcr_read [<pcr> [<digest_addr> [<digest_algo>]]]\n"
 "    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo>.\n"
 "    <pcr>: index of the PCR\n"
 "    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
-- 
2.43.0

