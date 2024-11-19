Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F500D60D03
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D339894B5;
	Tue, 19 Nov 2024 01:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rG3Xqs/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B48894B5; Tue, 19 Nov 2024 01:36:43 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685DE89417
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0acUQ001238;
 Mon, 18 Nov 2024 18:36:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731976599;
 bh=YFKm2mTRH5bxNEqA1PjVpKqjNp7I/2qo47PKoTkpbOo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rG3Xqs/on6BghyyvLHuc/0ReBDJmuP8RWZFBaW+2lt+umHrjSiqh3g4c45+9yT2ux
 GxP3gVpvekzsLFDrr507nx6iaQ57A06UkVFHMYuj9Pjjofo/1pHX+QSlTsp9cJsyrd
 My4ueQwlimFxkFIcP8dMe74q3kicJxyLo+gyxYi0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0acSm021954
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 18:36:38 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 18:36:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 18:36:38 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0aPMX114132;
 Mon, 18 Nov 2024 18:36:36 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v4 4/5] arm: mach-k3: j721e-init.c: Add support for
 CONFIG_K3_OPP_LOW
Date: Tue, 19 Nov 2024 06:02:58 +0530
Message-ID: <20241119003617.1871183-5-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119003617.1871183-1-a-limaye@ti.com>
References: <20241119003617.1871183-1-a-limaye@ti.com>
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

The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
for A72/MSMC clks and the OPP_NOM voltage.

J7200 SOCs may support OPP_LOW Operating Performance Point:
1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.

Hence, add a config check in board_init_f() to select OPP_LOW specs:
- Check if OPP_LOW AVS voltage read from efuse is valid.
- Use the device IDs and clock IDs (TISCI docs [0]) to find the A72 and
  MSMC clock frequencies in the devicetree.
- Fixup the clock frequencies in devicetree as per OPP_LOW spec.

k3_avs driver programs the OPP_LOW AVS voltage for VDD_CPU through
k3_avs_notify_freq() callback from clk_k3.

[0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---

v4:
- Fixup patch styling problems
- In previous versions, fdt_fixup_a72ss_clock_frequency() assumed a
  fixed order of assigned-clock-rates in the DT to update clk freqs.
  This may not always be a valid assumption. So, add a new function
  get_clock_index_by_dev_id() to search the indices for A72 CPU and MSMC
  clk IDs and then use that index to update the clock rates in place.
- Link to v3: https://lore.kernel.org/u-boot/20241116071615.839623-5-a-limaye@ti.com/

v3:
- Use more descriptive name for fdt_fixup_a72ss_clock_frequency()
  and make function static.
- Add error codes to prints.
- Move error prints (with error codes) before else conditions. Helps
  with code readability to map error print with the function.
- Remove k3_avs_set_opp() from here altogether. Reasoning being that the
  value being set through k3_avs_set_opp() will anyway be (correctly)
  overridden by the k3_avs_notify_freq() call later in the boot process,
  when a72 freq is actually set from clk_k3.
- Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-5-a-limaye@ti.com/

v2:
- Fix indentation in fix_freq()
- Remove the efuse data check addition from this commit, as it's not
  related to adding support for CONFIG_K3_OPP_LOW. The same addition
  was moved to the previous patch in this series.
- Link to v1: https://lore.kernel.org/u-boot/20241017062911.2241167-5-a-limaye@ti.com/
---
 arch/arm/mach-k3/j721e/j721e_init.c | 92 ++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index e9ed8cb267c..805b28af8e4 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -19,6 +19,7 @@
 #include <fdtdec.h>
 #include <mmc.h>
 #include <remoteproc.h>
+#include <k3-avs.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -39,6 +40,12 @@
 #define NB_THREADMAP_BIT0				BIT(0)
 #define NB_THREADMAP_BIT1				BIT(1)
 
+/* TISCI DEV ID for A72, MSMC Clock */
+#define DEV_A72SS0_CORE0_0_ID 202
+#define DEV_A72SS0_CORE0_0_ARM_CLK_CLK_ID 2
+#define DEV_A72SS0_CORE0_ID 4
+#define DEV_A72SS0_CORE0_MSMC_CLK_ID 1
+
 #ifdef CONFIG_K3_LOAD_SYSFW
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 #if defined(CONFIG_TARGET_J721E_R5_EVM)
@@ -147,6 +154,78 @@ static void setup_navss_nb(void)
 	writel(NB_THREADMAP_BIT1, (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
 }
 
+#if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
+static int get_clock_index_by_dev_id(ofnode node, u32 dev_id, u32 clk_id)
+{
+	ofnode clknode;
+	int count, i;
+	struct ofnode_phandle_args phandle_args;
+
+	clknode = ofnode_by_compatible(ofnode_null(), "ti,k2g-sci-clk");
+	if (!ofnode_valid(clknode)) {
+		printf("%s: clock-controller not found\n", __func__);
+		return -ENODEV;
+	}
+
+	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
+	for (i = 0; i < count; i++) {
+		if (ofnode_parse_phandle_with_args(node, "assigned-clocks",
+						   "#clock-cells", 0, i, &phandle_args)) {
+			printf("%s: Could not parse assigned-clocks at index %d\n", __func__, i);
+			continue;
+		}
+		if (ofnode_equal(clknode, phandle_args.node) &&
+		    phandle_args.args[0] == dev_id && phandle_args.args[1] == clk_id)
+			return i;
+	}
+	return -1;
+}
+
+static int fdt_fixup_a72ss_clock_frequency(void)
+{
+	int index, size;
+	u32 *rates;
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "ti,am654-rproc");
+	if (!ofnode_valid(node)) {
+		printf("%s: A72 not found\n", __func__);
+		return -ENODEV;
+	}
+
+	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
+			      "assigned-clock-rates", &size);
+	if (!rates) {
+		printf("%s: Wrong A72 assigned-clocks-rates configuration\n", __func__);
+		return -1;
+	}
+
+	/* Update A72 Clock Frequency to OPP_LOW spec */
+	index = get_clock_index_by_dev_id(node,
+					  DEV_A72SS0_CORE0_0_ID,
+					  DEV_A72SS0_CORE0_0_ARM_CLK_CLK_ID);
+	if (index < 0 || index >= (size / sizeof(u32))) {
+		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
+		return -1;
+	}
+	rates[index] = cpu_to_fdt32(1000000000);
+	printf("Changed A72 CPU frequency to %dHz in DT\n", 1000000000);
+
+	/* Update MSMC Clock Frequency to OPP_LOW spec */
+	index = get_clock_index_by_dev_id(node,
+					  DEV_A72SS0_CORE0_ID,
+					  DEV_A72SS0_CORE0_MSMC_CLK_ID);
+	if (index < 0 || index >= (size / sizeof(u32))) {
+		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
+		return -1;
+	}
+	rates[index] = cpu_to_fdt32(500000000);
+	printf("Changed MSMC frequency to %dHz in DT\n", 500000000);
+
+	return 0;
+}
+#endif
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -301,8 +380,19 @@ void board_init_f(ulong dummy)
 #if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
 	ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
 					  &dev);
-	if (ret)
+	if (ret) {
 		printf("AVS init failed: %d\n", ret);
+	} else if (IS_ENABLED(CONFIG_K3_OPP_LOW)) {
+		ret = k3_avs_check_opp(dev, J721E_VDD_MPU, AM6_OPP_LOW);
+		if (ret) {
+			printf("OPP_LOW: k3_avs_check_opp failed: %d\n", ret);
+		} else {
+			ret = fdt_fixup_a72ss_clock_frequency();
+			if (ret)
+				printf("OPP_LOW: fdt_fixup_a72ss_clock_frequency failed: %d\n",
+				       ret);
+		}
+	}
 #endif
 
 #if defined(CONFIG_K3_J721E_DDRSS)
-- 
2.47.0

