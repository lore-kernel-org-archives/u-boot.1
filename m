Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB79C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 11:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B418323A;
	Wed, 16 Jul 2025 13:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="qHARf4p4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243728313B; Wed, 16 Jul 2025 13:18:55 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F363A831D8
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 13:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iLFMpHx5vHtl8/PCTi/mSKuYGs1D9bFC+03QY/UmcVU=; b=qHARf4p4py5f5aTL/Lv3xZJoVS
 LKSe9+mvUOLX4ZpOki8+wk2bW77LYLFyCm1udIa22VW8vSxFBec21Z3DZ++cI0T/QF8UJQkCqzRYS
 thIxgR+D7C46LsyAiWxM6b+jjrd7RIP2aRYbUOpWDltn7kAR1YgHYp+r2UP1Z0cUvmcN7W7dtYAuJ
 M52S0yrZvx/Gh6WenHPrgNRVmTly9FF/mR85rbFKjtNgdJNIaBVVEaa9uG7hiH1eHKpXQXJIpg38H
 aEcqTz3VfvUYoBamchpzC44Km5AVdo4pHjIfCMvp6PN4pdc1zrqFOLCNHz++RnYQkZFiK0gMoAolM
 0FS1dOXA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:49610
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uc09z-008q09-24;
 Wed, 16 Jul 2025 13:18:51 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] board: phytec: phycore-imx93: Drop unused include files
Date: Wed, 16 Jul 2025 13:18:51 +0200
Message-Id: <20250716111851.1168897-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716111851.1168897-1-primoz.fiser@norik.com>
References: <20250716111851.1168897-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
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

Drop unused include files from the PHYTEC phyCORE-i.MX93 board code.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore-imx93.c | 3 ---
 board/phytec/phycore_imx93/spl.c           | 2 --
 2 files changed, 5 deletions(-)

diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index a55795e06034..8d2caf8bbef6 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -6,10 +6,7 @@
  * Copyright (C) 2024 PHYTEC Messtechnik GmbH
  */
 
-#include <asm/arch-imx9/ccm_regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/arch-imx9/imx93_pins.h>
-#include <asm/arch/clock.h>
 #include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 3876db9d2ab7..7b5d38d438f2 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -14,9 +14,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
-#include <hang.h>
 #include <init.h>
-#include <log.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
 #include <spl.h>
-- 
2.34.1

