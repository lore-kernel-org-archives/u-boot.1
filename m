Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA92C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F22805E2;
	Mon,  3 Feb 2025 17:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/ngycg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E259805DA; Mon,  3 Feb 2025 17:27:32 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8718801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8521df70be6so17994939f.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738600047; x=1739204847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uf7THv/NNwpmBuWU9fxI2cM3aNcm/9TSo5vX2GyuZrU=;
 b=m/ngycg30bqxH+phIVg/2NMbLvqDHelxQsDePpnunyWyMPYeXVjuSek+qYiGuyjDct
 nsBVsRfhya63R3E326EPIWfuFY3foHbVoLaTAnc/krAdKRSqGA1rM8o6V1/+yh2K9j9l
 Rr/++19BFrNHD2juqrzkzq4A7EPY4gZ22o6P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600047; x=1739204847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uf7THv/NNwpmBuWU9fxI2cM3aNcm/9TSo5vX2GyuZrU=;
 b=te74l0IJCou94WjxqlAgPc/QYuExW+X3u/P8FSQmsc4Hr/MrRb2M7cXZowMmQdpDQA
 AqW/9pIK/xmqqqk9urK2SibrOp14nMwbiUO1DGzzMxft94E+5GWi+KbewBW5s9DIfAfi
 xcvb4ZIZDeCcgvg2EGTu0yTWpmfg40nmIeb2wWRARu+hES77EgsmnRVa5Qb4LidOmwsa
 P8aEYXAJFos4G7/uL91uwqZwHnouFrBV6UDGOQjmIeGRuL4RqUd6/cqgGA+LQZAc2kIs
 ZVYgJ3PeSkHITwfddQrZJwITf8Yh2m6bXA1RcbnAPopXBvUJkk5Eon7KUJ5gUyR2Ipya
 cSIQ==
X-Gm-Message-State: AOJu0YyO49vQ/HQqEb2KAec0pQU2G6hr+wLx5CTu4LOVvIsLjaAov1Mr
 23p5g+MKvvn9a7b9sgY0JFQuqpQJR2uYYjJsR5YKPbTi6LcODZ4B5AuHzsx4tK8oW8YUqhZRSa8
 =
X-Gm-Gg: ASbGncseb5KDcieikiL871fiS1FRDZOviZkcshDYExLTsUFkr6NU1QJEtoEMREueuAX
 wn1x5gU0f9VarnEmIKhTNb5mKR8gVh3ZjiMGoUCUGleVovbOokg+fCTZN9VvAeF7CEczNf6+1Wb
 zgNkgT2Fm1cX6G0GaQdCXec9bV99YaRa0riITEHIGvIj2aVTac6dSc0nHQurLtVhC3/zdSEmLyk
 WHtnKI5nKHPxcsO/i1kI340rvzF2IRo6JmYHw3L7eard7uxDNmnRy1PiMuRdoUHUDIKhxh+LS9/
 jpGTwov006il8GBD/L7BbWwB2NOUVHIwlAMJ8R+6mEj97ifHPdqS
X-Google-Smtp-Source: AGHT+IHcJ5pSKEZFyLIp7tGEw7P8ACBoDOMXCXY4o8oVVTmuHKvPBjvoIJamIbGQxzmflUghk66nQA==
X-Received: by 2002:a05:6e02:1707:b0:3cf:b39c:58ea with SMTP id
 e9e14a558f8ab-3cffe3bd76bmr196699515ab.10.1738600045630; 
 Mon, 03 Feb 2025 08:27:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d01da7e688sm15935735ab.33.2025.02.03.08.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:27:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] u_boot_pylib: Fix pylint warnings in command
Date: Mon,  3 Feb 2025 09:26:44 -0700
Message-ID: <20250203162704.627469-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203162704.627469-1-sjg@chromium.org>
References: <20250203162704.627469-1-sjg@chromium.org>
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

This file has a lot of warnings. Before adding any more features, fix
those which are straightforward to resolve.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/command.py | 107 +++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 27 deletions(-)

diff --git a/tools/u_boot_pylib/command.py b/tools/u_boot_pylib/command.py
index 4a9916bd814..a98dcedd322 100644
--- a/tools/u_boot_pylib/command.py
+++ b/tools/u_boot_pylib/command.py
@@ -1,8 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2011 The Chromium OS Authors.
-#
+"""
+Shell command ease-ups for Python
 
-import os
+Copyright (c) 2011 The Chromium OS Authors.
+"""
+
+import subprocess
 
 from u_boot_pylib import cros_subprocess
 
@@ -26,16 +29,16 @@ class CommandExc(Exception):
         self.result = result
 
 
-"""Shell command ease-ups for Python."""
-
 class CommandResult:
     """A class which captures the result of executing a command.
 
     Members:
-        stdout: stdout obtained from command, as a string
-        stderr: stderr obtained from command, as a string
-        return_code: Return code from command
-        exception: Exception received, or None if all ok
+        stdout (bytes): stdout obtained from command, as a string
+        stderr (bytes): stderr obtained from command, as a string
+        combined (bytes): stdout and stderr interleaved
+        return_code (int): Return code from command
+        exception (Exception): Exception received, or None if all ok
+        output (str or None): Returns output as a single line if requested
     """
     def __init__(self, stdout='', stderr='', combined='', return_code=0,
                  exception=None):
@@ -44,34 +47,46 @@ class CommandResult:
         self.combined = combined
         self.return_code = return_code
         self.exception = exception
+        self.output = None
 
     def to_output(self, binary):
+        """Converts binary output to its final form
+
+        Args:
+            binary (bool): True to report binary output, False to use strings
+        Returns:
+            self
+        """
         if not binary:
             self.stdout = self.stdout.decode('utf-8')
             self.stderr = self.stderr.decode('utf-8')
             self.combined = self.combined.decode('utf-8')
         return self
 
-def run_pipe(pipe_list, infile=None, outfile=None,
-            capture=False, capture_stderr=False, oneline=False,
-            raise_on_error=True, cwd=None, binary=False,
-            output_func=None, **kwargs):
+
+def run_pipe(pipe_list, infile=None, outfile=None, capture=False,
+             capture_stderr=False, oneline=False, raise_on_error=True, cwd=None,
+             binary=False, output_func=None, **kwargs):
     """
     Perform a command pipeline, with optional input/output filenames.
 
     Args:
-        pipe_list: List of command lines to execute. Each command line is
-            piped into the next, and is itself a list of strings. For
+        pipe_list (list of list): List of command lines to execute. Each command
+            line is piped into the next, and is itself a list of strings. For
             example [ ['ls', '.git'] ['wc'] ] will pipe the output of
             'ls .git' into 'wc'.
-        infile: File to provide stdin to the pipeline
-        outfile: File to store stdout
-        capture: True to capture output
-        capture_stderr: True to capture stderr
-        oneline: True to strip newline chars from output
-        output_func: Output function to call with each output fragment
-            (if it returns True the function terminates)
-        kwargs: Additional keyword arguments to cros_subprocess.Popen()
+        infile (str): File to provide stdin to the pipeline
+        outfile (str): File to store stdout
+        capture (bool): True to capture output
+        capture_stderr (bool): True to capture stderr
+        oneline (bool): True to strip newline chars from output
+        raise_on_error (bool): True to raise on an error, False to return it in
+            the CommandResult
+        cwd (str or None): Directory to run the command in
+        binary (bool): True to report binary output, False to use strings
+        output_func (function): Output function to call with each output
+            fragment (if it returns True the function terminates)
+        **kwargs: Additional keyword arguments to cros_subprocess.Popen()
     Returns:
         CommandResult object
     Raises:
@@ -89,7 +104,7 @@ def run_pipe(pipe_list, infile=None, outfile=None,
     result = CommandResult(b'', b'', b'')
     last_pipe = None
     pipeline = list(pipe_list)
-    user_pipestr =  '|'.join([' '.join(pipe) for pipe in pipe_list])
+    user_pipestr = '|'.join([' '.join(pipe) for pipe in pipe_list])
     kwargs['stdout'] = None
     kwargs['stderr'] = None
     while pipeline:
@@ -125,28 +140,66 @@ def run_pipe(pipe_list, infile=None, outfile=None,
         raise CommandExc(f"Error running '{user_pipestr}'", result)
     return result.to_output(binary)
 
+
 def output(*cmd, **kwargs):
+    """Run a command and return its output
+
+    Args:
+        *cmd (list of str): Command to run
+        **kwargs (dict of args): Extra arguments to pass in
+
+    Returns:
+        str: command output
+    """
     kwargs['raise_on_error'] = kwargs.get('raise_on_error', True)
     return run_pipe([cmd], capture=True, **kwargs).stdout
 
+
 def output_one_line(*cmd, **kwargs):
     """Run a command and output it as a single-line string
 
-    The command us expected to produce a single line of output
+    The command is expected to produce a single line of output
+
+    Args:
+        *cmd (list of str): Command to run
+        **kwargs (dict of args): Extra arguments to pass in
 
     Returns:
-        String containing output of command
+        str: output of command with all newlines removed
     """
     raise_on_error = kwargs.pop('raise_on_error', True)
     result = run_pipe([cmd], capture=True, oneline=True,
-                     raise_on_error=raise_on_error, **kwargs).stdout.strip()
+                      raise_on_error=raise_on_error, **kwargs).stdout.strip()
     return result
 
+
 def run(*cmd, **kwargs):
+    """Run a command
+
+    Note that you must add 'capture' to kwargs to obtain non-empty output
+
+    Args:
+        *cmd (list of str): Command to run
+        **kwargs (dict of args): Extra arguments to pass in
+
+    Returns:
+        str: output of command
+    """
     return run_pipe([cmd], **kwargs).stdout
 
+
 def run_list(cmd):
+    """Run a command and return its output
+
+    Args:
+        cmd (list of str): Command to run
+
+    Returns:
+        str: output of command
+    """
     return run_pipe([cmd], capture=True).stdout
 
+
 def stop_all():
+    """Stop all subprocesses initiated with cros_subprocess"""
     cros_subprocess.stay_alive = False
-- 
2.43.0

