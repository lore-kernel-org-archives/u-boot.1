Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A0BC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B845C82B54;
	Sun,  4 May 2025 15:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tvc9JePm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D9D82A81; Sun,  4 May 2025 15:24:55 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394A382B18
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso574009966b.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365092; x=1746969892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a4yN3c/RMdUL5vDGQrd+DQQEWu7xVp3MTEbUfhSZFQ=;
 b=Tvc9JePmgBudgKTbg6JinGiIrHQLHiAw6ImGi6lTP8oZozdiitLQvYBkuysyOmscbS
 qXI+fFPHBrv/sjfiFP+EL8Xf9P8MBGLvMaFnBlTQEHMJYKGnBokjEvPnkRCua4hkRjcz
 CRlNA4lKddbE9a3RwF50wVYgJkKmnyQdTHQkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365092; x=1746969892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8a4yN3c/RMdUL5vDGQrd+DQQEWu7xVp3MTEbUfhSZFQ=;
 b=MBf3Xxx9Yp8PH/kb9RHQVhNlVybXbeZlT2g0cRsRCFGYjKKO21bgMG8Rv8UgEJ40Og
 P0IowMsVXrfzrlultDgP+GHeSApo0otBfmD3H0hk+r4WILJHl81EwpqqGrvrgrhZsTrX
 /3uzf6qxX73eLPxKlQo8LM2EhRHi5K+MTQyTJr+BGgZAZzViilPL4Y+BUSOAAVCpqgYh
 gC4VZ/D3qX/Ut0H3Oi23IGyWJs9qb7toQZBIT68UQh1tQx0R8L2kpLaqBZyGWWnTddM8
 SypHOKdSrCJ3SlxRYWmZ/61SWS8M+6Tnvpc14ghnL7uYbIu3vK1yVq2yb3ec6JYACfak
 m9tQ==
X-Gm-Message-State: AOJu0YwPwRJVkMolr9pk7Rl2oh5Ts9RKUBc9GaDAneUmYWeOwld2L8lr
 +LfjA+r/TJfTCCgaJvWSqomsXkYze320TnbQE4UCxATtJUqxfxyg+LJSgxm7SCL0X2DMZft8S4G
 eWPBVcz0=
X-Gm-Gg: ASbGncvZXKEkEYjkM/pWDe8BOPiX6BYHXPBy8aXhsf9rXJy8UqKLBMBOdRnfXa5iBe9
 /WreeNFIiJksapMOJYynKGjdVz2lK+7igHuSkDRP7TnpFsvyC2B+CT7KBL0S+1si7AcDNV02QB1
 zrq7srEDD+5WAGIBsSuh+fr/W8BMb7V+ja8yuolQ9uBQbNa+Ss1gJXA82dYxsS5n1lnmNqm8tz5
 5HeuEq1AQisZQrgAAGM6/1rE3i3VHVwPM1EtvK9ZIS4Pm9qXkgBTTVAPVvMERqbUDH4/2zqpZZg
 Ywh4tNeJVJfnfanI6q/BzQMsUAH6sUn58+V5
X-Google-Smtp-Source: AGHT+IHP+dJpWe5IEnVR1WHT3CLHlZWmnK9WFj2RyO4xnZt1i87bTfDdw1RvEthDkAuh+7TvCuINLw==
X-Received: by 2002:a17:906:7314:b0:aca:a3a8:5560 with SMTP id
 a640c23a62f3a-ad190863496mr492401066b.53.1746365092240; 
 Sun, 04 May 2025 06:24:52 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 28/30] patman: Provide an option to run in single-threaded
 mode
Date: Sun,  4 May 2025 15:23:44 +0200
Message-ID: <20250504132356.2317305-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

