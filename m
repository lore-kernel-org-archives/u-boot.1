Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AA6D1CA07
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8C388DE6;
	Mon,  4 Nov 2024 23:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xvuf1w/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5247888FAA; Mon,  4 Nov 2024 23:46:13 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F50D88D29
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e6075cba82so2319048b6e.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760369; x=1731365169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlheGeuo0Q4NReR8CGnDBoYD1xWhSji/d8yw6EQBpZE=;
 b=Xvuf1w/f/pphz64na3r35Prf6ENVxhMs2/rXMKU86a8uBVsWZgEoOrtc0SeezfbFWv
 Ypg7orSGis+5PR8pQtdcvXN4R1AQRxySQU7IqpFwOP6rDQFEY4VuU941W9Ebm28L+Q6L
 4eTx4vTDepX00xVMTh/LNBwehQKmnP3nxgJmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760369; x=1731365169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlheGeuo0Q4NReR8CGnDBoYD1xWhSji/d8yw6EQBpZE=;
 b=xLL3o7vBfPze/2wfqPXYJG67pTxWxntHgvlItP7gwTtg/O1trvsqP15x1FtVLpXdKz
 W6J9juQ6qKnUkCKRcCPOXoAHao9eh2H+JVAh0rtoDtGeTISpyO+vfx8OvkvTddud86Q8
 2fektfhp0jpyVksHOWVdoI4ipU2+5Op43sGVkiT3BYle9Wx08h5WciKg1134/fWJOpUw
 LJ36C62u2PIGs0OgWhWORic6dM08sy8iXsaY0hIoQ/PQzVb64oVPLGKYZOWl4Y+JNWaO
 sQeoiarJePS6CqCspqB9LQOZm/zoE07U30evjjqjcVHytTSHGxx8x3QzynRsaeJLO5eo
 wWbg==
X-Gm-Message-State: AOJu0YxnUyjCVWwsH3lqK7qUfsi93FPs7YoSU+jmpzOXk1aSFC9YIXA0
 g+rZvWO/jM1YIgUnCk7u1FyUP3nH2yajUC+IsUeASPiAgwO9IGFSc0UoQEeJX65OEu7TSsINNb4
 =
X-Google-Smtp-Source: AGHT+IF0KO4w8tri2xwDrZ6VO3KnJ0/F/OakWJUxkLedhuCFzc2DzpqG3jOxtBRNjkh/FGMVk/va6g==
X-Received: by 2002:a05:6808:1787:b0:3e7:6020:4cfa with SMTP id
 5614622812f47-3e760204f1fmr9453358b6e.0.1730760368820; 
 Mon, 04 Nov 2024 14:46:08 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 04/11] test: Introduce the concept of a role
Date: Mon,  4 Nov 2024 15:45:31 -0700
Message-ID: <20241104224550.677442-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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

In Labgrid there is the concept of a 'role', which is similar to the
U-Boot board ID in U-Boot's pytest subsystem.

The role indicates both the target and information about the U-Boot
build to use. It can also provide any amount of other configuration.
The information is obtained using the 'labgrid-client query' operation.

Make use of this in tests, so that only the role is required in gitlab
and other situations. The board type and other things can be queried
as needed.

Use a new 'u-boot-test-getrole' script to obtain the requested
information.

With this it is possible to run lab tests in gitlab with just a single
'ROLE' variable for each board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v7)

Changes in v7:
- Update --role help and get_details() comment to mention Labgrid-sjg

Changes in v5:
- Add a few more comments
- Comment out the debugging, which might be useful later

 test/py/conftest.py | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 7a52b966154..5c8d2fdba31 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -23,6 +23,7 @@ from pathlib import Path
 import pytest
 import re
 from _pytest.runner import runtestprotocol
+import subprocess
 import sys
 from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
@@ -80,6 +81,7 @@ def pytest_addoption(parser):
     parser.addoption('--gdbserver', default=None,
         help='Run sandbox under gdbserver. The argument is the channel '+
         'over which gdbserver should communicate, e.g. localhost:1234')
+    parser.addoption('--role', help='U-Boot board role (for Labgrid-sjg)')
     parser.addoption('--use-running-system', default=False, action='store_true',
         help="Assume that U-Boot is ready and don't wait for a prompt")
 
@@ -131,12 +133,40 @@ def get_details(config):
             str: Build directory
             str: Source directory
     """
-    board_type = config.getoption('board_type')
-    board_identity = config.getoption('board_identity')
+    role = config.getoption('role')
+
+    # Get a few provided parameters
     build_dir = config.getoption('build_dir')
+    if role:
+        # When using a role, build_dir and build_dir_extra are normally not set,
+        # since they are picked up from Labgrid-sjg via the u-boot-test-getrole
+        # script
+        board_identity = role
+        cmd = ['u-boot-test-getrole', role, '--configure']
+        env = os.environ.copy()
+        if build_dir:
+            env['U_BOOT_BUILD_DIR'] = build_dir
+        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
+                              env=env)
+        if proc.returncode:
+            raise ValueError(proc.stderr)
+        # For debugging
+        # print('conftest: lab:', proc.stdout)
+        vals = {}
+        for line in proc.stdout.splitlines():
+            item, value = line.split(' ', maxsplit=1)
+            k = item.split(':')[-1]
+            vals[k] = value
+        # For debugging
+        # print('conftest: lab info:', vals)
+        board_type, default_build_dir, source_dir = (vals['board'],
+            vals['build_dir'], vals['source_dir'])
+    else:
+        board_type = config.getoption('board_type')
+        board_identity = config.getoption('board_identity')
 
-    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
-    default_build_dir = source_dir + '/build-' + board_type
+        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
+        default_build_dir = source_dir + '/build-' + board_type
     if not build_dir:
         build_dir = default_build_dir
 
-- 
2.43.0

