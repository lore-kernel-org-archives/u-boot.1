Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0BE7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 22:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686C68005B;
	Sun, 15 Dec 2024 23:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDC380083; Sun, 15 Dec 2024 23:14:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 06C8080050
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 23:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3074B11FB;
 Sun, 15 Dec 2024 14:14:47 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214833F720;
 Sun, 15 Dec 2024 14:14:18 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Chen-Yu Tsai <wens@csie.org>, Leon Anavi <leon.anavi@konsulko.com>,
 lhristov@gmail.com
Subject: [PATCH] power: pmic: sunxi: guard DCDC5 separately
Date: Sun, 15 Dec 2024 22:13:31 +0000
Message-ID: <20241215221331.28461-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
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

So far all sunxi boards programming the DCDC1 power rail on the AXP PMIC
also set the DCDC5 rail, so we could handle both with the same DCDC1
guard.
Some boards using the AXP313 will need to set DCDC1 now as well, and
since the AXP313 only has three buck converters, there will be no DCDC5,
so this trick is not going to work anymore.

Don't try to be too clever, and just protect programming the two DCDC
rails with two separate guards.

This has the interesting side effect of fixing operation on A80 boards,
using the AXP809 PMIC. Apparently programming DCDC5 right after DCDC1,
but before the other three rails caused some glitch, which made the board
hang during Linux boot, during the PSCI handler in U-Boot. Just keeping
the old setup order (DCDC1,2,3,4,5) will make those boards boot to the
Linux prompt again.

Fixes: ffb02942fab024d4a9b6a ("sunxi: board: simplify early PMIC setup conditions")
Reported-by: Leon Anavi <leon.anavi@konsulko.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 board/sunxi/board.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 824c322a0dc..9c340908a96 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -577,7 +577,6 @@ void sunxi_board_init(void)
 
 #ifdef CONFIG_AXP_DCDC1_VOLT
 	power_failed |= axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
-	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
 #endif
 #ifdef CONFIG_AXP_DCDC2_VOLT
 	power_failed |= axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
@@ -586,6 +585,9 @@ void sunxi_board_init(void)
 #ifdef CONFIG_AXP_DCDC4_VOLT
 	power_failed |= axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
 #endif
+#ifdef CONFIG_AXP_DCDC5_VOLT
+	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
+#endif
 
 #ifdef CONFIG_AXP_ALDO1_VOLT
 	power_failed |= axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
-- 
2.46.2

