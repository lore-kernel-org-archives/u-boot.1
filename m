Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC86EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85978021D;
	Fri, 13 Dec 2024 00:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Fo4EgAmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8CE8025C; Fri, 13 Dec 2024 00:58:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8277980214
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047885; bh=ePmrX4yVi4UjqikJfbQdXxTDYboqNmqJBylfqu4e3nw=;
 b=Fo4EgAmygNWUc/q/IQ21FyAfnP06JtmOUp1hPZ7hSLoAtk7e3ER+SJoErd94L85uQ84pti3KT
 PYphfZBhY1gqVtRfRNd8MGlnvYL9LnOEanRjlonXNfy5iFk0mU/JO5pMeCk7HHn7+CBPFIBAz0u
 TEojJNMSddEQ3oQFK9hiUkZ6fPTBTlu/nbNpwBV9/lq2ms0+09hWq5c0K3mlBZ3UsPl7k2ZRn57
 1tOhvT5Q5aH1slkqVhHk8lKOj0IdmORBHs1kMreU3Y/M2PSVlG0Zyb2lC7YFTt0z/inB4GvtMBb
 v1+D+bdN5yE/Y5/CyD93XpfuqWxlcpqrVmKxPSig89Mw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/12] rockchip: rk3399-gru: Use TPL with common bss and stack
 addresses
Date: Thu, 12 Dec 2024 23:57:12 +0000
Message-ID: <20241212235735.164272-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b788ba511ed8f0b3fe2ad
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

Migrate to use TPL, common bss, stack and malloc heap size and addresses
to unify memory use in TPL, SPL and pre-reloc with other RK3399 boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/chromebook_bob_defconfig   | 13 +------------
 configs/chromebook_kevin_defconfig | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 69a07ef7e01e..f13c4c1e7d63 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -3,26 +3,15 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-bob"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
-CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
 # CONFIG_SPL_MMC is not set
-CONFIG_SPL_STACK=0xff8effff
-CONFIG_SPL_TEXT_BASE=0xff8c2000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xff1a0000
@@ -42,10 +31,10 @@ CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index d689eeaf2781..7a2b8e70fe69 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -3,27 +3,16 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-kevin"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
-CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
 # CONFIG_SPL_MMC is not set
 CONFIG_TARGET_CHROMEBOOK_KEVIN=y
-CONFIG_SPL_STACK=0xff8effff
-CONFIG_SPL_TEXT_BASE=0xff8c2000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xff1a0000
@@ -43,10 +32,10 @@ CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
-- 
2.47.1

