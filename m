Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1DEC7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C2788AE8;
	Thu, 29 Aug 2024 00:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CR/jYvVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2CC88A9B; Thu, 29 Aug 2024 00:09:04 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8A8881E7
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39e6a32ae1aso7302945ab.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882936; x=1725487736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llJUBVz/Hv6PyBsN3OgAmBIDrX3QOWUuDi18w/3Jo9s=;
 b=CR/jYvVSWRzur69Vdcf9hlWTdyJZKza/2rFEFnWiivU4ipcoiLS2XM1qGA5v5uS4g+
 psQGCMZ1cs0VJ1JZUkyC4ANAWI8bqVqIY8jSzW4WpNy4CISgZlOdcOE4rSgPLeCbG4JI
 VASR685sTl+RHZXD8a8iB0qzSsqidnKM54dZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882936; x=1725487736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llJUBVz/Hv6PyBsN3OgAmBIDrX3QOWUuDi18w/3Jo9s=;
 b=sBgh4xg8g0OMp3GaiSuzwhDMWwi9mqlWUwY3Na6HK7oQu/8v1UNQkdNXLxTkxRXkwz
 5J2LB18o55LcDbk04JSIc60Lo1Rjq9e03v6Tkg4N7HGQoXMd7VuPb5VVCW73SCLkLMSn
 3t99iP2vfDYSRJFv+XXzKEfrRU+Bh+iff7bXDcB9M5/oPWXFBFonB1i3wDABvnEiDTnx
 L6QHeeI9lKtu7BFdUCe4VbHxZ68EOUTplEcCO0nJAZvBDmsPBZVOxDXqhLdQhoOImN7f
 Qqgh5YopZOzIjw45LcdM3XKPTSC2tluaphQNppAQmuRknszBPBxIxeTsZ77G+bearcSO
 auWg==
X-Gm-Message-State: AOJu0YxLznC3Co5W3oBUlvZAYXQhIC4aTCshfzf6o/gvnkIsNIod0Vj8
 9gc9btXBqAfQ1WZmmFbvXMwOH9L+ZYxl4Tbu8BXid6numa3AV+AwPcWXEHxu25vTdS6GGtFGr0M
 =
X-Google-Smtp-Source: AGHT+IHUQjGMIG9Eu2b4YY3JQH+gGW74x/XC1Dtpm0YBL8r729rq71nSYV5O1nEw22GRwl8xXv9oIw==
X-Received: by 2002:a92:c56f:0:b0:396:c825:4db6 with SMTP id
 e9e14a558f8ab-39f378693cdmr12580295ab.26.1724882936406; 
 Wed, 28 Aug 2024 15:08:56 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 08/20] test: Introduce the concept of a role
Date: Wed, 28 Aug 2024 16:08:34 -0600
Message-Id: <20240828220846.1205813-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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
2.34.1

