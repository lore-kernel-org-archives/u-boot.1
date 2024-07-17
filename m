Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5447DC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 04:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0736885B5;
	Wed, 17 Jul 2024 06:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63AF88729; Wed, 17 Jul 2024 06:47:52 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E566688464
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 06:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 46H4lao9020657; Wed, 17 Jul 2024 13:47:39 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 andy.yan@rock-chips.com, gajjar04akash@gmail.com, jonas@kwiboo.se,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v3 3/3] configs: rockchip: imply OF_LIBFDT_OVERLAY for rk3308
 and rk3328
Date: Wed, 17 Jul 2024 13:47:26 +0900
Message-ID: <20240717044726.59721-3-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717044726.59721-1-naoki@radxa.com>
References: <20240717044726.59721-1-naoki@radxa.com>
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

for rk3308, all defconfigs have CONFIG_OF_LIBFDT_OVERLAY=y, so enable it
by default.

for rk3328, any defconfig doesn't have it. but there is no strong reason
not to enable it. at least it's required for ROCK Pi E.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
Changes in v3:
- add missing separator in commit message
Changes in v2:
- none
---
 arch/arm/mach-rockchip/Kconfig     | 2 ++
 configs/evb-rk3308_defconfig       | 1 -
 configs/roc-cc-rk3308_defconfig    | 1 -
 configs/rock-pi-s-rk3308_defconfig | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 661e7fd1c9..5f6a4dd24a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -166,6 +166,7 @@ config ROCKCHIP_RK3308
 	imply LEGACY_IMAGE_FORMAT
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_LIBFDT_OVERLAY
 	imply OF_UPSTREAM
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
@@ -196,6 +197,7 @@ config ROCKCHIP_RK3328
 	imply ARMV8_SET_SMPEN
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_LIBFDT_OVERLAY
 	imply OF_LIVE
 	imply OF_UPSTREAM
 	imply PRE_CONSOLE_BUFFER
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index f4c2ea12ad..6d090dba30 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-evb"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_EVB_RK3308=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 862ea4301f..b1b59d9cb5 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-roc-cc"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_ROC_RK3308_CC=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index c15ba3d8a4..e450a06180 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-pi-s"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_TARGET_EVB_RK3308=y
-- 
2.43.0

