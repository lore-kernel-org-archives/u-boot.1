Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D49606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QBcB/96F;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=t3GPGyS8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A671E811BC;
	Wed, 18 Nov 2026 13:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R94haL1UZfVQ; Wed, 18 Nov 2026 13:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 241FC8129F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007956;
	b=WHKCAbWzs7GKZkpCUef3uen8Nes8NCKAbPG93fWn69wYeYyRA+JSfCg+Z4ZURP0Xxgkc
	 HWRP9yk3EJUg393vbAXWip8GYj/yv+hGk4BTxQByVLQ21hdif3c6aQghtz9dR+hq7PUzR
	 m10WBdN/4tROM+Dn5dfF1eHopVkQ309nanbd3J10MBXrmuig/wJ0s+wmidIHF7hV7xR+2
	 rmK0waXEpOj5IXCljyWlFpN909kAS4k4dUKcjHukTBkj6HCy5CWKWaWIaXH3bIPRB48hZ
	 olBeZVVtEo+xQSpwiFgwtcF80tzZOGypEHGI7cPV7BRE2jfzKEsm9ShHeetBOUad9qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=atsib/tlq4lzD0H56Q4Y/5esKyB/X8YXqO8pFyzSZ3c=;
	b=LTDwKFp3AUfI6QgMHn0acQ8SgllQ6kbIuXWHPL4uu2dzN072d+PVbK7pAljhvOG8UyAt
	 IAKD+mLOiqe3Q13PdudrCnIK4E2sU3g7CtMNVU4f3fuzmk0rGFGfpjs38sJtWt8tiWV6f
	 ol8+2hOKar8hzVM9+piKfXtOnmIRl9UfEYxyegPiIA12fFdhfE4WjVDvdJ5rb8fBNYCmJ
	 EY5+PW2iLoQVNugqZ3bku+XaCs789jgDo9vdtcAkmFEWEXVWT1M3AQ5ZPMmhttEdDSAVl
	 /dn3I+8VvZPNm7DwPOVLp3XziCFICfCkRd/8DTseWrfGvyg/cRlblPymTIVnXFLqA7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007956;
	bh=atsib/tlq4lzD0H56Q4Y/5esKyB/X8YXqO8pFyzSZ3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QBcB/96FzdaDtMHMhHG6oiW0154PTgmpTJLFft+k9gZm2QqSNCIriJUReIgLniuty
	 LfiPmHOQzr7TK9CpyYiuFTpASJsXfrJ6SQwZo/fmYp6+ysUHSZBw9xKQcKl5ML2PCJ
	 mq7shh7TT69Vnt8YIN5mSD1Gjk6nisb9e1kSlNg7TVP5egn497IWTgoW7DALoMc/tF
	 MdywaiGHtvvOvvxEVFdArZZKmVft/J36Gcd3VBzFT4eNLpcuTbziz4P61GNK9FFNMb
	 GBWXNGBYYNa7yWWy1Ip4gWbB9tRQMlEQYMuJ+phOMx2gIoZ3/7SHHDj2rxjyhJxGtb
	 b13n7VPBRz7uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 241FC8129F;
	Wed, 18 Nov 2026 13:19:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 721F4A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53CD040A0D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5opoFZPkl0HN for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25F9D40A3B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=t3GPGyS8
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25F9D40A3B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id ADF15C4F77E;
 Wed, 18 Nov 2026 13:19:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D86205FE9B;
 Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 80D5111BC1FBF; Wed, 18 Nov 2026 14:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007948; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=atsib/tlq4lzD0H56Q4Y/5esKyB/X8YXqO8pFyzSZ3c=;
 b=t3GPGyS8kpSTjedalCAhpvqSlcq7ou1mMHnFaVln5NWYzhtZ2HawdvXqDMmh9iab3iUxCH
 /T4kJVyhA0VFYGPYlU3BkYTtE1CFDg8/+HK+Y4AX+0K9B9Zp/MlT5BUdAfi/Yvyqs41Omk
 bA3Q3IX3ijvbIcWydC20mVxfL+Jwcu59NRPhr6MvLO+6qqtZptfn4ZN75Ymc2b3wQdZeim
 TEAQ5QfwCWd3PPvXu+qzSmcx/rVQkNe027AzedbWXJINM+e4W3TGqQ9q8MRFyjNii555A3
 GAPN+dGuuStlhOze9X7iDOoVnFumfxk+0JyD3Owlfbb/TPk/WnY31PJAOioLZg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 16/20] arm: mach-k3: j721s2: Enable LPM resume flow
Date: Wed, 18 Nov 2026 14:18:03 +0100
Message-ID: <20261118131807.135859-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

First, set LPM core bus path and compatible needed by extract_lpm_region
to find lpm-metadata memory region (at boot and at resume time)

Then, add the board specific part of the exit retention sequence for
k3-ddrss:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power
After that, the generic resume path is run.

Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 57 +++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 780d853423f8..d301525d2455 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -16,12 +16,20 @@
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
+#include <mach/k3-ddr.h>
 #include <mmc.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 
 #include "../sysfw-loader.h"
+#include "../lpm-common.h"
 #include "../common.h"
 
+#define MAX_DDR_CONTROLLERS	2
+
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(3)
+
 /* NAVSS North Bridge (NB) */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
 #define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
@@ -262,9 +270,12 @@ bool check_rom_loaded_sysfw(void)
 void k3_mem_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
 		if (ret)
 			panic("Probe of msmc failed: %d\n", ret);
@@ -272,10 +283,48 @@ void k3_mem_init(void)
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+		devs[0] = dev;
+		ctrl++;
 
-		ret = uclass_next_device_err(&dev);
-		if (ret && ret != -ENODEV)
-			panic("DRAM 1 init failed: %d\n", ret);
+		while (ctrl < MAX_DDR_CONTROLLERS) {
+			ret = uclass_next_device_err(&dev);
+			if (ret == -ENODEV)
+				break;
+
+			if (ret)
+				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
+			ctrl++;
+		}
+
+		k3_set_lpm_core_bus_node_path("/bus@100000/bus@28380000");
+		k3_set_lpm_core_compatible("ti,j721s2-r5f");
+
+		if (j7xx_board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, 0, false);
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+
+			/*
+			 * The DM (PDK) doesn't support being started with
+			 * caches enabled, and there no gain enabling them here
+			 * and disabling them just before jumping to DM
+			 */
+			do_resume();
+		}
 	}
 	spl_enable_cache();
 }
