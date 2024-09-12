Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58482EED617
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72028906C;
	Thu, 12 Sep 2024 17:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kuSFbHPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CCB8905E; Thu, 12 Sep 2024 17:51:21 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9981189020
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 96692A456FC;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E805DC4CECC;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=jUm09dIFH8fHQB5/KBA//d/dcsRr1NVIGdWDKBdFvMM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kuSFbHPgwl5pTwdETEHOzE2BqceVheNKzpbrLB04ZYjnN1WC7mX4AfRKfV1f4Msox
 owKZX8UlJd+DNyOCLO6ESHyurtzWNhSITux2MKu5Todv2ZA5p+YGhYNjatx9srz5mM
 3rfvIWaT6w7eZWGRTfNJfdJ8Uv6YzhFmvVIEwwK/pgZBeJCTEpc1UYbzQseakt7Wd5
 OzZy6PXO3gofi9SMWrmapXEDlgi4wos6VrqcTMfsTDU7b0xcSDS0E0YzvELlxbCPUu
 qg7GWuOK5vlCG+L32wdxu2q2oLYs3tzsWEgQn+WFyDkHYpnAelXDOruPNR0Shjf307
 ZtmPgikO3kbKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E21CCEED618;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:53 +0100
Subject: [PATCH v2 12/20] arm: mach-sc5xx: clean up Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-12-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=2392;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=7bnm3vMM/zOKe6FK7GtGt37ws75/PYDFzRyCKZfj0UQ=;
 b=z/biYdkmo15DiI0AB8LkCwPigkYm1lmxiGDBhGrjT5FIc4yuskdQcErtcXpBvzc8/z0GEV5aD
 jEvM1tTT/K4CpMtJWLvRfGLwBIf6cgGeWeBfBy19jo/oyuuqZ55ke0p
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Moves common options between all SC5xx series boards to the ARCH_SC5XX
option instead of duplicating them.

Also, it was possible to select multiple of the SoC support options.
Given a U-Boot binary can only support a single platform, this moves
the SoC selection to a `choice`, making them mutually exclusive.

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 arch/arm/Kconfig            |  8 ++++++++
 arch/arm/mach-sc5xx/Kconfig | 39 +++++++++++++++------------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba0359fed5..72960126ee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1868,6 +1868,14 @@ config TARGET_LS1046AFRWY
 
 config ARCH_SC5XX
 	bool "Analog Devices SC5XX-processor family"
+	select ADI_SC5XX_TIMER
+	select DM
+	select DM_SERIAL
+	select PANIC_HANG
+	select SPL
+	select SPL_DM
+	select SUPPORT_SPL
+	select TIMER
 
 config TARGET_SL28
 	bool "Support sl28"
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 3846b4fd5b..2ec09dbf3e 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -13,47 +13,38 @@
 
 if ARCH_SC5XX
 
+choice
+	prompt "SC5xx SoC Select"
+	help
+	  Selects which series of Analog Devices SC5xx chips to support.
+
 config SC57X
-	bool
-	select SUPPORT_SPL
-	select CPU_V7A
-	select PANIC_HANG
+	bool "SC57x series"
 	select COMMON_CLK_ADI_SC57X
-	select TIMER
-	select ADI_SC5XX_TIMER
+	select CPU_V7A
 
 config SC58X
-	bool
-	select SUPPORT_SPL
-	select CPU_V7A
-	select PANIC_HANG
+	bool "SC58x series"
 	select COMMON_CLK_ADI_SC58X
-	select TIMER
-	select ADI_SC5XX_TIMER
+	select CPU_V7A
 
 config SC59X
-	bool
-	select SUPPORT_SPL
-	select CPU_V7A
-	select PANIC_HANG
+	bool "SC59x 32-bit series"
 	select COMMON_CLK_ADI_SC594
-	select TIMER
-	select ADI_SC5XX_TIMER
+	select CPU_V7A
 	select NOP_PHY
 
 config SC59X_64
-	bool
-	select SUPPORT_SPL
-	select PANIC_HANG
-	select MMC_SDHCI_ADMA_FORCE_32BIT
+	bool "SC59x 64-bit series"
 	select ARM64
-	select DM
-	select DM_SERIAL
 	select COMMON_CLK_ADI_SC598
 	select GICV3
 	select GIC_600_CLEAR_RDPD
+	select MMC_SDHCI_ADMA_FORCE_32BIT
 	select NOP_PHY
 
+endchoice
+
 config SC_BOOT_MODE
 	int "SC5XX boot mode select"
 	default 1

-- 
2.34.1


