Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15134C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2CA82952;
	Sun,  4 May 2025 15:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a2SPyN56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CA1829A1; Sun,  4 May 2025 15:24:14 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3965282A2F
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so536033966b.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365051; x=1746969851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlFVJA6sb/7FkTTQ2vjj+92v3u0tlR6FGbO+XwTKmmU=;
 b=a2SPyN56Cj228tPnq5aOKnU6dEsRIClCHeaJSc1dOqzAQkGLm9vQveq548sIS7XK7f
 5swB5TGNDq2x9UmjGofK2Xwb4a7o65vufu+3kd8K/t5ohtlsxUqHHgiDhe/YIfYM5Sdc
 /egkKzvYr9t8umQC4RCqHNm2SwT6Dzzw6UBJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365051; x=1746969851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlFVJA6sb/7FkTTQ2vjj+92v3u0tlR6FGbO+XwTKmmU=;
 b=JGimMzeaUjz+/N4hqGy5SGcLJcfN6jJXiBa0LzkzMwUFFRMAhgn/rGPyyxHZ3BCKkA
 zCwKJfka9G+2PCqvZERQWSx/xe/eXGqZLwBu2RzU8olP1KdtUPc+hzGwl0EUg+fwvzjg
 aSUEb0UoXS7Mqhe3pNscEYEao/77x3f+3wpNjZsTpfhBMKFeqRjGQLe0WP5odD6/WRkq
 pEoZlplD2Gtp+AwDYIqEoYP2cbHmiKV+OMzIzopEGB5yJWX8DzTXbucXEUshrKvVYBu5
 7+UFjeRMZ7+utEbOHv2KFZJEexdaozgG9BNAS9DDk8o7l3iq82LIdz3Vwh4KDM7r4F3O
 44KA==
X-Gm-Message-State: AOJu0Yx/CHbkRSmjt043mW6xrTAhfVBGNDU5SM819EdMybN/TlWcwX4G
 Ab0ZxwrGGwCG704LlzYjz7k7VAnxknnOUsI2sZyUwNQ0MyZ1e4NeXrpGYuOTS0POpktxHhBT1zP
 RVG7ddPY=
X-Gm-Gg: ASbGncvDjn4S/fYNJRCsFaSGUmoKOAq2hsQNIjsEmPlRxs5OQh3Ene2n2iPZtT/Hnrq
 yTYi4lgn7dj6E2FlnoJ2FEyB1jDxBh5BcZHfupu2dQwtGOuc5Y6+GHwsOs/C9iMyTG5cuz8dSHk
 JHi/Pgh7mUtrjrZ4vvqagAnttjLqt+GPZbHhvUiS2gj3VE4QlZ6hKASQ5D/vqC2Fzq5ZCiTbtmq
 raBKenUDJBE1w019yKNg6Ryc9cIo3jXQEGjZhKoaMt3SUfLTSUe7s1fNcASNOXk5E3ngX9EDch2
 AF/cpBCsQiv6LxOeqeX/R1iWPa9CkKCYZfoD
X-Google-Smtp-Source: AGHT+IFdKcRKX5kKTPRAb3KxCcTX6Cm9FDSA/T91JbQUeJqOzmflMQ6xkLmckpbO9Cq5JxF9ZFRSAQ==
X-Received: by 2002:a17:907:7f90:b0:ace:388e:d84a with SMTP id
 a640c23a62f3a-ad1a4a8dac7mr343234066b.47.1746365050820; 
 Sun, 04 May 2025 06:24:10 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/30] u_boot_pylib: Improve ANSI-colour output with
 backgrounds
Date: Sun,  4 May 2025 15:23:21 +0200
Message-ID: <20250504132356.2317305-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

