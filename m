Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BADC48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4DC87E77;
	Sat, 17 Feb 2024 19:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="w5y2xVy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3200187E7B; Sat, 17 Feb 2024 19:37:03 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82F587E78
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708194993; bh=FaS8BA+IqaZf6bDa/FQcBjq6HI+jc9V+qYp2xpu/SSo=;
 b=w5y2xVy12jPXqAEe4AXTD1zknMqKWB7r3dQIAe5hCeNvwFcgjPa/iJhJjgGyyNnC9Z4CcF0Rd
 DBJP99CjAY20Am9jajy90A/QI8Isptn/iBbNYlBnFoiZj6hwyfTUOERsXRyCmO2SnhfCU4U06CY
 Q44hse10Io0cDHjQSX7HWEgwrY+y066nuni4Ir3M5pTvYD+vg6fAOBnQELyTFzb0sY03VNjvtXR
 M5mmuSSDUi+4ZxZ5BjPA414XoXyaQTHisQzLs/3daS2a9uLndGJcDav0HXezTO1WfvG80TMrSXt
 IzImRqo1quSgGIUQYmpDgaDOCMu4RddaLflIb3SCrgsg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH 03/11] board: rockchip: rk3399: Remove unused
 board_early_init_f functions
Date: Sat, 17 Feb 2024 18:35:48 +0000
Message-ID: <20240217183610.2621132-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217183610.2621132-1-jonas@kwiboo.se>
References: <20240217183610.2621132-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d0fcafaf53a5c07f266c84
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

These functions is excluded from SPL build and BOARD_EARLY_INIT_F is not
enabled for any of the affected boards, so this legacy code is not used.

Rockchip common board code already enable all regulators flagged as
always-on or boot-on in device tree, and fixed/gpio regulators now have
basic reference counting support so the original intent of this code is
no longer valid.

Remove the unneeded and unused code that used to enable usb regulators.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   | 22 +------------------
 .../pinebook-pro-rk3399/pinebook-pro-rk3399.c | 22 -------------------
 .../pinephone-pro-rk3399.c                    | 22 -------------------
 board/rockchip/evb_rk3399/evb-rk3399.c        | 20 -----------------
 4 files changed, 1 insertion(+), 85 deletions(-)

diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 93e7d776fb2f..590519b32af2 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -9,32 +9,12 @@
 #include <log.h>
 #include <spl_gpio.h>
 #include <asm/io.h>
-#include <power/regulator.h>
 
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 
-#ifndef CONFIG_SPL_BUILD
-int board_early_init_f(void)
-{
-	struct udevice *regulator;
-	int ret;
-
-	ret = regulator_get_by_platname("vcc5v0_host", &regulator);
-	if (ret) {
-		debug("%s vcc5v0_host init fail! ret %d\n", __func__, ret);
-		goto out;
-	}
-
-	ret = regulator_set_enable(regulator, true);
-	if (ret)
-		debug("%s vcc5v0-host-en set fail! ret %d\n", __func__, ret);
-out:
-	return 0;
-}
-
-#else
+#ifdef CONFIG_SPL_BUILD
 
 #define PMUGRF_BASE	0xff320000
 #define GPIO0_BASE	0xff720000
diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
index 5e758ea6cd92..0001022c62a6 100644
--- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
+++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
@@ -11,32 +11,10 @@
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/printk.h>
-#include <power/regulator.h>
 
 #define GRF_IO_VSEL_BT565_SHIFT 0
 #define PMUGRF_CON0_VSEL_SHIFT 8
 
-#ifndef CONFIG_SPL_BUILD
-int board_early_init_f(void)
-{
-	struct udevice *regulator;
-	int ret;
-
-	ret = regulator_get_by_platname("vcc5v0_usb", &regulator);
-	if (ret) {
-		pr_debug("%s vcc5v0_usb init fail! ret %d\n", __func__, ret);
-		goto out;
-	}
-
-	ret = regulator_set_enable(regulator, true);
-	if (ret)
-		pr_debug("%s vcc5v0-host-en-gpio set fail! ret %d\n", __func__, ret);
-
-out:
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_MISC_INIT_R
 static void setup_iodomain(void)
 {
diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
index c9b0d5a061d6..06dc512c57d8 100644
--- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
+++ b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
@@ -11,33 +11,11 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <power/regulator.h>
 
 #define GRF_IO_VSEL_BT565_GPIO2AB 1
 #define GRF_IO_VSEL_AUDIO_GPIO3D4A 2
 #define PMUGRF_CON0_VSEL_SHIFT 8
 
-#ifndef CONFIG_SPL_BUILD
-int board_early_init_f(void)
-{
-	struct udevice *regulator;
-	int ret;
-
-	ret = regulator_get_by_platname("vcc5v0_usb", &regulator);
-	if (ret) {
-		pr_debug("%s vcc5v0_usb init fail! ret %d\n", __func__, ret);
-		goto out;
-	}
-
-	ret = regulator_set_enable(regulator, true);
-	if (ret)
-		pr_debug("%s vcc5v0-host-en-gpio set fail! ret %d\n", __func__, ret);
-
-out:
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_MISC_INIT_R
 static void setup_iodomain(void)
 {
diff --git a/board/rockchip/evb_rk3399/evb-rk3399.c b/board/rockchip/evb_rk3399/evb-rk3399.c
index 3c773d0930cc..ebdd74a7b97f 100644
--- a/board/rockchip/evb_rk3399/evb-rk3399.c
+++ b/board/rockchip/evb_rk3399/evb-rk3399.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <asm/arch-rockchip/periph.h>
 #include <linux/kernel.h>
-#include <power/regulator.h>
 
 #define ROCKPI4_UPDATABLE_IMAGES	2
 
@@ -25,25 +24,6 @@ struct efi_capsule_update_info update_info = {
 #endif
 
 #ifndef CONFIG_SPL_BUILD
-int board_early_init_f(void)
-{
-	struct udevice *regulator;
-	int ret;
-
-	ret = regulator_get_by_platname("vcc5v0_host", &regulator);
-	if (ret) {
-		debug("%s vcc5v0_host init fail! ret %d\n", __func__, ret);
-		goto out;
-	}
-
-	ret = regulator_set_enable(regulator, true);
-	if (ret)
-		debug("%s vcc5v0-host-en set fail! ret %d\n", __func__, ret);
-
-out:
-	return 0;
-}
-
 #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
 static bool board_is_rockpi_4b(void)
 {
-- 
2.43.0

