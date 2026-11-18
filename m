Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qINY1BcU;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mUBr6DVA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FD76812AF;
	Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYJ3OpSEh4Tn; Wed, 18 Nov 2026 13:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C84A812A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007948;
	b=WRYjKuTSFl9P15CZJUxv/w+HR3x2WkQb6UjdN6d8r70iBjdIH+m7rlFbnUHnyIl2D3AW
	 sqfRlzDLxLLEzSo3ENvscetq7BIRqKdiodNwLsJMX3TkzaTCZAc/Vmxzb5AK5fyYCREt/
	 EOg2Ji/Cayzv9tK6tV9UC4TNG82C3XVkuMJ4jcMI1zeS3FUTRp4YzAkGaKA16ZZk6j5AD
	 A49xUHyeUUSkgpt/teW0P1nPwwLXHU+r+8heN3isp3Yg/n+AGk7s7XJgNvvFjlasLCfll
	 4L5LmpPWnDRIwE9+i2OdzAkj5fR9LbVtPMUAIL6HRTAYuXVjPP6xSs823QkTApKFY7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q2BmsO/YWNdEGRiJ9LBvDfuocMDT6/JFIwjvkVUuXs0=;
	b=ls3KuKtQHMDieP5xsF/EusOKDYiVhqqiJp7fJl9pTCEs9Y0XEbIpfh+3JeMo80VmXWJW
	 aWwXdILYIelx2rLhQoHIe+7YvikM/wp7oblrxzSZ/0QO8ZKO4GVdSYx9dkwS0GTz5DBHR
	 LzAi+YJVxFm+/zqv3ewPm9xahSb0W3bBaViGaPxaCKFZ1OXXjpenRMUPcHDG2Lf5e21+m
	 34CqlzC2P55YgAudFv8Go9VE8ON3i1edn9VTBbH48M+9WbuwNstCiH8EZZ9vcTf3a1XrI
	 KL79DQhFb2Ln2JvNpge5V0l1875Qq22jOtGNDNf9PwLFGXrGB7MJe45pqw3QEHlYFkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007948;
	bh=q2BmsO/YWNdEGRiJ9LBvDfuocMDT6/JFIwjvkVUuXs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qINY1BcUQZrP1RInhTgCr5VO05tHbZ3H1TdbYMc9SY2IbihWULwDtgnOWShpvNdrv
	 pAK52UmNWZTLpE/QUj54TPqNEg0OZDmJoLQdqjzMrl4ob9Ro8hGs3TLOyKceWT6UiJ
	 qInLwyIEeP70Lz0G0kDZ67u1qrIiEhD8kFwKGl9JiUDLuvn/YggvZRVn+FIP74KUSk
	 axHVFyRuxQ4jNDRktvbAoOmO+Fy0hSYGbm1P0VFTMT0T+4LdCsNd1i9HrKPtMvKj3P
	 erj5ZBXRp7hv0zCwwasTLXkCZDu2/CH19ApE5zozgf76KId8hn5X63JhV4QvfV+wf4
	 3qIwD/n+zJPew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C84A812A0;
	Wed, 18 Nov 2026 13:19:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60EB5977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EBBC40A24
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvYJV1AZZsZL for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65CB740A23
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=mUBr6DVA
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65CB740A23
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 350C7C4CBD9;
 Wed, 18 Nov 2026 13:19:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5D2305FE9B;
 Wed, 18 Nov 2026 13:19:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E864911BC1FAA; Wed, 18 Nov 2026 14:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007941; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=q2BmsO/YWNdEGRiJ9LBvDfuocMDT6/JFIwjvkVUuXs0=;
 b=mUBr6DVAjR0qMASfON48NXmxkccKSLpK/xdhkN6tUetyTOryAA0VKWX9l4rNCLzfjxu2p9
 NJbgaobR4rjDaIA8pFXSY5f8yloTtZ+tY1hHUJG9S4bk9eif/twFlBHQJNDGh1Yb2EMrt6
 TV8w7qpHShEUnkzXDsLbMOMnL1ZWPc2OAZEtTnIhwk7m1p5gDtf7LRPt2mMhNylQqxCw+s
 73zJ45m3yGtyYp7wh8fsuBzm/Z2p/ALUUCJCjbfpFr+xVjxkUqrcffabieO9F/Ri+4XctN
 WSVaojmada6DNeraDAenxJBA/x+tCszGqNXhtv1xOLJnW3dCqNqbzI3BFT2VLg==
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
Subject: [PATCH v7 13/20] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200 SOC
Date: Wed, 18 Nov 2026 14:18:00 +0100
Message-ID: <20261118131807.135859-14-richard.genoud@bootlin.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

Add support for resuming from suspend in board_init_f.
The resume state of the SOC is identified and LPM resume
sequence is followed accordingly.

First, set LPM core bus path and compatible needed by extract_lpm_region
to find lpm-metadata memory region (at boot and at resume time)

Then, add the board specific part of the exit retention sequence for
k3-ddrss following the DDR resume sequence:
   - exit DDR from retention
   - de-assert the DDR_RET pin
   - restore DDR max frequency
   - exit DDR from low power

Finally:
   - Extract context address from devicetree
   - Power on the rproc cluster power domain.
   - Ask TIFS to authenticate the certificates attached to saved images
     of ATF, OPTEE and DM and apply the firewalls in it.
   - Send the context address to TIFS.
   - Ask TIFS to firewall the context address area.
   - Ask TIFS to decrypt and restore TFA.
   - Ask TIFS to resume TFA.
   - Power on the rproc power domain.
   - Jump to DM firmware.
(All those steps are done in do_resume())

Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j721e/j721e_init.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index a9224045b9f5..f8a11a653faa 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -20,9 +20,12 @@
 #include <mmc.h>
 #include <remoteproc.h>
 #include <k3-avs.h>
+#include <power/pmic.h>
+#include <mach/k3-ddr.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
 /* NAVSS North Bridge (NB) registers */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03802000
@@ -46,6 +49,10 @@
 #define DEV_A72SS0_CORE0_ID 4
 #define DEV_A72SS0_CORE0_MSMC_CLK_ID 1
 
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(1)
+#define DDR_RET_CLK BIT(2)
+
 #ifdef CONFIG_K3_LOAD_SYSFW
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 #if defined(CONFIG_SOC_K3_J721E)
@@ -298,6 +305,7 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
+	struct k3_ddrss_regs regs;
 	struct udevice *dev;
 #endif
 	/*
@@ -410,6 +418,30 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	k3_set_lpm_core_bus_node_path("/bus@100000/bus@28380000");
+	k3_set_lpm_core_compatible("ti,j7200-r5f");
+
+	if (j7xx_board_is_resuming()) {
+		/*
+		 * The DDR resume sequence is:
+		 * - exit DDR from retention
+		 * - de-assert the DDR_RET pin
+		 * - restore DDR max frequency
+		 * - exit DDR from low power
+		 */
+		k3_ddrss_lpddr4_exit_retention(dev, &regs);
+		k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, DDR_RET_CLK, true);
+		k3_ddrss_lpddr4_change_freq(dev);
+		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
+
+		/*
+		 * The DM (PDK) doesn't support being started with caches
+		 * enabled, and there no gain enabling them here and disabling
+		 * them just before jumping to DM
+		 */
+		do_resume();
+	}
 #endif
 	spl_enable_cache();
 
