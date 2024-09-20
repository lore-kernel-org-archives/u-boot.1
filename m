Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE40CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A5E8936D;
	Fri, 20 Sep 2024 08:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CP4++zh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0242E89369; Fri, 20 Sep 2024 08:03:21 +0200 (CEST)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90F689347
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x142.google.com with SMTP id
 2adb3069b0e04-5365392cfafso1690369e87.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812198; x=1727416998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NO/lobEVmaIsrGcEREu4l9gt2Ln1qG3zFc1IWMBYUvg=;
 b=CP4++zh0y2+wg6+vC4mqr/DaAjK8viBrm4iFGmynSwNoMfl4sYP0iUzB62B7h/ld9f
 0CO4gS+gQmYATmZ6gfLzPQ5OaupsF4m20t247hX2vSlZVJR04r6K/JBd0wNybnzwA0Lt
 aBYsqinvkeqpytIbUlgbGSQ08LKssWKK6JXcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812198; x=1727416998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NO/lobEVmaIsrGcEREu4l9gt2Ln1qG3zFc1IWMBYUvg=;
 b=URmaC55S5wb7F/ENfUGg7ZEdNeuQ0YGoOfA6C1enzlPQMxSnMGa5Fk1/g1saEGdJmP
 Hyd84NKSn05X/7/AiV5xPjdy0qaUx93bO0kwk3t6ba3nZi0M+AjSF4Xc+v0gS8pkC+7U
 qOJ/ezAcqNSoGqJlNaO7JhV9m6j9RpjEmskKPCdujmHrDPYyunqz54B4Z4OEq6+QJXGE
 HOE3RHb5ws97wVvCjkXUKciU+VPiMBdnEJmtCvhWQts04cS3AoaSGKYFgTXbFfqfoB2H
 VghR4C3rd+lPLLRWV3Q+wS4cnPeWw2alBjkmNJZD/qXvwVzDz1Ej5iNfQBBZ9yASPfdP
 0RtQ==
X-Gm-Message-State: AOJu0Yy3Z7gh/mwFoaWc8qps1pdy/l0t1slXqB+6DVh2INuHX9yziaTR
 DllWKbVAsEmUSCDnTvJcN0pW0Qrpf6TIU3Yu+Z0cxh7d/cg2kXIVolnrL8sX5T7P/I2rsJ5u9w4
 SgZ7GtLM=
X-Google-Smtp-Source: AGHT+IGSh3ALLKFl08E8O+8xDEcD+qEQaZmprww9uWcjq1+oI6hCKqKYHag01/eHZYdV9h5ONCIjAw==
X-Received: by 2002:a05:6512:1293:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-536ac34094fmr836993e87.57.1726812197865; 
 Thu, 19 Sep 2024 23:03:17 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 18/19] test: Support testing with two board-builds
Date: Fri, 20 Sep 2024 08:01:53 +0200
Message-ID: <20240920060158.106612-19-sjg@chromium.org>
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

The Beagleplay board uses two entirely separate builds to produce an
image, rather than using an SPL build for this purpose.

Handle this in test.py by adding more parameters.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Add a patch to support testing with two board-builds

 test/py/conftest.py | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 9eea65b5929..542c0d53e46 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -66,12 +66,16 @@ def pytest_addoption(parser):
 
     parser.addoption('--build-dir', default=None,
         help='U-Boot build directory (O=)')
+    parser.addoption('--build-dir-extra', default=None,
+        help='U-Boot build directory for extra build (O=)')
     parser.addoption('--result-dir', default=None,
         help='U-Boot test result/tmp directory')
     parser.addoption('--persistent-data-dir', default=None,
         help='U-Boot test persistent generated data directory')
     parser.addoption('--board-type', '--bd', '-B', default='sandbox',
         help='U-Boot board type')
+    parser.addoption('--board-type-extra', '--bde', default='sandbox',
+        help='U-Boot extra board type')
     parser.addoption('--board-identity', '--id', default='na',
         help='U-Boot board identity/instance')
     parser.addoption('--build', default=False, action='store_true',
@@ -129,14 +133,17 @@ def get_details(config):
     Returns:
         tuple:
             str: Board type (U-Boot build name)
+            str: Extra board type (where two U-Boot builds are needed)
             str: Identity for the lab board
             str: Build directory
+            str: Extra build directory (where two U-Boot builds are needed)
             str: Source directory
     """
     role = config.getoption('role')
 
     # Get a few provided parameters
     build_dir = config.getoption('build_dir')
+    build_dir_extra = config.getoption('build_dir_extra')
     if role:
         # When using a role, build_dir and build_dir_extra are normally not set,
         # since they are picked up from Labgrid via the u-boot-test-getrole
@@ -146,6 +153,8 @@ def get_details(config):
         env = os.environ.copy()
         if build_dir:
             env['U_BOOT_BUILD_DIR'] = build_dir
+        if build_dir_extra:
+            env['U_BOOT_BUILD_DIR_EXTRA'] = build_dir_extra
         proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
                               env=env)
         if proc.returncode:
@@ -159,24 +168,36 @@ def get_details(config):
             vals[k] = value
         # For debugging
         # print('conftest: lab info:', vals)
-        board_type, default_build_dir, source_dir = (vals['board'],
-            vals['build_dir'], vals['source_dir'])
+
+        # Read the build directories here, in case none were provided in the
+        # command-line arguments
+        (board_type, board_type_extra, default_build_dir,
+         default_build_dir_extra, source_dir) = (vals['board'],
+            vals['board_extra'], vals['build_dir'], vals['build_dir_extra'],
+            vals['source_dir'])
     else:
         board_type = config.getoption('board_type')
+        board_type_extra = config.getoption('board_type_extra')
         board_identity = config.getoption('board_identity')
 
         source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
         default_build_dir = source_dir + '/build-' + board_type
+        default_build_dir_extra = source_dir + '/build-' + board_type_extra
+
+    # Use the provided command-line arguments if present, else fall back to
     if not build_dir:
         build_dir = default_build_dir
+    if not build_dir_extra:
+        build_dir_extra = default_build_dir_extra
 
-    return board_type, board_identity, build_dir, source_dir
+    return (board_type, board_type_extra, board_identity, build_dir,
+            build_dir_extra, source_dir)
 
 def pytest_xdist_setupnodes(config, specs):
     """Clear out any 'done' file from a previous build"""
     global build_done_file
 
-    build_dir = get_details(config)[2]
+    build_dir = get_details(config)[3]
 
     build_done_file = Path(build_dir) / 'build.done'
     if build_done_file.exists():
@@ -216,7 +237,8 @@ def pytest_configure(config):
     global console
     global ubconfig
 
-    board_type, board_identity, build_dir, source_dir = get_details(config)
+    (board_type, board_type_extra, board_identity, build_dir, build_dir_extra,
+     source_dir) = get_details(config)
 
     board_type_filename = board_type.replace('-', '_')
     board_identity_filename = board_identity.replace('-', '_')
@@ -281,9 +303,11 @@ def pytest_configure(config):
     ubconfig.test_py_dir = TEST_PY_DIR
     ubconfig.source_dir = source_dir
     ubconfig.build_dir = build_dir
+    ubconfig.build_dir_extra = build_dir_extra
     ubconfig.result_dir = result_dir
     ubconfig.persistent_data_dir = persistent_data_dir
     ubconfig.board_type = board_type
+    ubconfig.board_type_extra = board_type_extra
     ubconfig.board_identity = board_identity
     ubconfig.gdbserver = gdbserver
     ubconfig.no_prompt_wait = config.getoption('no_prompt_wait')
@@ -292,10 +316,12 @@ def pytest_configure(config):
 
     env_vars = (
         'board_type',
+        'board_type_extra',
         'board_identity',
         'source_dir',
         'test_py_dir',
         'build_dir',
+        'build_dir_extra',
         'result_dir',
         'persistent_data_dir',
     )
-- 
2.43.0

