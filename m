Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31456C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 759108357C;
	Sat, 24 May 2025 19:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OUPj+mCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1817834BC; Sat, 24 May 2025 19:07:17 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5138182CD2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3dc926f21d0so2288535ab.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106433; x=1748711233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTRJYMy3hOCaz6Au4GMya+QmbkHe2N+rLTWGgF0PJ6Y=;
 b=OUPj+mCKmV1POUKXfwSa364yXrP3g6yqns2e66NE7v6TXSSRvyyJVJyAm4SyO/semd
 VMV8V7axevKGmbGDOMGdKFKa/0j1TYFrYWXCXvSBjJTw5jOa7InlyZYzEEQGptCh4lv8
 /6Gf5LvCwXGI7jbEnvdhQdcfMy4KfoQ1XlHUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106433; x=1748711233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTRJYMy3hOCaz6Au4GMya+QmbkHe2N+rLTWGgF0PJ6Y=;
 b=JliioZJOBWJJfF+pSJ8ta0ilmSLjptAj2UpNE3w8c3v6fgKYM9zISzoSW0NO8eUgKX
 erR4kkA9n3sFtbyZW2FHaz8OEXAbA3TN1CDUZKc1QXUJl8EWSCq0xTsxuVNpvv4YA/X4
 YzXdVUKMbidbPmBRkWtycLCPvzbm4Xb9TXf4aMiJfBPUrUR6Vw9o/BCbaNk56xHsB9Zi
 /NfF3ureWj/giPi2DFn6Mq7Lg5KbBHUHkec+kBbZ45TeoO4KWAv3aMX2OVQHqoCxq6Lo
 7Ll0ySJq4dasuJYcoyMuiiztEoNbEoqMb+zIE2Loe8rhxrF9bioehvTxHzlRvQ3+dyNR
 aO5A==
X-Gm-Message-State: AOJu0Ywnz01NjcjnxuGoUC1g+yV4mZeuQ4NwzTom4BZ5Uyr6fcGf6Zuw
 kgxqb5xnhqn5GxyTQVfKDyHz7xG2+dS00hJHcbhPjIdg/DPD2IkoT6Ve5BnCYH8AXH0mcMCluQ2
 tkFxfsj4t+gs=
X-Gm-Gg: ASbGncugCcfigZy+qF55WoLRYGepeHX61WhMUqU4jX+PyIkFaGRKdnAoDMK4VRpBUtj
 Dkuyx7uN4PO3uJ1mC9EDYqBWkIDPvwaN5NekLGJkrOTQ/nkLh3MBWKx5yz1PltYpzEKpvGHowFQ
 WsbPHMUKviEu83cAHd7CcENaoHyyKYaT62GqQmKrA+Vnzgi7dS0A3tZSVqoERZ2sdsJu70Z2t3Z
 4rHm5ckAqsMK8siX+54PYJ67onJ4ui4h+nODunK45J3r8DnfB+4rmOkxD1e8m3nl7MTJhY62w4G
 Bcn3IyHGsK9Bwr3+LOeXtvYS4e80b+3ju9SE64DK5xO2eARTDNjUYnhY1R9SvatmBg/4I8HG9wq
 bqRKfXbISBTkxfYRQDjLqMwI=
X-Google-Smtp-Source: AGHT+IFGKRBVsdX4X/v3wkcjiE5j3Irtpk2s52ra4oq6niZuRi96u7RqnizS9IVzPUbqNWCJHN0hNQ==
X-Received: by 2002:a05:6e02:1a4d:b0:3dc:8b29:30bc with SMTP id
 e9e14a558f8ab-3dc9b7739d3mr30695005ab.21.1748106433446; 
 Sat, 24 May 2025 10:07:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] patman: Move split_name_version to patchstream
Date: Sat, 24 May 2025 11:06:50 -0600
Message-ID: <20250524170701.1238642-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524170701.1238642-1-sjg@chromium.org>
References: <20250524170701.1238642-1-sjg@chromium.org>
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

This function is needed by 'patman status', meaning that it must import
cser_helper which needs pygit2

Move it to patchstream so that pygit2 is not needed for the
'patman status' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py      |  4 +---
 tools/patman/cser_helper.py  | 29 ++---------------------------
 tools/patman/cseries.py      |  2 +-
 tools/patman/patchstream.py  | 25 +++++++++++++++++++++++++
 tools/patman/series.py       |  1 +
 tools/patman/test_cseries.py |  4 ++--
 6 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index e10125e2581..1250fa10c62 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -71,8 +71,6 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     Raises:
         ValueError: if the branch has no Series-link value
     """
-    from patman import cser_helper
-
     if not branch:
         branch = gitutil.get_branch()
     if count == -1:
@@ -94,7 +92,7 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     if not links:
         raise ValueError("Branch has no Series-links value")
 
-    _, version = cser_helper.split_name_version(branch)
+    _, version = patchstream.split_name_version(branch)
     link = series.get_link_for_version(version, links)
     if not link:
         raise ValueError('Series-links has no link for v{version}')
diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
index 2841fcd9c20..39f291cb3ec 100644
--- a/tools/patman/cser_helper.py
+++ b/tools/patman/cser_helper.py
@@ -64,31 +64,6 @@ def oid(oid_val):
     return str(oid_val)[:HASH_LEN]
 
 
-def split_name_version(in_name):
-    """Split a branch name into its series name and its version
-
-    For example:
-        'series' returns ('series', 1)
-        'series3' returns ('series', 3)
-    Args:
-        in_name (str): Name to parse
-
-    Return:
-        tuple:
-            str: series name
-            int: series version, or None if there is none in in_name
-    """
-    m_ver = re.match(r'([^0-9]*)(\d*)', in_name)
-    version = None
-    if m_ver:
-        name = m_ver.group(1)
-        if m_ver.group(2):
-            version = int(m_ver.group(2))
-    else:
-        name = in_name
-    return name, version
-
-
 class CseriesHelper:
     """Helper functions for Cseries
 
@@ -577,7 +552,7 @@ class CseriesHelper:
         """
         if not name:
             name = gitutil.get_branch(self.gitdir)
-        name, _ = split_name_version(name)
+        name, _ = patchstream.split_name_version(name)
         ser = self.get_series_by_name(name, include_archived)
         if not ser:
             ser = Series()
@@ -609,7 +584,7 @@ class CseriesHelper:
             name = gitutil.get_branch(self.gitdir)
             if not name:
                 raise ValueError('No branch detected: please use -s <series>')
-        name, version = split_name_version(name)
+        name, version = patchstream.split_name_version(name)
         if not name:
             raise ValueError(f"Series name '{in_name}' cannot be a number, "
                              f"use '<name><version>'")
diff --git a/tools/patman/cseries.py b/tools/patman/cseries.py
index bcbc4963cea..f2a6ae61ba9 100644
--- a/tools/patman/cseries.py
+++ b/tools/patman/cseries.py
@@ -686,7 +686,7 @@ class Cseries(cser_helper.CseriesHelper):
         if old_ser.name != series:
             raise ValueError(f"Invalid series name '{series}': "
                              'did you use the branch name?')
-        chk, _ = cser_helper.split_name_version(name)
+        chk, _ = patchstream.split_name_version(name)
         if chk != name:
             raise ValueError(
                 f"Invalid series name '{name}': did you use the branch name?")
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 45040877f8c..aec7643838c 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -69,6 +69,31 @@ STATE_PATCH_HEADER = 2      # In patch header (after the subject)
 STATE_DIFFS = 3             # In the diff part (past --- line)
 
 
+def split_name_version(in_name):
+    """Split a branch name into its series name and its version
+
+    For example:
+        'series' returns ('series', 1)
+        'series3' returns ('series', 3)
+    Args:
+        in_name (str): Name to parse
+
+    Return:
+        tuple:
+            str: series name
+            int: series version, or None if there is none in in_name
+    """
+    m_ver = re.match(r'([^0-9]*)(\d*)', in_name)
+    version = None
+    if m_ver:
+        name = m_ver.group(1)
+        if m_ver.group(2):
+            version = int(m_ver.group(2))
+    else:
+        name = in_name
+    return name, version
+
+
 class PatchStream:
     """Class for detecting/injecting tags in a patch or series of patches
 
diff --git a/tools/patman/series.py b/tools/patman/series.py
index ad61bbfa399..517fd4304f5 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -21,6 +21,7 @@ from u_boot_pylib import tools
 valid_series = ['to', 'cc', 'version', 'changes', 'prefix', 'notes', 'name',
                 'cover_cc', 'process_log', 'links', 'patchwork_url', 'postfix']
 
+
 class Series(dict):
     """Holds information about a patch series, including all tags.
 
diff --git a/tools/patman/test_cseries.py b/tools/patman/test_cseries.py
index e58f2f68333..c761e0e1f9a 100644
--- a/tools/patman/test_cseries.py
+++ b/tools/patman/test_cseries.py
@@ -3123,8 +3123,8 @@ Date:   .*
         repo = self.repo
 
         self.assertEqual(('fred', None),
-                         cser_helper.split_name_version('fred'))
-        self.assertEqual(('mary', 2), cser_helper.split_name_version('mary2'))
+                         patchstream.split_name_version('fred'))
+        self.assertEqual(('mary', 2), patchstream.split_name_version('mary2'))
 
         ser, version = cser._parse_series_and_version(None, None)
         self.assertEqual('first', ser.name)
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
