Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF58CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268BD8338C;
	Tue, 16 Sep 2025 18:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jqpodX9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59896832DA; Tue, 16 Sep 2025 18:15:00 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 083F08344E
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-88f49be4c21so140167539f.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039296; x=1758644096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjHC9WM1SimkVEI4xSMMwoMTklyKoj42anJR/dzOfbg=;
 b=jqpodX9/ezxAqrwGqJEW4uYZbGvFJCE0gC1bcMtEFO3pOoCYkSNPYskyJlWLambMT3
 OyDlmSaslfvtyO2QXTrCYvqSs37LXcYlccIOPt+RVg1ZcpcuG1VqyWVlGGyKX5EVBRms
 P01OMGStXR9+WStNzrq1U3q5svsmm7jPJvDVYVxDSHfVsF7YxNb94RYdX8bTvMFeNQzO
 SHvZjed2skfrWc9mPzb+7jXPJTTv9xFNQkF/S4ddG3dZjUZfN716+rZxqoMtkU+nYXbM
 9cvoLJWVc58MXRsRO96JiuBMevGuMasvyIMoirm3xyNXrNvzvroqwf1Jx0OykRSsI9KE
 EWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039296; x=1758644096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjHC9WM1SimkVEI4xSMMwoMTklyKoj42anJR/dzOfbg=;
 b=SK14fN4y5Eny0jjM2blA5AKae3KhQgOzh5D6hQbPyYlt/oeLOZjX649D4xlToe4dSk
 MrGh8OTFLmqjelJA81S5xcjW1hMIAEYqds8/JBsAM7Ul8qWdcMclyuhuASspu8z48wNb
 jvYfKjzVUWIV3CjbR4S6q5CIvo/XQBJ7jPtFAAjaIKbC5xLua9V3Uf+uqIbuAiWUU3iL
 zG71BpoJw/5JgCF7adyoh49lb+oFQ/ZzGM87hBeeptDX4mdGsVPbzJkiEw2owUy6RJx1
 pqeAsUTYxmxqXO/18fbKellvxd7G2FbHbCA9OxQckByuUNM3Ce6xaFAd3aOnFldyxcbE
 t5AQ==
X-Gm-Message-State: AOJu0YwfAhPoPPfMPDC2MOjae4R/OVOOEmOEh32FAVXenkh6GzvTkZPs
 SaThn+H6/sRV5dcjEAAZf9JZ8BIvQAhVEK7EMgSGMEfeymbB5hoxwK664i0MlQrl6kZrx2ibJ5e
 Z6ipm
X-Gm-Gg: ASbGncvFwtX2XMLK6j6i9TGyZ/tedfc2sUqIQpzi26LyokGLaLt/lIuSd7y9WoNjXWN
 bt2VliOb47suZnqeatfxAevv2zKERdwWaE8PjnkBeSQBm1RwLNQhNUn1M4idfFqRx1infeH1aRi
 eFSFH2VZWLAPDu91mSbc+45UbUb+FuEP5OtiUPfqqvQfBU6rNdM+VFD2liKVngOUDKe/9plCz1n
 gDE0ig0rqOxTq+z8iiD2VlPJXIfap1Fh62+nWFUV7MeIR5yV3QQU2yuCZ60VNJ2PQwtRBzEXK/v
 WVnlQchR+C87rrwoesIuryT8y8P+wyY2NC5ieEep1G8pJo07IYMHu2NHEYnV5kK4z4Vd3WywGpn
 lyqpesYmxRWsH1lKqkwkpg427Uz69IJvgqS/4/2SGdYHFaGN79tkaNo86m4gLtw6q61UwaTu/1i
 3XyMiw4+SAZg==
X-Google-Smtp-Source: AGHT+IGDv5Dvv8o7f2Tw79dsQg9FMT+xtgQxk9tyiFy67EafRRvMnCPFYB6TZFllvxy/M7XwQjGziw==
X-Received: by 2002:a05:6e02:1a07:b0:41c:473a:aa30 with SMTP id
 e9e14a558f8ab-420a417436dmr148640695ab.22.1758039296464; 
 Tue, 16 Sep 2025 09:14:56 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41f0ea1bdaasm68433615ab.39.2025.09.16.09.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:14:56 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 3/5] pytest: add test script to validate Firmware Handoff
Date: Tue, 16 Sep 2025 09:14:19 -0700
Message-Id: <20250916161426.32259-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916161426.32259-1-raymond.mao@linaro.org>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
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

Add test cases to validate FDT and TPM eventlog handoff from TF-A
and OP-TEE via bloblist.

For FDT, the nodes 'reserved-memory' and 'firmware' appended by
OP-TEE indicates a successful handoff.

For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
successful handoff.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 test/py/tests/test_fw_handoff.py

diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw_handoff.py
new file mode 100644
index 00000000000..4cdf51a4375
--- /dev/null
+++ b/test/py/tests/test_fw_handoff.py
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
+#
+# Validate Firmware Handoff from TF-A and OP-TEE
+
+import pytest
+import re
+
+def _norm_ws(s: str) -> str:
+    """Normalize whitespace for robust comparisons."""
+    return re.sub(r"\s+", " ", s).strip()
+
+@pytest.mark.buildconfigspec("bloblist")
+@pytest.mark.buildconfigspec("cmd_bloblist")
+@pytest.mark.buildconfigspec("of_control")
+@pytest.mark.buildconfigspec("cmd_fdt")
+def test_fw_handoff_dt(ubman):
+    """Validate FDT handoff via bloblist."""
+
+    if (ubman.config.board_type != 'qemu_arm64' or
+        ubman.config.board_identity != 'fw_handoff_tfa_optee'):
+        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa_optee")
+
+    bloblist = ubman.run_command("bloblist list")
+    blob_fdt = re.search(r"^([0-9a-fA-F]+)\s+[0-9a-fA-F]+\s+1\s+Control FDT\s*$",
+                         bloblist, re.MULTILINE)
+    assert blob_fdt, "Control FDT entry not found in bloblist"
+
+    blob_fdt_addr = int(blob_fdt.group(1), 16)
+    ubman.run_command(f"fdt addr {blob_fdt_addr:x}")
+
+    reserved_a = ubman.run_command("fdt print /reserved-memory")
+    firmware_a = ubman.run_command("fdt print /firmware")
+
+    fdt_addr_out = ubman.run_command("echo $fdt_addr")
+    fdt_addr_match = re.search(r"(?:0x)?([0-9a-fA-F]+)", fdt_addr_out)
+    assert fdt_addr_match, "Could not parse $fdt_addr"
+
+    fdt_addr = int(fdt_addr_match.group(1), 16)
+    ubman.run_command(f"fdt addr {fdt_addr:x}")
+
+    reserved_b = ubman.run_command("fdt print /reserved-memory")
+    firmware_b = ubman.run_command("fdt print /firmware")
+
+    # Normalize whitespace & compare
+    assert _norm_ws(reserved_a) == _norm_ws(reserved_b), \
+        "reserved-memory blocks differ between Control FDT and $fdt_addr FDT"
+    assert _norm_ws(firmware_a) == _norm_ws(firmware_b), \
+        "firmware blocks differ between Control FDT and $fdt_addr FDT"
+
+@pytest.mark.buildconfigspec("bloblist")
+@pytest.mark.buildconfigspec("cmd_bloblist")
+@pytest.mark.buildconfigspec("cmd_memory")
+def test_fw_handoff_eventlog(ubman):
+    """Validate TPM event log handoff via bloblist."""
+
+    if (ubman.config.board_type != 'qemu_arm64' or
+        ubman.config.board_identity != 'fw_handoff_tfa_optee'):
+        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa_optee")
+
+    # Get the address and size of eventlog from the bloblist
+    bloblist_output = ubman.run_command("bloblist list")
+    evt_addr = None
+    evt_size = None
+    for line in bloblist_output.splitlines():
+        if "TPM event log" in line:
+            parts = line.strip().split()
+            evt_addr = int(parts[0], 16)
+            evt_size = int(parts[1], 16)
+            break
+
+    assert evt_addr is not None and evt_size is not None, \
+        "TPM event log not found in bloblist"
+
+    # Read byte from memory and extract printable ASCII from each line
+    md_output = ubman.run_command(f"md.b {evt_addr:x} {evt_size}")
+    ascii_log = ""
+    for line in md_output.splitlines():
+        match = re.search(r'([0-9a-f]+:.*?)((?:\s[0-9a-f]{2}){1,16})\s+(.*)', line)
+        if match:
+            ascii_part = match.group(3).strip()
+            ascii_log += ascii_part
+
+    # The events created by TF-A are expected
+    expected_keywords = [
+        "SECURE_RT_EL3",
+        "SECURE_RT_EL1_OPTEE",
+        "SECURE_RT_EL1_OPTEE_EXTRA1"
+    ]
+
+    for keyword in expected_keywords:
+        assert keyword in ascii_log, f"Missing expected event: {keyword}"
-- 
2.25.1

