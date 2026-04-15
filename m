Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C3DF41992
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 11:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D9883B99;
	Wed, 15 Apr 2026 13:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="MtESJa4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22D783C2B; Wed, 15 Apr 2026 13:47:06 +0200 (CEST)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EA180086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 13:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Luj0wtlYI5+rDh97cVJdHpgjjr/2Mb3bWTVnOdlC6uo=; b=MtESJa4R9e7vTNSDGQ6oVDf4/f
 AMB1C1qutepCzOEZi0a0rsdcIZGD6ZliG7UQsGzJQUbzTDfNM+cHxm0xeoZSOhHNzqesjxH5d4F5O
 wiKwzA40Wbt4CZ9djGIfCQJNrFVQ5mg/7j7JVoIu8At/2IeNiBB2fMyIVgzheqntD6txDDuyi/aFK
 BUWTZeyYfm5iQVD6V6f8pSPfiYrsO9FvbGhUa4BCOpnLnSRulH+3IVESl3NyX+C68953l2B/W9H/i
 BDlZva6BfIR/u/82+30ZT2++iSPzK6qYc2Zu/GdTnFeZjpNeBqog4VhsCE821GQIxjyKPLpYgs0uR
 LpucO0ZA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:43782
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1wCyhx-000000041sm-3rgz; Wed, 15 Apr 2026 13:46:58 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
Date: Wed, 15 Apr 2026 13:46:58 +0200
Message-Id: <20260415114658.3321643-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Instead of adding select ARCH_MISC_INIT for each i.MX 9x SoC, select it
at the i.MX9 family Kconfig level. The corresponding arch_misc_init() is
already defined in the common arch/arm/mach-imx/imx9/soc.c file and will
print out ELE firmware BuildInfo for all i.MX9 SoCs now instead of just
i.MX91 and i.MX95.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 2308457df23e..12eb0af88a73 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -7,6 +7,7 @@ config AHAB_BOOT
 
 config IMX9
 	bool
+	select ARCH_MISC_INIT
 	select BINMAN
 	select CPU
 	select CPU_IMX
@@ -22,7 +23,6 @@ config IMX93
 config IMX91
 	bool
 	select IMX9
-	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX95_A0
@@ -30,7 +30,6 @@ config IMX95_A0
 
 config IMX95
 	bool
-	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 	select IMX9
 	select DM_MAILBOX
-- 
2.34.1

