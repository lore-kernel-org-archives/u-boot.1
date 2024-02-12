Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF802C4829A
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 01:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69E887C48;
	Mon, 12 Feb 2024 02:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GVKAh9oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B3287C63; Mon, 12 Feb 2024 02:32:03 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE984878A1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 02:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b753=JV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707701479; bh=Sx8npdhumRT+FfGqAjvG1KgORi73ZDj0tkm73carqzE=;
 b=GVKAh9ohaQDnE2aI1aIJ9o9OAeAnG0mP8MVxx3MeVsaEsVeC4R5xrn77Vl14juBMrxceoLnIG
 Uu7J80L9SslO33T1MBKwU0Cqc1S9JH5jFKqpuam1rqdOv7ax+21onDHrlxxUfwbjvrBdfkSBICK
 wvTBpSBYlX2kbaQryRpjR0hTTnppPlflbT920ul7jnwUU2PWAZwHoZtdZzOLBz3ZxFC5OfjNVOg
 JngMwkkS63sfKRx29v++ZjhMxTX9giz2nCZD1Zrjx2ewOf9qFTVJHiAkVIhbTy08rja7wQ+lFv4
 Ww6PSEaqWWSo+8KIxbZl/qs0wJGVE1QSAr6a852bKaww==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Nick Xie <nick@khadas.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Suniel
 Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
Date: Mon, 12 Feb 2024 00:59:07 +0000
Message-ID: <20240212005914.3512640-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65c96d755425f2fb50c1afff
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

With the stack and text base used by U-Boot SPL and proper on RK3399
there is a high likelihood of overlapping when U-Boot proper + FDT nears
1 MiB in size.

Currently the following memory layout is used:
- 0x00000000 (@0 MiB): U-Boot SPL text base
- 0x00040000 (@256 KiB): TF-A
- 0x00200000 (@2 MiB): U-Boot proper text base
- 0x00300000 (@3 MiB): U-Boot proper init stack
- 0x00400000 (@4 MiB): U-Boot SPL init stack
- 0x00400000 (@4 MiB): U-Boot SPL bss
- 0x02000000 (@64 MiB): U-Boot SPL reloc stack
- 0x08400000 (@132 MiB): optional OPTEE

SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
However, the initial stack used by U-Boot proper is limiting the size
of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).

Instead change to use the following memory layout:
- 0x00000000 (@0 MiB): U-Boot SPL text base
- 0x00040000 (@256 KiB): TF-A
- 0x00200000 (@2 MiB): U-Boot proper text base
- 0x00400000 (@4 MiB): U-Boot SPL init stack
- 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
- 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
- 0x04000000 (@64 MiB): U-Boot SPL reloc stack
- 0x08400000 (@132 MiB): optional OPTEE

This should leave room for loading and running a U-Boot proper close
to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.

With the moved SPL reloc stack it is also possible to use a much larger
malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/chromebook_bob_defconfig             | 2 +-
 configs/chromebook_kevin_defconfig           | 2 +-
 configs/eaidk-610-rk3399_defconfig           | 4 ++--
 configs/evb-rk3399_defconfig                 | 4 ++--
 configs/ficus-rk3399_defconfig               | 2 +-
 configs/firefly-rk3399_defconfig             | 4 ++--
 configs/khadas-edge-captain-rk3399_defconfig | 4 ++--
 configs/khadas-edge-rk3399_defconfig         | 4 ++--
 configs/khadas-edge-v-rk3399_defconfig       | 4 ++--
 configs/leez-rk3399_defconfig                | 4 ++--
 configs/nanopc-t4-rk3399_defconfig           | 4 ++--
 configs/nanopi-m4-2gb-rk3399_defconfig       | 4 ++--
 configs/nanopi-m4-rk3399_defconfig           | 4 ++--
 configs/nanopi-m4b-rk3399_defconfig          | 4 ++--
 configs/nanopi-neo4-rk3399_defconfig         | 4 ++--
 configs/nanopi-r4s-rk3399_defconfig          | 4 ++--
 configs/orangepi-rk3399_defconfig            | 4 ++--
 configs/pinebook-pro-rk3399_defconfig        | 4 ++--
 configs/pinephone-pro-rk3399_defconfig       | 4 ++--
 configs/puma-rk3399_defconfig                | 2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig    | 4 ++--
 configs/roc-pc-rk3399_defconfig              | 4 ++--
 configs/rock-4c-plus-rk3399_defconfig        | 4 ++--
 configs/rock-4se-rk3399_defconfig            | 4 ++--
 configs/rock-pi-4-rk3399_defconfig           | 4 ++--
 configs/rock-pi-4c-rk3399_defconfig          | 4 ++--
 configs/rock-pi-n10-rk3399pro_defconfig      | 4 ++--
 configs/rock960-rk3399_defconfig             | 4 ++--
 configs/rockpro64-rk3399_defconfig           | 4 ++--
 29 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index bffa0d33b75c..1fffc8b9e273 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-gru-bob"
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index e14fc358c504..c9ffd3d60dd3 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-gru-kevin"
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 22ad98b95ad3..d6ba6f74b5b5 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-eaidk-610"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index 698991e51bde..29ee9d229f7d 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-evb"
@@ -22,7 +22,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index d214f635dc65..edd111e08675 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index b01b1a327896..100bf88d3a99 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-firefly"
@@ -23,7 +23,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 9d59d28164d6..99856789aa36 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge-captain"
 CONFIG_ROCKCHIP_RK3399=y
@@ -21,7 +21,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 9de8a53c1aea..68cd642ced25 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge"
 CONFIG_ROCKCHIP_RK3399=y
@@ -21,7 +21,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index 72e1653ed151..1f9eef1d379e 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge-v"
 CONFIG_ROCKCHIP_RK3399=y
@@ -21,7 +21,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 76dd91911c7c..f6958c96f8be 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-leez-p710"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index c18e7b1bd169..04ff74202d6a 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopc-t4"
 CONFIG_DM_RESET=y
@@ -22,7 +22,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index e3bdbccccbec..f06e8c9b77c3 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4-2gb"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index e51e51c8cf5c..355054a17e93 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index ca57c7f81a51..7e6278c2854f 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4b"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 02e7f4e2ecb7..11cdc8381ce4 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-neo4"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 80c05d04005b..9d0075a9da1c 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index 27add8a29b92..64da9312a4a4 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-orangepi"
 CONFIG_ROCKCHIP_RK3399=y
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index 6b83daf07945..3d787d0c79ad 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
@@ -29,7 +29,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 96316c4b303f..e185e11243e2 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
@@ -28,7 +28,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index f39d352c7890..ec5ef89fcf42 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0x3F8000
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 64103eada8cf..423d11d2945f 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_ENV_SECT_SIZE=0x1000
@@ -29,7 +29,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 61991e8868b3..bfb786ef937b 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
@@ -30,7 +30,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 86a64d191e13..93b92efcdf0e 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -24,7 +24,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index e3a2d5eeb180..21a48a1bebb8 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -26,7 +26,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 7986e07ee108..2a6ebed4b617 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -26,7 +26,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index f96f24a150c0..89641e8d6122 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -24,7 +24,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 9a8beaa81ddf..31f3623bea0b 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399pro-rock-pi-n10"
 CONFIG_DM_RESET=y
@@ -25,7 +25,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index 80b41b061bdb..03cf74cfbf56 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock960"
 CONFIG_DM_RESET=y
@@ -23,7 +23,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index c37d858c2c66..e67a5ccba940 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
@@ -31,7 +31,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_START_ADDR=0x2000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

