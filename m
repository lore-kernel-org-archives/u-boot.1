Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEADCC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF3488630;
	Fri, 21 Jun 2024 21:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fEHy4Ece";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE8188607; Fri, 21 Jun 2024 21:52:37 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CEF88599
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ebe508fa34so122842039f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999554; x=1719604354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54GyErOHdkl6Mj5KSztJvPK1M75Zlg/531bGCoQa6Os=;
 b=fEHy4EceAfr6iTEpL108CFu/Bvi5GTR483p/wVIcr+D1S2Iz7aBH6SyduVvh2uOFqp
 ZGTd0A0ldx36uKSa++ZFrUVBD+TuOLbnRG/tN9zly6biOfyRB8fawCXzfA4JJsldiINg
 6Xdu/QVPc+qDYsfLKT9mMWpJJ1uzwy6FdTu9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999554; x=1719604354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54GyErOHdkl6Mj5KSztJvPK1M75Zlg/531bGCoQa6Os=;
 b=D2QpxGZEiynAYd9hAxt8cXHdxFAKHTgstbbQz5IsQpu6LSx9iInKgIB+cuzzmvh7Wj
 ufqYQ+4dBoYMlsvVt6FP3gejVjpOZlByfgMiYVU+cNXVadoSGu7eidHMrFwIINi9ephW
 zod4Z3P6wX3L5ybuNtFi6rF4c/s/rHL6eogjzNb/IGl+OeB0/TA3hEewM0c0enMN4+Z7
 nxKBEJURXYQBY+FkWlvUMmJewp7/gBpvFYUe443FDWlLfKo6BQfYuMHYrugEeh/refAA
 WbpBy7NS2C3bY6s5VhGn9EB5p8Dh+H52shytwvrxl5tf6NNdoqQ1LfDhYQ3ls1QPu64y
 qi2A==
X-Gm-Message-State: AOJu0YyXMNtpbZ6efD+mttyvOkRP0YPJjaMtZtOryzN+Ji706B66SquS
 3AyhWXBDr5U7VkUQvgKqHeLFGynne2GP1L6h7E4SAXP6LaWR48n0sT9zhAuoiGn8s7YpFmpiw24
 qKw==
X-Google-Smtp-Source: AGHT+IHwQqg5NY+Lb4IpyotVv3vC7eQzhFgq18BVI3UZaigyIALa8LvEEGAOlVUrqRV6c3tAY9z8jg==
X-Received: by 2002:a05:6602:6b0a:b0:7eb:832e:eecf with SMTP id
 ca18e2360f4ac-7f13ee7a8bemr1072133339f.17.1718999554052; 
 Fri, 21 Jun 2024 12:52:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 31/43] test: Introduce the concept of a role
Date: Fri, 21 Jun 2024 13:51:52 -0600
Message-Id: <20240621195204.2675252-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

