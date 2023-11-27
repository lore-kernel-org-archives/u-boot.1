Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C821C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4FB87701;
	Mon, 27 Nov 2023 14:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZKM7/i0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8725087753; Mon, 27 Nov 2023 14:01:09 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F1A8773A
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507975d34e8so5775897e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090066; x=1701694866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgwYbRu88Ced266OZDbb50IHq7aBIxtSa83fftjaWek=;
 b=ZKM7/i0PRCnKnA0b8RJAr547CF/K8l9kmIRkOn77gusIDMPDxlBcVrZWBDJrKshl5P
 jrhU+FegNWogzlsOn5yQYyN5zL/gwyHpIl2NGRYogukPTHyKLPwird5/eECSIcctomHI
 wNWl1xcnwHeE0UhQxiEKTVohqTSfC8QBS7YK/EC8JVKAmK5AHjjf6UXEpE+odZbTTdh2
 B6qrb2uPaz+9ZEFeQpT7vsCNWoP5+ykzCOkA7d2UhRjlqaHXbu0qWtXvNlD4cwTFHJUN
 3lORpiDlr2OIuj4IhCwDnfpb4TTsn5gvYZ6CG45iO6t1GgMBZNLzMusa4VWpB3qZzrig
 yWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090066; x=1701694866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgwYbRu88Ced266OZDbb50IHq7aBIxtSa83fftjaWek=;
 b=KO8mQwLDWUkh0chfJ/tOzsfl28g0Nb/aCIZ73Xq7yrl/TphEawDuPRgyFckCZaStYc
 d5U58ibTqHS98r6wOeqGwj3A0UQiDfxMMOrhklDb4E6WDlPkUrd3gpeRXt/0i+siuAY2
 NOrsjgwkocsr8Gvu1dYL3fyiPOuYvCguYPSvO4c6RXXQ0LhVMjtCcLP6CZBB9fY4zttw
 +IuZBdEyHvqGFyJJQwTZfWvtMpsN8foENrweuYz+jwE3UDC4wekUrt/tNygbGiLcUPt1
 TlkJXNY/vybaVAuX1g6EYfbvdRyUW+8IR12TsUr77QBz4Ajb2HnF51gIIX6dKwCRhiXE
 kkgA==
X-Gm-Message-State: AOJu0Yyfov84pYK3fyQSKn/18HA+A8laTc9RLssh+bpISSypmntv+Ha5
 e9WrnMFu5DUh+bIl4zW7oevsWB47c4I7tyYpRUG7rw==
X-Google-Smtp-Source: AGHT+IFXnKrPHf62ejfuyIunf5bg8pKlJonT6sMdM9MbMB+5f7bZ8A3/q3nh56rI1vkeXL8/UTnpbg==
X-Received: by 2002:a05:6512:21ca:b0:507:b935:9f5f with SMTP id
 d10-20020a05651221ca00b00507b9359f5fmr6292455lft.24.1701090064632; 
 Mon, 27 Nov 2023 05:01:04 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:04 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 24/43] lwip: omap3: rename mem_init
Date: Mon, 27 Nov 2023 18:57:07 +0600
Message-Id: <20231127125726.3735-25-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Rename mem_init to solve following compilation error.
+arm-linux-gnueabi-ld.bfd: net/lwip/lwip-external/src/core/mem.o: in
  function `mem_init':
+net/lwip/lwip-external/src/core/mem.c:162: multiple definition
  of `mem_init';
  arch/arm/mach-omap2/omap3/sdrc.o:arch/arm/mach-omap2/omap3/
  sdrc.c:240: first defined here
+make[1]: *** [Makefile:1764: u-boot] Error 1
+/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-
  gnueabi/13.1.0/../../
../../arm-linux-gnueabi/bin/ld: net/lwip/lwip-external/src/core/
  mem.o (symbol from
  plugin): in function `mem_init':
+(.text+0x0): multiple definition of `mem_init'; arch/arm/mach-omap2/
  omap3/emif4.o
  (symbol from plugin):(.text+0x0): first defined here
+collect2: error: ld returned 1 exit status
+(.text+0x0): multiple definition of `mem_init'; arch/arm/mach-omap2/
  omap3/sdrc.o
  (symbol from plugin):(.text+0x0): first defined here
+Image 'simple-bin' is missing external blobs and is non-functional:
   tee-os
+/binman/simple-bin/fit/images/op-tee/tee-os (tee-os):

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 arch/arm/include/asm/arch-omap3/mem.h | 2 +-
 arch/arm/mach-omap2/omap3/board.c     | 2 +-
 arch/arm/mach-omap2/omap3/emif4.c     | 4 ++--
 arch/arm/mach-omap2/omap3/sdrc.c      | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/arch-omap3/mem.h
index 569779c55e..fce3568eca 100644
--- a/arch/arm/include/asm/arch-omap3/mem.h
+++ b/arch/arm/include/asm/arch-omap3/mem.h
@@ -475,7 +475,7 @@ enum {
 #ifndef __ASSEMBLY__
 
 /* Function prototypes */
-void mem_init(void);
+void omap3_mem_init(void);
 
 u32 is_mem_sdr(void);
 u32 mem_ok(u32 cs);
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index 8b70251457..c76a95dd5d 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -216,7 +216,7 @@ void s_init(void)
 void board_init_f(ulong dummy)
 {
 	early_system_init();
-	mem_init();
+	omap3_mem_init();
 	/*
 	* Save the boot parameters passed from romcode.
 	* We cannot delay the saving further than this,
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 7e5a281922..4fbfb387ab 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -159,10 +159,10 @@ int dram_init_banksize(void)
 }
 
 /*
- * mem_init() -
+ * omap3_mem_init() -
  *  - Initialize memory subsystem
  */
-void mem_init(void)
+void omap3_mem_init(void)
 {
 	do_emif4_init();
 }
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 5d43e7c9cf..f2a0769b9d 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -4,7 +4,7 @@
  *
  * This file has been created after exctracting and consolidating
  * the SDRC related content from mem.c and board.c, also created
- * generic init function (mem_init).
+ * generic init function (omap3_mem_init).
  *
  * Copyright (C) 2004-2010
  * Texas Instruments Incorporated - https://www.ti.com/
@@ -232,11 +232,11 @@ int dram_init_banksize(void)
 }
 
 /*
- * mem_init -
+ * map3_mem_init -
  *  - Init the sdrc chip,
  *  - Selects CS0 and CS1,
  */
-void mem_init(void)
+void omap3_mem_init(void)
 {
 	/* only init up first bank here */
 	do_sdrc_init(CS0, EARLY_INIT);
-- 
2.30.2

