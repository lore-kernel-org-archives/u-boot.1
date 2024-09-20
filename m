Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4698CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0582389354;
	Fri, 20 Sep 2024 08:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YPjQrIgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268EF8931B; Fri, 20 Sep 2024 08:03:11 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192598932B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so230134966b.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812188; x=1727416988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4LkKy/biW7n9xuKyOH0uAVMDeqUoxV5ZdcfRtAzC1I=;
 b=YPjQrIgtmSpmk5Xhz3uU6kpH1VXrJXgX/SbsqPMx3YUx7eW5iuvs+K/0UJyxHgLeXP
 2AFPrhm1KnadL0N2ifGXmqBvynyfiwkqJ3H9ZZVOFnSR3cXdoCXGBM1yR9U4d1ZCjdtH
 emjKokTtfaT5gipGLWNX5BNK8BTZNhRnrb80c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812188; x=1727416988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4LkKy/biW7n9xuKyOH0uAVMDeqUoxV5ZdcfRtAzC1I=;
 b=HGJY0dkiD/o4rxr5Az40XQi0hvHA39I/dCczMvvI96dm2zus2MbwTamIpEgwfxZtO3
 0w11oOdGMvFGhCG9lwxQ4WGTmDe79FPgz7Nj6wHEIvcTjzfefaVV3+T5a8GNjcEmOjp1
 ElAsYyB8MklaeXh+P1CzTL4TH5ekmc5iIqpb0pF9/DbKu6v6IisdZ0/d+uF5uU/kB3/S
 mE6oihjBHvFbgm44rn1OwPh2Gk7Lod0vx0hURjZEuhaMdO3tp5F2qUzFl0rK4Eve3iNr
 CyFxnbyXBIvTDSG5qLu8JB5IzdV+4u05gcEP9miYlezmlnCw2UHCn0onspiU2X+iZTLg
 khnA==
X-Gm-Message-State: AOJu0YwpZaEU3WQvWaBR1LDBOmWPs2gOh4J0aJqyaY4flbd+H04+Kb6b
 DoE8LkkocYmdP9liAAxWnQDr3Q2lkoATLBtDQcRT28rErCk6td+22OQkAma3JyyH4BOww+F22rR
 cPPW7C0c=
X-Google-Smtp-Source: AGHT+IHGvMJL5lARv7HYmuHOgBaNvKSHf09+RSEooZvUclxxcZHtx4OWLi9tXrY6mo2/k/vNsiwh2Q==
X-Received: by 2002:a17:907:f151:b0:a86:7021:1368 with SMTP id
 a640c23a62f3a-a90d5613552mr121061466b.21.1726812188107; 
 Thu, 19 Sep 2024 23:03:08 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 10/19] test: Detect dead connections
Date: Fri, 20 Sep 2024 08:01:45 +0200
Message-ID: <20240920060158.106612-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/conftest.py     | 19 +++++++++++++++++--
 test/py/u_boot_spawn.py | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 03dfd8ab562..9eea65b5929 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -25,6 +25,7 @@ import re
 from _pytest.runner import runtestprotocol
 import subprocess
 import sys
+from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Globals: The HTML log file, and the connection to the U-Boot console.
 log = None
@@ -287,6 +288,7 @@ def pytest_configure(config):
     ubconfig.gdbserver = gdbserver
     ubconfig.no_prompt_wait = config.getoption('no_prompt_wait')
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
+    ubconfig.connection_ok = True
 
     env_vars = (
         'board_type',
@@ -453,8 +455,21 @@ def u_boot_console(request):
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
index bcba7b5cd43..24d369035e5 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -8,6 +8,7 @@ Logic to spawn a sub-process and interact with its stdio.
 import os
 import re
 import pty
+import pytest
 import signal
 import select
 import time
@@ -27,6 +28,43 @@ class BootFail(Exception):
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
2.43.0

