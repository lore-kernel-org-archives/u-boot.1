Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B71C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD6B8858C;
	Sat,  4 May 2024 21:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gyNcDMLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C12D884F6; Sat,  4 May 2024 21:45:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4753188586
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851919; bh=K8vAUcdbcYQS2TmMKI7OGHeLaV+EJGGLlQLUA1uhLmI=;
 b=gyNcDMLfvI6YD2A2cO2Han5NHnttp+ho9Zhy119Rbk4uPDz2ORlu/jF/YRTb49iGWoT1XN+YE
 eqxFzVfVmy849alY6eQgiD4D/lrze4B0X5xKYEOFBPFEogw6nmWkyNLQprSTI1KNPwF/uL1lCTx
 67sALitbR5q+FTzZsqKCHiNC9fxGWq8YnZjYsfT3lJxKWE7Kg3GAmY6rkFI4z8Mu4WupNKlcIam
 b88/5OpTf9LD2aP+mO/M1svGc2rW4lkjDuTT1GDYjERkjWYQG6q+q17Y0WYIduFNQ0NnfJdERtU
 bTlSG1iffIHD8LAiNxat+2eGIU5AybbuHEsoEx/YizAA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>, Jonas Karlman <jonas@kwiboo.se>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, John Clark <inindev@gmail.com>, Jagan Teki
 <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Eugen Hristev
 <eugen.hristev@collabora.com>, Elon Zhang <zhangzj@rock-chips.com>, Joshua
 Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH 15/16] rockchip: rk3588: Migrate to OF_UPSTREAM
Date: Sat,  4 May 2024 19:43:07 +0000
Message-ID: <20240504194346.2462489-16-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 6636904b2b8e4dad13276e7b
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

Migrate RK3588 boards that exists in Linux v6.8 to use OF_UPSTREAM.

Following targets is not migrated to use OF_UPSTREAM:
- generic-rk3588: Generic target only meant for U-Boot use
- toybrick-rk3588: Merged in v6.9-rc1

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile                    | 17 -----------------
 arch/arm/mach-rockchip/Kconfig           |  1 +
 configs/coolpi-4b-rk3588s_defconfig      |  2 +-
 configs/coolpi-cm5-evb-rk3588_defconfig  |  2 +-
 configs/evb-rk3588_defconfig             |  2 +-
 configs/generic-rk3588_defconfig         |  1 +
 configs/jaguar-rk3588_defconfig          |  2 +-
 configs/nanopc-t6-rk3588_defconfig       |  2 +-
 configs/neu6a-io-rk3588_defconfig        |  2 +-
 configs/neu6b-io-rk3588_defconfig        |  2 +-
 configs/orangepi-5-plus-rk3588_defconfig |  2 +-
 configs/orangepi-5-rk3588s_defconfig     |  2 +-
 configs/quartzpro64-rk3588_defconfig     |  2 +-
 configs/rock5a-rk3588s_defconfig         |  2 +-
 configs/rock5b-rk3588_defconfig          |  2 +-
 configs/toybrick-rk3588_defconfig        |  1 +
 configs/turing-rk1-rk3588_defconfig      |  2 +-
 17 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1dfcc05a14be..3bbdbd21e394 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -98,23 +98,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) += \
 	rk3368-geekbox.dtb \
 	rk3368-px5-evb.dtb \
 
-dtb-$(CONFIG_ROCKCHIP_RK3588) += \
-	rk3588s-coolpi-4b.dtb \
-	rk3588-coolpi-cm5-evb.dtb \
-	rk3588-edgeble-neu6a-io.dtb \
-	rk3588-edgeble-neu6b-io.dtb \
-	rk3588-evb1-v10.dtb \
-	rk3588-generic.dtb \
-	rk3588-jaguar.dtb \
-	rk3588-nanopc-t6.dtb \
-	rk3588s-orangepi-5.dtb \
-	rk3588-orangepi-5-plus.dtb \
-	rk3588-quartzpro64.dtb \
-	rk3588s-rock-5a.dtb \
-	rk3588-rock-5b.dtb \
-	rk3588-toybrick-x0.dtb \
-	rk3588-turing-rk1.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RV1108) += \
 	rv1108-elgin-r1.dtb \
 	rv1108-evb.dtb
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 03f6bf43fdf4..0b9098426420 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -355,6 +355,7 @@ config ROCKCHIP_RK3588
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply OF_UPSTREAM
 	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index 2608bb67679b..3d45d939abb2 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588s-coolpi-4b"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-coolpi-4b"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index c5bb7a429574..5190d69c1c58 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-coolpi-cm5-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-coolpi-cm5-evb"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index a8c32c4fcf4a..1d5585677a46 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-evb1-v10"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-evb1-v10"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_EVB_RK3588=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 87a171701e42..42bc2c9a7656 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_NET is not set
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index f29505ea150b..b69cf4cd057a 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_ENV_SIZE=0x1f000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-jaguar"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-jaguar"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
 CONFIG_SPL_SERIAL=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 738dda026b01..926267f93ad5 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-nanopc-t6"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-nanopc-t6"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 56198556affc..ac281e65392c 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-edgeble-neu6a-io"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-edgeble-neu6a-io"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_RK3588_NEU6=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index 40baec319c9e..c01e5fb0d044 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-edgeble-neu6b-io"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-edgeble-neu6b-io"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_RK3588_NEU6=y
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index ba8005363ad0..138a633f320e 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-orangepi-5-plus"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-orangepi-5-plus"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index d61f85aaa8c6..33529d4cac31 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588s-orangepi-5"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-orangepi-5"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index 33cbda88285f..06c5cff3ca55 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-quartzpro64"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-quartzpro64"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZPRO64_RK3588=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 01df911d9dc8..c09e6655f021 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5a"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ROCK5A_RK3588=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 9e14b14af7c6..fc118cea7bae 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-rock-5b"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-rock-5b"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 76bfa50c306c..5a190357e454 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -31,6 +31,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 038b14769e50..05ef5bf571c6 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-turing-rk1"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
-- 
2.43.2

