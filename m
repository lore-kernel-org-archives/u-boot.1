Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF5BC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4D2828F8;
	Tue, 29 Apr 2025 15:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTyS5fCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176AA8293C; Tue, 29 Apr 2025 15:23:52 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E17D8291D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c14138668so1588149a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933027; x=1746537827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NP5Xf0MboZI2V8RbFPyAmddDekT1pjgx9tlz465cea0=;
 b=jTyS5fCTaoSw1c/bnjPu08JDdSuAxcbS+kEhVRNE82p6yuG84a2FYh2VyGCT7E8iC9
 t9T7o8iLbyF1EefH7uW3+GBRNCAEtMAwTzue6q81ABH/UbtlrDpKAGycT1wJuPMkFfRx
 n6hXsJ7VEmjIgo/oZUah62tItDeeRU8i6qz5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933027; x=1746537827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NP5Xf0MboZI2V8RbFPyAmddDekT1pjgx9tlz465cea0=;
 b=DN5XFkYIlxpXRn11nqNeRP5kwuRXTY8eOTUktkjpBQCT2KRKowm6CuM1VRaDRvAv0J
 ttPgW24/fPDLqufVnw1tvk4SrohZqSuaccj7ZkTYujfPncvtwaTrsMtBijVnzjmfdoPe
 N3CY5QKxt9mNISuhkMEiIgMCU4NVaXS/1Tuv+JJVFrCTv/NNmK5fTBkFSsnSyiE5Qsbu
 dn13nBSvmU9aQRAWak3nIMeDG1stmzsIlldDN5AgiKuTDtsrzXqQhTAwDnUuGVOEEDyw
 0Z7lwQQRRJ1XQFpgbgXGFv40/Qu9SXNmyQvIK/dTrnNjuhaHlCroDc+TozSAq0C01eXw
 vmpA==
X-Gm-Message-State: AOJu0Yx0IcUia0B+Ef/YNqHenm5VSnekgzgy5m7sS0vhww0H0wUOoJj7
 1r09BoE4/mHqLZyBJcqdFTZGNgfC9GOAq5+uLHIoJqvfgjmPnOaugEt28LSaaQkWR/4BY9M09+A
 =
X-Gm-Gg: ASbGncuHpOjIe3fY9fHsH7SMIKEy6zneFeXllp/ssnUnX7Jl8krvwILw4vAy6IkrxAd
 lRwgecEIq8BiZB5oDqD/PKuuKVm6pU4+qKQltgfP3mzsMS3x0Fqto78bxbntV4jv9ppzn7P6Ctg
 PQ3uKG4wDO0Yng3VrsERtJwS9DCvcuDz6DGDt2nJgahjQpY62t7aPOvYK0dENN1bilADlIVVuXe
 ctnxbVx0w35GnWdd3G/XMLbSyEGzrMIm96fMfubGvhTuQVgxwwyqzJbqDu7L/2MqkUth5r54MlN
 YcYHatIdNxsSj30xQZog5CFygSoqgPCD9fRZCv9edpQAOhCOxGwmWwjhhgYiLdhOT6PD7g6Id1g
 LYmj3FHCEQ1l6
X-Google-Smtp-Source: AGHT+IGddP+BeFB7tnj3d8qLFgtYg7pzVAfDzN5naRrp0s8H/7juAr8+HKqX7D4A73rs6Do/Sc1KTQ==
X-Received: by 2002:a05:6830:d84:b0:727:423c:95ea with SMTP id
 46e09a7af769-730652634c1mr7720223a34.19.1745933027466; 
 Tue, 29 Apr 2025 06:23:47 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/30] u_boot_pylib: Improve ANSI-colour output with
 backgrounds
Date: Tue, 29 Apr 2025 07:22:02 -0600
Message-ID: <20250429132239.251756-6-sjg@chromium.org>
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

The current implementation does not handle background colours very well:

- It outputs an incorrect code in some cases, leading to wrong colours
- Some functions lack a control for the background

Tidy this up so that background colours can be used in more places.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/terminal.py | 38 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/u_boot_pylib/terminal.py b/tools/u_boot_pylib/terminal.py
index 4b9a907a547..6bd790acc3f 100644
--- a/tools/u_boot_pylib/terminal.py
+++ b/tools/u_boot_pylib/terminal.py
@@ -139,7 +139,8 @@ def trim_ascii_len(text, size):
     return out
 
 
-def tprint(text='', newline=True, colour=None, limit_to_line=False, bright=True):
+def tprint(text='', newline=True, colour=None, limit_to_line=False,
+           bright=True, back=None, col=None):
     """Handle a line of output to the terminal.
 
     In test mode this is recorded in a list. Otherwise it is output to the
@@ -155,9 +156,10 @@ def tprint(text='', newline=True, colour=None, limit_to_line=False, bright=True)
     if print_test_mode:
         print_test_list.append(PrintLine(text, colour, newline, bright))
     else:
-        if colour:
-            col = Color()
-            text = col.build(colour, text, bright=bright)
+        if colour is not None:
+            if not col:
+                col = Color()
+            text = col.build(colour, text, bright=bright, back=back)
         if newline:
             print(text)
             last_print_len = None
@@ -214,9 +216,10 @@ class Color(object):
     """Conditionally wraps text in ANSI color escape sequences."""
     BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)
     BOLD = -1
-    BRIGHT_START = '\033[1;%dm'
-    NORMAL_START = '\033[22;%dm'
+    BRIGHT_START = '\033[1;%d%sm'
+    NORMAL_START = '\033[22;%d%sm'
     BOLD_START = '\033[1m'
+    BACK_EXTRA = ';%d'
     RESET = '\033[0m'
 
     def __init__(self, colored=COLOR_IF_TERMINAL):
@@ -233,7 +236,14 @@ class Color(object):
         except:
             self._enabled = False
 
-    def start(self, color, bright=True):
+    def enabled(self):
+        """Check if colour is enabled
+
+        Return: True if enabled, else False
+        """
+        return self._enabled
+
+    def start(self, color, bright=True, back=None):
         """Returns a start color code.
 
         Args:
@@ -244,8 +254,11 @@ class Color(object):
           color, otherwise returns empty string
         """
         if self._enabled:
+            if color == self.BOLD:
+                return self.BOLD_START
             base = self.BRIGHT_START if bright else self.NORMAL_START
-            return base % (color + 30)
+            extra = self.BACK_EXTRA % (back + 40) if back else ''
+            return base % (color + 30, extra)
         return ''
 
     def stop(self):
@@ -259,7 +272,7 @@ class Color(object):
             return self.RESET
         return ''
 
-    def build(self, color, text, bright=True):
+    def build(self, color, text, bright=True, back=None):
         """Returns text with conditionally added color escape sequences.
 
         Keyword arguments:
@@ -274,12 +287,7 @@ class Color(object):
         """
         if not self._enabled:
             return text
-        if color == self.BOLD:
-            start = self.BOLD_START
-        else:
-            base = self.BRIGHT_START if bright else self.NORMAL_START
-            start = base % (color + 30)
-        return start + text + self.RESET
+        return self.start(color, bright, back) + text + self.RESET
 
 
 # Use this to suppress stdout/stderr output:
-- 
2.43.0

