Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B284FE68949
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 03:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB8F8920A;
	Thu, 31 Oct 2024 04:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA7E8920A; Thu, 31 Oct 2024 04:23:14 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA6F8920A
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 04:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 49V3Mn31014266; Thu, 31 Oct 2024 12:22:49 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@linaro.org, jonas@kwiboo.se, kever.yang@rock-chips.com,
 macromorgan@hotmail.com, quentin.schulz@cherry.de,
 o451686892@gmail.com, sebastian.reichel@collabora.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/3] configs: rockchip: enable RK806 SPI PMIC for Radxa ROCK 5A
Date: Thu, 31 Oct 2024 03:22:43 +0000
Message-ID: <20241031032245.32749-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

enable RK806 SPI PMIC driver and related cmd/configs for Radxa ROCK 5A.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 configs/rock5a-rk3588s_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 9618d590009..d2770198ef2 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -28,6 +28,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
@@ -55,11 +56,16 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.43.0

