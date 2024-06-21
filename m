Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E102DC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E9F885F1;
	Fri, 21 Jun 2024 21:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hXP5fK/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C09885B3; Fri, 21 Jun 2024 21:52:36 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0623885EB
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb6aedcabcso90280539f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999553; x=1719604353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=hXP5fK/xgNuSRN2A0OYUB1wL2b4p7H5fD0klU55sXU5jhvV80Jqn/zcqng3DNHe/Yu
 3kfXL1tBcYBtXoqvVRVQAn9879j09uL6gDQMlymZulx7JNt5dIqtxshb6Kak0yGRCoCi
 E5XMmUnulJVZZZSuTi3dRVHY/u5gcBXPpWIHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999553; x=1719604353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=vLVwcW3rVDW7caim2aHid5914V5asjDRYiUPIioWRA+INfYSiu+IIMgsEl/wArPBmI
 MfYcAivDiesxXnk2s3OraeXmoS2lWnw5DyD6rpAaRG//ixkQC1b4apG/Ou6ZMuOtekis
 aUihuThkfV8Mjwr2WeL3CLQ642nGMBqOjphdPqQiAHKGT4xtfKB/vkITOTVQ5euCG41D
 Q5RObsBYbe+cftI0lcVm2C41gc5Gix3eDtBQGi1hzKNvBdECh5DTTaDToWOAt1aVgiR8
 mxABL725KVPHOOMg654O212wIECIgtgR4FhIf8Zi1tDFwYrL497QRAd++LMVB+SDGIjr
 v92A==
X-Gm-Message-State: AOJu0YzClyidDlrM86Aw6pOQRXr5BCHirj1qaB85IiGwjAgRoOXqR7P+
 max0v+XLHdPKgWYihLKsbdHWnc3NGRB4HahiGb2l14y824UYBUc7ZUm9dRRElUN0AXhI06j+dsM
 GbQ==
X-Google-Smtp-Source: AGHT+IEmT7ZAlO9oQgQOmO9ZphGfLCpY8ycXHTRUH0Xos7eaXV4qkAchlaLnC10OgIp/YKUqdIPtrw==
X-Received: by 2002:a05:6602:2dc1:b0:7eb:f3c8:c59f with SMTP id
 ca18e2360f4ac-7f13ee26cc6mr1031610739f.11.1718999553217; 
 Fri, 21 Jun 2024 12:52:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 30/43] test: Create a common function to get the config
Date: Fri, 21 Jun 2024 13:51:51 -0600
Message-Id: <20240621195204.2675252-31-sjg@chromium.org>
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

The settings are decoded in two places. Combine them into a new
function, before (in a future patch) expanding the number of items.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/conftest.py | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index ca66b9d9e61..6547c6922c6 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -117,14 +117,36 @@ def run_build(config, source_dir, build_dir, board_type, log):
         runner.close()
         log.status_pass('OK')
 
-def pytest_xdist_setupnodes(config, specs):
-    """Clear out any 'done' file from a previous build"""
-    global build_done_file
-    build_dir = config.getoption('build_dir')
+def get_details(config):
+    """Obtain salient details about the board and directories to use
+
+    Args:
+        config (pytest.Config): pytest configuration
+
+    Returns:
+        tuple:
+            str: Board type (U-Boot build name)
+            str: Identity for the lab board
+            str: Build directory
+            str: Source directory
+    """
     board_type = config.getoption('board_type')
+    board_identity = config.getoption('board_identity')
+    build_dir = config.getoption('build_dir')
+
     source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
+    default_build_dir = source_dir + '/build-' + board_type
     if not build_dir:
-        build_dir = source_dir + '/build-' + board_type
+        build_dir = default_build_dir
+
+    return board_type, board_identity, build_dir, source_dir
+
+def pytest_xdist_setupnodes(config, specs):
+    """Clear out any 'done' file from a previous build"""
+    global build_done_file
+
+    build_dir = get_details(config)[2]
+
     build_done_file = Path(build_dir) / 'build.done'
     if build_done_file.exists():
         os.remove(build_done_file)
@@ -163,17 +185,10 @@ def pytest_configure(config):
     global console
     global ubconfig
 
-    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
+    board_type, board_identity, build_dir, source_dir = get_details(config)
 
-    board_type = config.getoption('board_type')
     board_type_filename = board_type.replace('-', '_')
-
-    board_identity = config.getoption('board_identity')
     board_identity_filename = board_identity.replace('-', '_')
-
-    build_dir = config.getoption('build_dir')
-    if not build_dir:
-        build_dir = source_dir + '/build-' + board_type
     mkdir_p(build_dir)
 
     result_dir = config.getoption('result_dir')
-- 
2.34.1

