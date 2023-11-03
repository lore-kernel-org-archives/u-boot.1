Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E7BC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B8087761;
	Fri,  3 Nov 2023 01:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b08zBtR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A8987736; Fri,  3 Nov 2023 01:38:32 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0074F87645
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8Gn003491;
 Thu, 2 Nov 2023 19:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971888;
 bh=X6ljQwvk8eijFFBmcfBXk6QwNjIUHzjgAOeV963ZBzA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=b08zBtR2ck5LvpZ9LEe3PbTEDZ2niDSlbCbUJxglvi2ipxoDQmsQ7BGa7Z8dsfW+S
 V/DY+Y/u9WQrC6U3BR8uBso0ueLzoeOoU9U06PnnHiFK2RK6cll57IssSKXkwKqAhg
 +eKY0edyHQq3JrVI/mJwi0yiHGHQfFWcV8J7WWyQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30c8Z1017621
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:08 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8NH043186;
 Thu, 2 Nov 2023 19:38:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 06/15] board: ti: j721e: evm: Drop board based serdes
 initialization
Date: Thu, 2 Nov 2023 19:37:56 -0500
Message-ID: <20231103003805.2420005-7-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Serdes initialization should be compile flag based instead of being
eeprom based.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/j721e/evm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 17640ae79665..d49993fffe39 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -359,9 +359,6 @@ void configure_serdes_torrent(void)
 	struct phy serdes;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
-		return;
-
 	ret = uclass_get_device_by_driver(UCLASS_PHY,
 					  DM_DRIVER_GET(torrent_phy_provider),
 					  &dev);
@@ -393,9 +390,6 @@ void configure_serdes_sierra(void)
 	int ret, count, i;
 	int link_count = 0;
 
-	if (!IS_ENABLED(CONFIG_PHY_CADENCE_SIERRA))
-		return;
-
 	ret = uclass_get_device_by_driver(UCLASS_MISC,
 					  DM_DRIVER_GET(sierra_phy_provider),
 					  &dev);
@@ -477,10 +471,10 @@ int board_late_init(void)
 			probe_daughtercards();
 	}
 
-	if (board_is_j7200_som())
+	if (IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
 		configure_serdes_torrent();
 
-	if (board_is_j721e_som())
+	if (IS_ENABLED(CONFIG_PHY_CADENCE_SIERRA))
 		configure_serdes_sierra();
 
 	return 0;
-- 
2.40.0

