Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CEECD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1888490D;
	Tue, 26 May 2026 00:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FADlN6J7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C3C8490D; Tue, 26 May 2026 00:26:59 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793AC8490D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-4855003fa6cso2292560b6e.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779748015; x=1780352815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYGkWRmzAu3eaqGGoFJOGIQ387j+nVWqsllSesgtyzI=;
 b=FADlN6J7DARZGvmovJEkX3wGM/cJWpwhcakqlQc/gHVxev//92xDJJzPUZXvfDAyef
 p/r+PRXGcs0fwBSHQ6DafmKVpeTlT8ZH18BVeJCl2kX4WKnVtiDzQEiPnGolUX+bk3jq
 yv5mo7DCSGuUGvt3P9dCOVR++c8s+/k9oceec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779748015; x=1780352815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iYGkWRmzAu3eaqGGoFJOGIQ387j+nVWqsllSesgtyzI=;
 b=MiM2sgAjlCS/eEQV1iVISdSxt7VxlSDsH0T3f6QduyBx99Zy5nO62SjKRjsaZuRGZx
 Xn+afsD18kkABeFYru7bISwX/NBoQB9Ib0FnR9MD54hF8r9iylvxQTZxtMIcOKm75fSW
 8TTtj6ARLvxIemA6ytT5JPYavKO6Gw0VUSfYAq5SdMQBh5MaMmIyvzn6KTHiKtsaT0+8
 FVUHTncnt0ZfzDxF1lNxy2ikzV+pWbk9Rd1o8A5Svy3IQEwF5njvBrcZXCIokxtagaSr
 ym3NQvTFZA6YZltW8KrNHHIu6YDPCZxuU6tutv0/jv8JHy7QSVA8g425Es38TxAGZWBS
 SsYQ==
X-Gm-Message-State: AOJu0YxH78qD9IgWw5axLfqgr/XnfmpvwNoQ7sFbPMCT3p6xPjEPkxIL
 1xTlZgmuNSOEAJW8RbotNCfu2tied9qADCD3GsbqLjs2JfgtdIVAtG7eDunwFSrWZAVvVBZk2Cc
 lX9Ll/2ZnYSw=
X-Gm-Gg: Acq92OEhRQWqN5Es2kdCbJ68oRLuCI2ydrZAzedSRtH40TL7kpqO1wFETBCb225jkUb
 dKHRo0Y7ri4nnu0JBoCE7kd886DJMDjEzJqeofvVrYp0k8VjASHvXhnO55E37YPOwFwcMWUt18N
 VkkKI2G5cR4Mor9hBzUv6iF/Vtnr5zpVjbpw5c60hmCHWNt0APTD3ihD3iZH1tr49Mn0z7KZ2jE
 WWiYC0NMVQMSxW8sGvkREMT0DXyH2bqkZwIb3JEIke5Q1c0dWY65DLvWkbM3haRHf+7WkBsjD74
 K3dj9lhxQwbjiBMxSOVPYtlnlaGGMqpckCqQHnIZ9rUGauhU2nV6DaX1ZN8coEXmuWj5RsFF4oL
 YSVmQdT7sVzy8kM+Jp9BlBcf3eaVjjrfWYADOgBPySmQps9gP3zpJOKsle01UnMj7u3bwuslQGs
 f2NZSBRX6oh+liYddd5g==
X-Received: by 2002:a05:6808:4f6b:b0:467:268d:31cc with SMTP id
 5614622812f47-4854a169876mr11023631b6e.26.1779748015107; 
 Mon, 25 May 2026 15:26:55 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63512d63sm11169468fac.2.2026.05.25.15.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:26:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 2/2] check_linker_lists: Enhance detection of alignment
 problems
Date: Mon, 25 May 2026 16:26:32 -0600
Message-ID: <20260525222637.2962284-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525222637.2962284-1-sjg@chromium.org>
References: <20260525222637.2962284-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

When linker-inserted padding breaks list integrity, pointer arithmetic
like (end - start) / sizeof(struct) produces garbage. GCC optimizes
division by constants using multiplicative inverses, which only works
when the dividend is an exact multiple. With padding, outputs like
"Running -858993444 bloblist tests" appear instead of the correct count.

Enhance the linker list checking script to detect these problems by
adding symbol size tracking using nm -S. This enables:

1. Padding detection: Compare symbol sizes to gaps. If gap > size,
   padding was inserted, breaking contiguous array assumptions.

2. Pointer arithmetic bugs: Check if (end - start) marker span is a
   multiple of struct size.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 scripts/check_linker_lists.py | 127 +++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 25 deletions(-)

diff --git a/scripts/check_linker_lists.py b/scripts/check_linker_lists.py
index 46ff4465989..30183a14dc7 100755
--- a/scripts/check_linker_lists.py
+++ b/scripts/check_linker_lists.py
@@ -15,7 +15,8 @@ Exit Codes:
   0: Success - no alignment problems were found
   1: Usage Error - the script was not called with the correct arguments
   2: Execution Error - failed to run 'nm' or the ELF file was not found
-  3: Problem Found - an inconsistent gap was detected in at least one list
+  3: Problem Found - inconsistent gap, padding, or pointer-arithmetic
+                     mismatch detected in at least one list
 """
 
 import sys
@@ -25,8 +26,15 @@ import argparse
 from statistics import mode
 from collections import defaultdict, namedtuple
 
+# Information about a symbol: address, size (from nm -S), and name
+Symbol = namedtuple('Symbol', ['address', 'size', 'name'])
+
 # Information about the gap between two consecutive symbols
-Gap = namedtuple('Gap', ['gap', 'prev_sym', 'next_sym'])
+Gap = namedtuple('Gap', ['gap', 'prev_sym', 'next_sym', 'prev_size'])
+
+# Start and end marker addresses for a list
+Markers = namedtuple('Markers', ['start', 'end'])
+
 # Holds all the analysis results from checking the lists
 Results = namedtuple('Results', [
     'total_problems', 'total_symbols', 'all_lines', 'max_name_len',
@@ -41,18 +49,26 @@ SIZE_COL = 17
 # Matches a list entry symbol (the '_2_' infix marks the actual list elements,
 # as opposed to the '_1' start and '_3' end markers).
 ENTRY_PATTERN = re.compile(r'^_u_boot_list_\d+_(?P<base_name>\w+)_2_')
+# Matches the start ('_1') and end ('_3') markers of a list. The regex on its
+# own is ambiguous: an entry whose user-chosen name ends in '_1' or '_3' (e.g.
+# '_u_boot_list_2_driver_2_foo_1') is also accepted, with '_2_foo' folded into
+# base_name. Callers must reject any match whose base_name contains '_2_'
+# (see run_nm_and_get_lists()) — real list names never do.
+MARKER_PATTERN = re.compile(
+    r'^_u_boot_list_\d+_(?P<base_name>\w+)_(?P<marker>[13])$')
 
 def eprint(*args, **kwargs):
     """Print to stderr"""
     print(*args, file=sys.stderr, **kwargs)
 
-def check_single_list(name, symbols, max_name_len):
+def check_single_list(name, symbols, max_name_len, marker_info=None):
     """Check alignment for a single list and return its findings
 
     Args:
         name (str): The cleaned-up name of the list for display
-        symbols (list): A list of (address, name) tuples, sorted by address
+        symbols (list): A list of Symbol tuples, sorted by address
         max_name_len (int): The max length of list names for column formatting
+        marker_info (Markers): Optional namedtuple with start and end addresses
 
     Returns:
         tuple: (problem_count, list_of_output_lines)
@@ -62,9 +78,9 @@ def check_single_list(name, symbols, max_name_len):
 
     gaps = []
     for i in range(len(symbols) - 1):
-        addr1, name1 = symbols[i]
-        addr2, name2 = symbols[i + 1]
-        gaps.append(Gap(gap=addr2 - addr1, prev_sym=name1, next_sym=name2))
+        sym1, sym2 = symbols[i], symbols[i + 1]
+        gaps.append(Gap(gap=sym2.address - sym1.address, prev_sym=sym1.name,
+                        next_sym=sym2.name, prev_size=sym1.size))
 
     expected_gap = mode(g.gap for g in gaps)
     lines = [f'{name:<{max_name_len + NAME_PAD}}  {len(symbols):>{SYM_COL}}  '
@@ -76,19 +92,42 @@ def check_single_list(name, symbols, max_name_len):
             problem_count += 1
             lines.append(
                 f'  - Bad gap (0x{g.gap:x}) before symbol: {g.next_sym}')
+        elif g.prev_size and g.gap > g.prev_size:
+            # Gap is larger than symbol size - padding was inserted
+            problem_count += 1
+            lines.append(
+                f'  - Padding: gap 0x{g.gap:x} > size 0x{g.prev_size:x}'
+                f' before: {g.next_sym}')
+
+    # Check if start/end marker span is a multiple of the struct size. If not,
+    # pointer subtraction (end - start) will produce wrong results due to
+    # compiler optimisation using magic-number multiplication. Skip when
+    # expected_gap is zero to avoid ZeroDivisionError on degenerate input
+    # (two list entries sharing an address).
+    if marker_info and expected_gap:
+        total_span = marker_info.end - marker_info.start
+        remainder = total_span % expected_gap
+        if remainder:
+            problem_count += 1
+            lines.append(
+                f'  - Pointer arithmetic bug: span 0x{total_span:x} is not a '
+                f'multiple of struct size 0x{expected_gap:x} '
+                f'(remainder: {remainder})')
 
     return problem_count, lines
 
 def run_nm_and_get_lists(elf_path):
-    """Run 'nm' and parse the output to discover all linker lists
+    """Run 'nm -S' and parse the output to discover all linker lists
 
     Args:
         elf_path (str): The path to the ELF file to process
 
     Returns:
-        dict or None: A dictionary of discovered lists, or None on error
+        tuple or None: (lists_dict, markers_dict) or None on error
+            lists_dict: entries keyed by base_name
+            markers_dict: start/end marker addresses keyed by base_name
     """
-    cmd = ['nm', '-n', elf_path]
+    cmd = ['nm', '-S', '-n', elf_path]
     try:
         proc = subprocess.run(cmd, capture_output=True, text=True, check=True)
     except FileNotFoundError:
@@ -103,29 +142,57 @@ def run_nm_and_get_lists(elf_path):
         return None
 
     lists = defaultdict(list)
+    markers = defaultdict(dict)  # {base_name: {'start': addr, 'end': addr}}
+
     for line in proc.stdout.splitlines():
         if '_u_boot_list_' not in line:
             continue
         try:
+            # 'nm -S' formats: '<addr> <size> <type> <name>' for sized symbols
+            # and '<addr> <type> <name>' for unsized (e.g. linker-defined
+            # start/end markers). Size defaults to 0 when absent.
             parts = line.strip().split()
-            address, name = int(parts[0], 16), parts[-1]
+            address = int(parts[0], 16)
+            name = parts[-1]
+            size = int(parts[1], 16) if len(parts) == 4 else 0
+
             match = ENTRY_PATTERN.match(name)
             if match:
-                lists[match.group('base_name')].append((address, name))
+                lists[match.group('base_name')].append(
+                    Symbol(address, size, name))
+                continue
+
+            # Reject marker matches where '_2_' leaked into base_name; those
+            # are entries the regex accepted via backtracking (see comment on
+            # MARKER_PATTERN). Real list names never contain '_2_'.
+            match = MARKER_PATTERN.match(name)
+            if match and '_2_' not in match.group('base_name'):
+                base_name = match.group('base_name')
+                key = 'start' if match.group('marker') == '1' else 'end'
+                markers[base_name][key] = address
         except (ValueError, IndexError):
             eprint(f'Warning: Could not parse line: {line}')
 
-    return lists
+    # Convert marker dicts to Markers namedtuples (only if both start/end exist)
+    marker_tuples = {n: Markers(m['start'], m['end'])
+                     for n, m in markers.items()
+                     if 'start' in m and 'end' in m}
 
-def collect_data(lists):
+    return lists, marker_tuples
+
+def collect_data(lists, markers):
     """Collect alignment check data for all lists
 
     Args:
         lists (dict): A dictionary of lists and their symbols
+        markers (dict): A dictionary of start/end marker addresses per list
 
     Returns:
         Results: A namedtuple containing the analysis results
     """
+    if markers is None:
+        markers = {}
+
     max_name_len = max((len(n) for n in lists), default=0)
 
     total_problems = 0
@@ -134,8 +201,8 @@ def collect_data(lists):
     for list_name in sorted(lists):
         symbols = lists[list_name]
         total_symbols += len(symbols)
-        problem_count, lines = check_single_list(list_name, symbols,
-                                                 max_name_len)
+        problem_count, lines = check_single_list(
+            list_name, symbols, max_name_len, markers.get(list_name))
         total_problems += problem_count
         all_lines.extend(lines)
 
@@ -177,13 +244,22 @@ def main():
     """Main entry point of the script, returns an exit code"""
     epilog_text = '''
 Auto-discover all linker-generated lists in a U-Boot ELF file
-(e.g., for drivers, commands, etc.) and verify their integrity. Check
-that all elements in a given list are separated by a consistent number of
-bytes.
+(e.g., for drivers, commands, etc.) and verify their integrity.
+
+Problems detected (cause build failure):
+
+1. Inconsistent gaps: Elements in a list should all be separated by the same
+   number of bytes (the struct size). If the linker inserts padding between
+   some elements but not others, this is detected and reported.
+
+2. Padding detection: Using symbol sizes from nm -S, the script compares each
+   symbol's size to the gap after it. If gap > size, the linker inserted
+   padding, which breaks U-Boot's assumption that the list is a contiguous
+   array of same-sized structs.
 
-Problems typically indicate that the linker has inserted alignment padding
-between two elements in a list, which can break U-Boot's assumption that the
-list is a simple, contiguous array of same-sized structs.
+3. Pointer arithmetic bugs: Each list has start (_1) and end (_3) markers.
+   If the span (end - start) is not a multiple of struct size, pointer
+   subtraction produces garbage due to GCC's magic-number division.
 '''
     parser = argparse.ArgumentParser(
         description='Check alignment of U-Boot linker lists in an ELF file.',
@@ -197,16 +273,17 @@ list is a simple, contiguous array of same-sized structs.
 
     args = parser.parse_args()
 
-    lists = run_nm_and_get_lists(args.elf_path)
-    if lists is None:
+    result = run_nm_and_get_lists(args.elf_path)
+    if result is None:
         return 2  # Error running nm
 
+    lists, markers = result
     if not lists:
         if args.verbose:
             eprint('Success: No U-Boot linker lists found to check')
         return 0
 
-    results = collect_data(lists)
+    results = collect_data(lists, markers)
     show_output(results, args.verbose)
 
     return 3 if results.total_problems > 0 else 0
-- 
2.43.0

