Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65470CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A982D86C39;
	Mon, 16 Oct 2023 23:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dKobUAH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E9186B97; Mon, 16 Oct 2023 23:54:57 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2038E85423
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 25F4F3F733; 
 Mon, 16 Oct 2023 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697493290;
 bh=US0rkwU8n2lIXhYqWfi4t2bw6dFBxGh0ZohUrmN1DRY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=dKobUAH04aU7vGIDWJdU3RCVvqpXFlOkkVTJrJcXcBkIGrwFEEY82PVsv6K7MHcUa
 wOVB6fhqn+Yu7Se91aaYv9VKRhGC/OofxovGeyGCUkUrTRnaTEdcf016Yo1qU9W6bH
 PmVk1vdfg/5FOxbNTFWq6XUfy++b9jAuSz4ExA1ntNppI5gWMr9zD7CvBANC2Tw6qu
 7WnKCms3s0N29BKtqi7oXGjDCdC/vtgGBdgIMQS8Q7gpg4KZpXAlzaFKdiFfqUlCnq
 RB/sr/7cTx4Y/8P4rUc8kpFb0QXSIr6vjVMIglkOHUZnwxRCwnNVEf91GNkzAL2efL
 jsCh7U/d2Dl+Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Alexander Graf <agraf@csgraf.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] config: qemu: relax print and console buffer size
Date: Mon, 16 Oct 2023 23:54:45 +0200
Message-Id: <20231016215445.5970-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

QEMU print and console buffer sizes have been restricted on QEMU below
their default values.

One of the side effects of the print buffer size restriction is output
truncation of the 'efidebug dh' command.

As QEMU does not have special memory size restrictions remove the settings
from the defconfig files and go with the generic defaults.

Fixes: d0ee7f295d74 ("Convert CONFIG_SYS_PBSIZE to Kconfig")
Fixes: d31466b382dd ("Convert CONFIG_SYS_CBSIZE to Kconfig")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/qemu-ppce500_defconfig       | 1 -
 configs/qemu-riscv32_defconfig       | 2 --
 configs/qemu-riscv32_smode_defconfig | 2 --
 configs/qemu-riscv32_spl_defconfig   | 2 --
 configs/qemu-riscv64_defconfig       | 2 --
 configs/qemu-riscv64_smode_defconfig | 2 --
 configs/qemu-riscv64_spl_defconfig   | 2 --
 configs/qemu-x86_64_defconfig        | 1 -
 configs/qemu-x86_defconfig           | 1 -
 configs/qemu_arm64_defconfig         | 2 --
 configs/qemu_arm_defconfig           | 2 --
 11 files changed, 19 deletions(-)

diff --git a/configs/qemu-ppce500_defconfig b/configs/qemu-ppce500_defconfig
index fbe84d5702..de7267e228 100644
--- a/configs/qemu-ppce500_defconfig
+++ b/configs/qemu-ppce500_defconfig
@@ -21,7 +21,6 @@ CONFIG_BOOTCOMMAND="test -n \"$qemu_kernel_addr\" && bootm $qemu_kernel_addr - $
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PBSIZE=276
 CONFIG_CMD_REGINFO=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index 9ace68e73f..cf74a48ea2 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -12,8 +12,6 @@ CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 0c7389e2f9..aeef2f35b0 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -13,8 +13,6 @@ CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index e63d6fd934..db9c971c2f 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -19,8 +19,6 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
 # CONFIG_CMD_MII is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index 9a8bbef192..9fb40b22f9 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -12,8 +12,6 @@ CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 1d0f021ade..e3b123ca4d 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -15,8 +15,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index b048bb8aed..d6bf3130fe 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -18,8 +18,6 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SYS_CBSIZE=256
-CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
 # CONFIG_CMD_MII is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index f02e9125a6..2ff49fbd6a 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -46,7 +46,6 @@ CONFIG_SPL_NET=y
 CONFIG_SPL_PCI=y
 CONFIG_SPL_PCH=y
 CONFIG_SPL_RTC=y
-CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 4b2787d4aa..246ac6b6b8 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -24,7 +24,6 @@ CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
-CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5fdf496a45..c010c25a92 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -27,8 +27,6 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index 1347b86f34..9cc1f5f7c4 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -28,8 +28,6 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=532
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.40.1

