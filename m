Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329F3C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3C682A8D;
	Mon,  2 Jun 2025 18:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iRyMGrIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502B681F32; Mon,  2 Jun 2025 18:11:08 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8E5828F8
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a361b8a66cso2766573f8f.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880666; x=1749485466; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3rBlczCLDuJeJVfwlHqjHo9naPJLzz7NV2CUVDyqSTk=;
 b=iRyMGrIjYxR6kMPny7Om5Fk0bCwZtQcZzvEh2JH7tn0qZbYcB8bes9/oCJX9zsmLKH
 5LeuZ7p2xXxDYEH2X9+XooXKR/jUH/BMZPazV1Ak7BD/Zb7imOQOamsdL4znP7LRvVCp
 GDdNi5/3PI/GPfrbegD1ny2jAl1KIMuv4ghGVK12Ox+xssmCtisZKH9x6X190mpL3vDj
 EghBDEatm35oxwRSPCPqSoKAIjtUBBu5VLwzk2w5tkKJuD/s/OaXHOTuRs0e1kech8E1
 Z7I0yuVN7ybOY5xBZxJBfhLIF+VxuTsaOQKD2i4heDz1FkFaUZ97187od3pmqVxcaHDu
 3LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880666; x=1749485466;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rBlczCLDuJeJVfwlHqjHo9naPJLzz7NV2CUVDyqSTk=;
 b=wuWDOYD7eKV1k6QP3PH5/7HtJlANIhqHjRtibstLTQy+hiyIAtscw+dV/A3n26KvSV
 GIX3tTX4RC1N6eLYClZ5NXk/moA6y7+IJJHcV9S34IzUPhzPbr/MQHqDi0vDjAk4eqzF
 QNjlz1Bvv6E2jvKnkiPwHuOvvpNz9xBOMhkzdU5QNx+wyLDqOL1evUU1tR+J0Lk+kSPj
 hu10bG7c46L4ty+txvri9poRn4+MuTavNwWx8ovTKyUchWw7YNth86x1CJs24gNUoeZK
 LqkU8ovzKKvFh53Z8k/QtGbSgHBEw/kYWxIy0+gCdja09PzErhQEfBru6KTvqLdjaTFr
 9K8Q==
X-Gm-Message-State: AOJu0YymI3LZGpEE9kerQh2mqjppxlbzcpdzVJ+hEks4w3PBVRb4Eau/
 S8/0R75FbreBv24uAsSMGAY1C1oJyfT+snS/FNRxY/ThHm61CcUqteLu2aaQKu2qPos=
X-Gm-Gg: ASbGncvRZezeOF36xSwljocG4+F4V2tx+7s7FCHsh9zcLmUjzEtPfOA4ffFepJHopUn
 EXNXno6cKiMB+ZeA+rNJxdjsohuFQ1ta+qXdjtq81mPdlMivHzq3juQXxDrFoPNg7nK6j/QEik0
 T4w3gE8JcbSkAsYWPjtym2IiVV8+084KLv4AOQUuE5k6hu1Puiy3jsUyR0Mjnj8opjpMJ6z8J99
 GuXbEzxc57uXhBJl/t+YE5DDdQrejYtZjy/b8pFDNIbMU/oYHiDRMB8Dg4BNc8gE9nqB7RPha5e
 a0OxD9bN6bkGeIgOgmZsQpcT/kDK61ayPd4xR+0HtptS4Zvw/dQpxqWev4ieQrvlo7Ux6iJVOdG
 NdkLZhwyxvcUA
X-Google-Smtp-Source: AGHT+IEUEq+f/HfKMO2FxLpDveuT6O0Ko/F4NedjdiPur7fGv19htHvFm2/nwhTG+ScZZ2EVO7YNXw==
X-Received: by 2002:a05:6000:26d0:b0:3a4:dfaa:df8d with SMTP id
 ffacd0b85a97d-3a4fe1617famr6934666f8f.9.1748880665647; 
 Mon, 02 Jun 2025 09:11:05 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:11:04 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 02 Jun 2025 18:10:55 +0200
Subject: [PATCH v2 4/7] binman: add support for building Qualcomm signed
 MBN ELF images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-4-c7d19c0d4a8b@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3365;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=TXFHSBTqflb6f6NfX7pRRs+cU+8UjpId/6G4GiI9qEA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0Sh8BgoInbtYhUtLqewa4qCFkS+5r0h1XpA
 w0phKsx/hWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEgAKCRAFgzErGV9k
 tllgD/9rRT1p9fLV5lot/8yeOAmRSHlBT/zM0MRM8HXIt8JFGgpkBkGM1xPHVVNwoHNR4pb/ZBU
 0nZ+5/JgkTNX7CuCoklpBTHxMDz0X+oMl4s2fhJq7kZALzVXC3xExOKeJ4rMKGo1ieR+6k6arny
 zV8yzMA//PiHxPE9dbSFUtjYeFOf2S3T0DgPse8EBhdiNgrZQ2O+7r+UXlzacXYhMMmUlMoxEt/
 9OxNsst4HF7SkDAINdy2tm2QrjAfKWnkWmDFJkm6D8IWYCuZ5AAM7MC+3KiJgf4PWfnTQyanPGp
 Y8fjGGKBjlKeYt1QhjzjtIo1Z1N4d4w1xMoXvdluEEU5ko8M7v7ewPalgVgp6OtL13vkA0aTqET
 VjejYKxkdPXNnAYd66KukiWMjDZ8dWic4S7pDsuXpfnGg+fDALCP0pY3EvrAjQ1C1zTujoEk7TJ
 LqXL03xfsBD9Mfw24p0nAJ1SCviyqTZgihEfcLF6wm9B8qO3qH04fDt5JfB7uTecnmgcG+qBwo2
 +S+zzQi0EUw/gD55eGJUfhIqbVuZni5ZN2MCQ4HTutEv8zZ+FcE1F2DwnjzPmF2H/wrqPt7Voq8
 haVAKGGTAy//lWYXzzvHn/Ie/wopcfEDZiT9npVDzcrRy+T5y6U0Jtsxr+QZ5iETHQ6zHZKvqCi
 CVGDuQig3pi0viQ==
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

Implement support for building u-boot.mbn files using the new mkmbn
tool.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/binman/btool/mkmbn.py      | 29 +++++++++++++++++++++++
 tools/binman/etype/u_boot_mbn.py | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
new file mode 100644
index 0000000000000000000000000000000000000000..232e2b442a166f9e86a4d4eb5f55f624eee0dc62
--- /dev/null
+++ b/tools/binman/btool/mkmbn.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025, Linaro Ltd.
+#
+"""Bintool implementation for mkmbn"""
+
+from binman import bintool
+from u_boot_pylib.command import CommandResult
+
+class Bintoolmkmbn(bintool.Bintool):
+    """Qualcomm MBN generator for U-Boot
+    """
+    def __init__(self, name):
+        super().__init__(name, 'Generate MBN (signed ELF) image for U-Boot')
+
+    # pylint: disable=R0913
+    def run(self, infile: str) -> CommandResult:
+        """Run mkmbn.py
+        """
+        args = [infile]
+        return self.run_cmd_result(*args, raise_on_error=False)
+
+
+    def get_path(self):
+        path = super().get_path()
+        return path
+
+
+    def fetch(self, _method):
+        return True
diff --git a/tools/binman/etype/u_boot_mbn.py b/tools/binman/etype/u_boot_mbn.py
new file mode 100644
index 0000000000000000000000000000000000000000..35c271a45e3ce75f10d1852eb0ac290b38913d84
--- /dev/null
+++ b/tools/binman/etype/u_boot_mbn.py
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2025 Linaro Ltd
+# Authored by Casey Connolly <casey.connolly@linaro.org>
+#
+# Entry-type module for 'u-boot.mbn'
+#
+
+from binman.entry import Entry
+from binman.etype.blob import Entry_blob
+from u_boot_pylib import tout
+from u_boot_pylib import tools
+from binman.btool.mkmbn import Bintoolmkmbn
+
+"""
+Casey TODO:
+
+* move qcom-binman.dts back to arch/arm/dts and figure out how to make it build...
+* set CONFIG_BINMAN_DTB in qcom_defconfig
+* update docs
+
+"""
+
+class Entry_u_boot_mbn(Entry_blob):
+    """U-Boot Qualcomm signed MBN ELF image
+
+    This is an ELF file with custom program headers containing Qualcomm
+    specific hashes, signatures and other metadata. It contains the
+    u-boot.bin image.
+    """
+    mkmbn: Bintoolmkmbn
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def ObtainContents(self):
+        self._pathname = tools.get_input_filename('u-boot.bin')
+        res = self.mkmbn.run(self._pathname)
+        if res is None:
+            self.Raise('mkmbn not found or failed!')
+        # Exit code 61 (ENODATA) indicates that an MBN file can't be built
+        # for this board. This is non-fatal since it may not be required.
+        # however we print the stderr which indicates how to add MBN support
+        # if it is actually needed for this platform.
+        if res.return_code == 61:
+            print(res.stderr, end='')
+        return self.ReadBlobContents()
+
+    def GetDefaultFilename(self):
+        return 'u-boot.mbn'
+
+    def AddBintools(self, btools):
+        self.mkmbn = self.AddBintool(btools, 'mkmbn')

-- 
2.49.0

