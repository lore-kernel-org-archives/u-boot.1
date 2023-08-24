Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C3C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B219C86536;
	Thu, 24 Aug 2023 05:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O31SGjWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1C286549; Thu, 24 Aug 2023 05:03:27 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0110986435
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34cb979c9b9so8262435ab.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846203; x=1693451003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BB+DX2Bqn8OFM3PQqnjpGw3yCH/cWanWnflN3ohxC/Y=;
 b=O31SGjWmlj0bac/g2QHfjuUHotFi2Ex+VMVM1cp2VZmqDmD1O6XJImrYEvnZMGuoGa
 76quLGAPEnBKi+8S1GuZbJeEolWPkOImx7Ngz2kOPS/lHf0zWTkhQDFfT88i7m3qtaU4
 SWZt2uvaAb6r4xtRBFA3KA70AlIrL70dsfVGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846203; x=1693451003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BB+DX2Bqn8OFM3PQqnjpGw3yCH/cWanWnflN3ohxC/Y=;
 b=DyM7mGQG8tFWypW1ZaVEhsqWrEgFZh69o3e/EIjO5smH2QvKlTHuO7r9LSeTfKlC/O
 lm0xNl3H91Zq+5hcfro4J2ydihHammlzccW0i8I5CDlJ44KXKgDja/Z3ZeKz61dOao7D
 rWowe0irqoMASxzaZob2n3shnUJQ0tUG0ftp8SotcnwaE00hgyfFoTLaeX6A50N4OYk9
 IsqPw/mFZ0IM5MNL60rirvGmWNxvrYDJdDZZvaydk9D1cTS4Fu/25xdPyGjuMKS2EEU4
 tXBzNNTfXcWphrgIGIuu61Wp+aRLRp6r3CWP8u99TQls4WgDXz4OnrdoeCCfV15KooPQ
 aOGQ==
X-Gm-Message-State: AOJu0YyV/72nphVZt6cHcn5P5yHuqVj6cpPRu9J/kqAZVG5hzxSLr/Ux
 Lj3Sly4J3xGuYSZnaVys3+FS/3ABmSWHYFH/hz0=
X-Google-Smtp-Source: AGHT+IHSnmzUCPEcSjpGZ26HI08GbpI4Ysr5Mz6cmG8xLwzSt7JNr59MpBnLXc2NNezKeO+0k7O1fA==
X-Received: by 2002:a05:6e02:1ba5:b0:348:fe78:e9d0 with SMTP id
 n5-20020a056e021ba500b00348fe78e9d0mr5372792ili.6.1692846203581; 
 Wed, 23 Aug 2023 20:03:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/6] buildman: Start the clock when the build starts
Date: Wed, 23 Aug 2023 21:02:57 -0600
Message-ID: <20230824030304.1555547-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
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
2.42.0.rc1.204.g551eb34607-goog

