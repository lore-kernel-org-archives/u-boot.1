Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF194CD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0947284A4C;
	Sun, 10 May 2026 02:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="o6SK5sdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F406C84ACF; Sun, 10 May 2026 02:07:45 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CACD84AC7
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36536771300so2997967a91.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371659; x=1778976459;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a7x43Pm1VTfak07bo6lia4gVdffg9Zxi08jHOGZPEr4=;
 b=o6SK5sdE2KVEVhV5KthsTjhhIaA8/D2jsp6B4JrH8G6WpvtQ4noLpvx7B6jXiHxldB
 JiGN+vty2ukN7evHE2GMOp2JS7Gb8KxqFdAD7e32eJhe1bcHyuZ3oneVl3t4PnJ7r4qN
 mNl+MY1XQqHa7rGPBRVHZtuF4vbW+AQwA3XDOLo+1JMhNFY4X0alIoVYhZc7x9bEWsRl
 Bm9C1mjkSPkLLeLBqAH1ynw2v2e/gDWX/1GU2L0skVLpz6yc+3Q3spXoKyq1QyfdcMsO
 L1Hek09x3ZA5ic0t7jZyinpSTlBWx7qagi5RWxY/5bVR/Q/Gfe7ZNhG9qZV4RyvhsYdF
 mwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371659; x=1778976459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a7x43Pm1VTfak07bo6lia4gVdffg9Zxi08jHOGZPEr4=;
 b=m0Bs2/dJ2lp28Q9RrnxcsjWdtqfVvhpq7PLXnMff+fEQtfir0Eib9U1hUkSxcZEfG6
 h3uUxTWoqF+/S/DC4m7Tfe18m51d8298BTOgN49ykFzFOUTV4Gg+5Gm4XINxG+lFyxXh
 RcX82h3AifqBJbEV0yyrWBMSjkZfzuGQ8MCvphpP7xXpnrrej/F3SV2xHkqYFL9J9qCE
 cDzR3WzITZBPpbcj2WdyrUJbu6Oqhl4SRcfaaDRRciLLbTF49hekKOTAXtWOC50RIYdZ
 wbHRWEU2qjSrcgIjIleq89ldSooVuUGOS5j+8LHe5/rPsSCOTj1E3x/CS4MFcPIQFlM/
 NjIA==
X-Gm-Message-State: AOJu0YwGx0XhxuolKvKavcF62k3hnQSV2iwr1hB6erZ0Ll+a0jbUD2Ka
 qK5g4vYlUwANpbUNJW1uv/jmUOoKmj8vCK2OyRZsYj3Tcd+kvKH/aZa3gfeeS/g/BKc=
X-Gm-Gg: Acq92OFJ3TW/DCNsgCRbRh4P4ZCs2YtSlHOe3B4PCTDudY+6flNI84785cEy51yA2Np
 afMa5JPn6BSvcFVGtbAvIySdpPzXOy+dAzbhfTVBT9T9hcFK4cZ0IZrudPv5X4oSeaKWP53FyjL
 qRtFtcnxO21ajZmXZrucW162ohlXHba5kVSw9khuvmkCACyIHXRlSSZiAVzammsWZt72cNlyiFO
 0wiuzl/2E9KRvL336Pf4EVac1aPF7OUSk6Y/aJR2yM2lClGOWxvRldwQUlBxmsshU0Qqzq3NoNx
 o/44Rjqg3d0EEfSqxMOCYBFvNo61RU1Jn8+6xcSQttwnomycVcJEzIjFQAo8eVFh3CWtT/40zKW
 c529K93VereOU3sFecRDDiCqMrKPD8VMJ0AfkiU3QY9/AQ8iK4dEEnkeuhp18kH6W2cTAr6kzbx
 WfSjS+oc+uoTE/pXjTu6CxEjvGsw/yDxgJ8dK9pjM+6jI=
X-Received: by 2002:a17:903:3904:b0:2ae:47b0:dc80 with SMTP id
 d9443c01a7336-2babcaad261mr116630965ad.11.1778371658673; 
 Sat, 09 May 2026 17:07:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:07:38 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 10 May 2026 08:06:29 -0400
Subject: [PATCH 7/8] reset: spacemit: k1: drop legacy spacemit,k1-reset driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-7-db0b0503ee44@riscstar.com>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

After the K1 build switched to dts/upstream/src/riscv/spacemit/ and the
local arch/riscv/dts/k1.dtsi was deleted, the legacy
reset-controller@d4050000 DT node no longer exists. The of_match driver
in drivers/reset/reset-spacemit-k1.c (compatible "spacemit,k1-reset")
matches nothing and only sits in the binary as dead code.

Remove the legacy driver file, its Makefile entry, the RESET_SPACEMIT_K1
Kconfig symbol, and its bananapi-f3_defconfig selection. The new
syscon-bound reset driver under drivers/reset/spacemit/ has no
DT of_match of its own and is spawned by the K1 clock drivers, so gate
the subdirectory on CONFIG_CLK_SPACEMIT_K1 instead.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 configs/bananapi-f3_defconfig     |   1 -
 drivers/reset/Kconfig             |   7 -
 drivers/reset/Makefile            |   3 +-
 drivers/reset/reset-spacemit-k1.c | 548 --------------------------------------
 4 files changed, 1 insertion(+), 558 deletions(-)

diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index b9a2ee19f53..adecbee10f2 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -22,6 +22,5 @@ CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-CONFIG_RESET_SPACEMIT_K1=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2fd91d6299c..7af309945fe 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -246,12 +246,5 @@ config RESET_RZG2L_USBPHY_CTRL
 	  RZ/G2L SoC. This is required for USB 2.0 functionality to work on this
 	  SoC.
 
-config RESET_SPACEMIT_K1
-	bool "Support for SPACEMIT's K1 Reset driver"
-	depends on DM_RESET
-	help
-	  Support for SPACEMIT's K1 Reset system. Basic Assert/Deassert
-	  is supported.
-
 source "drivers/reset/stm32/Kconfig"
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 10e1460ee34..170446f9a7e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -34,8 +34,7 @@ obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
-obj-$(CONFIG_RESET_SPACEMIT_K1) += reset-spacemit-k1.o
-obj-$(CONFIG_RESET_SPACEMIT_K1) += spacemit/
+obj-$(CONFIG_CLK_SPACEMIT_K1) += spacemit/
 
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
diff --git a/drivers/reset/reset-spacemit-k1.c b/drivers/reset/reset-spacemit-k1.c
deleted file mode 100644
index 613e002fc4f..00000000000
--- a/drivers/reset/reset-spacemit-k1.c
+++ /dev/null
@@ -1,548 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2022 Spacemit Inc.
- * Copyright (C) 2025 Huan Zhou <pericycle.cc@gmail.com>
- */
-
-#include <asm/io.h>
-#include <config.h>
-#include <dm.h>
-#include <dm/device_compat.h>
-#include <dm/device-internal.h>
-#include <dm/lists.h>
-#include <dt-bindings/reset/spacemit-k1-reset.h>
-#include <linux/bitops.h>
-#include <reset-uclass.h>
-
-/* APBC register offset */
-#define APBC_UART1_CLK_RST      0x0
-#define APBC_UART2_CLK_RST      0x4
-#define APBC_GPIO_CLK_RST       0x8
-#define APBC_PWM0_CLK_RST       0xc
-#define APBC_PWM1_CLK_RST       0x10
-#define APBC_PWM2_CLK_RST       0x14
-#define APBC_PWM3_CLK_RST       0x18
-#define APBC_TWSI8_CLK_RST      0x20
-#define APBC_UART3_CLK_RST      0x24
-#define APBC_RTC_CLK_RST        0x28
-#define APBC_TWSI0_CLK_RST      0x2c
-#define APBC_TWSI1_CLK_RST      0x30
-#define APBC_TIMERS1_CLK_RST    0x34
-#define APBC_TWSI2_CLK_RST      0x38
-#define APBC_AIB_CLK_RST        0x3c
-#define APBC_TWSI4_CLK_RST      0x40
-#define APBC_TIMERS2_CLK_RST    0x44
-#define APBC_ONEWIRE_CLK_RST    0x48
-#define APBC_TWSI5_CLK_RST      0x4c
-#define APBC_DRO_CLK_RST        0x58
-#define APBC_IR_CLK_RST         0x5c
-#define APBC_TWSI6_CLK_RST      0x60
-#define APBC_TWSI7_CLK_RST      0x68
-#define APBC_TSEN_CLK_RST       0x6c
-
-#define APBC_UART4_CLK_RST      0x70
-#define APBC_UART5_CLK_RST      0x74
-#define APBC_UART6_CLK_RST      0x78
-#define APBC_SSP3_CLK_RST       0x7c
-
-#define APBC_SSPA0_CLK_RST      0x80
-#define APBC_SSPA1_CLK_RST      0x84
-
-#define APBC_IPC_AP2AUD_CLK_RST 0x90
-#define APBC_UART7_CLK_RST      0x94
-#define APBC_UART8_CLK_RST      0x98
-#define APBC_UART9_CLK_RST      0x9c
-
-#define APBC_CAN0_CLK_RST       0xa0
-#define APBC_PWM4_CLK_RST       0xa8
-#define APBC_PWM5_CLK_RST       0xac
-#define APBC_PWM6_CLK_RST       0xb0
-#define APBC_PWM7_CLK_RST       0xb4
-#define APBC_PWM8_CLK_RST       0xb8
-#define APBC_PWM9_CLK_RST       0xbc
-#define APBC_PWM10_CLK_RST      0xc0
-#define APBC_PWM11_CLK_RST      0xc4
-#define APBC_PWM12_CLK_RST      0xc8
-#define APBC_PWM13_CLK_RST      0xcc
-#define APBC_PWM14_CLK_RST      0xd0
-#define APBC_PWM15_CLK_RST      0xd4
-#define APBC_PWM16_CLK_RST      0xd8
-#define APBC_PWM17_CLK_RST      0xdc
-#define APBC_PWM18_CLK_RST      0xe0
-#define APBC_PWM19_CLK_RST      0xe4
-/* end of APBC register offset */
-
-/* MPMU register offset */
-#define MPMU_WDTPCR     0x200
-/* end of MPMU register offset */
-
-/* APMU register offset */
-#define APMU_JPG_CLK_RES_CTRL       0x20
-#define APMU_CSI_CCIC2_CLK_RES_CTRL 0x24
-#define APMU_ISP_CLK_RES_CTRL       0x38
-#define APMU_LCD_CLK_RES_CTRL1      0x44
-#define APMU_LCD_SPI_CLK_RES_CTRL   0x48
-#define APMU_LCD_CLK_RES_CTRL2      0x4c
-#define APMU_CCIC_CLK_RES_CTRL      0x50
-#define APMU_SDH0_CLK_RES_CTRL      0x54
-#define APMU_SDH1_CLK_RES_CTRL      0x58
-#define APMU_USB_CLK_RES_CTRL       0x5c
-#define APMU_QSPI_CLK_RES_CTRL      0x60
-#define APMU_USB_CLK_RES_CTRL       0x5c
-#define APMU_DMA_CLK_RES_CTRL       0x64
-#define APMU_AES_CLK_RES_CTRL       0x68
-#define APMU_VPU_CLK_RES_CTRL       0xa4
-#define APMU_GPU_CLK_RES_CTRL       0xcc
-#define APMU_SDH2_CLK_RES_CTRL      0xe0
-#define APMU_PMUA_MC_CTRL           0xe8
-#define APMU_PMU_CC2_AP             0x100
-#define APMU_PMUA_EM_CLK_RES_CTRL   0x104
-
-#define APMU_AUDIO_CLK_RES_CTRL     0x14c
-#define APMU_HDMI_CLK_RES_CTRL      0x1B8
-
-#define APMU_PCIE_CLK_RES_CTRL_0    0x3cc
-#define APMU_PCIE_CLK_RES_CTRL_1    0x3d4
-#define APMU_PCIE_CLK_RES_CTRL_2    0x3dc
-
-#define APMU_EMAC0_CLK_RES_CTRL     0x3e4
-#define APMU_EMAC1_CLK_RES_CTRL     0x3ec
-/* end of APMU register offset */
-
-/* APBC2 register offset */
-#define APBC2_UART1_CLK_RST		0x00
-#define APBC2_SSP2_CLK_RST		0x04
-#define APBC2_TWSI3_CLK_RST		0x08
-#define APBC2_RTC_CLK_RST		0x0c
-#define APBC2_TIMERS0_CLK_RST	0x10
-#define APBC2_KPC_CLK_RST		0x14
-#define APBC2_GPIO_CLK_RST		0x1c
-/* end of APBC2 register offset */
-
-enum spacemit_reset_base_type {
-	RST_BASE_TYPE_MPMU       = 0,
-	RST_BASE_TYPE_APMU       = 1,
-	RST_BASE_TYPE_APBC       = 2,
-	RST_BASE_TYPE_APBS       = 3,
-	RST_BASE_TYPE_CIU        = 4,
-	RST_BASE_TYPE_DCIU       = 5,
-	RST_BASE_TYPE_DDRC       = 6,
-	RST_BASE_TYPE_AUDC       = 7,
-	RST_BASE_TYPE_APBC2      = 8,
-};
-
-struct spacemit_reset_signal {
-	u32 offset;
-	u32 mask;
-	u32 deassert_val;
-	u32 assert_val;
-	enum spacemit_reset_base_type type;
-};
-
-struct spacemit_reset_base {
-	void __iomem *mpmu_base;
-	void __iomem *apmu_base;
-	void __iomem *apbc_base;
-	void __iomem *apbs_base;
-	void __iomem *ciu_base;
-	void __iomem *dciu_base;
-	void __iomem *ddrc_base;
-	void __iomem *audio_ctrl_base;
-	void __iomem *apbc2_base;
-};
-
-struct spacemit_reset {
-	struct spacemit_reset_base io_base;
-	const struct spacemit_reset_signal *signals;
-};
-
-enum {
-	RESET_TWSI6_SPL = 0,
-	RESET_TWSI8_SPL,
-	RESET_SDH_AXI_SPL,
-	RESET_SDH0_SPL,
-	RESET_USB_AXI_SPL,
-	RESET_USBP1_AXI_SPL,
-	RESET_USB3_0_SPL,
-	RESET_QSPI_SPL,
-	RESET_QSPI_BUS_SPL,
-	RESET_AES_SPL,
-	RESET_SDH2_SPL,
-	RESET_NUMBER_SPL
-};
-
-static const struct spacemit_reset_signal
-	k1_reset_signals[RESET_NUMBER] = {
-	[RESET_UART1]   = { APBC_UART1_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART2]   = { APBC_UART2_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_GPIO]    = { APBC_GPIO_CLK_RST, BIT(2), 0,
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM0]    = { APBC_PWM0_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM1]    = { APBC_PWM1_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM2]    = { APBC_PWM2_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM3]    = { APBC_PWM3_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM4]    = { APBC_PWM4_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM5]    = { APBC_PWM5_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM6]    = { APBC_PWM6_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM7]    = { APBC_PWM7_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM8]    = { APBC_PWM8_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM9]    = { APBC_PWM9_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM10]   = { APBC_PWM10_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM11]   = { APBC_PWM11_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM12]   = { APBC_PWM12_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM13]   = { APBC_PWM13_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM14]   = { APBC_PWM14_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM15]   = { APBC_PWM15_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM16]   = { APBC_PWM16_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM17]   = { APBC_PWM17_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM18]   = { APBC_PWM18_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_PWM19]   = { APBC_PWM19_CLK_RST,
-			BIT(2) | BIT(0),
-			BIT(0),
-			BIT(2),
-			RST_BASE_TYPE_APBC },
-	[RESET_SSP3]    = { APBC_SSP3_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART3]   = { APBC_UART3_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_RTC]     = { APBC_RTC_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI0]   = { APBC_TWSI0_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TIMERS1] = { APBC_TIMERS1_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_AIB]     = { APBC_AIB_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TIMERS2] = { APBC_TIMERS2_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_ONEWIRE] = { APBC_ONEWIRE_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_SSPA0]   = { APBC_SSPA0_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_SSPA1]   = { APBC_SSPA1_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_DRO]     = { APBC_DRO_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_IR]      = { APBC_IR_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI1]   = { APBC_TWSI1_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TSEN]    = { APBC_TSEN_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI2]   = { APBC_TWSI2_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI4]   = { APBC_TWSI4_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI5]   = { APBC_TWSI5_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI6]   = { APBC_TWSI6_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI7]   = { APBC_TWSI7_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_TWSI8]   = { APBC_TWSI8_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_IPC_AP2AUD]   = { APBC_IPC_AP2AUD_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART4]   = { APBC_UART4_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART5]   = { APBC_UART5_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART6]   = { APBC_UART6_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART7]   = { APBC_UART7_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART8]   = { APBC_UART8_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_UART9]   = { APBC_UART9_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	[RESET_CAN0]    = { APBC_CAN0_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC },
-	/* MPMU */
-	[RESET_WDT]     = { MPMU_WDTPCR, BIT(2), 0, BIT(2), RST_BASE_TYPE_MPMU },
-	/* APMU */
-	[RESET_JPG]     = { APMU_JPG_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_CSI]     = { APMU_CSI_CCIC2_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_CCIC2_PHY]   = { APMU_CSI_CCIC2_CLK_RES_CTRL,
-				BIT(2),
-				BIT(2),
-				0,
-				RST_BASE_TYPE_APMU },
-	[RESET_CCIC3_PHY]   = { APMU_CSI_CCIC2_CLK_RES_CTRL,
-				BIT(29),
-				BIT(29),
-				0,
-				RST_BASE_TYPE_APMU },
-	[RESET_ISP]     = { APMU_ISP_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_ISP_AHB] = { APMU_ISP_CLK_RES_CTRL, BIT(3), BIT(3), 0, RST_BASE_TYPE_APMU },
-	[RESET_ISP_CI]  = { APMU_ISP_CLK_RES_CTRL, BIT(16), BIT(16), 0, RST_BASE_TYPE_APMU },
-	[RESET_ISP_CPP] = { APMU_ISP_CLK_RES_CTRL, BIT(27), BIT(27), 0, RST_BASE_TYPE_APMU },
-	[RESET_LCD]     = { APMU_LCD_CLK_RES_CTRL1, BIT(4), BIT(4), 0, RST_BASE_TYPE_APMU },
-	[RESET_DSI_ESC] = { APMU_LCD_CLK_RES_CTRL1, BIT(3), BIT(3), 0, RST_BASE_TYPE_APMU },
-	[RESET_V2D]     = { APMU_LCD_CLK_RES_CTRL1, BIT(27), BIT(27), 0, RST_BASE_TYPE_APMU },
-	[RESET_MIPI]    = { APMU_LCD_CLK_RES_CTRL1, BIT(15), BIT(15), 0, RST_BASE_TYPE_APMU },
-	[RESET_LCD_SPI] = { APMU_LCD_SPI_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_LCD_SPI_BUS]     = { APMU_LCD_SPI_CLK_RES_CTRL,
-				BIT(4),
-				BIT(4),
-				0,
-				RST_BASE_TYPE_APMU },
-	[RESET_LCD_SPI_HBUS]    = { APMU_LCD_SPI_CLK_RES_CTRL,
-				BIT(2),
-				BIT(2),
-				0,
-				RST_BASE_TYPE_APMU },
-	[RESET_LCD_MCLK]    = { APMU_LCD_CLK_RES_CTRL2, BIT(9), BIT(9), 0, RST_BASE_TYPE_APMU },
-	[RESET_CCIC_4X]     = { APMU_CCIC_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_CCIC1_PHY]   = { APMU_CCIC_CLK_RES_CTRL, BIT(2), BIT(2), 0, RST_BASE_TYPE_APMU },
-	[RESET_SDH_AXI]     = { APMU_SDH0_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_SDH0]      = { APMU_SDH0_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_SDH1]	  = { APMU_SDH1_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_USB_AXI]	  = { APMU_USB_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_USBP1_AXI] = { APMU_USB_CLK_RES_CTRL, BIT(4), BIT(4), 0, RST_BASE_TYPE_APMU },
-	[RESET_USB3_0]	  = { APMU_USB_CLK_RES_CTRL,
-				BIT(9) | BIT(10) | BIT(11),
-				BIT(9) | BIT(10) | BIT(11),
-				0,
-				RST_BASE_TYPE_APMU },
-	[RESET_QSPI]  = { APMU_QSPI_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_QSPI_BUS]  = { APMU_QSPI_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_DMA]	 = { APMU_DMA_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_AES]	 = { APMU_AES_CLK_RES_CTRL, BIT(4), BIT(4), 0, RST_BASE_TYPE_APMU },
-	[RESET_VPU]	 = { APMU_VPU_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_GPU]	 = { APMU_GPU_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_SDH2] = { APMU_SDH2_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_MC]	 = { APMU_PMUA_MC_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_EM_AXI]	= { APMU_PMUA_EM_CLK_RES_CTRL, BIT(0), BIT(0), 0, RST_BASE_TYPE_APMU },
-	[RESET_EM]	= { APMU_PMUA_EM_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_AUDIO_SYS] = { APMU_AUDIO_CLK_RES_CTRL,
-				BIT(0) | BIT(2) | BIT(3),
-				BIT(0) | BIT(2) | BIT(3),
-				0,
-				RST_BASE_TYPE_APMU },
-	[RESET_HDMI]	 = { APMU_HDMI_CLK_RES_CTRL, BIT(9), BIT(9), 0, RST_BASE_TYPE_APMU },
-	[RESET_PCIE0]	 = { APMU_PCIE_CLK_RES_CTRL_0,
-				BIT(3) | BIT(4) | BIT(5) | BIT(8),
-				BIT(3) | BIT(4) | BIT(5),
-				BIT(8),
-				RST_BASE_TYPE_APMU },
-	[RESET_PCIE1]	 = { APMU_PCIE_CLK_RES_CTRL_1,
-				BIT(3) | BIT(4) | BIT(5) | BIT(8),
-				BIT(3) | BIT(4) | BIT(5),
-				BIT(8),
-				RST_BASE_TYPE_APMU },
-	[RESET_PCIE2]	 = { APMU_PCIE_CLK_RES_CTRL_2, 0x138, 0x38, 0x100, RST_BASE_TYPE_APMU },
-	[RESET_EMAC0]	 = { APMU_EMAC0_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_EMAC1]	 = { APMU_EMAC1_CLK_RES_CTRL, BIT(1), BIT(1), 0, RST_BASE_TYPE_APMU },
-	[RESET_SEC_UART1]	= { APBC2_UART1_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	[RESET_SEC_SSP2]	= { APBC2_SSP2_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	[RESET_SEC_TWSI3]	= { APBC2_TWSI3_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	[RESET_SEC_RTC]		= { APBC2_RTC_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	[RESET_SEC_TIMERS0]	= { APBC2_TIMERS0_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	[RESET_SEC_KPC]		= { APBC2_KPC_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	[RESET_SEC_GPIO]	= { APBC2_GPIO_CLK_RST, BIT(2), 0, BIT(2), RST_BASE_TYPE_APBC2 },
-	};
-
-static u32 spacemit_reset_read(struct spacemit_reset *reset, u32 id)
-{
-	void __iomem *base;
-
-	switch (reset->signals[id].type) {
-	case RST_BASE_TYPE_APMU:
-		base = reset->io_base.apmu_base;
-		break;
-	case RST_BASE_TYPE_APBC:
-		base = reset->io_base.apbc_base;
-		break;
-	default:
-		base = reset->io_base.apbc_base;
-		break;
-	}
-
-	return readl(base + reset->signals[id].offset);
-}
-
-static void spacemit_reset_write(struct spacemit_reset *reset, u32 value, u32 id)
-{
-	void __iomem *base;
-
-	switch (reset->signals[id].type) {
-	case RST_BASE_TYPE_APMU:
-		base = reset->io_base.apmu_base;
-		break;
-	case RST_BASE_TYPE_APBC:
-		base = reset->io_base.apbc_base;
-		break;
-	default:
-		base = reset->io_base.apbc_base;
-		break;
-	}
-
-	writel(value, base + reset->signals[id].offset);
-}
-
-static void spacemit_reset_set(struct reset_ctl *rst, u32 id, bool assert)
-{
-	u32 value;
-	struct spacemit_reset *reset = dev_get_priv(rst->dev);
-
-	value = spacemit_reset_read(reset, id);
-
-	if (assert) {
-		value &= ~reset->signals[id].mask;
-		value |= reset->signals[id].assert_val;
-	} else {
-		value &= ~reset->signals[id].mask;
-		value |= reset->signals[id].deassert_val;
-	}
-
-	spacemit_reset_write(reset, value, id);
-}
-
-static int spacemit_reset_update(struct reset_ctl *rst, bool assert)
-{
-	if (rst->id < RESET_UART1 || rst->id >= RESET_NUMBER)
-		return 0;
-
-	/* can not write to twsi8 */
-	if (rst->id == RESET_TWSI8)
-		return 0;
-
-	spacemit_reset_set(rst, rst->id, assert);
-	return 0;
-}
-
-static int spacemit_reset_assert(struct reset_ctl *rst)
-{
-	return spacemit_reset_update(rst, true);
-}
-
-static int spacemit_reset_deassert(struct reset_ctl *rst)
-{
-	return spacemit_reset_update(rst, false);
-}
-
-static int spacemit_k1_reset_probe(struct udevice *dev)
-{
-	struct spacemit_reset *reset = dev_get_priv(dev);
-
-	reset->io_base.mpmu_base = (void *)dev_remap_addr_index(dev, 0);
-	if (!reset->io_base.mpmu_base) {
-		pr_err("failed to map mpmu registers\n");
-		goto out;
-	}
-
-	reset->io_base.apmu_base = (void *)dev_remap_addr_index(dev, 1);
-	if (!reset->io_base.apmu_base) {
-		pr_err("failed to map apmu registers\n");
-		goto out;
-	}
-
-	reset->io_base.apbc_base = (void *)dev_remap_addr_index(dev, 2);
-	if (!reset->io_base.apbc_base) {
-		pr_err("failed to map apbc registers\n");
-		goto out;
-	}
-
-	reset->io_base.apbs_base = (void *)dev_remap_addr_index(dev, 3);
-	if (!reset->io_base.apbs_base) {
-		pr_err("failed to map apbs registers\n");
-		goto out;
-	}
-
-	reset->io_base.ciu_base = (void *)dev_remap_addr_index(dev, 4);
-	if (!reset->io_base.ciu_base) {
-		pr_err("failed to map ciu registers\n");
-		goto out;
-	}
-
-	reset->io_base.dciu_base = (void *)dev_remap_addr_index(dev, 5);
-	if (!reset->io_base.dciu_base) {
-		pr_err("failed to map dragon ciu registers\n");
-		goto out;
-	}
-
-	reset->io_base.ddrc_base = (void *)dev_remap_addr_index(dev, 6);
-	if (!reset->io_base.ddrc_base) {
-		pr_err("failed to map ddrc registers\n");
-		goto out;
-	}
-
-	reset->io_base.apbc2_base = (void *)dev_remap_addr_index(dev, 7);
-	if (!reset->io_base.apbc2_base) {
-		pr_err("failed to map apbc2 registers\n");
-		goto out;
-	}
-
-	reset->signals = k1_reset_signals;
-
-out:
-	return 0;
-}
-
-const struct reset_ops k1_reset_ops = {
-	.rst_assert = spacemit_reset_assert,
-	.rst_deassert = spacemit_reset_deassert,
-};
-
-static const struct udevice_id k1_reset_ids[] = {
-	{ .compatible = "spacemit,k1-reset", },
-	{},
-};
-
-U_BOOT_DRIVER(k1_reset) = {
-	.name		= "spacemit,k1-reset",
-	.id		= UCLASS_RESET,
-	.ops		= &k1_reset_ops,
-	.of_match	= k1_reset_ids,
-	.probe		= spacemit_k1_reset_probe,
-	.priv_auto	= sizeof(struct spacemit_reset),
-};

-- 
2.43.0

