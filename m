Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDDCD0EE38
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA81893FF;
	Fri, 11 Oct 2024 23:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E1weot70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4088893F9; Fri, 11 Oct 2024 23:40:42 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8479893F0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3a5cd2a3bso12095725ab.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682839; x=1729287639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/rZYTQ++2GEg/4eQDVNUpw2KVVq7fYqPsJRlodrcmUc=;
 b=E1weot70AYrUsHzd6LE3iR8KN+FN21AAlBsTxjJqmtN8C5t/lHfcjygZP/O8qLCtIQ
 u/C5lQNhtFfL1YPMkSAXLKmNVCILhnx4qCXOWuhqmLCsV8lqowotN/0UHXMBxlzOaxKv
 9dj+BHp0sekBGfzyl5z9683rQt90FvQPgcXeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682839; x=1729287639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rZYTQ++2GEg/4eQDVNUpw2KVVq7fYqPsJRlodrcmUc=;
 b=BzEhfPiFOgAI+n77WUQGdOsVMiaVkNZH59QdgnLGQldko/riA21Y9GDCl+FFPwOn0F
 hLODu+q8zwFWjHRp8mCgdgCbjj+tLRLOXyXBDyZ10GKVor7LTDg9GdyTv6+yXSQmhCji
 EGr0BDbIWDPyURIJbb5LioshnZGGXcsMiuf8uzIyuEnLgrpsojKbIVjZJPeXIA4D6hB1
 YLcJh4h3eEbi1aKlwTUnhcIDwCQB1xdDqP0YUme8cMhQrNw9FLHCovlzTtAO0IPdKM0y
 YwXMwEKhEbA8U9nCil+RVuEr7noPasf9cFxHGQjT/HkC8OUuOky58Pic5v2jEteyQrMM
 POsw==
X-Gm-Message-State: AOJu0YxYu+uV29i2Y06ZubZ7WhG0b7yEkvTL655PMFfuWJs6S2k5au3n
 wNsrWK6OUbqbGBJGJlc59ZdY1i+85zNg3jJLJ3eCSGSSit0RFYT2wHLo9JzNan4aSFj6hHhsdO5
 F/A==
X-Google-Smtp-Source: AGHT+IHo0oG6iyxMUK9M2N/2ZOMA3JGPHskyK+pkk6Izi/tYNzjGKW2T+NawpCRiItFARxVYUjwuNQ==
X-Received: by 2002:a05:6e02:3b06:b0:3a3:b559:5b92 with SMTP id
 e9e14a558f8ab-3a3b5fbf175mr30907485ab.14.1728682839493; 
 Fri, 11 Oct 2024 14:40:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/7] am65x: Use map_to_sysmem() to convert from pointer
Date: Fri, 11 Oct 2024 15:40:27 -0600
Message-Id: <20241011214032.760072-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011214032.760072-1-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
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

(no changes since v1)

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
2.34.1

