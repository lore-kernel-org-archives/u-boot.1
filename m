Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00284CEDDB1
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F7B888FB5;
	Thu, 10 Oct 2024 03:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="de4nhjYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF3A88F48; Thu, 10 Oct 2024 03:51:58 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2035388DD4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a3938e73d3so2215315ab.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525115; x=1729129915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2J8sBMzjLz+fBQ2gejZ11xpYqgv0f98X7vavTrJ48s=;
 b=de4nhjYF4MJmCqAEJqq4NnogzNW+YA7/LoUSeyBjZbkfZQK7Td3LYxjJ5dBL1s8CL3
 OG1TpOFO23H/wZZBqXagz4fbp+r1gO/4aYFTbFucDXmiOxyOxOgmNvz3qqeq+vB7ShGE
 FEC4vh/A3H6q6i2OKo07N6S1QKpkNWIcYwhJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525115; x=1729129915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2J8sBMzjLz+fBQ2gejZ11xpYqgv0f98X7vavTrJ48s=;
 b=Bj0dVXSynS9YUw151A3qnxb3MtyvvkYhWUQfqifvHlK9cZeeiw7Yczb67eRqg2HT9p
 8z+YncsdXQA/JihGz/KH1u8+G40ZCNZExu/GNJz6wqpVnCI96WOt9VFTP6nztFd7tUrP
 ytSTxgf0FxbJMO5/56QawZ0EkQNDZ5t5/JCXsEce9nz8Tsc7Ll3knysSUBFN0ZLpBmYH
 g8gcktffUNytn2r1IGb7MDtg+q88iaf56sQntgGOj+lLkCkSg9uas0nlO9OYqMBDb/ei
 RM7DXTUqI+1kXHI9MyBBN1ZQoUWYmqtkjmONm7hGF/zvAOk7KRiIH0qS3LPKZVwWaf7k
 tuxg==
X-Gm-Message-State: AOJu0YwQ3GvZuPGZiQ8uHAYISt8blCCO6Bhr5j0mGSJI3xDmWyW8dYFH
 oyYqed21wz1tvVTO1irB4OWAf7ncznQWSRQcVq+Nfjr11S0BWlewBO4MaKFXLTexMq89spwi6YH
 z0A==
X-Google-Smtp-Source: AGHT+IHOARfHqxoI+MhfJ+CU5eUPqasdGJf3Nf2jVWzFbuOXgo547c2opKd8BQLSyKEO+LRG08lw/w==
X-Received: by 2002:a05:6e02:1609:b0:3a0:92b1:ec4c with SMTP id
 e9e14a558f8ab-3a397d2c52amr48811965ab.23.1728525114748; 
 Wed, 09 Oct 2024 18:51:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 04/11] test: Introduce the concept of a role
Date: Wed,  9 Oct 2024 19:51:38 -0600
Message-Id: <20241010015145.1977999-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010015145.1977999-1-sjg@chromium.org>
References: <20241010015145.1977999-1-sjg@chromium.org>
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
index 7a52b966154..4a45e080df9 100644
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
+    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
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
2.34.1

