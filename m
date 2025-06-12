Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108C8C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 15:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C0582B70;
	Thu, 12 Jun 2025 17:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+QUQkZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E9782C4D; Thu, 12 Jun 2025 17:33:27 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F67828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so694567f8f.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749742405; x=1750347205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nC5y3Rt0PtwMsXT1ldZxbgyX4k03P0sXuU7Y2h1B5Fk=;
 b=S+QUQkZ4DU9QBNgzcyFJR5kHYTO8Cz3aKxrP4FOD6cDO/QrNS0jskhEQyjiiE7wg5d
 CPhXNuXOUdjQS7AJ7byMqW5BmeRCv0cWFftkZW9rPdy1gR7fqxMRd2HAW8Tomw6BbwhY
 KbNsbS1FcSBzSsXOW7IFq71h5UbBt+AQYRzCW9AfYOnTBDS1tcR8hmUVTCFBwZXff6IW
 U/Y4NrLvNSIY+EZn1kEQv2dUkZT5fbjo+wbY1yFotd1BW/AU4ektjaVRLHJutf5ijecO
 p8EgDH8lZY/g7LkRu3joc6zcvtB7NM8cd47ztYX6kJkSh5MOxNMVPhv+icFUdtO8Omxk
 R4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749742405; x=1750347205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nC5y3Rt0PtwMsXT1ldZxbgyX4k03P0sXuU7Y2h1B5Fk=;
 b=HTvcFi5g7QwthYlstSASYQNVG0vfB1SvYIG+Tf5tcq1sYlfIHgdkbAQOuZIG2vOUiS
 WHUyCUuhQu2x+YqQKvRuOHejWd5nfrl65HGYNVYw/MCii4lQJiB/gXrIh+VOgzUQb0rx
 DeA0M4SV/ZijLzeZngDFSlCG+e3bqAT3Ey6UZn9zYaiTFuPB3RuAcDR5VSHOjREMrJv/
 WIFSCzoo7DXYtvmzSii3Dh4EuOflZozjThfQUA0hsvD6LeTZr6aqidcEyQdocLproxWu
 leI6b2yBbGvvvC/vsGjuMhK2Wkc9zYOoXVRM5Ikv/FG52dyUa5yPfprJBvDmqyDaYl9R
 62sQ==
X-Gm-Message-State: AOJu0YyBEraINKP2N8aMMB5sfCUnJcQ9xkj/C4MsNqogbxI0izekne+N
 8LfxASPQGgddqUFXJpxKQsxRpj811sd5S6xnZh2sD0gSNFhuky9efj5LXa27oYz3A3mvniaI42R
 RsnW9
X-Gm-Gg: ASbGncuwWap+6Zd6/3q8bVy3h17xG8TxUP+8RTcBCAiqe/dvyqBGkpcrUY4hyyAr5fp
 Us3ZOYWcLpnpyYKsCC9wk/LbE8BuLiB7sCFjHSx9To48T0b3VjoRzTyuMQflR49DL8z8QqN5TOC
 cWjx30fYJNEfKmBhwNhxqZOVO8xy27t+dpe1hZnyd7H2aLfhTmjJblvtVHrvufVsMdLooDGEmdn
 2ODpG0EitErEAQcsNzsqVyZsHRp4nKLh1Xxo/Ppjh8JQaWiVdMhY7bxkE1Dy0CPWQ3NveSFCFyV
 Sj/rHHq2HE+Bsy5mfJqL6xCvIG1xZQ7TD7nMHnE83Y3DAF9KzjgDZzOK5O+KZpazEG7S+cA=
X-Google-Smtp-Source: AGHT+IFwimRVpeVXACH8WJIQHc+EJcrvWQ8H9zoyUadZD6V1M2xSqOmhw67AZ3X6Oqa1wHaucjq5kg==
X-Received: by 2002:a05:6000:2310:b0:3a4:d994:be7d with SMTP id
 ffacd0b85a97d-3a567987a36mr396098f8f.23.1749742404643; 
 Thu, 12 Jun 2025 08:33:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d68f:cef4:37c0:ca3c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a56199a930sm2330606f8f.35.2025.06.12.08.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 08:33:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
Date: Thu, 12 Jun 2025 17:32:41 +0200
Message-ID: <20250612153311.2379944-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Add a script to help build a functional U-Boot binary for the ZynqMP
Kria KV260. Also add some documentation.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 doc/board/xilinx/index.rst        |  1 +
 doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
 tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
 tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+)
 create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
 create mode 100755 tools/zynqmp_kv260_build.sh
 create mode 100755 tools/zynqmp_pmufw_elf_convert.py

diff --git a/doc/board/xilinx/index.rst b/doc/board/xilinx/index.rst
index 2e31fe3f3a4..3f3a85b709c 100644
--- a/doc/board/xilinx/index.rst
+++ b/doc/board/xilinx/index.rst
@@ -9,4 +9,5 @@ Xilinx
    xilinx
    zynq
    zynqmp
+   zynqmp-kv260
    zynqmp-r5
diff --git a/doc/board/xilinx/zynqmp-kv260.rst b/doc/board/xilinx/zynqmp-kv260.rst
new file mode 100644
index 00000000000..219bbd602e9
--- /dev/null
+++ b/doc/board/xilinx/zynqmp-kv260.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+..  (C) Copyright 2025 Linaro Ltd.
+
+ZYNQMP KV260
+============
+
+Building
+--------
+
+To build for the KV260:
+
+   $ ./tools/zynqmp_kv260_build.sh
+
+The first invocation will fetch and build some required binaries (bl31.bin,
+pm_cfg_obj.o, pmufw.bin). Subsequently `make` can be invoked directly as
+follows:
+
+   $ export BL31=bl31.bin
+   # export CROSS_COMPILE=aarch64-linux-gnu-
+   $ make -j$(nproc) BINMAN_ALLOW_MISSING=1
+
+Flashing
+--------
+
+Press the FWUEN button on the carrier board, the press and release the RESET
+button, then release FWUEN. Connect to the embedded HTTP server and upload
+`qspi.bin`. Press and release RESET again.
diff --git a/tools/zynqmp_kv260_build.sh b/tools/zynqmp_kv260_build.sh
new file mode 100755
index 00000000000..3cf7147e3a6
--- /dev/null
+++ b/tools/zynqmp_kv260_build.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Linaro Ltd.
+
+set -ex
+
+if [ "$1" == "-c" ]; then
+  rm -f bl31.bin pmufw.elf pmufw.bin pm_cfg_obj.c pm_cfg_obj.o
+  exit 0
+fi
+[ -e bl31.bin ] || {
+  ATF_SRC=$(mktemp -d /tmp/arm-trusted-firmware.XXXXXXXXXX)
+  git clone https://github.com/ARM-software/arm-trusted-firmware ${ATF_SRC}
+  make -C ${ATF_SRC} -j$(nproc) bl31 CROSS_COMPILE=aarch64-linux-gnu- \
+	  LOG_LEVEL=40 ZYNQMP_CONSOLE=cadence1 CONSOLE_RUNTIME=cadence1 \
+	  RESET_TO_BL31=1 PLAT=zynqmp ZYNQMP_ATF_MEM_BASE=0x10000 \
+	  ZYNQMP_ATF_MEM_SIZE=0x2ffff ENABLE_LTO=1
+  cp ${ATF_SRC}/build/zynqmp/release/bl31.bin .
+  rm -rf ${ATF_SRC}
+}
+[ -e pmufw.bin ] || {
+  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2023.1/kv260-kria/pmufw.elf
+  ./tools/zynqmp_pmufw_elf_convert.py pmufw.elf pmufw.bin
+}
+[ -e pm_cfg_obj.o ] || {
+  wget https://github.com/Xilinx/embeddedsw/raw/refs/heads/xlnx_rel_v2023.1/lib/sw_apps/zynqmp_fsbl/misc/pm_cfg_obj.c
+  ./tools/zynqmp_pm_cfg_obj_convert.py pm_cfg_obj.c pm_cfg_obj.o
+}
+[ -e .config ] || {
+  make xilinx_zynqmp_kria_defconfig
+  cat << EOF >> .config
+CONFIG_PMUFW_INIT_FILE="pmufw.bin"
+CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE="pm_cfg_obj.o"
+CONFIG_BL31_LOAD_ADDR=0x10000
+CONFIG_BL32_LOAD_ADDR=0
+EOF
+}
+export BL31=bl31.bin
+export BL32=
+export TEE=
+export CROSS_COMPILE=aarch64-linux-gnu-
+make -j$(nproc) BINMAN_ALLOW_MISSING=1
diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw_elf_convert.py
new file mode 100755
index 00000000000..b4eb2695831
--- /dev/null
+++ b/tools/zynqmp_pmufw_elf_convert.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2025 Linaro Ltd.
+#
+# Written by Gemini (Google AI) then reviewed and edited to remove some comments
+
+import sys
+from elftools.elf.elffile import ELFFile
+from elftools.elf.segments import Segment
+from elftools.common.exceptions import ELFError
+
+def elf_to_bin_with_elftools(elf_path, bin_path):
+    """
+    Converts a Microblaze ELF file to a raw binary (.bin)
+    by extracting LOAD segments using the elftools library.
+
+    Args:
+        elf_path (str): Path to the input .elf file.
+        bin_path (str): Path for the output .bin file.
+    """
+    try:
+        with open(elf_path, 'rb') as f:
+            elffile = ELFFile(f)
+
+            if elffile.header['e_machine'] not in ('EM_MICROBLAZE', 'EM_MICROBLAZE_OLD'):
+                print(f"Error: ELF machine type is {elffile.header['e_machine']}, "
+                      f"not typical Microblaze.")
+                return
+
+            print(f"ELF Header Info:")
+            print(f"  Entry Point: 0x{elffile.header['e_entry']:08X}")
+            print(f"  Endianness: {elffile.little_endian and 'Little-endian' or 'Big-endian'}")
+
+            load_segments = []
+            for segment in elffile.iter_segments():
+                if segment.header['p_type'] == 'PT_LOAD':
+                    load_segments.append(segment)
+                    print(f"  Found LOAD segment:")
+                    print(f"    Offset: 0x{segment.header['p_offset']:08X}, VAddr: 0x{segment.header['p_vaddr']:08X}")
+                    print(f"    File Size: {segment.header['p_filesz']} bytes, Memory Size: {segment.header['p_memsz']} bytes")
+
+            if not load_segments:
+                print("Error: No LOADable segments found in the ELF file. Cannot create binary.")
+                return
+
+            load_segments.sort(key=lambda seg: seg.header['p_vaddr'])
+
+            min_vaddr = load_segments[0].header['p_vaddr']
+            max_vaddr = 0
+            for segment in load_segments:
+                end_vaddr = segment.header['p_vaddr'] + segment.header['p_memsz']
+                if end_vaddr > max_vaddr:
+                    max_vaddr = end_vaddr
+
+            total_bin_size = max_vaddr - min_vaddr
+            print(f"Calculated binary memory range: 0x{min_vaddr:08X} to 0x{max_vaddr:08X} (Size: {total_bin_size} bytes)")
+
+            output_buffer = bytearray(total_bin_size)
+
+            for segment in load_segments:
+                buffer_start = segment.header['p_vaddr'] - min_vaddr
+                buffer_end = buffer_start + segment.header['p_memsz'] # Using memsz for bounds check
+
+                if buffer_end > total_bin_size:
+                    print(f"Warning: Segment at 0x{segment.header['p_vaddr']:08X} "
+                          f"extends beyond calculated total binary size. Truncating.")
+                    buffer_end = total_bin_size
+
+                segment_data = segment.data()
+
+                output_buffer[buffer_start : buffer_start + len(segment_data)] = segment_data
+
+                # The remaining part of the segment in memory (if p_memsz > p_filesz)
+                # is already zeroed due to output_buffer initialization.
+
+            with open(bin_path, 'wb') as out_f:
+                out_f.write(output_buffer)
+
+            print(f"Successfully created '{bin_path}' (size: {len(output_buffer)} bytes) from '{elf_path}'.")
+
+    except FileNotFoundError:
+        print(f"Error: ELF file not found at '{elf_path}'")
+    except ELFError as e:
+        print(f"Error parsing ELF file with elftools: {e}. The file might be malformed or not a valid ELF.")
+    except Exception as e:
+        print(f"An unexpected error occurred: {e}")
+
+if __name__ == "__main__":
+    if len(sys.argv) != 3:
+        print("Usage: python elf_to_bin.py <input_elf_file> <output_bin_file>")
+        sys.exit(1)
+
+    input_elf = sys.argv[1]
+    output_bin = sys.argv[2]
+
+    elf_to_bin_with_elftools(input_elf, output_bin)
-- 
2.43.0

base-commit: fcdb871cb79e21d53fa8ef241dd0f06336c27d47
branch: kv260-spl-build
