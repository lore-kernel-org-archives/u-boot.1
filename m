Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F4AC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F5487D3F;
	Wed,  1 Nov 2023 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pAKeSoUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1239887D33; Wed,  1 Nov 2023 17:28:41 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D287B87AD4
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a822f96aedso70217927b3.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856113; x=1699460913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T3K9YiPpEMTWBqNK1HYx35Q76h9ZGBV5S70hE+vn6fo=;
 b=pAKeSoUMt38G4/7fVdwsPx3sn9S5IGd7c1wAkyqxrlpl4TuTEVAxthQJR/sIvLiAl1
 IBONPJUzztPzY5+NbohFZHMRAw1aS7sp+NGkZrPTGfVXURLLPrWBUbSv1Gxrjk3CSxnG
 89Opd32Fiq1uiBiRkNXrezdjptzrlO7pQnw1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856113; x=1699460913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3K9YiPpEMTWBqNK1HYx35Q76h9ZGBV5S70hE+vn6fo=;
 b=S5tiVrdoL5TFNXVF7/v9D352sJT7gvKt8ULAAVOdknZa01VTHv1B9o82WQzTO7qjXp
 egxvLB3xC3yvNIperLz//wmTyocdjkpOo89zdBEYMerxUzfVtJdHuFqwVcptRbqcXGzf
 ZLTZA2cd7EW8JVwfsvau478H0zXOWifhh77au0U8ct+rnghXPryorpIy+xslEbMKEu1z
 3qoK2hpEnrjn2vhMZ76B4fb+9FbrYdXHjD0n4L0wL3VKwNvsEJnlnHsoB0/OWw37YLhC
 UZdvzQk1kUFEtylJmVNH84Qz3TKQigy/g88OOrdxJYIdPLmTAJPMX8AFj6yvvpmib9E7
 bpSA==
X-Gm-Message-State: AOJu0YwRQhtR1QjMadCt85Cl3cUVcu9dUVJYVwL/ARQwuYplrtJAHIxA
 brWq/fUE9MZSoLgcV1xea6mYMiqRk587/49jaLFKMQ==
X-Google-Smtp-Source: AGHT+IGcAMpMfshu3y9EjCaHZDMIeW06OLKkyJJS34adjguWXEIfz2cw/M2jXmgM6hGOyaxvQfCRKQ==
X-Received: by 2002:a25:cb97:0:b0:d9a:ede4:7126 with SMTP id
 b145-20020a25cb97000000b00d9aede47126mr14946091ybg.44.1698856113177; 
 Wed, 01 Nov 2023 09:28:33 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 08/20] mpc85xx: Add missing include in mpc85xx_sleep.c
Date: Wed,  1 Nov 2023 12:28:12 -0400
Message-Id: <20231101162824.3755579-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

This file needs the include file that provides the prototypes for
flush_dcache() and others.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/freescale/common/mpc85xx_sleep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/common/mpc85xx_sleep.c b/board/freescale/common/mpc85xx_sleep.c
index 770fa0d62be5..d4ca278e8831 100644
--- a/board/freescale/common/mpc85xx_sleep.c
+++ b/board/freescale/common/mpc85xx_sleep.c
@@ -4,6 +4,7 @@
  */
 
 #include <log.h>
+#include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/immap_85xx.h>
 #include "sleep.h"
-- 
2.34.1

