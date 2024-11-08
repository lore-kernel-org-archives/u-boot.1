Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2500D5C0EF
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087B289102;
	Fri,  8 Nov 2024 16:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B0cf/+g7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447C589251; Fri,  8 Nov 2024 16:24:10 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8AE88DF1
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83abcfb9f39so75192339f.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079446; x=1731684246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvU4vNiBSIfgpbFXVL/C4OyDBi4H8giThtdtgQ7sy/o=;
 b=B0cf/+g7IxqwZzXcqkR6zXOyTt1u4kd4Sqk/KBL0MP/8U8SkxqzO/Y8JEXkQd3/9b8
 Vf4yHsBa/YfoU9uDLfL395mTO70YsoOJlAWX/jQJBdcyA1N1TcDKQnWNuJDO0H1hVxO4
 CBKxJ3BeHzlMj00c/KWdmBQjgS1c6htZRLqJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079446; x=1731684246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvU4vNiBSIfgpbFXVL/C4OyDBi4H8giThtdtgQ7sy/o=;
 b=i2tKkHXu7ptLe03XISlfJi7f+gIrfHP8xm1KHjOH/x0bpjmn5l+Gky3bgGmbOt9sO9
 8/yB3cD9d6bglmbwj7CLGDhV7gH5Z3abCtnbVG2b3d6b3Qz5m+j5qsvs6jGjAV39z+Ia
 a9tRQtbZjqyJoM+HW0HxSJxnuu241QzMwmTKaMqrhflZ50zj/AIT0c5WbTF0OQqSvK8C
 seBN68ocL77cRHONn+D7tcvOTOEDOEtrVwo8vlKYJdXayW6g7FbtOJff1IQQGx3SVR7L
 /L1LiGqU3Sg0Qsi6xulRmFgA4r4Jf7ZrtfL7zT8uXd2nK8xIagU3cDRYT2OfnXffcsbL
 uE5g==
X-Gm-Message-State: AOJu0YwH2mUGdzDATH5ajKo5+vpu8Ep4+baupPruFS9R3S6PTE3JuGli
 j7VVyKcienuA7jPd0YwrdQTN0hoGizZSHo/mDz7NO8zQbkdU1va7YDBO6LnUyUj7syRPVFtUIK8
 =
X-Google-Smtp-Source: AGHT+IG87lbkGL8+oTYgBG4lpv89cGaxb2CWVvnaz1O4THmHZvuRn1USVDDNB/PfhNWAITX9z0UMNA==
X-Received: by 2002:a05:6602:4f54:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-83e00ab9631mr319168939f.4.1731079446011; 
 Fri, 08 Nov 2024 07:24:06 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:24:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 7/9] buildman: Support a tilde to represent the home directory
Date: Fri,  8 Nov 2024 08:23:48 -0700
Message-Id: <20241108152350.3686274-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

It is convenient to use ~ to represent the home directory in the
settings file. Add support for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/buildman.rst |  6 +++++
 tools/buildman/test.py      | 50 +++++++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py | 28 +++++++++++++--------
 3 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 73a13134a4d..924564b5700 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -933,12 +933,18 @@ a set of (tag, value) pairs.
     For example powerpc-linux-gcc will be noted as a toolchain for 'powerpc'
     and CROSS_COMPILE will be set to powerpc-linux- when using it.
 
+    The tilde character ``~`` is supported in paths, to represent the home
+    directory.
+
 '[toolchain-prefix]' section
     This can be used to provide the full toolchain-prefix for one or more
     architectures. The full CROSS_COMPILE prefix must be provided. These
     typically have a higher priority than matches in the '[toolchain]', due to
     this prefix.
 
+    The tilde character ``~`` is supported in paths, to represent the home
+    directory.
+
 '[toolchain-alias]' section
     This converts toolchain architecture names to U-Boot names. For example,
     if an x86 toolchains is called i386-linux-gcc it will not normally be
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 15801f6097f..385a34e5254 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -46,6 +46,16 @@ main: /usr/sbin
 wrapper = ccache
 '''
 
+settings_data_homedir = '''
+# Buildman settings file
+
+[toolchain]
+main = ~/mypath
+
+[toolchain-prefix]
+x86 = ~/mypath-x86-
+'''
+
 migration = '''===================== WARNING ======================
 This board does not use CONFIG_DM. CONFIG_DM will be
 compulsory starting with the v2020.01 release.
@@ -1030,6 +1040,46 @@ class TestBuild(unittest.TestCase):
         finally:
             os.environ['PATH'] = old_path
 
+    def testHomedir(self):
+        """Test using ~ in a toolchain or toolchain-prefix section"""
+        # Add some test settings
+        bsettings.setup(None)
+        bsettings.add_file(settings_data_homedir)
+
+        # Set up the toolchains
+        home = os.path.expanduser('~')
+        toolchains = toolchain.Toolchains()
+        toolchains.GetSettings()
+        self.assertEqual([f'{home}/mypath'], toolchains.paths)
+
+        # Check scanning
+        with test_util.capture_sys_output() as (stdout, _):
+            toolchains.Scan(verbose=True, raise_on_error=False)
+        lines = iter(stdout.getvalue().splitlines() + ['##done'])
+        self.assertEqual('Scanning for tool chains', next(lines))
+        self.assertEqual(f"   - scanning prefix '{home}/mypath-x86-'",
+                         next(lines))
+        self.assertEqual(
+            f"Error: No tool chain found for prefix '{home}/mypath-x86-gcc'",
+            next(lines))
+        self.assertEqual(f"   - scanning path '{home}/mypath'", next(lines))
+        self.assertEqual(f"      - looking in '{home}/mypath/.'", next(lines))
+        self.assertEqual(f"      - looking in '{home}/mypath/bin'", next(lines))
+        self.assertEqual(f"      - looking in '{home}/mypath/usr/bin'",
+                         next(lines))
+        self.assertEqual('##done', next(lines))
+
+        # Check adding a toolchain
+        with test_util.capture_sys_output() as (stdout, _):
+            toolchains.Add('~/aarch64-linux-gcc', test=True, verbose=True)
+        lines = iter(stdout.getvalue().splitlines() + ['##done'])
+        self.assertEqual('Tool chain test:  BAD', next(lines))
+        self.assertEqual(f'Command: {home}/aarch64-linux-gcc --version',
+                         next(lines))
+        self.assertEqual('', next(lines))
+        self.assertEqual('', next(lines))
+        self.assertEqual('##done', next(lines))
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index dab350fec31..958f36f9f61 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -65,12 +65,13 @@ class Toolchain:
         """Create a new toolchain object.
 
         Args:
-            fname: Filename of the gcc component
+            fname: Filename of the gcc component, possibly with ~ or $HOME in it
             test: True to run the toolchain to test it
             verbose: True to print out the information
             priority: Priority to use for this toolchain, or PRIORITY_CALC to
                 calculate it
         """
+        fname = os.path.expanduser(fname)
         self.gcc = fname
         self.path = os.path.dirname(fname)
         self.override_toolchain = override_toolchain
@@ -109,7 +110,7 @@ class Toolchain:
                                                           self.priority))
                 else:
                     print('BAD')
-                    print('Command: ', cmd)
+                    print(f"Command: {' '.join(cmd)}")
                     print(result.stdout)
                     print(result.stderr)
         else:
@@ -296,10 +297,11 @@ class Toolchains:
 
         paths = []
         for name, value in toolchains:
+            fname = os.path.expanduser(value)
             if '*' in value:
-                paths += glob.glob(value)
+                paths += glob.glob(fname)
             else:
-                paths.append(value)
+                paths.append(fname)
         return paths
 
     def GetSettings(self, show_warning=True):
@@ -373,7 +375,7 @@ class Toolchains:
                 pathname_list.append(pathname)
         return pathname_list
 
-    def Scan(self, verbose):
+    def Scan(self, verbose, raise_on_error=True):
         """Scan for available toolchains and select the best for each arch.
 
         We look for all the toolchains we can file, figure out the
@@ -385,11 +387,12 @@ class Toolchains:
         """
         if verbose: print('Scanning for tool chains')
         for name, value in self.prefixes:
-            if verbose: print("   - scanning prefix '%s'" % value)
-            if os.path.exists(value):
-                self.Add(value, True, verbose, PRIORITY_FULL_PREFIX, name)
+            fname = os.path.expanduser(value)
+            if verbose: print("   - scanning prefix '%s'" % fname)
+            if os.path.exists(fname):
+                self.Add(fname, True, verbose, PRIORITY_FULL_PREFIX, name)
                 continue
-            fname = value + 'gcc'
+            fname += 'gcc'
             if os.path.exists(fname):
                 self.Add(fname, True, verbose, PRIORITY_PREFIX_GCC, name)
                 continue
@@ -397,8 +400,11 @@ class Toolchains:
             for f in fname_list:
                 self.Add(f, True, verbose, PRIORITY_PREFIX_GCC_PATH, name)
             if not fname_list:
-                raise ValueError("No tool chain found for prefix '%s'" %
-                                   value)
+                msg = f"No tool chain found for prefix '{fname}'"
+                if raise_on_error:
+                    raise ValueError(msg)
+                else:
+                    print(f'Error: {msg}')
         for path in self.paths:
             if verbose: print("   - scanning path '%s'" % path)
             fnames = self.ScanPath(path, verbose)
-- 
2.34.1

