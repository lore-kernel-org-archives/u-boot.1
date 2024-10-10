Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B7CEDDA9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2167C88F7B;
	Thu, 10 Oct 2024 03:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRNcxCeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009D788C78; Thu, 10 Oct 2024 03:51:57 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B433A88C78
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3a0cc384a85so2406845ab.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525114; x=1729129914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WK4MCoLaWRyhrmEbf9maMU12giJENt+6FZabhUK7u3M=;
 b=FRNcxCeE+toEyj2OlrH0h9wPwyp08pdCWnyAljEIeLovqElUhKUA2PcF3AZSuLY9b2
 wpBEl4C+2D65POt/rOwzLUkykD9KU2z5sX+eL6Q7bbM4uZ3O37YhVYjsICBzVVlFs2Ex
 lqZBBC5vWbJx/mYjdE/1d5+uoGk8PHWGRugrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525114; x=1729129914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WK4MCoLaWRyhrmEbf9maMU12giJENt+6FZabhUK7u3M=;
 b=Hv3ABTGOJ9OxyZW/ZTnLpRJtUhicaLbSCoasPMPAs9I9cgxH/DBcKx3DujP6mKEmD+
 cyJMkM9577EcUWzsvIvUpkEFukmqztgvsKrenNQCqJZo3F7MRhhq/cVnSLuF9qxUSkPq
 Io+kwAMl35EpH32Wrb9wzngkAv98P0VFLy201lriii9xsIQ8R3O6PcvHvO/oS3vg+E4U
 G/om840O2Z0IYXVjIBXuTnJMmdRWGA3CzogwGxUomoVy0ZNaCbXF+EH5NFyJPUxrSmaY
 8PXnLiMSyAnLfR9iT0Gs4WB8D24ClsFWvagvMj6gGjKdrwYK2UD+KPzncb7v0s+KNpWt
 8kFA==
X-Gm-Message-State: AOJu0YzdhRy+uqrLTawBBDC1AgsGEsWwrAMeqjBb3dWkH/+f+uz1W6be
 zIKf2UY56YqqBJ4DGsYMS3bpJ8qF/FaiREj3o+Taz5gECaqkLJ/uSh9hHShvnMNMF+h53SvGcwe
 FW3O2
X-Google-Smtp-Source: AGHT+IG8jFFZbhhXUzSNhHs7+/xeLNmSOeFXGV0dMt464b8iN0sE97JibMfqNKnnTzv8RPzDbPf1AQ==
X-Received: by 2002:a05:6e02:20e3:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a397d19c12mr44770575ab.24.1728525114095; 
 Wed, 09 Oct 2024 18:51:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 03/11] test: Allow connecting to a running board
Date: Wed,  9 Oct 2024 19:51:37 -0600
Message-Id: <20241010015145.1977999-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010015145.1977999-1-sjg@chromium.org>
References: <20241010015145.1977999-1-sjg@chromium.org>
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

Sometimes we know that the board is already running the right software,
so provide an option to allow running of tests directly, without first
resetting the board.

This saves time when re-running a test where only the Python code is
changing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Rename option to --use-running-system

 test/py/conftest.py                   |  3 +++
 test/py/u_boot_console_base.py        | 14 ++++++++++----
 test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 46a410cf268..7a52b966154 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -80,6 +80,8 @@ def pytest_addoption(parser):
     parser.addoption('--gdbserver', default=None,
         help='Run sandbox under gdbserver. The argument is the channel '+
         'over which gdbserver should communicate, e.g. localhost:1234')
+    parser.addoption('--use-running-system', default=False, action='store_true',
+        help="Assume that U-Boot is ready and don't wait for a prompt")
 
 def run_build(config, source_dir, build_dir, board_type, log):
     """run_build: Build U-Boot
@@ -254,6 +256,7 @@ def pytest_configure(config):
     ubconfig.board_type = board_type
     ubconfig.board_identity = board_identity
     ubconfig.gdbserver = gdbserver
+    ubconfig.use_running_system = config.getoption('use_running_system')
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
     ubconfig.connection_ok = True
 
diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 965832a4989..311e649d55b 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -441,11 +441,17 @@ class ConsoleBase(object):
             if not self.config.gdbserver:
                 self.p.timeout = TIMEOUT_MS
             self.p.logfile_read = self.logstream
-            if expect_reset:
-                loop_num = 2
+            if self.config.use_running_system:
+                # Send an empty command to set up the 'expect' logic. This has
+                # the side effect of ensuring that there was no partial command
+                # line entered
+                self.run_command(' ')
             else:
-                loop_num = 1
-            self.wait_for_boot_prompt(loop_num = loop_num)
+                if expect_reset:
+                    loop_num = 2
+                else:
+                    loop_num = 1
+                self.wait_for_boot_prompt(loop_num = loop_num)
             self.at_prompt = True
             self.at_prompt_logevt = self.logstream.logfile.cur_evt
         except Exception as ex:
diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 5f4916b7da2..8b253b4451d 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -59,15 +59,18 @@ class ConsoleExecAttach(ConsoleBase):
         args = [self.config.board_type, self.config.board_identity]
         s = Spawn(['u-boot-test-console'] + args)
 
-        try:
-            self.log.action('Resetting board')
-            cmd = ['u-boot-test-reset'] + args
-            runner = self.log.get_runner(cmd[0], sys.stdout)
-            runner.run(cmd)
-            runner.close()
-        except:
-            s.close()
-            raise
+        if self.config.use_running_system:
+            self.log.action('Connecting to board without reset')
+        else:
+            try:
+                self.log.action('Resetting board')
+                cmd = ['u-boot-test-reset'] + args
+                runner = self.log.get_runner(cmd[0], sys.stdout)
+                runner.run(cmd)
+                runner.close()
+            except:
+                s.close()
+                raise
 
         return s
 
-- 
2.34.1

