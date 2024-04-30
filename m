Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4801FC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F7988A2C;
	Tue, 30 Apr 2024 17:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kmjyee9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F7988A2B; Tue, 30 Apr 2024 17:32:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A0EE887BA
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491081; bh=2ohLkah7BKT5i8mYQ/sayOva6hDLnCSCraMik+fgCO0=;
 b=kmjyee9t980hxx5Y6dPl8+szB+neikFcStlLDiMJWTMts/ah9Y0SI5nCKQ97ZY1eF9DfOuqfa
 k0V4/xCnAIp/V1ANWhGVDASCO36Y4juQKHZ0hvt8XTEBgmM9FC7YjndvPPLFBetGaJs4pxo6s8b
 Cda1hCSxiwcPatZSHqqfb6uftcP1E6x1NLHnxp/BkZrvwnYXliNtUNPsSijTFosB6Wq4PIF8XiY
 Y62PbzHDbchuB0/h6B6w2dB3M/EvVDsXHsSssYjcyfTGSSZZdiuYFfm0ml6a0s292n3uZrixtSx
 QV32hRyIKwwvR1XzLQPdysAQNi/AWVMeJEt3ltxNqsEA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 03/18] rockchip: rk3399-puma: Use common bss and stack
 addresses
Date: Tue, 30 Apr 2024 15:30:10 +0000
Message-ID: <20240430153053.308788-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ec0d99e42224315b7f2
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

The rk3399-puma board is currently using SPL stack and bss addr in SRAM,
the same addr typically used by TPL, this differs from most other RK3399
boards.

Switch to use the common bss and stack addresses introduced in commit
008ba0d56d00 ("rockchip: Add common default bss and stack addresses").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 configs/puma-rk3399_defconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index ec7d52a6e13e..bd4926cf0fce 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -2,11 +2,8 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0x3F8000
@@ -16,12 +13,6 @@ CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_PUMA_RK3399=y
-CONFIG_SPL_STACK=0xff8effff
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
 CONFIG_DEBUG_UART_BASE=0xFF180000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
@@ -33,7 +24,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x38000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
-- 
2.43.2

