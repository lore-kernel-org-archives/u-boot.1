Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FD2CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22442844AE;
	Fri, 10 Oct 2025 16:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YU3S+Cmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDEB845CE; Fri, 10 Oct 2025 16:45:46 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DCAD84258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso23527526d6.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107543; x=1760712343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0DDfKaldd8E/cRaPy9VL4497Igs6BQXPfEOzlam0Lc=;
 b=YU3S+Cmj5WeUHhrbfiEvteiva7hogcoeyMN/RHpgPOnReIaWM1+0YECEdoRI8hdEa+
 ycwr5RTvRqoEUnHkoa6oqfluhOe5QV/mKe6cyo1Mg4XEvYZ6XOali9E3Uytusgj5jJa2
 nnvimdiPQ1dpSfLsqZnp466UEB2rz5oyM5VI4KTcIKpwlVwF7fIf1Z1OzDD61v9meN0L
 zToL7KbLSZ/K6bR05Cu5X+eGoBoeYeS0xDPq+dYI3a9TBtQfLBOY6cuMjpdN7gv5yDG2
 B00+LzWTYe8zFwT2ox0m2w7FeZWOxGwLNhD7HbXQKANzP39mNfmDzBz7Ca0Pi96ZiFMR
 cMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107543; x=1760712343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0DDfKaldd8E/cRaPy9VL4497Igs6BQXPfEOzlam0Lc=;
 b=IIYBRRSsO3gx7zQRIkAeQtIGp/J8V2LnroPORMM2PL9sc2GR3VUc0fQ7qjzCFxggO+
 ElUg6amCdc+mP01aJJhqNUI1HbmFelmozxPVlhBjk4IIhT2dTisxuPNb/0mtwrVpmgK7
 0tkUGFfFE5KB0m+dqI/sZMu/RQIWT6QvqK6tdRShSE0oGQ7UJG0U8Iyd6SQMU28cQEup
 FNqUVh6Q+MQCU/bJ8z5neoqT2GmJeuPzwElKZRJPZSq2/f9412Re1+TzEWzHJDGWba4O
 riW7w33g5yh771WfI28V3mRPKvW8lCHwo5LMKRELYBASJduRXzcGYQtFT50W3/MFwWze
 Deew==
X-Gm-Message-State: AOJu0YyD9S4BR4oyYFrgCtdmbHXJaoaqNE4ZJ5P0viR4pdg+3l9PcQbV
 4xzlbwNH/Ywcr5EVCSGEUUbdbm566Mf7ruaBsr8Ih/ZQI1TCa+YjHEYZU5fOlxAd2gSdHLYEDRE
 IZjtM
X-Gm-Gg: ASbGncvzAgGnpmezEExGUE46F/YTVkymSXS1dycoWslftnXFDIKuKopemMgqSfrplDW
 5wlatKwReIaxvT+NnhwTRzkaaXK9WWGdcjO0rsnzX6Y+V1NhIFL/gjKZG+mHld8IpLST1tZdBO9
 DKRdw1TgjG8ZKr52NCvlxRRNP4RVMOaXU006C9T99R+YrFL0Y2ZWRlT99wIabZ18jLXIlJhojPH
 WihdVypuajPuka/eQa4lD9FgmtJH6LmFyAKHK4CBl9/a4pmYLGPVMxVTC61iKDusx2EC6BKPfLT
 13pz4HzIrHC98lL1nGAwsKf3fasRdwmd6jm13KZZfRzvinJ2f1nv+gUo2bSxrEerpPN8+g7vZUg
 Bzypkqk/zjTbrxACXKeGkxGv62GyJIEpqM9rRByrfuKflU7cZ5pprBaBDnTT1lXW8vpuYHMRtgF
 JlEF4=
X-Google-Smtp-Source: AGHT+IENKFXx4jghGDckP2vCRDgocOV/TPYBR49/P1SMjuxwAfOGrOfD9btBZ7W/NP7/ccxillOoMg==
X-Received: by 2002:a05:6214:2469:b0:80a:71ea:38d8 with SMTP id
 6a1803df08f44-87b2efa9b3emr155108456d6.44.1760107542938; 
 Fri, 10 Oct 2025 07:45:42 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:45:42 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 2/6] pytest: add test script to validate Firmware Handoff
Date: Fri, 10 Oct 2025 07:45:06 -0700
Message-Id: <20251010144517.3573014-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010144517.3573014-1-raymond.mao@linaro.org>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
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
Changes in V3:
- Doc file is added.

 doc/develop/pytest/test_fw_handoff.rst |   8 ++
 test/py/tests/test_fw_handoff.py       | 108 +++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 doc/develop/pytest/test_fw_handoff.rst
 create mode 100644 test/py/tests/test_fw_handoff.py

diff --git a/doc/develop/pytest/test_fw_handoff.rst b/doc/develop/pytest/test_fw_handoff.rst
new file mode 100644
index 00000000000..af926f684c6
--- /dev/null
+++ b/doc/develop/pytest/test_fw_handoff.rst
@@ -0,0 +1,8 @@
+test_fw_handoff
+===============
+
+.. automodule:: test_fw_handoff
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
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

