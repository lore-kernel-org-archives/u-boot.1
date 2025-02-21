Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D444AC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33EF80F70;
	Fri, 21 Feb 2025 19:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740163677;
	bh=E8HskhqHsN3ETydvoVKerBNdfSQ4Ulq2EyI/ciS2j8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MtSH6EC3sZS/2f9thVgHFTIKp8F+DwMXATl/LdUbr6DEQCbBwJMi1KmKIpCMdcFah
	 EC6VIpi1mzt6zxUtVSLPeGewn3agGBjxhDF8T8R5BP0cpEQRDb0Lu5+aLIFQTUXdJv
	 zm6ARsPKe6Kj37TycDvANglQ+4YeFyEpJsc4th98WNUzVs0bKvXjwHetSlxrT+ik/o
	 3VhtpYGpLazf/UVqzpnLAdOnQAPTce7HMH6DHMdqD5k6jbLS8HA8xAbZ2kTvrVIBdr
	 VIQIkUmWlA7Y9VDvb2fiEn0kR3NB2ph/LZFJA79COiN1uiEbJCxLbzP1abphujUhtE
	 Qulmoeg39aCWw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144DC807C4; Fri, 21 Feb 2025 19:47:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E923680F56
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OQR+KPHJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 97E4510382D3C; Fri, 21 Feb 2025 19:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740163674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8HskhqHsN3ETydvoVKerBNdfSQ4Ulq2EyI/ciS2j8U=;
 b=OQR+KPHJZGnJzXsTKomipB1ng2io1YO5Lwm5ViqRY8r6JeJkSSXs39yy5zMeVh8IjPb6/Y
 ucA1/hYL+Miv9DjblOmplNLX39pgaXLgY2Wuue1W/gwDArqoZT/JitG6PaguXBV19CHqvx
 fL3uS5qsoG/ynD+dnvXUX2TzmORHox2eEyLIJ1ZkzEjkRHHS343vjxDULUXXyTtKScP6ib
 jWoUEJCIWEsktVWdbOigGpQ1GOAGGm3tQIdIiQjVeZARtRJ3alTdpSd+QzSPVCKDYChT9q
 L6DhnEKzt1owiBqVazg1yYxM8M5Cb18NSzkqc8WmoDzAHHsgBp7aHwlGKU811g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] env: mmc: Clean up env_mmc_load() ifdeffery
Date: Fri, 21 Feb 2025 19:47:24 +0100
Message-ID: <20250221184732.202336-2-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250221184732.202336-1-marex@denx.de>
References: <20250221184732.202336-1-marex@denx.de>
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

Rename the variants of env_mmc_load() for redundant and non-redundant
environment to env_mmc_load_redundant() and env_mmc_load_singular()
respectively and convert the env_mmc_load() implementation to use of
if (IS_ENABLED(...)). As a result, drop __maybe_unused from
mmc_env_is_redundant_in_both_boot_hwparts().

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
V3: New patch
---
 env/mmc.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/env/mmc.c b/env/mmc.c
index 353a7ce72fb..2ef15fb72e7 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -205,7 +205,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
 }
 #endif
 
-static bool __maybe_unused mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
+static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
 {
 	/*
 	 * In case the environment is redundant, stored in eMMC hardware boot
@@ -448,13 +448,7 @@ static inline int read_env(struct mmc *mmc, unsigned long size,
 	return (n == blk_cnt) ? 0 : -1;
 }
 
-#if defined(ENV_IS_EMBEDDED)
-static int env_mmc_load(void)
-{
-	return 0;
-}
-#elif defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT)
-static int env_mmc_load(void)
+static int env_mmc_load_redundant(void)
 {
 	struct mmc *mmc;
 	u32 offset1, offset2;
@@ -510,8 +504,8 @@ err:
 
 	return ret;
 }
-#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
-static int env_mmc_load(void)
+
+static int env_mmc_load_singular(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, CONFIG_ENV_SIZE);
 	struct mmc *mmc;
@@ -556,7 +550,16 @@ err:
 
 	return ret;
 }
-#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
+
+static int env_mmc_load(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_EMBEDDED))
+		return 0;
+	else if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
+		return env_mmc_load_redundant();
+	else
+		return env_mmc_load_singular();
+}
 
 U_BOOT_ENV_LOCATION(mmc) = {
 	.location	= ENVL_MMC,
-- 
2.47.2

