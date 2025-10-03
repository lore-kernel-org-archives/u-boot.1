Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E394CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B4183870;
	Fri,  3 Oct 2025 21:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C0FC3EWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E10E838AE; Fri,  3 Oct 2025 21:22:55 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5A18386F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-91f6ccdbfc8so138191739f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519371; x=1760124171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDrDJyDSfld5IdgdcCeS7JgvccMbVpIUA15xt9qq74Q=;
 b=C0FC3EWNW7DDc7/zcCYruOPNphhZOiqIqxAVah04kYKJaTg0dN/LyBXsQzr3LnnIdY
 jCkyeqa9D2JfKqYlEDzPwQszsSb5RzfFbG2rpwelIHFtD17VvmoQQfN5xxM0DKtJeSn+
 bA+cxsRNGNIYv14b6MAp9GS8C15/869q+FcS6F3L+zeL1ZkSxCpeyz1fHZT4W3EJqyTM
 SsdE5GnMSC5JhCNRXEHvVwA1ZBbhH+W1EUCjcnW4n7/Snwt/l+LTHjZ8JryghEWvF8Ki
 hna+C1ROGcAlFfRAUxvweQUqucfPOzJ2f2KM578F/hghec2yvlQwDK6Zb5lvM10lKidu
 5zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519371; x=1760124171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDrDJyDSfld5IdgdcCeS7JgvccMbVpIUA15xt9qq74Q=;
 b=xOr08Y6uVmfMci9vi360tg1vwmh2sNPqhsJvzZC55MgLi/ZMFm1sXkQXWPrBJTrBa2
 jt1PQvSfnt3yf4YiaUQxa92Y5qh/H2BJL1MT3JzFWIFY+UMWSFwBEXq79MI5Di6HBrI7
 ZhzWD8D4BjxZxXjLh38beT6wEachgmVk6eypttdVJtumrNYZYWtIuyrAbO8Y2WDwF0Eu
 RstT5+Jedw1f2Mk0cN5UxJHHyCzoTQrfG6Dkjq8pfL6wdsdBM418gEBM6CCWL+uKAIU9
 CgmGocTspsk8/+ZWGCzSwHWUI9oFkDAj2a/38daCeSq8Ndlg9oMUcoXq/3ZWbq5pJ7vx
 R0gg==
X-Gm-Message-State: AOJu0Yy3NAOQloyiWkV9KBhzNVNAXXxnckpVu+9y20g0UkKTA7vwYKsP
 CML8rPBwyOYk0wqHePRiipKfpsyvio8YMAnyI7DkBHwlllJFRNE/YQUfQiIZmRjIUTKog2JUjmF
 KKJpm
X-Gm-Gg: ASbGnctF21uww+ib5icGPBa/HvdE5/+iLNAkqsvu+n+ftAiooRg3cGeAPyJCHjdx3sU
 cJ9/R8x67koGMFlZd44OeQtWF3fHEJVN5UKp6ZhqPs0mDueOj9i5nGhQpxKwCqTsK9VEhp0UqZO
 VlqS/W+U41SXszN/U9EBZ/beMfBHEIXQ3F+eA9F0ukJk9Ftwg5WwpChsYGT0KEJxNtndf2CPYem
 ibAtdZWFgcMw+bFm5RTDcGKL74YF8ZOuUcBB6hfnds/pfulok90hI+pGFRfrZ2SjufA8ClG30h1
 HQFJeImeHlddYDc9KiyfdaIaexW+RRNgDnG9ap59syN/TTei6PekRmdxiRNB8zjExh0Ubj6E9gD
 5t2PZamdv17SSnBfZ3OOUJrCIieLmR9rzkvBns3G8rSou51vrta0ueILpBN3HXfNJHCODExIRvA
 ==
X-Google-Smtp-Source: AGHT+IH+spSRlW2rowLomR+oC8KAkxBnTys8sYz5Ug9NErX9cv6CiuwUgbdx1j/qY0XwpPD4GAiqZg==
X-Received: by 2002:a05:6602:150d:b0:886:fa71:f544 with SMTP id
 ca18e2360f4ac-93b96ae6ff4mr544785339f.17.1759519371567; 
 Fri, 03 Oct 2025 12:22:51 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm208975239f.4.2025.10.03.12.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:22:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 2/5] pytest: add test script to validate Firmware Handoff
Date: Fri,  3 Oct 2025 12:22:16 -0700
Message-Id: <20251003192222.767882-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003192222.767882-1-raymond.mao@linaro.org>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
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
Changes in v2:
- Control the tests to depend on 'env__firmware_handoff_enabled'.

 test/py/tests/test_fw_handoff.py | 108 +++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 test/py/tests/test_fw_handoff.py

diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw_handoff.py
new file mode 100644
index 00000000000..45f154665ef
--- /dev/null
+++ b/test/py/tests/test_fw_handoff.py
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
+#
+# Validate Firmware Handoff from TF-A and OP-TEE
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+whether Firmware Handoff is enabled for testing. Without this, this test
+will be automatically skipped.
+
+For example:
+
+.. code-block:: python
+
+    # Boolean indicating whether Firmware Handoff is enabled on this board.
+    # This variable may be omitted if its value is False.
+    env__firmware_handoff_enabled = True
+"""
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
+    fh_en = ubman.config.env.get('env__firmware_handoff_enabled', False)
+    if not fh_en:
+        pytest.skip('Firmware Handoff is disabled')
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
+    fh_en = ubman.config.env.get('env__firmware_handoff_enabled', False)
+    if not fh_en:
+        pytest.skip('Firmware Handoff is disabled')
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

