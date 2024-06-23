Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E76EC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C923885CC;
	Sun, 23 Jun 2024 22:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYrGPCtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 561488837D; Sun, 23 Jun 2024 22:32:28 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D2588599
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-37621e7468eso11414205ab.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174744; x=1719779544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=hYrGPCtRxLttkWxRt43GSCcvUSz9hjKDRpGONQw0yDwryEhMZ4E4x7AN/1af/wM7ll
 5LfnmOJt3Gvdaj/GTPuepC++4vB6+ZL2MvCn439mc5h4bLZYavYOdXK4s4vG4SLW0y+u
 ySYy51jy/B5gdayYaADXCgLA315edrq/LLCPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174744; x=1719779544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=lddRoBz7SuLNKV3SUV1OaNUMgnc1Hqu+i8zXz6oiA0AmLAoCkJC/zEY/VfHpCGBpCz
 +UpVbZM0vEQ8wVez6HqKvGe74lukdFIsJcF/cROaV8zjySmmncMXZRiWhmUfcPdNKRKc
 yGGivlL1R6RgLlFjRQSP5u4yqi3MEw/kIQyqgQIodH04dwy/h3NC4Ddln66Jvc9dSfKG
 mOwlLSf+o6F/cm0xIw8g2k+ggXnn90SjT5JwYRg01Or3bXotpnOdlHOd/+FBjOoGLwAa
 UOZSNW620YjSrGbUZlbkEEykGDpsiY1pgG2Sih12dnXFGTDqBX2DNOcJ0jZWhY+6U076
 U7Kg==
X-Gm-Message-State: AOJu0YxBp6ycIbZPodeXS2VfWKwiS2+uXe1KlXVbkt0bL7E8IC+WH+St
 Hkt4iNnYze6ssjYDTnibOi6oHU5/14FdkR80Nj3j+QYBRsJV02Q8AeCscWfQ7sr/dMtB/95UES8
 bfA==
X-Google-Smtp-Source: AGHT+IHIdK97E7WP9WLru4t4NygWuK/lY/BdFTTyHlbeYLQsjAwIhotA324G40nGs/tqHa3otR9dlQ==
X-Received: by 2002:a05:6e02:1a69:b0:376:41c5:d61e with SMTP id
 e9e14a558f8ab-37641c5d765mr9257965ab.20.1719174744682; 
 Sun, 23 Jun 2024 13:32:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/19] test: Create a common function to get the config
Date: Sun, 23 Jun 2024 14:32:01 -0600
Message-Id: <20240623203213.1571666-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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

