Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F86BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE13849D2;
	Tue,  7 Jul 2026 13:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NzwSF3RY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F092484A1F; Tue,  7 Jul 2026 13:36:20 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955B780087
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so1642786fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424177; x=1784028977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMS7SUlbeh4iQvb0JdqL9R5BerVEbITWDmoH/GQbVh0=;
 b=NzwSF3RYdnrnw11iLBQclW7X+DQl8Wx0EqQs8xLK4TjMZMS2ljf2HU4xZTPl/q6kcx
 ZtS7njZxY1hXIw5rmeVunQR3j6LVPgtU7Mj9is8hyt8IVs259/C1kDtz9utfFKbRxSIC
 eLgE9NvUqtPwhAvFVyueaR5tDdUvyJc5KV7ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424177; x=1784028977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMS7SUlbeh4iQvb0JdqL9R5BerVEbITWDmoH/GQbVh0=;
 b=miI82Y5mw5kYRUEXwDJr4AJyGJh+2G4UIh8Z7omtBNOsdX1puaj2vFa2mABijz7COP
 XXuPFe7zR+HjsM0oY59goVyizPn8ydwPGdRaIzM6QmQQ8UoIkCk1ec4NXRK/mENeeZwc
 qE0t4SxQNJy+UZ+WGfGN7gZqCAjYVYP+eEIbjw0YkebqiKdn/urQXFYAxPZEBHTInrvO
 JxAypokOAE1JjtHeOG5OwODqeHkx8v4OrPZ5E4/21XyGBxBLvGMg152peQEWI3Es3eM/
 lOdrTU46jmD2Dpa8lKaUo3wpZduh0aMb/wB490D7y45f4n/Qic6ObSBFHU9a2a0uwVWG
 MSFw==
X-Gm-Message-State: AOJu0YyMxkg5EGetVb82a+apcpzwjMjo15/qo3QijLIjdhZzS7x90lMi
 d7lR4iwOpi3UlkA8aRX7BD5e1vhmwdpzVAmn1//WlfTUIBmEq2FkSIIlTnhIguoY7p4dMJZYTnk
 724n3uA==
X-Gm-Gg: AfdE7ckFX431UPwifvEaKK3a/kxr6P3PNp+YEmIRncH82X70Lx9RJhacBjW1v727qiQ
 UUinIMmuzb0LBc3t2Q6qvzQfN6grEeuNJP/bzaC0dOoXnGJOJbFvlG6VBKON6KxXEKNrtwtMbmz
 uXJ/9lBpSN98Ici/Q0YmZrBa2csFKmKHRG0K4gNhKkC7ArQkpaxheUchyXRv0XDb3WIG9kd5qwj
 +dxhoQ1IszI2bIj2Iu1+lSl2B96APzel+nMZQV/YwvVnEaneKBMX3llzvMm3d3NoORb7iqO9NPM
 cclxosxM4UHqOpjDQ1wvivM3mwHVAI6sMh7BPPE5p/X4rzQ4X5FoLNHPKvmcbm3Ows7f2V9152Y
 5cZPAaaNp1MedUCkWKsffHf8sfiKgK5D8QidZIyXi8rED5HxduOf2F5sW2rKXPbHjtOWrm4UtQJ
 Uh9qmYQTs=
X-Received: by 2002:a05:6871:820a:b0:43b:58a4:cc33 with SMTP id
 586e51a60fabf-451065bccf8mr3155299fac.22.1783424177243; 
 Tue, 07 Jul 2026 04:36:17 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/13] qconfig: Use kconfiglib to build the CONFIG database
Date: Tue,  7 Jul 2026 05:35:09 -0600
Message-ID: <20260707113538.3382145-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

The -b option currently spawns two make subprocesses per board (make
defconfig + make auto.conf), requiring cross-compiler toolchains for
every architecture and taking several minutes for the full set of ~1500
boards.

Replace this with direct kconfiglib evaluation. Each worker-process
parses the Kconfig tree once, then loads each defconfig in its chunk
using kconf.load_config() and reads the resolved CONFIG values via
sym.config_string. This avoids all overhead related to subprocess and
toolchains, reducing the full database build from minutes to under two
seconds.

The multiprocessing pattern follows the existing approach in
buildman/boards.py, including handling of #include directives in
defconfig files via the C preprocessor.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/qconfig.rst |  43 ++++++++++---
 tools/qconfig.py        | 132 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 162 insertions(+), 13 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index 3b995355967..431de08cff3 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -24,14 +24,36 @@ You may need to install 'python3-asteval' for the 'asteval' module.
 How does it work?
 -----------------
 
-When building a database (`-b`), this tool runs configuration and builds
-include/autoconf.mk for every defconfig.  The config options defined in Kconfig
-appear in the .config file (unless they are hidden because of unmet dependency.)
-On the other hand, the config options defined by board headers are seen
-in include/autoconf.mk.
+Building a database
+~~~~~~~~~~~~~~~~~~~
+
+When building a database (`-b`), this tool evaluates the Kconfig tree directly
+using kconfiglib (a pure-Python Kconfig implementation). For each defconfig, it
+loads the file with ``kconf.load_config()``, resolves all symbol dependencies,
+and collects the resulting CONFIG values. This is the same approach used by
+``buildman`` when scanning board parameters.
+
+Multiple worker processes run in parallel (one per CPU core by default,
+adjustable with ``-j``), each parsing the Kconfig tree once and then processing
+its share of defconfigs. This completes in a few seconds for all ~1500 boards,
+since no ``make`` subprocesses or cross-compiler toolchains are needed.
+
+Defconfig files containing ``#include`` directives are preprocessed with the
+C preprocessor before loading, matching the behaviour of the build system.
+
+There is one known cosmetic difference compared with the old make-based
+approach: ``CONFIG_GCC_VERSION`` reflects the host compiler rather than each
+board's cross-compiler, since no cross-compiler is invoked. This does not
+affect the usefulness of the database for finding CONFIG combinations or
+computing imply relationships.
+
+Resyncing defconfigs
+~~~~~~~~~~~~~~~~~~~~
 
 When resyncing defconfigs (`-s`) the .config is synced by "make savedefconfig"
-and the defconfig is updated with it.
+and the defconfig is updated with it. This path still uses ``make``
+subprocesses and therefore requires appropriate cross-compiler toolchains (see
+below).
 
 For faster processing, this tool is multi-threaded.  It creates
 separate build directories where the out-of-tree build is run.  The
@@ -44,9 +66,12 @@ Note that `*.config` fragments are not supported.
 Toolchains
 ----------
 
-Appropriate toolchains are necessary to generate include/autoconf.mk
-for all the architectures supported by U-Boot.  Most of them are available
-at the kernel.org site. This tool uses the same tools as
+Toolchains are **not** needed for building the database (`-b`), since it
+uses kconfiglib to evaluate Kconfig files directly in Python.
+
+For resyncing defconfigs (`-s`), appropriate toolchains are necessary to run
+``make savedefconfig`` for all the architectures supported by U-Boot.  Most of
+them are available at the kernel.org site. This tool uses the same tools as
 :doc:`../build/buildman`, so you can use `buildman --fetch-arch` to fetch
 toolchains.
 
diff --git a/tools/qconfig.py b/tools/qconfig.py
index c8e5656e9d7..2a594ea0200 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -283,6 +283,129 @@ def scan_kconfig():
     return kconfiglib.Kconfig()
 
 
+def _scan_defconfigs_worker(srcdir, defconfigs, queue, error_queue):
+    """Worker process that scans defconfigs using kconfiglib
+
+    Each worker creates its own Kconfig instance (parsing is done once per
+    process) then loads each defconfig in turn, collecting all CONFIG values.
+
+    Args:
+        srcdir (str): Source-tree directory
+        defconfigs (list of str): Defconfig filenames to process, e.g.
+            ['sandbox_defconfig', 'snow_defconfig']
+        queue (multiprocessing.Queue): Output queue for (defconfig, configs)
+        error_queue (multiprocessing.Queue): Output queue for failed defconfigs
+    """
+    os.environ['srctree'] = srcdir
+    os.environ['UBOOTVERSION'] = 'dummy'
+    os.environ['KCONFIG_OBJDIR'] = ''
+    os.environ['CC'] = 'gcc'
+    kconf = kconfiglib.Kconfig(warn=False)
+
+    for defconfig in defconfigs:
+        fname = os.path.join(srcdir, 'configs', defconfig)
+        try:
+            if b'#include' in tools.read_file(fname):
+                cpp = os.getenv('CPP', 'cpp').split()
+                cmd = cpp + ['-nostdinc', '-P', '-I', srcdir,
+                             '-undef', '-x', 'assembler-with-cpp', fname]
+                stdout = subprocess.check_output(cmd, stderr=subprocess.DEVNULL)
+                tmp = tempfile.NamedTemporaryFile(prefix='qconfig-', delete=False)
+                tmp.write(stdout)
+                tmp.close()
+                kconf.load_config(tmp.name)
+                os.unlink(tmp.name)
+            else:
+                kconf.load_config(fname)
+
+            configs = {}
+            for sym in kconf.unique_defined_syms:
+                conf = sym.config_string
+                if not conf or conf.startswith('#'):
+                    continue
+                config, value = conf.rstrip('\n').split('=', 1)
+                configs[config] = value
+            queue.put((defconfig, configs))
+        except Exception as exc:
+            error_queue.put((defconfig, str(exc)))
+
+
+def do_build_db(args):
+    """Build the CONFIG database using kconfiglib instead of make
+
+    This evaluates the Kconfig tree directly in Python for each defconfig,
+    avoiding the overhead of spawning make subprocesses and the need for
+    cross-compiler toolchains.
+
+    Args:
+        args (Namespace): Program arguments (uses jobs, defconfigs,
+            defconfiglist, nocolour)
+
+    Returns:
+        tuple:
+            config_db (dict): configs for each defconfig
+            Progress: progress indicator
+    """
+    srcdir = os.getcwd()
+
+    if args.defconfigs:
+        defconfigs = [os.path.basename(d)
+                      for d in get_matched_defconfigs(args.defconfigs)]
+    elif args.defconfiglist:
+        defconfigs = [os.path.basename(d)
+                      for d in get_matched_defconfigs(args.defconfiglist)]
+    else:
+        defconfigs = get_all_defconfigs()
+
+    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
+                         else terminal.COLOR_IF_TERMINAL)
+    progress = Progress(col, len(defconfigs))
+
+    jobs = args.jobs
+    total = len(defconfigs)
+    result_queue = multiprocessing.Queue()
+    error_queue = multiprocessing.Queue()
+    processes = []
+    for i in range(jobs):
+        chunk = defconfigs[total * i // jobs:total * (i + 1) // jobs]
+        if not chunk:
+            continue
+        proc = multiprocessing.Process(
+            target=_scan_defconfigs_worker,
+            args=(srcdir, chunk, result_queue, error_queue))
+        proc.start()
+        processes.append(proc)
+
+    config_db = {}
+    remaining = total
+    while remaining:
+        # Drain both queues without blocking forever
+        found = False
+        while not result_queue.empty():
+            defconfig, configs = result_queue.get()
+            config_db[defconfig] = configs
+            progress.inc(True)
+            progress.show()
+            remaining -= 1
+            found = True
+        while not error_queue.empty():
+            defconfig, msg = error_queue.get()
+            print(col.build(col.RED, f'{defconfig}: {msg}', bright=True),
+                  file=sys.stderr)
+            progress.inc(False)
+            progress.show()
+            remaining -= 1
+            found = True
+        if not found:
+            time.sleep(SLEEP_TIME)
+
+    for proc in processes:
+        proc.join()
+
+    progress.completed()
+    return config_db, progress
+
+
 # pylint: disable=R0903
 class KconfigParser:
     """A parser of .config and include/autoconf.mk."""
@@ -1742,7 +1865,7 @@ def ensure_database(threads):
                          dry_run=False, exit_on_error=False, jobs=threads,
                          git_ref=None, defconfigs=None, defconfiglist=None,
                          nocolour=False)
-        config_db, progress = move_config(args)
+        config_db, progress = do_build_db(args)
 
         write_db(config_db, progress)
 
@@ -1769,13 +1892,14 @@ def main():
     if args.find:
         return do_find_config(args.configs, args.list)
 
+    if args.build_db:
+        config_db, progress = do_build_db(args)
+        return write_db(config_db, progress)
+
     config_db, progress = move_config(args)
 
     if args.commit:
         add_commit(args.configs)
-
-    if args.build_db:
-        return write_db(config_db, progress)
     return move_done(progress)
 
 
-- 
2.43.0

