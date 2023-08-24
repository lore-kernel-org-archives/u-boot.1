Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09479C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EEA86555;
	Thu, 24 Aug 2023 05:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YIQS9wcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF3786548; Thu, 24 Aug 2023 05:03:27 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4128486536
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34ccc0fca24so3015845ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846203; x=1693451003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5SrNQpHw5LPHu3jFv8AnAcdHv8c05hcYhec0mP4f90=;
 b=YIQS9wcM8lkNtTxZmeaH+mtw/+xQOn6bU+KF33qLSyJkt7FL0QUj394F4SkPsREUH4
 QfAMXN6t9hySZ2nv35ip9kyB2smjxKV+LY5Wb97v/lg1BGyHWSlhJwUaUqoNoZ/ixfQ9
 4SiLY/+QAPOfzSnfs4q6NkfalKLWyXzf51Ue4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846203; x=1693451003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5SrNQpHw5LPHu3jFv8AnAcdHv8c05hcYhec0mP4f90=;
 b=gwtbj8qHR4Km3pDJtto0zvdQGAYg9Us/Ex4AuuW2fL6MNHnwFhedvHqrR1XxP5GreC
 N3j1ftPUMh0zqS1J5LJ9Vk5wVlnuN83oBSMz/BnV5OgwsdpCVE0L7Q79aVYyD74ic0r6
 j6p1sVAB2d55VspN+8eAJAicKuVH0bR6O1oIt6kug2tJjvX13hCbvS71udkZfsQWh6FH
 kLAzV81ibU/HrQE+pkLfgHvZmQRqG4vSRrkD+1jdsx+ftybC6at6tn5xXWwpG5iUAx5j
 nYuWtstr3rkHmWyrqW1qWHYJAigNCvVJ0SrcrM574tzVXHARYp4sO5ViYTYQgYXPTCOA
 1sHw==
X-Gm-Message-State: AOJu0YwB9FkmNw5B4j8CjswXjC3bFzlduODBPUx4nEA3glxeuRS/r0++
 9BtX830iPmldBu6Eq1Cpur8xbmj4LeI/it1u9FE=
X-Google-Smtp-Source: AGHT+IEkO7X45l+nsaR9+k1ZineJHmH4XOxBhy7AXnpDCKn3A3a3+pG/DzVy2jRNtuyPXSeHIV/ZoQ==
X-Received: by 2002:a05:6e02:1a65:b0:34c:a9b5:55d with SMTP id
 w5-20020a056e021a6500b0034ca9b5055dmr4980684ilv.21.1692846202839; 
 Wed, 23 Aug 2023 20:03:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/6] buildman: Show progress when regenerating the board.cfg
 file
Date: Wed, 23 Aug 2023 21:02:56 -0600
Message-ID: <20230824030304.1555547-4-sjg@chromium.org>
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

This can take a while, so show a message when starting.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by Tom Rini <trini@konsulko.com>
---

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
2.42.0.rc1.204.g551eb34607-goog

