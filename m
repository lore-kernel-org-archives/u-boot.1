Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0A2C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 11:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16523831D8;
	Wed, 16 Jul 2025 13:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="YF7AJdVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A2583214; Wed, 16 Jul 2025 13:18:55 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F266E8313B
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 13:18:51 +0200 (CEST)
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
 bh=htssVZU+iVKQdmCjxMnuIJYseahUPXDMvW8odwVNv2k=; b=YF7AJdVSBDikN+UNLOaAPWGAu6
 1UjWWsaHjN9zbWtSV3+oFj8SMulK4tBr+bizy+wLAZyYIgL9jOzR1zCIK3/TV42ahua+8HDn0ZPq1
 Rg0bfzIvRUIQwgV/kamsYFyM4EWs5ZzxG8LiWhYCAo4nKc4pY4MsaLsQtxNtuHTzM1kosVy1DSvq4
 +0g8eL8LFgG0lfC+CgS0CHT84k/sv1euKdnQ3Nce6s/4nn3uWfxyU6hk6JyCJBnSaX56jmfApwaoG
 a0gA9J1mLytpxPlTLff3pgs5xj+WsHhknkQIpglK0/whiIPSAs07pS67Y2djomoibqraQbPPQaWZE
 b1P9OQUA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:49610
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uc09z-008q09-1r;
 Wed, 16 Jul 2025 13:18:51 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] board: phytec: phycore-imx93: Drop unused PMIC define
Date: Wed, 16 Jul 2025 13:18:50 +0200
Message-Id: <20250716111851.1168897-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
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

Drop unused define for PCA9450 PMIC register which is already part of
the header file <power/pca9450.h> since commit 1d0d25704345 ("imx93_evk:
spl: update pmic settings").

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/spl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index a4d2aaac3204..3876db9d2ab7 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -25,11 +25,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/*
- * Will be part of drivers/power/regulator/pca9450.c
- * when pca9451a support is added.
- */
-#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
 #define EEPROM_ADDR            0x50
 
 /*
-- 
2.34.1

