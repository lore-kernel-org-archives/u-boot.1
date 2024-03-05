Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC0DC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B460880D5;
	Tue,  5 Mar 2024 19:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vbabU7uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC707880D5; Tue,  5 Mar 2024 19:52:28 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FC487FA0
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 19:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (ip-109-42-176-242.web.vodafone.de [109.42.176.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E530F3F2C8; 
 Tue,  5 Mar 2024 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709664742;
 bh=E6HOPcSlckDl1Eub/1GIilgOUBM7dVxd74AMJ9j0dR4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vbabU7uuB4Kxfz6uN7QGRvyyzHmXic23S2jHTK8aNaGnOQC9qhwEAi8KsKGo3NUPn
 LFiaSJH9GpUlof2JcM9tKrcOPGKcSzVXaQCEIxmMtAlP1a8R9UwMUqY06oVEvTZbjS
 cz5LBUTAXhWoZes4wf3Sf2CQCnx8tcUxSUJ8O9WOCXdaqeTaX4Zr/kdOss5FXe972w
 +YRZhmSgDmMlil1aza+obAmg4QHolQo03Jnc1CsVa5cQxP28fZdqLutB52lJsuZZpx
 Fpd/lV4n5N9wom5u7sEpNWI0i6Uuos6QEVu3oIfY01cvjtXDxgx/tw6jQl3boj+S4b
 +3UamJN3LAQ+w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Benjamin Gray <bgray@linux.ibm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] doc/sphinx: fix Python string escapes
Date: Tue,  5 Mar 2024 19:52:03 +0100
Message-ID: <20240305185204.12108-1-heinrich.schuchardt@canonical.com>
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

From: Benjamin Gray <bgray@linux.ibm.com>

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Message-ID: <20230912060801.95533-3-bgray@linux.ibm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Adapted for U-Boot
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/cdomain.py             | 2 +-
 doc/sphinx/kernel_abi.py          | 2 +-
 doc/sphinx/kerneldoc.py           | 2 +-
 doc/sphinx/maintainers_include.py | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/sphinx/cdomain.py b/doc/sphinx/cdomain.py
index 014a5229e57..491a7ed5f47 100644
--- a/doc/sphinx/cdomain.py
+++ b/doc/sphinx/cdomain.py
@@ -93,7 +93,7 @@ def markup_ctype_refs(match):
 #
 RE_expr = re.compile(r':c:(expr|texpr):`([^\`]+)`')
 def markup_c_expr(match):
-    return '\ ``' + match.group(2) + '``\ '
+    return '\\ ``' + match.group(2) + '``\\ '
 
 #
 # Parse Sphinx 3.x C markups, replacing them by backward-compatible ones
diff --git a/doc/sphinx/kernel_abi.py b/doc/sphinx/kernel_abi.py
index f3da859c987..32c50e496b5 100644
--- a/doc/sphinx/kernel_abi.py
+++ b/doc/sphinx/kernel_abi.py
@@ -147,7 +147,7 @@ class KernelCmd(Directive):
                 code_block += "\n    " + l
             lines = code_block + "\n\n"
 
-        line_regex = re.compile("^#define LINENO (\S+)\#([0-9]+)$")
+        line_regex = re.compile(r"^#define LINENO (\S+)\#([0-9]+)$")
         ln = 0
         n = 0
         f = fname
diff --git a/doc/sphinx/kerneldoc.py b/doc/sphinx/kerneldoc.py
index 01a55429c57..bc8bb9e5125 100644
--- a/doc/sphinx/kerneldoc.py
+++ b/doc/sphinx/kerneldoc.py
@@ -130,7 +130,7 @@ class KernelDocDirective(Directive):
             result = ViewList()
 
             lineoffset = 0;
-            line_regex = re.compile("^#define LINENO ([0-9]+)$")
+            line_regex = re.compile(r"^#define LINENO ([0-9]+)$")
             for line in lines:
                 match = line_regex.search(line)
                 if match:
diff --git a/doc/sphinx/maintainers_include.py b/doc/sphinx/maintainers_include.py
index dc8fed48d3c..6cee52cbb39 100755
--- a/doc/sphinx/maintainers_include.py
+++ b/doc/sphinx/maintainers_include.py
@@ -79,7 +79,7 @@ class MaintainersInclude(Include):
             line = line.rstrip()
 
             # Linkify all non-wildcard refs to ReST files in Documentation/.
-            pat = '(Documentation/([^\s\?\*]*)\.rst)'
+            pat = r'(Documentation/([^\s\?\*]*)\.rst)'
             m = re.search(pat, line)
             if m:
                 # maintainers.rst is in a subdirectory, so include "../".
@@ -92,11 +92,11 @@ class MaintainersInclude(Include):
                 output = "| %s" % (line.replace("\\", "\\\\"))
                 # Look for and record field letter to field name mappings:
                 #   R: Designated *reviewer*: FullName <address@domain>
-                m = re.search("\s(\S):\s", line)
+                m = re.search(r"\s(\S):\s", line)
                 if m:
                     field_letter = m.group(1)
                 if field_letter and not field_letter in fields:
-                    m = re.search("\*([^\*]+)\*", line)
+                    m = re.search(r"\*([^\*]+)\*", line)
                     if m:
                         fields[field_letter] = m.group(1)
             elif subsystems:
@@ -114,7 +114,7 @@ class MaintainersInclude(Include):
                     field_content = ""
 
                     # Collapse whitespace in subsystem name.
-                    heading = re.sub("\s+", " ", line)
+                    heading = re.sub(r"\s+", " ", line)
                     output = output + "%s\n%s" % (heading, "~" * len(heading))
                     field_prev = ""
                 else:
-- 
2.43.0

