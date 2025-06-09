Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512E8C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FFA82BAF;
	Mon,  9 Jun 2025 10:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TPFwHToE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF9382B18; Mon,  9 Jun 2025 10:15:02 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF2A82CA0
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598Ev4v738022;
 Mon, 9 Jun 2025 03:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456897;
 bh=mdOxWj/PvdJP218Y4toiLXlk/pM6Pz0LFPbEJlvhbU8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TPFwHToEwu6wzva/Pno6qFpk1/NowNa9BD7FeKA4diwsJwVcrGWB2pisR0nWeq+96
 4OmuhJ7g07+LDy2V9Ql07NR5gsXjl6LzbJTs2i17kN0V6xYdBWK21+OMK2saAAXkCD
 RVYPCicrh82HcapNpyChtSiY/+vAZkLbf4IoUwgo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598Evnl3662910
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:57 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:56 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EYqt1101163;
 Mon, 9 Jun 2025 03:14:53 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2 6/6] arm: mach-k3: Print version of DM firmware during boot
 process
Date: Mon, 9 Jun 2025 13:44:34 +0530
Message-ID: <20250609081434.1000377-7-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609081434.1000377-1-m-shah@ti.com>
References: <20250609081434.1000377-1-m-shah@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Print DM firmware's version in the boot up process of K3 devices,
having DM capability(DM as a separate binary).

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ++++
 arch/arm/mach-k3/am62px/am62p5_init.c | 4 ++++
 arch/arm/mach-k3/j721e/j721e_init.c   | 4 ++++
 arch/arm/mach-k3/j721s2/j721s2_init.c | 4 ++++
 arch/arm/mach-k3/j722s/j722s_init.c   | 4 ++++
 arch/arm/mach-k3/j784s4/j784s4_init.c | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index edd43a1d78d..ac4d30052f3 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -172,6 +172,10 @@ void board_init_f(ulong dummy)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	/* Output DM Firmware version info */
+	if (IS_ENABLED(CONFIG_ARM64))
+		k3_dm_print_ver();
+
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
 		/* Probe/configure ESM0 */
 		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 6e3c66e5107..44a2d445d24 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -224,6 +224,10 @@ void board_init_f(ulong dummy)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	/* Output DM Firmware version info */
+	if (IS_ENABLED(CONFIG_ARM64))
+		k3_dm_print_ver();
+
 	if (IS_ENABLED(CONFIG_K3_AM62A_DDRSS)) {
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f31c20f7ed6..498243485f5 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -374,6 +374,10 @@ void board_init_f(ulong dummy)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	/* Output DM Firmware version info */
+	if (IS_ENABLED(CONFIG_ARM64))
+		k3_dm_print_ver();
+
 	/* Perform board detection */
 	do_board_detect();
 
diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 5941fa26a95..528590f0434 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -232,6 +232,10 @@ void k3_spl_init(void)
 
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
+
+	/* Output DM Firmware version info */
+	if (IS_ENABLED(CONFIG_ARM64))
+		k3_dm_print_ver();
 }
 
 bool check_rom_loaded_sysfw(void)
diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index af211377e7c..d8123f282ee 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -150,6 +150,10 @@ static void k3_spl_init(void)
 
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
+
+	/* Output DM Firmware version info */
+	if (IS_ENABLED(CONFIG_ARM64))
+		k3_dm_print_ver();
 }
 
 static void k3_mem_init(void)
diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 787cf6261e4..ccf29810849 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -208,6 +208,10 @@ void k3_spl_init(void)
 
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
+
+	/* Output DM Firmware version info */
+	if (IS_ENABLED(CONFIG_ARM64))
+		k3_dm_print_ver();
 }
 
 void k3_mem_init(void)
-- 
2.34.1

