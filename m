Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4E7C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5BD88A76;
	Thu, 29 Aug 2024 00:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z1U+Oy0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0741A88969; Thu, 29 Aug 2024 00:09:18 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297B7889EF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39d4161c398so29981935ab.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882945; x=1725487745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bnm8JHiG9FiashdFu+QXFlmjPh02J2SqhRF5Jo0V44I=;
 b=Z1U+Oy0FmpclvwTouOBpJzLBVeQlOatVuC+Ok/SVr2DocrUBDYmmJg29f+mjMczGGA
 QQw/B3tmSmKiu0pEcECBGFSA2djth+3wOxxuw09Z5Jr1oRM2NB5QRM/sTfHELGxuWms0
 MMpRdhFQvDfNhY9blo5P4w3NjslTXWM0e0a/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882945; x=1725487745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bnm8JHiG9FiashdFu+QXFlmjPh02J2SqhRF5Jo0V44I=;
 b=VvgmvSYLFbFjxt8rPHfcpoVyqh0hiOmtj+L1Wmm6p3MTUDCkUwAyC0+7v1z0yFr8gu
 aik2AyRv4PapzODH/pg2CDs1GgId/BlV+TA6ZBiRBt/AvhGC7NDBWnNSk50XspBO4rWr
 7LTqSnVKnLOWJbPUT0XYeeEz4EYhvX5zbaFdlKs16TOx1g2aTJjPI9Ze1qvUdHJLYuto
 ADyBkMaV6etsbMY/suJ9Py9ZkBDOVDnlKBCJ/jrCfc7cQAEtuCRf2sqeVJNyMVK0Aci+
 3D7pLWU5hdLonpYB4KBCI3XPvyfqKC9oXlAnNA481qawS9snHhmvSrGFkv711gICze5R
 qiJw==
X-Gm-Message-State: AOJu0YwQGHUr1rTQ6kFuMtmUtb9lEru629+30ugW94+jJc6cRoOotFh+
 A4y7ZJOp3QL9dR8GNnWIPUUkC5iNCzvmC/6felx3XMi172GHSxr7c7lDQRmIAZ3PBRqegG1IKrY
 =
X-Google-Smtp-Source: AGHT+IFGUQ+rnDeGvosyKy1BHDRmZLdqEQLqcA93m+YUQoV6nvwBy7JZnEVZzw1OzIwS9thCFfVOuw==
X-Received: by 2002:a05:6e02:1a4e:b0:398:623a:2f49 with SMTP id
 e9e14a558f8ab-39f379b0fb1mr11233975ab.27.1724882944769; 
 Wed, 28 Aug 2024 15:09:04 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:09:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 19/20] test: Support testing with two board-builds
Date: Wed, 28 Aug 2024 16:08:45 -0600
Message-Id: <20240828220846.1205813-20-sjg@chromium.org>
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

The Beagleplay board uses two entirely separate builds to produce an
image, rather than using an SPL build for this purpose.

Handle this in test.py by adding more parameters.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.34.1

