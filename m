Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ACAC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6482082948;
	Tue, 29 Apr 2025 15:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="azRafsLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC0D8283E; Tue, 29 Apr 2025 15:23:54 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DF2828A2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c3b863b8eso4741479a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933031; x=1746537831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTdWs7ziR9nHxWkkRtte/eyZYmkd64rrxHKZMDtraoU=;
 b=azRafsLrosLiP9ybJMjN+QhFCipN7TUVhIedrSIIKgotOON5Be39AdAMJEYjAcE6A2
 9cGa38KvWSu3RWnPyfs/2/reYOivFa4YtQgrt1MD6lyxuMmMgORLx2UQWHiDyFJfpZqM
 FijaxpAQh1LMTBZ9w38Otx07VPdy/YFFjEzWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933031; x=1746537831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTdWs7ziR9nHxWkkRtte/eyZYmkd64rrxHKZMDtraoU=;
 b=uARxYKlopUgNNBOdqW6LWkPRjP6zyGDytIc9HvWCAcCzlDi2SZvCaXbXEH22c1j+F5
 9bFtB8bSCpP3BRlS77VKB91BlTj9SuLC0WTxlwXwSXv7DQ0sb+1IUi6+dXLIKlKtiMml
 /f2fJNj6Jz6bIOVZoBoi7roDzRKwhOHnZWseK0ZF6bp4zia9v194BYVRjVd1QIDyjOsk
 8le6pv/bOb/iPLL5sqmpHwyHei+36YTSTs04UGjmE9MgR9iBaa9+kNcyIgZtY6lVyhMk
 LH/ASC7Kvhzgo/J92tl6IJPNI+yE3uUnEvPdOxLrOnhC/wIJ5dlCzRtk7QDWQWGt8gY6
 7hXw==
X-Gm-Message-State: AOJu0YySI8cb9Uancr1EU5XueWtdr3t8CvyYc+H7a/76xqUjqIat2yuU
 BOXMFTyCSJpfGoOVZwYleY/aG9k2Vj91+DAp+eNSFLRGwsDfWcoRtRG9o1uVStrO8DnCe9FXX6A
 =
X-Gm-Gg: ASbGncs03Ttoudm6MeZqu3vapgj4vLGOLbfJRNY/ogUuLXbj4m3dutRh24/jDZdo65n
 ozyzkLP2cj08o/mPbyOdEJeVONZ2qfx0HBwRTbWt4LKElhnHqiNiET4Z4h7ftjfPpeDjkAFFQ+M
 9rqlX7JVXAMxGnBaHrlNy/99/lEsQ5KRNlUwrUPGp1tYJ4jFn0mn9InqXJGZuVeXHB3Nl9bU1Xo
 BDejDOg4O9waVq5ucB6/nvphCelwQlpi18wN596IG+8hSk2oeQUoEZA5dH3WQ8aWYXUgdiAbDEp
 NiPsGxlxEizSwu3yECobmqbOoswlFsLi4xAFdrc14zIseZMU0ZSkhjRMRz70D+hWUV+aj7VH0Iu
 KLA==
X-Google-Smtp-Source: AGHT+IG+J1Zzg//bno7MpHTAjGPAs8ylCoQ2YHk2sqQXgiH68wkmHuFxfxGGVHO35brtgBrj+xTlmw==
X-Received: by 2002:a05:6830:d01:b0:730:5d6:5990 with SMTP id
 46e09a7af769-73088cb8cf4mr2369509a34.24.1745933030948; 
 Tue, 29 Apr 2025 06:23:50 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/30] u_boot_pylib: Add a pager
Date: Tue, 29 Apr 2025 07:22:03 -0600
Message-ID: <20250429132239.251756-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

It is useful to have a pager when outputting a lot of text. Add support
for this in the terminal library, making use of a context manager.

Also add a function to indicate whether the output device is a terminal
or not, while we are here, to avoid duplicating this code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/terminal.py | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/u_boot_pylib/terminal.py b/tools/u_boot_pylib/terminal.py
index 6bd790acc3f..69c183e85e5 100644
--- a/tools/u_boot_pylib/terminal.py
+++ b/tools/u_boot_pylib/terminal.py
@@ -12,6 +12,7 @@ from io import StringIO
 import os
 import re
 import shutil
+import subprocess
 import sys
 
 # Selection of when we want our output to be colored
@@ -211,8 +212,16 @@ def echo_print_test_lines():
         if line.newline:
             print()
 
+def have_terminal():
+    """Check if we have an interactive terminal or not
 
-class Color(object):
+    Returns:
+        bool: true if an interactive terminal is attached
+    """
+    return os.isatty(sys.stdout.fileno())
+
+
+class Color():
     """Conditionally wraps text in ANSI color escape sequences."""
     BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)
     BOLD = -1
@@ -309,3 +318,29 @@ def capture():
         if not USE_CAPTURE:
             sys.stdout.write(capture_out.getvalue())
             sys.stderr.write(capture_err.getvalue())
+
+
+@contextmanager
+def pager():
+    """Simple pager for outputting lots of text
+
+    Usage:
+        with terminal.pager():
+            print(...)
+    """
+    proc = None
+    old_stdout = None
+    try:
+        less = os.getenv('PAGER')
+        if not CAPTURING and less != 'none' and have_terminal():
+            if not less:
+                less = 'less -R --quit-if-one-screen'
+            proc = subprocess.Popen(less, stdin=subprocess.PIPE, text=True,
+                                    shell=True)
+            old_stdout = sys.stdout
+            sys.stdout = proc.stdin
+        yield
+    finally:
+        if proc:
+            sys.stdout = old_stdout
+            proc.communicate()
-- 
2.43.0

