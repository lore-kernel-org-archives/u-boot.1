Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414E2C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08B5829A1;
	Tue, 29 Apr 2025 15:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V8Mc6hxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F49B82145; Tue, 29 Apr 2025 15:24:34 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B778182A38
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72a4793d4e2so4421429a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933068; x=1746537868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ2B1KiiKJElgbMC0WXufK1J4CnUE63BMK0A2TmE+LI=;
 b=V8Mc6hxWFNt0uzDkeDHR5EXxIWT8BfygY2IYXCVRXTWIpSpooH7BUFuh8AItDyB3ZG
 83e3ytrTXOfbqpd1u4w6YJWPaegcn0NY2e8wjtu1hCZ+9SvmeSQNpERAv19JUOYu5uE+
 +coKD8MFJJCyukvixJDBme8Sk12aEGQrDjPPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933068; x=1746537868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQ2B1KiiKJElgbMC0WXufK1J4CnUE63BMK0A2TmE+LI=;
 b=XrHmnkpYq6/4bYzBJAnSlLNryoZ+NTcyoUr8aGy3fZOJK2cnYs4JMWc7XfmiEaGkfY
 Oir67vHSwl6DFaRHJOaeuX+3tou0l724mGSnd2XUt5BuJTXgy7vcidW2PvV6XFn9bw2e
 IUDvBm7llOqwhUvmXH6Ytoy8AWdCzp5oG8qDagz4yRL2JV0iFE68snEeWUGitYbeVV50
 ph5wzZqSJyq8pwcsfSBHgu0TmMUEsLNW/Vgna6mm8G82zIFz8leCMzqJNn3s8w+gIpps
 AAlDGuTgiVu2YngBaXQqA8t2omG3UCdmDtQ7cakqUcRGB6C3DT/hySXjy5vDiH6nUP7y
 VDnQ==
X-Gm-Message-State: AOJu0YwUmNL+qGv1mvpiyEG5On5HGwKUK2WiKX+RGI/cKFX5R7yoOdo/
 cH66jFTIqWkqDSw3UGvXaBuWns9GWtIFTUdeWYX8cjWGqaa+Mb8ys4ett6dEDT/DgXzIJZZhUKU
 =
X-Gm-Gg: ASbGncv/9B4ASkfseWWpuIf/P3Wj7Fu/V8Hl4UsCoTVQHR6Iv0dWB6KrUmRQi1C0lPQ
 MyokqvdGfWd3IYqO6bTig5++CutV2CeQ0nqt4rhl/bie6WwVq/Q/W/cejmVFPWaE799KUp602LC
 8FZEdcv11U2GzAzdk79D29ZHv1ycMcRG/O2yDXNq7E7JXiipvVmM7wo7qEcZSid0sebhSPwgGUv
 1GPVJ4dSLjMOvnTEE6HQrN36fmXFPRgt9s6F+TMZaQehiS6SXkmAWFv4Cyxk+h464bLgQPO4fVe
 +S6lFCleHilh7nyJdwTe2Cdi/osLHrdTHP+f/elpC0nCIH/PPbSMO/XX9vJgF7HHIphMgovp3Pf
 Cuw==
X-Google-Smtp-Source: AGHT+IHyliZSAXRpJN0cZJiiexj/ozM+FOfq81qqNNX3UXpm96VJAuxnIl9Vyz0UZX060mOGIASM2A==
X-Received: by 2002:a05:6830:4904:b0:727:24ab:3e4 with SMTP id
 46e09a7af769-7308971f767mr2128930a34.9.1745933068180; 
 Tue, 29 Apr 2025 06:24:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/30] patman: Move Patch and Review to patchwork module
Date: Tue, 29 Apr 2025 07:22:14 -0600
Message-ID: <20250429132239.251756-18-sjg@chromium.org>
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

These relate to information obtained from the patchwork server, so move
their definition into the new patchwork module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py |  21 +++----
 tools/patman/patchwork.py | 113 ++++++++++++++++++++++++++++++++++++
 tools/patman/status.py    | 119 ++------------------------------------
 3 files changed, 129 insertions(+), 124 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index b3145612f9f..50fb53787d8 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -20,6 +20,7 @@ from patman.commit import Commit
 from patman import control
 from patman import patchstream
 from patman.patchstream import PatchStream
+from patman import patchwork
 from patman import send
 from patman.series import Series
 from patman import settings
@@ -807,7 +808,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
 
     def test_parse_subject(self):
         """Test parsing of the patch subject"""
-        patch = status.Patch('1')
+        patch = patchwork.Patch('1')
 
         # Simple patch not in a series
         patch.parse_subject('Testing')
@@ -876,11 +877,11 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         commit3 = Commit('3456')
         commit3.subject = 'Subject 2'
 
-        patch1 = status.Patch('1')
+        patch1 = patchwork.Patch('1')
         patch1.subject = 'Subject 1'
-        patch2 = status.Patch('2')
+        patch2 = patchwork.Patch('2')
         patch2.subject = 'Subject 2'
-        patch3 = status.Patch('3')
+        patch3 = patchwork.Patch('3')
         patch3.subject = 'Subject 2'
 
         series = Series()
@@ -976,7 +977,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         commit2 = Commit('ef12')
         commit2.subject = 'Subject 2'
 
-        patch1 = status.Patch('1')
+        patch1 = patchwork.Patch('1')
         patch1.parse_subject('[1/2] Subject 1')
         patch1.name = patch1.raw_subject
         patch1.content = 'This is my patch content'
@@ -984,7 +985,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
 
         patch1.comments = [comment1a]
 
-        patch2 = status.Patch('2')
+        patch2 = patchwork.Patch('2')
         patch2.parse_subject('[2/2] Subject 2')
         patch2.name = patch2.raw_subject
         patch2.content = 'Some other patch content'
@@ -1120,7 +1121,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         series = patchstream.get_metadata_for_list(branch, gitdir, count)
         self.assertEqual(2, len(series.commits))
 
-        patch1 = status.Patch('1')
+        patch1 = patchwork.Patch('1')
         patch1.parse_subject('[1/2] %s' % series.commits[0].subject)
         patch1.name = patch1.raw_subject
         patch1.content = 'This is my patch content'
@@ -1128,7 +1129,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
 
         patch1.comments = [comment1a]
 
-        patch2 = status.Patch('2')
+        patch2 = patchwork.Patch('2')
         patch2.parse_subject('[2/2] %s' % series.commits[1].subject)
         patch2.name = patch2.raw_subject
         patch2.content = 'Some other patch content'
@@ -1291,7 +1292,7 @@ line8
         commit2 = Commit('ef12')
         commit2.subject = 'Subject 2'
 
-        patch1 = status.Patch('1')
+        patch1 = patchwork.Patch('1')
         patch1.parse_subject('[1/2] Subject 1')
         patch1.name = patch1.raw_subject
         patch1.content = 'This is my patch content'
@@ -1312,7 +1313,7 @@ Reviewed-by: %s
 
         patch1.comments = [comment1a]
 
-        patch2 = status.Patch('2')
+        patch2 = patchwork.Patch('2')
         patch2.parse_subject('[2/2] Subject 2')
         patch2.name = patch2.raw_subject
         patch2.content = 'Some other patch content'
diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index 0456f98e83c..bb3645455fe 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -6,6 +6,7 @@
 """
 
 import asyncio
+import re
 
 import aiohttp
 
@@ -15,6 +16,118 @@ RETRIES = 3
 # Max concurrent request
 MAX_CONCURRENT = 50
 
+# Patches which are part of a multi-patch series are shown with a prefix like
+# [prefix, version, sequence], for example '[RFC, v2, 3/5]'. All but the last
+# part is optional. This decodes the string into groups. For single patches
+# the [] part is not present:
+# Groups: (ignore, ignore, ignore, prefix, version, sequence, subject)
+RE_PATCH = re.compile(r'(\[(((.*),)?(.*),)?(.*)\]\s)?(.*)$')
+
+# This decodes the sequence string into a patch number and patch count
+RE_SEQ = re.compile(r'(\d+)/(\d+)')
+
+
+class Patch(dict):
+    """Models a patch in patchwork
+
+    This class records information obtained from patchwork
+
+    Some of this information comes from the 'Patch' column:
+
+        [RFC,v2,1/3] dm: Driver and uclass changes for tiny-dm
+
+    This shows the prefix, version, seq, count and subject.
+
+    The other properties come from other columns in the display.
+
+    Properties:
+        pid (str): ID of the patch (typically an integer)
+        seq (int): Sequence number within series (1=first) parsed from sequence
+            string
+        count (int): Number of patches in series, parsed from sequence string
+        raw_subject (str): Entire subject line, e.g.
+            "[1/2,v2] efi_loader: Sort header file ordering"
+        prefix (str): Prefix string or None (e.g. 'RFC')
+        version (str): Version string or None (e.g. 'v2')
+        raw_subject (str): Raw patch subject
+        subject (str): Patch subject with [..] part removed (same as commit
+            subject)
+    """
+    def __init__(self, pid):
+        super().__init__()
+        self.id = pid  # Use 'id' to match what the Rest API provides
+        self.seq = None
+        self.count = None
+        self.prefix = None
+        self.version = None
+        self.raw_subject = None
+        self.subject = None
+
+    # These make us more like a dictionary
+    def __setattr__(self, name, value):
+        self[name] = value
+
+    def __getattr__(self, name):
+        return self[name]
+
+    def __hash__(self):
+        return hash(frozenset(self.items()))
+
+    def __str__(self):
+        return self.raw_subject
+
+    def parse_subject(self, raw_subject):
+        """Parse the subject of a patch into its component parts
+
+        See RE_PATCH for details. The parsed info is placed into seq, count,
+        prefix, version, subject
+
+        Args:
+            raw_subject (str): Subject string to parse
+
+        Raises:
+            ValueError: the subject cannot be parsed
+        """
+        self.raw_subject = raw_subject.strip()
+        mat = RE_PATCH.search(raw_subject.strip())
+        if not mat:
+            raise ValueError(f"Cannot parse subject '{raw_subject}'")
+        self.prefix, self.version, seq_info, self.subject = mat.groups()[3:]
+        mat_seq = RE_SEQ.match(seq_info) if seq_info else False
+        if mat_seq is None:
+            self.version = seq_info
+            seq_info = None
+        if self.version and not self.version.startswith('v'):
+            self.prefix = self.version
+            self.version = None
+        if seq_info:
+            if mat_seq:
+                self.seq = int(mat_seq.group(1))
+                self.count = int(mat_seq.group(2))
+        else:
+            self.seq = 1
+            self.count = 1
+
+
+class Review:
+    """Represents a single review email collected in Patchwork
+
+    Patches can attract multiple reviews. Each consists of an author/date and
+    a variable number of 'snippets', which are groups of quoted and unquoted
+    text.
+    """
+    def __init__(self, meta, snippets):
+        """Create new Review object
+
+        Args:
+            meta (str): Text containing review author and date
+            snippets (list): List of snippets in th review, each a list of text
+                lines
+        """
+        self.meta = ' : '.join([line for line in meta.splitlines() if line])
+        self.snippets = snippets
+
+
 class Patchwork:
     """Class to handle communication with patchwork
     """
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 5fb436e08ff..8edb4ced449 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -11,25 +11,16 @@ collected from patchwork.
 import collections
 import concurrent.futures
 from itertools import repeat
-import re
 
 import pygit2
 import requests
 
-from patman import patchstream
-from patman.patchstream import PatchStream
 from u_boot_pylib import terminal
 from u_boot_pylib import tout
+from patman import patchstream
+from patman import patchwork
+from patman.patchstream import PatchStream
 
-# Patches which are part of a multi-patch series are shown with a prefix like
-# [prefix, version, sequence], for example '[RFC, v2, 3/5]'. All but the last
-# part is optional. This decodes the string into groups. For single patches
-# the [] part is not present:
-# Groups: (ignore, ignore, ignore, prefix, version, sequence, subject)
-RE_PATCH = re.compile(r'(\[(((.*),)?(.*),)?(.*)\]\s)?(.*)$')
-
-# This decodes the sequence string into a patch number and patch count
-RE_SEQ = re.compile(r'(\d+)/(\d+)')
 
 def to_int(vals):
     """Convert a list of strings into integers, using 0 if not an integer
@@ -44,106 +35,6 @@ def to_int(vals):
     return out
 
 
-class Patch(dict):
-    """Models a patch in patchwork
-
-    This class records information obtained from patchwork
-
-    Some of this information comes from the 'Patch' column:
-
-        [RFC,v2,1/3] dm: Driver and uclass changes for tiny-dm
-
-    This shows the prefix, version, seq, count and subject.
-
-    The other properties come from other columns in the display.
-
-    Properties:
-        pid (str): ID of the patch (typically an integer)
-        seq (int): Sequence number within series (1=first) parsed from sequence
-            string
-        count (int): Number of patches in series, parsed from sequence string
-        raw_subject (str): Entire subject line, e.g.
-            "[1/2,v2] efi_loader: Sort header file ordering"
-        prefix (str): Prefix string or None (e.g. 'RFC')
-        version (str): Version string or None (e.g. 'v2')
-        raw_subject (str): Raw patch subject
-        subject (str): Patch subject with [..] part removed (same as commit
-            subject)
-    """
-    def __init__(self, pid):
-        super().__init__()
-        self.id = pid  # Use 'id' to match what the Rest API provides
-        self.seq = None
-        self.count = None
-        self.prefix = None
-        self.version = None
-        self.raw_subject = None
-        self.subject = None
-
-    # These make us more like a dictionary
-    def __setattr__(self, name, value):
-        self[name] = value
-
-    def __getattr__(self, name):
-        return self[name]
-
-    def __hash__(self):
-        return hash(frozenset(self.items()))
-
-    def __str__(self):
-        return self.raw_subject
-
-    def parse_subject(self, raw_subject):
-        """Parse the subject of a patch into its component parts
-
-        See RE_PATCH for details. The parsed info is placed into seq, count,
-        prefix, version, subject
-
-        Args:
-            raw_subject (str): Subject string to parse
-
-        Raises:
-            ValueError: the subject cannot be parsed
-        """
-        self.raw_subject = raw_subject.strip()
-        mat = RE_PATCH.search(raw_subject.strip())
-        if not mat:
-            raise ValueError("Cannot parse subject '%s'" % raw_subject)
-        self.prefix, self.version, seq_info, self.subject = mat.groups()[3:]
-        mat_seq = RE_SEQ.match(seq_info) if seq_info else False
-        if mat_seq is None:
-            self.version = seq_info
-            seq_info = None
-        if self.version and not self.version.startswith('v'):
-            self.prefix = self.version
-            self.version = None
-        if seq_info:
-            if mat_seq:
-                self.seq = int(mat_seq.group(1))
-                self.count = int(mat_seq.group(2))
-        else:
-            self.seq = 1
-            self.count = 1
-
-
-class Review:
-    """Represents a single review email collected in Patchwork
-
-    Patches can attract multiple reviews. Each consists of an author/date and
-    a variable number of 'snippets', which are groups of quoted and unquoted
-    text.
-    """
-    def __init__(self, meta, snippets):
-        """Create new Review object
-
-        Args:
-            meta (str): Text containing review author and date
-            snippets (list): List of snippets in th review, each a list of text
-                lines
-        """
-        self.meta = ' : '.join([line for line in meta.splitlines() if line])
-        self.snippets = snippets
-
 def compare_with_series(series, patches):
     """Compare a list of patches with a series it came from
 
@@ -253,7 +144,7 @@ def collect_patches(series, series_id, url, rest_api=call_rest_api):
     # Work through each row (patch) one at a time, collecting the information
     warn_count = 0
     for pw_patch in patch_dict:
-        patch = Patch(pw_patch['id'])
+        patch = patchwork.Patch(pw_patch['id'])
         patch.parse_subject(pw_patch['name'])
         patches.append(patch)
     if warn_count > 1:
@@ -304,7 +195,7 @@ def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, url,
         if pstrm.snippets:
             submitter = comment['submitter']
             person = '%s <%s>' % (submitter['name'], submitter['email'])
-            reviews.append(Review(person, pstrm.snippets))
+            reviews.append(patchwork.Review(person, pstrm.snippets))
         for response, people in pstrm.commit.rtags.items():
             rtags[response].update(people)
 
-- 
2.43.0

