Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92265D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E5A89471;
	Tue, 12 Nov 2024 15:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JIcHwouJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E7D18947E; Tue, 12 Nov 2024 15:13:39 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643188944C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a4e30bffe3so21125905ab.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420815; x=1732025615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Brng0DhSZqCyx5U0Rmem8ifHJzbqF8ZvkbVasrYAZ0g=;
 b=JIcHwouJPyOtGgpDQA0ThHHRaseEyMAsM0+2dkPLLiNSz8dXfrhPQSpUjPBn+bkvD+
 cEfEkmm5sY7aZGdMe+FiBI06uMZspMPgwnmK+dcfv7Npm9pXnqyvjSYXbRCiF2EuPAtO
 mmFI4bEOfg4J12IMoIpjdX4HbliNcFICq1FXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420815; x=1732025615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Brng0DhSZqCyx5U0Rmem8ifHJzbqF8ZvkbVasrYAZ0g=;
 b=b7Wg7XRleosOnjrR3LQCOZvvPT7XtPaL62UZsy1fZO/pTog6+MCore7EDMHVYnzYiv
 quHIL9CM4cajh5pn4wdvpQc5PJZVknQ3KG0AoT38WrzOkdv0WTWqcbQRIg+DRhC4MUCP
 HPybsw1d2TOzW9BrhWX6VdezrlzOCKdaFnL0TFY3VV0yGOd1xmLjoZ4EwiZqRhzkSnhF
 W9Fga61gDc9qGtkit9h6oPIHzjuoloLYwlH/iflAeeqfq4XphFEgw+DbbYDgwoi4Xh+o
 NV+u5vKFPW7eS+2e57dK6AleIZQCEK3OF1fgM0ECxnAhTMJVMs2ETcLzj12YZ0fYzdvB
 9/6w==
X-Gm-Message-State: AOJu0YyDEKQ+hLPwctbwVRFowHOINr6e7h/jLAi5Lu2q/rITWS0MePqX
 6Bg6ZHAEg5B2ul7A1OCms7+eL58myId4fQZCCf6Zpc6Fy4+TvHmxxMVtiePY+ico7p+MrMObwrQ
 =
X-Google-Smtp-Source: AGHT+IHG2z1mCjml+8IAWtcKqWr8CBsifvEFuV7yDIeVCs3mp81NGQT4FO+F8uxNVcCkriJ0+O4ZUQ==
X-Received: by 2002:a05:6e02:1f08:b0:3a4:eb9b:650 with SMTP id
 e9e14a558f8ab-3a6f1a230demr175493205ab.17.1731420815571; 
 Tue, 12 Nov 2024 06:13:35 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v9 03/12] test: Allow connecting to a running board
Date: Tue, 12 Nov 2024 07:13:17 -0700
Message-Id: <20241112141326.643128-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

Note that this feature is open to errors, since the user must know that
the board is in a fit state to execute tests. It is useful for repeated
iteration on a particular test, where it can save quite a bit of time.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v9:
- Update commit message to explain the risks

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

