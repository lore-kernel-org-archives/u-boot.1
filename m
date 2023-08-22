Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7EAEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C24C871C2;
	Tue, 22 Aug 2023 05:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OZ5e4KbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF1D871C1; Tue, 22 Aug 2023 05:17:24 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E00871CB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-349a94f3d69so12304335ab.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674238; x=1693279038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97t7VoREUZdeGDBBTW8dQQIYtDYXfK05eAImPvkMWn0=;
 b=OZ5e4KbUECva/kzyurzr9R/RJzWAfNUeU7003SnDBroO+R1Cm+DkXZk9sdtWvkCCpl
 AZOP2MuRNNY9f47PFT/oN9WP8Yh8G91d8lLKw6/7WyV0NGVjYynW+tOi1fLhPGoucvit
 szMDfmHGrgmfWn16bCrBrSjwQwG5xQmJFbQZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674238; x=1693279038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97t7VoREUZdeGDBBTW8dQQIYtDYXfK05eAImPvkMWn0=;
 b=j5TpJq7rgOfNftCiz/Kp4UDYb4tOZizQCOmxfd9kHHqEg+RnzkEao3Cn8c23KkwEsO
 Up6pUeCfZCFMnksJH2EoSz4SVSNoN98iX4xFNLL1XgrZZErlHFfcOEeBFvaZosWQs7bM
 6j2Wiqy26JotkE/DkXt7oXTQxWCeoLLiKg3mXyoXmZdsgVb4fkecB5pYysg789fSN+1c
 TC9hCji7zPXC9Z044N0oCXTd0nz5950pmKSc14nh+RcrrG+kLqjKWcCA5na3mtBq0GJd
 qU5HN/H0wRqHDznchupD/6ubXI6W6pPD71eggbiqAQcneCCszG4i0WaBxIgPG1zsFbJ5
 tHqw==
X-Gm-Message-State: AOJu0YwixZIdKmiKG1XxVHsh69I/DIi5WrLRvqnhYGG1gs9KzD7m1d7u
 oaGTK5Xw5bn4ghk8ukInxREEH+nL4xP2jBGIP3c=
X-Google-Smtp-Source: AGHT+IEsIRssKvzRiB3SwVF6ldYyVQ+oK2qEF4/vndqp9G7ytNCC0zTYmN6B6i2wtx1JFfe+oSDHcQ==
X-Received: by 2002:a05:6e02:1084:b0:349:9a8b:c949 with SMTP id
 r4-20020a056e02108400b003499a8bc949mr7654481ilj.8.1692674238665; 
 Mon, 21 Aug 2023 20:17:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/14] event: Update documentation for simple spy
Date: Mon, 21 Aug 2023 21:16:58 -0600
Message-ID: <20230822031705.1340941-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Now that we have two types of spy, mention this in the documentation. Put
the simple spy first, since it seems to be the common case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/event.rst | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/doc/develop/event.rst b/doc/develop/event.rst
index cb09e9c85a9a..d5043ec4f4ca 100644
--- a/doc/develop/event.rst
+++ b/doc/develop/event.rst
@@ -21,16 +21,31 @@ Declaring a spy
 
 To declare a spy, use something like this::
 
-    static int snow_setup_cpus(void *ctx, struct event *event)
+    static int snow_check_temperature(void)
     {
         /* do something */
         return 0;
     }
-    EVENT_SPY(EVT_DM_POST_INIT_F, snow_setup_cpus);
+    EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, snow_check_temperature);
 
 This function is called when EVT_DM_POST_INIT_F is emitted, i.e. after the
 driver model is initialized (in U-Boot proper before and after relocation).
 
+If you need access to the event data, use `EVENT_SPY_FULL`, like this::
+
+    static int snow_setup_cpus(void *ctx, struct event *event)
+    {
+        /* do something that uses event->data*/
+        return 0;
+    }
+    EVENT_SPY_FULL(EVT_DM_POST_INIT_F, snow_setup_cpus);
+
+Note that the context is always NULL for a static spy. See below for information
+about how to use a dynamic spy.
+
+The return value is handled by the event emitter. If non-zero, then the error
+is returned to the function which emitted the event, i.e. the one that called
+`event_notify()`.
 
 Debugging
 ---------
@@ -80,6 +95,10 @@ to be notified when a particular device is probed or removed.
 This can be handled by enabling `CONFIG_EVENT_DYNAMIC`. It is then possible to
 call `event_register()` to register a new handler for a particular event.
 
+If some context is need for the spy, you can pass a pointer to
+`event_register()` to provide that. Note that the context is only passed to
+a spy registered with `EVENT_SPY_FULL`.
+
 Dynamic event handlers are called after all the static event spy handlers have
 been processed. Of course, since dynamic event handlers are created at runtime
 it is not possible to use the `event_dump.py` to see them.
-- 
2.42.0.rc1.204.g551eb34607-goog

