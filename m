Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4230CC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764DA8210D;
	Thu,  8 May 2025 09:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lIaeOXDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A938211F; Thu,  8 May 2025 09:35:08 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BF38059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54addb5a139so833470e87.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689704; x=1747294504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YwxkpXk85oRcagJ+fFKbozgr+c1aoljpUDNeJ9dxT0=;
 b=lIaeOXDJjEodaO0WQdtHQbXV1hPXwEtkkkkiWwcwqL+SVKH8ZBSwOXAWIAmwYL1bXV
 LamDhcpGS1PK5561y8FxtrExrk0RjOedtcIF5zaMMr/A1NkdltUr/H3vu6gO1D7Y8b0q
 FD6oqjqK2TMn2naodMnL4V23ktEF43by06Sqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689704; x=1747294504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YwxkpXk85oRcagJ+fFKbozgr+c1aoljpUDNeJ9dxT0=;
 b=BVJGqEdv4XU7w8nGXVrbsGDXmCmR1YiJCQB4AF9LoiGphkUzYUY5Qo6dHUiLIkaQo6
 94S2x4zVIxAvudn8wG0Ozo+FGkufOOPeTF5gT3j9/ju7vfwev3G0ERjTgQhoqV1SkE9s
 x3uH0lf3QoH973TN8EYcEe8pKOBYv8ITIoTHN5CAdsefvQ7ifbZ8Vq0LJpEt5AfU05AH
 B1e0Qf8wS+c5nXLljQMbFc7UdqkzhgsAvzjvLwYaVZqsmxFGbsjwXgOa2+imKXJrj6ZU
 Bpa0WAXxC3V3KJKj9mfvF8CuktPK/0CMpe6TIpxUxhUCenJlANbmhNd2vc7d5afusx0g
 PYzg==
X-Gm-Message-State: AOJu0YzG4An3GfHS51ll5JXIQ1rhWwiONpqTq/LbUro1LYuH2ZHcrvuV
 XIL+4XRzGd+nhNDmPAyXd8ZSBd4X9dEqjGSIy0oW/8bCG3thnycbHEkqjlDGIGBey5VyoYZLvwN
 w3sfx6e5ctQ==
X-Gm-Gg: ASbGncsdKCQchEhT9hPoLjhbJk7dGmWY7fbFEsyOheWh0I3pXL3SJfVfThVdJUEVJ+C
 OjjMkD7ILOnyefRCAg3oAgZDJZiXEj55/qMYVgX3zhbIMILdzMVxhVIBHEJjoBHIN2Y4tKfcBim
 cnaSgb+xweTwBC3+9HbSwFMcwc17sYmXcIml/1OvrBiMuRSPC8iByyhd6bNR1d96DkA/+q4O1FP
 e0V34nUiR3LtHkwOul8XrezEfWJGT3Y8tLojfyWjVMBE/H91priuKRreWOXF6pl3HWvFKv5E3Rx
 EjyKJRR6b05izHEkntsHhOJ6Jy5uRvVF/67nJg==
X-Google-Smtp-Source: AGHT+IER9gDfy6S4V75H7VTtpKyF0kSwH+K4EbXwHtl31Q+TTEtSsrkGcYKIgyyqDD76e9FjUOPISw==
X-Received: by 2002:a05:600d:3:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-442d095339cmr19966305e9.0.1746689387046; 
 Thu, 08 May 2025 00:29:47 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/20] patman: Move -H out of the send command
Date: Thu,  8 May 2025 09:28:42 +0200
Message-ID: <20250508072907.207175-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

This is the help for the whole of patman, so move it to the start of the
control function, rather than being inside 'patman send'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py |  2 +-
 tools/patman/control.py | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 912d488ff74..0ae92f88c4b 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -215,7 +215,7 @@ def parse_args(argv=None, config_fname=None, parser=None):
     # If we have a command, it is safe to parse all arguments
     if args.cmd:
         args = parser.parse_args(argv)
-    else:
+    elif not args.full_help:
         # No command, so insert it after the known arguments and before the ones
         # that presumably relate to the 'send' subcommand
         nargs = len(rest)
diff --git a/tools/patman/control.py b/tools/patman/control.py
index fbf368cb2fa..902b5092e9c 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -110,6 +110,15 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
 
 
 def do_patman(args):
+    """Process a patman command
+
+    Args:
+        args (Namespace): Arguments to process
+    """
+    if args.full_help:
+        with resources.path('patman', 'README.rst') as readme:
+            tools.print_full_help(str(readme))
+        return 0
     if args.cmd == 'send':
         # Called from git with a patch filename as argument
         # Printout a list of additional CC recipients for this patch
@@ -123,15 +132,12 @@ def do_patman(args):
                             cca = cca.strip()
                             if cca:
                                 print(cca)
-
-        elif args.full_help:
-            with resources.path('patman', 'README.rst') as readme:
-                tools.print_full_help(str(readme))
         else:
             # If we are not processing tags, no need to warning about bad ones
             if not args.process_tags:
                 args.ignore_bad_tags = True
             do_send(args)
+        return 0
 
     ret_code = 0
     try:
-- 
2.43.0

