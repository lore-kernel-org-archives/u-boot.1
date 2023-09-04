Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12DEC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 19:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D96B686611;
	Mon,  4 Sep 2023 21:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OCyk+U8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59EF86886; Mon,  4 Sep 2023 21:06:41 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34425863C3
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 21:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-573449a364fso1183052eaf.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693854397; x=1694459197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KBoPnLk8+yyJPW0q94k64SLHlSXV0M0Vr+rBa53BX/8=;
 b=OCyk+U8T4wTRs/I+9tBu6I4PL3Mwu8SaPyw5jZpSLuabiHrfkkZm3HnxLB+or7Q6xu
 q196gx6OzvVWZVdVzL6mg1rbi6Vl/NSd/2xKsfUsj06y7LNHbL7qzzkpthMb7Vnr7hVJ
 yFVbPgrJ/mXRPJitmfqsN4nltF4uit8glBVo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693854397; x=1694459197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KBoPnLk8+yyJPW0q94k64SLHlSXV0M0Vr+rBa53BX/8=;
 b=MvqiBcscifJuE6nua18d7WrSXOQ4hOiUbCgBV7r5uDmoo/bwwmNqyOjMfRNHF9O3uG
 4P2oKcx2OtRV6YjqH2reDy5oWhPSe8UVij6SycV8STm954uFX1pwV/pc6dW1c5SppZGZ
 aBQag38HsVYUwEE++Os/9ffOVBtRHNq5vJrxx6YPkGxJCjLxpgmTAANhvyWBO6IRloP7
 gKYFyAv0K8teOubc84FsfJK5QNyzo6Z2P/nOvzSx0S1VQIZsPDpHRYZP1BTr+pVeKaOj
 YPiAJiNoKXxkEwZTjYWSN8abxfir4bYTdMEP9+aXDBWFt/pLO4Az087Q4Q5aTwBzDfzK
 Ri6Q==
X-Gm-Message-State: AOJu0Yx6BDLvLiYVZJcNG8VltwTO2BklVqLUcay1HsggKZnFHEOG2nui
 Zv3OiPvi6Mqsa5JP/LN2PDz6JASpPMQYIsycZa7NKw==
X-Google-Smtp-Source: AGHT+IEqFLI3V5RUe8X9AoBSX5L3Vl++CiltTW8d54ZQLtI0cLlxvjc8wnSWw0QrKFakw5xTiAXLYQ==
X-Received: by 2002:a05:6358:920f:b0:13c:ee28:2323 with SMTP id
 d15-20020a056358920f00b0013cee282323mr13067662rwb.16.1693854397125; 
 Mon, 04 Sep 2023 12:06:37 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 ci7-20020a05690c0a8700b005869d49212fsm2755109ywb.32.2023.09.04.12.06.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 12:06:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] riscv: Rework riscv_cpu_probe for current event macros
Date: Mon,  4 Sep 2023 15:06:34 -0400
Message-Id: <20230904190635.3896494-1-trini@konsulko.com>
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

This function should now be a EVENT_SPY_SIMPLE call, update it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/riscv/cpu/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index d64aa330f206..cfe9fdc9df55 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
 #endif /* CONFIG_CPU */
 }
 
-static int riscv_cpu_probe(void *ctx, struct event *event)
+static int riscv_cpu_probe(void)
 {
 #ifdef CONFIG_CPU
 	int ret;
@@ -79,7 +79,7 @@ static int riscv_cpu_probe(void *ctx, struct event *event)
 
 	return 0;
 }
-EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, riscv_cpu_probe);
 
 /*
  * This is called on secondary harts just after the IPI is init'd. Currently
-- 
2.34.1

