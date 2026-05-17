Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBD1CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EE98468B;
	Sun, 17 May 2026 21:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="hehopAtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFD584659; Sun, 17 May 2026 21:25:13 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E29C8465D
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id AFBF580704;
 Sun, 17 May 2026 22:25:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-II5ULbLN; 
 Sun, 17 May 2026 22:25:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045910; bh=HDOXAVF5+W7tYyNpPq+VSMwDc3bUp7Ikba0qcPdye4Y=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=hehopAtx16ijkRcGxQ9q4dEPwUcKTQb0AGCgTkt8455xevbgPxV4QRZs1uk4sBYSu
 G0DpLnUyoHfFGcKSzXw/VOJ6j24/nYKI9zg1iI1y3GR1k0eacYsVeJz/6RFL5NMXxf
 Je4k90hhpzm8QVx6Qu8Bpq7xcRKu9HS8+CkKne7Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:43 +0300
Subject: [PATCH RFC 17/18] rockchip: rk356x-generic: Initialize SDRAM at
 TPL stage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-17-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

Only LPDDR4 initialization is confirmed to be working for now.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 arch/arm/mach-rockchip/Kconfig        | 28 +++++++++++++++++++++++++++-
 arch/arm/mach-rockchip/rk3568/Kconfig | 16 ++++++++++++++++
 common/spl/Kconfig.tpl                |  1 +
 configs/generic-rk3568_defconfig      |  1 +
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 108713488af..9a6a580025e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -413,11 +413,15 @@ config ROCKCHIP_RK3528
 config ROCKCHIP_RK3568
 	bool "Support Rockchip RK3568"
 	select ARM64
+	select SUPPORT_TPL
+	select TPL_HAVE_INIT_STACK if TPL
+	select TPL_ROCKCHIP_BACK_TO_BROM if TPL
 	select SUPPORT_SPL
 	select SPL
 	select CLK
 	select PINCTRL
 	select RAM
+	select ROCKCHIP_SDRAM_COMMON
 	select REGMAP
 	select SYSCON
 	select BOARD_LATE_INIT
@@ -433,10 +437,32 @@ config ROCKCHIP_RK3568
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
-	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
+	imply ROCKCHIP_SERIAL if !ROCKCHIP_EXTERNAL_TPL
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
+	imply TPL if !ROCKCHIP_EXTERNAL_TPL
+	imply TPL_CLK
+	imply TPL_DM
+	imply TPL_LIBCOMMON_SUPPORT
+	imply TPL_LIBGENERIC_SUPPORT
+	imply TPL_OF_CONTROL
+	imply TPL_OF_PLATDATA
+	imply TPL_RAM
+	imply TPL_ROCKCHIP_COMMON_BOARD
+	imply TPL_SERIAL
+	imply TPL_SYSCON
+	imply SPL_CLK
+	imply SPL_DM
+	imply SPL_DRIVERS_MISC
+	imply SPL_LIBCOMMON_SUPPORT
+	imply SPL_LIBGENERIC_SUPPORT
+	imply SPL_OF_CONTROL
+	imply SPL_RAM
+	imply SPL_REGMAP
+	imply SPL_ROCKCHIP_COMMON_BOARD
+	imply SPL_SERIAL
+	imply SPL_SYSCON
 	help
 	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
 	  including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 2730220a18e..893185291d8 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -61,6 +61,10 @@ config TARGET_ORANGEPI_3B_RK3566
 
 endchoice
 
+config SOC_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select HAS_CUSTOM_SYS_INIT_SP_ADDR
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0xfdc20200
 
@@ -70,6 +74,18 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3568"
 
+config TPL_LDSCRIPT
+	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
+
+config TPL_STACK
+	default 0xfdcd8000
+
+config TPL_SYS_MALLOC_F_LEN
+	default 0x2000
+
+config TPL_TEXT_BASE
+	default 0xfdcc1000
+
 source "board/rockchip/evb_rk3568/Kconfig"
 source "board/anbernic/rgxx3_rk3566/Kconfig"
 source "board/hardkernel/odroid_m1/Kconfig"
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd3..e64316b8eb3 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -127,6 +127,7 @@ config TPL_TEXT_BASE
 config TPL_MAX_SIZE
 	hex "Maximum size (in bytes) for the TPL stage"
 	default 0x2e000 if ROCKCHIP_RK3399
+	default 0xe800 if ROCKCHIP_RK3568
 	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
 	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
 	default 0x2800 if ROCKCHIP_PX30
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index a33c3af9255..4510fa94775 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -81,3 +81,4 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
+CONFIG_RAM_ROCKCHIP_LPDDR4=y

-- 
2.25.1

