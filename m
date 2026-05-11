Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC335CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C8783CD3;
	Mon, 11 May 2026 15:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NByMaGKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D49F84653; Mon, 11 May 2026 15:57:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A258394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bc23bebd345so403551966b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507875; x=1779112675; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JiTbv1ntNw0zBwBGG4FYd+0LUISH9umlDgcxhuUZK7Q=;
 b=NByMaGKZKy2h+ytms5prepshaIPq9HXU4FtqR3bbajprBIiQSsgDkWzCFSW9U4+THf
 5XPFd6a8Pla/uwjBk9MDDmU+w2WbQhwTYYHPYmAiBtNuwpvvsP/K2NLEpzmHwsPbSc1H
 zm8rcRulNXro8FP5xtxGNi9qkW5O9X75HMvWiigZStKTeAWMIliz5w6yv5GhycCXFc3B
 M3YX+63ugNm8O7kjuxTcb9XEaaKD+4J3oTQYqkza9IYtIR4978sW+Yqx/J35YGSqBCaT
 ax4wXvWK+sRRA6jClMyGpFS6RNUVo/gajTsFUu7/dCEuuDLHSW3uyDanBzUY4TOrptLW
 id1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507875; x=1779112675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JiTbv1ntNw0zBwBGG4FYd+0LUISH9umlDgcxhuUZK7Q=;
 b=eaUCcA0u0B7/KXiceKFnoPEOosMFidp+ouz+VN1g2mEwlMOSyYB/H+XjkZoaDgZ1uj
 yzXHzsDD31+F7oLNevHlYcH9mbz4KgvAf1VTdtTr3lnSq07574v6fN3MH+E/MnBX6cyJ
 NspUVBV80iQjRmZWGmmGzAVXoYXbAzoL7Rkgj/kzYiRpcN1bgX8hPpv3pyuIOdhLqu3A
 nR6/OdXaaafx0tRjnxvn5VLTqDaIjmz84Rp6dC1hetmk/FgoNwjGWXBGgW/dUo8jhjjy
 CeaJ6vZkr3wh0bwZMcmmdUEFZkczDYPcyPDi/Tvh47XErw22a+MpetgQ6T/htv0cBIJu
 kSlg==
X-Gm-Message-State: AOJu0Yy6AaAVyj8TxfdevAda4vm4CJtmqoH7sG3+iSosdOOPyYKaR73t
 3smdatWDrtP6msQirKm5JumAgNoAgEPY6s0agNAbQyGry6AeGiTFkt2kyd12DoqfmsM=
X-Gm-Gg: Acq92OGJD5p/B9x4APF6rWQtVcRRgEsWOPHPD4OA0JBbMOiA/ogNsWdetNx25y9VJkk
 3tuGnEJqRTe9sPfJOFH/HKDz1ueeEsvYuLauC7YV7FkLQWQK8OMnWqwdxzB8/rNShlcBtwjnd4k
 QWvn8ejCMqTQ9mu09Ho/Ivsul2iDnicwtnnxoSWUlsDJ/AbFDtyIDcEZ8MUjq53KisWM+TAEtDK
 LfHbNI151oSKh+sblL24DsSqKz6z0jY+WJtBKEnflLiyv5ZgxWkyrvLoNAzIzLGksETwenDh7KK
 /jWa2TI0YaDTUxCp9HlyadxumlWjfkRMDhIOpfLVBP9ZDuLLw50O0mWVF3eKNYmgWtHdNhNz//7
 2CfaGLdZ4G/S/aX2kw4xn7x2bFPO36OzHyhb5zYoDafiW+mdTG72pHYPRBgVAhNCkprYyffGcBt
 Q2N31Mslh9D8SdY9awXFYvmOmAp3Lrk81UQvrtqmLjXq1XaioQ7czkuUspUqp0/5OoyxlrmCd2Y
 8c/CqxNUyyP35Tr3A==
X-Received: by 2002:a17:906:ee84:b0:bc5:114c:956 with SMTP id
 a640c23a62f3a-bc84cc73483mr862110766b.1.1778507875082; 
 Mon, 11 May 2026 06:57:55 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3805377a12.14.2026.05.11.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:57:54 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 11 May 2026 15:57:45 +0200
Subject: [PATCH v7 3/6] tools: qcom: add mkmbn.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-b4-qcom-tooling-improvements-v7-3-0c06346e79a9@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8765;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qCCeU0T4p3Hzlzl8XWJ8BchZ+6/KH/zL9+4V1EWTcOk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizGB7E5K34bztTj3x67OzXsT77yXinm1akvMx7K+jwRX
 bb2043PHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiS+0YGZbXS9WlxnjsXObw
 7MKL2NK7Sab8kut01L9Le73jO/3hnijDP0sW1z37E44frpmp80oqOVJER3GH9LmJx+5P0rz062P
 zgscA
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

The new tool inspects the DTB embedded in u-boot.bin and uses a lookup
table to determine the appropriate configuration based on the root
compatible property, effectively encoding the info that was previously
kept in documentation.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/mkmbn                 |   1 +
 tools/qcom/mkmbn/elf.py     |  36 ++++++++++
 tools/qcom/mkmbn/hashseg.py |   4 +-
 tools/qcom/mkmbn/mkmbn.py   | 165 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/tools/mkmbn b/tools/mkmbn
new file mode 120000
index 000000000000..a7b2096756f7
--- /dev/null
+++ b/tools/mkmbn
@@ -0,0 +1 @@
+qcom/mkmbn/mkmbn.py
\ No newline at end of file
diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
index a5c4dad5ee01..4bd54239fbbe 100644
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
@@ -109,8 +125,24 @@ class Phdr:
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
@@ -142,8 +174,12 @@ def align(i: int, alignment: int) -> int:
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
index fe74761ae8df..db157a23d186 100644
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
index 000000000000..e4484b539b02
--- /dev/null
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -0,0 +1,165 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 Stephan Gerhold
+# Copyright (C) 2026 Casey Connolly
+#
+# This is a port of qtestsign designed to integrate with the
+# U-Boot build system. See the qtestsign repo for more information.
+# https://github.com/msm8916-mainline/qtestsign
+#
+from __future__ import annotations
+
+import argparse
+from pathlib import Path
+
+from elf import Elf, Phdr
+import hashseg
+import sys
+from enum import Enum
+import struct
+
+verbose = False
+
+def log(*args, **kwargs):
+    if verbose:
+        print(*args, *kwargs, file=sys.stderr)
+
+def error(*args, **kwargs):
+    print("mkmbn: ", file=sys.stderr, end='')
+    print(*args, *kwargs, file=sys.stderr)
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
+    uefi = 0x09
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
+    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    # Fallback/generic matches since most boards for a platform will
+    # use the same load address
+    b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
+    b"qcom,qcs9100\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
+    b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
+    b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
+    b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
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
+verbose = args.verbose
+
+elf = Elf()
+
+data: bytes = args.bin.read()
+
+# dtb is at the end, so find the last match
+dtb_off = 0
+off = 0
+dtb_size = 0
+while True:
+    off = data.find(b"\xd0\x0d\xfe\xed", dtb_off + dtb_size)
+    if off == -1:
+        break
+    (dtb_size,) = struct.unpack_from("I", data, offset=off)
+    dtb_off = off
+
+if not dtb_off:
+    print("Couldn't find DTB in provided binary!")
+    exit(1)
+
+log(f"Found FDT at {dtb_off:#x} size {dtb_size:#x}")
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
+        "CONFIG_QCOM_GENERATE_MBN is enabled but this platform doesn't appear to be supported\n"
+        "Please see tools/qcom/mkmbn/mkmbn.py for details. If you intend to chainload U-Boot\n"
+        "then disregard this message and disable CONFIG_QCOM_GENERATE_MBN in your defconfig."
+    )
+    args.output.unlink(missing_ok=True)
+    exit(1)
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
2.53.0

