Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S7JM5mIb;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=gJP2NbVh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4BC860E26;
	Fri, 13 Nov 2026 02:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLUG0eXy55EQ; Fri, 13 Nov 2026 02:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0CA860E2D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537240;
	b=OHEPhahs9XI65hW3fFBhl1Oril/7On2VLdO6qC6cVAK/y2S6wAPzuNNIDO9fp3ooEhB5
	 mL6AQeGD7mH3ykuGTq4fSDT/k9LbCj721UMpmsTlpjrXG0RWlC6P8Cl0B4BQ9+cniNn7n
	 CYIigHHVQjwFH4a6xABWUojUuMfhH4yJIbKNE7iuPWs/dYJ1f0mC+IfAFAIL4LQjJtFiJ
	 42o8N340zWTIVNa1Pub3ddsM3dHHi9M/At7ntnsd2bZ66T3pXwQh24TrrPg/1REGpq/O9
	 M+yIZZkBQ/M31cA9jLA+8oxCntrYKVTq9SOsDv5hASIeO5NWWUZh+Bix9MJkqPeLB3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YgXDsqrkvVfAPudXjfPel/B9W6w/uzp9vNwD6h8HgVo=;
	b=O3UcRJMfoUlDlMDhQEG5gBnkkBgWn7oDXSSlR2rzEDu+1bzjk9LK08ejhpHpBWGBV7aB
	 dL/dgSC0aCp/Mn3KP/i62Ezt9qtQic01spPj/nT2583qpibqhPbfmNj38RwtDaD0ntsxU
	 +2OruburLnvkxtAjgsd483TrsWpMh38ZO8S2TWOEpZoj44EUV+gPWMXcoMPNGjraLYVdc
	 94XaAALRX6grjXqEMDbvFs8cx9FKnyL6zeWx+pHbcoTCmdKinAB46LWHeZTAksYODiO8+
	 ZY3CYr5UJkDKNd2mcUDC+qe1Y5z6YWlyp0vTHURbcPGidmqvtkkHBFImac15fI3VW5A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=gJP2NbVh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537240;
	bh=YgXDsqrkvVfAPudXjfPel/B9W6w/uzp9vNwD6h8HgVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7JM5mIbFStVC7R4rPsNpsFjHSRR9z03HqkQ7hCVY8VfQP8pipgg+hBqq/kFqsPv1
	 ScXMRoMNsIJLcWKmCVxcS0xQl42C2rwFsK6wxpoSY7azniDSegGdM7FCMq0NayBdNv
	 lTAOOZCgx7MO9DVV4kzjm0D1CSlLrFaSOqzQozPsf2HVJMOfHdRLowk3TYUY6l7Y2c
	 BUNGgFOc+K6++vzNebz85ouJPhFpRI9m7e/oDyMaF3M66J2U7kP0q371OIVRAsECrz
	 DXB+ZZGm/436kGHc3ym0aNqPVmvbx9m4hZ9A0NOJ8iZgObubN2M0zqi1RM0y08G7C5
	 w3tKdH0fKvo1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0CA860E2D;
	Fri, 13 Nov 2026 02:34:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2CC92E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35A2360E39
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Fw02MJTNwXr for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3699660E26
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=gJP2NbVh
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3699660E26
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:55 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 09C8E4C8BF;
 Fri, 13 Nov 2026 13:33:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgXDsqrkvVfAPudXjfPel/B9W6w/uzp9vNwD6h8HgVo=;
 b=gJP2NbVhTHpPbrnMGos9vtRkcuVST+LXm3hJ35QiuP7/qUfZO6keNoKtaJv8S4Jg0WL3M9
 4UGeFrVWv9EbFt4q6opc12BK+8ZXLu+TwVu88GLhpGMhkB9dw1uWDqzwrlJsBSXRUnkosA
 OIWIP3txxaT0aE/VwodSTFH6A+uQlF7ICc7t/oVIE00MWqAme6L1T/Lfmu5YbvwdBB7P1P
 88BxuWA3n3LupnQEZit0qPg5/NZAL0w/6nylwqf/VLPcRKgLZZuVBGgE0lXkM5GNMN1OaG
 KYirnYb27jaHualqvxvHB12cVwtzZ3KYXoymy+6rZvxmzaYSFZI6y3XfB7Gykg==
X-GPT-Reason: legitimate; the message is a technical software
 patch/contribution that perfectly aligns with the personal/professional
 context of the recipient's mailbox (alastair@d-silva.org); the
 From domain (d-silva.org) matches the recipient domain, indicating
 a known personal or professional relationship; the content is highly
 specific technical documentation regarding "Allwinner A733 DDR PHY" and
 "ARC EM4 microsequencer firmware" with no signs of marketing, phishing,
 or urgency; the "Signed-off-by" field confirms a standard Linux
 kernel-style development workflow.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 14/26] sunxi: dram: a733: Add ARC PMU register, ABI,
 and build definitions
Date: Fri, 13 Nov 2026 13:32:24 +1100
Message-ID: <20261113023236.569054-15-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the shared host/ARC ABI header, DesignWare LPDDR5 DDR PHY CSR and
DCCM offsets, internal firmware prototypes, ICCM execute-only linker
script, and single-pass ELF build helper for the Allwinner A733 DDR PHY
ARC EM4 microsequencer firmware.

The firmware in arch/arm/mach-sunxi/pmu/ is an original GPL-2.0+ C
implementation written under a strict two-team clean-room methodology:
an analysis team documented hardware register addresses, DCCM mailbox
protocol layouts, and JEDEC LPDDR5 training state transitions as
functional specifications without sharing code or control-flow idioms,
and an isolated implementation team wrote this C codebase solely from
those specifications and JEDEC JESD209-5.

build_pmu_fw.py locates an ARC toolchain via ARC_CROSS_COMPILE, PATH,
or ~/.buildman, supports --pmu-fw for externally built ICCM binaries,
and supports --allow-missing (wired to BINMAN_ALLOW_MISSING) so CI
builders without arc-*-gcc emit a non-functional stub cleanly.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/mach-sunxi/pmu/build_pmu_fw.py       | 257 ++++++++
 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h | 463 +++++++++++++++
 arch/arm/mach-sunxi/pmu/pmu.ld                |  38 ++
 arch/arm/mach-sunxi/pmu/pmu_fw.h              | 553 ++++++++++++++++++
 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h       | 251 ++++++++
 5 files changed, 1562 insertions(+)
 create mode 100755 arch/arm/mach-sunxi/pmu/build_pmu_fw.py
 create mode 100644 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu.ld
 create mode 100644 arch/arm/mach-sunxi/pmu/pmu_fw.h
 create mode 100644 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h

diff --git a/arch/arm/mach-sunxi/pmu/build_pmu_fw.py b/arch/arm/mach-sunxi/pmu/build_pmu_fw.py
new file mode 100755
index 00000000000..8ce2bfdcd6c
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/build_pmu_fw.py
@@ -0,0 +1,257 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+"""
+Single-pass ELF builder for Allwinner A733 LPDDR5 ARC EM4 PMU Firmware.
+"""
+
+import argparse
+import configparser
+import glob
+import os
+import shutil
+import struct
+import subprocess
+import sys
+import tempfile
+
+DEFAULT_SOURCES = (
+    "pmu_primitives.c",
+    "pmu_clock.c",
+    "pmu_telemetry.c",
+    "pmu_cbt.c",
+    "pmu_deskew.c",
+    "pmu_eye.c",
+    "pmu_train.c",
+)
+
+
+def resolve_arc_toolchain(preferred_prefix, explicit=False):
+    """Locate an ARC GCC toolchain prefix across PATH and U-Boot CI locations."""
+    if preferred_prefix:
+        if shutil.which(f"{preferred_prefix}gcc") and shutil.which(f"{preferred_prefix}objcopy"):
+            return preferred_prefix
+        if explicit:
+            raise RuntimeError(
+                f"Explicitly requested ARC toolchain '{preferred_prefix}gcc' not found"
+            )
+
+    candidates = [
+        "arc-linux-gnu-",
+        "arc-linux-",
+        "arc-elf32-",
+    ]
+    for bman_cfg in (
+        os.path.expanduser("~/.buildman"),
+        "/home/uboot/.buildman",
+    ):
+        if not os.path.isfile(bman_cfg):
+            continue
+        cfg = configparser.ConfigParser()
+        try:
+            cfg.read(bman_cfg)
+            if cfg.has_option("toolchain-prefix", "arc"):
+                candidates.append(os.path.expanduser(cfg.get("toolchain-prefix", "arc")))
+            if cfg.has_section("toolchain"):
+                for _, root in cfg.items("toolchain"):
+                    root = os.path.expanduser(root)
+                    for pat in ("bin/arc-*-gcc", "*/bin/arc-*-gcc"):
+                        candidates.extend(sorted(glob.glob(os.path.join(root, pat)), reverse=True))
+        except configparser.Error:
+            pass
+
+    for pattern in (
+        "/opt/gcc-*-nolibc/arc-linux/bin/arc-linux-",
+        os.path.expanduser("~/.buildman-toolchains/gcc-*-nolibc/arc-linux/bin/arc-linux-"),
+        "/home/uboot/.buildman-toolchains/gcc-*-nolibc/arc-linux/bin/arc-linux-",
+    ):
+        candidates.extend(sorted(glob.glob(pattern), reverse=True))
+
+    for prefix in candidates:
+        if prefix.endswith("gcc"):
+            prefix = prefix[:-3]
+        if shutil.which(f"{prefix}gcc") and shutil.which(f"{prefix}objcopy"):
+            return prefix
+
+    return None
+
+
+def write_header(output_h_path, hwords, missing=False):
+    """Atomically emit the C header containing the PMU ICCM image or missing stub."""
+    out_dir = os.path.dirname(output_h_path)
+    os.makedirs(out_dir, exist_ok=True)
+    with tempfile.NamedTemporaryFile("w", dir=out_dir, delete=False, prefix=".pmu_fw_tmp_") as f:
+        tmp_name = f.name
+        f.write("/* SPDX-License-Identifier: GPL-2.0+ */\n")
+        f.write("/*\n")
+        if missing:
+            f.write(" * Auto-generated stub ARC EM4 PMU Firmware Header (missing toolchain).\n")
+        else:
+            f.write(
+                f" * Auto-generated ARC EM4 PMU Firmware Header "
+                f"({len(hwords) * 2} bytes / {len(hwords)} halfwords).\n"
+            )
+        f.write(" */\n\n")
+        f.write("#ifndef __DRAM_SUN60I_A733_PMU_FW_H__\n")
+        f.write("#define __DRAM_SUN60I_A733_PMU_FW_H__\n\n")
+        f.write("#include <linux/compiler_attributes.h>\n")
+        f.write("#include <linux/types.h>\n\n")
+        if missing:
+            f.write("#define SUN60I_A733_PMU_FW_MISSING 1\n\n")
+            f.write(
+                "static const u16 __section(\".init.rodata\") "
+                "sun60i_a733_pmu_imem[1] = { 0 };\n\n"
+            )
+        else:
+            f.write(
+                f"static const u16 __section(\".init.rodata\") "
+                f"sun60i_a733_pmu_imem[{len(hwords)}] = {{\n"
+            )
+            for i in range(0, len(hwords), 8):
+                hex_str = ", ".join(f"0x{x:04x}" for x in hwords[i:i + 8])
+                f.write(f"\t{hex_str},\n")
+            f.write("};\n\n")
+        f.write("#endif /* __DRAM_SUN60I_A733_PMU_FW_H__ */\n")
+
+    os.replace(tmp_name, output_h_path)
+
+
+def main():
+    pmu_dir_default = os.path.abspath(os.path.dirname(__file__))
+    repo_root = os.path.abspath(os.path.join(pmu_dir_default, "..", "..", "..", ".."))
+    default_out = os.path.join(repo_root, "arch/arm/mach-sunxi/dram_sun60i_a733_pmu_fw.h")
+
+    parser = argparse.ArgumentParser(
+        description="Build Allwinner A733 LPDDR5 ARC EM4 PMU firmware."
+    )
+    parser.add_argument("--cross-compile", default="", help="ARC toolchain prefix")
+    parser.add_argument("--pmu-fw", default="", help="Prebuilt raw PMU ICCM binary path")
+    parser.add_argument("--allow-missing", action="store_true",
+                        help="Emit a non-functional stub header if ARC toolchain is absent")
+    parser.add_argument("--src-dir", default=pmu_dir_default, help="PMU firmware source directory")
+    parser.add_argument("--ld-script", default="", help="Linker script path")
+    parser.add_argument("--out", default=default_out, help="Output C header path")
+    parser.add_argument("sources", nargs="*", help="Explicit C source files to compile")
+    args = parser.parse_args()
+
+    src_dir = os.path.abspath(args.src_dir)
+    ld_script = os.path.abspath(args.ld_script) if args.ld_script else os.path.join(src_dir, "pmu.ld")
+    output_h_path = os.path.abspath(args.out)
+
+    if args.pmu_fw:
+        with open(args.pmu_fw, "rb") as bf:
+            raw = bf.read()
+        if not raw:
+            raise ValueError(f"PMU firmware '{args.pmu_fw}' is empty")
+        if len(raw) > 0x10000:
+            raise ValueError(
+                f"PMU firmware '{args.pmu_fw}' exceeds 64 KiB ICCM limit ({len(raw)} bytes)"
+            )
+    else:
+        explicit_cc = any(arg.startswith("--cross-compile") for arg in sys.argv[1:])
+        prefix = resolve_arc_toolchain(args.cross_compile, explicit=explicit_cc)
+        if prefix is None:
+            if args.allow_missing:
+                print(
+                    "Image 'spl/u-boot-spl.bin' is missing ARC cross-compiler; "
+                    "using non-functional stub PMU firmware",
+                    file=sys.stderr,
+                )
+                write_header(output_h_path, [], missing=True)
+                return 0
+            print(
+                "Error: ARC toolchain not found (install arc-linux-gnu-gcc, pass PMU_FW=, "
+                "or build with BINMAN_ALLOW_MISSING=1)",
+                file=sys.stderr,
+            )
+            return 1
+
+        gcc = f"{prefix}gcc"
+        objcopy = f"{prefix}objcopy"
+        c_files = (
+            [os.path.abspath(p) for p in args.sources]
+            if args.sources
+            else [os.path.join(src_dir, name) for name in DEFAULT_SOURCES]
+        )
+
+        cflags = [
+            "-mcpu=em4",
+            "-mrf16",
+            "-mcode-density",
+            "-mbranch-index",
+            "-mcode-density-frame",
+            "-mdiv-rem",
+            "-mbarrel-shifter",
+            "-mmpy-option=mpy",
+            "-fno-branch-count-reg",
+            "-EL",
+            "-Os",
+            "-ffreestanding",
+            "-fno-caller-saves",
+            "-fno-ipa-ra",
+            "-ffixed-r26",
+            "-ffixed-r27",
+            "-fno-strict-aliasing",
+            "-fno-jump-tables",
+            "-fno-tree-switch-conversion",
+            "-fno-pic",
+            "-fno-pie",
+            "-fno-stack-protector",
+            "-fno-builtin",
+            "-ffunction-sections",
+            "-fdata-sections",
+            "-std=gnu11",
+            "-Wall",
+            "-Wextra",
+            f"-I{src_dir}",
+        ]
+
+        with tempfile.TemporaryDirectory(prefix="pmu_fw_") as tmpdir:
+            objs = []
+            for src_path in c_files:
+                base = os.path.splitext(os.path.basename(src_path))[0]
+                obj_path = os.path.join(tmpdir, f"{base}.o")
+                subprocess.check_call([gcc, *cflags, "-c", src_path, "-o", obj_path])
+                objs.append(obj_path)
+
+            elf_path = os.path.join(tmpdir, "pmu.elf")
+            bin_path = os.path.join(tmpdir, "pmu.bin")
+            ld_cmd = [
+                gcc,
+                "-mcpu=em4",
+                "-mrf16",
+                "-mcode-density",
+                "-mdiv-rem",
+                "-mbarrel-shifter",
+                "-mmpy-option=mpy",
+                "-EL",
+                "-Os",
+                "-nostdlib",
+                "-no-pie",
+                f"-Wl,-L,{src_dir}",
+                f"-Wl,-T,{ld_script}",
+                "-Wl,--gc-sections",
+                "-Wl,--build-id=none",
+                *objs,
+                "-o",
+                elf_path,
+            ]
+            subprocess.check_call(ld_cmd)
+            subprocess.check_call([objcopy, "-O", "binary", elf_path, bin_path])
+
+            with open(bin_path, "rb") as bf:
+                raw = bf.read()
+
+    if len(raw) % 2 != 0:
+        raw += b"\x00"
+
+    hwords = list(struct.unpack(f"<{len(raw) // 2}H", raw))
+    while hwords and hwords[-1] == 0:
+        hwords.pop()
+
+    write_header(output_h_path, hwords, missing=False)
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h b/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
new file mode 100644
index 00000000000..119fbc9c644
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
@@ -0,0 +1,463 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Synopsys DesignWare DDR PHY PMU Microcontroller Register & Memory Definitions
+ * Target Architecture: Synopsys ARC EM4 (ARCv2 ISA)
+ * SoC: Allwinner A733 (Sun60i) / LPDDR4 & LPDDR5 PHY
+ *
+ * =============================================================================
+ * PHY SILICON ARCHITECTURE & TERMINOLOGY EXPLAINED
+ * =============================================================================
+ *
+ * Inside the Synopsys DesignWare DDR PHY Type 9 silicon on Allwinner A733:
+ *
+ * 1. DBYTE Slices (Data Byte Slices 0..3):
+ *    Each DBYTE slice manages the physical analog signals for one 8-bit byte lane
+ *    (DQ0..DQ7, Data Mask DM, and differential Data Strobe DQS/DQSN).
+ *    Because the A733 uses dual 16-bit channels (Ch0 = 16-bit, Ch1 = 16-bit),
+ *    there are 4 DBYTE slices in total:
+ *      - Slice 0: Ch0 Byte Lane 0 (DQ0..DQ7)
+ *      - Slice 1: Ch0 Byte Lane 1 (DQ8..DQ15)
+ *      - Slice 2: Ch1 Byte Lane 0 (DQ0..DQ7)
+ *      - Slice 3: Ch1 Byte Lane 1 (DQ8..DQ15)
+ *
+ * 2. AC Slices (Address/Command Slices 0..1):
+ *    Manage the clock (CK/CKN) and Command/Address (CA0..CA6) signals sent to the
+ *    LPDDR5 memory chips for each channel.
+ *
+ * 3. PUB (PHY Utility Block):
+ *    The central control core containing master PLL configuration, clock gating,
+ *    PMU execution mailboxes, analog bias generators, and host CPU APB interface.
+ *
+ * 4. LCDL (Local Clock Delay Line):
+ *    Analog tapped delay lines consisting of coarse stages and fine vernier stages.
+ *    Adjusting LCDL delay taps shifts signal transitions by picoseconds, enabling
+ *    the PMU to place sampling clock edges precisely in the center of the data eye.
+ *
+ * 5. CBT (Command Bus Training):
+ *    A JEDEC-standard training mode where the memory controller transmits command
+ *    patterns to the DRAM, and the DRAM returns feedback on the DQ lines. This allows
+ *    the PHY to align the CA signals to the memory clock with picosecond accuracy.
+ *
+ * 6. ZQ Calibration:
+ *    Calibrates transmitter output impedance (Ron) and receiver on-die termination
+ *    (ODT) against an external precision resistor to prevent transmission line
+ *    signal reflections.
+ * =============================================================================
+ */
+
+#ifndef _DWC_DDRPHY_PMU_REGS_H
+#define _DWC_DDRPHY_PMU_REGS_H
+
+#include "sunxi_pmu_abi.h"
+
+/* ========================================================================== */
+
+/* ========================================================================== */
+/* ARC PMU DCCM Addresses (0x80000000 Base)                                   */
+/* ========================================================================== */
+
+#define PMU_DMEM_BASE			0x80000000UL
+#define PMU_DMEM_CLK_GATE_FLAG		0x80000001UL /* Byte: Clock gate / broadcast flag */
+#define PMU_DMEM_PSTATE_FLAGS		0x80000004UL /* Byte: PState / channel status flags */
+#define PMU_DMEM_CAL_MODE_FLAG_ADDR	0x80000005UL /* Byte: Calibration parameter */
+#define PMU_DMEM_DRAM_FREQ_MHZ		0x80000006UL /* Half: Operating DRAM data rate (MT/s) */
+#define PMU_DMEM_PLL_RATIO		0x80000008UL /* Byte: WCK:CK ratio (4 = 4:1, 2 = 2:1) */
+#define PMU_DMEM_ASSERT_CODE		0x8000000cUL /* Word: Fatal assertion / panic code */
+#define PMU_DMEM_SIGNED_STEP		0x8000000eUL /* SByte: Signed AC timing step */
+#define PMU_DMEM_SEQ_CTRL		0x80000010UL /* Half: Training sequence control mask */
+#define PMU_DMEM_POST_THRESH		0x80000012UL /* Byte: Post mailbox threshold */
+#define PMU_DMEM_TRAIN_MODE_ADDR	0x80000014UL /* Half: Active training stage mode */
+#define PMU_DMEM_ANALOG_CFG		0x80000015UL /* Byte: Analog cfg flag */
+#define PMU_DMEM_RX_CLK_EN		0x80000019UL /* Byte: Receiver clock enable flag */
+#define PMU_DMEM_CAL_STEP_CONFIG	0x8000001aUL /* Half: Calibration step configuration */
+#define PMU_DMEM_DESKEW_LIM		0x8000001cUL /* Byte: Dual-rank deskew cfg */
+#define PMU_DMEM_CH0_DQ_WIDTH		0x80000024UL /* Byte: Total DQ bit width Ch0 */
+#define PMU_DMEM_CH0_ANALOG_EN		0x80000025UL /* Byte: Ch0 analog power enable */
+#define PMU_DMEM_CH0_DESKEW_COARSE	0x80000026UL /* Base: Ch0 coarse deskew diff */
+#define PMU_DMEM_ACTIVE_SLICE_CNT	0x80000028UL /* Byte: Active DBYTE slice cnt */
+#define PMU_DMEM_CH0_DESKEW_CROSS	0x8000002cUL /* Base: Ch0 cross deskew diff */
+#define PMU_DMEM_CH0_DESKEW_FINE	0x80000030UL /* Base: Ch0 fine deskew diff */
+#define PMU_DMEM_CH1_DQ_WIDTH		0x8000003fUL /* Byte: Total DQ bit width Ch1 */
+#define PMU_DMEM_CH1_ACTIVE_FLAG	0x80000040UL /* Byte: Ch1 active enable flag */
+#define PMU_DMEM_SLICE_PROFILE		0x8000005aUL /* Base: 29-entry slice profile */
+#define PMU_DMEM_MR3_ADDR		0x80000062UL /* Byte: Signed Vref training mode flags */
+#define PMU_DMEM_MR13_ADDR		0x80000072UL /* Byte: Vref DAC control configuration */
+#define PMU_DMEM_MR20_ADDR		0x8000008eUL /* Byte: JEDEC MR20 RDQS mode byte */
+#define PMU_DMEM_MR22_ADDR		0x80000096UL /* Byte: DRAM training config byte */
+#define PMU_DMEM_CAL_OVERRIDE		0x800000ceUL /* Byte: Eye margin override */
+#define PMU_DMEM_WCK_PHASE		0x800000d2UL /* Base: WCK align phase codes */
+#define PMU_DMEM_TEST_PAT		0x800000e4UL /* Half: Custom CBT test pattern */
+#define PMU_DMEM_DESKEW_OFFSET		0x800000e6UL /* Byte: Deskew offset override */
+#define PMU_DMEM_VREF_OVR_CTRL_ADDR	0x800000e7UL /* Byte: Vref DAC override control flags */
+#define PMU_DMEM_PLL_GATE_CH0_ADDR	0x800000e8UL /* Base: Per-rank shadow base */
+#define PMU_DMEM_PLL_GATE_CH1_ADDR	0x800000eaUL /* Half: Ch1 shadow base */
+#define PMU_DMEM_PLL_SEQ_EN_ADDR	0x800000f2UL /* Half: PLL param seq enable */
+#define PMU_DMEM_AC_PROFILE_EN_ADDR	0x800000f4UL /* Byte: AC slice profile en */
+#define PMU_DMEM_LANE_ERR_MASK		0x80000101UL /* Byte: Per-lane deskew error status mask */
+#define PMU_DMEM_TRAIN_FEAT_MASK_ADDR	0x80000102UL /* Byte: Eye sweep op17 param */
+#define PMU_DMEM_CA_VREF_RANK1_ADDR	0x80000103UL /* Byte: CA Vref state Rank 1 */
+#define PMU_DMEM_CA_VREF_RANK0_ADDR	0x80000104UL /* Byte: CA Vref state Rank 0 */
+#define PMU_DMEM_SHADOW_INIT_IDX_ADDR	0x80000108UL /* Half: Initial shadow idx */
+#define PMU_DMEM_SHADOW_PHASE_CNT_ADDR	0x8000010aUL /* Half: Phase shadow count */
+#define PMU_DMEM_SHADOW_MID_IDX_ADDR	0x8000010cUL /* Half: Midpoint shadow idx */
+#define PMU_DMEM_SHADOW_FINAL_CNT_ADDR	0x8000010eUL /* Half: Final shadow count */
+#define PMU_DMEM_GATE_DESC		0x80000118UL /* Base: Gate eye margin desc */
+#define PMU_DMEM_RFIFO_BAK		0x80000130UL /* Base: 7-halfword RFIFO backup */
+#define PMU_DMEM_CBT_LANE_LIM		0x80000403UL /* Byte: CBT strobe/lane limit */
+#define PMU_DMEM_MARGIN_STAT		0x80000405UL /* Byte: Stage 10 margin status byte */
+#define PMU_DMEM_STAGE_RANK_IDX_ADDR	0x80000406UL /* Byte: Stage active rank idx */
+#define PMU_DMEM_STAGE_SLICE_IDX_ADDR	0x80000407UL /* Byte: Stage active slice idx */
+#define PMU_DMEM_STAGE_LANE_IDX_ADDR	0x80000408UL /* Byte: Stage active lane idx */
+#define PMU_DMEM_COST_WEIGHT_2		0x80000410UL /* Half: Eye overflow weight */
+#define PMU_DMEM_SHADOW_TRACE_PTR	0x80000418UL /* Word: Shadow trace buffer ptr */
+#define PMU_DMEM_STEP_CFG_RAW		0x8000001aUL /* Half: Raw step config register */
+#define PMU_DMEM_ACTIVE_CH_OFFSET	0x8000041cUL /* Word: Active channel CSR offset */
+#define PMU_DMEM_COST_WEIGHT_1		0x80000422UL /* Half: Eye deviation weight */
+#define PMU_DMEM_CAL_SAVE_CFG_ADDR	0x8000042aUL /* Half: Saved cal status word */
+#define PMU_DMEM_DBYTE_DLY_SAVE		0x80000430UL /* Base: Saved DBYTE delay array */
+#define PMU_DMEM_CAL_TABLE		0x8000043cUL /* Half: 2D calibration parameter table */
+#define PMU_DMEM_AC_PROFILE_DLY_ADDR	0x80000444UL /* Base: AC profile step cfg A */
+#define PMU_DMEM_AC_PROFILE_CFG_ADDR	0x80000448UL /* Base: AC profile step cfg B */
+#define PMU_DMEM_CBT_STATE		0x8000045aUL /* Byte: CBT state latch */
+#define PMU_DMEM_CBT_CONFIG		0x8000046aUL /* Byte: CBT configuration value */
+#define PMU_DMEM_CAL_CMD_TABLE		0x8000046cUL /* Base: Shadow cal cmd tbl */
+#define PMU_DMEM_NORM_STEP_STRIDE	0x8000047cUL /* Half: Normalized step stride */
+#define PMU_DMEM_CAL_SEQ_MAP		0x80000480UL /* Base: 21-byte cal seq idx map */
+#define PMU_DMEM_CAL_STRUCT_ADDR	0x800009a4UL /* Base: 54B cal struct base */
+#define PMU_DMEM_CH_MASK		0x800009b8UL /* Byte: Active channel mask */
+#define PMU_DMEM_AC_CAL_ACTIVE		0x80000a7cUL /* Byte: AC calibration active flag */
+#define PMU_DMEM_AC_SIGNED_STEP		0x80000a7dUL /* Byte: AC signed step offset */
+#define PMU_DMEM_DQ_PIN_MAP_BASE	0x80000a7eUL /* Base: DBYTE DQ pin swizzle table */
+#define PMU_DMEM_SLICE_CNT_LIMIT	0x80000b20UL /* Base: Slice cnt limit array */
+#define PMU_DMEM_SLICE_IMP_CFG		0x80000b24UL /* Base: Sec rank slice map */
+#define PMU_DMEM_TIMING_LIM		0x80000b64UL /* Byte: Gate timing limit */
+#define PMU_DMEM_ACTIVE_RANK		0x80000b67UL /* Byte: Active rank / byte index */
+#define PMU_DMEM_CH_RANGE		0x80000b68UL /* Base: Active ch [min, max] */
+#define PMU_DMEM_CH_ACTIVE_RANGE	0x80000b6aUL /* Base: Primary ch [min, max] */
+#define PMU_DMEM_DESKEW_DIR		0x80000b6bUL /* Byte: Active deskew sweep direction */
+#define PMU_DMEM_CH_SEC_RANGE		0x80000b6cUL /* Base: Secondary ch [min, max] */
+#define PMU_DMEM_DESKEW_STAT_TBL	0x80000b6eUL /* Base: Deskew lane stat tbl */
+#define PMU_DMEM_ARCHIVED_CAL_STAT_ADDR	0x80000b7eUL /* Half: Archived cal status */
+#define PMU_DMEM_EYE_SWEEP_STAT		0x80000b82UL /* Base: Eye sweep status arr */
+#define PMU_DMEM_LANE_STATUS		0x80000b97UL /* Byte: Latched slice lane status */
+#define PMU_DMEM_ACTIVE_SLICE_MASK	0x80000b98UL /* Byte: Active slice bitmask */
+#define PMU_DMEM_DBYTE_BACKUP		0x80000ba0UL /* Base: DBYTE delay register backup buffer */
+#define PMU_DMEM_EYE_BACKUP		0x80000bc0UL /* Base: 2D eye table backup buffer */
+#define PMU_DMEM_ALT_TRACKER		0x80000d70UL
+#define PMU_DMEM_CAL_TRACKER		0x80000d9cUL /* Base: Calibration marker scratchpad state */
+#define PMU_DMEM_EYE_CLEAR_BUF		0x80000dacUL /* Base: Eye scratchpad buffer */
+#define PMU_DMEM_AC_TIMING_TBL		0x80000dc8UL /* Base: Primary AC timing tbl */
+#define PMU_DMEM_LANE_PARAM_TBL_ADDR	0x80000e48UL /* Base: Per-lane parameter tbl */
+#define PMU_DMEM_LANE_STEP_TBL_ADDR	0x80000e4aUL /* Base: Per-lane signed step tbl */
+#define PMU_DMEM_AC_TIMING_DESC		0x80003708UL /* Base: Sec AC timing desc tbl */
+#define PMU_DMEM_CAL_TAP_STAT		0x8000378bUL /* Base: Calibrated tap status tbl */
+#define PMU_DMEM_CBT_COEFF_A_ADDR	0x80006098UL /* Base: 10-lane CBT coeff tbl A */
+#define PMU_DMEM_CBT_COEFF_B_ADDR	0x80006138UL /* Base: 10-lane CBT coeff tbl B */
+#define PMU_DMEM_CBT_LANE_FLAGS_ADDR	0x800061d8UL /* Base: 10-lane CBT byte flags */
+#define PMU_DMEM_CBT_BASE_TBL_ADDR	0x80006228UL /* Base: 10-lane CBT base tbl */
+#define PMU_DMEM_CBT_INIT_STAT_ADDR	0x80006278UL /* Base: 10-lane CBT init stat tbl */
+#define PMU_DMEM_CBT_TRACK_STAT_ADDR	0x800062c8UL /* Base: 10-lane CBT track stat tbl */
+#define PMU_DMEM_RX_SCAN_MATRIX		0x80008000UL /* Base: 3.5 KiB RX gate scan scratch */
+#define PMU_DMEM_CBT_DELAY_ARR		0x8000e798UL /* Base: CBT per-slice delay arr */
+#define PMU_DMEM_DELAY_TAP_LUT		0x8000e7b8UL /* Base: Pad delay tap LUT */
+#define PMU_DMEM_DELAY_TAP_SUB1		0x8000e7c4UL
+
+/* ========================================================================== */
+/* ARC PMU DCCM Relative Byte Offsets                                         */
+/* ========================================================================== */
+
+#define PMU_DMEM_DRAM_FREQ_OFF		0x06 /* Half: Clock in MHz offset */
+#define PMU_DMEM_DRAM_TYPE_FLAGS	0x0009
+#define PMU_DMEM_DRAM_CFG_FLAGS		0x0a /* Half: DRAM config bitmask */
+#define PMU_DMEM_CAL_SELECT_FLAGS	0x0b /* Byte: Calibration selector flags */
+#define PMU_DMEM_CAL_MISC_FLAGS		0x000d
+#define PMU_DMEM_TRAIN_MODE_HI		0x000f
+#define PMU_DMEM_SEQUENCE_CTRL		0x0010
+#define PMU_DMEM_TRAIN_MODE		0x0014
+#define PMU_DMEM_CAL_CTRL_HI		0x0017
+#define PMU_DMEM_CAL_MODE_EXT		0x0018
+#define PMU_DMEM_CAL_DISABLE		0x0019
+#define PMU_DMEM_CAL_MODE		0x001b
+#define PMU_DMEM_LANE_MASK		0x1c /* Byte: Lane active mask */
+#define PMU_DMEM_CH0_CTRL_LO		0x0020
+#define PMU_DMEM_CH0_CTRL_HI		0x0021
+#define PMU_DMEM_CH0_RANK_EN		0x0025
+#define PMU_DMEM_CH0_RANK_CFG		0x0032
+#define PMU_DMEM_SEARCH_WIN_COARSE	0x0037
+#define PMU_DMEM_SEARCH_WIN_FINE	0x0039
+#define PMU_DMEM_CH1_RANK_EN		0x0040
+#define PMU_DMEM_CH1_RANK_CFG		0x004d
+#define PMU_DMEM_LANE_SWEEP_CTRL	0x0059U
+#define PMU_DMEM_SLICE_PROFILE_TABLE	0x005aUL
+#define PMU_DMEM_VREF_FLAG_SIGNED	0x0062
+#define PMU_DMEM_VREF_DAC_CTRL		0x0072
+#define PMU_DMEM_MR19_OFF		0x8a /* Byte: DRAM protocol status offset */
+#define PMU_DMEM_TRAIN_PARAM_CTRL	0x0096
+#define PMU_DMEM_CAL_OVERRIDE_FLAG	0x00ce
+#define PMU_DMEM_WCK_TAP_C0R0		0x00d1U
+#define PMU_DMEM_WCK_TAP_C1R0		0x00d6U
+#define PMU_DMEM_WCK_TAP_C0R1		0x00dbU
+#define PMU_DMEM_WCK_TAP_C1R1		0x00e0U
+#define PMU_DMEM_BIST_PATTERN_LO	0x00e4
+#define PMU_DMEM_BIST_PATTERN_HI	0x00e5
+#define PMU_DMEM_DESKEW_OFFSET_OVERRIDE	0x00e6
+#define PMU_DMEM_TRAIN_STATUS		0x00e7
+#define PMU_DMEM_DQ_SWAP_BASE		0x0100
+#define PMU_DMEM_TRAIN_FEATURE_MASK	0x0102
+#define PMU_DMEM_DIFF_TAP_PAIR		0x0105
+#define PMU_DMEM_CAL_STEP		0x0106
+#define PMU_DMEM_SEARCH_WINDOW_BIAS_LO	0x0110
+#define PMU_DMEM_SEARCH_WINDOW_BIAS_HI	0x0111
+#define PMU_DMEM_HIGH_FREQ_FLAG		0x0401
+#define PMU_DMEM_CAL_ACTIVE_FLAG	0x0402
+#define PMU_DMEM_FREQ_MODE		0x0403
+#define PMU_DMEM_METRIC_TABLE_ENTRIES	0x0409
+#define PMU_DMEM_ACTIVE_CSR_OFFSET	0x041c
+#define PMU_DMEM_METRIC_COEFF_X		0x0420
+#define PMU_DMEM_METRIC_COEFF_Y		0x0422
+#define PMU_DMEM_ITER_COUNT		0x0428
+#define PMU_DMEM_2D_STEP_CTRL		0x0438
+#define PMU_DMEM_2D_STEP_PARAM		0x043a
+#define PMU_DMEM_CAL_STRIDE		0x047c
+#define PMU_DMEM_DESKEW_TARGET_DELAY	0x047e
+#define PMU_DMEM_CAL_STRUCT_BASE	0x09a4UL
+#define PMU_DMEM_AC_STEP_FLAG		0x0a7c
+#define PMU_DMEM_RANK_SLICE_COUNTS	0x0b20
+#define PMU_DMEM_RANK_SLICE_MAP		0x0b44
+#define PMU_DMEM_SEARCH_WINDOW_STEPS	0x0b64
+#define PMU_DMEM_SEARCH_WINDOW_SCALE	0x0b65
+#define PMU_DMEM_CAL_BYTE		0x0b67
+#define PMU_DMEM_SLICE_START		0x0b68
+#define PMU_DMEM_SLICE_END		0x0b69
+#define PMU_DMEM_RANK0_SLICE_START	0x0b6a
+#define PMU_DMEM_RANK_BOUNDARY		0x0b6b
+#define PMU_DMEM_RANK1_SLICE_START	0x0b6c
+#define PMU_DMEM_RANK1_SLICE_END	0x0b6d
+#define PMU_DMEM_DELAY_CAL_RESULTS	0x0b70
+#define PMU_DMEM_DESKEW_SWAP		0x0b72U
+#define PMU_DMEM_DESKEW_NORM		0x0b76U
+#define PMU_DMEM_BEST_TAP_ARR		0x0b7aU
+#define PMU_DMEM_LANE_ACTIVE_FLAGS	0x0b96
+#define PMU_DMEM_ACTIVE_SLICE_MASK_CAL	0x0b98
+#define PMU_DMEM_EYE_SAMPLE_BUF		0x0dc8
+#define PMU_DMEM_SWEEP_SAMPLE_BUF	0x6318
+#define PMU_DMEM_SWEEP_BLINK_OFF	0x6594U
+#define PMU_DMEM_CBT_DELAY_ARR_OFF	0xe798U
+
+/* ========================================================================== */
+/* Calibration Descriptor & Step Tracker Geometry                             */
+/* ========================================================================== */
+
+#define PMU_SLICE_DESC_SIZE		54U
+#define PMU_SLICE_DESC_COUNT		4U
+#define PMU_SLICE_DESC_TOTAL_BYTES	(PMU_SLICE_DESC_COUNT * PMU_SLICE_DESC_SIZE)
+#define PMU_SLICE_DESC_MR1_OFF		0x01U
+#define PMU_SLICE_DESC_MR2_OFF		0x02U
+#define PMU_SLICE_DESC_MR3_OFF		0x03U
+#define PMU_SLICE_DESC_MR16_OFF		0x10U
+#define PMU_SLICE_DESC_MR41_OFF		0x29U
+#define PMU_TRACKER_SLOTS_BYTES		32U
+
+/* ========================================================================== */
+/* Synopsys DDR PHY Internal APB CSRs (0x90000000 Base)                       */
+/* ========================================================================== */
+
+#define PHY_DBYTE_SLICE_STRIDE		0x2000UL
+#define PHY_REG_PUB_BASE		0x90000000UL /* Half: PHY APB base aperture */
+#define PHY_REG_AC_COARSE_TIMING	0x90000020UL /* Half: PHY AC coarse timing reg */
+#define PHY_REG_AC_FINE_TIMING		0x90000024UL /* Half: PHY AC timing register */
+#define PHY_REG_STROBE_CAL_EN		0x90000148UL /* Half: Strobe cal mode enable */
+#define PHY_REG_STREAM_ALT_BASE		0x9001e000UL /* Half: Alt APB stream base */
+#define PHY_REG_DBYTE_BASE		0x90020000UL /* Base address for DBYTE slice CSRs */
+#define PHY_REG_OP_MODE			0x90020012UL /* Channel-indexed PHY operating mode */
+#define PHY_REG_DBYTE_XCVR_GATE		0x9002001eUL /* Half: DBYTE xcvr gate ctrl */
+#define PHY_REG_DBYTE_DELAY_CNT		0x90020028UL
+#define PHY_REG_DBYTE_ANALOG		0x90020054UL /* Half: DBYTE analog delay tap */
+#define PHY_REG_DBYTE_EYE_DELAY		0x9002009cUL /* Half: DBYTE eye sweep delay */
+#define PHY_REG_DBYTE_COARSE_STEP	0x900200e4UL /* Half: DBYTE coarse step reg */
+#define PHY_REG_DBYTE_DQ_SWIZZLE_BASE	0x90020100UL /* Half: DBYTE Slice 0 delay register base */
+#define PHY_REG_DBYTE_GATE_STAT		0x9002011aUL /* Half: DBYTE sample status */
+#define PHY_REG_DBYTE_WCK_DLY		0x90020146UL /* Half: DBYTE WCK delay reg */
+#define PHY_REG_DBYTE_COARSE		0x90020154UL /* Half: DBYTE coarse gate delay */
+#define PHY_REG_DBYTE_EYE_CTRL		0x90020158UL /* Half: DBYTE eye sweep ctrl */
+#define PHY_REG_DBYTE_DQ_DLY0		0x90020160UL /* Half: DBYTE DQ delay 0 reg */
+#define PHY_REG_DBYTE_SAMPLE_RDY	0x9002016aUL /* Half: DBYTE sample ready reg */
+#define PHY_REG_DBYTE_LCDL_STAT		0x9002016eUL /* Half: DBYTE LCDL gate status */
+#define PHY_REG_DBYTE_CAL_TRIG		0x90020176UL /* DBYTE calibration strobe sequence */
+#define PHY_REG_DBYTE_PERIOD		0x900201aaUL /* Half: DBYTE period meas reg */
+#define PHY_REG_DBYTE_PLL_TIER		0x900201b2UL /* Half: DBYTE PLL rate tier cfg */
+#define PHY_REG_DBYTE_PLL_LOCK		0x900201c0UL /* Half: DBYTE PLL lock status */
+#define PHY_REG_DBYTE_UPPER_GATE	0x90021f6aUL /* Half: DBYTE gate control reg */
+#define PHY_REG_DBYTE_BCAST_BASE	0x9003e000UL
+#define PHY_REG_DBYTE_BCAST_PULSE	0x9003e002UL /* Half: DBYTE bcast win valid */
+#define PHY_REG_DBYTE_BCAST_GATE	0x9003e00aUL /* Half: DBYTE bcast pulse ctrl */
+#define PHY_REG_DBYTE_BCAST_MODE	0x9003e012UL /* Half: DBYTE bcast mode reg */
+#define PHY_REG_DBYTE_BCAST_VREF	0x9003e014UL /* Half: DBYTE bcast Vref ctrl */
+#define PHY_REG_DBYTE_BCAST_WIDTH	0x9003e016UL /* Half: DBYTE bcast pulse width */
+#define PHY_REG_DBYTE_BCAST_XCVR_GATE	0x9003e01eUL /* Half: DBYTE bcast gate ctrl */
+#define PHY_REG_DBYTE_BCAST_TX_CTRL	0x9003e02cUL /* Half: DBYTE bcast ctrl */
+#define PHY_REG_DBYTE_BCAST_PWR_GATE	0x9003e034UL /* Half: DBYTE bcast power gate */
+#define PHY_REG_DBYTE_BCAST_STROBE	0x9003e080UL
+#define PHY_REG_DBYTE_BCAST_CBT		0x9003e144UL
+#define PHY_REG_DBYTE_BCAST_RX_EN	0x9003e14eUL
+#define PHY_REG_DBYTE_BCAST_EYE		0x9003e158UL
+#define PHY_REG_DBYTE_BCAST_DQ_DLY0	0x9003e160UL
+#define PHY_REG_DBYTE_BCAST_DQ_DLY1	0x9003e162UL
+#define PHY_REG_DBYTE_BCAST_DQ_DLY2	0x9003e166UL
+#define PHY_REG_DBYTE_BCAST_DQ_DLY3	0x9003e168UL
+#define PHY_REG_DBYTE_BCAST_SAMPLE_RDY	0x9003e16aUL
+#define PHY_REG_DBYTE_BCAST_DQS_DLY0	0x9003e172UL
+#define PHY_REG_DBYTE_BCAST_DQS_DLY1	0x9003e174UL
+#define PHY_REG_DBYTE_BCAST_TRIG	0x9003e176UL /* Half: DBYTE bcast gate commit */
+#define PHY_REG_DBYTE_BCAST_LANE	0x9003e17cUL
+#define PHY_REG_DBYTE_BCAST_WCK		0x9003e1b2UL
+#define PHY_REG_DBYTE_UPPER_SAMPLE_A	0x9003f16aUL /* Half: Upper DBYTE sample A */
+#define PHY_REG_DBYTE_UPPER_DLY0	0x9003fe20UL /* Half: DBYTE upper delay 0 */
+#define PHY_REG_DBYTE_UPPER_DLY1	0x9003fe22UL /* Half: DBYTE upper delay 1 */
+#define PHY_REG_DBYTE_UPPER_DLY2	0x9003fe24UL /* Half: DBYTE upper delay 2 */
+#define PHY_REG_DBYTE_UPPER_DLY3	0x9003fe26UL /* Half: DBYTE upper delay 3 */
+#define PHY_REG_DBYTE_UPPER_COARSE	0x9003ff54UL
+#define PHY_REG_DBYTE_UPPER_SAMPLE_B	0x9003ff6aUL /* Half: Upper DBYTE sample B */
+#define PHY_REG_DBYTE_UPPER_BCAST	0x9003ff7cUL
+#define PHY_REG_MASTER_BASE		0x90040000UL
+#define PHY_REG_CAL_STAT_CTRL0		0x90040008UL /* Half: PHY cal status ctrl A */
+#define PHY_REG_CAL_STAT_CTRL1		0x9004000cUL /* Half: PHY cal status ctrl */
+#define PHY_REG_MASTER_CFG		0x9004000eUL /* Master PUB configuration */
+#define PHY_REG_SLICE_STAT		0x90040018UL /* Slice / lane status register */
+#define PHY_REG_MASTER_DELAY		0x9004001aUL /* Half: Master profile delay */
+#define PHY_REG_CAL_STAT_CTRL2		0x90040022UL /* Half: PHY cal status ctrl */
+#define PHY_REG_PUB_ACK			0x9004002aUL /* Half: PUB status ack reg */
+#define PHY_REG_MASTER_PWR_GATE		0x90040034UL /* Half: Master power gate ctrl */
+#define PHY_REG_CLK_GATE		0x90040040UL /* Master PHY clock gate enable */
+#define PHY_REG_CLK_GATE_STAT		0x90040042UL /* Master clock gate acknowledge */
+#define PHY_REG_DESKEW_DLY0		0x90040044UL /* Deskew delay tap 0 */
+#define PHY_REG_DESKEW_DLY1		0x90040046UL /* Deskew delay tap 1 */
+#define PHY_REG_TIMER_DUMMY		0x90040048UL /* Half: Dummy APB turnaround read register */
+#define PHY_REG_CLK_TIMING_CTRL		0x9004004eUL /* Clock timing control */
+#define PHY_REG_PAD_CAL_CTRL		0x90040050UL /* Half: Master pad cal ctrl */
+#define PHY_REG_VREF_TRIM_CFG		0x90040054UL
+#define PHY_REG_CA_VREF_DAC		0x90040058UL /* Half: CA Vref DAC ctrl A */
+#define PHY_REG_PLL_CLK_CTRL		0x90040062UL /* Master PLL & clock control */
+#define PHY_REG_VREF_CTRL		0x90040082UL /* Receiver Vref control */
+#define PHY_REG_VREF_STAT		0x90040084UL /* Half: Gate settle timing reg */
+#define PHY_REG_DRAM_TYPE_CFG		0x90040088UL
+#define PHY_REG_GATE_STAT		0x90040092UL /* Half: Gate pulse status reg */
+#define PHY_REG_ZQ_STAT			0x90040094UL /* Half: ZQ telemetry status 0 */
+#define PHY_REG_PHY_STATUS		0x900400c0UL /* Master PHY status & receiver clock */
+#define PHY_REG_MASTER_CAL_CTRL		0x900400dcUL
+#define PHY_REG_CH0_ANALOG_PWR		0x900400e4UL /* Ch0 analog power configuration */
+#define PHY_REG_CH1_ANALOG_PWR		0x900400e6UL /* Ch1 analog power configuration */
+#define PHY_REG_RESET_TRIGGER		0x900400f2UL /* Soft reset pulse toggle */
+#define PHY_REG_GATE_MASK		0x900400f4UL
+#define PHY_REG_GATE_CTRL		0x900400fcUL
+#define PHY_REG_CH0_RANK_CFG		0x90040100UL
+#define PHY_REG_CH1_RANK_CFG		0x90040102UL
+#define PHY_REG_RFIFO_CFG		0x90040110UL /* Half: RFIFO cfg base */
+#define PHY_REG_RFIFO_SUPPRESS		0x90040116UL /* Half: RFIFO suppress ctrl */
+#define PHY_REG_MASTER_INIT_CTRL	0x90040120UL /* Half: Master init ctrl */
+#define PHY_REG_CBT_CTRL		0x90040144UL /* CBT control register */
+#define PHY_REG_CAL_TRIG		0x90040146UL /* Calibration strobe trigger */
+#define PHY_REG_CAL_STAT		0x90040148UL /* Calibration status & configuration */
+#define PHY_REG_MASTER_COARSE_CFG	0x90040154UL /* Half: Master coarse gate cfg */
+#define PHY_REG_CBT_STAT0		0x90040180UL /* Half: CBT status reg */
+#define PHY_REG_CBT_STAT1		0x90040182UL /* Half: CBT status reg */
+#define PHY_REG_CBT_STAT2		0x90040184UL /* Half: CBT status reg */
+#define PHY_REG_AC_PLL_CTRL		0x900401c0UL
+#define PHY_REG_CBT_PLL			0x900401f0UL /* CBT PLL control register */
+#define PHY_REG_CMD_DISPATCH		0x90040238UL /* Command dispatch strobe */
+#define PHY_REG_CLK_PHASE_BASE		0x90040600UL
+#define PHY_REG_CLK_PHASE_DELAY		0x90040628UL
+#define PHY_REG_PUB_SEC_BASE		0x9005e000UL
+#define PHY_REG_SEC_CLK_GATE		0x9005e0a4UL /* Secondary clock gate toggle */
+#define PHY_REG_SEC_CAL_CTRL		0x9005e0b2UL
+#define PHY_REG_SEC_PUB_CTRL0		0x9005e0eeUL /* Half: Sec PUB ctrl */
+#define PHY_REG_PUB_CAL_STROBE		0x9005e140UL /* Secondary calibration strobe */
+#define PHY_REG_SEC_PUB_CTRL1		0x9005e14aUL /* Half: Sec PUB ctrl */
+#define PHY_REG_AC_BASE			0x90060000UL /* Half: AC slice profile base */
+#define PHY_AC_PIN_DELAY_BASE		0x90060002UL /* AC pin delay base */
+#define PHY_AC_BASE_OFFSET_CTRL		0x90060004UL /* AC base offset control */
+#define PHY_REG_AC_SLICE_CFG		0x9006005cUL
+#define PHY_AC_SWIZZLE_S0_BASE		0x90060120UL /* AC slice 0 pin swizzle base */
+#define PHY_REG_AC_PLL_LOCK		0x9006017eUL /* Half: AC PLL lock status B */
+#define PHY_AC_MASTER_DESKEW0		0x90061002UL /* AC master deskew 0 */
+#define PHY_AC_MASTER_DESKEW1		0x90061202UL /* AC master deskew 1 */
+#define PHY_AC_GATE_CTRL_RESET		0x90061e02UL /* AC gate control reset */
+#define PHY_AC_SWIZZLE_S1_BASE		0x90062120UL /* AC slice 1 pin swizzle base */
+#define PHY_AC_PROFILE_LANE_BASE	0x9007e002UL /* AC profile lane base */
+#define PHY_AC_PROFILE_MASTER_CTRL	0x9007e004UL /* AC profile master control */
+#define PHY_REG_PLL_STATUS		0x9007e034UL /* PLL lock status */
+#define PHY_REG_AC_DRIVE_CFG0		0x9007e05cUL
+#define PHY_REG_AC_DRIVE_CFG1		0x9007e066UL
+#define PHY_REG_AC_DRIVE_CFG2		0x9007e068UL
+#define PHY_REG_AC_DRIVE_CFG3		0x9007e080UL
+#define PHY_REG_AC_DRIVE_CFG4		0x9007e082UL
+#define PHY_REG_AC_DRIVE_CFG5		0x9007e084UL
+#define PHY_REG_AC_DRIVE_CFG6		0x9007e086UL
+#define PHY_REG_AC_BCAST_GATE		0x9007e108UL
+#define PHY_REG_CSR_RESULT_STREAM	0x90082000UL /* Half: PHY CSR result stream */
+#define PHY_REG_BIST_PLL_CFG		0x900e0022UL /* Half: AC ctrl read source */
+#define PHY_REG_DESKEW_QUAD_TAP		0x900e0048UL /* Half: Deskew quad-tap base */
+#define PHY_REG_AC_PAT_CTRL		0x900e00c0UL
+#define PHY_REG_PLL_CFG			0x900e00c2UL /* Master PLL configuration parameter 0 */
+#define PHY_REG_AC_TX_EN_BCAST		0x900e00caUL /* AC transmitter broadcast enable */
+#define PHY_REG_AC_BCAST		0x900fe022UL /* Half: AC bcast write target */
+#define PHY_REG_BIST_CTRL_MODE		0x900fe0c0UL /* Half: AC bcast test pattern A */
+#define PHY_REG_AC_BCAST_PAT_DATA	0x900fe0caUL /* Half: AC bcast test pattern B */
+#define PHY_REG_AC_BCAST_PAT_CFG	0x900fe1acUL /* Half: AC bcast pattern ctrl B */
+#define PHY_REG_AC_BCAST_PAT_CTRL	0x900fe1aeUL /* Half: AC bcast pattern ctrl */
+#define PHY_REG_BIST_PAT_CTRL0		0x900ffe4cUL
+#define PHY_REG_BIST_PAT_CTRL1		0x900ffe4eUL
+#define PHY_REG_CSR_SCRATCH_BASE	0x90120052UL /* Half: PUB CSR scratchpad */
+#define PHY_REG_CAL_LATCH_STREAM	0x90121000UL
+#define PHY_REG_CAL_RESTORE_TRIG	0x9013e050UL
+#define PHY_REG_SHADOW_TRACK_BASE	0x90140000UL /* Half: Shadow track aperture */
+#define PHY_REG_MAILBOX_STAT		0x90180008UL /* Mailbox status */
+#define PHY_REG_MAILBOX_STREAM		0x90180064UL /* Mailbox stream low */
+#define PHY_REG_MAILBOX_TRIG		0x90180066UL /* Mailbox interrupt trigger */
+#define PHY_REG_PUB_CFG			0x90180100UL
+#define PHY_REG_PUB_CTL			0x901801dcUL /* PUB control */
+#define PHY_REG_SHADOW_CNT		0x9018021eUL /* Half: Shadow stream count reg */
+
+/* ========================================================================== */
+/* ARC EM4 Auxiliary Timer Registers                                          */
+/* ========================================================================== */
+
+#define PMU_AUX_RTC_CTRL		0x103 /* AUX 259: RTC control / enable register */
+#define PMU_AUX_RTC_LOW			0x104 /* AUX 260: RTC low 32-bit counter */
+#define PMU_AUX_RTC_HIGH		0x105 /* AUX 261: RTC high 32-bit counter */
+
+/* ========================================================================== */
+/* PMU Firmware Identifiers & Assertion Error Codes                           */
+/* ========================================================================== */
+
+#define PMU_FW_VERSION_ID		0x230bU
+#define PHY_CSR_SCRATCH_MAGIC_LO	0x55aaU
+#define PHY_CSR_SCRATCH_MAGIC_HI	0xaa55U
+#define PMU_ERR_PLL_LOCK_TIMEOUT	0x00240000UL
+#define PMU_ERR_CLK_GATE_TIMEOUT	0x00250000UL
+#define PMU_ERR_ZQ_CAL_LOW_FREQ		0x00430000UL
+#define PMU_ERR_ZQ_CAL_HIGH_FREQ	0x00470000UL
+#define PMU_ERR_EYE_RANK_LIMIT_1	0x00920001UL
+#define PMU_ERR_EYE_RANK_MODE_INVALID	0x00930001UL
+#define PMU_ERR_RANK_BOUNDS_BASE	0x009d0003UL
+#define PMU_ERR_EYE_STEP_ALIGN_MISMATCH	0x00a40003UL
+#define PMU_ERR_DESKEW_SAMPLE_CHECK	0x01160000UL
+#define PMU_ERR_RX_FIFO_SCAN_OVERFLOW	0x011c0000UL
+#define PMU_ERR_LPCA_CLK_GATE_PRECOND	0x01280000UL
+#define PMU_ERR_AC_STEP_COORD_ADJUST	0x019f0003UL
+#define PMU_ERR_BIST_PATTERN_IDX_INVALID	0x01a40001UL
+#define PMU_ERR_BIST_VALIDATION_MODE	0x01a50000UL
+#define PMU_ERR_BIST_CMD_MODE_INVALID	0x01a80001UL
+#define PMU_ERR_EYE_SLICE_REG_SOURCE	0x01ab0000UL
+#define PMU_ERR_EYE_WINDOW_TOO_NARROW	0x01b10006UL
+#define PMU_ERR_EYE_SWEEP_CONVERGENCE	0x01f60000UL
+#define PMU_ERR_CMD_SUBCODE_INVALID	0x02190001UL
+#define PMU_ERR_CSR_BUS_ACCESS_FAULT	0x02240000UL
+#define PMU_ERR_WCK_EYE_ZERO_WIDTH	0x022e0003UL
+#define PMU_ERR_VREF_STEP_DIR_INVALID	0x02350000UL
+#define PMU_ERR_BIST_PATTERN_MODE_RANGE	0x027e0001UL
+#define PMU_ERR_COARSE_DELAY_OVERFLOW	0x02a80000UL
+
+#endif /* _DWC_DDRPHY_PMU_REGS_H */
diff --git a/arch/arm/mach-sunxi/pmu/pmu.ld b/arch/arm/mach-sunxi/pmu/pmu.ld
new file mode 100644
index 00000000000..79ff0f8c0c4
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/pmu.ld
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Linker script for Allwinner A733 LPDDR5 ARC EM4 PMU Firmware
+ */
+
+OUTPUT_FORMAT("elf32-littlearc", "elf32-littlearc", "elf32-littlearc")
+OUTPUT_ARCH(arc)
+ENTRY(pmu_vector_table)
+
+SECTIONS
+{
+	.vectors 0x00000000 : {
+		KEEP(*(.vectors))
+	} = 0xe078
+
+	.text 0x00000080 : {
+		KEEP(*(.text.pmu_start))
+		KEEP(*(.text.pmu_default_exception_handler))
+		*(.text .text.*)
+	} = 0xe078
+
+	.rodata : { *(.rodata*) }
+	.data   : { *(.data*) *(.sdata*) }
+	.bss    : { *(.bss*) *(.sbss*) *(COMMON) }
+
+	/DISCARD/ : {
+		*(.comment)
+		*(.note*)
+		*(.eh_frame*)
+		*(.ARC.attributes)
+	}
+}
+
+ASSERT(SIZEOF(.rodata) == 0 && SIZEOF(.data) == 0 && SIZEOF(.bss) == 0,
+       "ARC ICCM is execute-only; .rodata/.data/.bss sections are forbidden")
+ASSERT(. <= 0x00010000, "PMU firmware exceeds 64 KiB ICCM")
diff --git a/arch/arm/mach-sunxi/pmu/pmu_fw.h b/arch/arm/mach-sunxi/pmu/pmu_fw.h
new file mode 100644
index 00000000000..e71955bdf5c
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/pmu_fw.h
@@ -0,0 +1,553 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Common declarations and external symbol prototypes for standalone
+ * Allwinner A733 DDR PHY PMU firmware modules.
+ */
+
+#ifndef _SUNXI_PMU_FW_H
+#define _SUNXI_PMU_FW_H
+
+#include "dwc_ddrphy_pmu_regs.h"
+
+/*
+ * ARC EM4 global architectural state registers pinned across all translation
+ * units via -ffixed-r26 and -ffixed-r27:
+ *   r26 (gp) = 0x80000400 (struct pmu_sdata base in DCCM)
+ *   r27 (fp) = reserved by firmware startup so GCC never clobbers r27
+ */
+
+/**
+ * dmem_ptr() - Convert a DCCM byte offset into an ARC DMEM pointer
+ * @offset: Byte offset within DCCM (or full 0x8000xxxx address)
+ *
+ * Return: Pointer to the target DCCM address.
+ */
+static inline void *dmem_ptr(u32 offset)
+{
+	return (void *)(uintptr_t)(PMU_DMEM_BASE | offset);
+}
+
+/**
+ * dmem_read8() - Read an unsigned 8-bit byte from DCCM
+ * @offset: Byte offset within DCCM (or full 0x8000xxxx address)
+ *
+ * Return: 8-bit value read from DCCM.
+ */
+static inline u8 dmem_read8(u32 offset)
+{
+	return *(__volatile__ u8 *)dmem_ptr(offset);
+}
+
+/**
+ * dmem_read16() - Read an unsigned 16-bit halfword from DCCM
+ * @offset: Byte-aligned halfword offset within DCCM
+ *
+ * Return: 16-bit value read from DCCM.
+ */
+static inline u16 dmem_read16(u32 offset)
+{
+	return *(__volatile__ u16 *)dmem_ptr(offset);
+}
+
+/**
+ * dmem_read32() - Read an unsigned 32-bit word from DCCM
+ * @offset: Word-aligned offset within DCCM
+ *
+ * Return: 32-bit value read from DCCM.
+ */
+static inline u32 dmem_read32(u32 offset)
+{
+	return *(__volatile__ u32 *)dmem_ptr(offset);
+}
+
+/**
+ * dmem_write8() - Write an unsigned 8-bit byte to DCCM
+ * @offset: Byte offset within DCCM (or full 0x8000xxxx address)
+ * @val: 8-bit value to write
+ */
+static inline void dmem_write8(u32 offset, u8 val)
+{
+	*(__volatile__ u8 *)dmem_ptr(offset) = val;
+}
+
+/**
+ * dmem_write16() - Write an unsigned 16-bit halfword to DCCM
+ * @offset: Halfword-aligned offset within DCCM
+ * @val: 16-bit value to write
+ */
+static inline void dmem_write16(u32 offset, u16 val)
+{
+	*(__volatile__ u16 *)dmem_ptr(offset) = val;
+}
+
+/**
+ * dmem_write32() - Write an unsigned 32-bit word to DCCM
+ * @offset: Word-aligned offset within DCCM
+ * @val: 32-bit value to write
+ */
+static inline void dmem_write32(u32 offset, u32 val)
+{
+	*(__volatile__ u32 *)dmem_ptr(offset) = val;
+}
+
+/**
+ * phy_read16() - Read a 16-bit DDR PHY CSR register in ARC MMIO space
+ * @addr: ARC PHY register address (0x9000xxxx)
+ *
+ * Return: 16-bit CSR value.
+ */
+static inline u16 phy_read16(u32 addr)
+{
+	return *(__volatile__ u16 *)(uintptr_t)addr;
+}
+
+/**
+ * phy_write16() - Write a 16-bit DDR PHY CSR register in ARC MMIO space
+ * @addr: ARC PHY register address (0x9000xxxx)
+ * @val: 16-bit CSR value to write
+ */
+static inline void phy_write16(u32 addr, u16 val)
+{
+	*(__volatile__ u16 *)(uintptr_t)addr = val;
+}
+
+/**
+ * struct pmu_sdata - PMU small-data (.sdata) state block at DCCM 0x80000400
+ * @cbt_dly_init: Clamped CBT delay line initial offset (0x400)
+ * @high_freq_flag: High-frequency operating mode flag (0x401)
+ * @cal_active_flag: Active calibration stage flag (0x402)
+ * @freq_mode: Frequency mode / CBT lane limit code (0x403)
+ * @timer_shift: Hardware timer prescaler shift factor (0x404)
+ * @stage_step_mode: Stage 10 margin status / step mode (0x405)
+ * @stage_rank_idx: Active calibration rank index (0x406)
+ * @stage_slice_idx: Active calibration slice index & flags (0x407)
+ * @stage_lane_idx: Active calibration lane index & mode (0x408)
+ * @metric_tbl_entries: Calibration metric table entry count (0x409)
+ * @rsvd0: Alignment padding halfword (0x40a)
+ * @active_slice_cnt: Active DBYTE slice count (0x40c)
+ * @active_ch_cnt: Active channel count / quadratic cost weight W (0x410)
+ * @rsvd1: Reserved word (0x414)
+ * @shadow_trace_ptr: Shadow trace buffer pointer (0x418)
+ * @active_csr_offset: Active channel PHY CSR address offset (0x41c)
+ * @fw_version_id: Firmware version ID / quadratic cost weight X (0x420)
+ * @num_ranks: Active rank count / quadratic cost weight Y (0x422)
+ * @rsvd_424: Reserved alignment word (0x424)
+ * @iter_count: Calibration stage iteration counter (0x428)
+ * @cal_save_cfg: Saved hardware calibration configuration mask (0x42a)
+ * @dbyte_slice_cnt: Active DBYTE slice limit (0x42c)
+ * @rsvd2: Alignment padding bytes (0x42d..0x42f)
+ * @rfifo_dly: Per-slice RFIFO delay parameters across 4 slices (0x430..0x437)
+ * @step_2d_ctrl: 2D eye sweep step control (0x438)
+ * @step_2d_param: 2D eye sweep step parameter (0x43a)
+ * @rsvd3: Alignment padding byte (0x43b)
+ * @master_dly_tbl: Master delay table [channel][rank] (0x43c..0x443)
+ * @ac_profile_dly: AC profile delay halfwords (0x444..0x447)
+ * @ac_profile_cfg: AC profile step configuration bytes (0x448..0x453)
+ * @saved_cal_stat: Saved calibration status word (0x454)
+ * @cal_marker_a: Calibration step marker A (0x458)
+ * @cbt_state: CBT state latch (0x45a)
+ * @cbt_step_ext: CBT step extension flag (0x45b)
+ * @cbt_cal_active: CBT calibration active flag (0x45c)
+ * @rsvd4: Alignment padding byte (0x45d)
+ * @cal_marker_b: Calibration step marker B (0x45e)
+ * @active_slice_mask: Active slice bitmask (0x460)
+ * @tracker_popcnt_acc: Tracker popcount accumulator (0x464)
+ * @ch_range_lim: Channel active range limit (0x468)
+ * @step_mode_ovr: Channel step mode override (0x469)
+ * @cbt_config: CBT configuration value (0x46a)
+ * @cbt_step_stat: CBT step status flag (0x46b)
+ * @cal_cmd_tbl: Shadow calibration command table [0..3] (0x46c..0x46f)
+ * @active_slice_idx: Active slice index (byte 0 is cal_cmd_tbl[4]) (0x470)
+ * @slice_timing_desc: Per-rank/slice timing descriptor bytes (0x474..0x47b)
+ * @cal_stride: Normalized power-of-2 step stride (0x47c)
+ * @deskew_target_dly: Pad timing / deskew target delay (0x47e)
+ * @cal_seq_map: 21-byte calibration sequence index map (0x480..0x494)
+ * @rsvd5: Alignment padding to 0x4c0 (0x495..0x4bf)
+ * @rank_ch_tap_tbl: Per-rank/channel tap table (0x4c0..0x4c3)
+ * @best_tap: Best WCK read-gate tap per channel and rank (0x4c4..0x4c7)
+ */
+struct pmu_sdata {
+	u8 cbt_dly_init;
+	u8 high_freq_flag;
+	u8 cal_active_flag;
+	u8 freq_mode;
+	u8 timer_shift;
+	u8 stage_step_mode;
+	u8 stage_rank_idx;
+	u8 stage_slice_idx;
+	u8 stage_lane_idx;
+	u8 metric_tbl_entries;
+	u16 rsvd0;
+	u32 active_slice_cnt;
+	u32 active_ch_cnt;
+	u32 rsvd1;
+	u32 shadow_trace_ptr;
+	u32 active_csr_offset;
+	u16 fw_version_id;
+	u16 num_ranks;
+	u32 rsvd_424;
+	u16 iter_count;
+	u16 cal_save_cfg;
+	u8 dbyte_slice_cnt;
+	u8 rsvd2[3];
+	u16 rfifo_dly[4];
+	u16 step_2d_ctrl;
+	u8 step_2d_param;
+	u8 rsvd3;
+	u16 master_dly_tbl[2][2];
+	u16 ac_profile_dly[2];
+	u8 ac_profile_cfg[12];
+	u32 saved_cal_stat;
+	u16 cal_marker_a;
+	u8 cbt_state;
+	u8 cbt_step_ext;
+	u8 cbt_cal_active;
+	u8 rsvd4;
+	u16 cal_marker_b;
+	u32 active_slice_mask;
+	s32 tracker_popcnt_acc;
+	u8 ch_range_lim;
+	u8 step_mode_ovr;
+	u8 cbt_config;
+	u8 cbt_step_stat;
+	u8 cal_cmd_tbl[4];
+	u32 active_slice_idx;
+	u8 slice_timing_desc[8];
+	u16 cal_stride;
+	u16 deskew_target_dly;
+	u8 cal_seq_map[21];
+	u8 rsvd5[43];
+	u8 rank_ch_tap_tbl[2][2];
+	u8 best_tap[2][2];
+};
+
+/**
+ * struct pmu_cal_tracker - Multi-channel calibration step tracker (0x80000d9c)
+ * @slot0: Primary 8-halfword channel 0 command slot (0x00..0x0f)
+ * @slot1: Secondary 8-halfword channel 1 command slot (0x10..0x1f)
+ * @slot1_mode: Channel 1 step mode control halfword (0x20)
+ * @repeat_cnt: Step repeat count minus one (0x22)
+ * @slot0_mode: Channel 0 step mode control halfword (0x24)
+ * @ext_flag: Step extension flag halfword (0x26)
+ * @commit_flag: Pending step commit flag halfword (0x28)
+ * @rsvd0: Alignment padding halfword (0x2a)
+ */
+struct pmu_cal_tracker {
+	u16 slot0[8];
+	u16 slot1[8];
+	u16 slot1_mode;
+	u16 repeat_cnt;
+	u16 slot0_mode;
+	u16 ext_flag;
+	u16 commit_flag;
+	u16 rsvd0;
+};
+
+/**
+ * pmu_sdata() - Access the PMU small-data (.sdata) structure via r26 (gp)
+ *
+ * Return: Volatile pointer to struct pmu_sdata at DCCM 0x80000400.
+ */
+#define PMU_SDATA_BASE		0x80000400UL
+
+static inline __volatile__ struct pmu_sdata *pmu_sdata(void)
+{
+	return (__volatile__ struct pmu_sdata *)PMU_SDATA_BASE;
+}
+
+_Static_assert(sizeof(struct pmu_sdata) == 0xc8,
+	       "struct pmu_sdata size mismatch");
+_Static_assert(offsetof(struct pmu_sdata, cbt_dly_init) == 0x00,
+	       "cbt_dly_init offset mismatch");
+_Static_assert(offsetof(struct pmu_sdata, active_ch_cnt) == 0x10,
+	       "active_ch_cnt offset mismatch");
+_Static_assert(offsetof(struct pmu_sdata, shadow_trace_ptr) == 0x18,
+	       "shadow_trace_ptr offset mismatch");
+_Static_assert(offsetof(struct pmu_sdata, active_csr_offset) == 0x1c,
+	       "active_csr_offset offset mismatch");
+_Static_assert(offsetof(struct pmu_sdata, fw_version_id) == 0x20,
+	       "fw_version_id offset mismatch");
+_Static_assert(offsetof(struct pmu_sdata, num_ranks) == 0x22,
+	       "num_ranks offset mismatch");
+_Static_assert(offsetof(struct pmu_sdata, best_tap) == 0xc4,
+	       "best_tap offset mismatch");
+
+/**
+ * pmu_tracker() - Access the primary calibration step tracker in DCCM
+ *
+ * Return: Volatile pointer to struct pmu_cal_tracker at DCCM 0x80000d9c.
+ */
+static inline __volatile__ struct pmu_cal_tracker *pmu_tracker(void)
+{
+	return (__volatile__ struct pmu_cal_tracker *)PMU_DMEM_CAL_TRACKER;
+}
+
+/**
+ * struct pmu_cal_bist_cmd_ctx - BIST command strobe context block
+ * @ctrl0: Primary command control word 0
+ * @ctrl1: Secondary command control word 1
+ * @ctrl2: Tertiary command control word 2
+ * @strobe_cmd_a: Strobe command pattern word C
+ * @strobe_cmd_b: Strobe command pattern word 10
+ * @stride_minus_1: Loop stride count minus one
+ * @rsvd0: Alignment padding halfword
+ * @csr_offset: Target PHY CSR channel/slice address offset
+ * @slice_delays: Per-slice 16-bit delay values across 4 slices
+ */
+struct pmu_cal_bist_cmd_ctx {
+	u32 ctrl0;
+	u32 ctrl1;
+	u32 ctrl2;
+	u32 strobe_cmd_a;
+	u32 strobe_cmd_b;
+	u16 stride_minus_1;
+	u16 rsvd0;
+	u32 csr_offset;
+	u16 slice_delays[4];
+};
+
+/* Cross-Module PMU Firmware Function Prototypes */
+void *memcpy(void *dest, const void *src, size_t n);
+void *memset(void *s, int c, size_t n);
+void pmu_ac_lane_profile_setup(void);
+void pmu_adjust_step_limit(u8 *pair, u32 flag);
+void pmu_assert_or_halt(u32 cond, u32 assert_code);
+u32 pmu_bist_pattern_bit_get(u32 shift, u32 mask);
+void pmu_cal_bist_cmd_strobe_dispatch(uintptr_t ctx_addr,
+				      u32 pattern_mode, u32 cmd_mode, u32 target_mask,
+				uintptr_t slice_flags_addr, u32 status_idx, u32 setup_flags);
+void pmu_cal_bist_pattern_setup(u32 pattern_idx, u32 slice_or_lane,
+				u32 enable_deskew_reset, u32 validation_mode);
+void pmu_cal_bist_search_win_setup(u32 stage);
+u32 pmu_cal_cbt_desc_unpack(u32 rank, u32 channel);
+void pmu_cal_channel_rank_bounds_verify(u32 err_id);
+u32 pmu_cal_channel_rank_config_get(u32 rank, u16 *out_cfg,
+				    u8 *out_mode_sel, u8 *out_num_slices);
+void pmu_cal_dbyte_bcast_pulse_width_clear(const u8 *cfg);
+void pmu_cal_dbyte_delay_backup_all_ch(void);
+void pmu_cal_dbyte_deskew_fine_tune(u32 mode);
+void pmu_cal_dbyte_gate_mask_clear(void);
+void pmu_cal_dbyte_pattern_loop_exec(u32 reg_offset,
+				     u16 pattern_mode, void *dest_buf, void *scratch_buf,
+				u32 bound_start, u32 bound_end, u32 flags);
+s16 pmu_cal_dbyte_rx_fifo_reset_poll(u32 channel, u32 mode_sel,
+				     u32 enable_scan, void *unused_buf);
+void pmu_cal_dbyte_sample_ready_poll_all(u32 flags);
+u32 pmu_cal_delay_line_accum_dispatch(u32 count, u32 limit);
+void pmu_cal_delay_line_init(void);
+void pmu_cal_deskew_quad_tap_set(u32 ch, u16 tap0, u16 tap1,
+				 u16 tap2, u16 tap3);
+u32 pmu_cal_eye_margin_quadratic_cost_calc(u32 val, u32 target,
+					   u32 min_bound, u32 max_bound, u8 *out_overflow);
+u32 pmu_cal_eye_margin_sample_latch(u32 mask, u32 lane);
+void pmu_cal_eye_param_block_init(u16 *param_block, u32 p1, u32 p2,
+				  u32 p3);
+void pmu_cal_eye_table_restore(u8 *dest, u32 offset);
+void pmu_cal_eye_table_save(const u8 *src, u32 offset);
+void pmu_cal_gate_eye_master_trigger(void);
+void pmu_cal_lane_deskew_sweep_exec(u32 channel);
+u32 pmu_cal_lane_error_status_check(u32 lane, u32 phase);
+void pmu_cal_lane_mask_and_all(u32 base, u32 offset, u32 mask);
+void pmu_cal_lane_mask_or_all(u32 base, u32 offset, u32 mask);
+void pmu_cal_lane_window_margin_eval(u32 mode);
+void pmu_cal_lane_window_sweep_coordinator(u32 ch_mask, u32 wide_range);
+void pmu_cal_lcdl_coarse_fine_pair_pack(u32 ch_idx, u32 threshold,
+					u32 limit, const u8 *pair_a,
+					const u8 *pair_b, const u8 *pair_c,
+					const u8 *pair_d, void *table_base);
+void pmu_cal_margin_dir_get(void);
+void pmu_cal_margin_matrix_scan_eval(u32 channel, u32 rank,
+				     u32 slice, u32 mode, u32 flag, u32 step);
+u16 pmu_cal_marker_status_update(void);
+u16 pmu_cal_marker_verify(void);
+void pmu_cal_marker_verify_and_buffer_clear(u32 flags);
+void pmu_cal_marker_win_step_prog(u32 marker0, u32 marker1,
+				  u32 win_param, u32 win_mode);
+void pmu_cal_multi_lane_deskew_sweep(u32 type, u32 ch_mask,
+				     u32 lane_mask);
+void pmu_cal_multi_rank_step_commit(u32 rank_mode, u32 steps_table,
+				    u32 eval_error_mask, u32 skip_mask_low, u32 skip_mask_high,
+				u32 pulse_coarse_pre, u32 check_settle_flags);
+void pmu_cal_multi_rank_timing_step(u32 rank_mode, u32 steps_table,
+				    u32 eval_error_mask, u32 skip_mask_low, u32 skip_mask_high,
+				u32 check_settle_flags);
+void pmu_cal_pad_impedance_lock(void);
+void pmu_cal_pad_timing_delay_set(u32 bypass_min_clamp, u32 steps,
+				  u32 use_fixed_unit);
+void pmu_cal_pad_timing_step_settle(void);
+u32 pmu_cal_pad_voltage_dac_set(u32 val, u32 mode);
+void pmu_cal_param_unpack(u32 val, u8 *out);
+void pmu_cal_phase_detector_edge_align(void);
+void pmu_cal_pll_lock_settle_spin(u16 *out_dbyte_pll, u16 *out_ac_pll);
+void pmu_cal_pulse_burst_send(u32 burst_type, u32 count, u32 slice);
+void pmu_cal_pulse_seq_coordinator(u32 ch_idx, u32 rank, u32 param1, u32 flags);
+void pmu_cal_rank_deskew_matrix_commit(u32 channel, u32 rank, void *buf);
+u32 pmu_cal_rank_margin_window_check(u32 tap_ptr, u32 channel,
+				     u32 slice_mask);
+u8 pmu_cal_rank_offset_get(u32 rank, u32 channel);
+void pmu_cal_rank_param_commit(u32 freq_pt, u32 mode_cfg, u32 step_lim,
+			       u32 type);
+void pmu_cal_rank_rx_en_delay_commit(u32 channel, u16 rank_flags,
+				     u32 cal_stage_mode, u32 stage);
+void pmu_cal_rx_dqs_delay_center(void);
+void pmu_cal_search_win_init(u32 base);
+void pmu_cal_search_win_max_calc(u32 channel, u32 rank, u32 dir);
+void pmu_cal_seq_table_timed_replay(const void *seq_table,
+				    u32 total_bytes);
+u32 pmu_cal_sequence_pulse_send(u32 cmd_flags, u32 pulse_type,
+				u32 phase_id, u32 param_code, u32 tap_idx, u32 slice_mask,
+				u32 extra);
+void pmu_cal_slice_deskew_result_commit(u32 channel, void *buf,
+					u32 flags);
+u32 pmu_cal_slice_mask_eval(void *table_buf);
+void pmu_cal_slice_step_diff_commit(u32 slice_idx, u16 *out_buf,
+				    u32 cal_mode);
+void pmu_cal_slice_step_diff_latch(u32 timing, u32 wait_ack);
+void pmu_cal_slice_step_eval_sweep(void *results_buf, u32 sweep_mode,
+				   u32 cal_mode, u32 channel_rank, u32 unused,
+				   u32 timing_val, u32 overflow_flag,
+				   const u16 *slice_delay_lut, u32 bound_flag,
+				   u32 remap_flag, const void *sweep_ctx);
+void pmu_cal_slice_timing_latch(u32 timing, u32 wait_ack);
+void pmu_cal_delay_accum_dispatch(u32 dram_type, u32 count,
+				  void *slice_base);
+u16 pmu_cal_stride_get(void);
+u32 pmu_cal_strobe_pulse_init(void);
+void pmu_cal_struct_mask_remap(void);
+void pmu_cal_timing_margin_envelope_scan(u32 channel, u32 rank, void *buf);
+void pmu_cal_timing_table_matrix_init(u8 *buf);
+u32 pmu_cal_tracker_csr_commit(__volatile__ void *tracker);
+void pmu_cal_tracker_reset_and_apb_zero(const void *buf, u32 len);
+u32 pmu_cal_tracker_step_advance(u32 marker, u32 count, u32 mode);
+void pmu_cal_training_flags_gate_update(u8 *descriptor);
+void pmu_cal_vref_dac_step_adjust(u32 stage_step);
+void pmu_cal_vref_search_center_update(void);
+void pmu_cal_vref_trim_cfg_latch(void);
+void pmu_cal_wck_ck_align_pulse_send(u32 ch, u32 rank);
+void pmu_cal_win_bounds_clear(void);
+u32 pmu_cal_window_params_dispatch(const u8 *params_buf,
+				   u16 base_val, u32 mode_flags);
+void pmu_cbt_3phase_pulse_dispatch(u32 cal_mode,
+				   const u8 *step_table, u32 step_idx, u32 flags);
+void pmu_cbt_3phase_pulse_seq(void);
+void pmu_cbt_cal_pulse_seq(u32 pulse_cmd);
+u32 pmu_cbt_delay_offset_lookup(u32 rank, u32 channel);
+void pmu_cbt_deskew_pulse_train(u32 pulse_cmd, u32 is_alternate);
+void pmu_cbt_strobe_pulse_train(u32 pulse_cmd, u32 is_stage2);
+void pmu_cbt_timing_pulse_coordinator(u16 cal_mode, u32 phase_sel);
+u32 pmu_channel_rank_avail_check(u32 channel, u32 rank);
+void pmu_channel_timing_deskew_reset(u32 dly_ac0, u32 dly_ac1,
+				     u32 dly_ac2, u32 dly_ac3, u32 target_slice);
+u32 pmu_stage_slice_flag_check(void);
+u32 pmu_check_freq_lt_3200(void);
+u32 pmu_check_stage(u32 val);
+void pmu_cal_marker_clear(void);
+void pmu_clk_gate_handoff(void);
+void pmu_clk_ratio_pulse_trigger(void);
+void pmu_cmd_code_map_log(u32 cmd_code, u32 sub_code);
+void pmu_dbyte_cal_step_latch(u32 fine_val, u32 coarse_val,
+			      u32 ch_flags);
+void pmu_dbyte_cal_strobe_pulse_seq(u32 mode, u32 val, u32 step);
+u32 pmu_dbyte_coarse_step_mask_sweep(u32 ch_idx, u32 step_val, u32 flag);
+void pmu_dbyte_deskew_phase_sample(u32 ch_base, u32 *out_mask,
+				   u32 sel_mask);
+void pmu_dbyte_dq_deskew_regs_save_and_ramp(u8 *out_a, u8 *out_b,
+					    u8 *out_c, u32 flag, u32 extra);
+void pmu_dbyte_lane_error_mask_calc(u32 mode, u32 slice_or_rank);
+void pmu_dbyte_rx_en_slice_pulse_eval(u32 mode, u32 slice_mask);
+void pmu_default_exception_handler(void);
+void pmu_delay_us(u32 count, u32 unit);
+u32 pmu_dly_line_repack(u32 val);
+u32 pmu_dly_reg_offset_select(u32 rank, u32 unused, u32 direction);
+void pmu_dmem_reg_stream_unpack(const void *cfg_desc);
+u8 pmu_dmem_training_flags_eval(void);
+u32 pmu_dram_cfg_bit13_check(u32 rank, u32 flag);
+void pmu_eye_centroid_avg_calc(const u16 *base_delays,
+			       u16 *out_left, u16 *out_right, u16 *out_width);
+void pmu_eye_margin_step_align(u8 *margin_cur, u8 *margin_target,
+			       u32 step_size);
+u32 pmu_eye_margin_window_search(u8 *samples, u32 reserved_arg);
+void pmu_cbt_cal_active_clear(void);
+void pmu_cbt_cal_active_set(void);
+void pmu_cbt_step_stat_set(void);
+u32 pmu_freq_delay_step_calc(u32 count, u32 unit);
+u32 pmu_freq_ratio_mult(u32 mult);
+u32 pmu_freq_scaled_timing_step_calc(void);
+u8 pmu_cbt_config_get(void);
+u8 pmu_cal_mode_flag_get(void);
+u32 pmu_lane_mask_bit_get(u32 word_idx, u32 bit_shift);
+u16 pmu_phy_cal_stat_read(void);
+u32 pmu_mr22_bit4_check(void);
+void pmu_hw_timer_delay(u32 count);
+u32 pmu_is_lpddr4(void);
+u32 pmu_is_lpddr5(void);
+void pmu_mailbox_post_cmd_dispatch(u32 cmd);
+int pmu_main_wrapper(void);
+u8 pmu_map_mask(u8 val, u32 index);
+s32 pmu_math_freq_scale_div(s32 val);
+s8 pmu_midpoint_deviation_calc(u32 val);
+void pmu_multiphase_pulse_seq_repeat(u32 phase_cmd, u32 param_val,
+				     u32 slice, u32 count);
+void pmu_multirank_slice_cal_dispatch(void *table_ptr,
+				      u32 eval_error_mask, u32 skip_mask_low, s32 skip_mask_high,
+				u32 ch_enable_mask, u32 check_settle_flags);
+u16 pmu_phy_ac_lane_timing_delay_set(u32 lane);
+void pmu_phy_analog_cfg_mode_set(u32 mode);
+void pmu_phy_cal_strobe_latch_setup(void);
+void pmu_phy_clk_gate_sync_pulse(void);
+void pmu_phy_clk_phase_toggle_pulse(void);
+void pmu_phy_dbyte_broadcast_enable(void);
+void pmu_phy_dbyte_cfg_unpack(void);
+u16 pmu_phy_delay_bound_margin_log(u32 slice);
+void pmu_phy_lcdl_delay_read(u16 *out_arr, u32 flag, u32 mode);
+void pmu_phy_mode_cfg_dispatch(u32 mode);
+void pmu_phy_pll_cfg_quad_write_stream(u32 reg_offset, u16 p0,
+				       u16 p1, u32 p2, u32 flags);
+void pmu_phy_pll_clock_divider_align(void);
+void pmu_phy_pll_lock_init(void);
+void pmu_phy_profile_param_program(void);
+u32 pmu_phy_query_operating_mode(void);
+void pmu_phy_dbyte_cal_trig_pulse(u32 slice, u32 bit_idx);
+void pmu_phy_reg_buffer_stream(void *buf, u32 count, u32 is_save);
+void pmu_phy_reg_offset_diff_adjust(u32 rank);
+void pmu_pll_clk_gate_cfg(void);
+void pmu_pll_lock_freq_tier_cfg(void);
+void pmu_pll_quad_param_tuple_stream(const u16 *param_array,
+				     u16 *out_ctr, u16 *base_ptr);
+void pmu_post_cmd_conditional_dispatch(u32 val);
+void pmu_phy_sec_cal_strobe_pulse(void);
+void pmu_phy_cal_trig_pulse(void);
+void pmu_phy_soft_reset_pulse(void);
+u16 pmu_rank_margin_channel_accum(u32 rank, u32 start_slice,
+				  u32 end_slice, u32 flags, u32 swap_mode);
+void pmu_rank_mask_multiparam_dispatch(u32 channel, u32 rank,
+				       u32 shadow_update);
+void pmu_rank_shadow_status_sample(void);
+void pmu_rank_slice_margin_eval(void);
+int pmu_sample_margin_center_eval(const u8 *samples,
+				  u8 *out_margins, u8 *out_mode);
+void pmu_cal_marker_pair_set(u16 val);
+void pmu_cbt_config_set(u8 val);
+void pmu_phy_deskew_dly0_set(u16 val);
+void pmu_phy_deskew_dly1_set(u16 val);
+void pmu_phy_clk_timing_set(u16 val);
+void pmu_slice_delay_step_program(u32 reg_base_off,
+				  const s16 *step_deltas, u32 format_mode, u32 shift_sel,
+				u32 stride_flag, u32 single_lane_flag);
+void pmu_slice_deskew_pulse_seq(u32 enable);
+void pmu_slice_lcdl_delay_collect(u32 param, void *out_buf, u32 count);
+void pmu_slice_metric_scan_and_program(void);
+void pmu_slice_lane_status_save(void);
+void pmu_start(void);
+u32 pmu_unpack_6(const u8 *p);
+u32 pmu_unpack_7(const u8 *p);
+void pmu_unpack_byte_pair(u32 val, u8 *out);
+__section(".vectors") void pmu_vector_table(void);
+void pmu_vref_signed_direction_pulse_dispatch(u32 slice_target,
+					      u32 vref_step);
+u32 pmu_window_centroid_calc(void *table_buf);
+void pmu_phy_pll_cfg_quad_write(u16 v0);
+
+#endif /* _SUNXI_PMU_FW_H */
diff --git a/arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h b/arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h
new file mode 100644
index 00000000000..0625a6f46dd
--- /dev/null
+++ b/arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Alastair D'Silva <alastair@d-silva.org>
+ *
+ * Synopsys DesignWare DDR PHY PMU Firmware & SPL Hardware ABI Definitions
+ * SoC: Allwinner A733 (Sun60i) / LPDDR5 PHY (Type 9)
+ *
+ * For detailed architecture, clean-room specification provenance, and memory
+ * map alignment, see doc/board/allwinner/a733-pmu.rst.
+ */
+
+#ifndef _SUNXI_PMU_ABI_H_
+#define _SUNXI_PMU_ABI_H_
+
+#if defined(__KERNEL__) || defined(__UBOOT__)
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/compiler_attributes.h>
+#else
+#include <stdint.h>
+#include <stdbool.h>
+#include <stddef.h>
+
+#ifndef __packed
+#define __packed		__attribute__((__packed__))
+#endif
+#ifndef __aligned
+#define __aligned(x)		__attribute__((__aligned__(x)))
+#endif
+#ifndef __always_inline
+#define __always_inline		inline __attribute__((__always_inline__))
+#endif
+#ifndef noinline
+#define noinline		__attribute__((__noinline__))
+#endif
+#ifndef __section
+#define __section(s)		__attribute__((__section__(s)))
+#endif
+
+#ifndef BIT
+#define BIT(nr)			(1UL << (nr))
+#endif
+
+#ifndef _PMU_TYPES_DEFINED_
+#define _PMU_TYPES_DEFINED_
+typedef unsigned char      u8;
+typedef unsigned short     u16;
+typedef unsigned int       u32;
+typedef unsigned long long u64;
+typedef signed char        s8;
+typedef signed short       s16;
+typedef signed int         s32;
+typedef signed long long   s64;
+#endif
+#endif
+
+/*
+ * Memory Map Base Addresses: Host ARM Physical vs ARC EM4 Microsequencer
+ */
+#define SUNXI_DRAM_PHY_CTRL_BASE    0x0aaa0000UL    /* PHY CSRs (APB Slave interface) */
+#define SUNXI_DRAM_PHY_IMEM_BASE    0x0a9a0000UL    /* ARC ICCM: Instruction Memory (64 KB) */
+#define SUNXI_DRAM_PHY_DMEM_BASE    0x0a9b0000UL    /* ARC DCCM: Data Memory (64 KB) */
+
+/*
+ * PMU Control & Mailbox Register Offsets (relative to SUNXI_DRAM_PHY_CTRL_BASE / 0x0aaa0000)
+ * Note: The PHY APB slave interface is strictly 16-bit. All host accesses
+ *       must use 16-bit readw / writew operations.
+ */
+#define PMU_REG_APB_MUX             0x0000  /* 0 = Host ARM owns APB, 1 = PMU ARC owns APB */
+#define PMU_REG_POLL_STAT           0x0008  /* Bit 0: 1 = PMU busy, 0 = msg pending / complete */
+#define PMU_REG_HANDOFF_0           0x0060  /* Handshake handoff 0 */
+#define PMU_REG_HANDOFF_1           0x0062  /* Handshake handoff 1 (write 1 to trigger, 0 to ack) */
+#define PMU_REG_STATUS_LO           0x0064  /* PMU status low 16 bits */
+#define PMU_REG_MAILBOX_INT         0x0066  /* Mailbox interrupt pulse / trigger */
+#define PMU_REG_STATUS_HI           0x0068  /* PMU status high 16 bits */
+#define PMU_REG_RESET               0x0132  /* MicroReset (0=run, bit 0=stall, bit 3=reset) */
+
+/*
+ * PMU Return Status Codes (read from PMU_REG_STATUS_LO | (PMU_REG_STATUS_HI << 16))
+ */
+#define PMU_STATUS_SUCCESS          0x00000007U /* Training completed successfully */
+#define PMU_STATUS_FATAL_ERROR      0x000000ffU /* Training failed assertion / aborted */
+
+/*
+ * PMU SequenceCtrl Flags (DMEM offset 0x10)
+ * Selects which calibration and training stages the PMU microsequencer executes.
+ */
+#define PMU_SEQ_DEV_INIT            BIT(0)  /* Bit 0:  Device init, PLL lock, CBT entry, ZQ cal */
+#define PMU_SEQ_STAGE_VREF          BIT(1)  /* Bit 1:  Receiver Vref voltage centering */
+#define PMU_SEQ_STAGE_DCD           BIT(2)  /* Bit 2:  Duty cycle distortion correction */
+#define PMU_SEQ_STAGE_DQS           BIT(3)  /* Bit 3:  Read/Write DQS strobe timing centering */
+#define PMU_SEQ_BIST_SEARCH_WIN     BIT(4)  /* Bit 4:  BIST test pattern search window setup */
+#define PMU_SEQ_SEARCH_WIN          BIT(6)  /* Bit 6:  High-resolution 2D eye margin search */
+#define PMU_SEQ_ZQ_CAL              BIT(7)  /* Bit 7:  ZQ pad output impedance & ODT calibration */
+#define PMU_SEQ_DESKEW_SWEEP        BIT(8)  /* Bit 8:  Per-bit DQ deskew delay line tuning */
+#define PMU_SEQ_MARGIN_STEP         BIT(9)  /* Bit 9:  Margin envelope boundary evaluation */
+#define PMU_SEQ_LANE_WIN_SWEEP      BIT(10) /* Bit 10: Lane window sweep & cross-lane matrix scan */
+#define PMU_SEQ_LPCA_INIT           BIT(12) /* Bit 12: Low-Power Command/Address training & init */
+
+/*
+ * Operating Mode:
+ * - FULL_TRAIN: Complete multi-stage LPDDR5 calibration sweep.
+ */
+#define PMU_SEQ_FULL_TRAIN          (PMU_SEQ_DEV_INIT | PMU_SEQ_STAGE_VREF | \
+				     PMU_SEQ_STAGE_DCD | PMU_SEQ_STAGE_DQS | \
+				     PMU_SEQ_BIST_SEARCH_WIN | PMU_SEQ_SEARCH_WIN | \
+				     PMU_SEQ_MARGIN_STEP | PMU_SEQ_LPCA_INIT)	/* 0x125f */
+
+/**
+ * struct pmu_message_block - Host-to-PMU parameter handshake mailbox
+ * @msg_misc: Miscellaneous control and debug flags
+ * @cfg_flags: Hardware configuration flags
+ * @rsvd0: Reserved padding at offset 0x02
+ * @pstate_flags: Power-state flags and channel offset (0x04)
+ * @rsvd1: Reserved padding at offset 0x05
+ * @dram_rate_mts: DRAM data rate in MT/s (3600 for 1800 MHz WCK)
+ * @pll_ratio: WCK:CK frequency ratio (0x08: 4 = 4:1, 2 = 2:1)
+ * @rsvd2: Reserved padding at offset 0x09
+ * @dfi_freq_ratio: DFI frequency divider ratio (0x0a)
+ * @assert_code: PMU 32-bit assert error code (overwritten on fatal error, 0x0c)
+ * @rsvd_0c: Reserved runtime byte at offset 0x0c
+ * @cal_misc_flags: Runtime calibration miscellaneous flags (0x0d)
+ * @ac_signed_step: Runtime signed AC timing step (0x0e)
+ * @train_mode_hi: Runtime upper training mode flags (0x0f)
+ * @sequence_ctrl: Training stage bitmask (PMU_SEQ_*)
+ * @post_threshold: Telemetry log filter threshold (0xff = disabled)
+ * @rsvd3: Reserved padding at offset 0x13
+ * @train_mode: Training mode / calibration state (0x14)
+ * @cal_ctrl: Calibration control flags (0x16)
+ * @rsvd4: Reserved padding at offsets 0x18..0x23
+ * @ch0_dq_width: Channel 0 total DQ bit width (16)
+ * @ch0_rank_en: Channel 0 active rank bitmask (0x03 = dual-rank)
+ * @rsvd5: Reserved padding at offsets 0x26..0x3e
+ * @ch1_dq_width: Channel 1 total DQ bit width (16)
+ * @ch1_rank_en: Channel 1 active rank bitmask (0x03 = dual-rank)
+ * @rsvd6: Reserved padding at offsets 0x41..0x59
+ * @mr1: Per-slice JEDEC MR1 values (clock and WL set config)
+ * @mr2: Per-slice JEDEC MR2 values (RL and nWR config)
+ * @mr3: Per-slice JEDEC MR3 values (PDDS, DBI, and bank org)
+ * @mr10: Per-slice JEDEC MR10 values (RDQS preamble/postamble)
+ * @mr11: Per-slice JEDEC MR11 values (CA and DQ ODT)
+ * @mr12: Per-slice JEDEC MR12 values (CA Vref)
+ * @mr13: Per-slice JEDEC MR13 values
+ * @mr14: Per-slice JEDEC MR14 values (DQ[7:0] Vref)
+ * @mr15: Per-slice JEDEC MR15 values (DQ[15:8] Vref)
+ * @mr16: Per-slice JEDEC MR16 values (FSP-WR/OP and CBT)
+ * @mr17: Per-slice JEDEC MR17 values (CK/CA ODT)
+ * @mr18: Per-slice JEDEC MR18 values (WCK ODT and CK-to-WCK sync)
+ * @mr19: Per-slice JEDEC MR19 values (DVFSC and WCK2DQ osc)
+ * @mr20: Per-slice JEDEC MR20 values (RDQS mode)
+ * @mr21: Per-slice JEDEC MR21 values
+ * @mr22: Per-slice JEDEC MR22 values
+ * @mr24: Per-slice JEDEC MR24 values (DFE)
+ * @mr25: Per-slice JEDEC MR25 values
+ * @mr26: Per-slice JEDEC MR26 values
+ * @mr27: Per-slice JEDEC MR27 values
+ * @mr28: Per-slice JEDEC MR28 values (ZQ reset/stop/interval)
+ * @mr30: Per-slice JEDEC MR30 values (DCA)
+ * @mr31: Per-slice JEDEC MR31 values
+ * @mr32: Per-slice JEDEC MR32 values
+ * @mr33: Per-slice JEDEC MR33 values
+ * @mr34: Per-slice JEDEC MR34 values
+ * @mr37: Per-slice JEDEC MR37 values (WCK2DQI interval)
+ * @mr40: Per-slice JEDEC MR40 values (WCK2DQO interval)
+ * @mr41: Per-slice JEDEC MR41 values (NT-ODT and PPRE)
+ * @rsvd7: Reserved padding at offsets 0xce..0xe7
+ * @pll_gate_ch: Per-channel PLL clock gate thresholds (0xe8..0xeb)
+ * @rsvd8: Reserved padding at offsets 0xec..0xff
+ * @dq_swap_en: Per-bit DQ pin swizzle enable flag (0x100)
+ * @lane_err_mask: Per-lane deskew error status mask (0x101)
+ * @train_feature_mask: Training feature override bitmask (0x102)
+ * @ca_vref_rank1: Initial CA Vref DAC setting for Rank 1 (0x103)
+ * @ca_vref_rank0: Initial CA Vref DAC setting for Rank 0 (0x104)
+ * @diff_tap_pair: Differential tap pair offset (0x105)
+ *
+ * Placed at the base of PMU DCCM (0x80000000 in ARC address space,
+ * 0x0a9b0000 in host physical address space). Written by U-Boot SPL
+ * prior to triggering PMU training execution.
+ */
+struct pmu_message_block {
+	u8  msg_misc;           /* 0x000 */
+	u8  cfg_flags;          /* 0x001 */
+	u16 rsvd0;              /* 0x002 */
+	u8  pstate_flags;       /* 0x004 */
+	u8  rsvd1;              /* 0x005 */
+	u16 dram_rate_mts;      /* 0x006 */
+	u8  pll_ratio;          /* 0x008 */
+	u8  rsvd2;              /* 0x009 */
+	u16 dfi_freq_ratio;     /* 0x00a */
+	union {
+		u32 assert_code;        /* 0x00c */
+		struct __packed {
+			u8 rsvd_0c;        /* 0x00c */
+			u8 cal_misc_flags; /* 0x00d */
+			s8 ac_signed_step; /* 0x00e */
+			u8 train_mode_hi;  /* 0x00f */
+		};
+	};
+	u16 sequence_ctrl;      /* 0x010 */
+	u8  post_threshold;     /* 0x012 */
+	u8  rsvd3;        /* 0x013 */
+	u16 train_mode;         /* 0x014 */
+	u16 cal_ctrl;        /* 0x016 */
+	u8  rsvd4[12];    /* 0x018..0x023 */
+	u8  ch0_dq_width;       /* 0x024 */
+	u8  ch0_rank_en;        /* 0x025 */
+	u8  rsvd5[25];    /* 0x026..0x03e */
+	u8  ch1_dq_width;       /* 0x03f */
+	u8  ch1_rank_en;        /* 0x040 */
+	u8  rsvd6[25];    /* 0x041..0x059 */
+	u8  mr1[4];             /* 0x05a */
+	u8  mr2[4];             /* 0x05e */
+	u8  mr3[4];             /* 0x062 */
+	u8  mr10[4];            /* 0x066 */
+	u8  mr11[4];            /* 0x06a */
+	u8  mr12[4];            /* 0x06e */
+	u8  mr13[4];            /* 0x072 */
+	u8  mr14[4];            /* 0x076 */
+	u8  mr15[4];            /* 0x07a */
+	u8  mr16[4];            /* 0x07e */
+	u8  mr17[4];            /* 0x082 */
+	u8  mr18[4];            /* 0x086 */
+	u8  mr19[4];            /* 0x08a */
+	u8  mr20[4];            /* 0x08e */
+	u8  mr21[4];            /* 0x092 */
+	u8  mr22[4];            /* 0x096 */
+	u8  mr24[4];            /* 0x09a */
+	u8  mr25[4];            /* 0x09e */
+	u8  mr26[4];            /* 0x0a2 */
+	u8  mr27[4];            /* 0x0a6 */
+	u8  mr28[4];            /* 0x0aa */
+	u8  mr30[4];            /* 0x0ae */
+	u8  mr31[4];            /* 0x0b2 */
+	u8  mr32[4];            /* 0x0b6 */
+	u8  mr33[4];            /* 0x0ba */
+	u8  mr34[4];            /* 0x0be */
+	u8  mr37[4];            /* 0x0c2 */
+	u8  mr40[4];            /* 0x0c6 */
+	u8  mr41[4];            /* 0x0ca */
+	u8  rsvd7[26];    /* 0x0ce..0x0e7 */
+	u16 pll_gate_ch[2];     /* 0x0e8..0x0eb */
+	u8  rsvd8[20];    /* 0x0ec..0x0ff */
+	u8  dq_swap_en;         /* 0x100 */
+	u8  lane_err_mask;      /* 0x101 */
+	u8  train_feature_mask; /* 0x102 */
+	u8  ca_vref_rank1;      /* 0x103 */
+	u8  ca_vref_rank0;      /* 0x104 */
+	u8  diff_tap_pair;      /* 0x105 */
+} __packed __aligned(2);
+
+#endif /* _SUNXI_PMU_ABI_H_ */
-- 
2.53.0

