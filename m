Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAC8CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23AE88C91;
	Tue,  3 Sep 2024 10:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WhtLZZ3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0022588C87; Tue,  3 Sep 2024 10:38:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 014D788AB1
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42c5347b2f7so26759195e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352728; x=1725957528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNk71n5E6pjt2UwcXalyjEEUKv5jtsxHr6voRWPzPlU=;
 b=WhtLZZ3Omq5ncGFMqMEGNASBduqTHYvGK0vItnk6B3oCGfFOPbIGjRLvIXlz/9KzWM
 /IyGBAeKtIT7l6hnm4plJD7DMSfmWSPCl0tpShOTipwOzg3M08TtNJcuad2xpy1/evvv
 RSRQ1YRzOEX0D9Nw23jKzwg+vUbGLZjrnwoZ2rarVu0+SpyVCXPkoGy9r3spj8CDLJtt
 j+rrtPoSM7qPPSkuONv/A+FWNWBwjHsXBIsEgRgJoM0Zdg7rijMR3xFODipFrBo2ctWE
 h6lvOXiy6aFBEXIR1h/2QnC1kxwK2lqPQwGsu3MnXkf5IJRk1YqZIv2gfG4g5gZXrMSs
 1oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352728; x=1725957528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNk71n5E6pjt2UwcXalyjEEUKv5jtsxHr6voRWPzPlU=;
 b=Je2JxwCCJbEuFdJjVQDRs7AQyO0pf6wBgjQXTm8W/Iq+/lwXizQUv3aG3a60kOUrh0
 3SDDDmv2bXMf3/H/XJ4aSGjyBhGzqKYckjA9hDoqn5mHkJhhQUgp+RW+R1xBwTE5BNvK
 bZWlUb9+4He5pL5UssJEhOrkw+KPbPIsW+lTQ0yLBl6480AatmdVt7uFKEzjRsdjZ1OX
 fB+yogp22bsyiWpcR1gl1LyHP+l91EKk8rA6Z/JhObz1NAXj8y+Cm5ybPx5g8yl5k3Oh
 E0GWb3tip8qgxXj69lNlixd9/cQp08q0s7GYkWmJATN8IfOrSAUvCFGWUf9dtqgaTJFM
 gkDA==
X-Gm-Message-State: AOJu0Yw23rbSjF1MkFgTHZ1wZ180znAx7kYRaYBfUhrmBO5Bn1OLNGty
 0KDgEPVNbLTOzNb4hxYr19aDOw8YTfjlJZ7o0GaPBXodvDBk+TUqajWdYmfIXSSHfpz7ROBEjCp
 yXoYrOg==
X-Google-Smtp-Source: AGHT+IF6lg5FIfbjKFZuUivZ6am0Ll7gO5BVK8b62jiLE9YmTP0cHJjdttasJsZCK8MnDUgDRMZgbw==
X-Received: by 2002:a05:600c:1c83:b0:426:6ed5:d682 with SMTP id
 5b1f17b1804b1-42bb01b4419mr115014325e9.12.1725352727630; 
 Tue, 03 Sep 2024 01:38:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 02/16] buildman/toolchain.py: do not set CROSS_COMPILE for
 sandbox
Date: Tue,  3 Sep 2024 10:37:59 +0200
Message-Id: <f4defe07f87f6c9761b401d435da03460b3b0947.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

When building for sandbox, self.cross is empty.

In MakeEnvironment(), CROSS_COMPILE is defined to be self.cross (with
or without a full path), optionally prefixed by the toolchain wrapper
defined in ~/.buildman. This is fine when self.cross is not empty, but
it doesn't make sense when it is:
- Either there is no wrapper and we end up with an empty CROSS_COMPILE
which is the same as not defining it (the host compiler will be used),
- Or there is a wrapper and CROSS_COMPILE will contain only the wrapper
which obviously is not a valid compiler, hence an error.

Test case:

 $ sudo apt install ccache
 $ grep -q toolchain-wrapper ~/.buildman || \
     printf "[toolchain-wrapper]\nwrapper = ccache\n" >>~/.buildman
 $ make mrproper
 $ ./tools/buildman/buildman sandbox_noinst
 $ ./tools/buildman/buildman sandbox_noinst
 Building current source for 1 boards (1 thread, 24 jobs per thread)
    sandbox:  +   sandbox_noinst
 +arch/sandbox/lib/reloc_sandbox_efi.c:10:15: error: operator '==' has no left operand
 +   10 | #if HOST_ARCH == HOST_ARCH_X86_64
 +      |               ^~
[...]

The GetEnvArgs function is modified too, since the VAR_CROSS_COMPILE
case has the same issue.

In tools/buildman/test.py, testGetEnvArgs is extended and
testMakeEnvironment is added. They check the 'arm' and 'sandbox'
toolchains, with and without a wrapper.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 tools/buildman/test.py      | 46 +++++++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py |  6 +++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index bfad3093030..bda6596bde8 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -36,6 +36,16 @@ main: /usr/sbin
 x86: i386 x86_64
 '''
 
+settings_data_wrapper = '''
+# Buildman settings file
+
+[toolchain]
+main: /usr/sbin
+
+[toolchain-wrapper]
+wrapper = ccache
+'''
+
 migration = '''===================== WARNING ======================
 This board does not use CONFIG_DM. CONFIG_DM will be
 compulsory starting with the v2020.01 release.
@@ -605,6 +615,9 @@ class TestBuild(unittest.TestCase):
                          tc.GetEnvArgs(toolchain.VAR_ARCH))
         self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_MAKE_ARGS))
 
+        tc = self.toolchains.Select('sandbox')
+        self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
         self.toolchains.Add('/path/to/x86_64-linux-gcc', test=False)
         tc = self.toolchains.Select('x86')
         self.assertEqual('/path/to',
@@ -613,6 +626,39 @@ class TestBuild(unittest.TestCase):
         self.assertEqual('HOSTCC=clang CC=clang',
                          tc.GetEnvArgs(toolchain.VAR_MAKE_ARGS))
 
+        # Test config with ccache wrapper
+        bsettings.setup(None)
+        bsettings.add_file(settings_data_wrapper)
+
+        tc = self.toolchains.Select('arm')
+        self.assertEqual('ccache arm-linux-',
+                         tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
+        tc = self.toolchains.Select('sandbox')
+        self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
+    def testMakeEnvironment(self):
+        """Test the MakeEnvironment function"""
+        tc = self.toolchains.Select('arm')
+        env = tc.MakeEnvironment(False)
+        self.assertEqual(env[b'CROSS_COMPILE'], b'arm-linux-')
+
+        tc = self.toolchains.Select('sandbox')
+        env = tc.MakeEnvironment(False)
+        self.assertTrue(b'CROSS_COMPILE' not in env)
+
+        # Test config with ccache wrapper
+        bsettings.setup(None)
+        bsettings.add_file(settings_data_wrapper)
+
+        tc = self.toolchains.Select('arm')
+        env = tc.MakeEnvironment(False)
+        self.assertEqual(env[b'CROSS_COMPILE'], b'ccache arm-linux-')
+
+        tc = self.toolchains.Select('sandbox')
+        env = tc.MakeEnvironment(False)
+        self.assertTrue(b'CROSS_COMPILE' not in env)
+
     def testPrepareOutputSpace(self):
         def _Touch(fname):
             tools.write_file(os.path.join(base_dir, fname), b'')
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 324ad0e0821..cbd8ce03d30 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -159,6 +159,8 @@ class Toolchain:
         if which == VAR_CROSS_COMPILE:
             wrapper = self.GetWrapper()
             base = '' if self.arch == 'sandbox' else self.path
+            if (base == '' and self.cross == ''):
+                return ''
             return wrapper + os.path.join(base, self.cross)
         elif which == VAR_PATH:
             return self.path
@@ -201,10 +203,10 @@ class Toolchain:
         if self.override_toolchain:
             # We'll use MakeArgs() to provide this
             pass
-        elif full_path:
+        elif full_path and self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(
                 wrapper + os.path.join(self.path, self.cross))
-        else:
+        elif self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
             env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
 
-- 
2.40.1

