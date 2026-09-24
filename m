Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C245EC98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F80A806FA;
	Thu, 24 Sep 2026 12:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0NKlNuWlkq9; Thu, 24 Sep 2026 12:37:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EBF7181E1F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253431;
	b=EMYOfEMcA9JS7rlwQx7MIxgO3ZCnftryxSZbeUUE+Vf8i6SV1MkkRU11+0TdKuiuWXmI
	 XcGBPtmJsB39SNvYGSTjvTw92DbIwLhHG+t/rVa2C0AhnWrXFphsNBrwcr7HcigoM8dHo
	 VCNNkMwACbtUyKMdGmUG8n9Ky6983NIk4H3hahDHVZ0Y+pEuxEvRuKx700IsT4sOWIj3R
	 w7xyEa5y6iBq9TdLTt8rU0qGExjsb6odKIzIz+M907hZFBkIYXHWqHC/KPpoBuWqqzFAG
	 UqpCfDUY5Pvd8EEbgvw9rEmZ1TJFSfvHkUq5Zxrf/m5jqWRBKazqoe3nfsu/wgp83Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AvTM8/XaNWcWBPAvmNSVW0R6AHfKjE3+TEpnTSSimVE=;
	b=LbtNMZ7ZnrbFsw40+pEDJkhETvcP2eotNM7uutk8/2+TzhiWlx7JhzeOLldbRxOxP9fk
	 psPgLC5tEkp9FrgZly2NL1GyLs6+WZkBDVZPJ/03NqWQ+l2QlnkYI2Rwn2TZYLF6TToDm
	 /hsy98kpVYZ+W4x9jdButj9mSDx7xfd4FwFPKPkfGjUv5zpw2uD7XpcWfHCOXD96e/uZ0
	 js583AtTuUM3kPjT9c+yUOScUcboNhnhUb6HeWeaboI/oXbaUMGh+MrpfvA3tiJSIiv94
	 1e37YMCgiqvy3FKqVtrAA5lpkqymAZT5VYl/MigkfOgFFr9L8G4mo9qotGGBqhmyfzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253431;
	bh=AvTM8/XaNWcWBPAvmNSVW0R6AHfKjE3+TEpnTSSimVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2QWXmrGX8+oeB7J3EqxKgjvNOLB3MaCmy5o3wBDvp826thSwV4jSdwGsRLV71Sxc
	 Co81IM2ysM+9p6eiJuswBloqmNVAN6PLLqbNe0CISEuW24R3nzMCjPOnL4yI4aC4Y8
	 pUVcMU8OSZjLZKD1VJ1+EIxE2j5A1VkmGVeLTBendAfyMh6+78MZi/bORtMbKY5plF
	 qV7sofkElWvGm2YBoxbx5SVM3oXyoaOd1fVESIQjupWe7TvO0tB5fScoX4UhD5k732
	 /PRPBj9MyQnGgfrmdSaBJvT3svQVryJFTzzUCnfM4TiGMOuwn+JS3QhSPlJschB6q+
	 czKeuzePYD6Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBF7181E1F;
	Thu, 24 Sep 2026 12:37:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B21DB194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD49F40CAC
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhA1O4WfNv3x for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A300C40D04
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253429;
 b=JPNnnC2pfhm00MaQDPYKnhK5rF53My6Q2hnM8C1lSRVwbMC9FL+RfXYX+NZmkUYX2vKZ
 YLVcVygaSV0LskxvACv/NXs3bei5WfYiS90qiGA1bYs4gdmcHyv27TdZbLKgDdAg1lQLJ
 Bllxgi3L52l6zV1PeYB4yqM3RzlnbqjvOgV5jL8FwnggdF4KfqWjLsXjuNq8+wl3KRH/O
 ahpNB7+ECZoVTyYnBQR0wRuoR1JaggRWLv2wvA3N5vYw63JYY6lzuG4OK9rl9wg5ucr/V
 JCEbjrWKdv7VjKbqPGO/DScx1m9HwsI6sCdFo2iXciG5qoMnkTF5UQeXOMLepBTt21A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253429;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=AvTM8/XaNWcWBPAvmNSVW0R6AHfKjE3+TEpnTSSimVE=;
 b=fByvVVX5e93iqOthA/zclF/u9xE8ODaXhNC9TBvOhq6VJEyRL3SbmSLf8YgXdMIDhum7
 ghdzJVp+B2Cbe6xpdVAyzJFs7YIz8h48unJ3Mjrq3vuYP1ARVeWGBQV5Y4w6z+Con1v8y
 CPGdAqwsQx+JTUtQkOaBs1wtTwi8MY+w0QYFFo7Ua5DlkmyZLnFCOP6wVme3DmrKlcB+o
 2BNL+Iji1nQhWLNOccLN+PhNWbkkeu+s0YFrXN52n3Qh+H7VvYfvNtsQREOdysP7uEyCe
 WG6roL61wRSjPBFbAIfEQqeZakTVPPuBeMLwxuWTqZN1XcyX+rDcxdt4UTEBMOJDchQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=e4Z3lhJG; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=e4Z3lhJG
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A300C40D04
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0E0BB4E4105A;
 Thu, 24 Sep 2026 12:37:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D050560341;
 Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6798010329407; 
 Thu, 24 Sep 2026 14:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253425; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=AvTM8/XaNWcWBPAvmNSVW0R6AHfKjE3+TEpnTSSimVE=;
 b=e4Z3lhJGuTc0RdjYFs8xpzKbEPkv5glH5ozqnepPfa0yjX3ZQgX0ag+vXxyQWrfdMYeuM5
 FWVTn4EFedTiMgUogxHlvJvLc1jxo/NwmktGiDwmxKZA2SXw8Fvs/nvP98V3KAtPrH4biv
 SgWESHfEtRyVNp14l9aQUwUPkiVbNxD2x9DD1woLIM7G6l544gDW5q69/z/rtNr1KdA3AG
 3C0bBX4NVLOYiOvaon8XqJyvH9vw0jtymtEY7GSHdNUm9Dopv5JL8oZjphHpe4uVuT3uLL
 0CSJce4qmwj4hd5Yn0pVlE9noFpnq5NHyr5bWJ5rLVE5byS1NjkiINYN6mHo7Q==
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
Subject: [PATCH v6 16/22] arm: mach-k3: j784s4: Enable LPM resume flow for
 J784s4/J742s2 SOCs
Date: Thu, 24 Sep 2026 14:35:27 +0200
Message-ID: <20260924123533.2599438-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
-- 
2.55.0

