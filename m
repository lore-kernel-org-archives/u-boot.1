Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD503C4829A
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 01:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4ECD87C7F;
	Mon, 12 Feb 2024 02:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QIkXCAF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B7A87811; Mon, 12 Feb 2024 01:59:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8AF87C94
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 01:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b753=JV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707699569; bh=2QTzHw5y1bslsK+SOdW+2e1w+YKEliuFSd+DduR9imI=;
 b=QIkXCAF82XMgKFK+1LeHFOmx3vd5nG6bk2bHaxzbndqsJpmrZVfOEuNJq9x859/WJg5IOQ9si
 /vGh5+lCb0h1PigelhawGA4m63/tsgjg+LqsInPwtB+4dkFTX+BVcvwrHcfqVAFRTakEbMhsZxY
 Q3Lpe/MXrQ/G3uhiAR/1Ptc7CfZmOe707qmGZPrvNiht2tO/Jip3WUT9s0sA+i1N8Hehyq0t17s
 c0afaucWdoOXNP80tQ9NoIjINgV7WuIdLtN68sbUqkC0XQeka+HD9+Ytawlt0j4Wn3n0ccICjNj
 dJscOHcjMD71w3yfRaW5fUkIZQgDlf9TswmkGQd57OXA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Jonas
 Karlman <jonas@kwiboo.se>, Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] rockchip: rk3328: Update stack addresses
Date: Mon, 12 Feb 2024 00:59:06 +0000
Message-ID: <20240212005914.3512640-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212005914.3512640-1-jonas@kwiboo.se>
References: <20240212005914.3512640-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65c96d6d5425f2fb50c1aff1
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

With the stack and text base used by U-Boot SPL and proper on RK3328
there is a high likelihood of overlapping when U-Boot proper + FDT nears
1 MiB in size.

Currently the following memory layout is used:
- 0x00000000 (@0 MiB): U-Boot SPL text base
- 0x00040000 (@256 KiB): TF-A
- 0x00200000 (@2 MiB): U-Boot proper text base
- 0x00300000 (@3 MiB): U-Boot proper init stack
- 0x00400000 (@4 MiB): U-Boot SPL init stack
- 0x00600000 (@6 MiB): U-Boot SPL reloc stack
- 0x02000000 (@32 MiB): U-Boot SPL bss
- 0x08400000 (@132 MiB): optional OPTEE

SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
relocated, meaning that there is room for close to 4 MiB (@2-6 MiB).
However, the initial stack used by U-Boot proper is limiting the size
of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).

Instead change to use the following memory layout:
- 0x00000000 (@0 MiB): U-Boot SPL text base
- 0x00040000 (@256 KiB): TF-A
- 0x00200000 (@2 MiB): U-Boot proper text base
- 0x00400000 (@4 MiB): U-Boot SPL init stack
- 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
- 0x02000000 (@32 MiB): U-Boot SPL bss
- 0x04000000 (@64 MiB): U-Boot SPL reloc stack (changed)
- 0x08400000 (@132 MiB): optional OPTEE

This should leave room for loading and running a U-Boot proper close
to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.

Also update SYS_MALLOC_F_LEN to use a 16 KiB malloc area running in SPL
pre-reloc and proper pre-reloc stage. Same size that is used on RK3399.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3328/Kconfig         | 2 +-
 configs/evb-rk3328_defconfig                  | 4 +---
 configs/nanopi-r2c-plus-rk3328_defconfig      | 4 ++--
 configs/nanopi-r2c-rk3328_defconfig           | 4 ++--
 configs/nanopi-r2s-rk3328_defconfig           | 4 ++--
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 4 ++--
 configs/orangepi-r1-plus-rk3328_defconfig     | 4 ++--
 configs/roc-cc-rk3328_defconfig               | 4 ++--
 configs/rock-pi-e-rk3328_defconfig            | 4 +---
 configs/rock64-rk3328_defconfig               | 4 ++--
 10 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3328/Kconfig b/arch/arm/mach-rockchip/rk3328/Kconfig
index d5cb649ae6ba..681a1a624da2 100644
--- a/arch/arm/mach-rockchip/rk3328/Kconfig
+++ b/arch/arm/mach-rockchip/rk3328/Kconfig
@@ -22,7 +22,7 @@ config SYS_SOC
 	default "rk3328"
 
 config SYS_MALLOC_F_LEN
-	default 0x2000
+	default 0x4000
 
 config SPL_LIBCOMMON_SUPPORT
 	default y
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index 004cbd33e80a..975ba72a8274 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-evb"
@@ -16,7 +16,6 @@ CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -38,7 +37,6 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index 2f0d253b4b7c..7dfa8686651d 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c-plus"
@@ -15,7 +15,7 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index ca13eb873a72..ba98c152639c 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c"
@@ -15,7 +15,7 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 619707436130..4a8f952d7765 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2s"
@@ -15,7 +15,7 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 8e9a9411a763..537383458981 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus-lts"
@@ -16,7 +16,7 @@ CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index 240fcdeb221f..a0c541e933da 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus"
@@ -16,7 +16,7 @@ CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index f734116f847e..8b122975ea8a 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-roc-cc"
@@ -15,7 +15,7 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index 5ccdc02d4c86..67a5f52f0073 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e"
@@ -18,7 +18,6 @@ CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -40,7 +39,6 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 81284c6697a5..32acd3b29310 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
@@ -16,7 +16,7 @@ CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
-- 
2.43.0

