Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4153C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC2680780;
	Wed,  5 Feb 2025 14:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5x28ALw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE0080207; Wed,  5 Feb 2025 04:02:16 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C5A80087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 04:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166651f752so27979865ad.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 19:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738724532; x=1739329332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tB06qAOtswDuAnNhmIyH9E7nGcB0ZpBmRfB/FRd2h8k=;
 b=J5x28ALwgMIvvoOzsmtnTW+JRYRu//y5OwS/WxjJEBcnIg/nHoxyCgfXfysmYy+7y3
 AkICTerxKJnm1cPBoTksV9/Yvh9hmgku9EwRB3AQGt9WUHN1kjPZ/DVyMW57AuOhDG1x
 vhjT/FMy+kFWO+b7YaKa2EKcafW5R7k9E5+fxXJXaC72of9vTIa12OCkvGjb85z1ZNNu
 gwsdaw6lZFG9QKgL/4EkDDH/lYYE3jONjcEFsj80YcQSb3LD+CtOnNPAg+qTt4fxgC6p
 qWQXQroUqVpS1sUlomtSH6+zOw1ERu4nWL6TT6YxG42P53igSoP4RF6nc1bC1EeeHx8n
 oGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738724532; x=1739329332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tB06qAOtswDuAnNhmIyH9E7nGcB0ZpBmRfB/FRd2h8k=;
 b=bVyDCKCWvBQnXFnE4rlncdFzZizuGVzNj2KuzZmep0I6iNCuSfHQx85i6WyLQCn0BB
 Nr0JzQdXotBwY3HEc/ow/GGuuOeZd+ZJLEi8MWAjtNW1dS/P5yuEvI5VyVpmzhVl8zAO
 X5b0GJfbTOJNG8CdzZ96Fpp2Hf1+dlVtyAMVQFSFC8vWohDqgpWMqUR6F7pLSbRCKryN
 eDSYrhyE3Hxq5cxqlEgJQxrIniEQv/OdvITMqgnmVYCt66wVN0HTVPumLiFLPH/0bsTt
 czBr9EM0gBeC1BVJFCdBH54V8P9WhxcKHxaJa652JypO2wG+zTK2ktTNcqH49d7DfKPC
 07fQ==
X-Gm-Message-State: AOJu0YyTv1QqzU+3eFJFLHOH09mrER5po9Yw5lTBrMRmh8VNiVb/d0VQ
 gJr8zl76ivQVBgB82WzySFC1ugMrlosR9xfxSQgV9ke0WDMkQ3L3
X-Gm-Gg: ASbGncvEMfxpe2r3jYePtofU/NbM6Ge/OGgSyzqVPN4QZDrSTEGNmw7rt/CGBJY/V57
 8OS4g4cSSs5T5ABzqJ4dIKNpxzSdsh7F5zuxhfAz0KGZK4TZPbetAKyHotXUBk0Lg1ANqhpyYbp
 h1CEPhVSZR8F090yuxXl5kEDdXN68+JAJO2uyw9J6n8r4m0W7GBjbz/AA8JaL8J59zJ9eBOrsDm
 Dk3uTRZoNkDhNO7aJqb48LfmsNhug03lsoPQTEIWbs0vXrT5FhDqtPgIJdTXXgZg0hgk1e2TNTd
 hTs2PVSgW9Ve9OWZe3lxomkZ6XGU4bcG/SvEeX1uFN7w0kuydTPyzyKff1vUhJc=
X-Google-Smtp-Source: AGHT+IFIIZSwqRrPoc8d87X/jguwRggXdihbKImGtN8KoBxQz/QkPkUN+e9JvEOYjYbqKnTUbieX8A==
X-Received: by 2002:a17:903:2291:b0:21f:db8:261e with SMTP id
 d9443c01a7336-21f17dde8c2mr17567505ad.7.1738724532454; 
 Tue, 04 Feb 2025 19:02:12 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f0be3e722sm15533155ad.71.2025.02.04.19.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 19:02:12 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: zhang971090220@gmail.com, yschu@nuvoton.com, JJLIU0@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] board: nuvoton: use an event to replace last_stage_init()
Date: Wed,  5 Feb 2025 11:01:03 +0800
Message-Id: <20250205030103.54736-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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
id 91caa3bb89b112a1421ee2ee3661baf67c64bab9.

Signed-off-by: Michael Chang <zhang971090220@gmail.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 5 ++++-
 board/nuvoton/poleg_evb/poleg_evb.c | 5 ++++-
 configs/arbel_evb_defconfig         | 1 -
 configs/poleg_evb_defconfig         | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 55e93a77f0..b5194f713a 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <event.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include "../common/uart.h"
@@ -98,9 +99,11 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	board_set_console();
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 3c4e5aaf29..11ce472d31 100644
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
@@ -73,3 +74,5 @@ int last_stage_init(void)
 
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

