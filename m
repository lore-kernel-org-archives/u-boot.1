Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330F5E77198
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 04:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5592B8066C;
	Wed,  8 Jan 2025 05:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o24HQtB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB4D8066C; Wed,  8 Jan 2025 05:50:10 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B86680601
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 05:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5084o4gN2674275
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 22:50:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736311804;
 bh=3MbjjGdm3iYp7eT+s9+FyQZs5B7NhcfyQCxLHUDzyzQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=o24HQtB6vmq9AZiYnFh0TGRCGOt0av96q4yQKx0d4BkeqbfOvpya36cmvI8nt44ia
 4bsDCAS0Z6lbp4yf7dBZX7YbxMFH/+zsK5j4+Pgg3D15cN2rzoGuxPxln0OJR7gV8W
 pr3SWE6cClHRvgiAYBgfplhnHnGTQFMJOwe95TL4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5084o4BI126841
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 22:50:04 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 22:50:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 22:50:04 -0600
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5084ngo2130961;
 Tue, 7 Jan 2025 22:50:02 -0600
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 Aparna Patra <a-patra@ti.com>
Subject: [PATCH v2 4/4] arm: mach-k3: am62p: Set a53 cpu freq based on
 speed-grade
Date: Wed, 8 Jan 2025 10:19:39 +0530
Message-ID: <20250108044939.392785-5-a-patra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108044939.392785-1-a-patra@ti.com>
References: <20250108044939.392785-1-a-patra@ti.com>
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

The maximum frequency of the A53 CPU on the AM62P depends on the speed
grade of the SoC. This value is hardcoded in the DT for all AM62P
variants, potentially causing specifications to be exceeded. Moreover,
setting a common lower frequency for all variants increases boot time.
To prevent these issues, modify the DT at runtime from the R5 core to
adjust the A53 CPU frequency.

Signed-off-by: Aparna Patra <a-patra@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 34ed01cd78..74631a4ce9 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -11,10 +11,14 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <dm/ofnode.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
 
+/* TISCI DEV ID for A53 Clock */
+#define AM62PX_DEV_A53SS0_CORE_0_DEV_ID 135
+
 struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
 };
@@ -67,6 +71,62 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+static int get_a53_cpu_clock_index(ofnode node)
+{
+	int count, i;
+	struct ofnode_phandle_args *args;
+	ofnode clknode;
+
+	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
+	if (!ofnode_valid(clknode))
+		return -1;
+
+	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
+
+	for (i  = 0; i < count; i++) {
+		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
+						    "#clock-cells", 0, i, args)) {
+			if (ofnode_equal(clknode, args->node) &&
+			    args->args[0] == AM62PX_DEV_A53SS0_CORE_0_DEV_ID)
+				return i;
+		}
+	}
+
+	return -1;
+}
+
+static void fixup_a53_cpu_freq_by_speed_grade(void)
+{
+	int index, size;
+	u32 *rates;
+	ofnode node;
+
+	node =  ofnode_path("/a53@0");
+	if (!ofnode_valid(node))
+		return;
+
+	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
+			      "assigned-clock-rates", &size);
+
+	index = get_a53_cpu_clock_index(node);
+
+	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
+		printf("Wrong A53 assigned-clocks configuration\n");
+		return;
+	}
+
+	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
+
+	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
+	       k3_get_a53_max_frequency(), k3_get_speed_grade());
+}
+#else
+static void fixup_a53_cpu_freq_by_speed_grade(void)
+{
+}
+#endif
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -160,6 +220,8 @@ void board_init_f(ulong dummy)
 
 	spl_enable_cache();
 	debug("am62px_init: %s done\n", __func__);
+
+	fixup_a53_cpu_freq_by_speed_grade();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
-- 
2.34.1

