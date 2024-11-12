Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0134D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1783888001;
	Tue, 12 Nov 2024 15:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m7TKtPdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A527F89460; Tue, 12 Nov 2024 15:13:41 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FE289443
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83ab694ebe5so221864439f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420817; x=1732025617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcl1GeiFI6Fyc663qrmpxXxU2eRdhy2FLP27rcgRVww=;
 b=m7TKtPdZfffznNoplwJ5O9FKi+sEHq2wNZ7N1b3DNFm2TrXsVXzQhuC0rY+QSpEU6d
 phdjOOYt9eBbE9SYJKGTD78tx3+XhV+4jhyasdMbifPGYqzm1qobTD4bqZLpuFMTS1g3
 l20iLfObouzw9QxXV7DwIqTNarGph7+Vl4VT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420817; x=1732025617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcl1GeiFI6Fyc663qrmpxXxU2eRdhy2FLP27rcgRVww=;
 b=m6JPW2j8liPYA78G8OVxkz35xpPYRrvMciwJWxI5s+EaeAeBmjcEEOTwZ91Fc5fwyt
 xoU8RPCiivoLtUd0O2xdG6eZMvPZ/nfBEywt5OC2r8zNjZepiE0m64B+tp265jssC1CM
 ToGOP8YzOuBOLgLGWq6ElMueMhnMTJSYbu2WEBcxGmOXEpMuuzTSF2EDOVtD2XKLvlOi
 BKCPItNmiS5qoBUJpMqDyUKkWsCCRSHJ5TdHoWophJL+b8qGksMUVAyCSxsvYpp9Zea9
 HCt18rA301TsOh46PE+4r9CXWv584wns+gphTd/Raxn4zCMhDkRM3e+g33m2OKLLKYqZ
 5NTg==
X-Gm-Message-State: AOJu0YycL6+zIf0EjreI/lp2rR+0ToCajOmsHYOzPtyDc1d/buh3wxvv
 MtssqBgkmdZAcS4OORIRv7cJg0ckkIJLq09Nr+ufBl7tYHJU9OeLyfbXr4ck0H6fDY3jlbDjI64
 =
X-Google-Smtp-Source: AGHT+IGqo0RKpDj56NQHCJFcXsjRVS9fyU9TCMTpCkwWnDqyulMklx1SZA9PF/yJf8B6vMSboBtURA==
X-Received: by 2002:a05:6e02:1a2e:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a6f19c33b0mr128065645ab.12.1731420817246; 
 Tue, 12 Nov 2024 06:13:37 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 04/12] test: Introduce the concept of a role
Date: Tue, 12 Nov 2024 07:13:18 -0700
Message-Id: <20241112141326.643128-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

Using this role, all required configuration for the board is stored
within the Labgrid environment, with pytest simply querying it. This
allows connecting to boards using an interactive console, something that
isn't possible without some kind of mapping. It also means that we don't
need to replicate the pytest functionality in tbot, since Labgrid can
handle the console and kick off builds as needed.

Make use of this in tests, so that only the role is required in gitlab
and other situations. The board type and other things can be queried
as needed.

Use a new 'u-boot-test-getrole' script to obtain the requested
information.

With this it is possible to run lab tests in gitlab with just a single
'ROLE' variable for each board.

Note that, without this feature:
- interactive use of boards with Labgrid-sjg would require repeating the
  id/board in a separate configuration file
- Gitlab yaml file would need to specify both the id and board

This feature is entirely optional, however, with the code gracefully
falling back to using a separate ID and board.

Link: https://tbot.tools

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v9:
- Expand the commit message to explain the value of a 'role'

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
2.34.1

