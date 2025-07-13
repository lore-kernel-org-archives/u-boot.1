Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF1CC83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA688309D;
	Mon, 14 Jul 2025 01:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PsS8w16C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7478781E06; Mon, 14 Jul 2025 01:35:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C68C82D06
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449728; bh=yhMmjizPRB9rcOEJf2ulpwF7Qb9Mb9zPET4go9P/vW0=;
 b=PsS8w16CHMs77rF6+bYcWcPp4T3IZEuL8JUCy8OEBGdce+QaBHptzIzrN8W5lRtR4YsEDj+DI
 LL5kJQE+RrBKX77tkMFtmhFSO6t7EdNU+xlXGSZ7MMMw78ZNCFuoc2um0izB35r4qkaAp/6k1J1
 c01FBGXljRIKGrIcK8PkMjjBvaaDtbLMewFOpVOXygtxB7t9hyQm4Q1h0P448qMCL8T1b5VA8zk
 GwBxmdLW4l8lBGEfxIH6e+Ny1L5MMhhyfUdJfUkEEk29oVEqB5hqJ/WOSPu4IfJZuUqXZwJx/Pa
 skl1oe8cCrq+zxCIPVA+OuHwCrHED85LVKC8MDBTAspw==
X-Forward-Email-ID: 687442bc5c59ddd2f404ff91
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 13/17] rockchip: odroid-go2: Enable RockUSB, button,
 LED and RNG support
Date: Sun, 13 Jul 2025 23:34:01 +0000
Message-ID: <20250713233429.1376172-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

Enable Kconfig options to support RockUSB, buttons, LEDs and RNG
featured on the board or SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/odroid-go2_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 185d0f1d7c5f..70d74c65a2f3 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SLEEP is not set
@@ -72,12 +73,17 @@ CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_BUF_SIZE=0x04000000
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_PWM=y
+CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
@@ -97,6 +103,8 @@ CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
 CONFIG_ROCKCHIP_SDRAM_COMMON=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 # CONFIG_SPECIFY_CONSOLE_INDEX is not set
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -109,6 +117,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-- 
2.49.0

