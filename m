Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98033CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6221837E4;
	Fri, 24 Oct 2025 10:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eDl+oFTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9498483631; Fri, 24 Oct 2025 10:33:40 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63150837B6
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8Xa8H721673;
 Fri, 24 Oct 2025 03:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761294816;
 bh=IGEwQPTlYIqAMtRvawlWNrn7zsxCph/iQGJAgVdxQec=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=eDl+oFTfanOO1+aO91o5ji2q4ry/FC+zhMnOVvfRCtdvZXPuvMkWqfnJf0WvhYLZY
 jnuMuP4UpqvGKPa0wzE7fkbe6PWS4WbiUsANz9lSkFV4i2ISSWFe8i+eelm6pH4T79
 xAxR+e0THv+0RPvq/CzulMtFMxjUc3v3mgqcz/SE=
Received: from DFLE213.ent.ti.com (dfle213.ent.ti.com [10.64.6.71])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8XaqB3449995
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:33:36 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:33:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:33:36 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8XYXI059376;
 Fri, 24 Oct 2025 03:33:35 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 24 Oct 2025 14:03:01 +0530
Subject: [PATCH v2 7/8] board: am62x: add env file for AM6254atl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251024-62sip_support-v2-7-23d4948af70c@ti.com>
References: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
In-Reply-To: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761294801; l=2591;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=UaKVzQ+WZIvI2eI4ai5Zs+hM0B75tvT728+PxO7Kfxw=;
 b=FCul5ovyJeFhfgnIeVd44AdkZ2yaf+rqy0Sg7kMrVXZZJN6VyYKiagKTex4/TMVbmq3GrL/SX
 pZh5mrbToa7Bui5m9J8U4ZDCUBo/383lHdbSLXKGjl5bSHWwxOtaIMK
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
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

Add the env file for AM6254atl with the following changes from
am62x.env:

 1. splashimage address updated from 0x80200000 to 0x81a00000
 2. DFU addresses updated to match updated TEXT_BASE for SPL and U-Boot

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am62x/am6254atl.env        | 37 +++++++++++++++++++++++++++++++++++++
 configs/am6254atl_evm_a53_defconfig |  1 +
 configs/am6254atl_evm_r5_defconfig  |  1 +
 3 files changed, 39 insertions(+)

diff --git a/board/ti/am62x/am6254atl.env b/board/ti/am62x/am6254atl.env
new file mode 100644
index 0000000000000000000000000000000000000000..ea5a33d8cc312ca6034062ede4493cfb037469be
--- /dev/null
+++ b/board/ti/am62x/am6254atl.env
@@ -0,0 +1,37 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
+
+
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
+rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot_targets=mmc1 mmc0 usb pxe dhcp
+boot=mmc
+mmcdev=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
+
+splashfile=ti_logo_414x97_32bpp.bmp.gz
+splashimage=0x82180000
+splashpos=m,m
+splashsource=sf
+
+dfu_alt_info_ram=
+	tispl.bin ram 0x82000000 0x200000;
+	u-boot.img ram 0x82f80000 0x400000
+
+#if CONFIG_BOOTMETH_ANDROID
+#include <env/ti/android.env>
+adtb_idx=0
+#endif
diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm_a53_defconfig
index e6602af7acf557ba9155fbc4aa83779463c7aabf..b95158a595f7a0a13946bb8d224769f1ccf1883d 100644
--- a/configs/am6254atl_evm_a53_defconfig
+++ b/configs/am6254atl_evm_a53_defconfig
@@ -12,3 +12,4 @@ CONFIG_SPL_BSS_START_ADDR=0x82c00000
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x82f80000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b00000
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am6254atl-sk"
+CONFIG_ENV_SOURCE_FILE="am6254atl"
diff --git a/configs/am6254atl_evm_r5_defconfig b/configs/am6254atl_evm_r5_defconfig
index 852c3cfd144166dd2d4db4098c8e204358ac1536..5c94666859421231a88b0d4f80e80685ce6c31cf 100644
--- a/configs/am6254atl_evm_r5_defconfig
+++ b/configs/am6254atl_evm_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_R5_EVM=y
+CONFIG_ENV_SOURCE_FILE="am6254atl"
 CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
 CONFIG_DEFAULT_DEVICE_TREE="k3-am6254atl-r5-sk"

-- 
2.51.0

