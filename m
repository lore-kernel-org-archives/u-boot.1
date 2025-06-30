Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC64C7EE30
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 00:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACD582F5E;
	Mon, 30 Jun 2025 02:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h30I5u4N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lui7CrI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217F482F54; Mon, 30 Jun 2025 02:11:13 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFBF81FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 02:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bVmlw26s7z9sv4;
 Mon, 30 Jun 2025 02:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7IsAZW9uVi0YRA9nWJhG9aMzVloiRQXVA715hehv0hI=;
 b=h30I5u4N6tUnlzZ1i0UFmluasE82X/pqQgPVZHKJjDZ9I00yJqfQTILm5Sf6GpsA3sH38n
 nM1PKqrOJOwj8nKn0s/y4CrRcGLYCUTdwI9P3w9GnIvLT85Iq2u10wmHk0pv1gnlq16ets
 x8MQfubDttxTAFWKc0SxfRQ+g0l3GxED/0QoWWTddX5od/2GjBMLaStD4K5OCvlcYaFUYb
 2Gm360FOz70NS64UU/b+Mx3ExpbE+Rq6MvuTOTPpnGH168mtlDN6KS9NVvnMXG53H8Dp66
 2gQ2XCTxd+cNT1g0N/OhmeXRN/RmooOg5RrLNnqSPFOGJgvf43EoWwHYVVqSKA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7IsAZW9uVi0YRA9nWJhG9aMzVloiRQXVA715hehv0hI=;
 b=Lui7CrI6pKh8JcnQsk028eWTJ6GwX4fGePtdbFp63Z+lz9t+abdrLXTjWa9c0vYi138aY1
 6DH0J5+pm2LSnORrTNyBDjHQR6ajFYGBpJfevdt22OsujN/k0JRXHp0IzR+N9vR274QVIt
 j1lL6+G+fOYAwt64hjIPjKXEMi0XjDfr5tY4nhES6xT+IsEXQUrPbMTf8tsNWk2+jW7WYF
 QNhpN4oq2weeVsIKYRRSo6hyPY0wimgVhpZkeZppJM+VdRPbnHpns2hq4/JCGuE1BWzPIB
 3CvgcVKTTeZVyYacgF17bC+78VOsQEGOXf8eyw+y9qB8FQ97hkE+an0tZHKy+Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
Date: Mon, 30 Jun 2025 02:10:27 +0200
Message-ID: <20250630001053.952342-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xcsfqprjmny61kapau6ua45fd9drpj85
X-MBO-RS-ID: ba501e81c1344fe569a
X-Rspamd-Queue-Id: 4bVmlw26s7z9sv4
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
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
V2: Add RB from Patrice
---
 arch/arm/mach-stm32mp/Kconfig     | 7 +++++--
 arch/arm/mach-stm32mp/Kconfig.13x | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 09b7d5123ae..c658ac19b41 100644
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

