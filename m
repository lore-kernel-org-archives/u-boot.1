Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5DACF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A84B88FCB;
	Wed,  9 Oct 2024 03:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Meqg2SoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCA088FF1; Wed,  9 Oct 2024 03:50:35 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F1488F4B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82aac438539so264275339f.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438632; x=1729043432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHU4zbOwco+MMfRzSw/Pwoe+Rdh9TE05K+Mqcsu3DAQ=;
 b=Meqg2SoIBFIRa0/XNOc8LvGmvWvRC5ARZIFZk6cSi2G5vbyzf1HIi76+osBVl9NiaK
 +vNpa4NMip7FD1O978Ykp5ucVOFeVHFOmn/2Nff9bGn3MTG+oqWihXzcWWCeIYUssPj2
 icPvcWcfYRFeaKFus9AttNGJOn8Ya+1anufPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438632; x=1729043432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHU4zbOwco+MMfRzSw/Pwoe+Rdh9TE05K+Mqcsu3DAQ=;
 b=GWrIYIvKaX8XXzilLXfufgBtNqDESgzF+T1VD3Xgw7II9OAgR7+wXdZe9lSbxx2pc8
 8U+V1TkWg3x1uRuPpNthm0aJK9jhPI0HTgkTWPX9vuaJQK8onpsqFdosG6SjCJ5qnwwz
 HYaTNiTFKSZ+R8k7p/WV21RywWEFMmTvWSixfskU+gUmj/95MQp9f3HKl46Fkt6KUZFD
 KQwUIyW9cGiX/zV9t+q0jNeuufIzp6G78rJRHD46sOchEUD2UalF6LgbAIaAU1kKFPyn
 ZNz/XGSf3tQ/Xogy6SrxAplDcI720fESstxVZNuIBLhkUDKNgxueXaK9fkyYKADjqF7S
 UTJQ==
X-Gm-Message-State: AOJu0YzWf7PV8F2Abaw2Jm0SEtXnvXu8B80yxwXsbm+Yv3txLmkmCPea
 hYsFLmI/oJlDFiSBjuQvmsUJmXYIDWPfaPRtwWiXUIKTop7LsYguDWiFnYXBohjUOXG6rcfLZ9a
 aHw==
X-Google-Smtp-Source: AGHT+IFVNUbhDtGHGT+NPyS9EvxBVlbe3n+tLTOPkl15/VY0UNO3tr0rywQK38VnUMPbXpdhYEwinA==
X-Received: by 2002:a92:ca4a:0:b0:3a0:97df:997e with SMTP id
 e9e14a558f8ab-3a397d0d0efmr8642645ab.14.1728438632271; 
 Tue, 08 Oct 2024 18:50:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/6] am65x: Use map_to_sysmem() to convert from pointer
Date: Tue,  8 Oct 2024 19:50:15 -0600
Message-ID: <20241009015020.25817-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009015020.25817-1-sjg@chromium.org>
References: <20241009015020.25817-1-sjg@chromium.org>
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

The board_init_f() function for am65x is a bit confusing, since it uses
the variable name 'pool_addr' to hold a pointer. It then casts it to an
address to pass to mem_alloc_init()

Rename the variable and use mapmem to convert to an address.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-k3/am65x/am654_init.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-k3/am65x/am654_init.c b/arch/arm/mach-k3/am65x/am654_init.c
index a4f038029d7..ddcc1355210 100644
--- a/arch/arm/mach-k3/am65x/am654_init.c
+++ b/arch/arm/mach-k3/am65x/am654_init.c
@@ -8,6 +8,7 @@
 
 #include <fdt_support.h>
 #include <init.h>
+#include <mapmem.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <spl.h>
@@ -165,7 +166,7 @@ void board_init_f(ulong dummy)
 #if defined(CONFIG_K3_LOAD_SYSFW) || defined(CONFIG_K3_AM654_DDRSS)
 	struct udevice *dev;
 	size_t pool_size;
-	void *pool_addr;
+	void *pool;
 	int ret;
 #endif
 	/*
@@ -204,14 +205,14 @@ void board_init_f(ulong dummy)
 	 * malloc pool of which we use all that's left.
 	 */
 	pool_size = CONFIG_VAL(SYS_MALLOC_F_LEN) - gd->malloc_ptr;
-	pool_addr = malloc(pool_size);
-	if (!pool_addr)
+	pool = malloc(pool_size);
+	if (!pool)
 		panic("ERROR: Can't allocate full malloc pool!\n");
 
-	mem_malloc_init((ulong)pool_addr, (ulong)pool_size);
+	mem_malloc_init(map_to_sysmem(pool), (ulong)pool_size);
 	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 	debug("%s: initialized an early full malloc pool at 0x%08lx of 0x%lx bytes\n",
-	      __func__, (unsigned long)pool_addr, (unsigned long)pool_size);
+	      __func__, (unsigned long)pool, (unsigned long)pool_size);
 	/*
 	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
 	 * regardless of the result of pinctrl. Do this without probing the
-- 
2.43.0

