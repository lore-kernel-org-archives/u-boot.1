Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB813C02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 13:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437868096D;
	Wed, 29 Jan 2025 14:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C62481EDD; Wed, 29 Jan 2025 14:26:03 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B2E807E5
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 14:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 50TDPec3011059; Wed, 29 Jan 2025 22:25:44 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 quentin.schulz@cherry.de, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, greg.malysa@timesys.com, bb@ti.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 2/3] rockchip: Fix SPL link error for Radxa ROCK Pi 4
Date: Wed, 29 Jan 2025 13:25:28 +0000
Message-ID: <20250129132529.807031-2-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129132529.807031-1-naoki@radxa.com>
References: <20250129132529.807031-1-naoki@radxa.com>
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

If CONFIG_EFI_CAPSULE_FIRMWARE_RAW, CONFIG_SPL_ENV_SUPPORT, and
CONFIG_SPL_DFU are enabled, linking u-boot-spl will fail.

  LD      spl/u-boot-spl
ld.bfd: drivers/dfu/dfu.o: in function `dfu_init_env_entities':
/home/radxa/u-boot/drivers/dfu/dfu.c:173:(.text.dfu_init_env_entities+0x24): undefined reference to `set_dfu_alt_info'

Compile mach-rockchip/board.c for SPL.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/mach-rockchip/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 5e7edc99cdc..e697df7ebcb 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -22,10 +22,10 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 # we can have the preprocessor correctly recognise both 0x0 and 0
 # meaning "turn it off".
 obj-y += boot_mode.o
-obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 endif
 
 ifeq ($(CONFIG_TPL_BUILD),)
+obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
 
-- 
2.43.0

