Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DEAC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F8E82977;
	Thu,  8 May 2025 09:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HP0MhK71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560438295C; Thu,  8 May 2025 09:29:21 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DCDA8294C
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso551857f8f.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689358; x=1747294158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0E2IRe5KAqkJJT23k0Z+suoixR3ilSa8d5Sb6jJ3v4A=;
 b=HP0MhK71dMGWrDBGzhUtGgevjFnXW3ACysEbYOMEgYqb+DjKKg5Zct0Lc/46cfEHlx
 CuQX+MZC3HG+G2xctA494qtSAmDjTWrMjpr1mgQSj0UQir5PzFQh8uUJY06htyla2XGs
 KGvf5D+L12EUTbM41IlMOdsJDFx5HLzJVptTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689358; x=1747294158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0E2IRe5KAqkJJT23k0Z+suoixR3ilSa8d5Sb6jJ3v4A=;
 b=hwsbgxhrfYOy3k+JiRCP+Lp3Tk1G2WvU4GtSVtf3YnhuLxEGQOX5+JV+U0m+fAIqnT
 shLn4gyA6thAJZnZkg5o5CxFU+nxMhcCTaT68tc37msNKfdkOMJ42aKCqLYoGil0Zp5A
 eDSkILHMxihCqiPwu9gFSpqJqGwdYqvBXUo/TLcIRO3jPw+uweLkvQ9ANMKr54YIVYal
 dMDeTn4uVBPdPzpf6lXx2rivDviAE9rf/wBQd0mS6FBJiDb7A6+33xZdIVjR7fWrNu1R
 OXU+uj6BE6R3yNB2/Mg1d9i+bcQ/y8vrxj8XpQlzD7TCQITELAC/0f4qtitQm6JK0ILF
 WP9w==
X-Gm-Message-State: AOJu0YyEz7GLSjyE2M6F8opmapIxt0xl4lZZldcKRDcHg6G4V4NGHNQE
 +/MbRk36yQcav4MIY3Eh2FuFlRJaqZc6xLOrr9RNkHjxSV6i4uTYluGNueXfpb7LHuJ13iuqubR
 pqFXqK6k7EA==
X-Gm-Gg: ASbGnctQ1UbKdicSJOfn/lQFmppqvA++Ee6y6FFnMIUUooZcmEM69+H8ZQNukgi4i+K
 VIKo9BjmZEpP2eMRAYqy2spzISqLFF4s6/Af+ymkKNpwh9uCYPy7UyNxs9ZTiLZ3NYlb5jB93YH
 0dU5R1CXjI0NO2NJNAtEfjqTBMdSadK4UdPRvLZrTQE3H3m8gPXwNNAWlcEVY5sMgKytwJQSZQ/
 X/uaHwQ+8sx5toq4yk82B4Q502aOTnOCBxMwMvBad3ypwp1bdwM6afflcO9T1b9xbdYKD3SyFwj
 Ua2PwjjmLxk4S1xTRK+z0l3H4rqB739nrW68Qg==
X-Google-Smtp-Source: AGHT+IEEXgzE2xRGATLAUMxQmFHT43CWmTXF+3tn+g88khDBfLB2ZhP7v9rItJBgONduk6w1ylz/0g==
X-Received: by 2002:a05:6000:2a7:b0:3a0:8c01:d463 with SMTP id
 ffacd0b85a97d-3a0b990e2b2mr1985029f8f.9.1746689358356; 
 Thu, 08 May 2025 00:29:18 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/20] u_boot_pylib: Speed up determining the upstream branch
Date: Thu,  8 May 2025 09:28:27 +0200
Message-ID: <20250508072907.207175-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Use --decorate to quickly detect the upstream branch, since this is much
faster than using 'git name-rev' on every possible commit.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/gitutil.py | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index f89576ef3b9..cc57e7b7f73 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -13,7 +13,7 @@ USE_NO_DECORATE = True
 
 
 def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
-            count=None):
+            count=None, decorate=False):
     """Create a command to perform a 'git log'
 
     Args:
@@ -31,8 +31,10 @@ def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
     cmd += ['--no-pager', 'log', '--no-color']
     if oneline:
         cmd.append('--oneline')
-    if USE_NO_DECORATE:
+    if USE_NO_DECORATE and not decorate:
         cmd.append('--no-decorate')
+    if decorate:
+        cmd.append('--decorate')
     if reverse:
         cmd.append('--reverse')
     if count is not None:
@@ -90,9 +92,11 @@ def name_revision(commit_hash):
         Name of revision, if any, else None
     """
     stdout = command.output_one_line('git', 'name-rev', commit_hash)
+    if not stdout:
+        return None
 
     # We expect a commit, a space, then a revision name
-    name = stdout.split(' ')[1].strip()
+    name = stdout.split()[1].strip()
     return name
 
 
@@ -112,18 +116,21 @@ def guess_upstream(git_dir, branch):
             Name of upstream branch (e.g. 'upstream/master') or None if none
             Warning/error message, or None if none
     """
-    cmd = log_cmd(branch, git_dir=git_dir, oneline=True, count=100)
+    cmd = log_cmd(branch, git_dir=git_dir, oneline=True, count=100,
+                  decorate=True)
     result = command.run_one(*cmd, capture=True, capture_stderr=True,
                              raise_on_error=False)
     if result.return_code:
         return None, f"Branch '{branch}' not found"
     for line in result.stdout.splitlines()[1:]:
-        commit_hash = line.split(' ')[0]
-        name = name_revision(commit_hash)
-        if '~' not in name and '^' not in name:
-            if name.startswith('remotes/'):
-                name = name[8:]
-            return name, f"Guessing upstream as '{name}'"
+        parts = line.split(maxsplit=1)
+        if len(parts) >= 2 and parts[1].startswith('('):
+            commit_hash = parts[0]
+            name = name_revision(commit_hash)
+            if '~' not in name and '^' not in name:
+                if name.startswith('remotes/'):
+                    name = name[8:]
+                return name, f"Guessing upstream as '{name}'"
     return None, f"Cannot find a suitable upstream for branch '{branch}'"
 
 
-- 
2.43.0

