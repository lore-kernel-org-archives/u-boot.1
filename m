Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D8EC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95820885F7;
	Fri, 21 Jun 2024 21:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BFTGIBuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0863388614; Fri, 21 Jun 2024 21:52:33 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE80E885F1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-7eb6aedcabcso90279339f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999549; x=1719604349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2B5ugf5xpRykR6qvk08f+SXyw2XjCQOs0cCM/6oconQ=;
 b=BFTGIBuWlEsAG6Bngq30qq2T/PhBxS3voj20CuNTFZImxQQMpAREBKC+u4rF8vdG21
 jLRpZ+k+ZeLqkV9Wuv+n3t2amCnBMwQacmDvVBP/z1qk7SMeQY3k5wptZPnb4GFXyAEe
 HDydjQJLWMIV6x3WrMIr+SLXu7G3EW+CY7j74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999549; x=1719604349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2B5ugf5xpRykR6qvk08f+SXyw2XjCQOs0cCM/6oconQ=;
 b=I6ItFXtI3DZePQJVoU0HNBKEuaA/APcEvDlIxQNMbGx6mtvnImvqWqfEj6dKd5/gpZ
 hON/Qrik+6SJzp3ig3Cuq3m+wmNTO4taszgglHtSmLdV942br0TfE3VDGlaKtUWiFHGq
 7HQchwRira+BPVY8GU3teM4StcgnkN1Lax9tpBu1CUiJVwi2bSKydf9jjB62zUzqUzQI
 HYhqppwDpshiVR0qL5uv1iwyYpx8k7o2uMdXKBFccJaCLHS38SJMBGDNS7VjdzWhPAX6
 X4l05ymGRz88DnmUSamHYD/jdmOwiM1Zs+DhIlB2MFkOH38uhd6WoOO+zcCajRSBYlOr
 Hc3A==
X-Gm-Message-State: AOJu0Yxr8Fr+t3CR00C7ZeUn9NSxUjeTm226KIj3nJGfeRNhgb4vVChs
 tXVkzwaZzgzgzoaoBN2mLnK61p5ECvU4vCEpwSGePFMBMnzilDcLZ2pVXZtLF4wKNxwmw5jSvWH
 nHH2Q
X-Google-Smtp-Source: AGHT+IETdFt8BnECMPNZfgQeoov8cwsqrH1oUUHNMRIgEzK/TasfxpPZy+Rvdn1NO+SpeVt+M5kpyA==
X-Received: by 2002:a05:6602:14cb:b0:7e1:e022:9e46 with SMTP id
 ca18e2360f4ac-7f13ee9635cmr934703239f.21.1718999549334; 
 Fri, 21 Jun 2024 12:52:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 25/43] test: Allow connecting to a running board
Date: Fri, 21 Jun 2024 13:51:46 -0600
Message-Id: <20240621195204.2675252-26-sjg@chromium.org>
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
index e4f86f6af5b..a61eec31148 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -413,11 +413,17 @@ class ConsoleBase(object):
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

