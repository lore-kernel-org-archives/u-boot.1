Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2DCC71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D588E82F35;
	Fri, 13 Jun 2025 19:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TyNR1Kde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0C682EC6; Fri, 13 Jun 2025 19:23:18 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD6AF82E5A
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1347415f8f.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835396; x=1750440196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HSctOsDtr3cTSaNvhQwXc7JUjvmoXsiNTRopqGQ4n10=;
 b=TyNR1KdeDba6d+etNux0IlJi/PDLvXMm0ur4XeLAxZawxGCE5xAglugz3xQhWjmuD4
 bkF+UtXKcCWa6DNmamfUjO2CTgHZNiFcoHykAQ4/Wnc+oHKgQAPRYEbdiy1UtokaL5Lm
 cGI/Rx3AFff9Wr9aAjuDp22j6NN6YtDfmjSAegE44eyu+8q4vgCPbe7yk2NeXTYdMFA9
 NtHH7lTnlf653A2yCOdiE+4aWBgDQCUHimGlORx77EoQta2ko8j4ow615Etqu0satbTJ
 O5Sp0IgUA5w7UHlb9zY5CW0etybd8clSD1HDVNoPmpZWeWi6e2Ed51onLkGLJrnk0WvI
 EjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835396; x=1750440196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSctOsDtr3cTSaNvhQwXc7JUjvmoXsiNTRopqGQ4n10=;
 b=ugkftPFsdnSBt0HAsq6Yri6X6vmtipNv0UBV71jcksxTGYENRSKuHz+D+3cDCGggWQ
 JZhKaXJZYVYTvrt1vFd12ezHTGIkPql8QHVgohh5k11ymHjia1z1V1BokpAHD4oUlRAk
 JvugR6/373GlAt73WG2IqS8BriHbnGNYdd7AIP2416p7eoZagkVVf8okKlPboKEb2TMO
 FYDkbBFABNBQLw6/zauPYYZauBeXmY7okOAFrXbhSzWLzUFbQXNw8tqxejhLgcl+V5Xm
 FNecPttyG7aXkoFqzgIpAeaTjtimIL7sC+qk+MT4WBDdfWwxH9HudaK7LDZB8apJGfbT
 a/mA==
X-Gm-Message-State: AOJu0Ywni96I8hEOcX2L/eiQhcTEZn8KhMOUmim7D843pdcUlw1k7A8R
 igx2F4K5M9bfBmjg6MejEQ96FI/gzsElb8ojPNCtbwDOQ+Vx6jC6jGx27jCTNKwy30s=
X-Gm-Gg: ASbGncu9nO6WUAkkx+2lYP4jQNMzCji7FxJ3wSaRSWFGHrdgtcQyCSqn3BH7cd8hEcI
 5xyH9BLRvr2sUO/ykAG91h1TdFs/88QkgZ0oLh115BEwMwHjqg5ecx6LN07D7l2epLXstlwFd+U
 x9Wc8zMhSOvBT/MNnR7rljxlG4s7fzF7piClm8cify7D84EHsLjcv9vVTATScj4hp+HQ41eXpfE
 5BN5gFfgEOSrC+MndglOFLh30T+E5uqnMvrV9vlMp5dDC5Sj9fezf5GVUZZL3osOoyBLag5Quar
 AQ1dNh+JLBTXZgsbc5r6qyRVrhi+O2FSMrTHeCcEXaLHKEPolaT/Xy0KGbMMvXenseyS
X-Google-Smtp-Source: AGHT+IE8VcBnl4sq1EDilpsFk3l46G6vghRpygnc9A+kQz4zd+Dhbd0Vpdx32cW73kOPtpBoFmHRAQ==
X-Received: by 2002:a05:6000:40dc:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3a572371fe7mr677316f8f.14.1749835396067; 
 Fri, 13 Jun 2025 10:23:16 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:08 +0200
Subject: [PATCH v4 4/8] tools: qcom: add mkmbn.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-4-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8452;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=vf4fO8Tsr3mu9qIbj0DbFpoiqpYcB8eR8sIaRFcEmpw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF56vfBlA/r5xm+j6AYHeXzs1S2WbgX+bkzml
 lsw851gRyiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeegAKCRAFgzErGV9k
 tkHsD/4umP8fbsX3oGljFv1VsVuliQ+0X8RlGxnHPgdQJbE5kbhCFsX5IH2BKr5r9iUBnteq7zi
 cgL6J6zFzwFqzcWBP70zBPsrKwbG1EIOqaSJqCfONbJBV7A7ac1PxTX1GOt/QjJEUtoq1QwMRq6
 nSDT2TWHQAN79dX/rTn6fshcFv57iazPUVaGsgyvnmyAz7AwQdXHMBWNT+7d4e3gQwtS7BKC0i4
 Xo/EzdHv/6o0PT8n/9ZBekxMXkt4igQWADFF5b+naUJXIDYg/Xv6n1DiBU5poE+cyZaSnszAolB
 p4EphGwKZOQgCf8JajyeVxUHX5bM+zEscuFoFW4VLMPaBxmjAG7AIjghsfZDsjxNKJedcAJ6eLL
 QPRDT6qABJZAOxbrHHvvrIebATdN1TnVchc/rQeKjkSj/Q3XIEQqYSDnAtrhRC6BSMP0eAucwyW
 qyk98c534HwEKJ9bHZlP1ZX5YYmRiC3TKzq7fzQZyKIPys/DJZYoz3lg7Fz5jSoPWZzg6x7ncD0
 MC+QUOukW8zQsSnGu/8mxm+Zq1BxwGqFxQTGXKSl0IBUgtz/uTUlcwbyJjoFywTSYj/YaJXKoPH
 aLL3qdKeanjpTMUWPTofFNDnlh64q2hmCKgfzoxcc6vArjkTqDlnKBV2YcS8VcJ93ima9sYqAEV
 EdhBkmyp38NIQfw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Adjust the elf class to support creating ELF files from scratch so that
mkmbn can build an MBN file from the U-Boot binary image and fix some
imports to work correctly in the U-Boot build system.

Since we already need to process the ELF file to produce a valid "MBN"
which sbl1 will accept, mkmbn additionally inspects the U-Boot binary,
finding the DTB and then checking for known compatible strings to
identify the board or platform.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/mkmbn                 |   1 +
 tools/qcom/mkmbn/elf.py     |  36 +++++++++++
 tools/qcom/mkmbn/hashseg.py |   4 +-
 tools/qcom/mkmbn/mkmbn.py   | 154 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/tools/mkmbn b/tools/mkmbn
new file mode 120000
index 0000000000000000000000000000000000000000..a7b2096756f76c07ca21e73c63f3b8be28a4cf59
--- /dev/null
+++ b/tools/mkmbn
@@ -0,0 +1 @@
+qcom/mkmbn/mkmbn.py
\ No newline at end of file
diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
index 9fac35cfd5d272a07ee56c3a2cebe36e6f9fbe4a..86f12d1f4e5deb102dd97d1616f64b7e3215b96e 100644
--- a/tools/qcom/mkmbn/elf.py
+++ b/tools/qcom/mkmbn/elf.py
@@ -44,8 +44,24 @@ class Ehdr:
 
 	CLASS32 = 1
 	CLASS64 = 2
 
+	# Init a qcom XBL style ELF header
+	def __init__(self):
+		self.ei_magic = b"\x7fELF"
+		self.ei_class = 2
+		self.ei_data = 1
+		self.ei_version = 1
+		self.ei_os_abi = 0
+		self.ei_abi_version = 0
+		self.e_type = 2
+		self.e_machine = 183
+		self.e_version = 1
+
+		self.e_ehsize = 64
+		self.e_phoff = 64
+		self.e_phentsize = 56
+
 	@staticmethod
 	def parse(b: bytes) -> Ehdr:
 		hdr_unpack = Ehdr.START_FORMAT.unpack_from(b)
 		hdr = Ehdr(*hdr_unpack)
@@ -106,8 +122,24 @@ class Phdr:
 			unpack.insert(-1, flags)
 
 		return Phdr(*unpack)
 
+	@staticmethod
+	def from_bin(b: bytes, loadaddr: int) -> Phdr:
+		# p_offset is fixed later
+		phdr = Phdr(
+			p_type=1,
+			p_offset=0xFFFFFFFF,
+			p_vaddr=loadaddr,
+			p_paddr=loadaddr,
+			p_filesz=len(b),
+			p_memsz=len(b),
+			p_flags=7,
+			p_align=0x1000,
+		)
+		phdr.data = memoryview(b)
+		return phdr
+
 	def save(self, f: BinaryIO, ei_class: int) -> int:
 		unpack = dataclasses.astuple(self)
 
 		if ei_class == Ehdr.CLASS32:
@@ -139,8 +171,12 @@ def _align(i: int, alignment: int) -> int:
 class Elf:
 	ehdr: Ehdr
 	phdrs: List[Phdr]
 
+	def __init__(self):
+		self.ehdr = Ehdr()
+		self.phdrs: List[Phdr] = []
+
 	def total_header_size(self):
 		return self.ehdr.e_phoff + len(self.phdrs) * self.ehdr.e_phentsize
 
 	@staticmethod
diff --git a/tools/qcom/mkmbn/hashseg.py b/tools/qcom/mkmbn/hashseg.py
index e73f6e94e163dd1e45cc341f76cfebf55685ded8..11e6a7b39f0fefeb0dd4ea86dd279e6dd4f96532 100644
--- a/tools/qcom/mkmbn/hashseg.py
+++ b/tools/qcom/mkmbn/hashseg.py
@@ -14,10 +14,10 @@ import hashlib
 from dataclasses import dataclass
 from io import BytesIO
 from struct import Struct
 
-from . import cert
-from . import elf
+import cert
+import elf
 
 # A typical Qualcomm firmware might have the following program headers:
 #     LOAD off    0x00000800 vaddr 0x86400000 paddr 0x86400000 align 2**11
 #          filesz 0x00001000 memsz 0x00001000 flags rwx
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
new file mode 100755
index 0000000000000000000000000000000000000000..94d85275c19c01c1e0aa64a61b615d14c10c0468
--- /dev/null
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -0,0 +1,154 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 Stephan Gerhold
+# Copyright (C) 2025 Casey Connolly
+from __future__ import annotations
+
+import argparse
+from pathlib import Path
+
+from elf import Elf, Phdr
+import hashseg
+import sys
+from enum import Enum
+
+verbose = False
+
+def log(*args, **kwargs):
+    if verbose:
+        print(args, kwargs, file=sys.stderr)
+
+def error(*args, **kwargs):
+    print("mkmbn: ", file=sys.stderr, end='')
+    print(*args, *kwargs, file=sys.stderr)
+
+
+
+class SwId(Enum):
+    sbl1 = 0x00
+    mba = 0x01
+    modem = 0x02
+    prog = 0x03
+    adsp = 0x04
+    devcfg = 0x05
+    tz = 0x07
+    aboot = 0x09
+    rpm = 0x0A
+    tz_app = 0x0C
+    wcnss = 0x0D
+    venus = 0x0E
+    wlanmdsp = 0x12
+    gpu = 0x14
+    hyp = 0x15
+    cdsp = 0x17
+    slpi = 0x18
+    abl = 0x1C
+    cmnlib = 0x1F
+    aop = 0x21
+    qup = 0x24
+    xbl_config = 0x25
+
+class MbnData:
+
+    # sw_id 0x9 is aboot/uefi, the most common
+    def __init__(self, loadaddr: int, version: int, sw_id: SwId = SwId.aboot):
+        self.loadaddr = loadaddr
+        self.version = version
+        self.sw_id = sw_id
+
+
+"""
+This dictionary is used to map a board or platform to the appropriate load address and
+other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
+data should be filled out here. The load address can typically be determined by looking
+at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
+for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
+at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+"""
+boards: dict[bytes, MbnData] = {
+    # Exact matches for boards, these are preferred
+    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.aboot),
+    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.aboot),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.aboot),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.aboot),  # Dragonwing IQ6
+    # Fallback/generic matches since most boards for a platform will
+    # use the same load address
+    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.aboot),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.aboot),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.aboot),  # Dragonwing IQ8
+    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.aboot),  # Dragonwing IQ6
+    b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+
+    # msm8916/apq8016 has an "aboot" partition but the process is the same
+    # They use header version 3.
+    b"qcom,apq8016\0": MbnData(0x8f600000, 3, SwId.aboot),
+    b"qcom,msm8916\0": MbnData(0x8f600000, 3, SwId.aboot),
+}
+
+parser = argparse.ArgumentParser(
+    description="""
+	Create a signed Qualcomm "uefi" ELF image
+"""
+)
+parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
+)
+parser.add_argument(
+    "-v", dest="verbose", action="store_true", default=False, help="Verbose"
+)
+parser.add_argument(
+    "bin", type=argparse.FileType("rb"), help="Binary to embed (e.g. u-boot.bin)"
+)
+args = parser.parse_args()
+
+elf = Elf()
+
+data: bytes = args.bin.read()
+
+# dtb is at the end, so find the last match
+dtb_off = 0
+off = 0
+while True:
+    off = data.find(b"\xd0\x0d\xfe\xed", dtb_off + 1)
+    if off == -1:
+        break
+    dtb_off = off
+
+if not dtb_off:
+    print("Couldn't find DTB in provided binary!")
+    exit(1)
+
+log(f"Found FDT at {dtb_off:#x}")
+
+mbn: MbnData|None = None
+
+for match, mbndata in boards.items():
+    if data.find(match, dtb_off) != -1:
+        mbn = mbndata
+        break
+
+if not mbn:
+    error(
+        "Not building an MBN file for this board, see tools/qcom/mkmbn/mkmbn.py for details"
+    )
+    # Bailing out would fail the build, and it's not possible to know if an MBN
+    # is actually needed for the board we're building for. Minimise confusion by removing
+    # any file that might exist from a previous build and exit with a known code.
+    args.output.unlink(missing_ok=True)
+    exit(61)
+
+log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
+
+elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
+elf.ehdr.e_entry = mbn.loadaddr
+elf.update()
+
+# QLI boards use v6 sw_id is "aboot"
+hashseg.generate(elf, mbn.version, mbn.sw_id.value)
+# print(f"after: {elf}")
+
+with open(args.output, "wb") as f:
+    elf.save(f)
+
+log(f"Built signed MBN: {args.output.resolve()}")

-- 
2.49.0

