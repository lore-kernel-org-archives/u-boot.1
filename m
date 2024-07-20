Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB4C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CF688C67;
	Sat, 20 Jul 2024 12:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NXomHTYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3E088BFD; Sat, 20 Jul 2024 12:50:14 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B1D88C3E
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3686b285969so1021074f8f.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472611; x=1722077411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1AAb7fPpTapCEkoTqfc0oA+MgHeOQZ53yxZMoy7rzw=;
 b=NXomHTYh5Ewl90wxoyhu2RPoktRPTABfUftHUTMetyihMN3s/RLnAozTKdvK50pvmM
 7nef6Et78bQNfS31Y42m1Ia2NXQXjU+uP0cV5Zd8+v88gAqAU5p6EnefYAHawT9F7rsE
 MILrwK/OIV5cyKBaQYxvkSFNWYKnhSUN5oenM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472611; x=1722077411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1AAb7fPpTapCEkoTqfc0oA+MgHeOQZ53yxZMoy7rzw=;
 b=iu08BgbNIrleVn0542D1BooElSBnOCLG4Izn5qpyCu4h8Z9Jh2Bs3yxRJtbAuILdIW
 2CuqdLCCaT6nU99UsRqumOFVMerJnBXDcalOiH5NrhvEgFENUzm+bTtdefWGecloWggr
 VCJoPO8j3wECVk5BpJ1hTqXVWkxJwB4nvEbFHI2B3p5NTe4c9S9LBnHpWw4XED2LHlkF
 tnd/AgbLYDZewX1JFLVkYRn6p1F7VrBmp9Wnk7CZyG0Lfe9NTxS4ldvMQeN4+Ap4nldF
 Xhgt816snzFVoVpIxXGcNHJcOoGVAdvA/72qY1bbqHEn8rMn1BAUNgaix0GwB0A5H58q
 tRWQ==
X-Gm-Message-State: AOJu0YwPj7R42gRpFulDhCm8nb6OzGUSYRtGbzSRuKtppGNc/TlMu5Eq
 D7YRNK29DdeA+wiZrfqvBELlMI+SV7d+ofwcCoFPpWzeCpscDsu2CKsAKAonu2i3Pe74jSDXOZ0
 =
X-Google-Smtp-Source: AGHT+IGUZYQE2NLtR4s0rdPLJteUq8R1JqNcTvkecphEg8aHZl57NH/G/xGtmBnaUdy8rCSnWoLDsg==
X-Received: by 2002:adf:f98f:0:b0:367:9cef:f41e with SMTP id
 ffacd0b85a97d-369bb2ab332mr709854f8f.57.1721472611446; 
 Sat, 20 Jul 2024 03:50:11 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/20] binman: Add a bintool for fdtgrep
Date: Sat, 20 Jul 2024 11:49:42 +0100
Message-Id: <20240720104950.2730773-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

Binman needs the ability to run fdtgrep to prepare devicetree subsets
for use by SPL and TPL. Add a new bintool in preparation for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/bintools.rst     |   8 ++
 tools/binman/btool/fdtgrep.py | 137 ++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/binman/btool/fdtgrep.py

diff --git a/tools/binman/bintools.rst b/tools/binman/bintools.rst
index fa44d9c6872..cd05ad8cb26 100644
--- a/tools/binman/bintools.rst
+++ b/tools/binman/bintools.rst
@@ -65,6 +65,14 @@ to add the public key separately from mkimage.
 
 
 
+Bintool: fdtgrep: Handles the 'fdtgrep' tool
+--------------------------------------------
+
+This bintool supports running `fdtgrep` with parameters suitable for
+producing SPL devicetrees from the main one.
+
+
+
 Bintool: fiptool: Image generation for ARM Trusted Firmware
 -----------------------------------------------------------
 
diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
new file mode 100644
index 00000000000..c34d8d8943b
--- /dev/null
+++ b/tools/binman/btool/fdtgrep.py
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2022 Google LLC
+#
+"""Bintool implementation for fdtgrep
+
+fdtgrepprovides a way to grep devicetree-binary files to extract or remove
+certain elements.
+
+Usage: fdtgrep - extract portions from device tree
+
+Usage:
+	fdtgrep <options> <dt file>|-
+
+Output formats are:
+	dts - device tree soure text
+	dtb - device tree blob (sets -Hmt automatically)
+	bin - device tree fragment (may not be a valid .dtb)
+
+Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
+  -a, --show-address                 Display address
+  -A, --colour                       Show all nodes/tags, colour those that match
+  -b, --include-node-with-prop <arg> Include contains containing property
+  -c, --include-compat <arg>         Compatible nodes to include in grep
+  -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
+  -d, --diff                         Diff: Mark matching nodes with +, others with -
+  -e, --enter-node                   Enter direct subnode names of matching nodes
+  -f, --show-offset                  Display offset
+  -g, --include-match <arg>          Node/property/compatible string to include in grep
+  -G, --exclude-match <arg>          Node/property/compatible string to exclude in grep
+  -H, --show-header                  Output a header
+  -I, --show-version                 Put "/dts-v1/;" on first line of dts output
+  -l, --list-regions                 Output a region list
+  -L, --list-strings                 List strings in string table
+  -m, --include-mem                  Include mem_rsvmap section in binary output
+  -n, --include-node <arg>           Node to include in grep
+  -N, --exclude-node <arg>           Node to exclude in grep
+  -p, --include-prop <arg>           Property to include in grep
+  -P, --exclude-prop <arg>           Property to exclude in grep
+  -r, --remove-strings               Remove unused strings from string table
+  -R, --include-root                 Include root node and all properties
+  -s, --show-subnodes                Show all subnodes matching nodes
+  -S, --skip-supernodes              Don't include supernodes of matching nodes
+  -t, --show-stringtab               Include string table in binary output
+  -T, --show-aliases                 Include matching aliases in output
+  -o, --out <arg>                    -o <output file>
+  -O, --out-format <arg>             -O <output format>
+  -v, --invert-match                 Invert the sense of matching (select non-matching lines)
+  -h, --help                         Print this help and exit
+  -V, --version                      Print version and exit
+"""
+
+import tempfile
+
+from u_boot_pylib import tools
+from binman import bintool
+
+class Bintoolfdtgrep(bintool.Bintool):
+    """Handles the 'fdtgrep' tool
+
+    This bintool supports running `fdtgrep` with parameters suitable for
+    producing SPL devicetrees from the main one.
+    """
+    def __init__(self, name):
+        super().__init__(name, 'Grep devicetree files')
+
+    def create_for_phase(self, infile, phase, outfile, remove_props):
+        """Create the FDT for a particular phase
+
+        Args:
+            infile (str): Input filename containing the full FDT contents (with
+                all nodes and properties)
+            phase (str): Phase to generate for ('tpl', 'vpl', 'spl')
+            outfile (str): Output filename to write the grepped FDT contents to
+                (with only neceesary nodes and properties)
+
+        Returns:
+            CommandResult: Resulting output from the bintool, or None if the
+                tool is not present
+        """
+        if phase == 'tpl':
+            tag = 'bootph-pre-sram'
+        elif phase == 'vpl':
+            tag = 'bootph-verify'
+        elif phase == 'spl':
+            tag = 'bootph-pre-ram'
+        else:
+            raise(f"Invalid U-Boot phase '{phase}': Use tpl/vpl/spl")
+
+        # These args mirror those in cmd_fdtgrep in scripts/Makefile.lib
+        # First do the first stage
+        with tempfile.NamedTemporaryFile(prefix='fdtgrep.tmp',
+                                         dir=tools.get_output_dir()) as tmp:
+            args = [
+                infile,
+                '-o', tmp.name,
+                '-b', 'bootph-all',
+                '-b', tag,
+                '-u',
+                '-RT',
+                '-n', '/chosen',
+                 '-n', '/config',
+                 '-O', 'dtb',
+                ]
+            self.run_cmd(*args)
+            args = [
+                    tmp.name,
+                    '-o', outfile,
+                    '-r',
+                     '-O', 'dtb',
+                    '-P', 'bootph-all',
+                    '-P', 'bootph-pre-ram',
+                    '-P', 'bootph-pre-sram',
+                    '-P', 'bootph-verify',
+                    ]
+            for prop_name in remove_props:
+                args += ['-P', prop_name]
+            return self.run_cmd(*args)
+
+    def fetch(self, method):
+        """Fetch handler for fdtgrep
+
+        This installs fdtgrep using the apt utility, which assumes that it is
+        packaged in u-boot tools, which it is not.
+
+        Args:
+            method (FETCH_...): Method to use
+
+        Returns:
+            True if the file was fetched and now installed, None if a method
+            other than FETCH_BIN was requested
+
+        Raises:
+            Valuerror: Fetching could not be completed
+        """
+        if method != bintool.FETCH_BIN:
+            return None
+        return self.apt_install('u-boot-tools')
-- 
2.34.1

