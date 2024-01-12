Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72E8C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106C7879EE;
	Fri, 12 Jan 2024 13:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T/wRd2Sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B8FC8785F; Fri, 12 Jan 2024 13:50:06 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3ED876C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E4C3761CE1;
 Fri, 12 Jan 2024 12:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F86C433F1;
 Fri, 12 Jan 2024 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705063801;
 bh=JgMMuH0YggTjvVGdHlXRApn55LjFMy5d3W72K5DChrE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T/wRd2Spg6tZ+HL/nbsb2FJH8ywiZRjJ77Yg+RnGBUwPcAhhaxPZnps/5XiVNSaeN
 wXQNsijcQG4lk3owY6h4Alvx+rRz1ZS1mmUa6buJmUniQ2hQGOy9VZasLJt1ITrbnm
 g+Jlef0Wogvjv5SafGf0kUtcrGI6ufDskYiLImjlgNOWAK/zHlLjqYfjYIwPmU7jBf
 wsw2eJuFJ9lNStLwWNGl5XE2pKVC3TXQzJvXGjnDAg3JDpTaprQSofx34FlckEAzdG
 NWxAQgi74070XWix/K5ABf6w6hemZPJKQb/2T+7Tamg/bV6CMhHVXx4TOSvc3m4i/7
 0ikBB3l+5GhGQ==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	robertcnelson@gmail.com,
	trini@konsulko.com,
	marex@denx.de
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/5] board: ti: j721e: Drop SERDES PHY init from board file
Date: Fri, 12 Jan 2024 14:49:47 +0200
Message-Id: <20240112124951.238098-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124951.238098-1-rogerq@kernel.org>
References: <20240112124951.238098-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since commit 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1"),
the following error message is seen at u-boot
	"Sierra init failed:-19"

Probing and initializing the SERDES PHY from
board file is not a clean solution so drop it.

Proper use case should be via PHY_UCLASS APIs.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 board/ti/j721e/evm.c | 77 --------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index c541880107..b77cffc5ef 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -352,77 +352,6 @@ static int probe_daughtercards(void)
 }
 #endif
 
-void configure_serdes_torrent(void)
-{
-	struct udevice *dev;
-	struct phy serdes;
-	int ret;
-
-	if (!IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
-		return;
-
-	ret = uclass_get_device_by_driver(UCLASS_PHY,
-					  DM_DRIVER_GET(torrent_phy_provider),
-					  &dev);
-	if (ret) {
-		printf("Torrent init failed:%d\n", ret);
-		return;
-	}
-
-	serdes.dev = dev;
-	serdes.id = 0;
-
-	ret = generic_phy_init(&serdes);
-	if (ret) {
-		printf("phy_init failed!!: %d\n", ret);
-		return;
-	}
-
-	ret = generic_phy_power_on(&serdes);
-	if (ret) {
-		printf("phy_power_on failed!!: %d\n", ret);
-		return;
-	}
-}
-
-void configure_serdes_sierra(void)
-{
-	struct udevice *dev, *link_dev;
-	struct phy link;
-	int ret, count, i;
-	int link_count = 0;
-
-	if (!IS_ENABLED(CONFIG_PHY_CADENCE_SIERRA))
-		return;
-
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(sierra_phy_provider),
-					  &dev);
-	if (ret) {
-		printf("Sierra init failed:%d\n", ret);
-		return;
-	}
-
-	count = device_get_child_count(dev);
-	for (i = 0; i < count; i++) {
-		ret = device_get_child(dev, i, &link_dev);
-		if (ret) {
-			printf("probe of sierra child node %d failed: %d\n", i, ret);
-			return;
-		}
-		if (link_dev->driver->id == UCLASS_PHY) {
-			link.dev = link_dev;
-			link.id = link_count++;
-
-			ret = generic_phy_power_on(&link);
-			if (ret) {
-				printf("phy_power_on failed!!: %d\n", ret);
-				return;
-			}
-		}
-	}
-}
-
 #ifdef CONFIG_BOARD_LATE_INIT
 static void setup_board_eeprom_env(void)
 {
@@ -476,12 +405,6 @@ int board_late_init(void)
 			probe_daughtercards();
 	}
 
-	if (board_is_j7200_som())
-		configure_serdes_torrent();
-
-	if (board_is_j721e_som())
-		configure_serdes_sierra();
-
 	return 0;
 }
 #endif
-- 
2.34.1

