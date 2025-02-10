Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ECDC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 03:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8293D805C2;
	Mon, 10 Feb 2025 04:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4SLwXXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFC7805C2; Mon, 10 Feb 2025 03:37:49 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FCC803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso5904263a91.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 18:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739155065; x=1739759865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UxrbMaM0zlpeZlhEFWC96Al5Oo0o4gcSHbX8iVlH43E=;
 b=e4SLwXXkfLfGUqlDI2CW1irXUl/SGh7a21cy/+OpEH8cD+zhsvjPG/XrNqliEuX7k/
 syy1weaD5z/ucb4P9A9rbjsB3NLPuT5lScGb2L10c7oiZFpYWMWaBHBSPcCpkNK7oQRY
 vhsJw19TIp3MGKHKJMLrjMq/KHTPfFTbhZZdv7NWXbYMqOOzTXy0MuV34bGMeB91qLuw
 jsI0HqzTKYOdVaovGd6pK1OO/K5qolxVjVH0d7pvREI0FBWMzZaXnE2aFmRkI8K2Fcqi
 60sezUSEoFgV5venqwUnJ2YTE1FdwyU/Wf0k4GPlO2DhblTxXQJ9//mFYWFwMXBzF1bS
 06rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739155065; x=1739759865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UxrbMaM0zlpeZlhEFWC96Al5Oo0o4gcSHbX8iVlH43E=;
 b=hsONYLIXDDsiDZ7siCqanPPfRHGoCZVr+Tmdsdn7sa2/Epdn81JUWR4gq9roZ7kRs7
 SevVJ/yxxTB6ug//vp6IjupMqP3Q5lhM9uO8WeXy9EiBPJqiHgMTiutKwTQOwL5/10Gu
 YXNUSIOF1p9udW1x87bCMnSHgRIin58nv2TFZlkObAmwShD4M8uH48wcSjt3/WyRM9oN
 W7q1aOD2wQgT/RP798RJfSOj/tiVgk/OVQqUPRdSSQAUodj4ICOJ2+9HsgKTzlXJcwQ2
 epJ02FPTDHMlTXx3u0UbLPBgvcHGzZV5UOM2kRonJRk9zLyC3i07pcBMzfLoje2EUglx
 asbw==
X-Gm-Message-State: AOJu0Ywtt+5lLLHzqz4wsHIhPxQQOEaCTy4Co31m+KCarioPyG7E2tgA
 r46FjKWA5iGHAspr+Uf88WBFLK3mRjvSAiTQqYtU4B33UajBfFXu
X-Gm-Gg: ASbGnctvg8Q4jVmpf0he/hCPy3naQZiEz36+M08CLJNbonth0wVtW1b3ZEXwUA1RCsq
 xJtKkkthXcMzkgA0tBftLGBMLDC6eQAZS095TxZiPuENOTL9yiOjjs0RR3kEaxQqaJswP8iq/6G
 duSY5xIjSHROD3bdcLYicOzsW7CaGfodaYjr9Brl9n9FrUOGKeFpruRgDaPuHPw6WbS+V4B+LcY
 JJpKmK5LLRDO0OZgqjNIlmzKBGDdBZFwaUAI1JhGCHpI+b4TJ5MrbuPcLCpS/9SELhDG1xtugL4
 wcvYPW/3zk4cSQdjq3I1gSebwS6jGuZqlhoZt/42cEvNo2cA5hnktHL+RSj8WVI=
X-Google-Smtp-Source: AGHT+IGKjh+DkXEZ9h8jSgofOKUDh/8B3sl16clbXTQXp35wk9WqYIqyDUzZE+zidnsgGPJ/XdvrHA==
X-Received: by 2002:a05:6a00:4293:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-7305d46f7ccmr20393930b3a.12.1739155065083; 
 Sun, 09 Feb 2025 18:37:45 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73088bcda6dsm1411549b3a.34.2025.02.09.18.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 18:37:44 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, JJLIU0@nuvoton.com, yschu@nuvoton.com,
 zhang971090220@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3] board: nuvoton: use an event to replace last_stage_init()
Date: Mon, 10 Feb 2025 10:37:10 +0800
Message-Id: <20250210023710.1210956-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Feb 2025 04:08:31 +0100
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

Add a new event which handles this function refer to commit
("91caa3bb89b1 event: Use an event to replace last_stage_init()")

Signed-off-by: Michael Chang <zhang971090220@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
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

