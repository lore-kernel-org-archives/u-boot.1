Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82424C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB5D88577;
	Sun, 23 Jun 2024 22:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BdJg5Px/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB462883C8; Sun, 23 Jun 2024 22:30:49 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF6C884B2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so152989239f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174645; x=1719779445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDqR2ev7V1mshcmHUcnU4wdYWDp399Tm/OL8d9oKlac=;
 b=BdJg5Px/sxGYYlEjrhQKqL10D2QAA6BBigZULhZb99tOaTpn3uFtqmyoEWTmXDZAYz
 PyHIqHModIT1kJpYwUhcund+wXsgD9wsl9XvEnSQDKGRjDJQn9dJTLfozcqErkCWuW8t
 /cqdzLfZdof+Q2ZMKLJuPkX6fUIerO7cG792I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174645; x=1719779445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDqR2ev7V1mshcmHUcnU4wdYWDp399Tm/OL8d9oKlac=;
 b=LaiTTD7UdFQwgUovrJ92OVvGVlAvi6u7VeAHT+uXQ1TwgskOcmTvQPuq/9wXem6vo4
 qS+eFlF2vzDObi0hOjUlWxVTWuYnlFTWzn0BE1zlYD7PBBPrrvuXTyvQyOSy8/Fmc6tR
 WXC3PVhrUNxFyq4iBPu9TAbTdnNo7OSjdK7HgRx53wATsZeVq0LxMbcbyFPTkseh6z1F
 rBjQdh7TVOGBiJoTvYnD9WVqk+EreIZ+MpaLpHE9j3U6muqdNWHwGDunS3XjNh6/kMDK
 F3PZTQQIx/YcyxH3G/oLw2pOEK1NPnwpSwEBrxcSwLYgsARWHTO+MzxRq5k4Jz0mjTCA
 ep3w==
X-Gm-Message-State: AOJu0Yx33wNUmnEB85SuJZooRtpfYEVdcYY8cOhmoPwuz6YguBxmya3W
 098gxwGCi/JmZsK855kI90bpGzUhtvWO7Yo4fByQK3Zy1k2A8nfI0H1wI6A6lzdIXTRf23R44sh
 DMw==
X-Google-Smtp-Source: AGHT+IFF7uUarULV/hc4mtMXDTxptvZ6oZ0q0EkkSp7LCBf4V2uwjQ0zqtxm+eB7bpFb55UBcqlIJQ==
X-Received: by 2002:a05:6602:60c1:b0:7eb:8015:3ec6 with SMTP id
 ca18e2360f4ac-7f3a7481166mr323981039f.4.1719174645030; 
 Sun, 23 Jun 2024 13:30:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/14] test: Decode exceptions only with sandbox
Date: Sun, 23 Jun 2024 14:30:30 -0600
Message-Id: <20240623203033.1566505-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

When a real board fails we don't want to decode the exception. Reserve
that behaviour for sandbox. Also avoid raising a new exception on
failure - just re-raise the existing one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_sandbox.py |  2 +-
 test/py/u_boot_spawn.py           | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/test/py/u_boot_console_sandbox.py b/test/py/u_boot_console_sandbox.py
index 27c6db8d719..7bc44c78b8b 100644
--- a/test/py/u_boot_console_sandbox.py
+++ b/test/py/u_boot_console_sandbox.py
@@ -58,7 +58,7 @@ class ConsoleSandbox(ConsoleBase):
         if self.use_dtb:
             cmd += ['-d', self.config.dtb]
         cmd += self.sandbox_flags
-        return Spawn(cmd, cwd=self.config.source_dir)
+        return Spawn(cmd, cwd=self.config.source_dir, decode_signal=True)
 
     def restart_uboot_with_flags(self, flags, expect_reset=False, use_dtb=True):
         """Run U-Boot with the given command-line flags
diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 7c48d96210e..97e95e07c80 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -24,18 +24,20 @@ class Spawn:
         output: accumulated output from expect()
     """
 
-    def __init__(self, args, cwd=None):
+    def __init__(self, args, cwd=None, decode_signal=False):
         """Spawn (fork/exec) the sub-process.
 
         Args:
             args: array of processs arguments. argv[0] is the command to
               execute.
             cwd: the directory to run the process in, or None for no change.
+            decode_signal (bool): True to indicate the exception number when
+                something goes wrong
 
         Returns:
             Nothing.
         """
-
+        self.decode_signal = decode_signal
         self.waited = False
         self.exit_code = 0
         self.exit_info = ''
@@ -197,12 +199,12 @@ class Spawn:
                     # With sandbox, try to detect when U-Boot exits when it
                     # shouldn't and explain why. This is much more friendly than
                     # just dying with an I/O error
-                    if err.errno == 5:  # Input/output error
+                    if self.decode_signal and err.errno == 5:  # I/O error
                         alive, _, info = self.checkalive()
                         if alive:
                             raise err
                         raise ValueError('U-Boot exited with %s' % info)
-                    raise err
+                    raise
                 if self.logfile_read:
                     self.logfile_read.write(c)
                 self.buf += c
-- 
2.34.1

