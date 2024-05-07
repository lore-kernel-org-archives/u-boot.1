Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6976C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 09:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADAB88723;
	Tue,  7 May 2024 11:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PrYelgZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3BA88726; Tue,  7 May 2024 11:11:39 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8093B88662
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 11:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so1638255b3a.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715073095; x=1715677895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QrBFyoCSFTTFtwQuaCgRxqilpP9FnhuucCcsoyfNQn0=;
 b=PrYelgZJ+KvBp804H6+ju38BCVAWVIwws5/cf67SXS5lUGTfaySdMjVkYh40zdWWpS
 C/EShVJUi9pTXfnAuVh4TmMyMpRMKE25Zklxa5CMp3dsOIisSfkgcbzdq5Quiavm2rz8
 h0TghG7i6uy9QKLBLWJfKxIZLZmrrdRxNtUzc53cnbvk7bXLQSJdP0t/z6EQOShEa369
 sjgxviwXPkTybd/McH7jCS6NAbtC6XKwfweiCpb8TzU3vEkcO0Ab2ltNVg0S7LTT2aDf
 Y5PZcXo/jC1DS82MS7e05dTmQzvcFbju5WYfVCUprmgZl3jeSfNePZsbWDPORKBqoqPD
 x8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073095; x=1715677895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrBFyoCSFTTFtwQuaCgRxqilpP9FnhuucCcsoyfNQn0=;
 b=s/Fy0OrX9HvXNENCB8deqzdhHFMRpUw12RVC/pmR1XGv7rRvoC0aa7fRc06rpCphIo
 rb1gx7ZCld/8HywzJboKnPE6Op2Baj0a+Cor6d4Lq6spU+C8zP7Ly8tFpm2T8AXgqnIn
 X+Z6mThPwkIgNTJ7VvmL/GsfNt+KwS8mPyi7bBgK09aL15n8LRZ1XnD8+uS4kfsvTf8s
 xAXSrt71PMz7ekV7iFCvDZ0/HdsZ3rRFqlD4Br7xzf1pBrdQPXZWpBVVT4j9Ujx8c6SP
 xgYgD92rpZtzML+uKKQL03EfKev/SFgyskotR0WcE/HAgzDwQZptcfPVlfKFYgEhqspD
 NBfQ==
X-Gm-Message-State: AOJu0YznXM4bv5Lbl4eLZvt7Ma05WiOTzTbKWcv/kz0U6ve0a9tVrmnx
 TFmZ9oAKUQl7QiJSG7+0wti6U3oK7k/PYKtjRYgGDqkRuXQaJlum
X-Google-Smtp-Source: AGHT+IGN5CC+w0f6sdwzInc+jy1kznYkJmU5cXURA67HU3vCZ0XSj8lTXaGnw3uwmdn/AWjVbvqbEQ==
X-Received: by 2002:a05:6a00:984:b0:6ed:21d5:fbdb with SMTP id
 d2e1a72fcca58-6f48e88df20mr3054227b3a.8.1715073094588; 
 Tue, 07 May 2024 02:11:34 -0700 (PDT)
Received: from localhost.localdomain ([180.217.157.40])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a056a00114400b006e554afa254sm8982233pfm.38.2024.05.07.02.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:11:34 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: YSCHU@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] board: nuvoton: Use an event to replace last_stage_init()
 and fix build error
Date: Tue,  7 May 2024 17:10:55 +0800
Message-Id: <20240507091055.1749680-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Followed the new style use event to replace last_stage_init().
Fixed build error After replace last_stage_init().
And remove CONFIG_SYS_SKIP_UART_INIT from defconfig,
system will reuse the setting from bootblock
and skip the baud rate setting.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 7 +++++--
 board/nuvoton/common/Makefile       | 2 +-
 board/nuvoton/poleg_evb/poleg_evb.c | 6 +++++-
 configs/arbel_evb_defconfig         | 1 -
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 53c931c3c2..d112329dc1 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <event.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include "../common/uart.h"
@@ -95,9 +96,11 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
+#if CONFIG_IS_ENABLED(CONFIG_SYS_SKIP_UART_INIT)
 	board_set_console();
-
+#endif
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
diff --git a/board/nuvoton/common/Makefile b/board/nuvoton/common/Makefile
index 8fd83b229b..3ba494e900 100644
--- a/board/nuvoton/common/Makefile
+++ b/board/nuvoton/common/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SYS_SKIP_UART_INIT)	+= uart.o
+obj-y	+= uart.o
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index e69bca9503..0710f31959 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <env.h>
+#include <event.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include <asm/mach-types.h>
@@ -49,7 +50,7 @@ int dram_init(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 
 	char value[32];
@@ -69,8 +70,11 @@ int last_stage_init(void)
 		}
 		sprintf(value, "ttyS%d,115200n8", dev->seq_);
 		env_set("console", value);
+#if CONFIG_IS_ENABLED(CONFIG_SYS_SKIP_UART_INIT)
 		board_set_console();
+#endif
 	}
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 08753aebc0..59652a154e 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -14,7 +14,6 @@ CONFIG_DEFAULT_DEVICE_TREE="nuvoton-npcm845-evb"
 CONFIG_DM_RESET=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_ARCH_NPCM8XX=y
-CONFIG_SYS_SKIP_UART_INIT=y
 CONFIG_TARGET_ARBEL_EVB=y
 CONFIG_SYS_LOAD_ADDR=0x06208000
 CONFIG_ENV_ADDR=0x803C0000
-- 
2.25.1

