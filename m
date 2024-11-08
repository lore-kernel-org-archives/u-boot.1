Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E2D5C0ED
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CB489242;
	Fri,  8 Nov 2024 16:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUf14/Ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14C8891E3; Fri,  8 Nov 2024 16:24:08 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AABA88B1F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83a9be2c0e6so84867439f.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079444; x=1731684244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAvNIhgOy0BkMGvGCO4KJbkM/7Ty9o0beYADpTaZC5c=;
 b=MUf14/Ec95fzI4lcSxeb4+rP3LRrjHQmbPAjzlJ83MLPLejDtfxGIEec0HJg8DjcI1
 KSbUlQ1SrcpcaYyaFiiAmYiVXID6WvqtMpwzcG08RVeNjcvonfq8QACoOGwmvfGFSbry
 xOTuB58L25BDA7gah6bZrIgrSIbu/MCArQCUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079444; x=1731684244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAvNIhgOy0BkMGvGCO4KJbkM/7Ty9o0beYADpTaZC5c=;
 b=OaLs2hWkaeZmpMwrG5ozzRMDK0A53DNf5RIt2h+77r/bqGz9MzWcEKR6hyDO0/Rugm
 RSXRv0flvhaUBwXYsKxq0AXJaQUhrmNihgYdartdDClk4qw/JC524sIlFUu5afua9a8c
 dnqOyPrARjFdC+m2wvFiddwUqckijc8rI1IrL/7deZZPOvNVTShA3ZupuEgxVeb9SGPd
 H50skey9HHjZv6LAiZ9JaA+bzwN9ngd9fwFZyKX2I9Wy4+aVU6Os06Jr4L0hCyMzWrD5
 G9gU3aSFZIC+lFlMlaUZZ+HEbX7GFIiY1TPN3N7sWPF0VNQY30JU7gedHrdj1Qr5wsnP
 Jt+Q==
X-Gm-Message-State: AOJu0Yyk9IiJi0F/aD9FVz2QSd1At7aISWeAtbHJAcZNGrwSOg7rS8tS
 b1L2CQwasFM6y3SEBHgJa3uarmTwYv59XfubnYWBha7txy1yYheyxSfQaGbW5qmxEDr6250iqLs
 =
X-Google-Smtp-Source: AGHT+IE7iuMabzCtFHaHeQ9WnnlpX8dRdXvUGTADoL6vJdmEkvgaBLXI6xtX0WIh4T+jvtAMXVJvXw==
X-Received: by 2002:a05:6602:2d91:b0:82a:a76a:1779 with SMTP id
 ca18e2360f4ac-83e032e69f0mr395293739f.8.1731079444560; 
 Fri, 08 Nov 2024 07:24:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:24:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 6/9] buildman: Correct logic for adding a toolchain
Date: Fri,  8 Nov 2024 08:23:47 -0700
Message-Id: <20241108152350.3686274-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

If the toolchain is bad, it should not be added. Correct the logic for
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/toolchain.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 0c8a4fa16eb..dab350fec31 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -327,16 +327,17 @@ class Toolchains:
         toolchain = Toolchain(fname, test, verbose, priority, arch,
                               self.override_toolchain)
         add_it = toolchain.ok
-        if toolchain.arch in self.toolchains:
-            add_it = (toolchain.priority <
-                        self.toolchains[toolchain.arch].priority)
         if add_it:
-            self.toolchains[toolchain.arch] = toolchain
-        elif verbose:
-            print(("Toolchain '%s' at priority %d will be ignored because "
-                   "another toolchain for arch '%s' has priority %d" %
-                   (toolchain.gcc, toolchain.priority, toolchain.arch,
-                    self.toolchains[toolchain.arch].priority)))
+            if toolchain.arch in self.toolchains:
+                add_it = (toolchain.priority <
+                          self.toolchains[toolchain.arch].priority)
+            if add_it:
+                self.toolchains[toolchain.arch] = toolchain
+            elif verbose:
+                print(("Toolchain '%s' at priority %d will be ignored because "
+                       "another toolchain for arch '%s' has priority %d" %
+                       (toolchain.gcc, toolchain.priority, toolchain.arch,
+                        self.toolchains[toolchain.arch].priority)))
 
     def ScanPath(self, path, verbose):
         """Scan a path for a valid toolchain
-- 
2.34.1

