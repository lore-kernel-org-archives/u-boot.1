Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9988AC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 19:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFDB88637;
	Thu, 15 Aug 2024 21:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="afN3iL/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A7F88A95; Thu, 15 Aug 2024 21:58:07 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B5986EE3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 21:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7093705c708so1297190a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723751879; x=1724356679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUjqd8LsDQeoLU27IN03yd7mgeP6IaViritdUqe0lS4=;
 b=afN3iL/lDI9YHZhKnYxH0pHIWwf461ElLyHxK1q93s0qZ45w0vyApvnBeswkXUeYHh
 4BrS3MV927X02RdtVtj4jcv9EBNZ7k1fCzEm70OkMUwqwOWDxqlPvts5NQqmwkbmZXnx
 IDzylvOO/53yYLQKBhY/xbFgRsSpX4V248+Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723751879; x=1724356679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUjqd8LsDQeoLU27IN03yd7mgeP6IaViritdUqe0lS4=;
 b=PBVpBHpwW68D0BYfAMX9RascxGexYo5DFpfPQurHUXM8y4s6i5Ifb/KTTwwb/k+TGJ
 KiOjo/2la14qwOr5anNwk951/4ODsNPZ/btzOzqqPb542DGFKH0rrlOM+11Bj4RSqevQ
 2s6eX2/2YLBdUB0rBQBe8V7cW38Mee0PoOL7T1hZAXRHS6baSKd0uG3bykrPUoQJksUm
 QS+2s7prjPHpNcKE9YDU9RUxIf/z0kNUkY5VgXeHTmFl0p1FwBhWPZVzKBBlGdTlJBx5
 /CenLlTx/KMr9DSqclXkKsKwgVw6tK9ceoCnT8lCC7MwGVXkyfsTbiLSTU4Qzspibey7
 Vkkg==
X-Gm-Message-State: AOJu0YxdelW5xGTZ4sANxIAJR1Fph8tKn6mMmHew1Vpt6rZEMYxZN/nB
 ZT9mz4ccT15401W57xwhlBXkzrl8lMTRo547EunrttWzk31utD+YnPdqWRggaNNN1GiMANSr0MO
 ORA==
X-Google-Smtp-Source: AGHT+IEZVzzRRq+IAiwZ+QRkaCVSSgjyM9Qz2HPJBk9n2BNMD+OLdmG88I7FVBATrFHqWV6X5xX5kA==
X-Received: by 2002:a05:6830:6004:b0:703:7775:c6c2 with SMTP id
 46e09a7af769-70cac8c9368mr695297a34.33.1723751879683; 
 Thu, 15 Aug 2024 12:57:59 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3e3f2sm697372173.100.2024.08.15.12.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 12:57:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Date: Thu, 15 Aug 2024 13:57:45 -0600
Message-Id: <20240815195746.749042-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815195746.749042-1-sjg@chromium.org>
References: <20240815195746.749042-1-sjg@chromium.org>
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

For most boards, the device-tree compiler is built in-tree, ignoring the
system version. Add a special option to skip this build. This can be
useful when the system dtc is up-to-date, as it speeds up the build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
 tools/buildman/builderthread.py |  4 ++--
 tools/buildman/buildman.rst     |  3 +++
 tools/buildman/cmdline.py       |  2 ++
 tools/buildman/control.py       |  3 ++-
 tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index c4384f53e8d..4090d328b30 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -22,6 +22,7 @@ from buildman import toolchain
 from patman import gitutil
 from u_boot_pylib import command
 from u_boot_pylib import terminal
+from u_boot_pylib import tools
 from u_boot_pylib.terminal import tprint
 
 # This indicates an new int or hex Kconfig property with no default
@@ -263,7 +264,8 @@ class Builder:
                  adjust_cfg=None, allow_missing=False, no_lto=False,
                  reproducible_builds=False, force_build=False,
                  force_build_failures=False, force_reconfig=False,
-                 in_tree=False, force_config_on_failure=False, make_func=None):
+                 in_tree=False, force_config_on_failure=False, make_func=None,
+                 dtc_skip=False):
         """Create a new Builder object
 
         Args:
@@ -312,6 +314,7 @@ class Builder:
             force_config_on_failure (bool): Reconfigure the build before
                 retrying a failed build
             make_func (function): Function to call to run 'make'
+            dtc_skip (bool): True to skip building dtc and use the system one
         """
         self.toolchains = toolchains
         self.base_dir = base_dir
@@ -354,6 +357,12 @@ class Builder:
         self.in_tree = in_tree
         self.force_config_on_failure = force_config_on_failure
         self.fallback_mrproper = fallback_mrproper
+        if dtc_skip:
+            self.dtc = shutil.which('dtc')
+            if not self.dtc:
+                raise ValueError('Cannot find dtc')
+        else:
+            self.dtc = None
 
         if not self.squash_config_y:
             self.config_filenames += EXTRA_CONFIG_FILENAMES
@@ -407,6 +416,22 @@ class Builder:
     def signal_handler(self, signal, frame):
         sys.exit(1)
 
+    def make_environment(self, toolchain):
+        """Create the environment to use for building
+
+        Args:
+            toolchain (Toolchain): Toolchain to use for building
+
+        Returns:
+            dict:
+                key (str): Variable name
+                value (str): Variable value
+        """
+        env = toolchain.MakeEnvironment(self.full_path)
+        if self.dtc:
+            env[b'DTC'] = tools.to_bytes(self.dtc)
+        return env
+
     def set_display_options(self, show_errors=False, show_sizes=False,
                           show_detail=False, show_bloat=False,
                           list_error_boards=False, show_config=False,
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index bbe2f6f0d24..54f3c02c844 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -406,7 +406,7 @@ class BuilderThread(threading.Thread):
                     the next incremental build
         """
         # Set up the environment and command line
-        env = self.toolchain.MakeEnvironment(self.builder.full_path)
+        env = self.builder.make_environment(self.toolchain)
         mkdir(out_dir)
 
         args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
@@ -574,7 +574,7 @@ class BuilderThread(threading.Thread):
                 outf.write(f'{result.return_code}')
 
             # Write out the image and function size information and an objdump
-            env = result.toolchain.MakeEnvironment(self.builder.full_path)
+            env = self.builder.make_environment(self.toolchain)
             with open(os.path.join(build_dir, 'out-env'), 'wb') as outf:
                 for var in sorted(env.keys()):
                     outf.write(b'%s="%s"' % (var, env[var]))
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index b8ff3bf1ab2..e873611e596 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1030,6 +1030,9 @@ of the source tree, thus allowing rapid tested evolution of the code::
 
     ./tools/buildman/buildman -Pr tegra
 
+Note also the `--dtc-skip` option which uses the system device-tree compiler to
+avoid needing to build it for each board. This can save 10-20% of build time.
+An alternative is to set DTC=/path/to/dtc when running buildman.
 
 Checking configuration
 ----------------------
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 544a391a464..7573e5bdfe8 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -46,6 +46,8 @@ def add_upto_m(parser):
           help='Show detailed size delta for each board in the -S summary')
     parser.add_argument('-D', '--debug', action='store_true',
         help='Enabling debugging (provides a full traceback on error)')
+    parser.add_argument('--dtc-skip', action='store_true', default=False,
+          help='Skip building of dtc and use the system version')
     parser.add_argument('-e', '--show_errors', action='store_true',
           default=False, help='Show errors and warnings')
     parser.add_argument('-E', '--warnings-as-errors', action='store_true',
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index d3d027f02ab..55d4d770c5c 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -809,7 +809,8 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
             force_build = args.force_build,
             force_build_failures = args.force_build_failures,
             force_reconfig = args.force_reconfig, in_tree = args.in_tree,
-            force_config_on_failure=not args.quick, make_func=make_func)
+            force_config_on_failure=not args.quick, make_func=make_func,
+            dtc_skip=args.dtc_skip)
 
     TEST_BUILDER = builder
 
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 6191af95445..91f7a3a475a 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -952,6 +952,37 @@ class TestBuild(unittest.TestCase):
         self.assertEqual(
             {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'}, diff)
 
+    def test_skip_dtc(self):
+        """Test skipping building the dtc tool"""
+        old_path = os.getenv('PATH')
+        try:
+            os.environ['PATH'] = self.base_dir
+
+            # Check a missing tool
+            with self.assertRaises(ValueError) as exc:
+                builder.Builder(self.toolchains, self.base_dir, None, 0, 2,
+                                dtc_skip=True)
+            self.assertIn('Cannot find dtc', str(exc.exception))
+
+            # Create a fake tool to use
+            dtc = os.path.join(self.base_dir, 'dtc')
+            tools.write_file(dtc, b'xx')
+            os.chmod(dtc, 0o777)
+
+            build = builder.Builder(self.toolchains, self.base_dir, None, 0, 2,
+                                    dtc_skip=True)
+            toolchain = self.toolchains.Select('arm')
+            env = build.make_environment(toolchain)
+            self.assertIn(b'DTC', env)
+
+            # Try the normal case, i.e. not skipping the dtc build
+            build = builder.Builder(self.toolchains, self.base_dir, None, 0, 2)
+            toolchain = self.toolchains.Select('arm')
+            env = build.make_environment(toolchain)
+            self.assertNotIn(b'DTC', env)
+        finally:
+            os.environ['PATH'] = old_path
+
 
 if __name__ == "__main__":
     unittest.main()
-- 
2.34.1

