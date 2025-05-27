Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD853C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 11:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B9583013;
	Tue, 27 May 2025 13:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aTjSlHGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24188300F; Tue, 27 May 2025 13:19:43 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5288882116
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-85df99da233so273378339f.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748344779; x=1748949579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5GPmh5waIml4FNDHosRqygZjmG5QGi0pju9IM0TIH8A=;
 b=aTjSlHGiugq04arqCKzzYnnDejdughIrgCKCHYGxX5Oy05qYsrYVA3mTgtsfx3y08Z
 bGR7bUWYRes2UFN+2Zni6yoEn1DuHksWixOi1bFYICmNk2hsM0I4RFBUBBIOkOYtM+hx
 2y42IMZDbLwRh2dCAPCwTJzOoDmaDoVHkz4mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748344779; x=1748949579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GPmh5waIml4FNDHosRqygZjmG5QGi0pju9IM0TIH8A=;
 b=d1fkBXBQLJPPfwlvYXxZGZKC8lMC0rHqlY5zbIO/sA8CKxRL36eqBGvarqf7tr8u3C
 MmL65gMwIobBeNqTBx0XP5wQe00c2F4k8FBIqdN+Lka/cvWkpLbn0GcnXyu2IFzsdc39
 vpTKncu5xOW+mGKORGRI9lcSnGcNICx2MLAW/1V8vJ3x434qtPOGzFB1gPYw5GKz306+
 D0r5FV8YVeagnJp9GTb6QhhAdQCULYGO3IFH+NTvWpA0LyRYEcbEEg6CLFps/Ku/YF+3
 yl73gvQkVSFitqo6oD1tJCAlTQh+tV7kKnUIUmtl8TgIAmiBa8VMKXgmQZxaC0f6M8MH
 TC9g==
X-Gm-Message-State: AOJu0YyHy89j8NT3sXgtjlexs9IrcFFgnHpCaUhvVY+AgpqC0CzryjMp
 +Tf/Bs6VX1sSYqZXoRVV7fl18Nc3HKSoSCugvvu/HiXb+z/dAVREqFsm4V+Ws8gKHJofkoi8Fwg
 8d8M9+Tf+gFk=
X-Gm-Gg: ASbGnctsiYTppq+dOVvfMwZ1wVGTb+dafRARc7C/+H1WNwJI+cfcpAJgHiCfwdyZPtV
 nZ7S8992ySuIfyQKUiixX732JAn3ujBLjPXDoPDKqDY3txHtp1scT9u3Dxbq3pY31SYTL3ixATc
 UcKYHNsncACILSw0c1mVD1uLPRJD1oancFylnyQdB742rWw3sH8lrW0lDxyJykF9kYZmaMujDIl
 rKu1A8FATQG7PtbUaxSPRVwDIOWl+mByPRBuOx7O5ikakeBENu0yCqB+rV0cNXe1tTrKOBBPngd
 rspRy+awfVccyEG+XmLsfLAvMnVdNX3LsA6OKGcNXk8Nze4u8t/Q2avLtVn89lfcRgCRJbPzSP2
 bxps1kPOxlCD+
X-Google-Smtp-Source: AGHT+IFpX5F2KChwwzwyGdt5PO+aaRa+ZpDPU/P6GIKZ40pE38cp8AQZP7saRKRmHwNGIr2NI4rfjA==
X-Received: by 2002:a05:6e02:3991:b0:3dc:8b2c:4bc7 with SMTP id
 e9e14a558f8ab-3dc9b695232mr96044975ab.1.1748344779474; 
 Tue, 27 May 2025 04:19:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc82e014f4sm36362755ab.40.2025.05.27.04.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 04:19:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] buildman: Correct behaviour of --in-tree
Date: Tue, 27 May 2025 05:19:20 -0600
Message-ID: <20250527111932.3058650-1-sjg@chromium.org>
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

This option doesn't work as expected since it sets the cwd to the work
directory, which does not necessarily hold the source code.

It should be left unset, so that the current directory is the source
directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builderthread.py | 38 +++++++++++++++++----------------
 tools/buildman/buildman.rst     |  6 ++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index b4cb66397bb..4617f516f40 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -37,6 +37,8 @@ def mkdir(dirname, parents=False):
     Raises:
         OSError: File already exists
     """
+    if os.path.exists(dirname):
+        return
     try:
         if parents:
             os.makedirs(dirname)
@@ -45,8 +47,8 @@ def mkdir(dirname, parents=False):
     except OSError as err:
         if err.errno == errno.EEXIST:
             if os.path.realpath('.') == os.path.realpath(dirname):
-                print(f"Cannot create the current working directory '{dirname}'!")
-                sys.exit(1)
+                raise ValueError(
+                    f"Cannot create the current working directory '{dirname}'!")
         else:
             raise
 
@@ -205,21 +207,20 @@ class BuilderThread(threading.Thread):
         args = []
         cwd = work_dir
         src_dir = os.path.realpath(work_dir)
-        if not self.builder.in_tree:
-            if commit_upto is None:
-                # In this case we are building in the original source directory
-                # (i.e. the current directory where buildman is invoked. The
-                # output directory is set to this thread's selected work
-                # directory.
-                #
-                # Symlinks can confuse U-Boot's Makefile since we may use '..'
-                # in our path, so remove them.
-                real_dir = os.path.realpath(out_dir)
-                args.append(f'O={real_dir}')
-                cwd = None
-                src_dir = os.getcwd()
-            else:
-                args.append(f'O={out_rel_dir}')
+        if commit_upto is None:
+            # In this case we are building in the original source directory
+            # (i.e. the current directory where buildman is invoked. The
+            # output directory is set to this thread's selected work
+            # directory.
+            #
+            # Symlinks can confuse U-Boot's Makefile since we may use '..'
+            # in our path, so remove them.
+            real_dir = os.path.realpath(out_dir)
+            args.append(f'O={real_dir}')
+            cwd = None
+            src_dir = os.getcwd()
+        elif out_rel_dir:
+            args.append(f'O={out_rel_dir}')
         if self.builder.verbose_build:
             args.append('V=1')
         else:
@@ -409,7 +410,8 @@ class BuilderThread(threading.Thread):
         """
         # Set up the environment and command line
         env = self.builder.make_environment(self.toolchain)
-        mkdir(out_dir)
+        if not os.path.exists(out_dir):
+            mkdir(out_dir)
 
         args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
                                               work_dir, commit_upto)
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 5fa7b277cb8..2555139334f 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1333,6 +1333,12 @@ To build a particular target, rather than the default U-Boot target, use the
 `--target` option. This is unlikely to be useful unless you are building a
 single board.
 
+Buildman normally builds out-of-tree, meaning that the source directory is not
+disturbed by the build. Use `-i` to do an in-tree build instead. Note that this
+does not affect the source directory, since buildman creates a separate git
+'worktree' for each board. This means that it is possible to do an in-tree
+build of an entire branch, or even a 'current source' build for multiple boards.
+
 Build summary
 -------------
 
-- 
2.43.0

base-commit: 9665e6b85eef02e62b1fe6a15e6f5fac418273fe
branch: bmg
