Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=niSwym9x;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2TfDBM/I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8C6740A33;
	Wed, 18 Nov 2026 13:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojUYoDXscGcT; Wed, 18 Nov 2026 13:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA44240A2F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007951;
	b=j9KcV/b3rwXrQqzdYI13Fgy0qYq4Oz/7g6BRTx5mU+i5hBvhimyXVRv55PlS0ChUyk/r
	 PeqiGs6Y76mRhQrCxfn4Y58zz/sOTv63h5VHE6PysszfvUjlJ4XjNzGiG+pIfVUuKgi2T
	 2BXhh2J8VU5M42DDMN5szxRhYjlZuJFReZtKDDNsfANns8DWC+SUxby13YUxiOlOLfQwO
	 14aGzSoYc8/VV92dMzbChmZv283DlMACrnt7SZMJPW6AtFW8JzxEvqu8qQdHlXZntV2C2
	 IzQSwuBlhqbHGN+2AQ3NCptiwGobpzuWDF56Eh+g9a0qN4iFOlbBEUof3f2nqh+15qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/XC6ggizvOKhVzHUnW7ENkuOas2pKv5majGA1uid7YA=;
	b=EMldBwvdoCRi0JpcdvWIrTR2+6ZldGcmG1Kepx2eIH7RlAeuxUlaNRHcioM52lJuHulB
	 2SC0uYh5vqDxQ1g06U1T8LoCeeZxxd72s4Kw6ZFzITPRuhx6+B3YWlI+IITZ7zVKjfXMO
	 tRqaGqh6gu9f7AVCD6Lzzkm+/ZcDQGSlfL/J0Z06RV5JDX7kvCVphd55X8knHRw1LXkp4
	 b3o4WW7sq8/8ypuwkGILvOc0OccpJLrqCYsoERD3biStGCm2eq5njpEsGhQS6slH8yiDT
	 3jHzXfElOrXaFZBneeursRO7h7VeAAmjXnNBkDrCkiagWBT3StIcUrwX+brqG1sDCzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="2TfDBM/I";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007951;
	bh=/XC6ggizvOKhVzHUnW7ENkuOas2pKv5majGA1uid7YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=niSwym9xIlHbfrgOsFxwTeJexv30JEuPbu+VTnbMo1YS7kcvPU7lD0v+cFgyW6oMO
	 1s33xoH6WuSmBTlSSi+HAqtSgj25WoJKnbxSdPva8eD7KliLpv9lROZ7YpEshk2tiR
	 7se2aVP81VjQU41Sjmiy8ox85tMS+Ujj4CYlHg2e2evFaGOQ/oPwz3p6eeLNzudSaT
	 +us7l9kx9kvfPxLoc99gAoiYoGKy/998wPoyEE14Pf+K/bJwGqHZ0wlxt5FV2g+Czj
	 A+TWXbtBw43AxbjJWsJVAs1pwePHeOfQJKiHJZn0FJVq2MK3Rpl9dHwP4ifMd4YfKy
	 HT0o2SJwJvrvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA44240A2F;
	Wed, 18 Nov 2026 13:19:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F885A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CF8240A2D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJS8Lluk1DJh for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A133040A13
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=2TfDBM/I
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A133040A13
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D8429C4F77E;
 Wed, 18 Nov 2026 13:19:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0E61D5FE9B;
 Wed, 18 Nov 2026 13:19:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F48711BC1FB6; Wed, 18 Nov 2026 14:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007943; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=/XC6ggizvOKhVzHUnW7ENkuOas2pKv5majGA1uid7YA=;
 b=2TfDBM/IlHXUqclGfasDEynJvCgq/BJBdVWB/MwlRJq2yRz/agIHgOUO0zxpLUtYyuaWFS
 xICwhwx58zncgCCKBdGWTtm7Qm95jcmau30tXhX7qYLI3qViX/+Xp6RMTS/eCNmSeJdW/0
 h/ZP/k1iEogTqM4GX9qMs8PXBxY/4g2L2i+ZBgjQl99B+NrY/kDrL/nGKC0yUi4ZRPe/Bq
 xF98H9OJ4pnNBPvmNDpqeGrX/LZuWQ5RCMNW4ERlSAZm25L2M7Iy6vaTnnJtqo0WdOnEDI
 oFhXfrXE64tL4fSHmr5nvJQx6/YbkK3ZTNUZZw48vFM27+PATuR6+zy1YaS0qA==
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
Subject: [PATCH v7 14/20] arm: mach-k3: j784s4: Enable LPM resume flow for
 J784s4/J742s2 SOCs
Date: Wed, 18 Nov 2026 14:18:01 +0100
Message-ID: <20261118131807.135859-15-richard.genoud@bootlin.com>
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

The self-refresh exit sequence is performed in a loop for each DDR
controller. (J784S4 has 4 DDR controllers and J742S2 has only 2)

Select the number of ddr controllers on the basis of
CONFIG_TARGET_J742S2_R5_EVM build flag.

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
Co-developed-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 52 +++++++++++++++++++++++++--
 board/ti/j784s4/evm.c                 |  3 +-
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 507b7ab685ad..84e7d6d659a8 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -18,11 +18,21 @@
 #include <mmc.h>
 #include <remoteproc.h>
 #include <k3_bist.h>
+#include <power/pmic.h>
+#include <mach/k3-ddr.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
-#define J784S4_MAX_DDR_CONTROLLERS	4
+#if IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)
+#define MAX_DDR_CONTROLLERS	2
+#else
+#define MAX_DDR_CONTROLLERS	4
+#endif
+
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(5)
 
 #define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL	0x001082e4
 #define AUDIO_REFCLK1_DEFAULT			0x1c
@@ -279,20 +289,58 @@ void k3_mem_init(void)
 	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+
+		devs[0] = dev;
 		ctrl++;
 
-		while (ctrl < J784S4_MAX_DDR_CONTROLLERS) {
+		while (ctrl < MAX_DDR_CONTROLLERS) {
 			ret = uclass_next_device_err(&dev);
 			if (ret == -ENODEV)
 				break;
 
 			if (ret)
 				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
 			ctrl++;
 		}
+
+		k3_set_lpm_core_bus_node_path("/bus@100000/bus@28380000");
+		k3_set_lpm_core_compatible("ti,j721s2-r5f");
+
+		if (j7xx_board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+			}
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_ddr_ret("pmic@48", DDR_RET_VAL, 0, false);
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+			}
+			printf("Initialized %d DRAM controllers\n", ctrl);
+
+			/*
+			 * The DM (PDK) doesn't support being started with
+			 * caches enabled, and there no gain enabling them here
+			 * and disabling them just before jumping to DM
+			 */
+			do_resume();
+		}
 		printf("Initialized %d DRAM controllers\n", ctrl);
 	}
 
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 5e9b9944a15f..269ea0801fb4 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -61,7 +61,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || \
+				      IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
 void clear_isolation(void)
 {
 	int ret;
