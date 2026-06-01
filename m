Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700CFCD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AAA84912;
	Mon,  1 Jun 2026 14:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kNwgrbId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B23684878; Mon,  1 Jun 2026 10:12:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F72C84825
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4416344638;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26B99C2BCF6;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301572;
 bh=16THLFRFJgFgXSXPPmSXTmIp0o3HfjSPCy9YlLwyiSg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kNwgrbIddOTPGReGha5Bmwi5XcpNJ/8xziz6SaCfkVPcwmZCAjKr/Qdsmp7Xd7G94
 SJ35YfP6qCH+b1biDUmFTlfSoOh47OM/K2mppwgSS61s7wBH99780fsi3EtkyU5F+H
 g4rscGa8HgzASC6aMKVOK8CUk7xMWIncroX+S56Ci4y4IBEp6/9xfD5igosOTk1Sgh
 ZBNNO2G0LWihN8Rz5LQxMqwn8tRATeAFH1JHeskmjLk3aGe95ek3KtvdukAEBSPCHf
 Ht6F7iinoUionW8cNaTZbfB4m/F0MG06dDtsk3c1hG1B1rV6XsnPXGdL4ktVlXXLH/
 Z8hwGepXSsoww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1D99DCD5BD1;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:46 +1000
Subject: [PATCH RESEND 05/16] mach-snapdragon: gate ARM64 features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-5-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=3504;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=bIJ7cYF6vytERhAUWslfSVzczauhvqi7mIbsGwwGNTw=;
 b=0dQl4/Xpv+rUY+KgHDQf+5AmOhjo5+fEX6Zj2EizI1CmMY1U4P5o57BW0q5qC9E756ciTALH0
 GgDaXregaopAHM9nAHndXzaAskkoQEyEwfITFohDdtC42Xce1alcKCe
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

With some strategic (and minimal) #ifdef ARM64 gating, we can ensure
that mach-snapdragon board code compiles cleanly on arm32 toolchains.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/board.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 56e943058ed..627b566d178 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -9,10 +9,8 @@
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
 
-#include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
-#include <asm/psci.h>
 #include <asm/system.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
@@ -22,9 +20,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
-#include <linux/arm-smccc.h>
 #include <linux/bug.h>
-#include <linux/psci.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
@@ -35,13 +31,20 @@
 
 #include "qcom-priv.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
-enum qcom_boot_source qcom_boot_source __section(".data") = 0;
+#ifdef CONFIG_ARM64
+#include <asm/armv8/mmu.h>
+#include <asm/psci.h>
+#include <linux/arm-smccc.h>
+#include <linux/psci.h>
 
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 
 static struct {
 	phys_addr_t start;
@@ -174,6 +177,7 @@ static int qcom_parse_memory(const void *fdt)
 
 static void show_psci_version(void)
 {
+#ifdef CONFIG_ARM64
 	struct arm_smccc_res res;
 
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
@@ -185,6 +189,7 @@ static void show_psci_version(void)
 	debug("PSCI:  v%ld.%ld\n",
 	      PSCI_VERSION_MAJOR(res.a0),
 	      PSCI_VERSION_MINOR(res.a0));
+#endif
 }
 
 /**
@@ -196,6 +201,7 @@ static void show_psci_version(void)
  */
 static void qcom_psci_fixup(void *fdt)
 {
+#ifdef CONFIG_ARM64
 	int offset, ret;
 	struct arm_smccc_res res;
 
@@ -212,6 +218,7 @@ static void qcom_psci_fixup(void *fdt)
 	ret = fdt_del_node(fdt, offset);
 	if (ret)
 		log_err("Failed to delete /psci node: %d\n", ret);
+#endif
 }
 
 /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
@@ -234,8 +241,8 @@ int board_fdt_blob_setup(void **fdtp)
 	 * Bail out while we can still print a useful error message.
 	 */
 	if (!internal_valid && !external_valid)
-		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
-		      (phys_addr_t)external_fdt);
+		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%p)\n",
+		      external_fdt);
 
 	/* Prefer memory information from internal DT if it's present */
 	if (internal_valid)
@@ -261,7 +268,7 @@ int board_fdt_blob_setup(void **fdtp)
 		qcom_boot_source = QCOM_BOOT_SOURCE_XBL;
 
 	debug("ram_base = %#011lx, ram_size = %#011llx\n",
-	      gd->ram_base, gd->ram_size);
+	      gd->ram_base, (unsigned long long)gd->ram_size);
 
 	if (internal_valid) {
 		debug("Using built in FDT\n");
@@ -595,6 +602,7 @@ int board_late_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ARM64
 static void build_mem_map(void)
 {
 	int i, j;
@@ -768,3 +776,4 @@ void enable_caches(void)
 	}
 	dcache_enable();
 }
+#endif

-- 
2.54.0


