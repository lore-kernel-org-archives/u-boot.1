Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5E0CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3965586EE2;
	Fri, 13 Oct 2023 18:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QQyjZRbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A5486EE2; Fri, 13 Oct 2023 18:29:29 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5359586A6B
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79faba5fe12so83341339f.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697214547; x=1697819347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYByFnkimg7UbixGJQsfaawTPUFS60YFdE08zkQpaQo=;
 b=QQyjZRbM1e+JeaYHc8RVd4KgisfBqRV8G+curWpzvhK8L1FkHivL+q9kiVT7l76U/O
 YYPNL5iW9GmQwNg6f7S3kMU5kSu6UIXX8jBF61Xf60hkpYGk+N/yiKwvIqoAodo8OKf7
 KnHOphcXAi0ALx4U92N/ds9cyS50DCD83ZgWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697214547; x=1697819347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYByFnkimg7UbixGJQsfaawTPUFS60YFdE08zkQpaQo=;
 b=oD2ac2B7n41hcJQZZvdettJrMjigH0mmbiIyceGWwHKuQLF4+uKhnUpaE1EPIDqdJ8
 UaEH6uM6KOZia8pc5WVf5i/+EESPR6+qvp3VshZfA8/DOms9XPDcp0i/DTj/1wY1tayd
 ui5KqBLoy/ohzCyTc38zoUBaexvVD+ldzhTwNDj1cdL7xTHnnm9XIi77/PELWeeelbPH
 RP06NJSDPUG1LpIn1MmeAvm08ywVVFS2UAF7/VRX5m2JUAi0b6hAMIJuteoJoJAmFIOm
 yd6i5HlOq8+Y3yOoPxB4JpqB/lZJLlvYJlOVa9U95a9kc/0btSCndZNVuEPkPuBfterQ
 j9LA==
X-Gm-Message-State: AOJu0Yxpg8JKtsIoayB3miWrv0khVBrRe9qCxkHXMYexg6onJ+8d8nZW
 ohCVF0/Ag61zTwjytBEu4F6GqYLF86haQBWdl3Gs4w==
X-Google-Smtp-Source: AGHT+IE0ovS9w6aq1LPuLAVvn/8w7stEguRpzgAsH6H89CqC+focMOMlQzJGLwYlC+7Ssx3A+iqMKQ==
X-Received: by 2002:a6b:919:0:b0:790:6629:b222 with SMTP id
 t25-20020a6b0919000000b007906629b222mr29924034ioi.5.1697214546946; 
 Fri, 13 Oct 2023 09:29:06 -0700 (PDT)
Received: from sjg1.www.unitedwifi.com ([75.104.104.107])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a5edd42000000b0077a1d1029fcsm4816757iop.28.2023.10.13.09.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:29:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/2] patman: Add a little documentation on the checkpatch
 tests
Date: Fri, 13 Oct 2023 09:28:33 -0700
Message-ID: <20231013162836.1911982-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231013162836.1911982-1-sjg@chromium.org>
References: <20231013162836.1911982-1-sjg@chromium.org>
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

These texts lack comments. Add some so that it is clearer what is going
on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/test_checkpatch.py | 49 +++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index f8117460ced2..0a8f7408f146 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -18,19 +18,47 @@ from patman import commit
 
 
 class Line:
+    """Single changed line in one file in a patch
+
+    Args:
+        fname (str): Filename containing the added line
+        text (str): Text of the added line
+    """
     def __init__(self, fname, text):
         self.fname = fname
         self.text = text
 
 
 class PatchMaker:
+    """Makes a patch for checking with checkpatch.pl
+
+    The idea here is to create a patch which adds one line in one file,
+    intended to provoke a checkpatch error or warning. The base patch is empty
+    (i.e. invalid), so you should call add_line() to add at least one line.
+    """
     def __init__(self):
+        """Set up the PatchMaker object
+
+        Properties:
+            lines (list of Line): List of lines to add to the patch. Note that
+                each line has both a file and some text associated with it,
+                since for simplicity we just add a single line for each file
+        """
         self.lines = []
 
     def add_line(self, fname, text):
+        """Add to the list of filename/line pairs"""
         self.lines.append(Line(fname, text))
 
     def get_patch_text(self):
+        """Build the patch text
+
+        Takes a base patch and adds a diffstat and patch for each filename/line
+        pair in the list.
+
+        Returns:
+            str: Patch text ready for submission to checkpatch
+        """
         base = '''From 125b77450f4c66b8fd9654319520bbe795c9ef31 Mon Sep 17 00:00:00 2001
 From: Simon Glass <sjg@chromium.org>
 Date: Sun, 14 Jun 2020 09:45:14 -0600
@@ -75,6 +103,11 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
         return '\n'.join(lines)
 
     def get_patch(self):
+        """Get the patch text and write it into a temporary file
+
+        Returns:
+            str: Filename containing the patch
+        """
         inhandle, inname = tempfile.mkstemp()
         infd = os.fdopen(inhandle, 'w')
         infd.write(self.get_patch_text())
@@ -82,6 +115,22 @@ Signed-off-by: Simon Glass <sjg@chromium.org>
         return inname
 
     def run_checkpatch(self):
+        """Run checkpatch on the patch file
+
+        Returns:
+            namedtuple containing:
+                ok: False=failure, True=ok
+                problems: List of problems, each a dict:
+                    'type'; error or warning
+                    'msg': text message
+                    'file' : filename
+                    'line': line number
+                errors: Number of errors
+                warnings: Number of warnings
+                checks: Number of checks
+                lines: Number of lines
+                stdout: Full output of checkpatch
+        """
         return checkpatch.check_patch(self.get_patch(), show_types=True)
 
 
-- 
2.42.0.655.g421f12c284-goog

