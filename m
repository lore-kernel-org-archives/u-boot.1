Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1BAC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 15:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B4E810F2;
	Thu, 27 Feb 2025 16:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lTHtbO6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196CC81112; Thu, 27 Feb 2025 16:30:09 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDA980FF2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 16:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2230c74c8b6so31561155ad.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740670185; x=1741274985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3YaURWoke6fGCvGJqp34ls6XFCv9IQmxk1Wv+DNFGSc=;
 b=lTHtbO6MfNg+5aa5lCRbvq76zWwB5+hgeEAFv5N0RzsLhgzRnMK7UvpqSiBunqWLFi
 9Z0bissihU1M9WM1VYzjGOe136QEkieHIfQNcDgBv/UHBPIQvT/BAAR88nAHSXkjeRhI
 cYywK9b624wN4gbj7siZQqSJwwzZCetBiZGlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740670185; x=1741274985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YaURWoke6fGCvGJqp34ls6XFCv9IQmxk1Wv+DNFGSc=;
 b=sfvnP29wifPeh67CHSndj/0x9ijtuNGwPTmjFaSYlBsl29ugS2sa49SOEESrXdfhA2
 3PuJdlYBGMLYFblT+hxC/2Oyk23Z1UGg4p7KZbRXqTZqQ7qwMNWFadknsKHI5Neswaaf
 sFAqYB2vMdTkcZQBPLTfvvbwUtmvhpaEwKODTyfpFnN23J3d7ERlV6xmNG9zAbBDWDma
 rmbnOCWfUFyTih6+14HFwK9kbpcmt98q77ewMvHkPS9iiPfG2Ff/zTuxUKBGsRzyCx5u
 nVslZJlAwfWlgA0QmF5F2e0aiqrsWedTOElCzBYzpxIs4bErHYUuyPFkRdv7lL3dEXKk
 FOJg==
X-Gm-Message-State: AOJu0Yze02KHyKTqTaKt7YXHR3Gu5qE1ciwI1a8bXYPhLi0YLEH40NlE
 DlwS4kMOmzzY5zZl82kmcW1jAfBKsPLwM3lRvxYdH5ym+PVMHQwK9/z9pX9pTC5eKyX+Ckd2Uaw
 xhoI=
X-Gm-Gg: ASbGnctvvyrgIVWgEm8xmKvEA045s6VNti1CsGWVcN0QskysIws9K9Qegtux/cml5Kq
 5S+G/QFcJu5UNXpIEGt+Ml6u1YRBDvIfxZTAb7XwDCHyFfBHsvhiXsfolw+L7Zna4Nd1AscL5Ye
 815eyqKfSbiESaNC63OzGY+H7wCm/aWEmn/traUFCX6yfQGDJK2ry0+q2TFpepWX55MUGHVp6gl
 rjA7e/jTFvYeI2hoABCXp3ileO21en4HP91HrkCE9HSk3pFXVvuMDzajDiYL26pD2ryywA8aHoO
 HcQiogq0LfnfMaYBAANqQaRLOMw=
X-Google-Smtp-Source: AGHT+IHYVOYF/s+3Kz/DrUUTUY/uI5MSwZkmFGBw0W/2d2aWVpQuDh4NG4PJOiPb35a1G6TfZnwHxA==
X-Received: by 2002:a05:6a00:a24:b0:732:622f:ec39 with SMTP id
 d2e1a72fcca58-734790a7da0mr17230518b3a.1.1740670185103; 
 Thu, 27 Feb 2025 07:29:45 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe48838sm1744513b3a.39.2025.02.27.07.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 07:29:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] mmc: fsl_esdhc: Migrate ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE to
 Kconfig
Date: Thu, 27 Feb 2025 09:29:42 -0600
Message-ID: <20250227152942.3966518-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The flag for enabling the ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE quirk can be
handled easily enough in Kconfig. This lets us remove a function but not
obviously correct usage of the IS_ENABLED() macro.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Fabio Estevam <festevam@denx.de>
---
 arch/powerpc/include/asm/config_mpc85xx.h | 3 ---
 drivers/mmc/Kconfig                       | 6 ++++++
 drivers/mmc/fsl_esdhc_imx.c               | 8 +-------
 include/configs/imxrt1020-evk.h           | 2 --
 include/configs/imxrt1050-evk.h           | 2 --
 include/configs/imxrt1170-evk.h           | 2 --
 6 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/config_mpc85xx.h b/arch/powerpc/include/asm/config_mpc85xx.h
index 819250f00902..abdaffbe00bc 100644
--- a/arch/powerpc/include/asm/config_mpc85xx.h
+++ b/arch/powerpc/include/asm/config_mpc85xx.h
@@ -133,7 +133,6 @@
 #define CFG_FM_PLAT_CLK_DIV	1
 #define CFG_SYS_FM1_CLK		CFG_FM_PLAT_CLK_DIV
 #define CFG_SYS_FM_MURAM_SIZE	0x30000
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 #define QE_MURAM_SIZE			0x6000UL
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
@@ -146,7 +145,6 @@
 #define CFG_SYS_FM1_CLK		0
 #define CFG_QBMAN_CLK_DIV		1
 #define CFG_SYS_FM_MURAM_SIZE	0x30000
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 #define QE_MURAM_SIZE			0x6000UL
 #define MAX_QE_RISC			1
 #define QE_NUM_OF_SNUM			28
@@ -165,7 +163,6 @@
 #define CFG_SYS_PME_CLK		CFG_PME_PLAT_CLK_DIV
 #define CFG_SYS_FM1_CLK		0
 #define CFG_SYS_FM_MURAM_SIZE	0x28000
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 
 #elif defined(CONFIG_ARCH_C29X)
 #define CFG_SYS_FSL_SEC_IDX_OFFSET	0x20000
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4827834b4aab..06053a318c93 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -919,6 +919,12 @@ config ESDHC_DETECT_QUIRK
 	bool "QIXIS-based eSDHC quirk detection"
 	depends on FSL_ESDHC && FSL_QIXIS
 
+config ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
+	bool
+	depends on FSL_ESDHC || FSL_ESDHC_IMX
+	def_bool y if ARCH_T1024 || ARCH_T1040 || ARCH_T1042 || ARCH_T2080 \
+		|| FSL_ESDHC_IMX
+
 config FSL_ESDHC_IMX
 	bool "Freescale/NXP i.MX eSDHC controller support"
 	help
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index d7a45ef0ad0d..926113f79d36 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -40,12 +40,6 @@
 #include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
-#ifndef ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
-#ifdef CONFIG_FSL_USDHC
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE	1
-#endif
-#endif
-
 DECLARE_GLOBAL_DATA_PTR;
 
 #define SDHCI_IRQ_EN_BITS		(IRQSTATEN_CC | IRQSTATEN_TC | \
@@ -376,7 +370,7 @@ static int esdhc_setup_data(struct fsl_esdhc_priv *priv, struct mmc *mmc,
 	    (timeout == 4 || timeout == 8 || timeout == 12))
 		timeout++;
 
-	if (IS_ENABLED(ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE))
+	if (IS_ENABLED(CONFIG_ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE))
 		timeout = 0xE;
 
 	esdhc_clrsetbits32(&regs->sysctl, SYSCTL_TIMEOUT_MASK, timeout << 16);
diff --git a/include/configs/imxrt1020-evk.h b/include/configs/imxrt1020-evk.h
index cd6af93454b6..aec12082b95d 100644
--- a/include/configs/imxrt1020-evk.h
+++ b/include/configs/imxrt1020-evk.h
@@ -9,8 +9,6 @@
 
 #include <asm/arch/imx-regs.h>
 
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE	1
-
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			(32 * 1024 * 1024)
 
diff --git a/include/configs/imxrt1050-evk.h b/include/configs/imxrt1050-evk.h
index c520c2fc203a..5b8d6a7ac05a 100644
--- a/include/configs/imxrt1050-evk.h
+++ b/include/configs/imxrt1050-evk.h
@@ -9,8 +9,6 @@
 
 #include <asm/arch/imx-regs.h>
 
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE	1
-
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			(32 * 1024 * 1024)
 
diff --git a/include/configs/imxrt1170-evk.h b/include/configs/imxrt1170-evk.h
index 1ccaa15bc112..f821212765c9 100644
--- a/include/configs/imxrt1170-evk.h
+++ b/include/configs/imxrt1170-evk.h
@@ -10,8 +10,6 @@
 
 #include <asm/arch/imx-regs.h>
 
-#define ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE	1
-
 /*
  * Configuration of the external SDRAM memory
  */
-- 
2.43.0

