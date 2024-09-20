Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59203CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABED689372;
	Fri, 20 Sep 2024 08:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jz3Oje7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BD389347; Fri, 20 Sep 2024 08:03:21 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA8389333
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53659867cbdso2538329e87.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812186; x=1727416986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaS64qdPfg65WSR3ojBzmqXsoIfKyBGCD0ldk3Nxg2w=;
 b=jz3Oje7OjD6FdjtvckCRIEswZ2xc+jejywdnuoK9pnubzGR++8TM8HrpWvqi+NOCAe
 IS6fT1PQFw5H8lFleTORZYSqs0AsI6of2FUm8GgOq/MOWWKRI6iBD+c0120oIsxbZNNP
 kM/RnIw5rbSkuov1ULzWuFpmm6Uy21H+V528U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812186; x=1727416986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaS64qdPfg65WSR3ojBzmqXsoIfKyBGCD0ldk3Nxg2w=;
 b=Cdx1iUoIztwHSfMNmgJvRYE8wZIVAqjOIElidgPoSjQVq+U/aFQh8X+aMsdXl0ZXwg
 N24YCpzetGTE0Y5f6tocpeTtFcu7RAnmY4SAPxkuZlBj9GIqcg1E7yqaxph9vyJxyhtg
 CDHtlWu0opmUkgCTGp5gxeZ4RZhMC2PtJ/TaDmFm2BpW0hKjAxP8TnYwSRewn7pTmQ3I
 pcQ1UDgt5sJFU5UuQ/vSI8rgvJ1JzOk5Xz6cb1Y7HdMGvGMhAM2es0VYvC1XZGXqMKDa
 AeBmrZ/O6GquGFYDtBVCbH+MCeVSxSEIo7BzTSxELZzscO33bG37+5TnsJm4ulGpDJhW
 d6cg==
X-Gm-Message-State: AOJu0YzeD+x6u6OJgB+i6AVPxfWdli51W5+XCwHh3eVud8ycm0pWfVLa
 qCfqFIJGXyCS//PgpKalr4SuAJaiaAOIK9I4sbRE8SIfQIPkkCBTLipyKe+8EM/nj4W7prEHCZb
 Uz3yA
X-Google-Smtp-Source: AGHT+IFC8/5QvcLh9IUBgE22D3OsuC/Im9OL1uN+mSloLj1tB0bF+eq6sB2ARELa53weQ0Sjum06Ew==
X-Received: by 2002:a05:6512:3f18:b0:536:7362:5912 with SMTP id
 2adb3069b0e04-536ac2f5b3cmr1174795e87.30.1726812185082; 
 Thu, 19 Sep 2024 23:03:05 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 07/19] test: Introduce the concept of a role
Date: Fri, 20 Sep 2024 08:01:42 +0200
Message-ID: <20240920060158.106612-8-sjg@chromium.org>
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

(no changes since v5)

Changes in v5:
- Add a few more comments
- Comment out the debugging, which might be useful later

 test/py/conftest.py | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 6547c6922c6..03dfd8ab562 100644
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
 
@@ -130,12 +132,40 @@ def get_details(config):
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
+        # since they are picked up from Labgrid via the u-boot-test-getrole
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

