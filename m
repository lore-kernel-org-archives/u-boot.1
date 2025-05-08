Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26571C3ABBF
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 00:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E5F82153;
	Thu,  8 May 2025 02:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AiBpbUhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8444A82162; Thu,  8 May 2025 02:07:21 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D11B820EB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 02:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-401e77e5443so284525b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746662838; x=1747267638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXy0AaPwrmt00v8ITSbg8etzFEKEmHbiU7huc17M4mY=;
 b=AiBpbUhpDWbubXkoyIj/TQx26iBxsNiG0y5iuVlqGGabZRQIEWIArnbDmkiyaHJD7V
 BRzSV1KYJCwD32ITqCliKK1c3wIvEEQX5u1QqHQNAFmihZLokurwUGb0nyOku03NQ40l
 evdRTDIkdZjXscns4PSvdP/HBRn+TTjYuMEYhbshD4VOkeI9cR4vXhUTwWXKTNqT5DGh
 2LjTt5OlV4MdzZ4QY5/miBStyJ1UVkht7h3JzEkp0ONs4N+wL+RWY7fUkplVHsBms9HG
 vXN3KEShtCRAK/1HKBmO7cGpc9VEECIFhvDfA4qV10pTzJnjQ4s/t0zPHBkK11jJcKnf
 ci8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746662838; x=1747267638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXy0AaPwrmt00v8ITSbg8etzFEKEmHbiU7huc17M4mY=;
 b=jcoyz0hA8+KzLtYwIidfuaJ36x3B2v/kimQzSs19a94JLoXSqtdX8cZAyxGOnanfQi
 w3pbI/ahQ66DRZTTUixH0PZsM30X+piXhqV1bePOMEssB/UEjXvz167lqNAIxUieGpbS
 hjRF0VwkviX71aOqbPAzRKmwR3S/dzlstS9xqal8DSL0V2PnvLscb4LO8JjjN8NBpKcK
 nyE/uJBhZ0WvtZoAJBKbgyMqwsEXJtKZMh3PwmXRRnvMBcrzMoK+bCWEl7aIU4NyvlwG
 h18xXWgjztChAn2IdhZjPHvdOJBM6OYjFptLxO+M8P9uOT0yi01b9Vfn9eLTO+iVqx0w
 Hd/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQPEYZBM5o/rws4s8fu0GkTRBXcCR7LtPfdD8TpR4vDN+nVq7Xbcw177Nf+nKXP8vtNrCWMls=@lists.denx.de
X-Gm-Message-State: AOJu0YxkLyqLRwyjOz8qcrt0miE0zBaEuKbAhX2kDUFdjbqiBAAOD0eU
 T2m+sMfOkig9Kv1kgvPTi6FEIyyuwMZhg8Q5w++wR00TdrqQQNfb
X-Gm-Gg: ASbGnct5ND0StKZ5rlk6S9O6bSK51YUBWCU+lhc09zND3jleR8TF4vBid2nw+9K8SF1
 8IhqBid8kZkw8bv+MzH9j8ORqOzRCvJm9gmjjq8EHUnY8zAFn8DI6+JMd3sFrXpBK6UB+LHJ5AC
 l9ezDgAHq03XbMSxt6ba0cE8m00aJBGNWRsERP24a4TzE5xPetlBCdG1pixNtuyBQ7AGVtXfL4P
 x4Y4uDo9tQtpsIW4U2k55Cyy9IBV4ni6+Y+z4V9NX6s2h2RtIyLmUOZSpzLrhNQfZQ3EvnEaGX0
 OxpbInpjRId25glLA+3m4c+zBhbMXljQCOrpfQNo4GjmBHKAoiTUnZg=
X-Google-Smtp-Source: AGHT+IGLMmEHd0RIsR+b96H2NjNzq41x2vkgGQdW7m6sIwyqs+H7CWRt89APOe/D6CLSE2Wnb520AQ==
X-Received: by 2002:a05:6808:300e:b0:3f8:150b:f55a with SMTP id
 5614622812f47-40377f2a3ebmr878179b6e.20.1746662837668; 
 Wed, 07 May 2025 17:07:17 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:428e:8da1:c20e:1705])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3abc95sm861971b6e.42.2025.05.07.17.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:07:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: nicolas.ferre@microchip.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] board: sama5d27_wlsom1_ek: Get RAM size and base from
 devicetree
Date: Wed,  7 May 2025 21:07:10 -0300
Message-Id: <20250508000710.1196995-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Instead of using defines for the RAM size and base address, retrieve these
information from the devicetree.

This aligns with the sama5d27_som1_ek board in commit 73c1589f025d9
("board: sama5d27_som1_ek: Get dram size and base from device tree").

While at it, remove a spurious '/* SPL */' comment.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 11 +++++++----
 include/configs/sama5d27_wlsom1_ek.h                |  6 ------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index 04de1257eca0..897fab58ebae 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -65,7 +65,7 @@ int board_early_init_f(void)
 int board_init(void)
 {
 	/* address of boot parameters */
-	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
 
 	rgb_leds_init();
 
@@ -82,11 +82,14 @@ int misc_init_r(void)
 }
 #endif
 
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
 int dram_init(void)
 {
-	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE,
-				    CFG_SYS_SDRAM_SIZE);
-	return 0;
+	return fdtdec_setup_mem_size_base();
 }
 
 /* SPL */
diff --git a/include/configs/sama5d27_wlsom1_ek.h b/include/configs/sama5d27_wlsom1_ek.h
index 1979cb366e54..b54e3d5c7108 100644
--- a/include/configs/sama5d27_wlsom1_ek.h
+++ b/include/configs/sama5d27_wlsom1_ek.h
@@ -15,10 +15,4 @@
 #undef CFG_SYS_AT91_MAIN_CLOCK
 #define CFG_SYS_AT91_MAIN_CLOCK      24000000 /* from 24 MHz crystal */
 
-/* SDRAM */
-#define CFG_SYS_SDRAM_BASE		0x20000000
-#define CFG_SYS_SDRAM_SIZE		0x10000000
-
-/* SPL */
-
 #endif
-- 
2.34.1

