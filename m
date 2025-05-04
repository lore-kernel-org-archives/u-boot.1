Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF17C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C28A82A33;
	Sun,  4 May 2025 15:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="meQseQbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC25E829A1; Sun,  4 May 2025 15:24:15 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC10F828F8
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso5077561a12.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365052; x=1746969852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMUxDioyQj7gVBoXbO2Q7Dj04pX6GBYdPHkwAloK8p4=;
 b=meQseQbj58rUGis177QEHhXCNt6DTYvL3QSz4VL3EV7epDNbRDqO0Kc+li5MQCOWaK
 SaObtRZ3AeJH8WT0T185PWKhhn1bVYtOmQe6pZpDXPQ05dL6JDMqg+rd87tDl/xQhrCY
 SXMIDk20BnIM7oGSMIHQvwYBz2GS3er2bOjiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365052; x=1746969852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMUxDioyQj7gVBoXbO2Q7Dj04pX6GBYdPHkwAloK8p4=;
 b=q2/ITUTszH7u6TOw09Ol7p8oa62k95/jvl0vTx6EGyoPDjl+AlMHYwTTfi9sbNv8UR
 MnNUjqx6gvFCNh7aK0HY5lyGfLg4CZNQfeQ2CxSH46D5MT+pskNRY3xSjaPlRaHEWRyW
 ACV8MtaRU1nX59WentRZBXOGCByBCBtxagOokcUDwpBWDQNkJsHn6PTuNvwNIKl2x4mW
 riTRYLmcNwaNK94jwTnZM8F8Tsy5a8VwvaiUJljoKLVM1OLsmkVhFZYZOoj/V1SgVE2w
 J+vlDjTdDokrx5b60vx+ZUePbgt/xAcx/Ik7RGYfhdtfuX58PXiXkfkZDB6QYbb2Srra
 /4Vw==
X-Gm-Message-State: AOJu0YyS3jnvjarzYrtIxSJvY8Kkx1I1CCfLWqIuv9nc98bhiyW4PTy8
 aan23W6aE+rH014E04xeiFvv+QKxZjG48upzTB6tkNHUR/Dj4dmpr6mJ0hAVlHLRlu2Jtee84TD
 RXrslOOA=
X-Gm-Gg: ASbGncvJJEcsUJr//aLHCnF2TC4US2gJv9G7u+EJQ3oaUeRSGFqasl1wTQ+D7TN4/nH
 gVY8qmw9KW7GIH80ih+5UwRR5pAkoo1XTOL+hoQUPaZ7z0OH/h3nQcQ4NNjkZyX3TO62msA3JUz
 lso0fbUNlj3vUEJRRevriGwJ269RZ0TF48MD7CAit+dWiQIv9udJpDR8WqasyymCmbybjj1rr6m
 E8Nb4sTPbBiACTZUrt2D+AikYqA3MWjJ7vygt/hhtv2I/g6li156P4eOXB9dbsKV+8BPiRobYj7
 4/BLT786Jti52aWhDEPGJqtW2l+mzr3iuclKhaTShj0W54w=
X-Google-Smtp-Source: AGHT+IH8MoVTs7E5R7VdnbObp9/l7WJqAUeXz8qaT3hECu8aYA1fU/d0cxsNSprnn36D2LCUszN0pw==
X-Received: by 2002:a17:907:2dab:b0:ac7:95b5:f5d1 with SMTP id
 a640c23a62f3a-ad19083700dmr478943166b.42.1746365052600; 
 Sun, 04 May 2025 06:24:12 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/30] u_boot_pylib: Add a pager
Date: Sun,  4 May 2025 15:23:22 +0200
Message-ID: <20250504132356.2317305-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

