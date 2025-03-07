Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2368EC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 07:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6BC81761;
	Fri,  7 Mar 2025 08:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ihdfv96x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298FB817E6; Fri,  7 Mar 2025 08:56:35 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB2E81433
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 08:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uVgo200234
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 01:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741334191;
 bh=u8aAnZ2a5sWjM1Y9RIUshYF30PX0GtYSS2Pz7jWAmEA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ihdfv96x/o4H3v1VMFvFNHUP23WWXJWnS21ZB9Iu27OXmqrGTlnlFh7geqEVnMRFx
 s8cmYs01QH1jIBv3GPh7+PAdvmVT3AVih7d+/QH2aBWKxo2jUInBmNeV/8fH6GIm3r
 HU4oyHfRtpGex5n552GFuujiUKa8WkTizPWQGj2k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uVLw105434
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Mar 2025 01:56:31 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 01:56:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 01:56:30 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5277uUbF086146;
 Fri, 7 Mar 2025 01:56:30 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH 09/10] config: add falcon boot config fragment for am62x
Date: Fri, 7 Mar 2025 13:25:37 +0530
Message-ID: <20250307075541.2571104-10-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307075541.2571104-1-anshuld@ti.com>
References: <20250307075541.2571104-1-anshuld@ti.com>
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
0x80200000 +-------------------------------+ PRELOADED_BL33_BASE* in ATF
           |                               | CONFIG_SYS_LOAD_ADDR* (load
   30MiB   |   Kernel + initramfs Image    | address for kernel)
           |                               |
0x82000000 +-------------------------------+ K3_HW_CONFIG_BASE in ATF
           |                               | CONFIG_SPL_PAYLOAD_ARGS_ADDR*
    1MiB   |          Kernel DTB           |
           |                               |
0x82100000 +-------------------------------+ CONFIG_SPL_LOAD_FIT_ADDRESS*
           |                               |
   55MiB   |Initial Download Region for FIT|
           |                               |
0x85800000 +-------------------------------+
           |                               |
           |  R5 U-Boot SPL Stack + Heap   |
   56MiB   |       (size defined by        |
           | SPL_STACK_R_MALLOC_SIMPLE_LEN)|
           |                               |
0x89000000 +-------------------------------+ CONFIG_SPL_STACK_R_ADDR*
  344MiB   |       Device Manager (DM)     |
0x9e800000 +-------------------------------+ BL32_BASE in ATF
   24MiB   |             OPTEE             |
0xa0000000 +-------------------------------+ End of DDR (512MiB)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/am62x_r5_falcon.config | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 configs/am62x_r5_falcon.config

diff --git a/configs/am62x_r5_falcon.config b/configs/am62x_r5_falcon.config
new file mode 100644
index 00000000000..256c1a260cf
--- /dev/null
+++ b/configs/am62x_r5_falcon.config
@@ -0,0 +1,30 @@
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
+CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82100000
+CONFIG_SPL_STACK_R_ADDR=0x89000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x3800000
+CONFIG_SYS_BOOTM_LEN=0x1e00000
+
+# Loading tispl_falcon instead of tispl which has fdt and A53 spl saves time
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tispl_falcon.bin"
+CONFIG_SPL_FS_LOAD_KERNEL_NAME="Image"
+# We don't use the args file when loading fitImage since it has dtb pre-packaged
+# this is only useful while reading the raw kernel image from FS
+CONFIG_SPL_FS_LOAD_ARGS_NAME="falcon.dtb"
+
+# Disabled to save space on the spl
+CONFIG_SPL_YMODEM_SUPPORT=n
-- 
2.43.0

