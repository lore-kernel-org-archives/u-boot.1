Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0257EC10F16
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D610288A7E;
	Tue, 30 Apr 2024 15:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q0PevCMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4221C88A61; Tue, 30 Apr 2024 15:36:33 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE8888A70
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6a0c8fb3540so20775246d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484189; x=1715088989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2J/DWM4xCtEpXUg07v+G9OLgSMTW+lxfEOOS3W7jSNg=;
 b=q0PevCMWh/iDlCUNCvLjyiPAPWQogbbbNJDZMkzrXaFD2o8UxMNYreqZJIEa6mT5ND
 dGYSIREN7BT6eRNepM4/skygQx+uhBvBivenWrxFDB2YfP5ceArgwYdm+oEJ49FuIf6k
 qhKH8ib0ymsy7YSpdaY5e58RNprbsXvVSuLtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484189; x=1715088989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2J/DWM4xCtEpXUg07v+G9OLgSMTW+lxfEOOS3W7jSNg=;
 b=C8qY9oBKgTaJF90N/KeWxVF+dUkSc+qYT3bo0Gu+PRMr3QWvdV9JhgI5xATKqZEZLv
 vxbk/4nQ7RIgP4rEEInx1uymdp78HOmYkwHiiA94u24a5cz8Nits+E0LAHb1k3hTA2lm
 rP3h023ZtrMql6URX3phMqY3QbDAEawfx3nqzW/0wgcrJn/99jLeclOd0gz80zCGa0An
 uOJ2lg64p8hxIozaiNayzuEPMVEPQ+AXduVhj1ei0TRODQ8nysimPVjWj8xv9ReR4oar
 vUd7NsKqYu3+7jFvPUNzVEaH0qvY0Oo3+5WFKzvwdaG/es7LiQ7J9AAK/MKEj+zirhDB
 KS1g==
X-Gm-Message-State: AOJu0YxoZgytl/V5wnSTdv3Vbg7MlEdNMLPigWhK1F0jms5rrjOgEu1e
 3kpT9bjS8mrqLY6FFz6yKUOWfROC63wOpnDg+wZiYZ9yIJto5aqiseBf49Am6u51xqrdt5KtYBA
 Q2Lktzw==
X-Google-Smtp-Source: AGHT+IECkCP8I5QYd6c0HjlPjJG1tAMVdtO1MwyN88QXLrK7aur9QrdTT7a6YhV13eo70Qf+HIiNVw==
X-Received: by 2002:a05:6214:20c3:b0:69c:b559:547d with SMTP id
 3-20020a05621420c300b0069cb559547dmr5907667qve.25.1714484189221; 
 Tue, 30 Apr 2024 06:36:29 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 25/33] arm: highbank: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:51 -0600
Message-Id: <20240430133559.1836389-25-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-highbank files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-highbank/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-highbank/timer.c b/arch/arm/mach-highbank/timer.c
index 2423a0e37855..32ec6f0ac0e2 100644
--- a/arch/arm/mach-highbank/timer.c
+++ b/arch/arm/mach-highbank/timer.c
@@ -5,7 +5,6 @@
  * Based on arm926ejs/mx27/timer.c
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch-armv7/systimer.h>
-- 
2.34.1

