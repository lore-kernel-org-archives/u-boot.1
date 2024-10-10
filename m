Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE90CED611
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B5DA88E14;
	Thu, 10 Oct 2024 02:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KXfcNkrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A82D88EE5; Thu, 10 Oct 2024 02:29:23 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0214088AE4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e4d624ac53so170430b6e.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520159; x=1729124959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usqk8uo2zlc1rS8nfthj39K0AyKnWBqNhSvtCPr4NLQ=;
 b=KXfcNkrhgsGbsxoGYbF68YH5B53UYLfeJJGxlHNdh8rSF5xtXTYnZCnZw2rMNddno1
 JKfhU+za0BK/fit/2FLpQGUkyO2PYBP1HyjZz5TmT2rQ/oMinIsiU70p1iwshvOTiApY
 nsWE7xf68KuyWoUSJlNtJtGObudhnzDjU2r4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520159; x=1729124959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usqk8uo2zlc1rS8nfthj39K0AyKnWBqNhSvtCPr4NLQ=;
 b=WlhVFuHeO9rRPKXe5/QB599TecX6nXTkGiX6iccoEusn6BuOjkwBqNB1g4e16xhULz
 vNOU22duOCzxBG5pHYD4yVVTqKWO4/BVa9CjXFIlnXx4aUF5UhrS8jwJthYScmc6OZ7c
 iDlXBn2XwalMFoq8M2E/C1fCKyYTOjtgchjUMN1S2yisfgYumWDL4TuEk98vm7Nk9qTe
 RaLVH4quJCVqLI4h8Fib1SuIFjc3AS/tn7mY4cXoS/XYlOYrWplTL7hsiM0fenEmFkoJ
 UjAUyzP4YaYnQrO3X+FQwDJy70UYsQ9ihG+K/JQ6P2CXK/4Ie/2W8+R6R2qfXGE0JGGK
 P1vQ==
X-Gm-Message-State: AOJu0YwxbYfa773F1ruYCJ8IR3Rn+Vy2PcrYjdHLDkpI9INY+6EOS/nR
 Q8R59CIh1yQA8FNKpFBE9RCPxAo4hKRyPqhSAk+A69iwFbqp+bAjTPb5kISSJupJcxmE+IXWBD2
 7bw==
X-Google-Smtp-Source: AGHT+IH7JpAI/jWvpv/5DFzKAkBQldC5L9/jz5TZE6OKj/uowlKV3AUuCPWefMVOadD6LA2JidOoWA==
X-Received: by 2002:a05:6830:2c0c:b0:716:aa97:8f91 with SMTP id
 46e09a7af769-716aa97901dmr1364221a34.1.1728520159433; 
 Wed, 09 Oct 2024 17:29:19 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 3/8] test: Create a common function to get the config
Date: Wed,  9 Oct 2024 18:29:00 -0600
Message-ID: <20241010002907.19383-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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
index fc9dd3a83f8..85e1979dc79 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -115,14 +115,36 @@ def run_build(config, source_dir, build_dir, board_type, log):
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
@@ -161,17 +183,10 @@ def pytest_configure(config):
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
2.43.0

