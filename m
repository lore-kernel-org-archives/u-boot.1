Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C46C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B74982BB5;
	Tue,  3 Jun 2025 16:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Nl7vvxfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8923B82B26; Tue,  3 Jun 2025 16:25:39 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ED381E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 553EPZPu3536182;
 Tue, 3 Jun 2025 09:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748960735;
 bh=jem43yQie0OegRmvzugR3Ep/hz1PE6vhGgolVWZOWrs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Nl7vvxfGbNp158BhwOlYMSkaK1AlrVcw1uivgLXjuytWEZHNyqEnXz9xpKN0+bbF5
 7kBgLIv9y9AErhmbPIDShdk5ui2eZFqBYsdGF80uRzYdfalKDDSQ5mQ5+c9QdJO8YK
 TCNZgeGEVtG0dsFmjIhD3vGEw7Mnb09X0cnnCaUU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 553EPZYG3585457
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 09:25:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 09:25:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 09:25:35 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 553EPYJM559451;
 Tue, 3 Jun 2025 09:25:35 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v7 06/10] config: add falcon boot config fragment for am62x
Date: Tue, 3 Jun 2025 19:54:46 +0530
Message-ID: <20250603142452.2707171-7-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603142452.2707171-1-anshuld@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
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

