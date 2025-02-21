Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026FEC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C6E80EC0;
	Fri, 21 Feb 2025 19:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740163677;
	bh=5+KqsXRn9raaMnlNwYiQJXoq1jFxMXMqAfon0aVqXm4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TS4arQyXYneBlKCIEwnEvmitzHIQgUTXP5lZGihMn/JMPBr5KGd2iXY7cz5zkxWzI
	 YNv3ys67bFCUBjdQfUqPrPHldHzrOzXPS5Gtae/HXdkJa6e8mu8PBTIn8Zhx13byfx
	 9GMOMIPoj118Go0/+Fi0vg90mvKX+jf43g3k3Mg442K7yl1O9r06PBAq+y2bk57Uvo
	 Vbtk0PCREO/zq/r4ykBHxVYIzLNuAvhgi1NfQekGR4ha6StKhPoDsly47cyfpTZdT8
	 h0sOKx9hTNE6wvMRWueJ0N886gB4iyP5LRvl46IvWxH1oLsKduf33kYUKesMHRCDyV
	 hVP8TM4h/HpFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CFC80F5C; Fri, 21 Feb 2025 19:47:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66276807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="V1CYQpiy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C7C510382D37; Fri, 21 Feb 2025 19:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740163673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5+KqsXRn9raaMnlNwYiQJXoq1jFxMXMqAfon0aVqXm4=;
 b=V1CYQpiyK1lv/73eRkgyvWW8JTuJiiGXV12UWOVzQHE+JP3THc0FfEmROd/3uuTJ6/Jf4J
 lMsq84L4Cpi9n2IJA731m/GsuqyS0K/dHl1xjWzq7sGQkVXOTc+Ihk2l3TFqQ3HvgSFF/i
 8sOrk4iCIqg6fY6MIEveU70sRL/NeYwA37HgEfWcj7Dt2o1QphBIvnBFqCcsQQbeuZKgdf
 w+Nbq1a7EHYg3Zb2Sph55fPYFu7IAh8nnOGdasubacgFzeFg8nFxAPgFEgcoqEbfODdW61
 zGR+XwShnSjWk0+E4VM1lHU0B9vsX2xerk9LsIEr14/U5sOj0Wcqyi1K51IfoA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
Date: Fri, 21 Feb 2025 19:47:23 +0100
Message-ID: <20250221184732.202336-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).

The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
in the last conditional, which does not do plain macro compare
(CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
in use, this gets optimized back to original macro compare, but
if OF_CONTROL is in use, this also takes into account the DT
properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Dragan Simic <dsimic@manjaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Rename mmc_env_hwpart_redund() to mmc_env_is_redundant_in_both_boot_hwparts()
    - Return bool
V3: - Hide the mmc_env_is_redundant_in_both_boot_hwparts symbol behind __maybe_unused
      as this symbol is called from code gated behind ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
      in env_mmc_load()
---
 env/mmc.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/env/mmc.c b/env/mmc.c
index 379f5ec9be7..353a7ce72fb 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -40,18 +40,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/*
- * In case the environment is redundant, stored in eMMC hardware boot
- * partition and the environment and redundant environment offsets are
- * identical, store the environment and redundant environment in both
- * eMMC boot partitions, one copy in each.
- * */
-#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
-     (CONFIG_SYS_MMC_ENV_PART == 1) && \
-     (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND))
-#define ENV_MMC_HWPART_REDUND	1
-#endif
-
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 
 static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
@@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 }
 #endif
 
+static bool __maybe_unused mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
+{
+	/*
+	 * In case the environment is redundant, stored in eMMC hardware boot
+	 * partition and the environment and redundant environment offsets are
+	 * identical, store the environment and redundant environment in both
+	 * eMMC boot partitions, one copy in each.
+	 */
+	if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+		return false;
+
+	if (CONFIG_SYS_MMC_ENV_PART != 1)
+		return false;
+
+	return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);
+}
+
 __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
 {
 	s64 offset = mmc_offset(mmc, copy);
@@ -336,7 +341,7 @@ static int env_mmc_save(void)
 		if (gd->env_valid == ENV_VALID)
 			copy = 1;
 
-		if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
+		if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
 			ret = mmc_set_env_part(mmc, copy + 1);
 			if (ret)
 				goto fini;
@@ -409,7 +414,7 @@ static int env_mmc_erase(void)
 	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
 		copy = 1;
 
-		if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
+		if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
 			ret = mmc_set_env_part(mmc, copy + 1);
 			if (ret)
 				goto fini;
@@ -477,7 +482,7 @@ static int env_mmc_load(void)
 		goto fini;
 	}
 
-	if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
+	if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
 		ret = mmc_set_env_part(mmc, 1);
 		if (ret)
 			goto fini;
@@ -485,7 +490,7 @@ static int env_mmc_load(void)
 
 	read1_fail = read_env(mmc, CONFIG_ENV_SIZE, offset1, tmp_env1);
 
-	if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
+	if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
 		ret = mmc_set_env_part(mmc, 2);
 		if (ret)
 			goto fini;
-- 
2.47.2

