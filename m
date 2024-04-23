Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582AAC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EBD288A96;
	Tue, 23 Apr 2024 09:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bfB7ZZgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A7A88A96; Tue, 23 Apr 2024 09:22:31 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55388895C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so5165176b3a.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713856948; x=1714461748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uy4PHEBa8NpkbYA/dlsz1s6h/wyqpBwnLjf9KnFjXXs=;
 b=bfB7ZZgIh+4xNYXZNb01h/NcjpZ55rOgiYXURCTKE8QbE47qpiNnjtHbAva7oRRR38
 202+xszWZ92IUUO1EkOKaO6okRPYrT2wJFDaL8DW+5XiWfMtol71o51G2N41N9indkdz
 OcGDqMO737RrjD9PxRQ9Y7t4ab3JU+thOeiIeB4p0dD8JmV+uJMoYGD/7nCKOdIwPMfv
 8N2l0u0LtQeppt6112jvQlWc80rIM9y4VFcuEeBR+2giHk8J7PuYeO/bdrd9rPzb2QmX
 8h+qBPzLwG01p8skBtRzZ5JwrZ+lPkHFBN0Kflgom8MAPzPJZSIHavurHKbO6ReQzZJ/
 F4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856948; x=1714461748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uy4PHEBa8NpkbYA/dlsz1s6h/wyqpBwnLjf9KnFjXXs=;
 b=ehDeXtKGJ9t6vniCXt5nl4iDEhmzSqoErIwnzB0m1vFBKVjm3BevzD/mA4M+6668js
 zOkoYv9ahwxjcUjoTS6hUpQpnWB8CDBuin3LbU3gq/QhAi1ZQ+4lX2D9yJVl/PCq6BoZ
 ufd2pxRC7emz0hRlIcIoFr5WZHk16r6MC0hTJ7hSYZNwi+a8pKxpDotFE9ZBLt+2uV5G
 NA3XKbHhfvFoIZPIQZ1ecXJb+WmhUlZUmJwN60hy22uBYeiYOjrQ/olGD2DJNfO+JlzM
 rmh/pAabAwdQs7o6kZAc5Y9owF4G9DOjlseyB52nGU1wEEAVjRsvcqQwQA8wblivHlWP
 6uPA==
X-Gm-Message-State: AOJu0YxhxG6fTKdR2fAGuAc8HNPj+jMFebDMj+pNwvFcJSs2+cyjJtE8
 vMpSupwog76A/D31sdAzrLHfUwcjfHsQsjQuKSD3lDO0sFwn79e/
X-Google-Smtp-Source: AGHT+IHQkd6v2eLyQpEt71d4xwajXOo723pLLfSD+R0vtqa3WEvsxopDvnre78iJbW1BUBfQ7udkxA==
X-Received: by 2002:a05:6a21:78a5:b0:1a7:a86a:113a with SMTP id
 bf37-20020a056a2178a500b001a7a86a113amr15933341pzc.6.1713856948145; 
 Tue, 23 Apr 2024 00:22:28 -0700 (PDT)
Received: from localhost.localdomain ([180.217.143.235])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a634c11000000b005f0793db2ebsm8746695pga.74.2024.04.23.00.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:22:27 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: YSCHU@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 KWLIU@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] Arm: npcm: fix npcm7xx boot to kernel error
Date: Tue, 23 Apr 2024 15:22:08 +0800
Message-Id: <20240423072210.1926141-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
References: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
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

Add mem and console env information and modify the wrong earlycon env.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/poleg_evb/poleg_evb.c | 27 ++++++++++++++++++++-------
 include/configs/poleg.h             |  4 ++--
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 7421911a41..e69bca9503 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -21,7 +21,6 @@ int board_init(void)
 
 int dram_init(void)
 {
-	char value[32];
 	struct npcm_gcr *gcr = (struct npcm_gcr *)NPCM_GCR_BA;
 
 	int ramsize = (readl(&gcr->intcr3) >> 8) & 0x7;
@@ -47,17 +46,31 @@ int dram_init(void)
 	break;
 	}
 
-	if (gd->ram_size > 0) {
-                sprintf(value, "%ldM", (gd->ram_size / 0x100000));
-                env_set("mem", value);
-        }
-
 	return 0;
 }
 
 int last_stage_init(void)
 {
-	board_set_console();
+
+	char value[32];
+	struct udevice *dev = gd->cur_serial_dev;
+
+	if (gd->ram_size > 0) {
+		sprintf(value, "%ldM", (gd->ram_size / 0x100000));
+		env_set("mem", value);
+	}
+
+	if (dev && (dev->seq_ >= 0)) {
+		void *addr;
+		addr = dev_read_addr_ptr(dev);
+		if (addr) {
+			sprintf(value, "uart8250,mmio32,0x%x", (u32)addr);
+			env_set("earlycon", value);
+		}
+		sprintf(value, "ttyS%d,115200n8", dev->seq_);
+		env_set("console", value);
+		board_set_console();
+	}
 
 	return 0;
 }
diff --git a/include/configs/poleg.h b/include/configs/poleg.h
index 2a2d85c8ec..14ead163e7 100644
--- a/include/configs/poleg.h
+++ b/include/configs/poleg.h
@@ -30,9 +30,9 @@
 		"eth2addr=00:00:F7:A0:00:FE\0"    \
 		"eth3addr=00:00:F7:A0:00:FF\0"    \
 		"console=ttyS0,115200n8\0" \
-		"earlycon=uart8250,mmio32,0xf0000000\0" \
+		"earlycon=uart8250,mmio32,0xf0001000\0" \
 		"common_bootargs=setenv bootargs earlycon=${earlycon} root=/dev/ram "   \
-		"console=${console} mem=${mem} ramdisk_size=48000 basemac=${ethaddr}\0"    \
+		"console=${console} mem=${mem} ramdisk_size=48000 basemac=${ethaddr} oops=panic panic=20\0"    \
 		"sd_prog=fatload mmc 0 10000000 image-bmc; cp.b 10000000 80000000 ${filesize}\0"  \
 		"sd_run=fatload mmc 0 10000000 image-bmc; bootm 10200000\0"   \
 		"\0"
-- 
2.25.1

