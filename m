Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D206CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 15:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F9483280;
	Wed, 10 Sep 2025 17:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A0348323A; Wed, 10 Sep 2025 17:14:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3EF9C830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 17:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=debbie.horsfall@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C77716F8;
 Wed, 10 Sep 2025 08:14:09 -0700 (PDT)
Received: from e137876.manchester.arm.com (e137876.arm.com [10.33.10.100])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96BFB3F694;
 Wed, 10 Sep 2025 08:14:16 -0700 (PDT)
From: Debbie Horsfall <debbie.horsfall@arm.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, fenghua@phytium.com.cn, linus.walleij@linaro.org,
 Peter.Hoyes@arm.com, liviu.dudau@foss.arm.com
Subject: [PATCH 2/2] arm: vexpress64: Enable SYSRESET and SYSRESET_PSCI
Date: Wed, 10 Sep 2025 16:13:42 +0100
Message-ID: <20250910151342.204255-2-debbie.horsfall@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910151342.204255-1-debbie.horsfall@arm.com>
References: <20250910151342.204255-1-debbie.horsfall@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Sep 2025 17:57:30 +0200
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

Select SYSRESET on Vexpress64 to enable system reset to support other
features, such as capsule-on-disk. Select SYSRESET_PSCI if PSCI is
inferred from the firmware (via ARM_PSCI_FW).
Select ARM_SMCCC for Vexpress64 boards which in turn selects
ARM_PSCI_FW.

The sysreset uclass unconditionally implements a reset_cpu() function.
Remove the empty reset_cpu() in vexpress64 board code.

Signed-off-by: Debbie Horsfall <debbie.horsfall@arm.com>
---
 arch/arm/Kconfig                     | 2 ++
 board/armltd/vexpress64/Kconfig      | 2 ++
 board/armltd/vexpress64/vexpress64.c | 5 -----
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40368abc297..d51a7619cdb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1417,6 +1417,8 @@ config ARCH_VEXPRESS64
 	select MTD_NOR_FLASH if MTD
 	select FLASH_CFI_DRIVER if MTD
 	select ENV_IS_IN_FLASH if MTD
+	select SYSRESET
+	select SYSRESET_PSCI if ARM_PSCI_FW
 	imply DISTRO_DEFAULTS
 
 config TARGET_CORSTONE1000
diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index f413c51ac43..5b10074e03f 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -22,6 +22,7 @@ config VEXPRESS64_BASE_MODEL
 	select LINUX_KERNEL_IMAGE_HEADER
 	select POSITION_INDEPENDENT
 	imply DM_RNG
+	select ARM_SMCCC
 
 choice
 	prompt "VExpress64 board variant"
@@ -47,6 +48,7 @@ config TARGET_VEXPRESS64_JUNO
 	select USB_EHCI_GENERIC if USB
 	select USB_OHCI_HCD if USB
 	select USB_OHCI_GENERIC if USB
+	select ARM_SMCCC
 	imply OF_HAS_PRIOR_STAGE
 
 endchoice
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index 0b75c1358f0..e8f1c2fe9fe 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -206,11 +206,6 @@ int board_fdt_blob_setup(void **fdtp)
 #endif
 #endif
 
-/* Actual reset is done via PSCI. */
-void reset_cpu(void)
-{
-}
-
 /*
  * Board specific ethernet initialization routine.
  */
-- 
2.43.0

