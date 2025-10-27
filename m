Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0E8CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95B683849;
	Mon, 27 Oct 2025 14:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="neH/m8X/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6038E836C8; Mon, 27 Oct 2025 14:00:15 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B51836C8
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD0Bnt1283663;
 Mon, 27 Oct 2025 08:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570011;
 bh=iiWugIdkjRQHvac0ILG6PETpICznqsxZn0YgqkjgbUQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=neH/m8X/FdXuKGCWdrwPuoUnmQZDOkdXpVgtTlM7/+bW++4lG7nawLnsAt/VRtrl9
 BexbcxqxIY+U77HFkjvD9ug95ndNkxy8vu2iSrhOKcQjweGxKvbJtL5Dk874rTsQTl
 xJTmstBP9N5wn4Vn3V9V6uYTQDS6lUmYCACTVjLE=
Received: from DLEE215.ent.ti.com (dlee215.ent.ti.com [157.170.170.118])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD0BrA993325
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:11 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:10 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD09Z4680141;
 Mon, 27 Oct 2025 08:00:10 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 2/8] configs: add falcon mode fragment for k3 devices
Date: Mon, 27 Oct 2025 18:29:57 +0530
Message-ID: <20251027130004.2156121-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027130004.2156121-1-anshuld@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
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

This fragment enables falcon boot for K3 platforms and modifies the
memory map.

To have enough stack and heap space for loading kernel image as
FIT the memory map was modified by expanding stack + heap size, the
PRELOADED_BL33_BASE in TFA has to also be updated to 0x82000000 since
the kernel requires to be loaded at 2MiB aligned address along with
updating K3_HW_CONFIG_BASE to 0x88000000 for the DT passed to kernel.

Modified memory map for R5 SPL (modified addresses marked with *):

0x80000000 +-------------------------------+ Start of DDR
  512KiB   |   TFA reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR*
0x80080000 +-------------------------------+
 31.5MiB   |            Unused             |
0x82000000 +-------------------------------+ PRELOADED_BL33_BASE* in TFA
           |                               | CONFIG_SYS_LOAD_ADDR*
   57MiB   |   Kernel + initramfs Image    | CONFIG_SPL_LOAD_FIT_ADDRESS*
           |                               |
0x85900000 +-------------------------------+
           |                               |
           |  R5 U-Boot SPL Stack + Heap   |
   39MiB   |       (size defined by        |
           |SPL_STACK_R_MALLOC_SIMPLE_LEN*)|
           |                               |
0x88000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR*
           |                               | K3_HW_CONFIG_BASE* in TFA
   16MiB   |          Kernel DTB           | CONFIG_SPL_PAYLOAD_ARGS_ADDR*
           |                               |
0x89000000 +-------------------------------+
  331MiB   | Device Manager (DM) Load Addr |
0x9db00000 +-------------------------------+
   12MiB   |          DM Reserved          |
0x9e700000 +-------------------------------+
    1MiB   |            Unused             |
0x9e800000 +-------------------------------+ BL32_BASE in TFA
   24MiB   |             OPTEE             |
0xa0000000 +-------------------------------+ End of DDR (512MiB)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/k3_r5_falcon.config | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 configs/k3_r5_falcon.config

diff --git a/configs/k3_r5_falcon.config b/configs/k3_r5_falcon.config
new file mode 100644
index 00000000000..9ceda7ce963
--- /dev/null
+++ b/configs/k3_r5_falcon.config
@@ -0,0 +1,39 @@
+# Enable falcon mode
+CONFIG_SPL_OS_BOOT=y
+CONFIG_SPL_OS_BOOT_SECURE=y
+CONFIG_SPL_LOAD_FIT=y
+
+# We use envs for setting bootargs
+CONFIG_SPL_ENV_SUPPORT=y
+
+# Allows for the SPL to detect UUID for kernel's rootfs
+CONFIG_SPL_PARTITION_UUIDS=y
+
+# Perform FDT fixups from SPL
+CONFIG_OF_SYSTEM_SETUP=y
+
+# Disable all non MMC/SD FS boot media to save space
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
+CONFIG_SPL_YMODEM_SUPPORT=n
+CONFIG_SUPPORT_EMMC_BOOT=n
+CONFIG_SPL_NAND_SUPPORT=n
+CONFIG_SPL_NOR_SUPPORT=n
+CONFIG_SPL_RAM_SUPPORT=n
+
+# Used as the 2MiB aligned load address for kernel
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0x88000000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x88000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2700000
+
+# We use the rootfs (i.e partition 2) for booting which is ext4 not FAT
+CONFIG_SYS_MMCSD_FS_BOOT=y
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_SPL_FS_EXT4=y
+CONFIG_SPL_FS_FAT=n
+
+# Loading tifalcon instead of tispl which has FDT and A53 SPL saves time
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="boot/tifalcon.bin"
+CONFIG_SPL_FS_LOAD_KERNEL_NAME="boot/fitImage"
-- 
2.51.0

