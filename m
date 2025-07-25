Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E439C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B557083A7F;
	Fri, 25 Jul 2025 17:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425BE83A25; Fri, 25 Jul 2025 17:51:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2C52583A6B
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D7E176C;
 Fri, 25 Jul 2025 08:50:59 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.31.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C30C3F66E;
 Fri, 25 Jul 2025 08:51:05 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v4 23/24] fwu_arm_psa: corstone1000: Set Boot0001 for on-disk
 FWU
Date: Fri, 25 Jul 2025 16:50:09 +0100
Message-Id: <20250725155010.285831-24-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Set Boot0001 to point to the ESP partition path

On-disk FWU requires setting the boot option to where the
EFI System Partition (ESP) is so U-Boot's capsule driver
can detect the ESP partition and start the FWU.

Corstone-1000 supports on-disk FWU on FVP.
The ESP partition is at mmc 1:1 and is accessible with boot option 1.

To avoid setting manually Boot0001 at factory level, Boot0001 is
set in the bootcmd. So, before starting the on-disk FWU, the bootcmd
will be executed and Boot0001 will be set automatically.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.env | 8 ++++++++
 configs/corstone1000_defconfig             | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/armltd/corstone1000/corstone1000.env b/board/armltd/corstone1000/corstone1000.env
index ee318b1b1c3..6e631b12bc2 100644
--- a/board/armltd/corstone1000/corstone1000.env
+++ b/board/armltd/corstone1000/corstone1000.env
@@ -1,5 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 
+/*
+ * Copyright 2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ */
+
 usb_pgood_delay=250
 boot_bank_flag=0x08005006
 kernel_addr_r=0x88200000
+prepare_ondisk_fwu=
+	if mmc dev 1; then
+		efidebug boot add -B 1 OnDiskFWU mmc 1:1 / ;
+	fi;
diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index d52d39a0b36..e02fb7cca67 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -25,7 +25,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0 loglevel=9 ip=dhcp earlyprintk"
-CONFIG_BOOTCOMMAND="echo Loading kernel from $kernel_addr to memory ... ; unzip $kernel_addr 0x90000000; loadm 0x90000000 $kernel_addr_r $filesize; usb start; usb reset; run distro_bootcmd; bootefi $kernel_addr_r $fdtcontroladdr;"
+CONFIG_BOOTCOMMAND="echo Loading kernel from $kernel_addr to memory ... ; unzip $kernel_addr 0x90000000; loadm 0x90000000 $kernel_addr_r $filesize; usb start; usb reset; run prepare_ondisk_fwu ; run distro_bootcmd; bootefi $kernel_addr_r $fdtcontroladdr;"
 CONFIG_CONSOLE_RECORD=y
 CONFIG_SYS_CBSIZE=512
 CONFIG_LOGLEVEL=7
-- 
2.25.1

