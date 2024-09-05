Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1885BCD6E56
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 17:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F53488C8A;
	Thu,  5 Sep 2024 19:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="LYleBxSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6E388C1C; Thu,  5 Sep 2024 19:18:50 +0200 (CEST)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1136688CB9
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 19:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1725556727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSoWVg7M828ib6baaCGf7HQvjRcJUcPI6J9ZT37ft+U=;
 b=LYleBxSG67nrMp+qpqs/IDSJPaSc6/j5j5l754gIJ5+oj88DayMzwmp5YODfcHMn4S+8FE
 D858bAGXq5EJNTmCN4MSWVzywe3upbrIIPjUI8yh0Teh1hW+49AZdK1R1M0XVNLnN17t0O
 DwcHvYf3ftkYw5dr1U0SV4P94EKogvY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@xilinx.com>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 1/2] zynqmp: Disable secure access for boot devices
Date: Thu,  5 Sep 2024 13:18:32 -0400
Message-Id: <20240905171833.325548-2-sean.anderson@linux.dev>
In-Reply-To: <20240905171833.325548-1-sean.anderson@linux.dev>
References: <20240905171833.325548-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Boot devices (QSPI, MMC, NAND, and Ethernet) use secure access for DMA
by default. As this causes problems when using the SMMU [1], configure
them for normal access instead.

[1] https://support.xilinx.com/s/article/72164

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Don't set reserved bits in AXI_RPRTCN, since QSPI doesn't use ARPROT

 arch/arm/mach-zynqmp/include/mach/hardware.h | 2 ++
 board/xilinx/zynqmp/zynqmp.c                 | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
index 8cb6494e52c..f1514d6a869 100644
--- a/arch/arm/mach-zynqmp/include/mach/hardware.h
+++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
@@ -63,6 +63,8 @@ struct crlapb_regs {
 
 #define crlapb_base ((struct crlapb_regs *)ZYNQMP_CRL_APB_BASEADDR)
 
+#define ZYNQMP_IOU_SECURE_SLCR 0xFF240000
+
 #define ZYNQMP_IOU_SCNTR_SECURE	0xFF260000
 #define ZYNQMP_IOU_SCNTR_COUNTER_CONTROL_REGISTER_EN	0x1
 #define ZYNQMP_IOU_SCNTR_COUNTER_CONTROL_REGISTER_HDBG	0x2
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index e6331c0e4d8..56e3b36ca99 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -72,6 +72,10 @@ int __maybe_unused psu_uboot_init(void)
 	writel(ZYNQMP_PS_SYSMON_ANALOG_BUS_VAL,
 	       ZYNQMP_AMS_PS_SYSMON_ANALOG_BUS);
 
+	/* Disable secure access for boot devices */
+	writel(0x04920492, ZYNQMP_IOU_SECURE_SLCR);
+	writel(0x00920492, ZYNQMP_IOU_SECURE_SLCR + 4);
+
 	/* Delay is required for clocks to be propagated */
 	udelay(1000000);
 	
-- 
2.35.1.1320.gc452695387.dirty

