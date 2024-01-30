Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6921C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB9587DD6;
	Tue, 30 Jan 2024 14:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p8ropmrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634BF87BEE; Tue, 30 Jan 2024 14:06:38 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D4287D9E
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6L60107518;
 Tue, 30 Jan 2024 07:06:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706619981;
 bh=es45azYb/JJETAYoaG2G4k2p9o0NCBEUj9b9hLSt/vk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=p8ropmrW3ZTUhqohhPc8BcfNZ2cQFZAIioJ3b9CWenTavPcZDq5s4juBwH/rHwuRb
 e9WkAW/4gTarbnDX8bigAl5Lvm6j3NMjdjuZBpELCD3+CyZnLssooTudhNatF4ipaW
 K9cU2A6RO/6hDWhRl5YEiA5yxqtSHEgZ9vGpG6T0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UD6Lud026353
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 07:06:21 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 07:06:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 07:06:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6LHB098251;
 Tue, 30 Jan 2024 07:06:21 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 03/11] board: ti: am62ax: Set fdtfile from C code instead
 of findfdt script
Date: Tue, 30 Jan 2024 07:06:07 -0600
Message-ID: <20240130130615.670783-4-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130130615.670783-1-nm@ti.com>
References: <20240130130615.670783-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

Stop using the findfdt script and switch to setting the fdtfile from
C code.

While at this, replace findfdt in environment with a warning as it is
no longer needed

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V3:
- none other than picking up reviews.

V2: https://lore.kernel.org/r/20240109191506.3820908-3-nm@ti.com

 board/ti/am62ax/am62ax.env       |  1 -
 board/ti/am62ax/evm.c            | 10 ++++++++++
 configs/am62ax_evm_a53_defconfig |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
index a6d967e982d4..334374abb73e 100644
--- a/board/ti/am62ax/am62ax.env
+++ b/board/ti/am62ax/am62ax.env
@@ -1,5 +1,4 @@
 #include <env/ti/ti_common.env>
-#include <env/ti/default_findfdt.env>
 #include <env/ti/mmc.env>
 
 name_kern=Image
diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index cd3360a43029..62d3664936e7 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -13,6 +13,8 @@
 #include <fdt_support.h>
 #include <spl.h>
 
+#include "../common/fdt_ops.h"
+
 int board_init(void)
 {
 	return 0;
@@ -27,3 +29,11 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+	ti_set_fdt_env(NULL, NULL);
+	return 0;
+}
+#endif
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 38083586a3ec..e5fcd8cc5b6f 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-- 
2.43.0

