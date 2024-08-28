Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E91C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6E588ACB;
	Thu, 29 Aug 2024 00:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYeg3LH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6DA88969; Thu, 29 Aug 2024 00:09:03 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3D7888D4
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82a109bc459so13995239f.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882936; x=1725487736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=YYeg3LH/qmJc1XHtTrX1NlgLmNJ6hKUsO02aJ23tRv7HirDdbvzGbHkRgH2PlmhOXh
 k9NvPMCI+U2aWc+zNiGMsDFMpvKwznKlvR19uyxhdoUdqGkDfn+B6OL3sZKzeu2IVqzR
 enGJrlZPAXmL6rpB76rpo77JyCgZ/W28m0d24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882936; x=1725487736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZX1CswZm054B0+zWyTmo8TAPiF+XAr8TcpdTNnsbHA=;
 b=BbsMxccWseCU3asiiI4MUIslF8noh3P9GzKYriq125BJ7N3/6FQndFM61b/9vV+u0O
 0QPI6/cJiW2slEy5WcRkvFFZasawUdBJumlhzDMz/NCyMsro975dR7XDKNGn6/8xOZYX
 EoaFcVHJ0GhlOP017FQtdfg7MvGNYzvbG4td8F/J+9mIxt/RbwJFcFrMKa0gUP+v39J4
 eCYVmJIPia4+M81XalBK/Cq/2iIcki7rYH0sB6zcxWDBoNP8xHBnUvMI57gcbCr5miRy
 IFTt5F1R73K++gcn4XM2Bm6IpXiE9abI4SIYlnNKvmJGx84fwNXX5aGdRX0Q+utq6gF0
 a6MA==
X-Gm-Message-State: AOJu0Yz3qfDeavKRJx+hhFEmz3mQbAnU+8Lj3kNFIALpne741Ajxaenw
 oCHDE1+z8t7pTtcLOnVJu6pRqELdIXozdAMvOooFhlrZQDEOuj4HWUC9jKh0GYRI39fxSbP/L08
 =
X-Google-Smtp-Source: AGHT+IEdAr6d+5DOZmS0ZfFBRD13tlNRrb88ZvBnw6r0s8JMTIFuBu0ZYwzpRUoAG+GJMrTbxDWaVw==
X-Received: by 2002:a05:6e02:1b01:b0:39b:36d6:2150 with SMTP id
 e9e14a558f8ab-39f38afa478mr4844225ab.6.1724882935608; 
 Wed, 28 Aug 2024 15:08:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 07/20] test: Create a common function to get the config
Date: Wed, 28 Aug 2024 16:08:33 -0600
Message-Id: <20240828220846.1205813-8-sjg@chromium.org>
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

