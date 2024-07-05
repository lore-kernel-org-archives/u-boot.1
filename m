Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B34AC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 20:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6477F88905;
	Fri,  5 Jul 2024 22:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m2wk1d8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E0488969; Fri,  5 Jul 2024 22:34:12 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F3E88864
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so1725642a34.3
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720211649; x=1720816449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=anP7gLeVKGScDHw2io+h6JJv+AoEhFHZBbnl6u7Z7qE=;
 b=m2wk1d8YthA/KP4OFlCztS54e3/BeNJhfhaP4AbgA0RfEm0uUp9fbpvJVNXBUthXh0
 rpsiLKauGvc4zK6GIoIuOI6IEmAlQLOzrj6ftgTfLlE3XtkjbLpjoMfYiG/NwDqEMDz6
 X16JO+KQHZe+hGjeqEH57eyad4qLL/4ueNTUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720211649; x=1720816449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anP7gLeVKGScDHw2io+h6JJv+AoEhFHZBbnl6u7Z7qE=;
 b=JA8x1VTxW/Tjvrhvd79nhmGdz1cirt6W/gGh21OlZDGSna2khdhGQfURABRjttnGeO
 IhNxVh5CKyc3wG9wK6/C1viAiTWnnR/FvH5zpw5PtZVHcWApQRZ/6MhXpiw4Bv/VbP2A
 VUJ2mfRD0gb55w4kM0BIHaOgsjNlpv0BQKCyzHNM5Bh1fgkeI3Hna4RpxWzblbd7lCw9
 41jYFInx3VaF5FOEajhJ2el023kAWrL2ihHyPiGryIBzUqW5oZEqQzd5NoI52L6Sk5G/
 9Lnbc7FNjh9/rgo6//h4bG1Lm2G+VE+ZCgWK5NqSo04iu7XiMy6BzMklRv28wrXjhf03
 wkJg==
X-Gm-Message-State: AOJu0YwXMSVG10s5t5Zs/qNFniXFPvmxUZ0Q8HyZ3OUSpC8i5qqtjFcz
 r8txBmvJpTUQWYcCqMgKaUuGbxuJt891F+LiDF5RMa5Cmf9xH/+FWU9wyTL3VsBZ0LoLdgiVDAR
 AjTXVww==
X-Google-Smtp-Source: AGHT+IFz2drit/RSqBqHdCwYeuhjIg/qcbNvk1EYX/yyawJdJAG6ssDOSOxVMZtrF36xpwNWm2Wzzw==
X-Received: by 2002:a9d:7391:0:b0:702:17a4:682 with SMTP id
 46e09a7af769-7034a80a85fmr6368883a34.27.1720211648984; 
 Fri, 05 Jul 2024 13:34:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b20953sm2731497a34.54.2024.07.05.13.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 13:34:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] Revert "buildman: Always use the full path in CROSS_COMPILE"
Date: Fri,  5 Jul 2024 14:34:07 -0600
Message-Id: <20240705203407.1871563-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

There are operations in buildman that result in running the cross-tools
(such as performing size checks) and now that we have not modified PATH
to know where our tools are, these operations fail.

This reverts commit 6c0a3cf75f72370deec3ee516a9dd377397af207.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I'm likely to apply this revert fairly quickly as it turns out (and I
assumed incorrectly it was just due to locality impact, but I started
getting worried this morning, sigh) none of my size check builds have
been really reporting true values.

Cc: Simon Glass <sjg@chromium.org>
---
 tools/buildman/bsettings.py     |  3 --
 tools/buildman/builder.py       |  5 ++-
 tools/buildman/builderthread.py |  4 +-
 tools/buildman/cmdline.py       |  2 +
 tools/buildman/control.py       |  6 ++-
 tools/buildman/test.py          | 75 ---------------------------------
 tools/buildman/toolchain.py     | 20 +++++----
 7 files changed, 23 insertions(+), 92 deletions(-)

diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
index a7358cfc08a5..aea724fc559f 100644
--- a/tools/buildman/bsettings.py
+++ b/tools/buildman/bsettings.py
@@ -31,9 +31,6 @@ def setup(fname=''):
 def add_file(data):
     settings.read_file(io.StringIO(data))
 
-def add_section(name):
-    settings.add_section(name)
-
 def get_items(section):
     """Get the items from a section of the config.
 
diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index c794177f2baf..c4384f53e8dc 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -255,7 +255,7 @@ class Builder:
 
     def __init__(self, toolchains, base_dir, git_dir, num_threads, num_jobs,
                  gnu_make='make', checkout=True, show_unknown=True, step=1,
-                 no_subdirs=False, verbose_build=False,
+                 no_subdirs=False, full_path=False, verbose_build=False,
                  mrproper=False, fallback_mrproper=False,
                  per_board_out_dir=False, config_only=False,
                  squash_config_y=False, warnings_as_errors=False,
@@ -279,6 +279,8 @@ class Builder:
             step: 1 to process every commit, n to process every nth commit
             no_subdirs: Don't create subdirectories when building current
                 source for a single board
+            full_path: Return the full path in CROSS_COMPILE and don't set
+                PATH
             verbose_build: Run build with V=1 and don't use 'make -s'
             mrproper: Always run 'make mrproper' when configuring
             fallback_mrproper: Run 'make mrproper' and retry on build failure
@@ -335,6 +337,7 @@ class Builder:
         self._step = step
         self._error_lines = 0
         self.no_subdirs = no_subdirs
+        self.full_path = full_path
         self.verbose_build = verbose_build
         self.config_only = config_only
         self.squash_config_y = squash_config_y
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 4e085d6d6756..bbe2f6f0d242 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -406,7 +406,7 @@ class BuilderThread(threading.Thread):
                     the next incremental build
         """
         # Set up the environment and command line
-        env = self.toolchain.MakeEnvironment()
+        env = self.toolchain.MakeEnvironment(self.builder.full_path)
         mkdir(out_dir)
 
         args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
@@ -574,7 +574,7 @@ class BuilderThread(threading.Thread):
                 outf.write(f'{result.return_code}')
 
             # Write out the image and function size information and an objdump
-            env = result.toolchain.MakeEnvironment()
+            env = result.toolchain.MakeEnvironment(self.builder.full_path)
             with open(os.path.join(build_dir, 'out-env'), 'wb') as outf:
                 for var in sorted(env.keys()):
                     outf.write(b'%s="%s"' % (var, env[var]))
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 2673e749d584..544a391a4647 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -123,6 +123,8 @@ def add_after_m(parser):
           help="Override host toochain to use for sandbox (e.g. 'clang-7')")
     parser.add_argument('-Q', '--quick', action='store_true',
           default=False, help='Do a rough build, with limited warning resolution')
+    parser.add_argument('-p', '--full-path', action='store_true',
+          default=False, help="Use full toolchain path in CROSS_COMPILE")
     parser.add_argument('-P', '--per-board-out-dir', action='store_true',
           default=False, help="Use an O= (output) directory per board rather than per thread")
     parser.add_argument('--print-arch', action='store_true',
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 037854dfc07e..464835c5be5c 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -788,8 +788,10 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
     builder = Builder(toolchains, output_dir, git_dir,
             args.threads, args.jobs, checkout=True,
             show_unknown=args.show_unknown, step=args.step,
-            no_subdirs=args.no_subdirs, verbose_build=args.verbose_build,
-            mrproper=args.mrproper, fallback_mrproper=args.fallback_mrproper,
+            no_subdirs=args.no_subdirs, full_path=args.full_path,
+            verbose_build=args.verbose_build,
+            mrproper=args.mrproper,
+            fallback_mrproper=args.fallback_mrproper,
             per_board_out_dir=args.per_board_out_dir,
             config_only=args.config_only,
             squash_config_y=not args.preserve_config_y,
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index ac0a7ab06d62..bfad30930307 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -148,7 +148,6 @@ class TestBuild(unittest.TestCase):
         self.toolchains.Add('arm-linux-gcc', test=False)
         self.toolchains.Add('sparc-linux-gcc', test=False)
         self.toolchains.Add('powerpc-linux-gcc', test=False)
-        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=False)
         self.toolchains.Add('gcc', test=False)
 
         # Avoid sending any output
@@ -869,80 +868,6 @@ class TestBuild(unittest.TestCase):
             self.assertEqual([4, 5], control.read_procs(tmpdir))
             self.assertEqual(self.finish_time, self.cur_time)
 
-    def call_make_environment(self, tchn, in_env=None):
-        """Call Toolchain.MakeEnvironment() and process the result
-
-        Args:
-            tchn (Toolchain): Toolchain to use
-            in_env (dict): Input environment to use, None to use current env
-
-        Returns:
-            tuple:
-                dict: Changes that MakeEnvironment has made to the environment
-                    key: Environment variable that was changed
-                    value: New value (for PATH this only includes components
-                        which were added)
-                str: Full value of the new PATH variable
-        """
-        env = tchn.MakeEnvironment(env=in_env)
-
-        # Get the original environment
-        orig_env = dict(os.environb if in_env is None else in_env)
-        orig_path = orig_env[b'PATH'].split(b':')
-
-        # Find new variables
-        diff = dict((k, env[k]) for k in env if orig_env.get(k) != env[k])
-
-        # Find new / different path components
-        diff_path = None
-        new_path = None
-        if b'PATH' in diff:
-            new_path = diff[b'PATH'].split(b':')
-            diff_paths = [p for p in new_path if p not in orig_path]
-            diff_path = b':'.join(p for p in new_path if p not in orig_path)
-            if diff_path:
-                diff[b'PATH'] = diff_path
-            else:
-                del diff[b'PATH']
-        return diff, new_path
-
-    def test_toolchain_env(self):
-        """Test PATH and other environment settings for toolchains"""
-        # Use a toolchain which has a path
-        tchn = self.toolchains.Select('aarch64')
-
-        # Normal case
-        diff = self.call_make_environment(tchn)[0]
-        self.assertEqual(
-            {b'CROSS_COMPILE': b'/path/to/aarch64-linux-', b'LC_ALL': b'C'},
-            diff)
-
-        # When overriding the toolchain, only LC_ALL should be set
-        tchn.override_toolchain = True
-        diff = self.call_make_environment(tchn)[0]
-        self.assertEqual({b'LC_ALL': b'C'}, diff)
-
-        # Test that virtualenv is handled correctly
-        tchn.override_toolchain = False
-        sys.prefix = '/some/venv'
-        env = dict(os.environb)
-        env[b'PATH'] = b'/some/venv/bin:other/things'
-        tchn.path = '/my/path'
-        diff, diff_path = self.call_make_environment(tchn, env)
-
-        self.assertNotIn(b'PATH', diff)
-        self.assertEqual(None, diff_path)
-        self.assertEqual(
-            {b'CROSS_COMPILE': b'/my/path/aarch64-linux-', b'LC_ALL': b'C'},
-            diff)
-
-        # Handle a toolchain wrapper
-        tchn.path = ''
-        bsettings.add_section('toolchain-wrapper')
-        bsettings.set_item('toolchain-wrapper', 'my-wrapper', 'fred')
-        diff = self.call_make_environment(tchn)[0]
-        self.assertEqual(
-            {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'}, diff)
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 739acf3ec53b..324ad0e0821d 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -90,7 +90,7 @@ class Toolchain:
         if self.arch == 'sandbox' and override_toolchain:
             self.gcc = override_toolchain
 
-        env = self.MakeEnvironment()
+        env = self.MakeEnvironment(False)
 
         # As a basic sanity check, run the C compiler with --version
         cmd = [fname, '--version']
@@ -172,7 +172,7 @@ class Toolchain:
         else:
             raise ValueError('Unknown arg to GetEnvArgs (%d)' % which)
 
-    def MakeEnvironment(self, env=None):
+    def MakeEnvironment(self, full_path):
         """Returns an environment for using the toolchain.
 
         This takes the current environment and adds CROSS_COMPILE so that
@@ -188,23 +188,25 @@ class Toolchain:
              569-570: surrogates not allowed
 
         Args:
-            env (dict of bytes): Original environment, used for testing
-
+            full_path: Return the full path in CROSS_COMPILE and don't set
+                PATH
         Returns:
             Dict containing the (bytes) environment to use. This is based on the
-            current environment, with changes as needed to CROSS_COMPILE and
-            LC_ALL.
+            current environment, with changes as needed to CROSS_COMPILE, PATH
+            and LC_ALL.
         """
-        env = dict(env or os.environb)
-
+        env = dict(os.environb)
         wrapper = self.GetWrapper()
 
         if self.override_toolchain:
             # We'll use MakeArgs() to provide this
             pass
-        else:
+        elif full_path:
             env[b'CROSS_COMPILE'] = tools.to_bytes(
                 wrapper + os.path.join(self.path, self.cross))
+        else:
+            env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
+            env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
 
         env[b'LC_ALL'] = b'C'
 
-- 
2.34.1

