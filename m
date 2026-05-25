Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D10CD5BC8
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D60FF8490A;
	Tue, 26 May 2026 00:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bz/mKyyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6787C8491C; Tue, 26 May 2026 00:26:57 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD4984903
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcd689829eso8307950a34.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779748013; x=1780352813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSzuDtr1bYOnRHt88iA3nV1DcceZUEQOF93LBCJWboM=;
 b=bz/mKyyTg8G/T5Tx+gIPeUqschCDYO1GKulJYnId4bycM81o7xI6C7YQ193MimK0OK
 qkmq7vnHwlMvCE8EleBeROGx4Tgs7jUihL179j3kovRQzzpMgrCP4ZwFBEdcK5wJDOA5
 Cxk9haQ/EjDN3wLacnm39B3Eucu1/qWlEJKYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779748013; x=1780352813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KSzuDtr1bYOnRHt88iA3nV1DcceZUEQOF93LBCJWboM=;
 b=LT1UqpOw0a/OPumruPgdTXtfjtdap09IIbIU466TxgUwnjG4N/uPERuQ25Vck0ywUU
 BQQAoz/oMP0ANrR2rGKH8L4kQNeUEydQVeVAx04bn6nMDNzc7j+8XR4ewPcXEjf2K0rz
 lj6Q3dm2w3lofUDB/GTkxsLpcaue5BNFXBOf+xf2SFqwwlfKR4f6V8IUuChC088sev25
 UNEPyfNEr1bQ7OhPg06MY1Uef00p/yGSj0ARonvm6nb5RLnDrEk2DrW8axI7+5q2eQ0s
 TVzRf2dliJq7kCHXg5yFmjhaNWBuRIyGrrr4UrKwe+/eL4O+k0w20CfKiWDscEaF1GC8
 XFUw==
X-Gm-Message-State: AOJu0Yxh73+TBlcZmO5/x5ZwX+4gepq8uEFb2wMJSB3zZn/UDCAZgTLJ
 hI8JRM3BSr+0yFp1ZDSfRIpOZhcCyAtwsGMf1rb5Uki1GzDZLk+q3Q/GdCBt0dwXEeAicKLS/fn
 hnYU8IoQ2
X-Gm-Gg: Acq92OHEtAKG7seXLal1fR3lvVf8m8gxSsWb618bxGlQz1IIxYTvCKcwRsp18cSkIaN
 DcUg0D50ctNRulNG7+2TKw0IKeh40m/RviCPFHNi70NA87X0JMlvOkyftf7QhoulAYOaCHXoZJS
 9gs9S4Cv7O7yQ/wv/WMeS0YM8My1rJv2hux5CouHp9D2/SakGdsdlEMTMPlsq1uPe4tOFcTtktP
 XA+4MbjIEZ8Jn/QRz5u/tbe8gRvHbpxT4ASpbGfyowJNWKWy1s3U9Twf6ij/+/zoYg+ddmr+VJJ
 1tFmyhN4XRtuj8tUyM7mpLSx3h02xbwiBrO32Hi/EwNQuCGUPfWZQC6YpSpNLG2ada6lx05hKxq
 4AinOVfpqkGPDv6hscr/X5eYdIo5usQfkGUsCh/Lx/6qTxNewMNtuoEbbhhEi6Y+E5LnXxcfwrU
 xdj2Obw9+ZQMOmjlFNPA==
X-Received: by 2002:a05:6820:1612:b0:68a:116a:a5e5 with SMTP id
 006d021491bc7-69d7ec85536mr9177249eaf.44.1779748013430; 
 Mon, 25 May 2026 15:26:53 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63512d63sm11169468fac.2.2026.05.25.15.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:26:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Simon Glass <simon.glass@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: [RFC PATCH 1/2] scripts: Add a script check consistency of linker
 lists
Date: Mon, 25 May 2026 16:26:31 -0600
Message-ID: <20260525222637.2962284-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525222637.2962284-1-sjg@chromium.org>
References: <20260525222637.2962284-1-sjg@chromium.org>
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

If linker lists have inconsistent alignment it can cause strange
runtime errors. Add a script that can detect and report these problems.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 Makefile                      |   5 +
 scripts/check_linker_lists.py | 215 ++++++++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+)
 create mode 100755 scripts/check_linker_lists.py

diff --git a/Makefile b/Makefile
index f07faada3d5..fe8df271c38 100644
--- a/Makefile
+++ b/Makefile
@@ -1389,6 +1389,10 @@ define deprecated
 
 endef
 
+# Check linker lists are consistent
+quiet_cmd_llcheck = LLCHK   $2
+cmd_llcheck = $(srctree)/scripts/check_linker_lists.py $2
+
 # Timestamp file to make sure that binman always runs
 .binman_stamp: $(INPUTS-y) FORCE
 ifeq ($(CONFIG_BINMAN),y)
@@ -2114,6 +2118,7 @@ ifeq ($(CONFIG_KALLSYMS),y)
 	$(call cmd,smap)
 	$(call cmd,u-boot__) common/system_map.o
 endif
+	$(call cmd,llcheck,u-boot)
 
 ifeq ($(CONFIG_RISCV),y)
 	@tools/prelink-riscv $@
diff --git a/scripts/check_linker_lists.py b/scripts/check_linker_lists.py
new file mode 100755
index 00000000000..46ff4465989
--- /dev/null
+++ b/scripts/check_linker_lists.py
@@ -0,0 +1,215 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+"""Check alignment of U-Boot linker lists.
+
+Auto-discover and verify the uniform spacing of all U-Boot linker list symbols.
+
+Analyze the symbol table of a U-Boot ELF file to ensure that all entries in all
+linker-generated lists are separated by a consistent number of bytes. Detect
+problems caused by linker-inserted alignment padding.
+
+By default, produce no output if no problems are found.
+Use the -v flag to force output even on success.
+
+Exit Codes:
+  0: Success - no alignment problems were found
+  1: Usage Error - the script was not called with the correct arguments
+  2: Execution Error - failed to run 'nm' or the ELF file was not found
+  3: Problem Found - an inconsistent gap was detected in at least one list
+"""
+
+import sys
+import subprocess
+import re
+import argparse
+from statistics import mode
+from collections import defaultdict, namedtuple
+
+# Information about the gap between two consecutive symbols
+Gap = namedtuple('Gap', ['gap', 'prev_sym', 'next_sym'])
+# Holds all the analysis results from checking the lists
+Results = namedtuple('Results', [
+    'total_problems', 'total_symbols', 'all_lines', 'max_name_len',
+    'list_count'])
+
+# Column widths used by the report. NAME_PAD is added to the longest list name
+# to leave a small gutter before the next column.
+NAME_PAD = 2
+SYM_COL = 12
+SIZE_COL = 17
+
+# Matches a list entry symbol (the '_2_' infix marks the actual list elements,
+# as opposed to the '_1' start and '_3' end markers).
+ENTRY_PATTERN = re.compile(r'^_u_boot_list_\d+_(?P<base_name>\w+)_2_')
+
+def eprint(*args, **kwargs):
+    """Print to stderr"""
+    print(*args, file=sys.stderr, **kwargs)
+
+def check_single_list(name, symbols, max_name_len):
+    """Check alignment for a single list and return its findings
+
+    Args:
+        name (str): The cleaned-up name of the list for display
+        symbols (list): A list of (address, name) tuples, sorted by address
+        max_name_len (int): The max length of list names for column formatting
+
+    Returns:
+        tuple: (problem_count, list_of_output_lines)
+    """
+    if len(symbols) < 2:
+        return 0, []
+
+    gaps = []
+    for i in range(len(symbols) - 1):
+        addr1, name1 = symbols[i]
+        addr2, name2 = symbols[i + 1]
+        gaps.append(Gap(gap=addr2 - addr1, prev_sym=name1, next_sym=name2))
+
+    expected_gap = mode(g.gap for g in gaps)
+    lines = [f'{name:<{max_name_len + NAME_PAD}}  {len(symbols):>{SYM_COL}}  '
+             f'{f"0x{expected_gap:x}":>{SIZE_COL}}']
+
+    problem_count = 0
+    for g in gaps:
+        if g.gap != expected_gap:
+            problem_count += 1
+            lines.append(
+                f'  - Bad gap (0x{g.gap:x}) before symbol: {g.next_sym}')
+
+    return problem_count, lines
+
+def run_nm_and_get_lists(elf_path):
+    """Run 'nm' and parse the output to discover all linker lists
+
+    Args:
+        elf_path (str): The path to the ELF file to process
+
+    Returns:
+        dict or None: A dictionary of discovered lists, or None on error
+    """
+    cmd = ['nm', '-n', elf_path]
+    try:
+        proc = subprocess.run(cmd, capture_output=True, text=True, check=True)
+    except FileNotFoundError:
+        eprint(
+            "Error: The 'nm' command was not found. "
+            'Please ensure binutils is installed')
+        return None
+    except subprocess.CalledProcessError as e:
+        eprint(
+            f"Error: Failed to execute 'nm' on '{elf_path}'.\n"
+            f'  Return Code: {e.returncode}\n  Stderr:\n{e.stderr}')
+        return None
+
+    lists = defaultdict(list)
+    for line in proc.stdout.splitlines():
+        if '_u_boot_list_' not in line:
+            continue
+        try:
+            parts = line.strip().split()
+            address, name = int(parts[0], 16), parts[-1]
+            match = ENTRY_PATTERN.match(name)
+            if match:
+                lists[match.group('base_name')].append((address, name))
+        except (ValueError, IndexError):
+            eprint(f'Warning: Could not parse line: {line}')
+
+    return lists
+
+def collect_data(lists):
+    """Collect alignment check data for all lists
+
+    Args:
+        lists (dict): A dictionary of lists and their symbols
+
+    Returns:
+        Results: A namedtuple containing the analysis results
+    """
+    max_name_len = max((len(n) for n in lists), default=0)
+
+    total_problems = 0
+    total_symbols = 0
+    all_lines = []
+    for list_name in sorted(lists):
+        symbols = lists[list_name]
+        total_symbols += len(symbols)
+        problem_count, lines = check_single_list(list_name, symbols,
+                                                 max_name_len)
+        total_problems += problem_count
+        all_lines.extend(lines)
+
+    return Results(
+        total_problems=total_problems,
+        total_symbols=total_symbols,
+        all_lines=all_lines,
+        max_name_len=max_name_len,
+        list_count=len(lists))
+
+def show_output(results, verbose):
+    """Print the collected results to stderr based on verbosity
+
+    Args:
+        results (Results): The analysis results from collect_data()
+        verbose (bool): True to print output even on success
+    """
+    if results.total_problems == 0 and not verbose:
+        return
+
+    name_col = results.max_name_len + NAME_PAD
+    eprint(f'{"List Name":<{name_col}}  {"# Symbols":>{SYM_COL}}  '
+           f'{"Struct Size (hex)":>{SIZE_COL}}')
+    eprint(f'{"-" * name_col}  {"-" * SYM_COL}  {"-" * SIZE_COL}')
+    for line in results.all_lines:
+        eprint(line)
+
+    # Print footer
+    eprint(f'{"-" * name_col}  {"-" * SYM_COL}')
+    eprint(f'{f"{results.list_count} lists":<{name_col}}  '
+           f'{results.total_symbols:>{SYM_COL}}')
+
+    if results.total_problems > 0:
+        eprint(f'\nFAILURE: Found {results.total_problems} alignment problems')
+    elif verbose:
+        eprint('\nSUCCESS: All discovered lists have consistent alignment')
+
+def main():
+    """Main entry point of the script, returns an exit code"""
+    epilog_text = '''
+Auto-discover all linker-generated lists in a U-Boot ELF file
+(e.g., for drivers, commands, etc.) and verify their integrity. Check
+that all elements in a given list are separated by a consistent number of
+bytes.
+
+Problems typically indicate that the linker has inserted alignment padding
+between two elements in a list, which can break U-Boot's assumption that the
+list is a simple, contiguous array of same-sized structs.
+'''
+    parser = argparse.ArgumentParser(
+        description='Check alignment of U-Boot linker lists in an ELF file.',
+        epilog=epilog_text,
+        formatter_class=argparse.RawDescriptionHelpFormatter
+    )
+    parser.add_argument('elf_path', metavar='ELF',
+                        help='Path to the U-Boot ELF file to check')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Print detailed output even on success')
+
+    args = parser.parse_args()
+
+    lists = run_nm_and_get_lists(args.elf_path)
+    if lists is None:
+        return 2  # Error running nm
+
+    if not lists:
+        if args.verbose:
+            eprint('Success: No U-Boot linker lists found to check')
+        return 0
+
+    results = collect_data(lists)
+    show_output(results, args.verbose)
+
+    return 3 if results.total_problems > 0 else 0
+
+if __name__ == '__main__':
+    sys.exit(main())
-- 
2.43.0

