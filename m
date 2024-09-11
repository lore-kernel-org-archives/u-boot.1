Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29DDEE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F7389241;
	Wed, 11 Sep 2024 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jhVxBhXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871038915D; Wed, 11 Sep 2024 11:58:50 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A311891ED
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so16249235e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048728; x=1726653528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teYIAqjwDVz3xpHp99O/xsLua/5vGoVOcC/xnmwefdU=;
 b=jhVxBhXE+rXXcbQDVeNrrWG03Y+ZdzrMMq/SwJnvqoNrHy/XSvaN5IqhrMH45FqMIW
 Z2q43fMHhC8fZiaHYoqlHnb7xd9o4FbONQ8LD7wSg1s+YS2ReAp5u0qxoU1DkdYfpQ+3
 gN000F1J0pBJpibGGkbWb1s+nqsx7kG/mYD77zsoBsUPwcvO6oo02UKYe7Ew/w1PPocW
 +LBSdHuhABPd4hUAPplcLPCYfBuzmfTLc0lJvTx6I9jIIKfLOJ77FUHzbZ/abZn5lPgF
 j4LNFt8lIQP3T4ivOSq04amn2AfN0quxdDUWjyh+SaSUFxwTorODIYUnpyVGUiy7LRe0
 CWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048728; x=1726653528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teYIAqjwDVz3xpHp99O/xsLua/5vGoVOcC/xnmwefdU=;
 b=nKDchZjb/Qu2ru2Dxtw6lLOfJjkJGef/2tT0pzkAfLduMVmTY1txr1VAMMxqCMibI1
 +69LlssDcCPXpJRmmtaw76ywI3t1ZjKfsSychUsy2Tb8IYy3LzWcqnQURZ7c/nLfU2xr
 s73KBpbXhmQDcIbiHKjeBnKxSyYWTH4DQlysqHZ+KqScHizsewgZeAaWZZHZfSK9zKUW
 ii+ris8o+E2pU9ul27qKtCIn3Vqi0NfdgyPjR18SFKGr7psUmQbaJHP4PsN+FU+aAwMu
 G4p0J8UrKr2JRhF5IJehNT1j/H2dP1qSlU0HyPcmVp8zBcw+PJNRfWqTZr51FIeh5rEa
 59Iw==
X-Gm-Message-State: AOJu0Yww8viFVCfnu+7rhf1B34QKuEws/R/i/csvqCKoeHwUgeVrcOjk
 kQRlW/GUNMAsmf+odyXkD/5tXQV2/v2F/i5acu3yKAs/jnb11lD7uxYeMKNpnuTE8KshA3AE83O
 G+wJo3Q==
X-Google-Smtp-Source: AGHT+IGUgJR4VWDqzd/en46R9XmwlQ43mXWPOCokwtXAJD21W5/NUEQalArBkqVy/WX1JV+kc4Peag==
X-Received: by 2002:a05:600c:5493:b0:42c:bf0b:c489 with SMTP id
 5b1f17b1804b1-42ccd32eb20mr21251095e9.18.1726048727480; 
 Wed, 11 Sep 2024 02:58:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v4 01/15] buildman/toolchain.py: do not set CROSS_COMPILE for
 sandbox
Date: Wed, 11 Sep 2024 11:58:14 +0200
Message-Id: <721993374cd63a2cddced7aff045fd0f23d9ecca.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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
index 5eed013d51c..46aa2a17916 100644
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
@@ -606,6 +616,9 @@ class TestBuild(unittest.TestCase):
                          tc.GetEnvArgs(toolchain.VAR_ARCH))
         self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_MAKE_ARGS))
 
+        tc = self.toolchains.Select('sandbox')
+        self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
         self.toolchains.Add('/path/to/x86_64-linux-gcc', test=False)
         tc = self.toolchains.Select('x86')
         self.assertEqual('/path/to',
@@ -614,6 +627,39 @@ class TestBuild(unittest.TestCase):
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
index 6ca79c2c0f9..a7d7883b851 100644
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
@@ -208,10 +210,10 @@ class Toolchain:
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
 
             # Detect a Python virtualenv and avoid defeating it
-- 
2.40.1

