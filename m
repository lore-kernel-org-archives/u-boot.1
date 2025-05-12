Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB53C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 17:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8AA082A36;
	Mon, 12 May 2025 19:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cgeGa4zr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GFaJLCJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63EA82A36; Mon, 12 May 2025 19:22:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D797A80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 19:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zx5yJ3fcRz9tRN;
 Mon, 12 May 2025 19:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COfX9f73aESEPxRa9Cw+JYLVc+Dd421G9ZOzHJ8MkJY=;
 b=cgeGa4zrEq7hOrcMmX25Mkl41JQq+HXPWjnsD4+aWf5TxXiIUJWNeb4qX3FJCueH3Kwpvl
 95BeyVR3yuVqMJZw/OaBnklEK7fwTlIzpu4V28eydujqSa6HIP26ELsGawc8wCbkBrDX0X
 zJcTDQ5bxdOSDTRNMay1TwMOJx2Dj/TAKY3Y+B277FslHXpPRsSEt0ecWuRErbg22voHZQ
 lwENCwG0VjfI+2JL5JsWNXrbif5FWcQjWjOkV3rcHwe/2xgcwJabYWPvi/XEHOJdLdm1Kk
 g6wuKOe+oDIGpkp1p4XXo8/oKNwL7lMPjAjNOPqDxq6QurnenRid4CyaRGn5OA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COfX9f73aESEPxRa9Cw+JYLVc+Dd421G9ZOzHJ8MkJY=;
 b=GFaJLCJb+Jms549EB+Gg01RwLKTaw7kKLuM2q7O9buVuKcHS7doapE+3IuT3I93WSFwjYp
 ijDOdi+XIyOQHJvAzWDkTDFe1tAbTZvVvSnE3EuwiUYKBNI8PKIwAPamdepBbx5UkcWDzT
 iskX5laOWnJ4Rz6Ab5JbwpgINZNLBl2W8SGKbgRh1GIqA852pS9Jd3ldZokSKcT/Y2OBAR
 3vMmEoQBHdob30Tq75FTOAjQx1z2d7ziFJ+9X2CQ8U8B0WtsiYw+7hSVEqNET5YN5UDGKx
 gcNPfifwRPn9BtYYBoEPxnGAHsjCDCLBltzg1bJPf4dZhrkacgZRn8bUo7z+Tg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
Date: Mon, 12 May 2025 19:21:28 +0200
Message-ID: <20250512172149.150214-2-marek.vasut@mailbox.org>
In-Reply-To: <20250512172149.150214-1-marek.vasut@mailbox.org>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fcf0fce494db52956a5
X-MBO-RS-META: spd8xkxnscbjras73774kar4m1xjwegq
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

Introduce Kconfig options used by SPL on STM32MP13xx and isolate
the Kconfig options only used in case TFA BL2 is used as a SPL
behind CONFIG_TFABOOT dependency.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Cheick Traore <cheick.traore@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Lionel Debieve <lionel.debieve@foss.st.com>
Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/Kconfig     | 7 +++++--
 arch/arm/mach-stm32mp/Kconfig.13x | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 58250901101..3a0ca50e9d6 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -40,16 +40,19 @@ choice
 config STM32MP13X
 	bool "Support STMicroelectronics STM32MP13x Soc"
 	select ARCH_EARLY_INIT_R
-	select ARM_SMCCC
+	select ARM_SMCCC if TFABOOT
+	select ARCH_SUPPORT_PSCI if !TFABOOT
+	select BINMAN if !TFABOOT
 	select CPU_V7A
 	select CPU_V7_HAS_NONSEC
 	select CPU_V7_HAS_VIRT
-	select OF_BOARD
+	select OF_BOARD if TFABOOT
 	select OF_BOARD_SETUP
 	select PINCTRL_STM32
 	select STM32_RCC
 	select STM32_RESET
 	select STM32_SERIAL
+	select SUPPORT_SPL if !TFABOOT
 	select SYS_ARCH_TIMER
 	imply CMD_NVEDIT_INFO
 	imply OF_UPSTREAM
diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
index bc8b3f8cf77..cecf9e3b8c7 100644
--- a/arch/arm/mach-stm32mp/Kconfig.13x
+++ b/arch/arm/mach-stm32mp/Kconfig.13x
@@ -20,7 +20,8 @@ config TARGET_ST_STM32MP13X
 endchoice
 
 config TEXT_BASE
-	default 0xC0000000
+	default 0xC0000000 if TFABOOT
+	default 0xC0100000 if !TFABOOT
 
 config PRE_CON_BUF_ADDR
 	default 0xC0800000
-- 
2.47.2

