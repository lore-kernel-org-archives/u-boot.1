Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A97D1CA09
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAED88F68;
	Mon,  4 Nov 2024 23:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mu0nb9WM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9510388D29; Mon,  4 Nov 2024 23:46:10 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6024188F0C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a6bd37f424so9710655ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760366; x=1731365166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ml2eg8e33nIKQ5YzdCUeqQbOXCTyCgwZLNeiQvPOsqs=;
 b=Mu0nb9WMhdTZ/su1lyXkV6GFQdCpljw0Ip5xCkc4Wii1GhJ72qc9YIl0eYmYdNmb0b
 hfLbK9/lcWKB2+zNdSnMiur06OCAPs0V1lsnWJQw8SKIrVzXtRlGWySlZmbtt2fxWaqF
 bHSxniqCGvkG8aI1YygCYhvAtXU5rj2LZr998=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760366; x=1731365166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ml2eg8e33nIKQ5YzdCUeqQbOXCTyCgwZLNeiQvPOsqs=;
 b=IS9AbZY0hKZUzhDcvuQTppfHFoDkDWrV4k0bkd2IdTM1ZGZC4/pGcC80ec4mmEh7M5
 t3d1X6iuVLCkCngJuHxuAE+nxkqiZESUPJMOcQlYW+yBLZ7MNQoBc7JqQfjOb5Ix8WS5
 88b87wI/itTvS4PL6lG1n5ejfx0NyPyZxs1z/RkvWtTGHvTmm10aOhjTEqb22EdgtY6e
 A8XxDH4tCd1MMzKOFLR0FEEVS4XZDXreTmyPtdhsdLD4YMhAzeZwv6WJDaN62jPVzrnq
 y3Ir7mBWLufTGBxc4gNQ18Wb4jMGTJJXqY+byp8K6QhZXh2/3n1rhsPqOxboMrVcFNzW
 Jb5A==
X-Gm-Message-State: AOJu0Yy71qQ1EtQKETEbsvt7DshEq7KdenRyRVFbtC5xdcW6txRflmpG
 jDjMH/7FPl0Kih5CaURMObyFtdtBjshhtGTeT7wDYwm0ntSMJ4i7hf7wGBc1EF8pEUELk+y5tlA
 =
X-Google-Smtp-Source: AGHT+IE41ZrY146h1xwriFFEwn3AM2wMvdpVsXpvGl3+nbHs1e1MbasSvTSCNB34fPuTHNPcD+5FJQ==
X-Received: by 2002:a05:6e02:1d09:b0:3a6:c651:3dad with SMTP id
 e9e14a558f8ab-3a6c651422fmr59944825ab.11.1730760366112; 
 Mon, 04 Nov 2024 14:46:06 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v8 03/11] test: Allow connecting to a running board
Date: Mon,  4 Nov 2024 15:45:30 -0700
Message-ID: <20241104224550.677442-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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

(no changes since v7)

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
2.43.0

