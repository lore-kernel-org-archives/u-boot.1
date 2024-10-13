Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1059CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 17:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A0488F1B;
	Sun, 13 Oct 2024 19:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="ZDT2ryMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D1F88F0C; Sun, 13 Oct 2024 19:43:13 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe11.freemail.hu [46.107.16.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 236F588F1B
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 19:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain
 (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XRSPp006Rz72r;
 Sun, 13 Oct 2024 19:43:09 +0200 (CEST)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, festevam@gmail.com, peng.fan@nxp.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] imx9: Improve boot device auto-selection
Date: Sun, 13 Oct 2024 19:41:20 +0200
Message-ID: <20241013174120.1872-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1728841390; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=1937; bh=oOLLzQwkwjgkVwCKSI7zGossP1eqIjqGxR8QPfiYMzU=;
 b=ZDT2ryMhThoOC/wQCou8zYFhmN/CBKjrZYe9iW47m9NB4c84De4wQc0YyKgcQxd7
 mz6CJZgqS9yioMASrcaKZGRz83rn5cZhj6/gRFYbpqLfaRMjr3VMnt1N7YD8UgIWAGs
 RmZV9ysWcTL/llTWklcPzkz5PgHb7wHe7ZB73wyH5ondMawcHOEiDUEPvjgQoFSP10Q
 eRZxCwhFn0yk5hfzyzBWk5z6uDok8lTRBun2eUAx3BPR17FsV8Uxy8Ex/3/YKYqH9gl
 s5+9/A3x3XYUDbxBK64Axbkknlev5LZO87qc6TCSZ8sctKtJaqUK3I9sxOsS3WBsyqR
 J0G5gBB1fg==
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

From: Benjamin Szőke <egyszeregy@freemail.hu>

Improve "mmcautodetect=yes" boot device auto-selection to able
to use it if CONFIG_ENV_IS_NOWHERE is enabled for i.MX9 SoC
and i.MX93 EVK board.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 arch/arm/mach-imx/imx9/soc.c          | 6 +++++-
 board/freescale/imx93_evk/imx93_evk.c | 2 +-
 include/configs/imx93_evk.h           | 6 ++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 7c28fa39e1..79ddbc7241 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -42,12 +42,16 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct rom_api *g_rom_api = (struct rom_api *)0x1980;
 
-#ifdef CONFIG_ENV_IS_IN_MMC
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
 __weak int board_mmc_get_env_dev(int devno)
 {
 	return devno;
 }
 
+#ifndef CONFIG_SYS_MMC_ENV_DEV
+#define CONFIG_SYS_MMC_ENV_DEV 0
+#endif
+
 int mmc_get_env_dev(void)
 {
 	int ret;
diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 341831a7d3..c9171df330 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -58,7 +58,7 @@ int board_init(void)
 
 int board_late_init(void)
 {
-#ifdef CONFIG_ENV_IS_IN_MMC
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
 	board_late_mmc_env_init();
 #endif
 
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 53fb8c9b1b..2a9595a261 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -27,6 +27,12 @@
 #define BOOTENV
 #endif
 
+#if CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
+#ifndef CONFIG_SYS_MMC_ENV_DEV
+#define CONFIG_SYS_MMC_ENV_DEV 0
+#endif
+#endif
+
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	BOOTENV \
-- 
2.47.0.windows.1

