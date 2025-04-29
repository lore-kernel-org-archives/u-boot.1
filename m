Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5F8C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD7A82A76;
	Tue, 29 Apr 2025 15:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DlCOmlGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2B582A65; Tue, 29 Apr 2025 15:25:10 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4BB182145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so3694517fac.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933107; x=1746537907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2mpDX+V5wPiuOLaiPfnEWmQ327f7fJYG/uzBqODMkc=;
 b=DlCOmlGdqS4RO9rjRjnIIEt9T6cazFd/guuqW4qm8UDqAIuE12XG7zFeUzGrd37eQz
 Y+0sLo1X4oRAP0fAzLMMZtUbSVF72416c/IxnTjYqqyZlnMykeDZ+2w6kFK5hUxHpSkW
 zeNWFLs0lLfe5M44Lrr44fo1s0YVg+mRpCORA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933107; x=1746537907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2mpDX+V5wPiuOLaiPfnEWmQ327f7fJYG/uzBqODMkc=;
 b=EQeBWMNWO3PnvJZme5YM/mCOv5BgWIM3Lk+Fv/ivzl6icfK2mNFiAs9mf4enbcTSxu
 OHlRMrMRH3cnTY/+yCzURxEGCR5LE2Pz6ev381wFSkTp/Rmv2dKKy25j9LwWsiGh6LxP
 2j8XCsk+rgPjXxI3bc8On4yKbMGeHK7P9ki+/X7AM2E7X8Fg756npPJ6WVeq3Pwmrr1w
 jr6JF5S5UNqu+/7+QgPnDX1TwsgmarkhT4k9ZTCI4wzD4HnUbz7Vh6eNjW7qWwC0tGOQ
 ZHo8IO/ukBsPpwPBxxrpUbGhPvNFYBlbbbLsm9DxE/PMsPt1hV6oBWG6NnpSdxlOredK
 68hg==
X-Gm-Message-State: AOJu0YxQ3gxzoGGgo4EO6updf+chP8yp0wwbU5IofgMvGURVCL7ojubM
 u86tHcGuM4KqyLdCRJvNwhn9yMrif81W3X+YaVsk5gdl2bIkT1yBt6E8AIqG1quCRFyp3pIF2dk
 =
X-Gm-Gg: ASbGncsVQQkmfr6Nc//QyMtaCOjqnum1glbyga/9w7S/lbm6IdmDJB+1YRa3lVvC/gF
 TvvZnkYtoC47KexVejP6orzZubwXUglknK2FqMKFak4JZfI+LjbJt+qTcKaB6jH/QRAmHgJh8de
 u42WERPKQDO5j4E7SAUa07c/++qhYFe4kdyaQ7sgbodR9GqNgUULuBt7JBi8WncxHCIFc48kZc0
 2VBOIH3s6Lt56R/lnEG2oow2SR0Z5kJlCQLBNmMfS8hKhV7VQICCc1sCQoAYAL6MwRszLWnyvzi
 ROuXCfWNaHGP9ke6QHRLcW7q1rmYSst2usLnPiXz0sacO2zVNSA063kjguz5DpC7XSbCYtuxgwf
 iocNmtMem0KLB
X-Google-Smtp-Source: AGHT+IGzIYlXjgZ1VrcYLZM3/tezGg758DdEvOTtV90lVOr1ceMTdwl4bHiuo9oSXRmGE6cxRVAn4w==
X-Received: by 2002:a05:6870:4792:b0:2c2:489d:887 with SMTP id
 586e51a60fabf-2d9be59560amr7028566fac.17.1745933106976; 
 Tue, 29 Apr 2025 06:25:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:25:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/30] patman: Provide an option to run in single-threaded mode
Date: Tue, 29 Apr 2025 07:22:25 -0600
Message-ID: <20250429132239.251756-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Patman normally sends multiple concurrent requests to the patchwork
server, as this is faster. Provide an option to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py   | 2 ++
 tools/patman/control.py   | 4 ++--
 tools/patman/patchwork.py | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index a7327a20665..cf32716b8e0 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -130,6 +130,8 @@ def parse_args():
         help='Name of branch to create with collected responses')
     status.add_argument('-f', '--force', action='store_true',
                         help='Force overwriting an existing branch')
+    status.add_argument('-T', '--single-thread', action='store_true',
+                        help='Disable multithreading when reading patchwork')
 
     # Parse options twice: first to get the project and second to handle
     # defaults properly (which depends on project)
diff --git a/tools/patman/control.py b/tools/patman/control.py
index cb8552ed550..cfea35ea648 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -44,7 +44,7 @@ def do_send(args):
 
 
 def patchwork_status(branch, count, start, end, dest_branch, force,
-                     show_comments, url):
+                     show_comments, url, single_thread=False):
     """Check the status of patches in patchwork
 
     This finds the series in patchwork using the Series-link tag, checks for new
@@ -96,7 +96,7 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     # Allow the series to override the URL
     if 'patchwork_url' in series:
         url = series.patchwork_url
-    pwork = patchwork.Patchwork(url)
+    pwork = patchwork.Patchwork(url, single_thread=single_thread)
 
     # Import this here to avoid failing on other commands if the dependencies
     # are not present
diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index 2b7734bbfe4..47d7be28fdf 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -139,7 +139,7 @@ class Review:
 class Patchwork:
     """Class to handle communication with patchwork
     """
-    def __init__(self, url, show_progress=True):
+    def __init__(self, url, show_progress=True, single_thread=False):
         """Set up a new patchwork handler
 
         Args:
@@ -151,7 +151,8 @@ class Patchwork:
         self.proj_id = None
         self.link_name = None
         self._show_progress = show_progress
-        self.semaphore = asyncio.Semaphore(MAX_CONCURRENT)
+        self.semaphore = asyncio.Semaphore(
+            1 if single_thread else MAX_CONCURRENT)
         self.request_count = 0
 
     async def _request(self, client, subpath):
-- 
2.43.0

