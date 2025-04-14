Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF1CC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A4B8267E;
	Mon, 14 Apr 2025 22:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZTgIAjBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC268272A; Mon, 14 Apr 2025 22:20:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF77B82153
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EKK3RR2790092
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 15:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744662004;
 bh=f+o2qmFXmokFYU8vLK0oZZPpC3shhd72nMCd4Qzpz8Y=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=ZTgIAjBxG+sBAz7UEsUkrYFMj89Av9OHoHzyB1g+y/9wM9hM980QmOpGXnRl3ay8/
 PReadSAlRrntqR1m3CEWGE5QTtgBgZciVsDRMHMorTA66/l8l0m+AseZHHIH5AZpR1
 dG1BzBpacwHDdxWnnSAnKot+sRZRW24blBaM74+I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EKK45Q111171
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 15:20:04 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 15:20:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 15:20:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EKK3k5025027;
 Mon, 14 Apr 2025 15:20:03 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 14 Apr 2025 15:20:03 -0500
Subject: [PATCH 2/2] arm: mach-k3: am625: remove any firewalls ROM has
 configured for HSRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250414-firewalls-v1-2-89090085c08b@ti.com>
References: <20250414-firewalls-v1-0-89090085c08b@ti.com>
In-Reply-To: <20250414-firewalls-v1-0-89090085c08b@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

ROM will configure a firewall to only allow HSRAM to be touched by the
R5 core. Any outside entity like DMA or the A53s will not have access to
this region. This can be problematic when U-Boot, running on the A53,
loads firmware that runs out of this region.

To simplify things remove the firewall here and let the remote core
firmware place a new firewall themselves if they wish for the memory
region.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/am62x/am625_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 595fc391ac5aa..a422919fab131 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -29,6 +29,12 @@
 /* TISCI DEV ID for A53 Clock */
 #define AM62X_DEV_A53SS0_CORE_0_DEV_ID 135
 
+struct fwl_data rom_fwls[] = {
+	{ "SOC_DEVGRP_MAIN", 641, 1 },
+	{ "SOC_DEVGRP_MAIN", 642, 1 },
+	{ "SOC_DEVGRP_MAIN", 642, 2 },
+};
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -177,6 +183,7 @@ void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
 	int ret;
+	int i;
 
 	if (IS_ENABLED(CONFIG_CPU_V7R)) {
 		setup_k3_mpu_regions();
@@ -261,6 +268,11 @@ void board_init_f(ulong dummy)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	/* Disable firewalls ROM has configured. */
+	if (IS_ENABLED(CONFIG_CPU_V7R))
+		for (i = 0; i < ARRAY_SIZE(rom_fwls); i++)
+			remove_fwl_region(&rom_fwls[i]);
+
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
 		/* Probe/configure ESM0 */
 		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);

-- 
2.48.1

