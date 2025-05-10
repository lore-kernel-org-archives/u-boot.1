Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07129C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599F382952;
	Sat, 10 May 2025 13:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fbKP8mKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18D68294C; Sat, 10 May 2025 13:05:53 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B8C8070C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5f6fb95f431so7527004a12.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875151; x=1747479951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYHfupbEoiKIRS46PM9eetRsLbw9FaYweXBH4QkR0OE=;
 b=fbKP8mKX7Ov5DJWPMwTizI7Et0lDj8y6qhCRrohenWdKVf6OWYEmwhaD37CShsYmpj
 ndAR4k/4M0Y3ryJ2a9uuiyoacalyoAraYUazcIEm1TaC5VTJPU0V7qthej7gNXyWYpjp
 eXnGvZ0mJgeY7KRP9rAV8fFxOOR6nZ3OcZ/w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875151; x=1747479951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYHfupbEoiKIRS46PM9eetRsLbw9FaYweXBH4QkR0OE=;
 b=pedBMcuU9VY2X3jGbTtOY8JcTCQBmqDdMampPJ5r6XJpfpwFq3Liv+KC9GzgUgeinP
 5qq8EUcqJcHkKWg+4CTerhLOtJvXMHSh2sEw74ZLbhQ0fWmfilgzxuTLMot73+vu9IL6
 z169FiwVjXIqdYZYM3yXKsPgtZsJ8mnYro39xopDe06dRxUsOn9OsMdZFqE4N4I0iYmn
 iBjPKnjg0PYpTTuKsWGbMiO9F2XnxZ4cJ1hOHlCzHB+/NF2OukqzG14MbZed5I7xagoD
 08adJUJcQTyz1g5GwNSWdBDiYpsS1Yuzd8B0b4eH2G8RHv9/CuX1HtBcV9IOxQJC4UCI
 x8zA==
X-Gm-Message-State: AOJu0Yx1RSnrczioysk0VXiiWYdEfpdQQ3BuD0CguggllQFpWMrfblls
 VjniaB7qDjSZlBcR8iht5KodXZl1Zvqg2TrbDpl89bxYTbIZJspyEff7vK4NicQo1Cg+AmOB2Ph
 BwNjQ28XUxACI
X-Gm-Gg: ASbGncvR5kMZJjSgu+1Y7y0rVVXcIWBg8fvMvZmJ0vduA14BRBLCPZNno0uMzpxdZlN
 Enyt2YeZCMPZt3WDg8R5vOUgc9kD/uveFg3QkHLfWdGsFFR4L1B6fFDM9fBTowZ/EIDhMnGN25R
 Ieb9rl2+2yLSz5COp1HwNHGArhj6Cg80Z0fZe+Osi6fpXZ5R+bKCMoGOKKboMrWW45vVS6yA+dH
 yn3NSz1XztiQpkmgJmd1lZ/jXXzYtc1GsWspnNDDlMGOvtAkof6tn9Y0PybNjxaFzyHZrTPTj2A
 72IJF8AUPYo1TTar4WmVwHbRK8Fd4zrzulvALgfamlmZDYwvvpYaHURqKA==
X-Google-Smtp-Source: AGHT+IHeHinytcPfHeh5OXBS4kiF86QPkiLo7trQaTONH+rIETnFSRsx3zOcoVr1yLik5vrCuEFY0g==
X-Received: by 2002:a17:906:c14b:b0:ad1:8e6f:3ad8 with SMTP id
 a640c23a62f3a-ad21b1d92e3mr634288966b.14.1746875150736; 
 Sat, 10 May 2025 04:05:50 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/25] u_boot_pylib: Correct pylint warnings in gitutil
Date: Sat, 10 May 2025 13:04:54 +0200
Message-ID: <20250510110535.1453745-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Correct various pylint warnings in this file.

The remaining ones are three functions with too many arguments (R0913
and R0918) and use of global (W0603).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/gitutil.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 3c52cce232c..cfcfeffe2f4 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -2,6 +2,8 @@
 # Copyright (c) 2011 The Chromium OS Authors.
 #
 
+"""Basic utilities for running the git command-line tool from Python"""
+
 import os
 import sys
 
@@ -22,6 +24,8 @@ def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
         oneline (bool): True to use --oneline, else False
         reverse (bool): True to reverse the log (--reverse)
         count (int or None): Number of commits to list, or None for no limit
+        decorate (bool): True to use --decorate
+
     Return:
         List containing command and arguments to run
     """
@@ -518,9 +522,8 @@ send --cc-cmd cc-fname" cover p1 p2'
     """
     to = build_email_list(series.get('to'), alias, '--to', warn_on_error)
     if not to:
-        git_config_to = command.output('git', 'config', 'sendemail.to',
-                                       raise_on_error=False)
-        if not git_config_to:
+        if not command.output('git', 'config', 'sendemail.to',
+                              raise_on_error=False):
             print("No recipient.\n"
                   "Please add something like this to a commit\n"
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
@@ -549,9 +552,8 @@ send --cc-cmd cc-fname" cover p1 p2'
     cmd += args
     if not dry_run:
         command.run(*cmd, capture=False, capture_stderr=False, cwd=cwd)
-    cmdstr = ' '.join([f'"{x}"' if ' ' in x and not '"' in x else x
-                       for x in cmd])
-    return cmdstr
+    return' '.join([f'"{x}"' if ' ' in x and '"' not in x else x
+                    for x in cmd])
 
 
 def lookup_email(lookup_name, alias, warn_on_error=True, level=0):
@@ -720,6 +722,7 @@ def get_hash(spec, git_dir=None):
 
     Args:
         spec (str): Git commit to show, e.g. 'my-branch~12'
+        git_dir (str): Path to git repository (None to use default)
 
     Returns:
         str: Hash of commit
@@ -762,6 +765,7 @@ def check_dirty(git_dir=None, work_tree=None):
 
     Args:
         git_dir (str): Path to git repository (None to use default)
+        work_tree (str): Git worktree to use, or None if none
 
     Return:
         str: List of dirty filenames and state
-- 
2.43.0

