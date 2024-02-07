Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDB1C48297
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 00:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B680F87CAA;
	Wed,  7 Feb 2024 01:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ayzgkfnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78D683414; Wed,  7 Feb 2024 01:15:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F7487C93
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 01:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707264886; bh=ww/wBcSm8F4ejapL2E43AeDBCpwN69l0R8f48DtOmGs=;
 b=ayzgkfnX+euFE2A2XZk5M1uhwPOnmVAcUOsdkF7F1YM0O9SWQYFFyTITHgAaEay/qqiaU5W+B
 kw5Eiw1d2TRl366J+XJDJXtq4JX9ZGkF+oC09jD3cgDfsBXc+v4egYTihTLPkF5nrKFbPyu2xNK
 VYHMc0zok/p/+7qoGICaC/aGj6R1UzoTDuejkCNDfK1zgcXM/kU2k1zrlP4lOgPZofTHdbvHDE2
 x5VkfU5tw5uTGRlSEJYasIlKlzLyZJeOdrgL9CIfcdpW8OIxEIxTz22EKx+MP+XjDQWzre2t4wz
 Y3mGqHir5bBl1fVVgPvhOQOyIP13zsHpUzeRKJiMgIpA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 14/15] rockchip: rk3328-rock64: Enable boot from SPI NOR flash
Date: Wed,  7 Feb 2024 00:02:43 +0000
Message-ID: <20240207000301.3270722-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c2c8ebd5b31093c56fc003
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

Add Kconfig options to enable support for booting from SPI NOR flash on
Pine64 Rock64.

The generated bootable u-boot-rockchip-spi.bin that can be written to
0x0 of SPI NOR flash. The FIT image is loaded from 0x60000, same as on
RK35xx boards.

  => sf probe
  SF: Detected gd25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB

  => load mmc 1:1 10000000 u-boot-rockchip-spi.bin
  1359872 bytes read in 65 ms (20 MiB/s)

  => sf update $fileaddr 0 $filesize
  device 0 offset 0x0, size 0x14c000
  1118208 bytes written, 241664 bytes skipped in 8.516s, speed 163516 B/s

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/rock64-rk3328_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 0157a1efe374..01e447448513 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
@@ -20,6 +21,8 @@ CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
@@ -42,6 +45,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
@@ -76,7 +81,10 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.43.0

