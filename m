Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CADCC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179AC84A35;
	Tue,  7 Jul 2026 13:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bksUc2c2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAC984994; Tue,  7 Jul 2026 13:36:27 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEEFE84A35
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a0e525db1eso2689004eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424183; x=1784028983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxGKVDpvlU5pz90s35nG240LWkDas4Mim21A/KmosoU=;
 b=bksUc2c28RrbDhvKk0qByRn1obHQ++8LleOlhWwWrTzrplY82cmkPwbKmPGxFCmITx
 L67mZsaA00BuO1LX6qjLE+VJbZqxAOE6WpTTYG8Dh9poY+9YwOD3qH4Qw0qBGOZXinA2
 XI03jKzM7ytkVB1lQpBr1N3LTmGIg+vftVMwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424183; x=1784028983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vxGKVDpvlU5pz90s35nG240LWkDas4Mim21A/KmosoU=;
 b=CJyk/sVqP4LjzPIDNp+mbTSlAt07EeO9iZgloU2TU+1RCY7fAwMHFVejMaObxUXJVi
 O/jGbl9kz5u5XcfacIR2hgDQIp9FfPTMpRIhJ+T5XX3mRr2e/Gwo2jQilgNrke2zofNP
 Jlb8bRUVIox0LN/rL9Td7afk7Z4kVBItqNRofPf/S4GM8bpYm7F6nqsw2xkL0bpI0NMH
 64DUlRsGX1bKNZqgPH4t7MzwT0hZalnQYaDtx0SokviJS0xDtLVfAp9XPizCk4V49bxf
 wmtOO83oahQz7wLsRPokVNKZeRBGyE5bfGJdjMnkHilTxFVHN6WKdtm8BPdXZj+ZBj4q
 nlMQ==
X-Gm-Message-State: AOJu0YxYfRKdUEVmHrCALJQxQL/PjKhjGPgjIdLlLEQbpycsuLeDZy63
 syNy3dm9CiKJkNJw6aNzzkuq0tiWLQEeAs0ZR1UquDOvFL/suoCOGVykPjPRYIljVwwZexFGFSm
 O5VAZTw==
X-Gm-Gg: AfdE7cl1b8OnsQdL2yVYLI5EUoKRSnihvEbMW/pUyzn/Iz9Uc/qLAxy5skuwteqh3mg
 Yy4iFckqVQMnfsIzesWYCUsB1aiGC841J+0wqmmkfdiDqxq1BLlyklDXDCkwBn6Jdx6J6kzsEqp
 ssIonHlOkelg7F/R6Y4fDapl/gYU6V+wsyzcE77jxRg2K0fs0Uo4YQ7phy5CKuRHucyP9n3vgTX
 04Ac3JN1bdUIrEjhFxbP+U2WcyAdqRc2dXjkXdHPZ98RgTmkQInTT0M4It0xp3IRT0tEeiMSczd
 1Xz5JDSEbiIRkyNzwDd3m5O9pMGBcAtw8ER2v3iUImyHpO8xu3iWVm1xp+X+MrPPw6XHI4JJxGk
 //60yQGIJRen//Bn29mEFYPJKlTw76zRYZt2zzFAOlLOV7dZ718FtVeiC/PAlHSFaEUC3pLl2i7
 VyeWAdFniP1xAp9bSpUA==
X-Received: by 2002:a05:6820:1845:b0:6a3:a7b:579f with SMTP id
 006d021491bc7-6a3553dae11mr3264508eaf.40.1783424183236; 
 Tue, 07 Jul 2026 04:36:23 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/13] qconfig: Use kconfiglib for defconfig sync
Date: Tue,  7 Jul 2026 05:35:11 -0600
Message-ID: <20260707113538.3382145-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The -s option currently spawns two make subprocesses per board (make
defconfig + make savedefconfig), requiring cross-compiler toolchains for
every architecture.

Replace this with kconfiglib's load_config() and write_min_config(),
which produces output matching 'make savedefconfig'. This uses the same
multiprocessing pattern as the -b optimisation, completing a full sync
of ~1500 boards in under two seconds with no toolchain requirement.

The -r (git-ref) option still uses the old make-based path, since it
needs to build against a different source tree.

Update the documentation for the new sync approach, folding the note
about CONFIG_GCC_VERSION into the Toolchains section.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/qconfig.rst |  44 ++++++-------
 tools/qconfig.py        | 138 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 25 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index 431de08cff3..e5c9e13915d 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -41,39 +41,33 @@ since no ``make`` subprocesses or cross-compiler toolchains are needed.
 Defconfig files containing ``#include`` directives are preprocessed with the
 C preprocessor before loading, matching the behaviour of the build system.
 
-There is one known cosmetic difference compared with the old make-based
-approach: ``CONFIG_GCC_VERSION`` reflects the host compiler rather than each
-board's cross-compiler, since no cross-compiler is invoked. This does not
-affect the usefulness of the database for finding CONFIG combinations or
-computing imply relationships.
-
 Resyncing defconfigs
 ~~~~~~~~~~~~~~~~~~~~
 
-When resyncing defconfigs (`-s`) the .config is synced by "make savedefconfig"
-and the defconfig is updated with it. This path still uses ``make``
-subprocesses and therefore requires appropriate cross-compiler toolchains (see
-below).
-
-For faster processing, this tool is multi-threaded.  It creates
-separate build directories where the out-of-tree build is run.  The
-temporary build directories are automatically created and deleted as
-needed.  The number of threads are chosen based on the number of the CPU
-cores of your system although you can change it via -j (--jobs) option.
+When resyncing defconfigs (`-s`), the tool also uses kconfiglib.  It loads
+each defconfig with ``load_config()`` and writes a minimal config with
+``write_min_config()`` (equivalent to ``make savedefconfig``).  Defconfigs
+that use ``#include`` directives are skipped, since a minimal config
+cannot preserve the include structure.
 
-Note that `*.config` fragments are not supported.
+The ``-r`` (git-ref) option still uses the old make-based path, since it
+needs to build against a different source tree.
 
 Toolchains
 ----------
 
-Toolchains are **not** needed for building the database (`-b`), since it
-uses kconfiglib to evaluate Kconfig files directly in Python.
-
-For resyncing defconfigs (`-s`), appropriate toolchains are necessary to run
-``make savedefconfig`` for all the architectures supported by U-Boot.  Most of
-them are available at the kernel.org site. This tool uses the same tools as
-:doc:`../build/buildman`, so you can use `buildman --fetch-arch` to fetch
-toolchains.
+Toolchains are **not** needed for ``-b`` or ``-s``, since both use
+kconfiglib to evaluate Kconfig files directly in Python.  The only
+difference from using a real toolchain is that ``CONFIG_GCC_VERSION``
+reflects the host compiler rather than each board's cross-compiler.
+This does not affect database queries, imply analysis, or defconfig
+sync, since ``CONFIG_GCC_VERSION`` is a build-time value that never
+appears in defconfig files or influences Kconfig defaults.
+
+The ``-r`` (git-ref) option still requires toolchains, as it falls back
+to the make-based path.  Most toolchains are available at the kernel.org
+site. This tool uses the same tools as :doc:`../build/buildman`, so you
+can use ``buildman --fetch-arch`` to fetch them.
 
 
 Examples
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 0b8f14d3e65..7ca0736ff3e 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -406,6 +406,138 @@ def do_build_db(args):
     return config_db, progress
 
 
+def _sync_defconfigs_worker(srcdir, defconfigs, result_queue, error_queue,
+                            dry_run):
+    """Worker process that syncs defconfigs using kconfiglib
+
+    For each defconfig, loads it via kconfiglib and writes a minimal config
+    (equivalent to 'make savedefconfig'), then compares with the original.
+
+    Args:
+        srcdir (str): Source-tree directory
+        defconfigs (list of str): Defconfig filenames to process
+        result_queue (multiprocessing.Queue): Output queue for
+            (defconfig, updated) tuples
+        error_queue (multiprocessing.Queue): Output queue for failed defconfigs
+        dry_run (bool): If True, do not update defconfig files
+    """
+    os.environ['srctree'] = srcdir
+    os.environ['UBOOTVERSION'] = 'dummy'
+    os.environ['KCONFIG_OBJDIR'] = ''
+    os.environ['CC'] = 'gcc'
+    kconf = kconfiglib.Kconfig(warn=False)
+
+    for defconfig in defconfigs:
+        orig = os.path.join(srcdir, 'configs', defconfig)
+        try:
+            # Skip defconfigs with #include — savedefconfig mangles them
+            if b'#include' in tools.read_file(orig):
+                result_queue.put((defconfig, False, 'has #include'))
+                continue
+
+            kconf.load_config(orig)
+
+            tmp = tempfile.NamedTemporaryFile(
+                mode='w', prefix='qconfig-', suffix='_defconfig',
+                dir=os.path.join(srcdir, 'configs'), delete=False)
+            tmp.close()
+            kconf.write_min_config(tmp.name)
+
+            updated = not filecmp.cmp(orig, tmp.name)
+            if updated and not dry_run:
+                shutil.move(tmp.name, orig)
+            else:
+                os.unlink(tmp.name)
+            result_queue.put((defconfig, updated, None))
+        except Exception as exc:
+            error_queue.put((defconfig, str(exc)))
+
+
+def do_sync_defconfigs(args):
+    """Sync defconfig files using kconfiglib instead of make
+
+    Evaluates each defconfig through kconfiglib and writes a minimal config
+    (equivalent to 'make savedefconfig'), updating the original if it differs.
+
+    Args:
+        args (Namespace): Program arguments (uses jobs, defconfigs,
+            defconfiglist, nocolour, dry_run, force_sync)
+
+    Returns:
+        Progress: progress indicator
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
+            target=_sync_defconfigs_worker,
+            args=(srcdir, chunk, result_queue, error_queue, args.dry_run))
+        proc.start()
+        processes.append(proc)
+
+    remaining = total
+    updated_count = 0
+    while remaining:
+        found = False
+        while not result_queue.empty():
+            defconfig, updated, msg = result_queue.get()
+            if updated:
+                updated_count += 1
+                name = defconfig[:-len('_defconfig')]
+                log = col.build(col.BLUE, 'defconfig updated', bright=True)
+                if args.dry_run:
+                    log = col.build(col.YELLOW, 'would update', bright=True)
+                print(f'{name.ljust(20)} {log}')
+            elif msg:
+                name = defconfig[:-len('_defconfig')]
+                log = col.build(col.RED, f'ignored: {msg}', bright=True)
+                print(f'{name.ljust(20)} {log}')
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
+    if updated_count:
+        print(col.build(col.BLUE,
+                         f'{updated_count} defconfig(s) updated', bright=True))
+    return progress
+
+
 # pylint: disable=R0903
 class KconfigParser:
     """A parser of .config and include/autoconf.mk."""
@@ -1925,6 +2057,12 @@ def main():
         config_db, progress = do_build_db(args)
         return write_db(config_db, progress)
 
+    if args.force_sync and not args.git_ref:
+        progress = do_sync_defconfigs(args)
+        if args.commit:
+            add_commit(args.configs)
+        return move_done(progress)
+
     config_db, progress = move_config(args)
 
     if args.commit:
-- 
2.43.0

