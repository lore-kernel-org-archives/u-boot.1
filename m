Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFCEC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E93B887B8;
	Tue, 11 Jun 2024 22:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RzE6PkT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D98887E8; Tue, 11 Jun 2024 22:02:38 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E31C8859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-375932c94f0so7404325ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136155; x=1718740955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNUvBXjivKarqdxeSd0NQYDCsDvN7Yplcy0JmaYqxJY=;
 b=RzE6PkT6mHWhZ3xHO6rssNi9Tfztm9fojw6yYZY45T//9yQpa5kbD2u/kkILVvCGtD
 95QHnRR6a8snA5WwIQ/cI54nLF6kiHGURo+Q8goTde/w1Auz5iNaZTiaH6FxP7VQB9+Q
 b4BLncoz2jHuukP6pD4q2ftVlLoD8NhAFvdzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136155; x=1718740955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNUvBXjivKarqdxeSd0NQYDCsDvN7Yplcy0JmaYqxJY=;
 b=Xkj9t5g5ng3UryHOB6iQ9KVUamdYxn3j2iuUGCdYTeqr9VyWP6MJ30cxkN0Ccpvqci
 hAlIuOT6Wx0ZPhYJUuCqkubZFH2ETNzBKxJ0w6R3nQIhQ8KuyZoxDLnR6WBsHApk3y5K
 0umMX/hDjBvTfCl0ztUZHQRWRLvEFWg3CK16dm5Fi8Tdxzh53oiQ8pXwRNlSTLyhihNf
 TdvCRAhKUomBatzh+2V1orD0h6l/sUvOO6FHgtmn4El9R1+y9YV5JTAJTQYNzgV0b7f0
 l3JiN466dQYGCdeJfJaH9SDTDoV2W+1uW76XvZP43xTmOXZEpqlbXfVYH10XapL5RsHv
 pZcw==
X-Gm-Message-State: AOJu0YziNgxuvYzr4/oU1LXVU1z0CPmwzZPq6GDH+Furg3hvmAbKArcE
 kKn69PyZdqJONsEI1/hixEfCtv7dQJEaY8z34R+mN6eIXus8Ahtgb2UKB4uPgwLmJZqpRtmgmNS
 y2g==
X-Google-Smtp-Source: AGHT+IGvFpe3e8fGDZR/XPibtAzSGpzo+L4VZnT6BE7Nw6mgxUmAXXhALyCXKBQU/oyYGRd+K78Wzw==
X-Received: by 2002:a05:6e02:188d:b0:375:a180:b3d1 with SMTP id
 e9e14a558f8ab-375a180b7ccmr97126915ab.20.1718136155044; 
 Tue, 11 Jun 2024 13:02:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 26/42] test: Decode exceptions only with sandbox
Date: Tue, 11 Jun 2024 14:01:40 -0600
Message-Id: <20240611200156.2245525-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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
index 7421da49aa9..81a09a9d639 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -25,18 +25,20 @@ class Spawn:
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
@@ -199,12 +201,12 @@ class Spawn:
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

