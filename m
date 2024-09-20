Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E89CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E0689362;
	Fri, 20 Sep 2024 08:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="myZWpZwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E678789325; Fri, 20 Sep 2024 08:03:12 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F1A89339
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so184121066b.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812182; x=1727416982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMqemo9yAz81CFX+6vs9ZIdl+j7POUx/2fudsivcxSo=;
 b=myZWpZwTRe3NgcRdZbqmIRwH8X5g/TYfVeRyhzbpGHlCnZPmsclnpXQx9CPJHnj0l8
 0Oknjqi7FONLRxCYMEg/KTbVMA8FeHKnWsOzKW5pTvLOVOd5Bf3HG4tgnd4BqJR58oh7
 yD2Eae5ToWOulU975uHzkB3BvHJ7ryN3sVQ14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812182; x=1727416982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMqemo9yAz81CFX+6vs9ZIdl+j7POUx/2fudsivcxSo=;
 b=XVj0wc78kzf8srapEStncpMWwLMF8uKsnZcahWefMuAnxeMNQI6VVLqtrZW04iIbuH
 RA7Gr0e+LitJFyLDr1L46lN5R2tUJb/A7QmGeXVqbUTbWkiJrVoK9MtD6fzGarLDIPGs
 nWPPYEFlc0c2jElatEIINDhJ6LtbnOEl/uyNsRrNTP4FQyiaonzRBpSQXaHYvVPYaad0
 sQmR+eoH0SduhY3SeV+OuFslUEhoCoxZORarVw0zoFiJoHZOSZrslAkmbQwi3XOtPELn
 bx+1LnvaYvJicrC18ohpkdwI0ISA7zB7hm0DhOThvTdWN2RkhznuGwYb9ioL6ny/A4AY
 MqSA==
X-Gm-Message-State: AOJu0YwLPyIg6rRHxXNHXcK338TBRs99PmpFkCMfrUD4Wlt2SWtvlxEj
 hygUiNeJ4WeosIcEZsLpgLqzjEdQFQtrm6+Zz7ZZFvYUq/A8cctszLk7j7k1eYLC618aZtlzxPr
 7dKONfGw=
X-Google-Smtp-Source: AGHT+IFHFhCq25BGikPp6AZhHFh8O4YYl2gbZ33tRuP9YdVd9yIE/P9OSSk/qfUzp6aJBOQTevE06w==
X-Received: by 2002:a17:907:a4b:b0:a86:aee7:9736 with SMTP id
 a640c23a62f3a-a90d59257d4mr107733466b.46.1726812182079; 
 Thu, 19 Sep 2024 23:03:02 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 04/19] test: Allow connecting to a running board
Date: Fri, 20 Sep 2024 08:01:39 +0200
Message-ID: <20240920060158.106612-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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
2.43.0

