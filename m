Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFAFC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF67B80C83;
	Mon, 12 May 2025 18:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eDba/7ah";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="diXDsmsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1207826AA; Mon, 12 May 2025 18:44:34 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1616080584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zx56l5QBNz9slv;
 Mon, 12 May 2025 18:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7tU9C4G36M3TmoqXvgky5u+kJa+6BteBh7IdA2hKN7s=;
 b=eDba/7ahGzmycA8OVglFNBXHEKpChyudmRacJl3PAeGVqr0ZpEhAyfMsbcLokV/wZoH9RZ
 mPg2AR83ddCQNjHeH0Uhu2UFwfflaR0HV/bRxz3SRgf8r2cp7QqqenkdRyFEw6WalY2vDU
 Oe0mNE88rbbO6oylwtvCdYa3aK637lTYmrM+ufw2XqY8yanfIOPiHAR3Vy8MDXiaMHZ/WV
 tpEXx49tWYQHyfZiG7U0cbjqmoEu+I7ICrBp0tdh5iMvY6210tYa5ZEZ/ItoFU5KGthJFT
 T11JluS/gaUezh0lWVwUyR10Min6wJqnYQV07Vc30umwlGj0fqMr0sz0A2BBHA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7tU9C4G36M3TmoqXvgky5u+kJa+6BteBh7IdA2hKN7s=;
 b=diXDsmsdEmTCLXjS5ug3lPjS4oDOFJKMR9hNeNav0bNz5HxeCS6OXORFIxnsQuE/AFDYH5
 +UBPBRSOnOa7ugwdSglVMqVnx5R8bGVupMXHTcM8bP84UMwSzwWIKnrERSMAgZ/jJB6BcM
 FlHuJXc3vwLXSWczu3DCviMwH2X5NYWc0OgOiw9AxtiCGJa4kpyASahFePQHQkIosjmsqO
 97qYcDonWbum0lYWniVwNltH4pLdYwRw+fy2VT5CdkKdYdsTKNPutGFUqOzUb1tdiB1c5l
 puaZUsArfTspB7xl4sfmj/JmnUs0ZeRdU29WgvwKUWzEGYkvgybx15OWLtKrnQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Fix SYSRAM size on STM32MP13xx
Date: Mon, 12 May 2025 18:44:04 +0200
Message-ID: <20250512164418.147714-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d71e54a9b6fc67e18af
X-MBO-RS-META: m63g6musfdrxnxibtinqmbojqgguggif
X-Rspamd-Queue-Id: 4Zx56l5QBNz9slv
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

The STM32MP13xx has only 128 kiB of SYSRAM starting at address 0x2ffe0000 .
The STM32MP15xx has 256 kiB of SYSRAM starting at address 0x2ffc0000 . Make
sure both SoCs configure ARMV7_SECURE_BASE correctly . Define the SYSRAM
base in stm32.h to be consistent with the STM32MP15xx macro.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/cpu/armv7/Kconfig                 | 3 ++-
 arch/arm/mach-stm32mp/include/mach/stm32.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index 4eb34b7b449..ab86d642eee 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -36,7 +36,8 @@ config ARMV7_SECURE_BASE
 	hex "Base address for secure mode memory"
 	depends on HAS_ARMV7_SECURE_BASE
 	default 0xfff00000 if TEGRA124
-	default 0x2ffc0000 if ARCH_STM32MP
+	default 0x2ffe0000 if STM32MP13X
+	default 0x2ffc0000 if STM32MP15X
 	default 0x2f000000 if ARCH_MX7ULP
 	default 0x10010000 if ARCH_LS1021A
 	default 0x00900000 if ARCH_MX7
diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index a9ac49bc5d2..47b459b75d1 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -110,6 +110,11 @@ enum forced_boot_mode {
 #define STM32_SDMMC2_BASE		0x58007000
 #define STM32_SDMMC3_BASE		0x48004000
 
+#ifdef CONFIG_STM32MP13X
+#define STM32_SYSRAM_BASE		0x2FFE0000
+#define STM32_SYSRAM_SIZE		SZ_128K
+#endif
+
 #ifdef CONFIG_STM32MP15X
 #define STM32_SYSRAM_BASE		0x2FFC0000
 #define STM32_SYSRAM_SIZE		SZ_256K
-- 
2.47.2

