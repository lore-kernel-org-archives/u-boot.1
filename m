Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CDEC3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7348F82A36;
	Sun, 11 May 2025 16:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BDzTA46Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46B982A0D; Sun, 11 May 2025 16:18:45 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE25A82A4B
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fbfdf7d353so4764526a12.0
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973123; x=1747577923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ST18UxPvhju7MIapNt/8XNgJP26h0uDZ1j+5rZlUhC4=;
 b=BDzTA46ZjY1D6zHOaKuod6QjqUeKcpt6VcF4IKKyrDrxFVXO9lbKrxR6aigoXl1/BH
 ViUvf5oMksx553elUOw4tw4I7mB1PpkBXsrAPThsUqpv43B9VQW8W5a/Eqk2GpUGE9nb
 MgjtsUd5Ggpch6QvOugsQBFXTnX0ugeXU3qIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973123; x=1747577923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ST18UxPvhju7MIapNt/8XNgJP26h0uDZ1j+5rZlUhC4=;
 b=cuD3kCDy3662pu9WFUcLC/7BEUz0Q520IgUWQDRX16t/Fa4QomPVpvTZSQgA6suiI1
 0FHcwDIxwp8o0QHSpEhb6xWnGqot7hEB1hnBDXQp/T0ofbJNx27WrDSGWFtMz9IQisds
 L5XlbAhQXt523r72U1O+ZkHZFU+9Yzv+1aQZY/hEd4Ad8OkgCaeB8uhlq7T1HAbG5Rsu
 R+XCoyLXjBIcmzpz9NNrI6VCIOFyHcMF/j0OXMlWnL1I2HoLA5lkUgN8DLY+SbOaT7PR
 P3IBVOhxaaliojmhLzFnFf2WH08bYfWhZNutKvKctznoRY+B0RJj9Mn/WcMr4LaXEsbq
 Ut9g==
X-Gm-Message-State: AOJu0YywetKWx8WI3qqPBkRDcvVoUjkwNqGY0/y4TPMNNQ3XGPZBdezA
 TkMGY2kFlJiz1zgS1uxG/Zgb13IDKHAx6UnlBdBiz1adJOF8LQtCtckH4PSN0S6/on9dGn7GxPx
 ZKvpkI4RPtg==
X-Gm-Gg: ASbGnctLZalRV1Wn/tC5bW0G70NDeec+FEaoK5O0rZTsY4ZhL08roSWLh30+TWL2xtI
 o7MDArwqDwBqF8+ye+3hbhTVQlQmCsY2Ai0cV+YQhegv4p7+kdXiP5TyCqfOVeHvqSBIxbju1xS
 dYgkrQpT0deyssVoBUKeRy8HjlMMJXpfSY4vbbZV7hJRsy0CkQoU2dCBsN2N9GEaI53lhQx65eg
 mNs5nDAl+EVqBulb4XhZC5MZy1KkVfz9BicjbZxmAdoh8kZZcDip93QEl+bRj1h01GJIhcUf+XK
 T3py9wz0y9cnoPaMuageKWJvneCwQh7xCQ4UJLoSoGFt0k4=
X-Google-Smtp-Source: AGHT+IGy3FfroxgKyRJoDc2HLS17ZDAP5ClOBy9fdbMF1a6UX1YnI9iIISYu2incnYwMz1LXsUtJmw==
X-Received: by 2002:a17:907:2da1:b0:ad2:3f21:a0a1 with SMTP id
 a640c23a62f3a-ad23f21b350mr341765066b.37.1746973122889; 
 Sun, 11 May 2025 07:18:42 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] u_boot_pylib: Support a fatal level in tout
Date: Sun, 11 May 2025 16:18:20 +0200
Message-ID: <20250511141828.2367318-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141828.2367318-1-sjg@chromium.org>
References: <20250511141828.2367318-1-sjg@chromium.org>
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

It is convenient to be able to print a message and exit. Add a new
'fatal' level to support this.

Update some assumptions about the level, so that the tools continue to
work as now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py    |  6 +++---
 tools/u_boot_pylib/tout.py | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 81f61e3e152..1946656f7d3 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -777,7 +777,7 @@ def Binman(args):
 
     if args.cmd in ['ls', 'extract', 'replace', 'tool', 'sign']:
         try:
-            tout.init(args.verbosity)
+            tout.init(args.verbosity + 1)
             if args.cmd == 'replace':
                 tools.prepare_output_dir(args.outdir, args.preserve)
             else:
@@ -835,9 +835,9 @@ def Binman(args):
         args.indir.append(board_pathname)
 
     try:
-        tout.init(args.verbosity)
+        tout.init(args.verbosity + 1)
         elf.debug = args.debug
-        cbfs_util.VERBOSE = args.verbosity > 2
+        cbfs_util.VERBOSE = args.verbosity > tout.NOTICE
         state.use_fake_dtb = args.fake_dtb
 
         # Normally we replace the 'u-boot' etype with 'u-boot-expanded', etc.
diff --git a/tools/u_boot_pylib/tout.py b/tools/u_boot_pylib/tout.py
index 37849d1450e..ca72108d6bc 100644
--- a/tools/u_boot_pylib/tout.py
+++ b/tools/u_boot_pylib/tout.py
@@ -9,7 +9,7 @@ import sys
 from u_boot_pylib import terminal
 
 # Output verbosity levels that we support
-ERROR, WARNING, NOTICE, INFO, DETAIL, DEBUG = range(6)
+FATAL, ERROR, WARNING, NOTICE, INFO, DETAIL, DEBUG = range(7)
 
 in_progress = False
 
@@ -42,12 +42,12 @@ def user_is_present():
     Returns:
         True if it thinks the user is there, and False otherwise
     """
-    return stdout_is_tty and verbose > 0
+    return stdout_is_tty and verbose > ERROR
 
 def clear_progress():
     """Clear any active progress message on the terminal."""
     global in_progress
-    if verbose > 0 and stdout_is_tty and in_progress:
+    if verbose > ERROR and stdout_is_tty and in_progress:
         _stdout.write('\r%s\r' % (" " * len (_progress)))
         _stdout.flush()
         in_progress = False
@@ -60,7 +60,7 @@ def progress(msg, warning=False, trailer='...'):
         warning: True if this is a warning."""
     global in_progress
     clear_progress()
-    if verbose > 0:
+    if verbose > ERROR:
         _progress = msg + trailer
         if stdout_is_tty:
             col = _color.YELLOW if warning else _color.GREEN
@@ -87,6 +87,8 @@ def _output(level, msg, color=None):
             print(msg, file=sys.stderr)
         else:
             print(msg)
+    if level == FATAL:
+        sys.exit(1)
 
 def do_output(level, msg):
     """Output a message to the terminal.
@@ -98,6 +100,14 @@ def do_output(level, msg):
     """
     _output(level, msg)
 
+def fatal(msg):
+    """Display an error message and exit
+
+    Args:
+        msg; Message to display.
+    """
+    _output(FATAL, msg, _color.RED)
+
 def error(msg):
     """Display an error message
 
@@ -153,13 +163,13 @@ def user_output(msg):
     Args:
         msg; Message to display.
     """
-    _output(0, msg)
+    _output(ERROR, msg)
 
 def init(_verbose=WARNING, stdout=sys.stdout, allow_colour=True):
     """Initialize a new output object.
 
     Args:
-        verbose: Verbosity level (0-4).
+        verbose: Verbosity level (0-6).
         stdout: File to use for stdout.
     """
     global verbose, _progress, _color, _stdout, stdout_is_tty
-- 
2.43.0

