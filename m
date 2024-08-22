Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF564C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED79F88E7A;
	Thu, 22 Aug 2024 04:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gfMT0hxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C4788C8E; Thu, 22 Aug 2024 04:56:48 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8AE8863B
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso15040839f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295405; x=1724900205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=gfMT0hxlkAO8/QqJIa26HbGnugV/0CRmzR04YQs9j8h01VCeFSP/0FzignxV8uC9bG
 yXw7S5jS4WoZFGPq1kYsgFkdOP1821jLHI0YoE00yQXo9tvGu1jiwLhOa3TlB4+S+mik
 u5FmJ87JeYW6r6d2CfVVslwRNw0/FgvkDT5fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295405; x=1724900205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=EF5Nicued14qAfHar7rqQV5uO4zHKkOc+HmkpLb+yCMKbAVfkCdGjRRX05OeSw31RK
 BtsBNCiicSi/Po5+6nzDwIXKMK5xIadSaaxgoBrY4xRnmz7XLKvFbw3fkO/6//r8z+4e
 MGNqpisQYVkm/7gdpZAOun0QV7kSjKpyerXb0dtg5wFDLYQdu7JUeYkGFTb+vJ17if/W
 lhdKx+H8sA3emk94KISysJfmS0tk3EzLmNYombL4+vyJctL6GArLoHFDAKljotXQUUQB
 grmPikUYftFxASzF8sPxSeWQARMjJCJBWjCeL8jC0rpun6ZepiYYCkuwGNAZcH5dic6g
 edmw==
X-Gm-Message-State: AOJu0YxPjo4sg+B4PAlKAGV+e9Uf10SKALfTPpqGMih01jzZ2cFhwjvH
 XEqnr0LEQJr4/vc4W7F5mdKUpJ3Pr9S3RkRd+74XvleDxDhvrJ9bexQHXvN/95ORxxdbbkwWkrU
 =
X-Google-Smtp-Source: AGHT+IFQUDqvwVeLNDt59oI0WgfPQ9RcXGFrgVVmPu5VRbfO+yjrmANDJEY/wZQnJrnALVA/OAb3fw==
X-Received: by 2002:a05:6602:1409:b0:81f:9215:80da with SMTP id
 ca18e2360f4ac-825318a3400mr554758139f.4.1724295404702; 
 Wed, 21 Aug 2024 19:56:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/19] test: Create a common function to get the config
Date: Wed, 21 Aug 2024 20:56:19 -0600
Message-Id: <20240822025631.1838434-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

