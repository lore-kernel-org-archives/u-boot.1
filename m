Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A5C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 10:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE7A8794A;
	Mon, 22 Jan 2024 11:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="WaOYoQIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02317878E5; Mon, 22 Jan 2024 11:52:47 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC6D878ED
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 11:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20240122105243448bf5b77d3447b7a4 for <u-boot@lists.denx.de>;
 Mon, 22 Jan 2024 11:52:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HWWtJr7Vjec5wWBuBLUWsk5UmWCC+Vh7Y972yU2/5XU=;
 b=WaOYoQIWEf9/jbaeF4yr+rMZtNu7rqwNtZ4q5eFKJu0rGO/LEZXzvx96hQqz8pIbfOf+VY
 5JgdMRNIcjOxxOQi5zgSST6vr24Cb5Olg960aspFVqX7FxIkSvMOzMV0Ng4uP7ro7ZbA4Qkr
 nRaJxC6tBz6PZD0JQa13vAUT2jKv0=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de,
	alexander.sverdlin@siemens.com
Cc: trini@konsulko.com,
	Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v5 4/7] siemens: board: etamin: remove deprecated nand config
Date: Mon, 22 Jan 2024 11:52:34 +0100
Message-Id: <20240122105237.939823-5-enrico.leto@siemens.com>
In-Reply-To: <20240122105237.939823-1-enrico.leto@siemens.com>
References: <20240122105237.939823-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
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

NAND was used in the early development phase of etamin. The board runs now
on MMC. This setting is no more used -> remove to simplify the board file.

Further clean-up of etamin should remove all NAND settings. Complete clean-
up of etamin board will take place in a separate patch serie.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 board/siemens/common/board.c |  4 ----
 board/siemens/draco/Kconfig  |  2 --
 board/siemens/draco/board.c  | 26 --------------------------
 3 files changed, 32 deletions(-)

diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index 80737838a23..9551a29f03d 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -135,10 +135,6 @@ int board_init(void)
 
 	gpmc_init();
 
-#if CONFIG_IS_ENABLED(NAND_CS_INIT)
-	board_nand_cs_init();
-#endif
-
 	return 0;
 }
 #endif /* #ifndef CONFIG_SPL_BUILD */
diff --git a/board/siemens/draco/Kconfig b/board/siemens/draco/Kconfig
index 0cdf5bc9812..9d45c4239be 100644
--- a/board/siemens/draco/Kconfig
+++ b/board/siemens/draco/Kconfig
@@ -44,6 +44,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
         default "draco-etamin"
 
-config NAND_CS_INIT
-	def_bool y
 endif
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index a0a7d51db32..8c5783d0fb4 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -358,30 +358,4 @@ U_BOOT_CMD(
 #endif /* #if defined(CONFIG_DRIVER_TI_CPSW) */
 #endif /* #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) */
 
-#if CONFIG_IS_ENABLED(NAND_CS_INIT)
-#define ETAMIN_NAND_GPMC_CONFIG1	0x00000800
-#define ETAMIN_NAND_GPMC_CONFIG2	0x001e1e00
-#define ETAMIN_NAND_GPMC_CONFIG3	0x001e1e00
-#define ETAMIN_NAND_GPMC_CONFIG4	0x16051807
-#define ETAMIN_NAND_GPMC_CONFIG5	0x00151e1e
-#define ETAMIN_NAND_GPMC_CONFIG6	0x16000f80
-
-/* GPMC definitions for second nand cs1 */
-static const u32 gpmc_nand_config[] = {
-	ETAMIN_NAND_GPMC_CONFIG1,
-	ETAMIN_NAND_GPMC_CONFIG2,
-	ETAMIN_NAND_GPMC_CONFIG3,
-	ETAMIN_NAND_GPMC_CONFIG4,
-	ETAMIN_NAND_GPMC_CONFIG5,
-	ETAMIN_NAND_GPMC_CONFIG6,
-	/*CONFIG7- computed as params */
-};
-
-static void board_nand_cs_init(void)
-{
-	enable_gpmc_cs_config(gpmc_nand_config, &gpmc_cfg->cs[1],
-			      0x18000000, GPMC_SIZE_16M);
-}
-#endif
-
 #include "../common/board.c"
-- 
2.30.2

