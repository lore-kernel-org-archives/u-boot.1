Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01AFC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA2782B17;
	Mon, 28 Apr 2025 16:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D9+T9JqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC0282B12; Mon, 28 Apr 2025 16:13:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E6982A5E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SED6En3569406
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 09:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745849586;
 bh=jem43yQie0OegRmvzugR3Ep/hz1PE6vhGgolVWZOWrs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=D9+T9JqO6aO07QD0DgWjy5PrHY1KQiQtH0nUDDL0o2s1omc5JYq+wI4iM8bDCvJlo
 L4nWeIVVnghufxvrrluuEeKiLXduN1Uzun8J6ChGOR1wmFmwXqClzmDqunmEtKj6NY
 f6vnCuCR9aBxNpoNtdks7fWmXele3/SCSeMV5V9c=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SED64D010009
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Apr 2025 09:13:06 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 09:13:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 09:13:06 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SED5qk045155;
 Mon, 28 Apr 2025 09:13:05 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v6 5/9] config: add falcon boot config fragment for am62x
Date: Mon, 28 Apr 2025 19:42:27 +0530
Message-ID: <20250428141235.1734014-6-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428141235.1734014-1-anshuld@ti.com>
References: <20250428141235.1734014-1-anshuld@ti.com>
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

To have enough stack and heap space for loading kernel image as
FIT the memory map was modified by expanding stack + heap size, the
PRELOADED_BL33_BASE in ATF has to also be updated to 0x82000000 since
the kernel requires to be loaded at 2MiB aligned address along with
change changing K3_HW_CONFIG_BASE to 0x88000000 for the DT passed to
kernel.

Modified memory map for R5 SPL (modified addresses marked with *):

0x80000000 +-------------------------------+ Start of DDR
  512KiB   |   ATF reserved memory space   | CONFIG_K3_ATF_LOAD_ADDR*
0x80080000 +-------------------------------+
 31.5MiB   |            Unused             |
0x82000000 +-------------------------------+ PRELOADED_BL33_BASE* in ATF
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
           |                               | K3_HW_CONFIG_BASE* in ATF
   16MiB   |          Kernel DTB           | CONFIG_SPL_PAYLOAD_ARGS_ADDR*
           |                               |
0x89000000 +-------------------------------+
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
 configs/am62x_r5_falcon.config | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 configs/am62x_r5_falcon.config

diff --git a/configs/am62x_r5_falcon.config b/configs/am62x_r5_falcon.config
new file mode 100644
index 00000000000..c9bb8d68505
--- /dev/null
+++ b/configs/am62x_r5_falcon.config
@@ -0,0 +1,38 @@
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
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x88000000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0x88000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2700000
+
+# We use the rootfs (i.e partition 2) for booting which is ext4 not FAT
+CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
+CONFIG_SPL_FS_EXT4=y
+CONFIG_SPL_FS_FAT=n
+
+# Loading tispl_falcon instead of tispl which has fdt and A53 spl saves time
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="boot/tispl_falcon.bin"
+CONFIG_SPL_FS_LOAD_KERNEL_NAME="boot/fitImage"
+
+# Disabled to save space on the spl
+CONFIG_TI_K3_NAVSS_UDMA=n
+
+# During SPI boot, kernel and args are loaded from the eMMC or SD and not SPI,
+# therefore we don't actually make use of these config values.
+CONFIG_SYS_SPI_KERNEL_OFFS=0
+CONFIG_SYS_SPI_ARGS_OFFS=0
+CONFIG_SYS_SPI_ARGS_SIZE=0
-- 
2.49.0

