Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55097EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F8D86B4C;
	Thu,  7 Sep 2023 18:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L6N/S1MH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6355786B47; Thu,  7 Sep 2023 18:00:33 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF25A86B0E
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34b4b2608e3so4692735ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102427; x=1694707227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qFge+TEdu7UFg/Oif2SVdTzVoiK71ndOG9LYwkkyOA=;
 b=L6N/S1MH3uG4KgTswfm4AXHhtkBFaIY42oNBi982NuNNTIdhP9civAFNq4I7+ShPE5
 4qTPyzNvZGcFu09Un1Vlu/f4i+bnFrxIxv3fNazwtRfVcr9wJox672CuyVWenNNmHw6C
 a9lc2xoISjM+aZJYlQ7LfxaMGtyPvUlarAZa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102427; x=1694707227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qFge+TEdu7UFg/Oif2SVdTzVoiK71ndOG9LYwkkyOA=;
 b=DAc6mcDUNVWiulbPaln2ATP/zWUgEEFKHtvr5bZULLYqueFOKGDMhGPakYxj9Mqfy5
 eepaGhqRr59ZS4nGpmIxUbtdBenK0itQT6DZDxf4YsOd2uLe5RXYf+aR7dm04XwmiVRl
 WrWgYlJkJD9gasIwWqquRG9aduk2hGV4ctv2tSkfUXz571GF6yhBL6EIj4mDbp+nhgMT
 wKwEUBB0C/AVjyHSw9E3he/yebYa0saQR/k1cJkJtxn+Fx3j5ozQ411O8JbDzkat3GQw
 8WzrZiA3R6X3k0MVvcwAOL6r3J1eKs2VXr4k+6zKLSq9jdNrz47BDCYcF3oQIONJhOOj
 C1ZQ==
X-Gm-Message-State: AOJu0YxGfrWr+jU3omMibs8EJYhnwQnLmb1RX2t5p7IabrqjLbdqfM3E
 0ksbUZggwXcf+Y2y5Xds1tv3ps4pN8RC+6jLREc=
X-Google-Smtp-Source: AGHT+IGF56q0mxIzL6cEbb5WKnByw8n4xfXNuA8hxQM/WjqHUO3cTbHVOj+USoeyR6I3mPLFFaoHCA==
X-Received: by 2002:a05:6e02:18cd:b0:349:36e1:10fb with SMTP id
 s13-20020a056e0218cd00b0034936e110fbmr160758ilu.18.1694102427343; 
 Thu, 07 Sep 2023 09:00:27 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a02a805000000b0042b39b2289asm5699209jaj.102.2023.09.07.09.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:00:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/4] buildman: Show progress when regenerating the
 board.cfg file
Date: Thu,  7 Sep 2023 10:00:18 -0600
Message-ID: <20230907160023.49339-3-sjg@chromium.org>
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

This can take a while, so show a message when starting.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/buildman/boards.py  | 15 ++++++++++++---
 tools/buildman/control.py |  3 ++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index eef3f19f7ad6..341a5056dfd2 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -19,6 +19,7 @@ import time
 from buildman import board
 from buildman import kconfiglib
 
+from u_boot_pylib.terminal import print_clear, tprint
 
 ### constant variables ###
 OUTPUT_FILE = 'boards.cfg'
@@ -863,11 +864,19 @@ class Boards:
         Returns:
             bool: True if all is well, False if there were warnings
         """
-        if not force and output_is_new(output, CONFIG_DIR, '.'):
+        if not force:
             if not quiet:
-                print(f'{output} is up to date. Nothing to do.')
-            return True
+                tprint('\rChecking for Kconfig changes...', newline=False)
+            is_new = output_is_new(output, CONFIG_DIR, '.')
+            print_clear()
+            if is_new:
+                if not quiet:
+                    print(f'{output} is up to date. Nothing to do.')
+                return True
+        if not quiet:
+            tprint('\rGenerating board list...', newline=False)
         params_list, warnings = self.build_board_list(CONFIG_DIR, '.', jobs)
+        print_clear()
         for warn in warnings:
             print(warn, file=sys.stderr)
         self.format_and_output(params_list, output)
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index f2ffb7f5b4aa..8f6850c52113 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -621,7 +621,8 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
     if not brds:
         brds = get_boards_obj(output_dir, args.regen_board_list,
                               args.maintainer_check, args.full_check,
-                              args.threads, args.verbose)
+                              args.threads, args.verbose and
+                              not args.print_arch and not args.print_prefix)
         if isinstance(brds, int):
             return brds
 
-- 
2.42.0.283.g2d96d420d3-goog

