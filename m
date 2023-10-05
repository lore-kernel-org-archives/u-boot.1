Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3521FE9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB4F86CCE;
	Thu,  5 Oct 2023 15:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DI7wnu/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8C986CC8; Thu,  5 Oct 2023 15:07:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFE686CE5
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 15:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 904706192B;
 Thu,  5 Oct 2023 13:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B4BC3279E;
 Thu,  5 Oct 2023 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696511216;
 bh=8FL8ELOznQxbTRBUfoIAWBZKSjQ0eCnIPkubm4519JI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DI7wnu/LmGJHUJ4ElFX934rWAdXy/W0BrmtJXbhA32EZ0QEwmpk9dtfkpn3k3ZyHS
 2fCDlxqKomiuEX/QOz+mzD9EIAQo+Ubp79ELMyCcj2dHglfwqTslRXm/P5tjlG9Bls
 hf3q+VZUgQnQlEaR51L6f0rcZt1bzgWEMGjeX6WGoKRueVMC62W1qZyu3/0wB+H0L9
 4ILSfTkpgkFv2wcM63F84FWKwy1wSszlHsx0P3sJYWsApCH4BXUMiZnQWyss3IrtIM
 sgJn6f9xYM+I9eBdwta2nSYPRe6+FqwDgSAXwt9ib/GWyIWNwQTV6o7Z/oZBh36ukm
 RolpBdm+KT8Cw==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
Date: Thu,  5 Oct 2023 16:06:42 +0300
Message-Id: <20231005130642.21402-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005130642.21402-1-rogerq@kernel.org>
References: <20231005130642.21402-1-rogerq@kernel.org>
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

Switch to using bootstd. Note with this change, we will stop using
distro_bootcmd and instead depend entirely on bootflow method of
starting the system up.

Drop header files that are no longer needed in am64x_evm.h.
k3_dfu.h is available via k3_dfu.env in am64x.env.

Drop unused macro CFG_SYS_SDRAM_BASE1.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 board/ti/am64x/am64x.env        | 1 +
 configs/am64x_evm_a53_defconfig | 5 +++--
 include/configs/am64x_evm.h     | 9 ---------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
index 68e42222b7..efd736b99b 100644
--- a/board/ti/am64x/am64x.env
+++ b/board/ti/am64x/am64x.env
@@ -15,6 +15,7 @@ console=ttyS2,115200n8
 args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
+boot_targets=mmc1 mmc0 usb pxe dhcp
 boot=mmc
 mmcdev=1
 bootpart=1:2
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 718ad176cb..43bfcf957a 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -31,8 +31,9 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x180000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
index 062102a610..f9f8c7bc2f 100644
--- a/include/configs/am64x_evm.h
+++ b/include/configs/am64x_evm.h
@@ -9,15 +9,6 @@
 #ifndef __CONFIG_AM642_EVM_H
 #define __CONFIG_AM642_EVM_H
 
-#include <linux/sizes.h>
-#include <config_distro_bootcmd.h>
-#include <env/ti/mmc.h>
-#include <asm/arch/am64_hardware.h>
-#include <env/ti/k3_dfu.h>
-
-/* DDR Configuration */
-#define CFG_SYS_SDRAM_BASE1		0x880000000
-
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.34.1

