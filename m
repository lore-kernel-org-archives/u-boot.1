Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FAAC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4EA8838B;
	Sat,  4 May 2024 21:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EGhYiHMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2EC884CD; Sat,  4 May 2024 21:44:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD9C88274
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851841; bh=pSsTpBYbjZF0+k1PZtHSn9HPdBOBEkCWiS4kQzKtBsI=;
 b=EGhYiHMx25aCmH9YHQtVWPIoI2fYewUckWQXJPJcOe4YS9DgEI13j+QWu3ZznA8bU+8LlZneX
 UmXkn1+XH9SI6pJeim/8GpZq1hmqbSpK6CH5VxDS0RPwmqE7ksstByVbxbgTTOMjb+WE4RrVBcI
 mvh5+JH0wXCqnODGxHK7YXWnP4BIJNrdtc55mXEQSb3blvB+tK6NWqyofiSlxfoDW/6LTcyrJIv
 t5jiY45vPi6jYwvMx+dhZxEqNw4bCz0CAcaqTUCBF+FoD6sLVuovResdADvHuLAtRLzdMGN8Ip+
 7EttG879WVe/vZywUc0lSaNGV743pLt5JXGLxDQaa+sw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 01/16] rockchip: rk3308: Migrate to OF_UPSTREAM
Date: Sat,  4 May 2024 19:42:53 +0000
Message-ID: <20240504194346.2462489-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240504194346.2462489-1-jonas@kwiboo.se>
References: <20240504194346.2462489-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66368ffe2b8e4dad13276d5a
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

All RK3308 boards has now been synced to Linux kernel v6.8 DTs and can
migrate to use OF_UPSTREAM.

Migrate all RK3308 boards to use OF_UPSTREAM.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile              | 5 -----
 arch/arm/mach-rockchip/Kconfig     | 1 +
 configs/evb-rk3308_defconfig       | 2 +-
 configs/roc-cc-rk3308_defconfig    | 2 +-
 configs/rock-pi-s-rk3308_defconfig | 2 +-
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index c9f1b25ad647..319ec23a4fee 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -92,11 +92,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3288) += \
 	rk3288-veyron-speedy.dtb \
 	rk3288-vyasa.dtb
 
-dtb-$(CONFIG_ROCKCHIP_RK3308) += \
-	rk3308-evb.dtb \
-	rk3308-roc-cc.dtb \
-	rk3308-rock-pi-s.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RK3328) += \
 	rk3328-evb.dtb \
 	rk3328-nanopi-r2c.dtb \
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 262cb7cba3ea..f1caf4f3738b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -166,6 +166,7 @@ config ROCKCHIP_RK3308
 	imply LEGACY_IMAGE_FORMAT
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_UPSTREAM
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index 04a94e13a68a..f4c2ea12adaa 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3308-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-evb"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index ef58bd657532..862ea4301f25 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3308-roc-cc"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-roc-cc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 37a124eae181..c15ba3d8a451 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-pi-s"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
-- 
2.43.2

