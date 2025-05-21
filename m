Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF2EC54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2575E83082;
	Thu, 22 May 2025 01:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j7725saI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6F78300E; Thu, 22 May 2025 01:01:52 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB8682FC5
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f6dccdcadaso5671517b6e.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868508; x=1748473308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jIgmExFLgmpDvRMfS5G87ehKfF7/lEUWZEJJaiLtIfU=;
 b=j7725saIFnFd8o5Beh1AF8FPNOpeCjd0ZcbKfmr54jkKIXCr52TSfop07xAqVbrHzq
 HIU2Pncx3RQX5T7oRkDlWytpFfI4Tt6aGSCZXeMZe9742vzb+2Ke7GOV0bc9ufPu10XH
 OKfnAOzh/RE+vvXOfKUVf6/AA5tuEs4UHkJCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868508; x=1748473308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIgmExFLgmpDvRMfS5G87ehKfF7/lEUWZEJJaiLtIfU=;
 b=akpQgD5VVWLxA1UOjmIC/2dZj2JoceaekadYRolhBsN4C+aGLY/GvpvtYJ032ZTdrc
 PtwJafLD23J3hBa9lbk/aA4qVqhHDzDTaTRaMUcjsAnT6v7OJEO22lV/EnkI/2FJqqxT
 aPnXkjGbMc7r5dsQShv1GvS+J9kI5r+Nc7jIfZOFXx7tGNzZQv4cXb9G76Iz4jYK85uz
 934/GtPYPSxvNedIMiLkMqo7MpotMU6HUeLftmOrODxSFNCF0Z5pOXPpfq2ijVqZ34s2
 BwF9zofFUbi/YIOzkXkgZpbbadbUF5UePMQHglZpljx1G+PrxSNsUNkzet0VUvJyw8AZ
 /otw==
X-Gm-Message-State: AOJu0YwkO9KjffImFxUb6DPP7NaOSjz8RKzxT6SiTr0RW/Mvmasohh83
 lNEaqtr/f/BR7KXzAlTvlBXNsod4+2vq2jGe7GIft06c8Vck2kHQhS0757HNNxTGfxS79eBO+4s
 vEJXaYf0=
X-Gm-Gg: ASbGncuiOEOPebNPQIglGIF5JpSLXkvuXlwBKgYK35mL8FG3KAMCOEkwqCtQiTT0gTP
 OZZErnGL+DX8EXjTzFXH7NF4lIf83jwYKgoJS0OIEVE4Tal0ChKD0uerI79nAjVLmzRj2yz+aA3
 WLbtq1JwttJDK6g5UZSy0+hlLMhyc3cRMbvzGwhoZm6EU0FmMcR6nTq2OjvY3QAl4r1Ta0E7c5j
 FAroIdKGPdicfg6kE7+r86UtbdgX7RtqGy7pc34yVgjdIH2xqx9V054RMCfXPhwkqaiG41vynnc
 MmrI1CdwWQ/jGXkTwpYk0rAdu8kiCDaaH4VxsCIBKZ571Pa2VKc8qvn6ekDGKs7A3dsMsX/3A8P
 wZdTHahbbG23HHd8=
X-Google-Smtp-Source: AGHT+IGCdSsb0JtmPg65NRE68I1OupIxor1R43wye0u4qBHri5Wp9Gu+fAYzFAUckh/cnZ3E9Zljwg==
X-Received: by 2002:a05:6808:3318:b0:3f9:8092:14be with SMTP id
 5614622812f47-404d86e2d58mr15388247b6e.13.1747868508015; 
 Wed, 21 May 2025 16:01:48 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 17/17] global: Cleanup usage of "ETH_ALEN"
Date: Wed, 21 May 2025 16:51:22 -0600
Message-ID: <20250521230119.2084088-18-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

The value of "ETH_ALEN" is defined to 6 in <linux/if_ether.h>. This file
is included in <net.h>. In the places where we had ETH_ALEN but no
direct include of <net.h>, add <linux/if_ether.h>. In the places where
we had a custom name used, make use of ETH_ALEN instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-tegra/dt-setup.c            | 1 +
 board/CZ.NIC/turris_omnia/turris_omnia.c  | 1 +
 board/Marvell/mvebu_armada-37xx/board.c   | 1 +
 board/Synology/common/legacy.h            | 2 ++
 board/bosch/shc/board.h                   | 5 +++--
 board/ti/common/board_detect.h            | 4 +++-
 drivers/net/mscc_eswitch/jr2_switch.c     | 1 -
 drivers/net/mscc_eswitch/luton_switch.c   | 1 -
 drivers/net/mscc_eswitch/ocelot_switch.c  | 1 -
 drivers/net/mscc_eswitch/serval_switch.c  | 1 -
 drivers/net/mscc_eswitch/servalt_switch.c | 1 -
 drivers/virtio/virtio_net.h               | 3 +--
 12 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-tegra/dt-setup.c b/arch/arm/mach-tegra/dt-setup.c
index f4ae602d5239..7f1c3538ebeb 100644
--- a/arch/arm/mach-tegra/dt-setup.c
+++ b/arch/arm/mach-tegra/dt-setup.c
@@ -5,6 +5,7 @@
 
 #include <fdtdec.h>
 #include <stdlib.h>
+#include <linux/if_ether.h>
 #include <asm/arch-tegra/cboot.h>
 #include <asm/arch-tegra/gpu.h>
 
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index b7588fa4eec9..baee5afa46d2 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -29,6 +29,7 @@
 #include <linux/bitops.h>
 #include <linux/bitrev.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>
 #include <u-boot/crc.h>
 
 #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index df3fb6d21645..e44b713f96d7 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -20,6 +20,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/Synology/common/legacy.h b/board/Synology/common/legacy.h
index 0a814324d097..f7ba225bd2ba 100644
--- a/board/Synology/common/legacy.h
+++ b/board/Synology/common/legacy.h
@@ -8,6 +8,8 @@
 #ifndef __SYNO_LEGACY_H
 #define __SYNO_LEGACY_H
 
+#include <linux/if_ether.h>
+
 /* Marvell uboot parameters */
 #define ATAG_MV_UBOOT 0x41000403
 #define VER_NUM       0x03040400 /* 3.4.4 */
diff --git a/board/bosch/shc/board.h b/board/bosch/shc/board.h
index a5e58186c9c1..8ff68f5a64b9 100644
--- a/board/bosch/shc/board.h
+++ b/board/bosch/shc/board.h
@@ -14,6 +14,8 @@
 #ifndef _BOARD_H_
 #define _BOARD_H_
 
+#include <linux/if_ether.h>
+
 /* Definition to control the GPIOs (for LEDs and Reset) */
 #define GPIO_TO_PIN(bank, gpio) (32 * (bank) + (gpio))
 
@@ -146,7 +148,6 @@ static inline int board_is_series(void)
 #define RESET_MASK	(0x1 << 29)
 
 #define HDR_MAGIC	0x43485342
-#define HDR_ETH_ALEN	6
 #define HDR_NAME_LEN	8
 #define HDR_REV_LEN	8
 #define HDR_SER_LEN	16
@@ -176,7 +177,7 @@ struct  shc_eeprom {
 	u32  magic;
 	u16  version;
 	u16  lenght;
-	uint8_t mac_addr[HDR_ETH_ALEN];
+	uint8_t mac_addr[ETH_ALEN];
 };
 
 void enable_uart0_pin_mux(void);
diff --git a/board/ti/common/board_detect.h b/board/ti/common/board_detect.h
index ca1aa80f2f04..b057f3b2269b 100644
--- a/board/ti/common/board_detect.h
+++ b/board/ti/common/board_detect.h
@@ -10,6 +10,8 @@
 
 /* TI EEPROM MAGIC Header identifier */
 #include <linux/bitops.h>
+#include <linux/if_ether.h>
+
 #define TI_EEPROM_HEADER_MAGIC	0xEE3355AA
 #define TI_DEAD_EEPROM_MAGIC	0xADEAD12C
 
@@ -18,7 +20,7 @@
 #define TI_EEPROM_HDR_SERIAL_LEN	12
 #define TI_EEPROM_HDR_CONFIG_LEN	32
 #define TI_EEPROM_HDR_NO_OF_MAC_ADDR	3
-#define TI_EEPROM_HDR_ETH_ALEN		6
+#define TI_EEPROM_HDR_ETH_ALEN		ETH_ALEN
 
 /**
  * struct ti_am_eeprom - This structure holds data read in from the
diff --git a/drivers/net/mscc_eswitch/jr2_switch.c b/drivers/net/mscc_eswitch/jr2_switch.c
index 925888e0765a..f04042091163 100644
--- a/drivers/net/mscc_eswitch/jr2_switch.c
+++ b/drivers/net/mscc_eswitch/jr2_switch.c
@@ -222,7 +222,6 @@
 #define CPU_PORT		53
 #define IFH_LEN			7
 #define JR2_BUF_CELL_SZ		60
-#define ETH_ALEN		6
 #define PGID_BROADCAST		510
 #define PGID_UNICAST		511
 
diff --git a/drivers/net/mscc_eswitch/luton_switch.c b/drivers/net/mscc_eswitch/luton_switch.c
index 1c584373b8bc..be78afc3f794 100644
--- a/drivers/net/mscc_eswitch/luton_switch.c
+++ b/drivers/net/mscc_eswitch/luton_switch.c
@@ -132,7 +132,6 @@
 #define CPU_PORT		26
 #define INTERNAL_PORT_MSK	0xFFFFFF
 #define IFH_LEN			2
-#define ETH_ALEN		6
 #define PGID_BROADCAST		28
 #define PGID_UNICAST		29
 #define PGID_SRC		80
diff --git a/drivers/net/mscc_eswitch/ocelot_switch.c b/drivers/net/mscc_eswitch/ocelot_switch.c
index 30bb4b5bad8b..b7a8b60587df 100644
--- a/drivers/net/mscc_eswitch/ocelot_switch.c
+++ b/drivers/net/mscc_eswitch/ocelot_switch.c
@@ -126,7 +126,6 @@
 #define CPU_PORT		11
 #define INTERNAL_PORT_MSK	0x2FF
 #define IFH_LEN			4
-#define ETH_ALEN		6
 #define PGID_BROADCAST		13
 #define PGID_UNICAST		14
 #define PGID_SRC		80
diff --git a/drivers/net/mscc_eswitch/serval_switch.c b/drivers/net/mscc_eswitch/serval_switch.c
index 8eab41df99ae..02f197aa3398 100644
--- a/drivers/net/mscc_eswitch/serval_switch.c
+++ b/drivers/net/mscc_eswitch/serval_switch.c
@@ -111,7 +111,6 @@
 #define CPU_PORT		11
 #define INTERNAL_PORT_MSK	0xFF
 #define IFH_LEN			4
-#define ETH_ALEN		6
 #define PGID_BROADCAST		13
 #define PGID_UNICAST		14
 
diff --git a/drivers/net/mscc_eswitch/servalt_switch.c b/drivers/net/mscc_eswitch/servalt_switch.c
index 61547d7933e4..4b073c0781ef 100644
--- a/drivers/net/mscc_eswitch/servalt_switch.c
+++ b/drivers/net/mscc_eswitch/servalt_switch.c
@@ -88,7 +88,6 @@
 #define MAC_VID			0
 #define CPU_PORT		11
 #define IFH_LEN			7
-#define ETH_ALEN		6
 #define PGID_BROADCAST		50
 #define PGID_UNICAST		51
 
diff --git a/drivers/virtio/virtio_net.h b/drivers/virtio/virtio_net.h
index c92bae526906..3adcb19aead2 100644
--- a/drivers/virtio/virtio_net.h
+++ b/drivers/virtio/virtio_net.h
@@ -9,8 +9,7 @@
 #ifndef _LINUX_VIRTIO_NET_H
 #define _LINUX_VIRTIO_NET_H
 
-/* TODO: needs to be removed! */
-#define ETH_ALEN				6
+#include <linux/if_ether.h>
 
 /* The feature bitmap for virtio net */
 
-- 
2.43.0

