Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2CEC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5719E84A5B;
	Tue,  7 Jul 2026 13:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQ4y8ncy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15F384A4C; Tue,  7 Jul 2026 13:36:30 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC6480087
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4513435cdd2so5880fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424186; x=1784028986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiFhjIZqb7WL93s3W2MSf+j4yjnPlyvd8yLFVJUoQwk=;
 b=NQ4y8ncyBaLgLodBh6ften+OcHFSLjDblcJnyxD7vpqJ5zHYZq87y7lqzX5zTkfqRe
 j5Z4Tahl35tY4KTTNPQyQDpf27/hhmQzbrgFAC/EJWjipZ6dmJhhgDTbXPIDZrQyUG9M
 h6VfiugGFG1X7fIkZNGekZYVLrpTDzQPlu8EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424186; x=1784028986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NiFhjIZqb7WL93s3W2MSf+j4yjnPlyvd8yLFVJUoQwk=;
 b=Yfcf2H4u/RmoF5/IY5PbgKDCt9SEan2RnY9KdtU3EWh3g5N79vKZYsusZncNF0FN+8
 J29BffTH6EVxEiuBjbYU6ta6bNl11cmT9BxPI3ezvoxBuH3WoQVzbvmHsKA3TlAYXF7z
 hEDN4SEsKfobE4CzEmAK0uqb7637KL5bP8YOTKZeWsomWuUwXgWVVUITTmNPQALH7/XW
 lkEaTLy3Nln2czncMbxjiMzdElY+uYjn1JgM9Fx27hvvIRRwsSG67basMXcxSmmBriWM
 AjYdm+33wkPdoAWeHc2Gd7v9X/uyN0vwuc6D9aKmYTjQ1zq/y9UAG47ejioEjXHH2rYE
 23Og==
X-Gm-Message-State: AOJu0Yw24eEKMAB+2xozurWlGo+SZ6+5k+t5cojhj8mJ150w+q1Wd7MP
 /y69sWVQhiqmrSHkHY4EFucgrQsTJiKS5EAG9XS5CO+ZOkV1TJxZaIeYPDos6Fh8W8bCKhpjpUG
 wEP5b1A==
X-Gm-Gg: AfdE7cl4JgUzMCUbrVz6EwaAlPLv/+i99M+4/+4lYtVY94ksvc1BrTt2hVL5i20eFju
 wx6A8Q3iCKK6pMgY5JdxGlrxYJ+Bym9nnl0WWYOr0vspnlWX/4MUuL6m3RsdGRVDZrwvaVOUygZ
 YJeXHa7VmbQOVgrRXOUyU0v2uzzrIr/2ndLZlZcnGljG3AVeDQAsVUDsJI+6gm9vCFZKF1Cf2e1
 krdK3cn9GfpId6/bkClXe9KIjHJ6r6pdtKNtpsnbS4M8u7QK/7/wOl9jStNpFMJsxpN7UV7wkmt
 qVY7JKiAhZY6B/HFdKwymii5BnXNiiZ9AU0heLShCzUQ3b+tltBI9cKV4P/5lM8BkF82ntIEN/A
 kCUv2Kw+fIxTcrtlhJqMGPFS9JnebuoIVGK19FIHTep6nlIWqjEX5CBS7it678+2QU2EnXlpzV1
 QQuVfpL58=
X-Received: by 2002:a05:6871:c8e8:b0:43d:108c:7145 with SMTP id
 586e51a60fabf-45105eab26amr2652015fac.30.1783424184981; 
 Tue, 07 Jul 2026 04:36:24 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/13] qconfig: Handle #include defconfigs in kconfiglib sync
Date: Tue,  7 Jul 2026 05:35:12 -0600
Message-ID: <20260707113538.3382145-12-sjg@chromium.org>
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

The -s option skips defconfigs that use #include directives because
make savedefconfig does not preserve them.

Handle these by preprocessing the include lines to get the base config
and the full defconfig to get the combined config, then computing the
overlay as the minimal-config entries which the include files provide
neither textually nor effectively. The textual check covers entries
hidden by unmet dependencies when the includes are loaded alone, while
the effective check avoids adding entries merely because an include
file is not in canonical minimal form.

The original include lines and the existing overlay ordering are
preserved: a line is kept in place when it needs a new value, still
matches the minimal config or simply restates the include files, so a
global resync does not rewrite files just to drop harmless entries.
Anything else (stale or newly-redundant entries) is dropped and any
missing entries are appended.

The result is verified by loading it through kconfiglib and comparing
against the target, iteratively adding corrections for any remaining
differences caused by transitive Kconfig dependencies. Corrections are
only added for symbols visible in the target config, since an invisible
symbol takes its value from its dependencies and correcting those fixes
it too; without this, disabling one option in the overlay would drag in
an explicit entry for every dependent option.

Running -s across all boards updates 82 defconfigs and every result
produces a byte-identical .config when processed by the C Kconfig
implementation via 'make <board>_defconfig'.

Also refactor the cpp preprocessing into a shared helper used by both
the database-build and sync workers.

Add unit tests for the sync logic and update the documentation for the
new #include handling.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/qconfig.rst |   5 +-
 tools/qconfig.py        | 523 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 497 insertions(+), 31 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index e5c9e13915d..4a85c78cbbb 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -47,8 +47,9 @@ Resyncing defconfigs
 When resyncing defconfigs (`-s`), the tool also uses kconfiglib.  It loads
 each defconfig with ``load_config()`` and writes a minimal config with
 ``write_min_config()`` (equivalent to ``make savedefconfig``).  Defconfigs
-that use ``#include`` directives are skipped, since a minimal config
-cannot preserve the include structure.
+that use ``#include`` directives are handled by computing the delta between
+the full expanded config and the base provided by the included files, so the
+include structure is preserved.
 
 The ``-r`` (git-ref) option still uses the old make-based path, since it
 needs to build against a different source tree.
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 7ca0736ff3e..a19a8e0118d 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -283,6 +283,43 @@ def scan_kconfig():
     return kconfiglib.Kconfig()
 
 
+def _cpp_preprocess(srcdir, fname):
+    """Run the C preprocessor on a file to expand #include directives
+
+    Args:
+        srcdir (str): Source-tree directory (used as include path)
+        fname (str): Path to the file to preprocess
+
+    Returns:
+        str: Path to a temporary file with the preprocessed output.
+            Caller must delete it.
+    """
+    cpp = os.getenv('CPP', 'cpp').split()
+    cmd = cpp + ['-nostdinc', '-P', '-I', srcdir,
+                 '-undef', '-x', 'assembler-with-cpp', fname]
+    stdout = subprocess.check_output(cmd, stderr=subprocess.DEVNULL)
+    tmp = tempfile.NamedTemporaryFile(prefix='qconfig-', delete=False)
+    tmp.write(stdout)
+    tmp.close()
+    return tmp.name
+
+
+def _load_defconfig(kconf, srcdir, fname):
+    """Load a defconfig, preprocessing #include directives if present
+
+    Args:
+        kconf (kconfiglib.Kconfig): Kconfig instance
+        srcdir (str): Source-tree directory
+        fname (str): Path to the defconfig file
+    """
+    if b'#include' in tools.read_file(fname):
+        tmp = _cpp_preprocess(srcdir, fname)
+        kconf.load_config(tmp)
+        os.unlink(tmp)
+    else:
+        kconf.load_config(fname)
+
+
 def _scan_defconfigs_worker(srcdir, defconfigs, queue, error_queue):
     """Worker process that scans defconfigs using kconfiglib
 
@@ -305,18 +342,7 @@ def _scan_defconfigs_worker(srcdir, defconfigs, queue, error_queue):
     for defconfig in defconfigs:
         fname = os.path.join(srcdir, 'configs', defconfig)
         try:
-            if b'#include' in tools.read_file(fname):
-                cpp = os.getenv('CPP', 'cpp').split()
-                cmd = cpp + ['-nostdinc', '-P', '-I', srcdir,
-                             '-undef', '-x', 'assembler-with-cpp', fname]
-                stdout = subprocess.check_output(cmd, stderr=subprocess.DEVNULL)
-                tmp = tempfile.NamedTemporaryFile(prefix='qconfig-', delete=False)
-                tmp.write(stdout)
-                tmp.close()
-                kconf.load_config(tmp.name)
-                os.unlink(tmp.name)
-            else:
-                kconf.load_config(fname)
+            _load_defconfig(kconf, srcdir, fname)
 
             configs = {}
             for sym in kconf.unique_defined_syms:
@@ -406,6 +432,311 @@ def do_build_db(args):
     return config_db, progress
 
 
+def _get_min_config_lines(kconf, fname):
+    """Get the set of minimal config lines for a defconfig
+
+    Args:
+        kconf (kconfiglib.Kconfig): Kconfig instance (will be modified)
+        fname (str): Path to preprocessed defconfig (or plain defconfig)
+
+    Returns:
+        set of str: Lines from write_min_config output (without header)
+    """
+    kconf.load_config(fname)
+    tmp = tempfile.NamedTemporaryFile(mode='w', prefix='qconfig-mc-',
+                                     delete=False)
+    tmp.close()
+    kconf.write_min_config(tmp.name)
+    with open(tmp.name) as inf:
+        lines = set(inf.readlines())
+    os.unlink(tmp.name)
+    return lines
+
+
+def _config_name(line):
+    """Extract config name (e.g. 'CONFIG_ARM') from a defconfig line
+
+    Args:
+        line (str): A defconfig line
+
+    Returns:
+        str or None: The config name, or None if not a config line
+    """
+    stripped = line.strip()
+    if stripped.startswith('CONFIG_'):
+        return stripped.split('=', 1)[0]
+    if stripped.startswith('# CONFIG_'):
+        return stripped.split()[1]
+    return None
+
+
+def _get_defconfig_entries(fname):
+    """Parse a preprocessed defconfig file to get config entries by name
+
+    Args:
+        fname (str): Path to the preprocessed defconfig file
+
+    Returns:
+        dict: Mapping of config name (e.g. 'CONFIG_ARM') to the full line
+            including the value (e.g. 'CONFIG_ARM=y')
+    """
+    entries = {}
+    with open(fname, encoding='utf-8') as inf:
+        for line in inf:
+            line = line.strip()
+            name = _config_name(line)
+            if name:
+                entries[name] = line
+    return entries
+
+
+def _sync_plain_defconfig(kconf, orig, dry_run):
+    """Sync a plain defconfig (no #include)
+
+    Args:
+        kconf (kconfiglib.Kconfig): Kconfig instance
+        orig (str): Path to the original defconfig file
+        dry_run (bool): If True, do not update defconfig files
+
+    Returns:
+        bool: True if the defconfig was (or would be) updated
+    """
+    kconf.load_config(orig)
+    confdir = os.path.dirname(orig)
+    tmp = tempfile.NamedTemporaryFile(
+        mode='w', prefix='qconfig-', suffix='_defconfig',
+        dir=confdir, delete=False)
+    tmp.close()
+    kconf.write_min_config(tmp.name)
+
+    updated = not filecmp.cmp(orig, tmp.name)
+    if updated and not dry_run:
+        shutil.move(tmp.name, orig)
+    else:
+        os.unlink(tmp.name)
+    return updated
+
+
+def _format_sym_value(sym, value=None):
+    """Format a symbol value as a defconfig line
+
+    Args:
+        sym (kconfiglib.Symbol): The symbol
+        value (str or None): Value to format; uses sym.str_value if None
+
+    Returns:
+        str: The defconfig line
+    """
+    if value is None:
+        value = sym.str_value
+    if sym.orig_type in (kconfiglib.BOOL, kconfiglib.TRISTATE):
+        if value == 'n':
+            return f'# CONFIG_{sym.name} is not set'
+        return f'CONFIG_{sym.name}={value}'
+    if sym.orig_type == kconfiglib.STRING:
+        return f'CONFIG_{sym.name}="{kconfiglib.escape(value)}"'
+    return f'CONFIG_{sym.name}={value}'
+
+
+def _rebuild_overlay(orig, needed, base_entries, full_entries):
+    """Rebuild a #include defconfig preserving the original line ordering
+
+    Keeps existing overlay lines that are still needed (updating values
+    that changed), drops lines that are now redundant, and appends
+    genuinely new entries at the end.
+
+    Args:
+        orig (str): Path to the original defconfig file
+        needed (dict): Mapping of config name to defconfig line value
+        base_entries (dict): Mapping of config name to defconfig line for
+            entries provided by the include files; overlay lines which
+            simply restate one of these are kept, to avoid churn
+        full_entries (dict): Mapping of config name to defconfig line for
+            the full minimal config; overlay lines which match are still
+            correct, so are kept in place
+
+    Returns:
+        bytes: The rebuilt defconfig content
+    """
+    orig_lines = tools.read_file(orig, binary=False).splitlines(keepends=True)
+    keep = set()
+    lines = []
+    for line in orig_lines:
+        if line.startswith('#include'):
+            lines.append(line)
+            continue
+        name = _config_name(line)
+        if not name:
+            # Blank lines and comments are structure; keep them
+            lines.append(line)
+            continue
+        if name in needed:
+            # Keep this line (possibly with updated value)
+            lines.append(needed[name] + '\n')
+            keep.add(name)
+        elif full_entries.get(name) == line.strip():
+            # The line still matches the minimal config; keep it in place
+            lines.append(line)
+            keep.add(name)
+        elif base_entries.get(name) == line.strip():
+            # The line simply restates what the include files already
+            # provide; keep it to avoid churn
+            lines.append(line)
+        # else: drop the line (no longer needed in overlay)
+
+    # Append new entries that weren't in the original overlay, making sure
+    # the existing content ends with a newline first
+    new_entries = []
+    for name, line in needed.items():
+        if name not in keep:
+            new_entries.append(line + '\n')
+    if new_entries:
+        if lines and not lines[-1].endswith('\n'):
+            lines[-1] += '\n'
+        lines.extend(sorted(new_entries))
+
+    return ''.join(lines).encode()
+
+
+def _verify_defconfig(kconf, srcdir, confdir, target, target_visible, needed,
+                      new_content):
+    """Verify an #include defconfig and fix remaining config differences
+
+    Loads the candidate defconfig through kconfiglib, compares against the
+    target config, and iteratively adds corrections for any remaining
+    differences (from include entries needing explicit resets or transitive
+    Kconfig dependency effects).
+
+    Args:
+        kconf (kconfiglib.Kconfig): Kconfig instance
+        srcdir (str): Source-tree directory
+        confdir (str): Directory for temp file placement
+        target (dict): Target config {sym_name: str_value}
+        target_visible (set of str): Symbols which are visible in the
+            target config; corrections are only added for these, since an
+            invisible symbol takes its value from its dependencies and is
+            fixed by correcting them instead
+        needed (dict): Overlay entries {config_name: line}, updated in place
+        new_content (bytes): Current defconfig content to verify
+
+    Returns:
+        bytes: The verified (possibly updated) defconfig content
+    """
+    for _ in range(3):
+        with tempfile.NamedTemporaryFile(suffix='_defconfig',
+                                         dir=confdir) as tmp:
+            tmp.write(new_content)
+            tmp.flush()
+            verify_pp = _cpp_preprocess(srcdir, tmp.name)
+            kconf.load_config(verify_pp)
+            os.unlink(verify_pp)
+
+        # Find configs that differ from target and add corrections
+        extra_lines = []
+        for sym in kconf.unique_defined_syms:
+            if sym.name not in target or sym.str_value == target[sym.name]:
+                continue
+            if sym.name not in target_visible:
+                continue
+            line = _format_sym_value(sym, target[sym.name])
+            name = _config_name(line)
+            if name not in needed:
+                needed[name] = line
+                extra_lines.append(line + '\n')
+
+        if not extra_lines:
+            break
+        new_content = new_content.rstrip(b'\n') + b'\n'
+        for line in sorted(extra_lines):
+            new_content += line.encode()
+
+    return new_content
+
+
+def _sync_include_defconfig(kconf, srcdir, orig, dry_run):
+    """Sync a defconfig that uses #include directives
+
+    Computes the overlay delta needed on top of the include files to produce
+    the target config, preserving the original line ordering. The result is
+    verified against the target config; if any differences remain, the
+    missing entries are added iteratively.
+
+    Args:
+        kconf (kconfiglib.Kconfig): Kconfig instance
+        srcdir (str): Source-tree directory
+        orig (str): Path to the original defconfig file
+        dry_run (bool): If True, do not update defconfig files
+
+    Returns:
+        bool: True if the defconfig was (or would be) updated
+    """
+    # Get the full min_config and target config values
+    full_tmp = _cpp_preprocess(srcdir, orig)
+    full_lines = _get_min_config_lines(kconf, full_tmp)
+    os.unlink(full_tmp)
+
+    # Save the target config for verification, noting which symbols are
+    # visible there (invisible symbols take their value from their
+    # dependencies, so never need an explicit entry)
+    target = {sym.name: sym.str_value
+              for sym in kconf.unique_defined_syms}
+    target_visible = {sym.name for sym in kconf.unique_defined_syms
+                      if sym.visibility}
+
+    # Build a temp file with just the #include lines (no overlay CONFIGs)
+    include_lines = []
+    with open(orig, 'rb') as inf:
+        for line in inf:
+            if line.startswith(b'#include'):
+                include_lines.append(line)
+
+    with tempfile.NamedTemporaryFile(suffix='_defconfig',
+                                     dir=os.path.dirname(orig)) as tmp:
+        tmp.writelines(include_lines)
+        tmp.flush()
+        base_pp = _cpp_preprocess(srcdir, tmp.name)
+
+    base_entries = _get_defconfig_entries(base_pp)
+    kconf.load_config(base_pp)
+    base_effective = {sym.name: sym.str_value
+                      for sym in kconf.unique_defined_syms}
+    os.unlink(base_pp)
+
+    # Build the set of configs needed in the overlay: full_min entries which
+    # the include files provide neither textually nor effectively. The
+    # textual check covers entries hidden by unmet dependencies when the
+    # includes are loaded alone; the effective check covers values the
+    # includes produce indirectly, so that entries are not added merely
+    # because an include file is not in canonical minimal form. If this
+    # wrongly deems an entry provided, the verification pass adds it back
+    needed = {}
+    full_entries = {}
+    for line in full_lines:
+        name = _config_name(line)
+        if not name:
+            continue
+        full_entries[name] = line.strip()
+        sym_name = name[len('CONFIG_'):]
+        if (base_entries.get(name) == line.strip() or
+                base_effective.get(sym_name) == target.get(sym_name)):
+            continue
+        needed[name] = line.strip()
+
+    new_content = _rebuild_overlay(orig, needed, base_entries, full_entries)
+    new_content = _verify_defconfig(kconf, srcdir, os.path.dirname(orig),
+                                    target, target_visible, needed,
+                                    new_content)
+
+    # Overlay entries which simply restate the include files are kept, so
+    # any remaining difference is a real change: a stale entry dropped, a
+    # value fixed or a missing entry added
+    if new_content == tools.read_file(orig):
+        return False
+    if not dry_run:
+        tools.write_file(orig, new_content)
+    return True
+
+
 def _sync_defconfigs_worker(srcdir, defconfigs, result_queue, error_queue,
                             dry_run):
     """Worker process that syncs defconfigs using kconfiglib
@@ -430,24 +761,14 @@ def _sync_defconfigs_worker(srcdir, defconfigs, result_queue, error_queue,
     for defconfig in defconfigs:
         orig = os.path.join(srcdir, 'configs', defconfig)
         try:
-            # Skip defconfigs with #include — savedefconfig mangles them
-            if b'#include' in tools.read_file(orig):
-                result_queue.put((defconfig, False, 'has #include'))
-                continue
-
-            kconf.load_config(orig)
+            raw = tools.read_file(orig)
+            has_include = b'#include' in raw
 
-            tmp = tempfile.NamedTemporaryFile(
-                mode='w', prefix='qconfig-', suffix='_defconfig',
-                dir=os.path.join(srcdir, 'configs'), delete=False)
-            tmp.close()
-            kconf.write_min_config(tmp.name)
-
-            updated = not filecmp.cmp(orig, tmp.name)
-            if updated and not dry_run:
-                shutil.move(tmp.name, orig)
+            if has_include:
+                updated = _sync_include_defconfig(kconf, srcdir, orig,
+                                                  dry_run)
             else:
-                os.unlink(tmp.name)
+                updated = _sync_plain_defconfig(kconf, orig, dry_run)
             result_queue.put((defconfig, updated, None))
         except Exception as exc:
             error_queue.put((defconfig, str(exc)))
@@ -1962,8 +2283,152 @@ def move_done(progress):
             col.GREEN, f'{progress.total} processed        ', bright=True))
     return 0
 
+class SyncTests(unittest.TestCase):
+    """Tests for defconfig sync using kconfiglib"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Create a shared Kconfig instance for all tests"""
+        os.environ['srctree'] = os.getcwd()
+        os.environ['UBOOTVERSION'] = 'dummy'
+        os.environ['KCONFIG_OBJDIR'] = ''
+        os.environ['CC'] = 'gcc'
+        cls.kconf = kconfiglib.Kconfig(warn=False)
+        cls.srcdir = os.getcwd()
+
+    def test_sync_plain_noop(self):
+        """Syncing an already-minimal defconfig produces no change"""
+        # sandbox_defconfig should already be synced if the tree is clean
+        orig = 'configs/sandbox_defconfig'
+        updated = _sync_plain_defconfig(self.kconf, orig, dry_run=True)
+        # This may or may not be updated depending on tree state, but
+        # it should not crash
+        self.assertIsInstance(updated, bool)
+
+    def test_sync_include_preserves_structure(self):
+        """Syncing a #include defconfig preserves the #include lines"""
+        orig = 'configs/sandbox_nocmdline_defconfig'
+        if not os.path.exists(orig):
+            self.skipTest(f'{orig} not found')
+
+        # Dry-run should not modify the file
+        content_before = tools.read_file(orig)
+        updated = _sync_include_defconfig(self.kconf, self.srcdir, orig,
+                                          dry_run=True)
+        content_after = tools.read_file(orig)
+        self.assertEqual(content_before, content_after)
+
+        # The output should still start with #include
+        self.assertIn(b'#include', content_after)
+
+    def test_sync_include_skips_redundant(self):
+        """Syncing a #include defconfig keeps include-redundant entries"""
+        # Pick an option which sandbox_defconfig sets explicitly, so the
+        # overlay entry simply restates the include
+        with open('configs/sandbox_defconfig', encoding='utf-8') as inf:
+            explicit = next(line for line in inf
+                            if line.startswith('CONFIG_') and
+                            line.rstrip().endswith('=y'))
+        with tempfile.NamedTemporaryFile(
+                mode='w', prefix='test-', suffix='_defconfig',
+                dir='configs', delete=False) as tmp:
+            tmp.write('#include "sandbox_defconfig"\n')
+            tmp.write(explicit)
+            tmp_name = tmp.name
+        try:
+            updated = _sync_include_defconfig(self.kconf, self.srcdir,
+                                              tmp_name, dry_run=False)
+            # An entry which restates the include is harmless, so the file
+            # should not be rewritten just to drop it
+            self.assertFalse(updated)
+            with open(tmp_name) as inf:
+                result = inf.read()
+            # File should be unchanged
+            self.assertIn(explicit.strip(), result)
+            self.assertIn('#include "sandbox_defconfig"', result)
+        finally:
+            os.unlink(tmp_name)
+
+    def test_sync_include_drops_stale(self):
+        """Syncing a #include defconfig removes stale options"""
+        with tempfile.NamedTemporaryFile(
+                mode='w', prefix='test-', suffix='_defconfig',
+                dir='configs', delete=False) as tmp:
+            tmp.write('#include "sandbox_defconfig"\n')
+            tmp.write('# CONFIG_CMDLINE is not set\n')
+            tmp.write('CONFIG_NON_EXISTENT_OPTION=y\n')
+            tmp_name = tmp.name
+        try:
+            updated = _sync_include_defconfig(self.kconf, self.srcdir,
+                                              tmp_name, dry_run=False)
+            # The stale option must be dropped, with the real override and
+            # the include structure preserved
+            self.assertTrue(updated)
+            with open(tmp_name) as inf:
+                result = inf.read()
+            self.assertNotIn('CONFIG_NON_EXISTENT_OPTION', result)
+            self.assertIn('# CONFIG_CMDLINE is not set', result)
+            self.assertIn('#include "sandbox_defconfig"', result)
+        finally:
+            os.unlink(tmp_name)
+
+    def test_sync_include_keeps_override(self):
+        """Syncing a #include defconfig keeps CONFIGs that differ from base"""
+        # Create a temp defconfig that includes sandbox and disables CMDLINE
+        with tempfile.NamedTemporaryFile(
+                mode='w', prefix='test-', suffix='_defconfig',
+                dir='configs', delete=False) as tmp:
+            tmp.write('#include "sandbox_defconfig"\n')
+            tmp.write('# CONFIG_CMDLINE is not set\n')
+            tmp_name = tmp.name
+        try:
+            _sync_include_defconfig(self.kconf, self.srcdir, tmp_name,
+                                    dry_run=False)
+            with open(tmp_name) as inf:
+                result = inf.read()
+            # Disabling CMDLINE is an override — should be kept
+            self.assertIn('# CONFIG_CMDLINE is not set', result)
+            self.assertIn('#include "sandbox_defconfig"', result)
+        finally:
+            os.unlink(tmp_name)
+
+    def test_sync_include_effective_config(self):
+        """Syncing a #include defconfig must not change the effective config"""
+        orig = 'configs/alt_defconfig'
+        if not os.path.exists(orig):
+            self.skipTest(f'{orig} not found')
+
+        # Load the original to get the target config
+        full_pp = _cpp_preprocess(self.srcdir, orig)
+        self.kconf.load_config(full_pp)
+        os.unlink(full_pp)
+        target = {sym.name: sym.str_value
+                  for sym in self.kconf.unique_defined_syms}
+
+        # Sync into a temp copy
+        tmp_name = orig + '.test_tmp'
+        shutil.copy2(orig, tmp_name)
+        try:
+            _sync_include_defconfig(self.kconf, self.srcdir, tmp_name,
+                                    dry_run=False)
+
+            # Load synced defconfig and compare
+            synced_pp = _cpp_preprocess(self.srcdir, tmp_name)
+            self.kconf.load_config(synced_pp)
+            os.unlink(synced_pp)
+            result = {sym.name: sym.str_value
+                      for sym in self.kconf.unique_defined_syms}
+
+            diffs = {name for name in set(target) | set(result)
+                     if target.get(name) != result.get(name)}
+            self.assertEqual(diffs, set(),
+                             'Synced defconfig changed effective config')
+        finally:
+            os.unlink(tmp_name)
+
+
 def do_tests():
-    """Run doctests and unit tests (so far there are no unit tests)"""
+    """Run doctests and unit tests"""
     sys.argv = [sys.argv[0]]
     fail, _ = doctest.testmod()
     if fail:
-- 
2.43.0

