Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CA9D0E6F9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B861892F4;
	Mon, 21 Oct 2024 13:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eU/DbhzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3008B88F49; Mon, 21 Oct 2024 13:39:16 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8753A892BA
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso105205a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510752; x=1730115552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZzOaX3V6RF9iODDAdcA59OWl/P+shVJvLGGKdn0P6k=;
 b=eU/DbhzJJjsLNFePzJzjqyPZFlShS9EjSlLBQfSYsjgoHh8t5+b9CDb9gYfkmz8iA+
 Qg1nytWJCNTCT49ubBlbkTg5ryOk7reAWkj0rqq+q9pNpm7nZmsta/M2DGkyWS6Q3irL
 /3wuxa42HMdv6K+d3fxYTLpgoMJgPeFBZz6l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510752; x=1730115552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZzOaX3V6RF9iODDAdcA59OWl/P+shVJvLGGKdn0P6k=;
 b=W5fiiZhIWqmUD2YKVvIu840MmO+q9XAiA6MUku2hBGqtKwCId3Un9FjXSIHVCBihNb
 7ffdoyOUFVffjJwziCwq04y3SogNmj5IawTw292FBOcv2sBaAyjKryaim4FKx7OrHfs6
 pN1sGuLSWcdsXQX5Dy/fYU3K7lNGW9QatgbRIPNFOMlk4qlETguYIgyi2Xu5iqgzHVXy
 c5fzX2wq1Gb3NTeXboku4DWY3tLBOAwf8dMAYsmXODrqlkjPyAjXShnNJqYfR+Vb404C
 vXeSBAq3YJP7BNkG9hn60Pe75OliaMnSo/BghRLqFcaVU31Nur6OQYOB10n/zdWvNxZH
 vKwQ==
X-Gm-Message-State: AOJu0YyAlA8hEPo5kvzWr5nN8+KFsvgDZWPCKLPCVC0tmNzuLprVHyxM
 9nucQZ0vfdP79EJHckyiwpuliv729v8k8bBMuunSf5f5/uhc7KGRfTKwIjatpmMXcx74zGAJ0DW
 W9NGQ
X-Google-Smtp-Source: AGHT+IHF+yEFWHskP1SI+MW0rBVVdp4wAH5ax0+a7ul3XCzOe6ZxW80pi2966MHmup0kBe4Gkp7+mg==
X-Received: by 2002:a17:907:6d12:b0:a99:6036:90a with SMTP id
 a640c23a62f3a-a9a69a75131mr1177046566b.14.1729510751794; 
 Mon, 21 Oct 2024 04:39:11 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v2 23/25] mpc83xx: Drop status-LED code
Date: Mon, 21 Oct 2024 13:38:31 +0200
Message-ID: <20241021113839.318572-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/timer/mpc83xx_timer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer.c
index 9da74479aaa..aefc18898e9 100644
--- a/drivers/timer/mpc83xx_timer.c
+++ b/drivers/timer/mpc83xx_timer.c
@@ -9,7 +9,6 @@
 #include <dm.h>
 #include <irq_func.h>
 #include <log.h>
-#include <status_led.h>
 #include <sysinfo.h>
 #include <time.h>
 #include <timer.h>
@@ -178,10 +177,6 @@ void timer_interrupt(struct pt_regs *regs)
 	if (CFG_SYS_WATCHDOG_FREQ && (priv->timestamp % (CFG_SYS_WATCHDOG_FREQ)) == 0)
 		schedule();
 #endif    /* CONFIG_WATCHDOG || CONFIG_HW_WATCHDOG */
-
-#ifdef CONFIG_LED_STATUS
-	status_led_tick(priv->timestamp);
-#endif /* CONFIG_LED_STATUS */
 }
 
 void wait_ticks(ulong ticks)
-- 
2.43.0

