Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB205C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2138B889F8;
	Thu, 29 Aug 2024 00:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWvm3LRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94663889A7; Thu, 29 Aug 2024 00:08:59 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B47D88744
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39e6a1e0079so6961485ab.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882934; x=1725487734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+H31XKUz/+EK1B2GCG0Zwccq4I6BpseEx5TJ2nBGWw=;
 b=cWvm3LRt13d2j9sSUPi3xqPkqWUdWfWJCrN9g4t5pYudv1U45+8BqrA7dLf8v0+eqT
 dysWXgqb77g4GjeL/hm8m+o6AXCgJrOtxTXYncXOQDTiqk78sZlvPq2/Il9sg/i1XO0D
 P7j1omd5hkThECQYOO18J4C6em63NQo4t7chc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882934; x=1725487734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+H31XKUz/+EK1B2GCG0Zwccq4I6BpseEx5TJ2nBGWw=;
 b=nDPMvVIPjUq+TqaBcPeQYRpEpJKKRzXg3N4C7F3b/MfnuTigeq00wvqJjXOsx6yc0W
 gP4qnz2XqjQT2PsH/Odsl3o2IlyKTWUoHwdBbAs9BHgtG6PTmOZr/I/Q9NwwUj6+Jt5C
 RG1dpS0ov/SUSCp+6MTrw/RLekhpOoSo8MaOcLWo5UPK/h7GKiog/O2N0kMq/XSRKlQE
 SoZSf/yIXGou9Qb86p1qsZ6484KEBnVZWFei9HNpDyd869J5FF2Ve/zy6LMbK9Y5MT41
 dxigzhd3YFGZxg7bFCritMrGxJOxhFWjUS0p19Ny3HenraJ9N8DoZHZht05iYltNyD3L
 x2Fg==
X-Gm-Message-State: AOJu0YwNnLKFgQDB9hZeS+Zv18sdAfc6pa1FHslikBfiycnIK0Luo7zV
 KxRk+ngeM+N/ujrpmP9rdBQiCvHZdGhhfnfdsOA5Hgd/Fn0RfY3FRLjM1nNffQROsOlT0fUEy2A
 =
X-Google-Smtp-Source: AGHT+IHDEITBrBzBqz+9kSyz8t7YrjD9rR8XCbBIxcJT1V+zUmTzNbTZRyzc+hetVRxip/rfHQ/PDw==
X-Received: by 2002:a05:6e02:178f:b0:39d:47cf:2c7f with SMTP id
 e9e14a558f8ab-39f3788c68bmr12184505ab.24.1724882934049; 
 Wed, 28 Aug 2024 15:08:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 05/20] test: Allow connecting to a running board
Date: Wed, 28 Aug 2024 16:08:31 -0600
Message-Id: <20240828220846.1205813-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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

