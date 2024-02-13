Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D968C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 16:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B04587D64;
	Tue, 13 Feb 2024 17:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EdaIYwVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335A087D58; Tue, 13 Feb 2024 17:00:16 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1746F87D84
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 17:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 34BB0212AD;
 Tue, 13 Feb 2024 17:00:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1707840008;
 bh=3gba2mGCZpb5FJhljPdb6r/Gb5+eUjfQ69bIROpoepM=; h=From:To:Subject;
 b=EdaIYwVKyR6VbBx+OpFrH6700QfdZi9n/W4KTs8Yuvdt2odzmuMRWb/Vr06xIETys
 bsqd0GyMjAA+2OB1T/Yt+hGUdoZSVMKYwhzYJMn0rnLlIJwEeFhleLBjDBqLtM0F+2
 SDrnSJdte+mbMcHayto9H8YbgTYIabStIMNv/o7vyb/6fHJfhx+sE5mSGt0bmdPikN
 1CgMziwbJ+6uQcWKbHuKlNFV/2UvMnjBAsK0QiuNZyDMc2vMYnaIvBT9KcMg7VrjwC
 ZuEkzrhNKghmIC8rfjRHwyYFPZtCh+5ij6YMG0AVYmLqjw3PdfJ4BZk7amqgDx7XoQ
 Zu2PJ+zf2Evrg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] Revert "board: verdin-am62: set cpu core voltage depending
 on speed grade"
Date: Tue, 13 Feb 2024 17:00:03 +0100
Message-Id: <20240213160003.18725-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This reverts commit d2099587d661c6ca2309256c0e04c06e26c8d34c.

According to TI changing the VDD_CORE while the SoC is running is not
allowed, the voltage must be set before the AM62 device reset is
released, revert this change therefore.

The correct solution would be to program the PMIC during manufactoring
according to the speed grade of the SoC.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1318338/am623-booting-from-mmc-failed-after-lowering-vdd_core-to-0-75v/5036508#5036508
Fixes: d2099587d661 ("board: verdin-am62: set cpu core voltage depending on speed grade")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/verdin-am62/verdin-am62.c | 47 -------------------------
 1 file changed, 47 deletions(-)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 395eb365a0bf..e948fc16ba99 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -14,13 +14,10 @@
 #include <fdt_support.h>
 #include <init.h>
 #include <k3-ddrss.h>
-#include <power/regulator.h>
 #include <spl.h>
 
 #include "../common/tdx-cfg-block.h"
 
-#define VDD_CORE_REG "buck1"
-
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -53,37 +50,9 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-static u32 get_vdd_core_nominal(void)
-{
-	int core_uvolt;
-
-	switch (k3_get_speed_grade()) {
-	case 'G':
-	case 'K':
-	case 'S':
-		core_uvolt = 750000;
-		break;
-	case 'T':
-	default:
-		core_uvolt = 850000;
-		break;
-	}
-	return core_uvolt;
-}
-
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-	int core_uvolt;
-
-	core_uvolt = get_vdd_core_nominal();
-	if (core_uvolt != 850000) {
-		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
-				     "regulator-max-microvolt", core_uvolt, 0);
-		do_fixup_by_path_u32(blob, "/bus@f0000/i2c@20000000/pmic@30/regulators/buck1",
-				     "regulator-min-microvolt", core_uvolt, 0);
-	}
-
 	return ft_common_board_setup(blob, bd);
 }
 #endif
@@ -118,22 +87,6 @@ static void select_dt_from_module_version(void)
 
 int board_late_init(void)
 {
-	int ret;
-	int core_uvolt;
-	struct udevice *dev = NULL;
-
-	core_uvolt = get_vdd_core_nominal();
-	if (core_uvolt != 850000) {
-		/* Set CPU core voltage to 0.75V for slower speed grades */
-		ret = regulator_get_by_devname(VDD_CORE_REG, &dev);
-		if (ret)
-			pr_err("VDD CORE Regulator get error: %d\n", ret);
-
-		ret = regulator_set_value_force(dev, core_uvolt);
-		if (ret)
-			pr_err("VDD CORE Regulator value setting error: %d\n", ret);
-	}
-
 	select_dt_from_module_version();
 
 	return 0;
-- 
2.39.2

