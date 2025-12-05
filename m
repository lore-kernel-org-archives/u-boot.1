Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574CED2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 11:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4973D841F7;
	Fri,  5 Dec 2025 12:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="cscyLY/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AF1841BC; Fri,  5 Dec 2025 12:10:52 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFB084033
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 12:10:46 +0100 (CET)
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
 bh=CrAQdHT1Yi6F3gB9Ct1DavTCNhCa4hxT3kDLR37ryMM=; b=cscyLY/XkdPAf+SgixgxFoYIkj
 kQAwoush4LAVyX46pajOiip19oG5DPgDDQoPHeOShTAjXVGIXUHEWVQXSbntZ4l31JKDCSmbEreNA
 1N/MziyjpJST16AeJPbIfYz9MNikO8mAKjF6Lf0vXXL+JoQbdTyPDBX/IDqgCChi5m5XRkH71FpqU
 PEyaVUESap9GXEPCm3pU0dmrCI5GnDg34SbiLopZH8/Ne9MIVtokPyC5EDFPvU95rIfh5xi438JyX
 u7AbpZ44Vm1n5tlNjIm8TIpQyhOxX6GWnFZ6W4e5/RLD18fE1DYTmAo9TZNuyuVegZwJSdaaPCyuB
 8z1Dhl3g==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:53200
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1vRTi5-000000046RH-2qWY; Fri, 05 Dec 2025 12:10:45 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH v2 2/3] board: phytec: phycore-imx93: Set boot_targets
 dynamically
Date: Fri,  5 Dec 2025 12:10:43 +0100
Message-Id: <20251205111044.3195322-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205111044.3195322-1-primoz.fiser@norik.com>
References: <20251205111044.3195322-1-primoz.fiser@norik.com>
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

Set boot_targets environment variable dynamically, so that when booting
from SD-card, boot binaries are also preferably fetched from the SD-card
by default. If the user decides to set their own boot_targets, we should
not overwrite them.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:                                                                  
- no changes                                   
                                                                                   
Link to v1: https://lore.kernel.org/all/20251204080744.3868067-2-primoz.fiser@norik.com/

 board/phytec/phycore_imx93/phycore-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index c6a4e923b074..cfc6d91f20f2 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -38,6 +38,8 @@ int board_late_init(void)
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
+		if (!env_get("boot_targets"))
+			env_set("boot_targets", "mmc1 mmc0 ethernet");
 		break;
 	case MMC1_BOOT:
 		env_set_ulong("mmcdev", 0);
-- 
2.34.1

