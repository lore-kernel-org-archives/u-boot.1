Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0CFCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 12:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06AA83236;
	Tue, 16 Sep 2025 14:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L0kzPVAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D192F8318E; Tue, 16 Sep 2025 09:25:33 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D87E83071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=v-singh1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58G7PIUn1221708;
 Tue, 16 Sep 2025 02:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758007518;
 bh=1sANp/pM/a+F1FD53NBxQhAniMc/YG/DVTIug610+bI=;
 h=From:To:Subject:Date;
 b=L0kzPVAWqEFBbysSZMJrO1Y0WLyPorjHTPq461CaSvqTROSZZlCzJc4FswDkVpnMa
 i+yxQECIvBSoQvrC22arh/dwrHbwXYd8ga01bmPNdoE74XoaGxXYyfgaR8icbK/+sW
 MEh8cPFX9oouuqkqpg3RbQ8R7/4x4u7D5qTkIohg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58G7PIqQ348512
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 02:25:18 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 02:25:18 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Tue, 16 Sep
 2025 02:25:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 02:25:18 -0500
Received: from uda0513920.dhcp.ti.com (uda0513920.dhcp.ti.com [10.24.69.90])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58G7PGa21243665;
 Tue, 16 Sep 2025 02:25:16 -0500
From: vishnu singh <v-singh1@ti.com>
To: <trini@konsulko.com>, <mkorpershoek@kernel.org>, <j@jannau.net>,
 <u-boot@lists.denx.de>
Subject: [PATCH] bootstage: stash boot records to reserved mem before kernel
 handoff
Date: Tue, 16 Sep 2025 12:55:15 +0530
Message-ID: <20250916072515.1088313-1-v-singh1@ti.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 16 Sep 2025 14:47:22 +0200
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

From: Vishnu Singh <v-singh1@ti.com>

U-Boot now stashes its bootstage buffer into a reserved memory region
whenever CONFIG_BOOTSTAGE_STASH is enabled, just before exiting to the
kernel. This allows a post boot parser to read a unified timeline
(SPL→U-Boot→Kernel→MCU/DSP) directly from DDR, enabling standardized
and repeatable boot-time profiling across releases and SoCs.

Change summary:
 Call bootstage_stash_default() in announce_and_cleanup()
  when CONFIG_BOOTSTAGE_STASH is set.

Reference boot-time parser utility:
 https://github.com/v-singh1/boot-time-parser

Sample boot time report:
    +--------------------------------------------------------------------+
                     am62xx-evm Boot Time Report
    +--------------------------------------------------------------------+
    Device Power On         : 0 ms
    SPL Time                : 843 ms
    U-Boot Time             : 2173 ms
    Kernel handoff time     : 462 ms
    Kernel Time             : 2522 ms
    Total Boot Time         : 6000 ms
    +--------------------------------------------------------------------+

    +--------------------------------------------------------------------+
                     Bootloader and Kernel Boot Records
    +--------------------------------------------------------------------+
    BOOTSTAGE_AWAKE                =      0 ms (+  0 ms)
    BOOTSTAGE_START_UBOOT_F        =    843 ms (+  0 ms)
    BOOTSTAGE_ACCUM_DM_F           =    843 ms (+  0 ms)
    BOOTSTAGE_START_UBOOT_R        =   1951 ms (+1108 ms)
    BOOTSTAGE_ACCUM_DM_R           =   1951 ms (+  0 ms)
    BOOTSTAGE_NET_ETH_START        =   2032 ms (+ 81 ms)
    BOOTSTAGE_NET_ETH_INIT         =   2053 ms (+ 21 ms)
    BOOTSTAGE_MAIN_LOOP            =   2055 ms (+  2 ms)
    BOOTSTAGE_START_MCU            =   2661 ms (+606 ms)
    BOOTSTAGE_BOOTM_START          =   2959 ms (+298 ms)
    BOOTSTAGE_RUN_OS               =   3016 ms (+ 57 ms)
    BOOTSTAGE_BOOTM_HANDOFF        =   3016 ms (+  0 ms)
    BOOTSTAGE_KERNEL_START         =   3478 ms (+462 ms)
    BOOTSTAGE_KERNEL_END           =   6000 ms (+2522 ms)
    +--------------------------------------------------------------------+

    +--------------------------------------------------------------------+
                     MCU Boot Records
    +--------------------------------------------------------------------+
    MCU_AWAKE                      =   2661 ms (+  0 ms)
    BOARD_PERIPHERALS_INIT         =   2661 ms (+  0 ms)
    MAIN_TASK_CREATE               =   2661 ms (+  0 ms)
    FIRST_TASK                     =   2662 ms (+  1 ms)
    DRIVERS_OPEN                   =   2662 ms (+  0 ms)
    BOARD_DRIVERS_OPEN             =   2662 ms (+  0 ms)
    IPC_SYNC_FOR_LINUX             =   6636 ms (+3974 ms)
    IPC_REGISTER_CLIENT            =   6636 ms (+  0 ms)
    IPC_SUSPEND_TASK               =   6636 ms (+  0 ms)
    IPC_RECEIVE_TASK               =   6636 ms (+  0 ms)
    IPC_SYNC_ALL                   =   6787 ms (+151 ms)
    +--------------------------------------------------------------------+

Signed-off-by: Vishnu Singh <v-singh1@ti.com>
---
 arch/arm/lib/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 7eb764e1f4e..198ac2f6b52 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -57,6 +57,7 @@ static void announce_and_cleanup(int fake)
 #ifdef CONFIG_BOOTSTAGE_FDT
 	bootstage_fdt_add_report();
 #endif
+	bootstage_stash_default();
 #ifdef CONFIG_BOOTSTAGE_REPORT
 	bootstage_report();
 #endif
-- 
2.50.1

