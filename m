Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D03DC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C59582B72;
	Wed, 30 Apr 2025 16:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k/Wk4qTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89AB82B45; Wed, 30 Apr 2025 16:40:24 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3FC8210F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d589ed2b47so23591415ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746024020; x=1746628820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MmRJ/qOdgy3jbAcT3h5m7d0uR3DLHnXK1kFOro9LTwI=;
 b=k/Wk4qTXbOtWlQnydZZx7IrdvKJtbiROwy1Ru5vFDZXdAZWgxNO+RxgkjLDNyM6Bfp
 SPhOLeXrK/cxfzcIr4IfGpqXVcU6roi9x6DoQAkCGl3m8bawQBSoOil4rfi0RDitacn8
 wTZkQf2hZmz1A7VfQA1Omkw03swE3wsM0pplQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746024020; x=1746628820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MmRJ/qOdgy3jbAcT3h5m7d0uR3DLHnXK1kFOro9LTwI=;
 b=AxMcxZ4YW/wpn/iOapw2CJVq5oGN0bkwRMXz/kSWms0Hfw7jVwYAXKB/vmI5PpXkz4
 LVp7BTWwUjVs/bsWJLmKxaSI6LyLxpp1dQkofog3g/PMsPRlrSjMOelng1vP5mmi0dyl
 w+hPVgVaho3ImpqoK0J9Fa55XECIm5uHC1h7IwFJ4EFKdx8kiSQgmHcXEqjUBsqdM82p
 YAEZICIUZAMIHQdgF9Dmwsf/QDToQF58YL/RaEaewGrE8d2FrjGkdqOUE6MbefUfa/aG
 27i2E6RsvnGaGB+/z9y06klX/b9CvcijwE+ndyYd/P5Xoqi/kZ9C9BnLhq3sYqdRCWdG
 2wZA==
X-Gm-Message-State: AOJu0Yz5yPCZ7oKr47CR2Log5WKOZpboKn3m/EyEH/XAIw7986FDwfFW
 jVoETh03Hxj15N8ldrQJhMOAsLLLwFM1zs/RcMdvZvXBQY4zAnqdzeryxz5fUB2NCqHlGYdPmhU
 =
X-Gm-Gg: ASbGncurcTwP9qkIrjUr8Ihw77M/31qhy0vVwgVgPWhroF+EWfH/w4DAyfs91s8nlNw
 rZ9aGmR4WqdJmSkMxfrQArEry6N/6nlI4CZiZ7pqiYehhoaDuDTtghWxQ3VpBPm/TBpjIdr1ii9
 xX/MUMIuB/PfekXjUEImwL5ml11sEJaahsDdgf9fq6qPeb1Qs9ceURoR8aT5uBbgxCh0y4DYhiZ
 qEXXivSgzrsAUQeC9IgRa+PU5sQu8Up4SnBSSrOc65XIBNyAzezXVD30/oL4w6p03dg/kAull6n
 /Sot96DN2xYbOhfyIbR5JMCfqVQxaJtK+2aUOn39Ft9m6W4HhZQrMZc19DILI01IlTkZCtZSce4
 nmQoTFiDO+DHn
X-Google-Smtp-Source: AGHT+IEJfo/8aOqpa31pcLlkk6Gqh362OjrsaWH/8ERfsREXEgUMKvHp/PsPK6lsWIJ/ylxAq87S9w==
X-Received: by 2002:a92:ccc6:0:b0:3d9:6cb6:fa52 with SMTP id
 e9e14a558f8ab-3d96cb6fbefmr12905645ab.12.1746024020433; 
 Wed, 30 Apr 2025 07:40:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f2a2f73sm8580995ab.3.2025.04.30.07.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:40:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/2] net: Use a forward declaration for cmd_tbl in net-common.h
Date: Wed, 30 Apr 2025 08:40:00 -0600
Message-ID: <20250430144014.1698011-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

We don't need to include command.h just for this declaration. It
eventually pulls in linux/byteorder which causes a conflict with exfat
which has its own byteorder functions.

Use a forward declaration instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/net-common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net-common.h b/include/net-common.h
index 12c50e2a41e..f2613a41ad8 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -4,7 +4,6 @@
 #define __NET_COMMON_H__
 
 #include <asm/cache.h>
-#include <command.h>
 #include <env.h>
 #include <hexdump.h>
 #include <linux/if_ether.h>
@@ -13,6 +12,8 @@
 #include <rand.h>
 #include <time.h>
 
+struct cmd_tbl;
+
 #define DEBUG_NET_PKT_TRACE 0	/* Trace all packet data */
 
 /*
-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: fix-net
