Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1305C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CAEC82AFC;
	Sun,  4 May 2025 15:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lNCxXYUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C6482B33; Sun,  4 May 2025 15:24:49 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B9482163
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5cded3e2eso1426072a12.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365085; x=1746969885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZALDu6xTNpAiTVGp4XmHpOBYU5gNCCgz3/RHld3038=;
 b=lNCxXYUW7TSkdRr6Gi0nSn2Y7o3pxLcsMkSQoRF9xIPFluzafM6BWvjdVFD0jrefJx
 KiLGTxR21S7tZIavfMLyNCThopcWxLRpP5BsIBZvBAMCkU+UQUvJYu0UIrY76vyQhxi/
 27EHJfx9j8xp0O7nyPMq3oodGJa7ftTA2K0Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365085; x=1746969885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZALDu6xTNpAiTVGp4XmHpOBYU5gNCCgz3/RHld3038=;
 b=ASHAjyMreZMozWVCr7hqnk0qHp3/Xr/vPxG60lHGoJ5NnEML6Ub0qTpvdKb8+UIZYU
 z1A0KhQiX0sGjKsYBglY4UDfz92U5QyxXAPXp7blabmfXeXug2SIw7xTibB4XnT4ifUk
 JDiAGwqFymLl5dFOUPQxmpCgpGL4xWf2NnTLBcS3QvakXp1mwoEnW/C8hjUelfzF5XF4
 jXxVDnnFOOlTRAwFHs9kbaR2LNhN7Ia1mv4yN0XCko2gL3qTASeMnGrBw7pn12hC7Pzj
 V1HnY0ggizSfbz36IvUHd45X3Fi7wsasuMu34sCnYvKBDylOnXvQQVuTeAsSHQ/ExCrX
 1hIw==
X-Gm-Message-State: AOJu0Yxqgqvu6ss+mixkkW+hg2CrpDJYT2mqZFXARh3kXWFBqkcxR9Ui
 dkPadIk4UCPoZ27pBCn4NGe7Fs5HtN586opBUxuoI/FLdHmq4Me5rlmG1gymGtFI32uK1jlAS/P
 VZuK9CpE=
X-Gm-Gg: ASbGncvRZJ5LvzLbmnvz9S3kftmLAgKiZD3Tq7GchVbH/D5XCPGsgRrUPxZtiqk8+mu
 zb8ZduuGnVc5v4PdP/D6M8kHeNG9+q5mUCEcHQHDcVB+nYrCoXcKfGIcc2hhj7STPFbf63D7TGV
 qxLt2K3QCg9NJP3TVqVy783ZJbusdCHhBo98H5msFoEACkgmabBo3bZyF6WN0dfOcyJ2+/+9Kzw
 iYAvv26MTq4VVWdkcphsTHmaFMH6HXe+SAz/tl+77GTJMlFoEj6NHCE1K8EfBWZEBBmxXbl7gF5
 Wa/UI43SYxWICnH8ndMKf5bnae62SYwxPBL7MZ6b7WYgv+0=
X-Google-Smtp-Source: AGHT+IGmqjEHHaTRNeXPZ1f31dMOYmj5rFaIAGWh+5RbYTiJCmv4oi8pu99Z8vB/+traUmgu6kCkIw==
X-Received: by 2002:a17:907:2d1f:b0:ad1:8169:da0b with SMTP id
 a640c23a62f3a-ad19069aee4mr460937666b.31.1746365085322; 
 Sun, 04 May 2025 06:24:45 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/30] patman: Show patches in yellow
Date: Sun,  4 May 2025 15:23:40 +0200
Message-ID: <20250504132356.2317305-25-sjg@chromium.org>
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

When comments are shown below patches it can be hard to see the patch
subject. Use yellow instead of blue, since it stands out better.

Pass the colour object into show_responses() rather than creating a new
one, since that is tidier.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |  8 ++++----
 tools/patman/status.py    | 15 ++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 3f7573a41a8..47fbbe0cc3f 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -1043,7 +1043,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
                                      pwork)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
-        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('    Reviewed-by: ', col.GREEN, newline=False,
@@ -1052,7 +1052,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         self.assertEqual(terminal.PrintLine(self.joe, col.WHITE, bright=False),
                          next(lines))
 
-        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('    Reviewed-by: ', col.GREEN, newline=False,
@@ -1359,7 +1359,7 @@ Reviewed-by: %s
                                      pwork)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
-        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
@@ -1380,7 +1380,7 @@ Reviewed-by: %s
             '    Here is my comment above the above...', None), next(lines))
         self.assertEqual(terminal.PrintLine('', None), next(lines))
 
-        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.BLUE),
+        self.assertEqual(terminal.PrintLine('  2 Subject 2', col.YELLOW),
                          next(lines))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 5c75d7b10c6..c114a432bf3 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -203,10 +203,11 @@ def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, pwork):
     new_rtag_list[seq] = new_rtags
     review_list[seq] = reviews
 
-def show_responses(rtags, indent, is_new):
+def show_responses(col, rtags, indent, is_new):
     """Show rtags collected
 
     Args:
+        col (terminal.Colour): Colour object to use
         rtags (dict): review tags to show
             key: Response tag (e.g. 'Reviewed-by')
             value: Set of people who gave that response, each a name/email string
@@ -216,14 +217,14 @@ def show_responses(rtags, indent, is_new):
     Returns:
         int: Number of review tags displayed
     """
-    col = terminal.Color()
     count = 0
     for tag in sorted(rtags.keys()):
         people = rtags[tag]
         for who in sorted(people):
             terminal.tprint(indent + '%s %s: ' % ('+' if is_new else ' ', tag),
-                           newline=False, colour=col.GREEN, bright=is_new)
-            terminal.tprint(who, colour=col.WHITE, bright=is_new)
+                           newline=False, colour=col.GREEN, bright=is_new,
+                           col=col)
+            terminal.tprint(who, colour=col.WHITE, bright=is_new, col=col)
             count += 1
     return count
 
@@ -357,14 +358,14 @@ def do_show_status(series, patch_for_commit, show_comments, new_rtag_list,
         if not patch:
             continue
         terminal.tprint('%3d %s' % (patch.seq, patch.subject[:50]),
-                       colour=col.BLUE)
+                       colour=col.YELLOW, col=col)
         cmt = series.commits[seq]
         base_rtags = cmt.rtags
         new_rtags = new_rtag_list[seq]
 
         indent = ' ' * 2
-        show_responses(base_rtags, indent, False)
-        num_to_add += show_responses(new_rtags, indent, True)
+        show_responses(col, base_rtags, indent, False)
+        num_to_add += show_responses(col, new_rtags, indent, True)
         if show_comments:
             for review in review_list[seq]:
                 terminal.tprint('Review: %s' % review.meta, colour=col.RED)
-- 
2.43.0

