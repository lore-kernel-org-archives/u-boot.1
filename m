Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970E7C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8F482D05;
	Wed, 16 Apr 2025 09:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tf3Jmlhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4620482DB0; Wed, 16 Apr 2025 09:46:42 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130CF82D4E
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kcve2706388
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744789598;
 bh=H7TQgCjiFaHod+YQK2PZhfORR4/EZ/K21D4CGDhcttU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tf3JmlhkmMjvcBCd9aj7CyHyuXdYV19dJHtSshS5nwfP4S2tbNqhMiZU34b1Zmx0P
 Uevo9sfNFlQd1POSwiJV1X82SnKoQU1gM53NQQNgdrvr8b22l29L5I5F664X9csyIg
 goP483RHAB8vz7SQVepZ1ypOwOfAA+r8DDpuLF9Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kcTh093198
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:46:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:46:38 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7kbw7069903;
 Wed, 16 Apr 2025 02:46:37 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v4 5/8] config: add falcon boot config fragment for am62x
Date: Wed, 16 Apr 2025 13:15:11 +0530
Message-ID: <20250416074515.1452854-6-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416074515.1452854-1-anshuld@ti.com>
References: <20250416074515.1452854-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This fragment enables falcon boot for the am62x, 62a and 62p.

To have enough stack and heap space for loading kernel image as FIT, the
memory map was modified as shown below, the PRELOADED_BL33_BASE in ATF
has to also be updated to 0x80200000 since the kernel requires to be
loaded at 2MiB aligned address.

Memory Map (changed addresses marked with *):

0x80000000 +-------------------------------+ Start of DDR
  512KiB   |   ATF reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR
0x80080000 +-------------------------------+
  1.5MiB   |            Unused             |
0x80200000 +-------------------------------+ splashimage
   30MiB   |           BMP Image           |
0x82000000 +-------------------------------+ K3_HW_CONFIG_BASE in ATF
           |                               | CONFIG_SPL_PAYLOAD_ARGS_ADDR*
    2MiB   |          Kernel DTB           |
           |                               |
0x82200000 +-------------------------------+ PRELOADED_BL33_BASE* in ATF
           |                               | CONFIG_SYS_LOAD_ADDR*
   55MiB   |   Kernel + initramfs Image    | CONFIG_SPL_LOAD_FIT_ADDRESS*
           |                               |
0x85900000 +-------------------------------+
           |                               |
           |  R5 U-Boot SPL Stack + Heap   |
   55MiB   |       (size defined by        |
           | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
           |                               |
0x89000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR*
  331MiB   | Device Manager (DM) Load Addr |
0x9db00000 +-------------------------------+
   12MiB   |          DM Reserved          |
0x9e700000 +-------------------------------+
    1MiB   |            Unused             |
0x9e800000 +-------------------------------+ BL32_BASE in ATF
   24MiB   |             OPTEE             |
0xa0000000 +-------------------------------+ End of DDR (512MiB)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/am62x_r5_falcon.config | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 configs/am62x_r5_falcon.config

diff --git a/configs/am62x_r5_falcon.config b/configs/am62x_r5_falcon.config
new file mode 100644
index 00000000000..9788dd96a73
--- /dev/null
+++ b/configs/am62x_r5_falcon.config
@@ -0,0 +1,42 @@
+# Enable falcon mode
+CONFIG_SPL_OS_BOOT=y
+
+# We use envs for setting bootargs and optionally for `falcon_(image|args)_file`
+CONFIG_SPL_ENV_SUPPORT=y
+
+# Perform FDT fixups from SPL
+CONFIG_OF_SYSTEM_SETUP=y
+
+# Enabling this causes issues with EMMC FS boot,
+# When enabled the SPL tries to detect FS on boot[01] hw partition which fails
+# since we need the raw tiboot3.bin there for the board to boot instead
+CONFIG_SUPPORT_EMMC_BOOT=n
+
+# Used as the 2MiB aligned load address for kernel
+CONFIG_SYS_LOAD_ADDR=0x82200000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82200000
+CONFIG_SPL_STACK_R_ADDR=0x89000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x3700000
+CONFIG_SYS_BOOTM_LEN=0x1e00000
+
+# We use the rootfs (i.e partition 2) for booting which is ext4 not FAT
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_SPL_FS_EXT4=y
+CONFIG_SPL_FS_FAT=n
+
+# Loading tispl_falcon instead of tispl which has fdt and A53 spl saves time
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="boot/tispl_falcon.bin"
+CONFIG_SPL_FS_LOAD_KERNEL_NAME="boot/Image"
+
+# Disabled to save space on the spl
+CONFIG_TI_K3_NAVSS_UDMA=n
+
+# During SPI boot, kernel and args are loaded from the eMMC or SD and not SPI,
+# therefore we don't actually make use of these config values.
+CONFIG_SYS_SPI_KERNEL_OFFS=0
+CONFIG_SYS_SPI_ARGS_OFFS=0
+CONFIG_SYS_SPI_ARGS_SIZE=0
+
+# Allow R5 to load the 64-bit linux kernel image
+CONFIG_SPL_BOOTI=y
+CONFIG_SPL_BOOTZ=n
-- 
2.49.0

