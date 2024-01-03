Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E7FC47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ED3879CB;
	Wed,  3 Jan 2024 01:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A466879AF; Wed,  3 Jan 2024 01:13:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D448C879BE
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D371516;
 Tue,  2 Jan 2024 16:14:24 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89BF53F5A1;
 Tue,  2 Jan 2024 16:13:37 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 08/19] sunxi: remove unneeded i2c_init_board() call for U-Boot
 proper
Date: Wed,  3 Jan 2024 00:12:28 +0000
Message-Id: <20240103001239.17482-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

The driver used for the Allwinner I2C IP is using proper DT and DM
enablement for a while: we enable the clock gate and de-assert the reset
line in the driver's probe() routine, and the pinmux setup is taken care
of by the DM framework.

This means the explicit call to the i2c_init_board() routine is not
needed for U-Boot proper. As the board_init() function in board.c is
only called for U-Boot proper, we can remove the call, something that
the comment there hinted at already.

Fix the comment for the board_init() function on the way: we were not
really doing board specific setup there. The fact that this function
is called from U-Boot proper only is probably more helpful for reasoning
about this code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 board/sunxi/board.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 8c12c8deade..1313b01dcea 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -186,7 +186,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	return ENVL_UNKNOWN;
 }
 
-/* add board specific code here */
+/* called only from U-Boot proper */
 int board_init(void)
 {
 	__maybe_unused int id_pfr1, ret;
@@ -226,13 +226,6 @@ int board_init(void)
 	if (ret)
 		return ret;
 
-#if CONFIG_IS_ENABLED(DM_I2C)
-	/*
-	 * Temporary workaround for enabling I2C clocks until proper sunxi DM
-	 * clk, reset and pinctrl drivers land.
-	 */
-	i2c_init_board();
-#endif
 	eth_init_board();
 
 	return 0;
-- 
2.35.8

