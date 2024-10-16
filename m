Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEF9D1AD5A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4803188DB6;
	Wed, 16 Oct 2024 15:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mr1Be53r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091FA88995; Wed, 16 Oct 2024 13:25:15 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC58889C3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jelonek.jonas@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so4314815e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729077912; x=1729682712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GhKiJXqt+14xHQQDj7XYgzNvNbO/Xl0G6KhXYoXT8g=;
 b=mr1Be53rz3D+a8tWAcOQDN4d5lxM1ZYvVLrLr3CleCpUQysUIky14QraQ6tvIT5Wkq
 vHzUqgjEatBVRo4vBDsYlEeKfGZhB9UHFo8p1xZClVuYO01eD8Y1aHLWcbRbShnOiE1C
 azMwKg3DYgrNskTMqORLYbl/80vmdtGl6j1RyvRTjJYZ728ib5noPYrF0XAhSTsSFCPq
 3gBFTTROk/hbjyq0/Dir5IRk+GAmWem5/WD3jOkMDt/tVrHz/QG7nK0wCwQvFjN4Zhme
 syhOZ+fT3hgyu/oP4Z3vZglCNjtreP1gMsashAwOUIVcBIbkTHJc72lCp0zI0zodtdDp
 f8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729077912; x=1729682712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GhKiJXqt+14xHQQDj7XYgzNvNbO/Xl0G6KhXYoXT8g=;
 b=iLmp5nLUoJO05Smgdcm8x1nLrCCREWaQWmYOQjycguMz8WmUZ9+jUT//DgQV3PBE5n
 R9RuypL+EMdvIPzPOZWYzTQ0zSPosQEd6OFxXcSJN7ayvdj5hrlMTmGFUO/lIJ8wBXtA
 lyRUQgd3PjbT7WBk30pWFiq2UCVntEIpYaeQvYuOB5hRmyCvJxukgNYWyfzGCpiv168E
 jwU1T8KkdIoCf4fShjB4GCtyGCzsmvLwXLAHgcuGFp/RMl3QS5d0g9orxvz+z0b9VWOS
 ceVkZ+Z64RWAoEA8C8FPw8RFi8VR3osteqxeG8jLxgzX9dlWAPUW9DXNFUA6ZFwnUy8l
 0RlA==
X-Gm-Message-State: AOJu0YwlAK6tyBKa4M9Brc7rNQrHRXSao19ULHhadNb7gi/DHlL3ksbR
 1RsfPqh18Env/J98W9lwHtKrUI7zCe2g1006rk5+UBX147PtruGJXdZhqA==
X-Google-Smtp-Source: AGHT+IG6ODq+4yyAW686zvx8Q8EEySOBo4QqwO03fscxoRxuqGimKcQ7Akk8RMj0QVKq9ZoS5A5Wsg==
X-Received: by 2002:a5d:4bd0:0:b0:37d:524e:9431 with SMTP id
 ffacd0b85a97d-37d552d3820mr10914315f8f.57.1729077911933; 
 Wed, 16 Oct 2024 04:25:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:599:81c:8ff7:8cd1:2207:fa9d:5a1a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a23csm4092572f8f.18.2024.10.16.04.25.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 16 Oct 2024 04:25:11 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: u-boot@lists.denx.de
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] arm: provide noncached_set_region prototype to fix build
Date: Wed, 16 Oct 2024 13:24:55 +0200
Message-Id: <20241016112455.35700-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016112455.35700-1-jelonek.jonas@gmail.com>
References: <20241016112455.35700-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 15:33:18 +0200
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

Due to the removal of weak functions in 7d6cee2cd0 ("cmd: cache: Remove
weak function"), uboot fails to compile after updating to v2024.10 for
mediatek target in OpenWrt with GCC-14 with error:
cmd/cache.c: In function 'do_dcache':
cmd/cache.c:57:25: error: implicit declaration of function
	'noncached_set_region' [-Wimplicit-function-declaration]

Thus, provide a prototype in arm's include/asm/system.h to fix a build
error in cmd/cache.c, since related prototypes are also located there.
Also add an include of asm/system.h in cmd/cache.c to have the function
available there.

The issue occured after the update of uboot-mediatek in OpenWrt to
v2024.10, in combination with GCC-14 toolchain. It was reported and
discussed in https://github.com/openwrt/openwrt/issues/16697, and
temporarily fixed with
https://github.com/openwrt/openwrt/commit/92ca322dd1f48158b8829fec59319a12e4ae4295.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/system.h | 1 +
 cmd/cache.c                   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d006..0100096202 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -668,6 +668,7 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
  * Return: 0 if OK
  */
 int noncached_init(void);
+void noncached_set_region(void);
 
 phys_addr_t noncached_alloc(size_t size, size_t align);
 #endif /* CONFIG_SYS_NONCACHED_MEMORY */
diff --git a/cmd/cache.c b/cmd/cache.c
index 3049f5c305..f873f2c8fb 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <linux/compiler.h>
+#include <asm/system.h>
 
 static int parse_argv(const char *);
 
-- 
2.39.5 (Apple Git-154)

