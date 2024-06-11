Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537DCC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9276588826;
	Tue, 11 Jun 2024 22:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sp/xsN3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5651887B4; Tue, 11 Jun 2024 22:02:44 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C0C887B4
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-7eb715a3411so59256639f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136161; x=1718740961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H79prm0oFv/uWfC6EV+xxTIFkUSPkDa59IkT7ktXOok=;
 b=Sp/xsN3HbneEcZ54zeOvbfEuJOpKMo1W2Xpe4+pknfQzP6g6MWlvLvoN2F6l+GgVRQ
 gA3Zp431Y0hEWRFchHYkaBLt1MoVvudjquhTk9R1qyPXEmnCa4rD+YRvg1z5yRWBKYii
 HEqcfoefU6A5/41TqTaI6ij/JaxNKNNkspPyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136161; x=1718740961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H79prm0oFv/uWfC6EV+xxTIFkUSPkDa59IkT7ktXOok=;
 b=p9JRk90EVf52OQG+p7ZO2gnZD2O/juaE3efq/IO8CA9P98gjLVLG/2BqaLGLdF2V+z
 BmFrz3p21y3W7ax0D3vG//NfT8P6rhQnU0R5EiC8dzkJP7FF9RubV5L0ymlHCFT99i1F
 ez84onuTqC5viZSXLdrEDa2nZ4QwgJUAUWc5G7mv6AkNKPnAOA60FSVLZBymfFu/WOQy
 4M5q671Q5wSVC6aKIutvOZZvZis8vnL0jKUaRnTznyByoBekZlyz3j7AHFCZha1DJ9/N
 Jk171OMC1e82j4iPEQNXRknvaDwNJVcCLZm6sIXs+nvHcAsBngupfzptIRzcLi9WXh95
 dSFQ==
X-Gm-Message-State: AOJu0YzalFZpgPuyowTwV8KD09fpFQId6zDlSE2Ne6M1rieWYdrgQ8Kd
 /WRbkIIYXknh3XyMmPMblFkZe5UxclvkkMFCqh+YBKG9qFuPl2aDVe0XYVOUGx/YoVZ+3fKUmLB
 odRTC
X-Google-Smtp-Source: AGHT+IGrrRfyxA24wy0mLfPx7uyN4/WWKdqLh3WyYJS7boB/s4tvFfOt7Wpss0VIddRZmNnWBLob9w==
X-Received: by 2002:a05:6e02:1606:b0:375:a7ee:dff9 with SMTP id
 e9e14a558f8ab-375a7eee19cmr81233565ab.17.1718136161306; 
 Tue, 11 Jun 2024 13:02:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 34/42] test: Detect dead connections
Date: Tue, 11 Jun 2024 14:01:48 -0600
Message-Id: <20240611200156.2245525-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

When the connection to a board dies, assume it is dead forever until
some user action is taken. Skip all remaining tests. This avoids CI
runs taking an hour, with hundreds of 30-second timeouts all to no
avail.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/conftest.py     | 19 +++++++++++++++++--
 test/py/u_boot_spawn.py | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 5de8d7b0e23..42af1abd72e 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -25,6 +25,7 @@ import re
 from _pytest.runner import runtestprotocol
 import subprocess
 import sys
+from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Globals: The HTML log file, and the connection to the U-Boot console.
 log = None
@@ -280,6 +281,7 @@ def pytest_configure(config):
     ubconfig.gdbserver = gdbserver
     ubconfig.no_prompt_wait = config.getoption('no_prompt_wait')
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
+    ubconfig.connection_ok = True
 
     env_vars = (
         'board_type',
@@ -446,8 +448,21 @@ def u_boot_console(request):
     Returns:
         The fixture value.
     """
-
-    console.ensure_spawned()
+    if not ubconfig.connection_ok:
+        pytest.skip('Cannot get target connection')
+        return None
+    try:
+        console.ensure_spawned()
+    except OSError as err:
+        handle_exception(ubconfig, console, log, err, 'Lab failure', True)
+    except Timeout as err:
+        handle_exception(ubconfig, console, log, err, 'Lab timeout', True)
+    except BootFail as err:
+        handle_exception(ubconfig, console, log, err, 'Boot fail', True,
+                         console.get_spawn_output())
+    except Unexpected:
+        handle_exception(ubconfig, console, log, err, 'Unexpected test output',
+                         False)
     return console
 
 anchors = {}
diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 57ea845ad4c..62eb4118731 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -8,6 +8,7 @@ Logic to spawn a sub-process and interact with its stdio.
 import os
 import re
 import pty
+import pytest
 import signal
 import select
 import sys
@@ -28,6 +29,43 @@ class BootFail(Exception):
 class Unexpected(Exception):
     """An exception sub-class that indicates that unexpected test was seen."""
 
+
+def handle_exception(ubconfig, console, log, err, name, fatal, output=''):
+    """Handle an exception from the console
+
+    Exceptions can occur when there is unexpected output or due to the board
+    crashing or hanging. Some exceptions are likely fatal, where retrying will
+    just chew up time to no available. In those cases it is best to cause
+    further tests be skipped.
+
+    Args:
+        ubconfig (ArbitraryAttributeContainer): ubconfig object
+        log (Logfile): Place to log errors
+        console (ConsoleBase): Console to clean up, if fatal
+        err (Exception): Exception which was thrown
+        name (str): Name of problem, to log
+        fatal (bool): True to abort all tests
+        output (str): Extra output to report on boot failure. This can show the
+           target's console output as it tried to boot
+    """
+    msg = f'{name}: '
+    if fatal:
+        msg += 'Marking connection bad - no other tests will run'
+    else:
+        msg += 'Assuming that lab is healthy'
+    print(msg)
+    log.error(msg)
+    log.error(f'Error: {err}')
+
+    if output:
+        msg += f'; output {output}'
+
+    if fatal:
+        ubconfig.connection_ok = False
+        console.cleanup_spawn()
+        pytest.exit(msg)
+
+
 class Spawn:
     """Represents the stdio of a freshly created sub-process. Commands may be
     sent to the process, and responses waited for.
-- 
2.34.1

