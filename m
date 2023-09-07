Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946B7EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B08286B3B;
	Thu,  7 Sep 2023 18:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IwRWJonx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE0886B43; Thu,  7 Sep 2023 18:00:32 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7801F86B36
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so47888539f.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102428; x=1694707228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9TSod6OMmR7aPZVLRg7hfsLajEfRnQJrI9ow2ikSos=;
 b=IwRWJonx6L8+CRgIe5m1gBMca45EGsgfkpvr1sJCnp9GQCzLKnDR3Cn1h7Or2pGmp+
 X1y3LNgrmkvSHoEE9KDE6Ghu+gt5BqKG+qNd/Za337ifaTq33F8CwbYJQrnqUMEfHoDL
 4lyNwuwgVXKA71e5jy1i/SP8Rpw7w9G2zG8x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102428; x=1694707228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9TSod6OMmR7aPZVLRg7hfsLajEfRnQJrI9ow2ikSos=;
 b=UuZuZ5FplvKszlIpEULnLDrsjWAh53G55G7ssZZr7yx+sFqlfFooJNCm5RIwk0fTRR
 46aJmg6YQKT5SVR7ggUVr7Z4d7qfQzYgUkinxIwUDXG1EFGvPd6t9SZAOkdM5m3GEszu
 iw8D2QKDYzII63FP8A5n4rMeyuNEZ7SA1mISxapYPsKNo7NZ/6QHAF+5zIi8FOJ3AreT
 GVGe6kzv/IrJmVGYKROZf0UVTau15jaEHm6GPUZGCGI7RGWOdN/Fy/ZMZhGlhn/b63zD
 D2cUsJZOzYEUxh3EYlMs4gM39D2uDTggyoXTHeoZAi0Dwj2iP3qGEtu1GufDtr/vrgrk
 ACgw==
X-Gm-Message-State: AOJu0YyEy81R9+9zJBiuPAQ2j83JuGGJoyezfH9+eZ+2AdfriSESH1b/
 9dqI0AsBC3eQSmQfDWh8REsKt8kmtKPNRkcghvA=
X-Google-Smtp-Source: AGHT+IH6DHeD95lQlHWoRzgpcr5qQhCqTJtQh0uRX0sMbTbPw94c180lVa5OHSzJMEgI7tMHybR3FQ==
X-Received: by 2002:a5e:8809:0:b0:787:8cf:fe8a with SMTP id
 l9-20020a5e8809000000b0078708cffe8amr142858ioj.2.1694102428149; 
 Thu, 07 Sep 2023 09:00:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a02a805000000b0042b39b2289asm5699209jaj.102.2023.09.07.09.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:00:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/4] buildman: Start the clock when the build starts
Date: Thu,  7 Sep 2023 10:00:19 -0600
Message-ID: <20230907160023.49339-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907160023.49339-1-sjg@chromium.org>
References: <20230907160023.49339-1-sjg@chromium.org>
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

The Kconfig and maintainer processing can take a while, sometimes 5
seconds or more. This skews the timing printed by buildmand when the build
completes. Start the clock when the threads start to avoid this problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/buildman/builder.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index ecbd368c47a5..5305477c5be6 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -328,7 +328,7 @@ class Builder:
         self._build_period_us = None
         self._complete_delay = None
         self._next_delay_update = datetime.now()
-        self._start_time = datetime.now()
+        self._start_time = None
         self._step = step
         self._error_lines = 0
         self.no_subdirs = no_subdirs
@@ -1778,6 +1778,7 @@ class Builder:
         self._prepare_output_space()
         if not self._ide:
             tprint('\rStarting build...', newline=False)
+        self._start_time = datetime.now()
         self.setup_build(board_selected, commits)
         self.process_result(None)
         self.thread_exceptions = []
-- 
2.42.0.283.g2d96d420d3-goog

