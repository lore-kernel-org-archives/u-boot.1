Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D07CCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C058004F;
	Wed, 29 Oct 2025 12:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8334882E34; Wed, 29 Oct 2025 12:34:43 +0100 (CET)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943DA8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxQBn2P67zfg3;
 Wed, 29 Oct 2025 12:34:41 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxQBm1MtnzKkP; Wed, 29 Oct 2025 12:34:40 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:34:25 +0100
Subject: [PATCH] rockchip: imply most symbols for ARCH_ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-arch-rockchip-imply-v1-1-899e1592a736@cherry.de>
X-B4-Tracking: v=1; b=H4sIAMD7AWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3cSi5Azdovzk7OSMzALdzNyCnErdlGSjRAsT40RDczNzJaDOgqL
 UtMwKsKnRsbW1ACDDcXllAAAA
X-Change-ID: 20251029-arch-rockchip-imply-dc2a843a1767
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Forcing all those symbols on means we cannot make the binary smaller or
with unnecessary features or drivers disabled. This is especially useful
for security, auditing and certification where less code built means
less to look at (and less surface attack) and less to patch, but also
for making binary images smaller which typically means faster boot.

It is possible to have boards without MMC, NAND or SPI flashes, without
anything on SPI or I2C buses, nothing to control over PWM or GPIO or for
which we have no interest in regulator control or serial output so make
it possible to remove all that if desired.

No intended change in default selected symbols.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ef834542bd4..4ee74d5cdd8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2072,30 +2072,30 @@ config ARCH_ROCKCHIP
 	bool "Support Rockchip SoCs"
 	select BINMAN if SPL_OPTEE || SPL
 	select DM
-	select DM_GPIO
-	select DM_I2C
-	select DM_PWM
-	select DM_REGULATOR
-	select DM_SERIAL
-	select DM_SPI
-	select DM_SPI_FLASH
 	select DM_USB_GADGET if USB_DWC3_GADGET
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select OF_CONTROL
-	select MMC
-	select MTD
-	select SPI
 	select SPL_DM if SPL
-	select SPL_DM_SPI if SPL
-	select SPL_DM_SPI_FLASH if SPL
 	select SYS_MALLOC_F
 	select SYS_THUMB_BUILD if !ARM64
 	imply ADC
+	imply BOOTSTD_DEFAULTS
 	imply CMD_DM
 	imply DEBUG_UART_BOARD_INIT
-	imply BOOTSTD_DEFAULTS
+	imply DM_GPIO
+	imply DM_I2C
+	imply DM_PWM
+	imply DM_REGULATOR
+	imply DM_SERIAL
+	imply DM_SPI
+	imply DM_SPI_FLASH
 	imply FAT_WRITE
+	imply MMC
+	imply MTD
 	imply SARADC_ROCKCHIP
+	imply SPI
+	imply SPL_DM_SPI if SPL
+	imply SPL_DM_SPI_FLASH if SPL
 	imply SPL_SYSRESET
 	imply SPL_SYS_MALLOC_SIMPLE
 	imply SYS_NS16550

---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-arch-rockchip-imply-dc2a843a1767

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

