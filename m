Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF46C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6766487BBD;
	Wed, 17 Jan 2024 18:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21AE8796A; Wed, 17 Jan 2024 18:24:09 +0100 (CET)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D2887B82
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFXmP2k0FzMqBHx;
 Wed, 17 Jan 2024 17:24:05 +0000 (UTC)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFXmN5Nf1znF1; Wed, 17 Jan 2024 18:24:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: heiko@sntech.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 jonas@kwiboo.se, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 5/6] rockchip: remove unused global data ptr
Date: Wed, 17 Jan 2024 18:22:59 +0100
Message-ID: <20240117-rk3588-spl-boot-dev-v3-5-72cb989e6da8@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Remove leftover import and global data ptr from files since they aren't
used anymore.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/board.c         | 3 ---
 arch/arm/mach-rockchip/rk3128/rk3128.c | 3 ---
 arch/arm/mach-rockchip/rk3308/rk3308.c | 3 ---
 arch/arm/mach-rockchip/rk3328/rk3328.c | 3 ---
 arch/arm/mach-rockchip/rk3368/rk3368.c | 3 ---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 3 ---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 2 --
 7 files changed, 20 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 57f08e0be0e..6a9d297e6ff 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -16,7 +16,6 @@
 #include <syscon.h>
 #include <uuid.h>
 #include <asm/cache.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/boot_mode.h>
 #include <asm/arch-rockchip/clock.h>
@@ -24,8 +23,6 @@
 #include <asm/arch-rockchip/misc.h>
 #include <power/regulator.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
 
 #define DFU_ALT_BUF_LEN			SZ_1K
diff --git a/arch/arm/mach-rockchip/rk3128/rk3128.c b/arch/arm/mach-rockchip/rk3128/rk3128.c
index 01dbfa75cb2..8f8f4951bae 100644
--- a/arch/arm/mach-rockchip/rk3128/rk3128.c
+++ b/arch/arm/mach-rockchip/rk3128/rk3128.c
@@ -4,9 +4,6 @@
  */
 #include <common.h>
 #include <init.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 int arch_cpu_init(void)
 {
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 5763604dc3e..6f121bf1304 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -5,7 +5,6 @@
 #include <common.h>
 #include <init.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/grf_rk3308.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -14,8 +13,6 @@
 #include <debug_uart.h>
 #include <linux/bitops.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #include <asm/armv8/mmu.h>
 static struct mm_region rk3308_mem_map[] = {
 	{
diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index de17b886827..02821c9e51d 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -10,11 +10,8 @@
 #include <asm/arch-rockchip/grf_rk3328.h>
 #include <asm/arch-rockchip/uart.h>
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define CRU_BASE		0xFF440000
 #define GRF_BASE		0xFF100000
 #define UART2_BASE		0xFF130000
diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c b/arch/arm/mach-rockchip/rk3368/rk3368.c
index d0a6107e5e0..d009b8758e5 100644
--- a/arch/arm/mach-rockchip/rk3368/rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
@@ -18,8 +17,6 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define IMEM_BASE                  0xFF8C0000
 
 /* Max MCU's SRAM value is 8K, begin at (IMEM_BASE + 4K) */
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 801a4a6662e..a1aa0e3e8b5 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -11,7 +11,6 @@
 #include <spl_gpio.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
@@ -23,8 +22,6 @@
 #include <linux/printk.h>
 #include <power/regulator.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define GRF_EMMCCORE_CON11 0xff77f02c
 #define GRF_BASE	0xff770000
 
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index b1f535fad50..00e3da40d9a 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -12,8 +12,6 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/ioc_rk3588.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define FIREWALL_DDR_BASE		0xfe030000
 #define FW_DDR_MST5_REG			0x54
 #define FW_DDR_MST13_REG		0x74

-- 
2.43.0

