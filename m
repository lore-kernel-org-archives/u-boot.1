Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0A9C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7A182E8E;
	Sat, 24 May 2025 19:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fRu7XnWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FCF82E76; Sat, 24 May 2025 19:07:14 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695FF82CD2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3dc978d5265so5204735ab.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106430; x=1748711230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=73mmyZlBM9Sjw9hs8Qoz8Frz+r3lo9PHDHJqWQz7c/k=;
 b=fRu7XnWbVsIhyeCcvfTJ3ZrlzR99tXsMl/Mmj2I45Z1SB2euWEpIfGryk4lpgPIijU
 kmx+glAFWQLtKjm95oUBqqL5xnVKamiS6v0DcQRNl3RG6GSOua81OVoKGAoiU+ftcKac
 Gw9MtivEIW/VK79ChEzxUiVPM9IGMWneFblOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106430; x=1748711230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73mmyZlBM9Sjw9hs8Qoz8Frz+r3lo9PHDHJqWQz7c/k=;
 b=o+KLUsN8avLiE0LgiVADnnSZZ+nwkH6gc82CX7u0hNC7NLjDlqxgGfOqAQ1PRVEgNN
 0xoQ2VAvr41h2rpD3jihR8XYJbhM9alv5kNgLPlnvVTLER6C4YkALENldvbZr8aaV22H
 RSwOcCHLmBpWoGDJP4RgqbKoc4a5HvD2/XlJAHLZIl/HMxIU77RpG/4SOhxHsNh4exSR
 4XEWN7gaa//ySFl1RSnFEreK7el5bzYLctuwHY+HWokO7z8PcHz2oKo4om7B2YeDOSOu
 VK2QW9o7nNdEdI32SUMX0kQpgFMMzh37ZMNIUp2JwqYJyKhQzjoMEudGVFEGh1OnDTfc
 zZ2g==
X-Gm-Message-State: AOJu0Yx8W/NOoFVMH0MkpgyYMzXgUP2y3CDCyj4UptEUbaj7mFVpVomR
 Kb4hTdFhBpNXc2sZPbqNFAo2sYCsxk9oYVMNoz73ZKrgy/zkj+E8BQUejU43V3UFYr+TCbI0cLz
 pH5DOLwTP
X-Gm-Gg: ASbGncuMrAjA4xdPxTzhx2EQv11rGihUp4ShD1IgCp5VKQf/agOAV24gCoFpmrz3u8z
 P2ul+SLX1bq88KTumYyyrqIswEcFGcJfhkzubiQQ5oa8OXkkd1MM4DNj0VlJqIjKdheVOVdrTvy
 SK+KzmxPAbD8p/SnYcQjODzi8z18NZy8PqCNnzMeA6QFWAwaUC7zgDutKUao3MhHKYjxIT/UClS
 xoNI45ulNSewv4F2F5zBZdX3Utnpm0xyuLBY/9HF2FpAU0YPUR6JpsfEzTDglPg3qEPKU3Go5lI
 ddiccymA6siCEqHexp6l/p0QeslhoHTZCjPI4M78444ed2b//hOPyiUrq8WTdj7ur+slA2KUss+
 IaFfNxqQZ80IJR9eOZJxacio=
X-Google-Smtp-Source: AGHT+IGPxTlUP4/umPP1kuJq6ERNOl0wF9OEe2o3IYLr91E3Q7T60cmlbbfGDhz9r5Vx8ZHgXNn0vg==
X-Received: by 2002:a05:6e02:2161:b0:3dc:7660:9efe with SMTP id
 e9e14a558f8ab-3dc9b6752bcmr24600385ab.9.1748106430547; 
 Sat, 24 May 2025 10:07:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] patman: Avoid needing pygit2 for all subcommands
Date: Sat, 24 May 2025 11:06:49 -0600
Message-ID: <20250524170701.1238642-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

If pygit2 does not exist, patman refuses to work at all, but most
subcommands don't need it. Move the imports to resolve this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index 3e09b16e87b..e10125e2581 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -21,8 +21,6 @@ from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
 from u_boot_pylib import tout
-from patman import cseries
-from patman import cser_helper
 from patman import patchstream
 from patman.patchwork import Patchwork
 from patman import send
@@ -73,6 +71,8 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     Raises:
         ValueError: if the branch has no Series-link value
     """
+    from patman import cser_helper
+
     if not branch:
         branch = gitutil.get_branch()
     if count == -1:
@@ -124,6 +124,8 @@ def do_series(args, test_db=None, pwork=None, cser=None):
             needed
         cser (Cseries): Cseries object to use, None to create one
     """
+    from patman import cseries
+
     if not cser:
         cser = cseries.Cseries(test_db)
     needs_patchwork = [
@@ -226,6 +228,8 @@ def upstream(args, test_db=None):
         test_db (str or None): Directory containing the test database, None to
             use the normal one
     """
+    from patman import cseries
+
     cser = cseries.Cseries(test_db)
     try:
         cser.open_database()
@@ -257,6 +261,8 @@ def patchwork(args, test_db=None, pwork=None):
             use the normal one
         pwork (Patchwork): Patchwork object to use
     """
+    from patman import cseries
+
     cser = cseries.Cseries(test_db)
     try:
         cser.open_database()
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
