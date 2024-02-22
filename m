Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB9C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 16:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DB088089;
	Thu, 22 Feb 2024 17:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="eAAEuDF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3B288097; Thu, 22 Feb 2024 17:52:40 +0100 (CET)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B2088087
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 17:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1708620757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zeSI54lBghPjacB0rirnOshg39bVdFyZofKano4T5q8=;
 b=eAAEuDF9XK8a+uLhUZ+X5TqqLl2RMkNn3AN5Eug9f+Q2Sfqo9nxFuAtm79FcxfsMfMigrX
 /LSxVCch9Ewccns/yt8XWZzV2Gn+I7zaDbX4tVofzpXHFzR/MPNadiMO7aOpP1dKVsja/n
 lykgRPAPuQs3shZ89ZFUy6da/XQXMg8=
From: Sean Anderson <sean.anderson@linux.dev>
To: u-boot@lists.denx.de,
	Michal Simek <michal.simek@amd.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2] arm64: zynqmp: Support semihosting boot method
Date: Thu, 22 Feb 2024 11:52:30 -0500
Message-Id: <20240222165230.2600974-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 22 Feb 2024 17:52:59 +0100
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

From: Sean Anderson <sean.anderson@seco.com>

Currently, when we boot from JTAG we try to boot U-Boot from RAM.
However, this is a bit tricky to time, since the debugger has to wait
for SPL to initialize RAM before it can load U-Boot. This can result in
long waits, since occasionally initializing RAM (and other things in
psu_init) takes a long time to complete and the debugger must wait for
this worst case.

Support semihosting if it is enabled, as it lets U-Boot tell the
debugger when we are ready for the image. This means we don't have to
wait any more than necessary. We don't change the default config to
ensure we don't break compatibility with existing debuggers that don't
expect us to hit semihosting breakpoints.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
I'm resending this from my linux.dev email as my regular email is
mangling my patches.

Changes in v2:
- Fix typo in subject

 arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index a0f35f36faa..5af735aa5ce 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -9,6 +9,7 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
+#include <semihosting.h>
 #include <spl.h>
 #include <linux/delay.h>
 
@@ -66,6 +67,11 @@ void spl_board_init(void)
 }
 #endif
 
+static u32 jtag_boot_device(void)
+{
+	return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
+}
+
 void board_boot_order(u32 *spl_boot_list)
 {
 	spl_boot_list[0] = spl_boot_device();
@@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
 	if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
 		spl_boot_list[1] = BOOT_DEVICE_MMC1;
 
-	spl_boot_list[2] = BOOT_DEVICE_RAM;
+	spl_boot_list[2] = jtag_boot_device();
 }
 
 u32 spl_boot_device(void)
@@ -97,7 +103,7 @@ u32 spl_boot_device(void)
 
 	switch (bootmode) {
 	case JTAG_MODE:
-		return BOOT_DEVICE_RAM;
+		return jtag_boot_device();
 #ifdef CONFIG_SPL_MMC
 	case SD_MODE1:
 	case SD1_LSHFT_MODE: /* not working on silicon v1 */
-- 
2.35.1.1320.gc452695387.dirty

