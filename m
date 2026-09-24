Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02C0C9831A
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9D3A81E14;
	Thu, 24 Sep 2026 12:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFaPwBOSv6Gh; Thu, 24 Sep 2026 12:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6A75D81DFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253428;
	b=Nf7URV0sqRmUUlYkrqApGe4dNMwdjmh7NIAQATl2Pf3gBmcSNyr+OekWbIwBoKBaHuHM
	 aoNYODsDKXToON4ZG85Y6/jWCHdRi4fSeFQJa3NAmO8HPA7Up3zTXKnhemG3N8X3FpM79
	 WFddab7RTSIiiIk/6ED/UXGMCUtV2r7l8eMzDe6allvaEVHx17nPpa5YZw4NIw5DcEZaZ
	 T8FF3PSfU23uCJquMLTasYGzB7Ez1xX2W+ylPqWTq7eOE5zJHAafNX3wk5Kok30Z7T7au
	 KGMPR+J3hDovOGlUkZu3k7HvcClWYKspZmy+FAIH5gWTD/jTRmBjsYDpq4sbuGfihhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rfdcleqkj3s0J9RQspznYF7YzabyLfIikE6dG+YVhbQ=;
	b=KaumL4SjNXU4M561TGLyDdZB0OPe56KhHzcMF/2Nu3mi09awehkZeCpY7L1kS5nCVryj
	 A4r/gLvfcRuamJzCDfeC8chDMxc/ftXIzg+Z/EejHoR+Pvh3M9fC5gwxNPNAWvVw83Mii
	 /9TRN/WNtIgbENdYTufafrOxgkGzLZZlcmgLqNyiRxQJbAYInHAbYGMxk/Yhfpu/xuG5p
	 EIwEL+IiTdbgbt+GM/HRYh+Y1DTk7dLL27j3EwztTWyod/+r4rgH2lNHPnwnxE1CZnpUT
	 rKEHafgREDUM+8q6tDGA9sPJ9r5y4ygeL4qjj5CCyTYyxGRAy5RC1gIUzA7qbXsiJRA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253428;
	bh=Rfdcleqkj3s0J9RQspznYF7YzabyLfIikE6dG+YVhbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tn02WK/wJJyJKrKokq5m7/zsQSmP2OVdhh2mHobQUiGSQ4bw4nZgoEiJvBcK/M8Wo
	 DGH6l2hw6YSPcSOWr8rBWbv3UbK0eU0j1Sjd8nKMI2wdleFKglzOe+iIMuxWaq9lKq
	 /lr3+MSN8pywxpThMwGN4T1k19ZCFSt4/27gF6mP/1FkoogVUym8kYn/ytC00f4t+k
	 1P8uhwI9LW+0WlgjqcaEvwsVHNTKNkeP1PG0a1NG85h2kNWQ5iZCGnhR52m+/0Ah1T
	 vf5Bda/tG9ZYpgN3vGUhoaG4CvNhKZv5Hf1EG3cJWgf1txSmSZRK5aFhkGXY7Uj7Q6
	 cTKDsusDPDnOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A75D81DFB;
	Thu, 24 Sep 2026 12:37:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22DCC35A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 084B440456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CuNeohtRIJGy for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 39305400FB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253426;
 b=bBO6mgpqGRGzxDh/E52gUCCTeD2Rk7tyn5JtzERt7tZ88km4EoirRyyM37pf1Vo1FjJQ
 ZoDE6BSMghIhSEWYC1YQ0ND9r03bPYz4xNJeMhp3mBWTdvYLcS1ny7n3K80n5I1S0zrcx
 m4OC9UmvJqhALR12Ofo3KZJGFusSsZvM7/+vpaF0hE9uufDvUHGd9GhrB/BKIsHz88Phc
 NRQacTqLwV9VT1Hq/VLVTaMv4a/WWbFyjiEVW7EtdyopPjmV76sA3YZsZQYIH5k41nw4M
 M3DFH5dUElAv3+EjPu2Up8NXe/glkAiHso8fywtC8BBQ7kIpHUPyxgjMBDIS5AHugvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253426;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Rfdcleqkj3s0J9RQspznYF7YzabyLfIikE6dG+YVhbQ=;
 b=WRlqPtwM1kZv3wXni6B9QHDRDNfyd3cQhLfU+veDqHm2I4dBc4SRwTozdQDYWdDMr4qy
 vm+H72mN4OVlrv11pcf9ukK75/R6pVrAU/CMlbused9zI4GvLDqMCZ3ZHtW9GFktbdTyA
 5p7TVxM+oWWMEU3TvmSQq22RNHn5DUlnFXOeniBAvWYPuFd6UyxJXV30IIef2vlbLM8VX
 En8DtEFEUy8Psvh60D5uGPnBk6UVacB8vAiMAaXO8bU8xbdiN+R0L0ffoXMZkuns4qMn3
 L0wVN9ZMVINAQCBc2d7hIzDtekkblcXFnP7DlxX0OrnYcL5lmeOPeAYxZwcmOVwBrOA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=MSlwSygb; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=MSlwSygb
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39305400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CC11AC211C1;
 Thu, 24 Sep 2026 12:37:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 66FC360341;
 Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E45EB103293FD; 
 Thu, 24 Sep 2026 14:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253422; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Rfdcleqkj3s0J9RQspznYF7YzabyLfIikE6dG+YVhbQ=;
 b=MSlwSygbfnI15f7zE6lW1u91rU/Oklerat2PgpGkEf1j6gk2fJvVqnq35Ai/GDevd3LX6r
 Wkob6i7AKajUYlg1VSy8syWnEnxMozYg5fnTRolY51avU9KIpKnZUoPQ6J3hKfwKw36BUt
 O3f3ta6+8iMbGrlIPqn4QcXTLP9z541g5f5XN9KWI/TKM5uQJs8v6CNtVDPJSa1cA2oTld
 NBfiENGrZXrsnjbX1pxvq3JxtLIkZXLkP1xZpcb9r18IZiUuAi/1tZ0hzyHYTiIWgOwkpU
 3o/6Jf+smQj1qgI7niOb/P1ImCA0LFmaFAGoRAjxr4wRuAaHuK2zqWH5ciSKBA==
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
Subject: [PATCH v6 15/22] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200 SOC
Date: Thu, 24 Sep 2026 14:35:26 +0200
Message-ID: <20260924123533.2599438-16-richard.genoud@bootlin.com>
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
index f9af0288cf66..15299ad2a613 100644
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
 
-- 
2.55.0

