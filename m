Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B40CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9CE8931D;
	Fri, 20 Sep 2024 08:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n+IabYHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E103F89343; Fri, 20 Sep 2024 08:03:08 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D048931A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so216809466b.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812184; x=1727416984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPe3fmy3f4uuOOrsJvHKA6PP8a5Pa0C8PYfC90KhFAc=;
 b=n+IabYHpYMOC3Yol0y2REzPk+WJdCy0JwXft05eO0Fo3uDVTCGbiUnQ2Qt+I8Qmmlb
 Z1AtdxmiWKo7xPXtxl9vdJrj2n2s1Ko6UFg/p1TshdpRKbxXYDhRZhkKyfp5dHByIJQY
 +O3Nw+uJ+LnLFwMc0tldAlAYTaSrAPjygmfHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812184; x=1727416984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPe3fmy3f4uuOOrsJvHKA6PP8a5Pa0C8PYfC90KhFAc=;
 b=dZ5NaVOgl2+JOvESyAURfZPnxu6vZE+pLSQcaeKCHRuVy1AWDbGSGY3IG1YKEeXg8z
 eghMUJEGimffyOKCJdj2YOLSrlQgy6HcDSXh2SAo1GfbDEXFgXfqyonIxlRGiPrjaC+I
 Hbxo64+ne5KhYIoVZU48LA51XgOrRZOQmIyyUvfDrsw5H+/IEc19QnGkmkt7W/OpV0l6
 IacuJ5fV1cYfAa/yZRLAxApPB78EfAimSesGBC/dG/RNJp22yFcvX7N62ecIpA76+Hgi
 Rdl3KweKHJDf5ezCNTaMF5V8wzVsqALHNvEZa997VEKpys4UvWPpujTABgIBzeeUOQHp
 zx8A==
X-Gm-Message-State: AOJu0Yym5HqpgYt7YVq5qMbqxn7jIQEaQ+5W8Ul5u1GAnP+T38nL280b
 bd7Pg+N5Jd2r7GFCmhq9aT//qHLRC2qJlWY9eJoRXRwjJO03Sq4LQYOJ5lOxqHrQNb+nJN/BPMP
 bHi6i
X-Google-Smtp-Source: AGHT+IGSon7PEhhKrAWt6ywkkQsdPDdN2QbNSAQoYkr91Jv0z4CiqarhDG61hIjXoOSqVCb6dqzT/Q==
X-Received: by 2002:a17:907:efc7:b0:a8d:439d:5c25 with SMTP id
 a640c23a62f3a-a90d4fdfe99mr137420966b.4.1726812184140; 
 Thu, 19 Sep 2024 23:03:04 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 06/19] test: Create a common function to get the config
Date: Fri, 20 Sep 2024 08:01:41 +0200
Message-ID: <20240920060158.106612-7-sjg@chromium.org>
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
2.43.0

