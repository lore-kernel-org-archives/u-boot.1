Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA8FC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A398210D;
	Thu,  8 May 2025 09:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l6t5uzvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603CF82AC4; Thu,  8 May 2025 09:29:51 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6527D82AA8
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so339852f8f.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689388; x=1747294188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lerWxM45T9HamWFoZfM3MD0oFGWxof+tDBq/16GL+Ms=;
 b=l6t5uzvvAiuOPU7wNYMYDzSnkD3q+a30ve7eIgavuuy7slFt++9x4SXBlqdeibHXSX
 G7UzUOF0OGgZlYQMLbycTLF4szmn6zuTdUY8puhnVZJhXitO4uTglGk/hQoHWU9X71LW
 4zLZOb4v3ib0eAVRPGbWI6F1g1nLtP+xXr95M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689388; x=1747294188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lerWxM45T9HamWFoZfM3MD0oFGWxof+tDBq/16GL+Ms=;
 b=vanhrsEfidEl4FUQo1DFQNhidIX5NoJTMpIbkQPYqU0YxFbEVU9h995ICHWj0JZwJB
 0dQZU6TuiWagSHUdAs5N0wVFCBhhqWBfYlFANhJICA7pYtPhtvQQfqPgkdhvTkkq7gzm
 P5br39R0Hu9kTOEYYuIUrwSJsFEBwluhM7R/G/eCVWmTpVbyVZTld/x4mkXHeqe9EP7O
 t6+IvmgmvFCUb+CncyXD32nWABbjOINSsLUy+in8HUG3WxJC7RymIjBQd6vX0KNlrOAZ
 ayraswv9Z/uawuqdj9ScaGrhcwtv6A02G3P0L6mj9jBdmsl52oVcoyVQPRwRKkdBjHZr
 h5Vg==
X-Gm-Message-State: AOJu0YzgQsVhaV5MzJi1XU95gPvx3wCIZdxbj8R+Zvwrdgn8dp2e9B6w
 RjQDa6795ggoykP68QnqK2+OaUkVg9hgtNi3mPUkQtBKpNKRfs/ZE+Z+BUyqz75nw7wU4nhkg7Y
 QPsG2GRAefg==
X-Gm-Gg: ASbGncsoVWEI6RdQxCkpb4GIo1k4warfIQIa0wGHA3SU92SFmCT2AWsTkC+EwTyF4z/
 avMvVVwOiCCq1AYL/kjqLotPL3rKC8Li+vQm56dCgB2iDeQNIr+4VMHnlRqsNOqD/uti8XYrrRk
 K4/mKa4iDPPbzVeMDL2Q04JEeV3mMoLhcnbkmn3IoWDoym+1bdPKx7ze85eWu1y0kfQoQ8TXt0Y
 nkGHAMkXuQfTNZqFwKGlItOG1tatiACIY3RjGm/QUig8fHwTU+DCVp4OQmgsbkB+QSdqGmxVqyZ
 BeD/YxTcwHxk12ckQDcHgAmt2GyRMA0ROztofA==
X-Google-Smtp-Source: AGHT+IG3Xwwu1iAGMNPj2xVls+OZKPlPCoj6IXLz6Ohw+zO7EU2gWhVTqHsgZDioUqAV3aSkn19lOQ==
X-Received: by 2002:a05:6000:178e:b0:3a1:1204:507c with SMTP id
 ffacd0b85a97d-3a1120452e2mr81672f8f.21.1746689388379; 
 Thu, 08 May 2025 00:29:48 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/20] patman: Tidy up function comments in the series module
Date: Thu,  8 May 2025 09:28:43 +0200
Message-ID: <20250508072907.207175-20-sjg@chromium.org>
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

This module is missing some comments, so add them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/series.py | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/patman/series.py b/tools/patman/series.py
index 66839a3dbea..97bb048c4b7 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -25,13 +25,23 @@ class Series(dict):
     """Holds information about a patch series, including all tags.
 
     Vars:
-        cc: List of aliases/emails to Cc all patches to
-        commits: List of Commit objects, one for each patch
-        cover: List of lines in the cover letter
-        notes: List of lines in the notes
-        changes: (dict) List of changes for each version, The key is
-            the integer version number
-        allow_overwrite: Allow tags to overwrite an existing tag
+        cc (list of str): Aliases/emails to Cc all patches to
+        to (list of str): Aliases/emails to send patches to
+        commits (list of Commit): Commit objects, one for each patch
+        cover (list of str): Lines in the cover letter
+        notes (list of str): Lines in the notes
+        changes: (dict) List of changes for each version:
+            key (int): version number
+            value: tuple:
+                commit (Commit): Commit this relates to, or None if related to a
+                    cover letter
+                info (str): change lines for this version (separated by \n)
+        allow_overwrite (bool): Allow tags to overwrite an existing tag
+        base_commit (Commit): Commit object at the base of this series
+        branch (str): Branch name of this series
+        _generated_cc (dict) written in MakeCcFile()
+            key: name of patch file
+            value: list of email addresses
     """
     def __init__(self):
         self.cc = []
@@ -44,10 +54,6 @@ class Series(dict):
         self.allow_overwrite = False
         self.base_commit = None
         self.branch = None
-
-        # Written in MakeCcFile()
-        #  key: name of patch file
-        #  value: list of email addresses
         self._generated_cc = {}
 
     # These make us more like a dictionary
@@ -375,8 +381,10 @@ class Series(dict):
         This will later appear in the change log.
 
         Args:
-            version: version number to add change list to
-            info: change line for this version
+            version (int): version number to add change list to
+            commit (Commit): Commit this relates to, or None if related to a
+                cover letter
+            info (str): change lines for this version (separated by \n)
         """
         if not self.changes.get(version):
             self.changes[version] = []
-- 
2.43.0

