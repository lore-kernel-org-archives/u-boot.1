Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155C5C2BA1A
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500DD884F1;
	Wed, 19 Jun 2024 23:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBB8/xGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AFDA884BA; Wed, 19 Jun 2024 23:28:10 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43570882DA
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f980c89db8so96630a34.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832487; x=1719437287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OQTEtjdFP/SwMt+oBpZIdgduuwg6zoow3rwEX80eJo=;
 b=iBB8/xGe9UmUVqC/pct2MR0zqzu3PBe9uY6Q/wM86X1HeFMkdq8yCPuTSwy7gSOzW/
 /7FDP0Zs2QaRjKZMhcUK9Xwlt11UAO6OMuWAmh/daSSH+XOJZx7T7JyIb5TEpmfLn7/A
 wD4fvw63RM6MNnw/2zHQAhHZ+XC4TVqAKTSx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832487; x=1719437287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OQTEtjdFP/SwMt+oBpZIdgduuwg6zoow3rwEX80eJo=;
 b=Lo1ofaEyQW/R6viOXDFVBDi7cCn6Pt3X+KWGd3Z9iXgZttx8+U+r9t7CsWbd8I6BFB
 zerJwy9GCxwdXDw1va5lCqMF3EFSkJIuhTNZdsgTaXQACGKuz1aFMJOEvt4ZhdiooIVp
 y6QIRqKIqyepmW9FLbov/l6pb3LzaLhb3jAIcjS+wp3AI4LoylY5TP4VZ8b4uFHPdeFK
 RjOl5hGfmk+3m/173VQUrT1sRKihusUhnjdZZTCWY9DLMmntsXP73Pqs4iNX3heWm4Ql
 MzZIudNMm2yqrZvKnlZB8hIJuc10DRkolKyF6JOuAcjlDLmg0+uYmZsAzm2dsr/rXc6W
 XJsA==
X-Gm-Message-State: AOJu0Yyb0cn25hahF8o4/YJh4+OMzKQfvEro2oCc8i8n/0zLnT8wgNIh
 FYrDmKdEzmY/OcbNENd3RFp5E3Wp8atHfYlV2+DqpbSlNTcGnev+1BFU81Elx47/Q0zARRDLgZs
 m66zzVA==
X-Google-Smtp-Source: AGHT+IEwcHl3snOsHtFuh27GMtEPRVabc0Bv+wb0YQu+tjeywW9MWPIEhGFPRa5wWHQaVg0VX8jgCQ==
X-Received: by 2002:a9d:5c15:0:b0:6f9:bcb5:6e90 with SMTP id
 46e09a7af769-700747d4227mr3616950a34.15.1718832487018; 
 Wed, 19 Jun 2024 14:28:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 4/7] sh: Add the old invalidate_icache_all function
Date: Wed, 19 Jun 2024 15:27:56 -0600
Message-Id: <20240619212759.3456158-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
References: <20240619212759.3456158-1-trini@konsulko.com>
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

Add the old invalidate_icache_all function that prints a warning that
was previously found in cmd/cache.c

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/cpu/sh4/cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
index f0cb39d6a923..d3c480e79ed2 100644
--- a/arch/sh/cpu/sh4/cache.c
+++ b/arch/sh/cpu/sh4/cache.c
@@ -6,6 +6,7 @@
 
 #include <command.h>
 #include <cpu_func.h>
+#include <stdio.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -100,6 +101,11 @@ void icache_disable(void)
 	cache_control(CACHE_DISABLE);
 }
 
+void invalidate_icache_all(void)
+{
+	puts("No arch specific invalidate_icache_all available!\n");
+}
+
 int icache_status(void)
 {
 	return 0;
-- 
2.34.1

