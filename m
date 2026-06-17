Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AF7CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 02:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B236848D8;
	Wed, 17 Jun 2026 04:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XKnw84F9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kFTmLBAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5779B8495E; Wed, 17 Jun 2026 04:49:11 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216B9848A2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 04:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gg7bm5X87z9t8w;
 Wed, 17 Jun 2026 04:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/5tnsibk2QAbpZ6sa5W5Clbj18f20prR/5vsqAgughY=;
 b=XKnw84F93L8XzgWxFs0mVFVC5WsTxQo6vsaDO4s6Sl72ECnXlmKNuBOk5FydvHEHBvU6H/
 BdqubgZqjVVzB+UAbjzzw+bvcEuI5geTquGwmzUzjc2UfY25Ixkj4a/FCgt9HhqXVBH76w
 Y9V76VokQK5zvJpjO0mKxgo2ZO0kC3eGlEAOzBqhVcAB2UyTp/FE+y9aicYxpGxP0hM++U
 pmLwYleBiXEw4Ui6/StMuPrZ/drVfxqtIKjVX1/BCamvxVw2OpW2MkEo5cho04+zNnohaU
 H+ey8/IGLwFV8v5XxglpFf2tXrxkZeNqs1EAf0C14nCVjuLItn0s1mpOd4WIIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/5tnsibk2QAbpZ6sa5W5Clbj18f20prR/5vsqAgughY=;
 b=kFTmLBAt48G4F/f5dcujWw4i3SiNsfkX747FA/RnPRrDyOWvNMURVczU+n4Qf1GcgHbt3j
 b0Nx1sWRFs8zK2fohBNdLwAMd/IzmByHcyt0ktE6B2ovmUsbFbPMqpT/+2+mMXi+hOUp8C
 vyOAUHFPExZX+zB2VjqqeC7Oogf5m/hNtd8daa7kskvcQ9iw4GtEs4B34UNEIWjWc4YiXC
 S4ew0FZvF6l5Yx6J+429H2iyCUFqOwcV8PrKI5pI6q6DedSsY2wHbdkDaK4u+gD7h1fP3w
 VCHGAHuxsSHpZaPDExwpVC6Q8USHfpeejWxuG8S+OX1feZqMhnMFsPiQvtWUlA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace Zynq/ZynqMP with N:
Date: Wed, 17 Jun 2026 04:48:46 +0200
Message-ID: <20260617024902.153555-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5cd42bce0edb8953615
X-MBO-RS-META: 5694p97k6cnza8rgyim7obbwe8yxbcws
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

Use N: to match on all zynq/zynqmp files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process. Combine Zynq and ZynqMP entries into single
entry to further cut down the duplication.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 56 ++++-------------------------------------------------
 1 file changed, 4 insertions(+), 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c862b206a85..7eeaeb4583f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -749,72 +749,24 @@ T:	git git://github.com/ARM-software/u-boot.git
 F:	drivers/misc/vexpress_config.c
 N:	vexpress
 
-ARM ZYNQ
+ARM ZYNQ and ZYNQMP
 M:	Michal Simek <monstr@monstr.eu>
+M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
-F:	arch/arm/mach-zynq/
 F:	doc/board/xilinx/
 F:	doc/device-tree-bindings/video/syncoam,seps525.txt
-F:	drivers/clk/clk_zynq.c
-F:	drivers/fpga/zynqpl.c
-F:	drivers/gpio/zynq_gpio.c
-F:	drivers/i2c/i2c-cdns.c
-F:	drivers/i2c/muxes/pca954x.c
-F:	drivers/i2c/zynq_i2c.c
-F:	drivers/mmc/zynq_sdhci.c
-F:	drivers/mtd/nand/raw/zynq_nand.c
-F:	drivers/net/phy/ethernet_id.c
-F:	drivers/net/phy/xilinx_phy.c
-F:	drivers/net/zynq_gem.c
-F:	drivers/pinctrl/pinctrl-zynqmp.c
-F:	drivers/serial/serial_zynq.c
-F:	drivers/spi/zynq_qspi.c
-F:	drivers/spi/zynq_spi.c
-F:	drivers/usb/host/ehci-zynq.c
-F:	drivers/watchdog/cdns_wdt.c
-F:	include/zynqpl.h
-F:	tools/zynqimage.c
-N:	zynq
-
-ARM ZYNQMP
-M:	Michal Simek <michal.simek@amd.com>
-S:	Maintained
-T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
-F:	arch/arm/mach-zynqmp/
-F:	drivers/bootcount/bootcount_zynqmp.c
-F:	drivers/clk/clk_zynqmp.c
-F:	driver/firmware/firmware-zynqmp.c
-F:	drivers/fpga/zynqpl.c
 F:	drivers/gpio/gpio_slg7xl45106.c
-F:	drivers/gpio/zynq_gpio.c
-F:	drivers/gpio/zynqmp_gpio_modepin.c
 F:	drivers/i2c/i2c-cdns.c
 F:	drivers/i2c/muxes/pca954x.c
-F:	drivers/i2c/zynq_i2c.c
-F:	drivers/mailbox/zynqmp-ipi.c
-F:	drivers/mmc/zynq_sdhci.c
-F:	drivers/mtd/nand/raw/zynq_nand.c
+F:	drivers/net/phy/ethernet_id.c
 F:	drivers/net/phy/xilinx_phy.c
-F:	drivers/net/zynq_gem.c
-F:	drivers/phy/phy-zynqmp.c
-F:	drivers/power/domain/zynqmp-power-domain.c
 F:	drivers/pwm/pwm-cadence-ttc.c
-F:	drivers/serial/serial_zynq.c
-F:	drivers/reset/reset-zynqmp.c
-F:	drivers/rtc/zynqmp_rtc.c
-F:	drivers/soc/soc_xilinx_zynqmp.c
-F:	drivers/spi/zynq_qspi.c
-F:	drivers/spi/zynq_spi.c
 F:	drivers/timer/cadence-ttc.c
 F:	drivers/video/seps525.c
-F:	drivers/video/zynqmp/
 F:	drivers/watchdog/cdns_wdt.c
-F:	include/zynqmppl.h
-F:	include/zynqmp_firmware.h
-F:	tools/zynqmp*
 N:	ultra96
-N:	zynqmp
+N:	zynq
 
 ARM ZYNQMP R5
 M:	Michal Simek <michal.simek@amd.com>
-- 
2.53.0

