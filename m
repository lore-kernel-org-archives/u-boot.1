Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB8C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9F083873;
	Tue, 22 Jul 2025 17:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kb6eO3PU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90BE83253; Tue, 22 Jul 2025 17:35:14 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ADF8833DB
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so57666755e9.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198512; x=1753803312; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=049L0s3h9yOijEiYkA30J0q9hOYHEcMfTegz4L/rO/o=;
 b=Kb6eO3PUP935EB6sCVrovClQZd5mBV08vuN/HzX8MljXf14KtPoIzKffvw6Arvo2GO
 FeT+KvnAHfuWOFboa/jvqsGKKkS7kXF6tpaJBAbj1l6Edl1VbuttYbSg8FKTMmr5asI2
 fm5n+OhhbaAqcc0uOBX9x9b6R2kZniAdjDTQ9ope6bsnW15kr2L/OV1OzFp7+/r/XDRa
 axPI/MfwJWvGcyifVcmxZLUk16UiwNb3POdD1+8tkDmh4ZxtXxJi6b81k58c8u58Vgnx
 Z9NPKrkDM+dlhitcw/XRa3RBUN2Lee2cMeBmcRXE9Ek20R/2bsRqnWmr9s8XKIlEe8w7
 oRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198512; x=1753803312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=049L0s3h9yOijEiYkA30J0q9hOYHEcMfTegz4L/rO/o=;
 b=H642Xc+b5znxnveWX4CILnxNTIATvLtQwU9T4kzpIeinCmZMmGdVAZMERIhDLKicvY
 z/o/a7EAulEOdnrYwk6ePy3nI470NA0V6lZqOKLRJcQXckbpImFFULl/zdbU7enTfIpY
 i6keQBFW7P/CeVv3fmeqFQUN53TMKvrJX1ygSAw+b8zAyBcKXBWPzfuW2kVRq9JQs9sZ
 OHkp+EY3a7xwDSl8JB+ZO87by07D7DBAvSf5WhBOW8ZXBPew0BB8a5OmXd1ilzn8i13t
 mGx58cRb2kLF1+tZeNnSgbJqgDfJrJMgIZRYvHsTeiY2AdyDjxz/ISC5TfPLFXhTCxFZ
 ou4Q==
X-Gm-Message-State: AOJu0YyREHeh9sbjgud4GK+ZOl15yPqfp+2xoClf9523W75/6IqdJq1o
 7R35mmxR+9MX+xtbbISr3BUFUZibr06K0sEQ+ndFiP8HZLDkcPLhzu0sR/QzZRn0Fpo=
X-Gm-Gg: ASbGncuDLmB37ytEUxqw9O+c3PIBoMmw5/tYtB+Iuz1msVzYlrcZXmZ06X2w10E+X7L
 GYDcfXqv2SDWul0W2OoOotLhdUV+VDjQvnwGrcOJn2T1hBTWnas1CIrC5vi9dFARHzKvt3lPNEx
 4wmhwu9qayYEnkcKQtnbVkiq4II/DxJQsXl2Wy6GLRrj+uiX4PjvXc22ZL3aSZ9aQDDbMyYF9E7
 5EMWUtdFnjP5GXpo557aeE26i60++S2dGv1vV3fYPaQ280BmZffCAxOZk6Bdue8h7zE38rWobvQ
 xi5D3oLB4krxsEKX/umt+aad6MA6+bUbCkWUIHLShTT7z/xWTh6C5oOeHdcjPPS1hJYUdZlxn8e
 xU4LWoALiJDpTWLSN+U6Snab6on3qwscSWz0TqrEbKLeQ6/jdI0c/3z4wg4kAbJGCjw==
X-Google-Smtp-Source: AGHT+IE/BbTQ/zNJW+hTyH6BlrXnsO0qt1PrD9C06IRt58xsCmZ9PQteYkavH+UvmahzaTeXCs2Jjw==
X-Received: by 2002:a05:600c:c118:b0:458:6733:fb43 with SMTP id
 5b1f17b1804b1-4586733fd37mr4484295e9.19.1753198511560; 
 Tue, 22 Jul 2025 08:35:11 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:10 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:54 +0200
Subject: [PATCH v5 4/8] tools: qcom: add mkmbn.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-4-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9174;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xoEpF+Oa4sw8AA56+RtsGihSqAWdcubclog+LJcT2W8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69StSl1UbuL3LvbnIZYbqTk21B3edk5NVq0WLyrxuv
 wiZ/1qto5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzEM43hf84DQ3Xxsts+T/9p
 un1/U/90WxfT6yBb2xlfZsY4LY+4/5nhN6uDYZ2gcvIHzltJ/ftDltdsm+S+hef6BwY1Y30psdm
 PnwMA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

From: Casey Connolly <casey.connolly@linaro.org>

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
 tools/qcom/mkmbn/elf.py     |  36 +++++++++
 tools/qcom/mkmbn/hashseg.py |   4 +-
 tools/qcom/mkmbn/mkmbn.py   | 173 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+), 2 deletions(-)

diff --git a/tools/mkmbn b/tools/mkmbn
new file mode 120000
index 000000000000..a7b2096756f7
--- /dev/null
+++ b/tools/mkmbn
@@ -0,0 +1 @@
+qcom/mkmbn/mkmbn.py
\ No newline at end of file
diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
index 9fac35cfd5d2..86f12d1f4e5d 100644
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
index e73f6e94e163..11e6a7b39f0f 100644
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
index 000000000000..92e8fe101050
--- /dev/null
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -0,0 +1,173 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 Stephan Gerhold
+# Copyright (C) 2025 Casey Connolly
+#
+# This script is responsible for inspecting the u-boot.bin file produced by the build system
+# and creating a valid Qualcomm MBN file with dummy signatures. On boards where U-Boot replaces
+# the original EDK2 bootloader this is necessary for the pre-loader to accept the binary and
+# load it to the correct address.
+#
+# If you intend to chainload U-Boot (e.g. by building an Android boot image) then you can safely
+# ignore this script.
+#
+# If you are attempting to build U-Boot for a new dev board or other secureboot disabled device
+# then you will need to add an entry to the lookup table below with your board/platform compatible
+# string, the load address, MBN version and SW ID.
+#
+# Additional documentation can be found in doc/board/qualcomm/signing.rst
+#
+
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
+    b"qcom,ipq5424-rdp466\0": MbnData(0x50000000, 6, SwId.aboot), #, "qcom,ipq5424"
+    b"qcom,ipq5424\0": MbnData(0x50000000, 6, SwId.aboot),
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
2.50.1

