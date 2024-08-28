Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EE6C54E92
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C4888C03;
	Wed, 28 Aug 2024 12:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A0BKB2Kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BAD88B63; Wed, 28 Aug 2024 12:12:35 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F2CF88B16
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5FE03CE1796;
 Wed, 28 Aug 2024 10:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0424C4E690;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839449;
 bh=oPZs+G0T3WazXTJL/Zt9RMeadis9zUzr8bYfQFtUZtw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=A0BKB2Kwq8tGEAXjDMvKPH+XMJrw/1wMBJk4Cj2JLBEIbBbSysHiQF+nnnPULang4
 O0PwiGd7Px0FEzD06uHQNv+Ds4RHzZJysvKiE5+fYbqOx8BrOB5YcW2IpZ7Xn+inMD
 gwY3nj2W5oSLE7QLt5H/pRCAVViMCBAMqWoCjSKgQAGfRMebD2YlgPzYcI5Jt9fFGZ
 EzJ4apUHhPHi3aRwpGmeZnTlIxGO4vJb3mbyp+FFQ7nzIUPxRwAtZl8NPpY1XaPXOM
 SRFJDm1Z8Cz+rvroTQL5cY5/uLqDBq4MUvIfql5pnFtO6dUlXiBCg+XT8Z7p1rJPEh
 e7+dFR/bLRqRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E7961C54E62;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:20 +0100
Subject: [PATCH 12/20] arm: mach-sc5xx: clean up Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-12-44d9adfdf327@analog.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=2293;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=GqAzHP3KosVfnR2WvoYCrPLMox90jgqaH+gfLsq7l78=;
 b=Dbqrde6b/peWVFsuWwr3sOp/ItUmKtntqaVhWuK5gupytt4s/kXNAXJqJglWA65I5anIO2sNj
 H2w6WPw5153B5PiI0BMxMUHy6jb2pkFhqW5AAttf55dx85ZwQaLMINj
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
 arch/arm/mach-sc5xx/Kconfig | 31 +++++++++++--------------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba0359fed5..69decaa591 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1868,6 +1868,14 @@ config TARGET_LS1046AFRWY
 
 config ARCH_SC5XX
 	bool "Analog Devices SC5XX-processor family"
+	select SPL
+	select SUPPORT_SPL
+	select PANIC_HANG
+	select DM
+	select SPL_DM
+	select DM_SERIAL
+	select TIMER
+	select ADI_SC5XX_TIMER
 
 config TARGET_SL28
 	bool "Support sl28"
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 3846b4fd5b..d99b02b574 100644
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
+	bool "SC57x series"
 	select CPU_V7A
-	select PANIC_HANG
 	select COMMON_CLK_ADI_SC57X
-	select TIMER
-	select ADI_SC5XX_TIMER
 
 config SC58X
-	bool
-	select SUPPORT_SPL
+	bool "SC58x series"
 	select CPU_V7A
-	select PANIC_HANG
 	select COMMON_CLK_ADI_SC58X
-	select TIMER
-	select ADI_SC5XX_TIMER
 
 config SC59X
-	bool
-	select SUPPORT_SPL
+	bool "SC59x 32-bit series"
 	select CPU_V7A
-	select PANIC_HANG
 	select COMMON_CLK_ADI_SC594
-	select TIMER
-	select ADI_SC5XX_TIMER
 	select NOP_PHY
 
 config SC59X_64
-	bool
-	select SUPPORT_SPL
-	select PANIC_HANG
+	bool "SC59x 64-bit series"
 	select MMC_SDHCI_ADMA_FORCE_32BIT
 	select ARM64
-	select DM
-	select DM_SERIAL
 	select COMMON_CLK_ADI_SC598
 	select GICV3
 	select GIC_600_CLEAR_RDPD
 	select NOP_PHY
 
+endchoice
+
 config SC_BOOT_MODE
 	int "SC5XX boot mode select"
 	default 1

-- 
2.34.1


