Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEE7CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 10:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7229D836F0;
	Wed, 22 Oct 2025 12:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e69BSq73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CDE836A3; Wed, 22 Oct 2025 12:26:29 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFAEF836AC
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 12:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MAQPwt1381936;
 Wed, 22 Oct 2025 05:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761128785;
 bh=EXYPPnrhD4x71mSxEVN4BF80zLeBQi3q0eVLWIz0CJs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=e69BSq73VitpFvpyHjZ+SjgFKXpMpfTG0r2tBE5M7KuyFu0fugIMUcLi7suhKwEed
 54WfjwBAw5hZE7lk3LcHO3zDWU7RYMQPQ6h9kSX0RMwXxk0dFZDCH4ubz4kdGV5GLP
 2IGDVSkqW3K2vJAk3suKsG5SCGve9kQ9u3YLGHyo=
Received: from DLEE206.ent.ti.com (dlee206.ent.ti.com [157.170.170.90])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MAQOKG1948719
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 05:26:24 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:26:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:26:24 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MAQN4I1048706;
 Wed, 22 Oct 2025 05:26:24 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 22 Oct 2025 15:55:43 +0530
Subject: [PATCH 7/8] board: am62x: add env file for am6254atl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251022-62sip_support-v1-7-eed08d15e76d@ti.com>
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
In-Reply-To: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761128770; l=2620;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=qVk4k/hoj3ZdGZnIonFEJ64qx7VYXsr+Gc2A+iPsFtk=;
 b=rpUxrCF5bm7FtAb9tSWThJQ9EFTmge8Po4iknWc7qfP9iti8wgB+io1eYpbduMJJ0YuXVUDFx
 JpG2VRMMzfJD1ntfAyT5Cl+jkg3xeTpKE1mjo7MCT0Xh/ZY5Q+sYnmt
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

Add the env file for am6254atl with the following changes from
am62x.env:

1. splashimage address updated from 0x80200000 to 0x81a00000
2. DFU addresses updated to reflect updated TEXT_BASE for spl and u-boot

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am62x/am6254atl.env        | 37 +++++++++++++++++++++++++++++++++++++
 configs/am6254atl_evm_a53_defconfig |  1 +
 configs/am6254atl_evm_r5_defconfig  |  1 +
 3 files changed, 39 insertions(+)

diff --git a/board/ti/am62x/am6254atl.env b/board/ti/am62x/am6254atl.env
new file mode 100644
index 0000000000000000000000000000000000000000..e2b0b102bfe12dba38271d42d54962849cff21d1
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
\ No newline at end of file
diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm_a53_defconfig
index fdf6be7068e7b2fe4e48f1f322703f6838729497..58ef0a43b11a49ba661c970faee43725794ec4ca 100644
--- a/configs/am6254atl_evm_a53_defconfig
+++ b/configs/am6254atl_evm_a53_defconfig
@@ -13,3 +13,4 @@ CONFIG_SPL_BSS_START_ADDR=0x82c00000
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

