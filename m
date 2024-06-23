Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624CBC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2DB88551;
	Sun, 23 Jun 2024 19:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dr6hADCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0822F88610; Sun, 23 Jun 2024 19:56:32 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF93881BA
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so150011139f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165388; x=1719770188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZuVtE/Ly1/A7/OuJHCiz8niV93yG/N2oSyd6PxIWPA=;
 b=Dr6hADCo/oPnuGbXpgVGz6zeONuZ5Txf20NFgIEElTciZ6JnvhT6jK1gFBchUPGJhL
 GD26aSHx1WwA5bgdxodBOwkdNPi0dS5Wl4egeU2qU5OaR2Q8pQDDJxr/eZjCcjphvErz
 4Q8WT9ZoPsG/JRPytm90iJSLRshn6/ztxm70s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165388; x=1719770188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZuVtE/Ly1/A7/OuJHCiz8niV93yG/N2oSyd6PxIWPA=;
 b=SFtwzokvkGlYsFzQ5aNQ6xL4TY1LdtD13ajyriVELf1me/40fMIrm1EovNarzN2mT3
 pROqxMhOm7ilnWyB4ilzEGVgfrS6wCKbtVv8aKvbvPs+hgj8w0tpdCCcOcXS8fO8sx2Q
 g91Zk4xcdZFJbcF8Bas7cYNJhufeHpAl+/DrPpdFPtwXwxZk5TCWwCvzL46UcQT4uyOa
 LsmJi9OeLXr2rKfCLxBKilYWlGX88zTuukWcBuVB5KbxbbcUGJUVbffFpjLXmLY0T2/c
 +bzotgrsvqB1+VVUMflcA/oYQV9KxDbX9unWRpe31dYmm0STWsRWlanijegv9rnfnmw+
 jUCw==
X-Gm-Message-State: AOJu0YwNi4gYM98NoxRKSP3El0GfavNvlFL/hYYWsLXvltoOyRsJuZwA
 oM6IHZs27agbMxLPFltcz2xNM8EFjTySCePeW4a/VlJG2PlxAYOQ3qr14DuzvLXci0HmhDmo6yB
 JCOpb
X-Google-Smtp-Source: AGHT+IHHorwBEuTWiqE5AqskQa1C7wa1Qtsy37r0QpICB5gkQCw/d+Z4CdLJMG/X4Cj0hxCMBI7hSQ==
X-Received: by 2002:a92:ca4d:0:b0:376:490c:482d with SMTP id
 e9e14a558f8ab-376490c4943mr8785975ab.9.1719165387921; 
 Sun, 23 Jun 2024 10:56:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
Date: Sun, 23 Jun 2024 11:56:20 -0600
Message-Id: <20240623175622.1468600-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175622.1468600-1-sjg@chromium.org>
References: <20240623175622.1468600-1-sjg@chromium.org>
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

The feature to set the toolchain path does not seem to be needed. It
causes problems with venv (see [1]). Let's remove it.

Add some tests while we are here.

It does not look like any docs changes are needed for this.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.2363294-6-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Drop the PATH modification altogether

 tools/buildman/bsettings.py     |  3 ++
 tools/buildman/builder.py       |  5 +--
 tools/buildman/builderthread.py |  4 +-
 tools/buildman/cmdline.py       |  2 -
 tools/buildman/control.py       |  6 +--
 tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py     | 20 ++++-----
 7 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
index e225ac2ca0f..1be1d45e0fa 100644
--- a/tools/buildman/bsettings.py
+++ b/tools/buildman/bsettings.py
@@ -31,6 +31,9 @@ def setup(fname=''):
 def add_file(data):
     settings.readfp(io.StringIO(data))
 
+def add_section(name):
+    settings.add_section(name)
+
 def get_items(section):
     """Get the items from a section of the config.
 
diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index f35175b4598..7c563cddada 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -255,7 +255,7 @@ class Builder:
 
     def __init__(self, toolchains, base_dir, git_dir, num_threads, num_jobs,
                  gnu_make='make', checkout=True, show_unknown=True, step=1,
-                 no_subdirs=False, full_path=False, verbose_build=False,
+                 no_subdirs=False, verbose_build=False,
                  mrproper=False, per_board_out_dir=False,
                  config_only=False, squash_config_y=False,
                  warnings_as_errors=False, work_in_output=False,
@@ -279,8 +279,6 @@ class Builder:
             step: 1 to process every commit, n to process every nth commit
             no_subdirs: Don't create subdirectories when building current
                 source for a single board
-            full_path: Return the full path in CROSS_COMPILE and don't set
-                PATH
             verbose_build: Run build with V=1 and don't use 'make -s'
             mrproper: Always run 'make mrproper' when configuring
             per_board_out_dir: Build in a separate persistent directory per
@@ -336,7 +334,6 @@ class Builder:
         self._step = step
         self._error_lines = 0
         self.no_subdirs = no_subdirs
-        self.full_path = full_path
         self.verbose_build = verbose_build
         self.config_only = config_only
         self.squash_config_y = squash_config_y
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index a8599c0bb2a..c23c3254d2d 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -404,7 +404,7 @@ class BuilderThread(threading.Thread):
                     the next incremental build
         """
         # Set up the environment and command line
-        env = self.toolchain.MakeEnvironment(self.builder.full_path)
+        env = self.toolchain.MakeEnvironment()
         mkdir(out_dir)
 
         args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
@@ -569,7 +569,7 @@ class BuilderThread(threading.Thread):
                 outf.write(f'{result.return_code}')
 
             # Write out the image and function size information and an objdump
-            env = result.toolchain.MakeEnvironment(self.builder.full_path)
+            env = result.toolchain.MakeEnvironment()
             with open(os.path.join(build_dir, 'out-env'), 'wb') as outf:
                 for var in sorted(env.keys()):
                     outf.write(b'%s="%s"' % (var, env[var]))
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 03211bd5aa5..5fda90508f2 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -121,8 +121,6 @@ def add_after_m(parser):
           help="Override host toochain to use for sandbox (e.g. 'clang-7')")
     parser.add_argument('-Q', '--quick', action='store_true',
           default=False, help='Do a rough build, with limited warning resolution')
-    parser.add_argument('-p', '--full-path', action='store_true',
-          default=False, help="Use full toolchain path in CROSS_COMPILE")
     parser.add_argument('-P', '--per-board-out-dir', action='store_true',
           default=False, help="Use an O= (output) directory per board rather than per thread")
     parser.add_argument('--print-arch', action='store_true',
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 8f6850c5211..3ca9e2e8761 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -653,10 +653,8 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
     builder = Builder(toolchains, output_dir, git_dir,
             args.threads, args.jobs, checkout=True,
             show_unknown=args.show_unknown, step=args.step,
-            no_subdirs=args.no_subdirs, full_path=args.full_path,
-            verbose_build=args.verbose_build,
-            mrproper=args.mrproper,
-            per_board_out_dir=args.per_board_out_dir,
+            no_subdirs=args.no_subdirs, verbose_build=args.verbose_build,
+            mrproper=args.mrproper, per_board_out_dir=args.per_board_out_dir,
             config_only=args.config_only,
             squash_config_y=not args.preserve_config_y,
             warnings_as_errors=args.warnings_as_errors,
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index f92add7a7c5..ae9963eed4f 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
         self.toolchains.Add('arm-linux-gcc', test=False)
         self.toolchains.Add('sparc-linux-gcc', test=False)
         self.toolchains.Add('powerpc-linux-gcc', test=False)
+        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=False)
         self.toolchains.Add('gcc', test=False)
 
         # Avoid sending any output
@@ -747,6 +748,80 @@ class TestBuild(unittest.TestCase):
         self.assertEqual([
             ['MARY="mary"', 'Missing expected line: CONFIG_MARY="mary"']], result)
 
+    def call_make_environment(self, tchn, in_env=None):
+        """Call Toolchain.MakeEnvironment() and process the result
+
+        Args:
+            tchn (Toolchain): Toolchain to use
+            in_env (dict): Input environment to use, None to use current env
+
+        Returns:
+            tuple:
+                dict: Changes that MakeEnvironment has made to the environment
+                    key: Environment variable that was changed
+                    value: New value (for PATH this only includes components
+                        which were added)
+                str: Full value of the new PATH variable
+        """
+        env = tchn.MakeEnvironment(env=in_env)
+
+        # Get the original environment
+        orig_env = dict(os.environb if in_env is None else in_env)
+        orig_path = orig_env[b'PATH'].split(b':')
+
+        # Find new variables
+        diff = dict((k, env[k]) for k in env if orig_env.get(k) != env[k])
+
+        # Find new / different path components
+        diff_path = None
+        new_path = None
+        if b'PATH' in diff:
+            new_path = diff[b'PATH'].split(b':')
+            diff_paths = [p for p in new_path if p not in orig_path]
+            diff_path = b':'.join(p for p in new_path if p not in orig_path)
+            if diff_path:
+                diff[b'PATH'] = diff_path
+            else:
+                del diff[b'PATH']
+        return diff, new_path
+
+    def test_toolchain_env(self):
+        """Test PATH and other environment settings for toolchains"""
+        # Use a toolchain which has a path
+        tchn = self.toolchains.Select('aarch64')
+
+        # Normal case
+        diff = self.call_make_environment(tchn)[0]
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'/path/to/aarch64-linux-', b'LC_ALL': b'C'},
+            diff)
+
+        # When overriding the toolchain, only LC_ALL should be set
+        tchn.override_toolchain = True
+        diff = self.call_make_environment(tchn)[0]
+        self.assertEqual({b'LC_ALL': b'C'}, diff)
+
+        # Test that virtualenv is handled correctly
+        tchn.override_toolchain = False
+        sys.prefix = '/some/venv'
+        env = dict(os.environb)
+        env[b'PATH'] = b'/some/venv/bin:other/things'
+        tchn.path = '/my/path'
+        diff, diff_path = self.call_make_environment(tchn, env)
+
+        self.assertNotIn(b'PATH', diff)
+        self.assertEqual(None, diff_path)
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'/my/path/aarch64-linux-', b'LC_ALL': b'C'},
+            diff)
+
+        # Handle a toolchain wrapper
+        tchn.path = ''
+        bsettings.add_section('toolchain-wrapper')
+        bsettings.set_item('toolchain-wrapper', 'my-wrapper', 'fred')
+        diff = self.call_make_environment(tchn)[0]
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'}, diff)
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 324ad0e0821..739acf3ec53 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -90,7 +90,7 @@ class Toolchain:
         if self.arch == 'sandbox' and override_toolchain:
             self.gcc = override_toolchain
 
-        env = self.MakeEnvironment(False)
+        env = self.MakeEnvironment()
 
         # As a basic sanity check, run the C compiler with --version
         cmd = [fname, '--version']
@@ -172,7 +172,7 @@ class Toolchain:
         else:
             raise ValueError('Unknown arg to GetEnvArgs (%d)' % which)
 
-    def MakeEnvironment(self, full_path):
+    def MakeEnvironment(self, env=None):
         """Returns an environment for using the toolchain.
 
         This takes the current environment and adds CROSS_COMPILE so that
@@ -188,25 +188,23 @@ class Toolchain:
              569-570: surrogates not allowed
 
         Args:
-            full_path: Return the full path in CROSS_COMPILE and don't set
-                PATH
+            env (dict of bytes): Original environment, used for testing
+
         Returns:
             Dict containing the (bytes) environment to use. This is based on the
-            current environment, with changes as needed to CROSS_COMPILE, PATH
-            and LC_ALL.
+            current environment, with changes as needed to CROSS_COMPILE and
+            LC_ALL.
         """
-        env = dict(os.environb)
+        env = dict(env or os.environb)
+
         wrapper = self.GetWrapper()
 
         if self.override_toolchain:
             # We'll use MakeArgs() to provide this
             pass
-        elif full_path:
+        else:
             env[b'CROSS_COMPILE'] = tools.to_bytes(
                 wrapper + os.path.join(self.path, self.cross))
-        else:
-            env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
-            env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
 
         env[b'LC_ALL'] = b'C'
 
-- 
2.34.1

