Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2101C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7947B8857D;
	Sun, 23 Jun 2024 22:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XM5EInds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15806882E6; Sun, 23 Jun 2024 22:32:29 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E389D882E6
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-37611e6ed4dso15478965ab.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174745; x=1719779545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54GyErOHdkl6Mj5KSztJvPK1M75Zlg/531bGCoQa6Os=;
 b=XM5EIndsUn+qCmAx6HNvCx5rthJhP8uUX1ZgGrNRgkxFyFursa340YpPX12OQIVIH5
 ScJmUNLUpecDSOxosifSmDlEvJCY1mwCBZZrrlsWWbdl68usJOKCDi+pmZtipJ8FwmPd
 7LN2eS7GV9/VZmN5KuHS095MnWsnYNwhIPUhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174745; x=1719779545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54GyErOHdkl6Mj5KSztJvPK1M75Zlg/531bGCoQa6Os=;
 b=sKgDmjuJACjji4PD1bHdw8O+8jnHQvxmam2lJfRtpR5/NO8aKnDkTjsi7+htOe4F+V
 Av9tUGBdRHd626CIMlRGPx8trhOWAE7i4gZdQtVvYRchL1fefICnnihr2xqRnHmDwPta
 rPwNVWc/qW590uGlqV0vN8SSP8sBd3ZAEvaYi4IXDap7v2IitgbJiU+MYNDSocv1aeL5
 cG3y+XxGkciHR3hLEc2dMrbMzxv1xjX+UEYnvVwYm0U+OFfIs/F4rdrfSEvNrkX7kJyL
 GHktH1fUlLLHABYVnOgNrhjQzo/MHsRSdZCf88kVlv8l7lKsBSWiSl/i9r0wjHObt/Nh
 KOjA==
X-Gm-Message-State: AOJu0Yw/OniyNjZGkCmsD+5t8HJOTo4NmgcHIlgTw6JjsojYfphuHQU1
 n6kU+oN1LcDlDiL/f/ajXm2e14DMEeUXjqAyYjjFy3MJP3dPA1ikGEC2Jk9ME0bTPwMFrNR3tEW
 KeA==
X-Google-Smtp-Source: AGHT+IHPGPOZ0dL7Ixy0xfR9lUXDiPJ5gJaGMXreiUB/d/nsYaJiSjLHcdZg/CEYRqLX28w1hIXuJg==
X-Received: by 2002:a92:ca0d:0:b0:374:5a2d:178 with SMTP id
 e9e14a558f8ab-3763f5adca5mr38822635ab.2.1719174745430; 
 Sun, 23 Jun 2024 13:32:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/19] test: Introduce the concept of a role
Date: Sun, 23 Jun 2024 14:32:02 -0600
Message-Id: <20240623203213.1571666-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/conftest.py | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 6547c6922c6..5de8d7b0e23 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -23,6 +23,7 @@ from pathlib import Path
 import pytest
 import re
 from _pytest.runner import runtestprotocol
+import subprocess
 import sys
 
 # Globals: The HTML log file, and the connection to the U-Boot console.
@@ -79,6 +80,7 @@ def pytest_addoption(parser):
     parser.addoption('--gdbserver', default=None,
         help='Run sandbox under gdbserver. The argument is the channel '+
         'over which gdbserver should communicate, e.g. localhost:1234')
+    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
     parser.addoption('--no-prompt-wait', default=False, action='store_true',
         help="Assume that U-Boot is ready and don't wait for a prompt")
 
@@ -130,12 +132,33 @@ def get_details(config):
             str: Build directory
             str: Source directory
     """
-    board_type = config.getoption('board_type')
-    board_identity = config.getoption('board_identity')
+    role = config.getoption('role')
     build_dir = config.getoption('build_dir')
+    if role:
+        board_identity = role
+        cmd = ['u-boot-test-getrole', role, '--configure']
+        env = os.environ.copy()
+        if build_dir:
+            env['U_BOOT_BUILD_DIR'] = build_dir
+        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
+                              env=env)
+        if proc.returncode:
+            raise ValueError(proc.stderr)
+        print('conftest: lab:', proc.stdout)
+        vals = {}
+        for line in proc.stdout.splitlines():
+            item, value = line.split(' ', maxsplit=1)
+            k = item.split(':')[-1]
+            vals[k] = value
+        print('conftest: lab info:', vals)
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
2.34.1

