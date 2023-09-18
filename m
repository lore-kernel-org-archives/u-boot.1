Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6250C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 12:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868018695F;
	Mon, 18 Sep 2023 14:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94EE86967; Mon, 18 Sep 2023 14:12:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F258690B
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 14:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38ICCaik050577;
 Mon, 18 Sep 2023 20:12:36 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 18 Sep 2023 20:12:32 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH V2 2/3] configs: andes: rearrange SPL mode memory layout
Date: Mon, 18 Sep 2023 20:11:35 +0800
Message-ID: <20230918121136.2295900-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918121136.2295900-1-randolph@andestech.com>
References: <20230918121136.2295900-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38ICCaik050577
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

Unify the memory layout for u-boot SPL mode
Add "CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS"

Signed-off-by: Randolph <randolph@andestech.com>
---
 configs/ae350_rv32_spl_defconfig     | 7 ++++---
 configs/ae350_rv32_spl_xip_defconfig | 5 +++--
 configs/ae350_rv64_spl_defconfig     | 7 ++++---
 configs/ae350_rv64_spl_xip_defconfig | 5 +++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 4adc1134ba..b28a0a84fb 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -8,14 +8,14 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x00200000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
@@ -23,9 +23,10 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index e19eb546a6..5e8f1b3631 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -9,7 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
@@ -24,9 +24,10 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 629c5bab77..1592ec811a 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -7,7 +7,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
@@ -15,7 +15,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x00200000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
@@ -23,9 +23,10 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 4557e05445..97f961b6c9 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SYS_PROMPT="RISC-V # "
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
@@ -24,9 +24,10 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
-- 
2.34.1

