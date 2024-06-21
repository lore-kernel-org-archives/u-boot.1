Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97E5C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097F98862D;
	Fri, 21 Jun 2024 21:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NmvHkdH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26E888617; Fri, 21 Jun 2024 21:52:33 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FC1885FE
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7ebde93bf79so92514739f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999550; x=1719604350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3ifV3AkqrSdmnwOJI4BSwUd2tvrU4e53OcYI7a17Hg=;
 b=NmvHkdH+q6d5iGBmtGHyAG0B8EhqmSAA/Nm3Jje4kdlbSe8V1US//CtHfw4SEAGI7K
 JLoCY31dNPZuy2yIOWzUfy0Lxdkg/RSLmh5RfebCDa8fOE8FN9SUs9YbSfxT0qR+/Z8i
 pGhJdZy5FO7W0BHBocSPy1fIjDJmtRQZAe+uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999550; x=1719604350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3ifV3AkqrSdmnwOJI4BSwUd2tvrU4e53OcYI7a17Hg=;
 b=eLIg5NqdZ0W4sxErXCZ4CHPVAGKNVAFaMODx5KNzPtEUI1nU4xxvJXCbboEzgiwHFX
 6N70yWipTwFwVqSXkwrP+CeGnC9Y8dwKHJ0hdJU7EDtC+C71vNRqLxaocE6hfV2knVx4
 1CnM8gcghrlIsBXPfLGvyoPcNi1YOU6kvzW/p/mUjotvEmTXk3ehacwUCfGjW7/UMumm
 MNtEWOHi1yhxkqdrPTwa+KaCG36dJZ1qKWbNmcuj7TsmGsVh/3Bat4NZrfhJhVSLxsFc
 z7/uJw7ZupvqgQAYlbP0QizSzv8z0gMtHEgE2YKmm/DtPspxwZrrZVd69IHNJBeNL4mA
 jg/Q==
X-Gm-Message-State: AOJu0YzvG3qSiRmLHltd9QcU25cHhBoPp+AQB8/2mH7IWb6ctDcaOVS7
 NM6OS+nnKg5Nu9q+To2npzJfPXPGaRnfcXQDn717TtLttsfcUtC+E8FVMcgL/EUZAz9nl7EK7di
 WMA==
X-Google-Smtp-Source: AGHT+IE7e32vS6BFqH2RoNidpq8LU0gfINhmoRP2r4Mp8e2YIW3ZfTxMgn3O0zj7YgdQJYI6LiGCWw==
X-Received: by 2002:a05:6602:6d06:b0:7eb:8d08:e9df with SMTP id
 ca18e2360f4ac-7f13eea3198mr1161958739f.19.1718999550211; 
 Fri, 21 Jun 2024 12:52:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/43] test: Decode exceptions only with sandbox
Date: Fri, 21 Jun 2024 13:51:47 -0600
Message-Id: <20240621195204.2675252-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

