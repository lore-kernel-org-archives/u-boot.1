Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D9DC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6E5807B3;
	Fri,  7 Feb 2025 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKwlCfGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEABD806FB; Fri,  7 Feb 2025 04:04:25 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F826801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 04:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f2cfd821eso29256825ad.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 19:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738897461; x=1739502261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0cOREnf6nAWBTlgGIltsEUNiGRwz/snwRQt/6XZdYo=;
 b=TKwlCfGA683B3s6PAZtMSkoibZ1/wyLGM0/sIDCaQLN2NHT063/mbGFoGkXKRgDJ8Y
 T9GN9/qfpUN6rcch88cJfxK8o7jWem6JM007isTowT/FaF7kTh94gi8qX3YYDNiS/zkl
 D+45zot1NCAicp/ZbTMJITbZH2Ir+r0dtNfrigQa564FybHxXPcY/Q3hf551N4JLC6S0
 7n+RQ8OXK0QxZpLygLNufbctY2E1N3DKfHx+2E/9E2CMXzBzbzXa2yZbajUbdvYoBbke
 YmF8BKmYeZNi05UmXochvKuigbv15c4798DYspDkEgwybIbs5fF/FjlgiN0E14TSIUFD
 84gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738897461; x=1739502261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0cOREnf6nAWBTlgGIltsEUNiGRwz/snwRQt/6XZdYo=;
 b=hLSh2YAM8uoz5auqfU40+4rc/1qlfCXDvhkPf7qrXSzB37kHKuDcYAG+17NRW+irGm
 l+7LCim22nYtrid5zWpfeTqSRCwcpRmiDSUy0vdWKMo81XZ+r2sX7yjNcPqD/HxhZ7Ze
 K2Cdrjnyoll/PSwgSQA3NFU74WaJ9CK67jYQjk6bR+eQxsuh3u9+ZIvJ5JF+t+OvrX7e
 Eje0/3JIUIwRw5ONEBTLI/zynD1omxrLbJgdhOZBo4t44trV9v9Mv+85RKkA6OE1V559
 TFJnpB4yC2cOnQIybyW0DbaZeNj0HKWlZ4reRb9V2GrESc9lsXB7Gd4y/Jvju1Pf2C2i
 7qmg==
X-Gm-Message-State: AOJu0YySmMS+S39ohJzBYGvoiNahERLWG/h3Iz7WXOtjX0cTKOK+dX7O
 22pHsABw49lCmwZIkCwOT4zqx/RHe/dZ67MsG8Yz6QjTFty4YDXo
X-Gm-Gg: ASbGnctfcJ+C0I6s54po+vWSMyfP/2PSieix1QxcOg2my3WXrs+jYG0Zar6cIkgaGxQ
 1TBpeg1whI03mM55ZjdZHRXD8W3zcYVaLWjONC+sST7COxIFUwU2ICdOoZrLCUZHDqYiip4jC3D
 bMZGKHzARMQwAjL6mBThaet9bEDAzlz1JzxemYmfbdIYZN5lBN5VIuMVrtqFQ3cHtg/TgXiAHJu
 i3J/FZ9ohEjZUs3aQkmh4OJbrirBAkj8nyHEUGLZYF6ITyTxhbOY3+MhqlYTZS4fWzMMZAwJZY7
 Ai7AZstX5UJgzBYdaechYtj9aviwGXzZ7TIt+o3fAFIp0GjbRLRHVA9OAXyM5ug=
X-Google-Smtp-Source: AGHT+IE/18MASxgBsbW1L7CKyoO8CH7LiC62zivJcY9eJUOZ0bNTS0MZ9JimwHfOwTmvEmWBNBBN/Q==
X-Received: by 2002:a17:903:186:b0:21f:75f:295 with SMTP id
 d9443c01a7336-21f4e716a17mr24708815ad.31.1738897461300; 
 Thu, 06 Feb 2025 19:04:21 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368c113esm19684215ad.239.2025.02.06.19.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 19:04:20 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, yschu@nuvoton.com, JJLIU0@nuvoton.com,
 zhang971090220@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] board: nuvoton: use an event to replace last_stage_init()
Date: Fri,  7 Feb 2025 11:03:59 +0800
Message-Id: <20250207030359.656796-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

Add a new event which handles this function refer commit
("91caa3bb89b1 event: Use an event to replace last_stage_init()")

Signed-off-by: Michael Chang <zhang971090220@gmail.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 7 ++-----
 board/nuvoton/common/uart.c         | 7 ++++---
 board/nuvoton/common/uart.h         | 2 +-
 board/nuvoton/poleg_evb/poleg_evb.c | 7 +++++--
 configs/arbel_evb_defconfig         | 1 -
 configs/poleg_evb_defconfig         | 1 +
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 55e93a77f0..699e5ca54a 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <event.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include "../common/uart.h"
@@ -98,9 +99,5 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int last_stage_init(void)
-{
-	board_set_console();
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, board_set_console);
 
-	return 0;
-}
diff --git a/board/nuvoton/common/uart.c b/board/nuvoton/common/uart.c
index b35c795704..06f637855f 100644
--- a/board/nuvoton/common/uart.c
+++ b/board/nuvoton/common/uart.c
@@ -14,7 +14,7 @@
 #define UART_LCR	0xc
 #define LCR_DLAB	BIT(7)
 
-void board_set_console(void)
+int board_set_console(void)
 {
 	const unsigned long baudrate_table[] = CFG_SYS_BAUDRATE_TABLE;
 	struct udevice *dev = gd->cur_serial_dev;
@@ -28,12 +28,12 @@ void board_set_console(void)
 	int ret, i;
 
 	if (!dev)
-		return;
+		return -ENODEV;
 
 	uart_reg = dev_read_addr_ptr(dev);
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
-		return;
+		return ret;
 
 	uart_clk = clk_get_rate(&clk);
 	setbits_8(uart_reg + UART_LCR, LCR_DLAB);
@@ -67,4 +67,5 @@ void board_set_console(void)
 	snprintf(string, sizeof(string), "ttyS0,%un8", gd->baudrate);
 	env_set("console", string);
 
+	return 0;
 }
diff --git a/board/nuvoton/common/uart.h b/board/nuvoton/common/uart.h
index 9cc895251b..fc8ec477c8 100644
--- a/board/nuvoton/common/uart.h
+++ b/board/nuvoton/common/uart.h
@@ -6,6 +6,6 @@
 #ifndef _NUVOTON_UART_H
 #define _NUVOTON_UART_H
 
-void board_set_console(void);
+int board_set_console(void);
 
 #endif /* _NUVOTON_COMMON_H */
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 3c4e5aaf29..2faa34954e 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -6,6 +6,7 @@
 
 #include <dm.h>
 #include <env.h>
+#include <event.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include <asm/mach-types.h>
@@ -48,7 +49,7 @@ int dram_init(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 
 	char value[32];
@@ -68,8 +69,10 @@ int last_stage_init(void)
 		}
 		sprintf(value, "ttyS%d,115200n8", dev->seq_);
 		env_set("console", value);
-		board_set_console();
+		return board_set_console();
 	}
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+
diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 2b0b8b2d3b..9a283b8105 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -25,7 +25,6 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run common_bootargs; run romboot"
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="U-Boot>"
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/poleg_evb_defconfig b/configs/poleg_evb_defconfig
index 74f4092d28..365f6434f8 100644
--- a/configs/poleg_evb_defconfig
+++ b/configs/poleg_evb_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="nuvoton-npcm750-evb"
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x10000000
 CONFIG_TARGET_POLEG=y
+CONFIG_SYS_SKIP_UART_INIT=y
 CONFIG_ENV_ADDR=0x80100000
 CONFIG_FIT=y
 CONFIG_USE_BOOTCOMMAND=y
-- 
2.34.1

