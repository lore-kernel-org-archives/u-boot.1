Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF0BC3DA4B
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D70CC88837;
	Sat, 13 Jul 2024 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BQliZqeQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pcKVoci3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBE08889A; Sat, 13 Jul 2024 15:21:31 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B2C88872
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyK2FFJz9sTd;
 Sat, 13 Jul 2024 15:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8jC1kNfN84eBzPtu/LG619iXLCY4r3rX/FWeXS15gU=;
 b=BQliZqeQhs1Tp87cTTKi+3SKXS1+BZZbhaK1FcNHTDFcwKzicXO1S/jiom3VuIgF45mkgL
 +IdRJia9WGuAaa/G0QfaXRhedQliWeiAU4NA1OsFfXS8x8R2Q1yfElgy12027Rjmi3oU80
 fNazF+h8hmL1dy7nVUapOTeybOfFHd8G8VsffbQrdepQsog0CXhvzAmbvZGSCaY2CMEMZt
 mmao9b8vRy2jNAJt3FyFjvEy8Y5Lfbkpv/kLy+99Tk1kNbhqYTcvM+IPwD5lljAW0mLBfz
 JHKT0UdbC67Fxzuq+/DdmdsJfzOBRoqrL+qu9hkZMnU8+C3sybRUQHbbkOSfRg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8jC1kNfN84eBzPtu/LG619iXLCY4r3rX/FWeXS15gU=;
 b=pcKVoci3X+Sv6axTD5JcOw5NpM1UM4RXWqbeGH2YujYcvVV7hRun7NrUi8MRFmr/wk1ney
 6WYbhdeHoS6QFueFG4t1sqEE0wIvQ2nE8SGLdEuyLKkKzgeoL2iqrFUDQtv+rE7VSyk8WA
 toks4/UXbJdIDDhQdKw7wcWWKLMjsCUFKMCk6NYuOzB2oSUeK6wasmSEQj2BEru2xD0e+d
 GoWm0Sg6YQPlGLStIFy3PMsggMMZIUJ8OmPGvXWj0miHvzPP8p7oGYort2PdP1H5YAsrKm
 56Gq8hNifyvJXOqTGgLVApN81gnMvPRiC4D0AOzacCJCL83AkwFCGEpw0yofSg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/45] arm: mach: socfpga: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:12 +0200
Message-ID: <20240713132021.57650-21-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bccfec69ce568b1e818
X-MBO-RS-META: xyac7za5ppobnkaam83z1y6hruyrpip7
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-socfpga/clock_manager_gen5.c             | 1 -
 arch/arm/mach-socfpga/freeze_controller.c              | 1 -
 arch/arm/mach-socfpga/include/mach/clock_manager_s10.h | 1 -
 arch/arm/mach-socfpga/misc_soc64.c                     | 1 -
 arch/arm/mach-socfpga/reset_manager_gen5.c             | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-socfpga/clock_manager_gen5.c b/arch/arm/mach-socfpga/clock_manager_gen5.c
index 154ad2154ae..0a2c84c9e13 100644
--- a/arch/arm/mach-socfpga/clock_manager_gen5.c
+++ b/arch/arm/mach-socfpga/clock_manager_gen5.c
@@ -125,7 +125,6 @@ int cm_basic_init(const struct cm_config * const cfg)
 	readl(socfpga_get_clkmgr_addr() + CLKMGR_GEN5_PERPLL_VCO);
 	readl(socfpga_get_clkmgr_addr() + CLKMGR_GEN5_SDRPLL_VCO);
 
-
 	/*
 	 * We made sure bgpwr down was assert for 5 us. Now deassert BG PWR DN
 	 * with numerator and denominator.
diff --git a/arch/arm/mach-socfpga/freeze_controller.c b/arch/arm/mach-socfpga/freeze_controller.c
index 7c86350d5ea..c8530c98043 100644
--- a/arch/arm/mach-socfpga/freeze_controller.c
+++ b/arch/arm/mach-socfpga/freeze_controller.c
@@ -3,7 +3,6 @@
  *  Copyright (C) 2013 Altera Corporation <www.altera.com>
  */
 
-
 #include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock_manager.h>
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
index 7f10296dc74..18921169a6d 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
@@ -106,7 +106,6 @@ void cm_basic_init(const struct cm_config * const cfg);
 #define CLKMGR_INTER					CLKMGR_S10_INTER
 #define CLKMGR_PERPLL_EN				CLKMGR_S10_PERPLL_EN
 
-
 #define CLKMGR_CTRL_SAFEMODE				BIT(0)
 #define CLKMGR_BYPASS_MAINPLL_ALL			0x00000007
 #define CLKMGR_BYPASS_PERPLL_ALL			0x0000007f
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index ad1ef0db186..a6cc78454da 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -39,7 +39,6 @@ static Altera_desc altera_fpga[] = {
 	},
 };
 
-
 /*
  * Print CPU information
  */
diff --git a/arch/arm/mach-socfpga/reset_manager_gen5.c b/arch/arm/mach-socfpga/reset_manager_gen5.c
index 9395122dae1..6a202bf227c 100644
--- a/arch/arm/mach-socfpga/reset_manager_gen5.c
+++ b/arch/arm/mach-socfpga/reset_manager_gen5.c
@@ -3,7 +3,6 @@
  *  Copyright (C) 2013 Altera Corporation <www.altera.com>
  */
 
-
 #include <mach/base_addr_ac5.h>
 #include <asm/io.h>
 #include <asm/arch/fpga_manager.h>
-- 
2.43.0

