Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F418C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 08:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A0C83599;
	Thu, 10 Jul 2025 10:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YlQUuRpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE6F835CD; Thu, 10 Jul 2025 09:23:51 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F411C8006D
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 09:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bd5tV5Ngmz9tCL;
 Thu, 10 Jul 2025 09:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1752132226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tLHnnqITDtZbvxpgOUK4z2GqfBqFLgVaTVcxIszIHPE=;
 b=YlQUuRpJdRQtb4wpl8+nZYuhz+QlQ9lDAtCXG5MSOHNkSLidpjwuN/ppo/159oHWfpd1e+
 8tAVGyRWvd/2ZJdBX5RznGBhfO6GkPn7yXuU19ProxoSnkGkYONJRnKp9ebhxjnlCjRruW
 WQ+rMj81TDH9dDnOco/QU3pbBzwi0YdTiB2clooVHWlQDjD0ZmrCfC2/KYNhthfyhpXdXP
 vUrgDqK6gygUrrv4XAm18zTrXLh50276VArIYBzV0J6AXxSGRodueG/oplWvveOuV+xV4w
 4/AEyj4f42PRtctzPP3j7npG5th84xvHo8SCMtUc2C7ZTRHcNW3VgbK7WdVKrg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
Subject: [PATCH] MAINTAINERS: Update email of Stefan Roese
Date: Thu, 10 Jul 2025 09:23:44 +0200
Message-ID: <20250710072345.3458823-1-stefan.roese@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: afa1a0b304e1d2eeb97
X-MBO-RS-META: z8teu5kqj4h4xpncjmne8p7tnb699j5h
X-Mailman-Approved-At: Thu, 10 Jul 2025 10:39:04 +0200
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

Use the @mailbox.org mail address also for community work.

Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
---
 .mailmap       |  2 +-
 MAINTAINERS    | 14 +++++++-------
 doc/git-mailrc |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 629d0ca95a81..67a42217cf86 100644
--- a/.mailmap
+++ b/.mailmap
@@ -125,7 +125,7 @@ Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <siva.durga.pala
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <sivadur@xilinx.com>
 Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
 Srinivas Neeli <srinivas.neeli@amd.com> <srinivas.neeli@xilinx.com>
-Stefan Roese <sr@denx.de> <stroese>
+Stefan Roese <stefan.roese@mailbox.org> <stroese>
 Stefano Babic <sbabic@nabladev.com>
 Stefano Stabellini <stefano.stabellini@amd.com> <stefano.stabellini@xilinx.com>
 No generic patch CC mail please <noreply@example.com> <swarren@wwwdotorg.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index d5264c8f5df6..f98acbc8885c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,7 +361,7 @@ S:	Maintained
 F:	drivers/misc/ls2_sfp.c
 
 ARM MARVELL KIRKWOOD ARMADA-XP ARMADA-38X ARMADA-37XX ARMADA-7K/8K
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
 F:	arch/arm/mach-kirkwood/
@@ -384,7 +384,7 @@ F:	drivers/watchdog/orion_wdt.c
 F:	include/configs/mv-common.h
 
 ARM MARVELL PCIE CONTROLLER DRIVERS
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
 F:	drivers/pci/pci-aardvark.c
@@ -400,7 +400,7 @@ F:	include/configs/pxa1908.h
 
 ARM MARVELL SERIAL DRIVERS
 M:	Pali Rohár <pali@kernel.org>
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
 F:	drivers/serial/serial_mvebu_a3700.c
@@ -1022,7 +1022,7 @@ S:	Maintained
 F:	cmd/cat.c
 
 CFI FLASH
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-cfi-flash.git
 F:	drivers/mtd/cfi_flash.c
@@ -1053,7 +1053,7 @@ F:	cmd/cpu.c
 F:	doc/usage/cpu.rst
 
 CYCLIC
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 F:	cmd/cyclic.c
 F:	common/cyclic.c
@@ -1251,7 +1251,7 @@ F:	drivers/i2c/
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
 F:	doc/README.kwbimage
@@ -1883,7 +1883,7 @@ F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
 
 WATCHDOG
-M:	Stefan Roese <sr@denx.de>
+M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-watchdog.git
 F:	cmd/wdt.c
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 50f896de8e8e..1982785f60e4 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -46,7 +46,7 @@ alias sbabic         Stefano Babic <sbabic@nabladev.com>
 alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 alias sjg            Simon Glass <sjg@chromium.org>
 alias smcnutt        Scott McNutt <smcnutt@psyent.com>
-alias stroese        Stefan Roese <sr@denx.de>
+alias stroese        Stefan Roese <stefan.roese@mailbox.org>
 alias tienfong       Tien Fong Chee <tien.fong.chee@intel.com>
 alias trini          Tom Rini <trini@konsulko.com>
 alias wd             Wolfgang Denk <wd@denx.de>
-- 
2.43.0

