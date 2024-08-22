Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BAEC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32FA388E6B;
	Thu, 22 Aug 2024 04:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="acq7QSix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BAF88C93; Thu, 22 Aug 2024 04:56:47 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC43688CB7
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39d46ae7863so1144415ab.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295403; x=1724900203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+H31XKUz/+EK1B2GCG0Zwccq4I6BpseEx5TJ2nBGWw=;
 b=acq7QSixAi6p7Tz4U9QqzXBfBdcfZaQEqmELLb5hSy+bLGBVx5db8U09h2ijVXX2bU
 emyNhUN+4+EPW6LVqUHrA86Yr++2NGtH4OP4ATjhFtqDJsmfpJd6XBQBwjnmKxEzNeZy
 tUX0447xRRlylock8iHglxu5TqAQ7nDxub/44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295403; x=1724900203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+H31XKUz/+EK1B2GCG0Zwccq4I6BpseEx5TJ2nBGWw=;
 b=Kz6GfJeti8VB9PqRy5Mht4+YLkuMrWOOo0Z4mOz6hUXh2RigaviyekFLuSOIxjRiLi
 W7e1H8iz7I6t8sxRxR04Nxr74epWrbmcbJOe2N2qi3Hkytbf+XmALIU1/fHDLUItXVo9
 +/E3QPcrAPihDlPlzNIGHcExkaDv1mPuaA1qKywI3Sc2gV+jXDidjZo8J2fbIaxmoOzK
 VRIF/QcJYdVWbgdZ0N0kN7yu8FAGT417D2qheI+pRAvvkRIfoCWk3A5wPmeImleFPJ2V
 sDFFWitI8x3D8++QSUgVQqPYaEidb6PwoRKXFRjE7zk4j6pE/q2jJvvYZFTEG/IZULfA
 uPZg==
X-Gm-Message-State: AOJu0YwqGxKAJ03BEQaYV1NeSq/WEmYQxOk9T0B3seU6Mtzk03WtpROA
 k+MQI4SGsyi4jsOEUdIK4jIeOZqDb5hjMiv+/YaVHzphU84RpxcIC2nbdE71aODITI1x+E4bdvs
 =
X-Google-Smtp-Source: AGHT+IFWA7bGYNYXpkfOkoTbGl9xuKe6AqRm4/DpQHs6mk3aFWM5LtC6lkjrTMZvgUXRA6yXD21YTg==
X-Received: by 2002:a05:6e02:b27:b0:39d:6377:7c02 with SMTP id
 e9e14a558f8ab-39d7284b059mr12722485ab.4.1724295403309; 
 Wed, 21 Aug 2024 19:56:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 05/19] test: Allow connecting to a running board
Date: Wed, 21 Aug 2024 20:56:17 -0600
Message-Id: <20240822025631.1838434-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/conftest.py                   |  3 +++
 test/py/u_boot_console_base.py        | 14 ++++++++++----
 test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index fc9dd3a83f8..ca66b9d9e61 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -79,6 +79,8 @@ def pytest_addoption(parser):
     parser.addoption('--gdbserver', default=None,
         help='Run sandbox under gdbserver. The argument is the channel '+
         'over which gdbserver should communicate, e.g. localhost:1234')
+    parser.addoption('--no-prompt-wait', default=False, action='store_true',
+        help="Assume that U-Boot is ready and don't wait for a prompt")
 
 def run_build(config, source_dir, build_dir, board_type, log):
     """run_build: Build U-Boot
@@ -238,6 +240,7 @@ def pytest_configure(config):
     ubconfig.board_type = board_type
     ubconfig.board_identity = board_identity
     ubconfig.gdbserver = gdbserver
+    ubconfig.no_prompt_wait = config.getoption('no_prompt_wait')
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
 
     env_vars = (
diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 9cc0af66356..8a9c4a576dc 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -439,11 +439,17 @@ class ConsoleBase(object):
             if not self.config.gdbserver:
                 self.p.timeout = TIMEOUT_MS
             self.p.logfile_read = self.logstream
-            if expect_reset:
-                loop_num = 2
+            if self.config.no_prompt_wait:
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
index 5f4916b7da2..42fc15197b9 100644
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
+        if self.config.no_prompt_wait:
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

