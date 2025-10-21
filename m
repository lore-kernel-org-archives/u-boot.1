Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC49CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283E68357F;
	Tue, 21 Oct 2025 20:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PXDCrg2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D0D833F6; Tue, 21 Oct 2025 20:17:36 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C783080107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-87bb66dd224so81056616d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070652; x=1761675452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Vghgs/zbkHHoaJuKqG6k3BBr8D8JUiJ7E7q+8vQtoY=;
 b=PXDCrg2msGykcxBUoEYOSafn8GyaF4QwQJ6+OElZUrZKkYUpfwO6cm5LemPG3PuGVc
 TaJRncgFV9wYwWvJntYWug0Rn+5VBIX4hFy88bitcF3DMuRe+/PW4oNEjoW0kfMVXlDZ
 vB4PFIx9Fod8Z6u6B7NdrybqONW/hqFKyxbkP5JQ9tctYSVVQm+EjUiY728w02Yq0AR2
 rFrrmwPJVtRvVic14hEfdsib+a+X3RWTvSuta8C94NSiHi3a9quBy6Q1Gkb9c9sbKNcS
 erxC58tYkYjlRT8Q/IYDb12NemxdhhPwNbulrpfTCsqKFKpjEd3yChzT/IoGTZMKH87E
 d+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070652; x=1761675452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Vghgs/zbkHHoaJuKqG6k3BBr8D8JUiJ7E7q+8vQtoY=;
 b=T9fX2EVe3kublarxpvRUDZmVEg1E+PU5GrBD2oLwjIXRQMJckPkkUanDYsE2WsiXBp
 4h/4MQBnzarJ2WPSLl/oMWj5VtlfGtkjaP2B1+aacflJuqioCPCuIyruLNhU/ZRBBPya
 rPooSFEw/PQPEsQ+AOPjh2gOWv6i4SNPz9DEYJwBWNT2gN75RQ4EIL7NeYyGtF9OTsov
 ATLB2c27/BAaI+gsYPEsVQAxxtUWZI6kEWHMTB0N44FoJWJXsREj5fGoLYfTTLFwfig0
 7ZQs6IO7x4Lw3UkEgtSa2zMxJFq4BjgStcfJ3+HSArX8xhhScO92jZjyexTnPx/E6kX+
 7tOw==
X-Gm-Message-State: AOJu0YzwKgHFJjT+7Sd/IqQc12ZDQLrgSPd8zsGzIwWcxHDK1WW5a3wj
 GZXhMjVronQGKTLf4R/hgqsBkKpPyc/6FOQOcQ47mU3W0fEWX/zq/k3ZOfZZzjOR09r3b6onPrl
 CCRrc
X-Gm-Gg: ASbGncsNHVImMro5ByCx7v5EYT3fEYOR2o4Zm8cnJLBeWHCmTBlJPqMC7v7qo7fOT6U
 zEhDf1ElRo3vGsVecLccrEaqYm/mjUhXbZUyAauRJ2XKpCce5ywx35IE4qp8QctC/aAOF4fra19
 G9lkmzTqu3rnGOoqUEWzT6BuqB14g+bh0q5/GvcAz4xTWoZrebG+Ang/Og9dvejJ6lz3Tn8mMut
 nnu1lmPMOS/6RCsnNQiHccFA7tGLlIsr+lsiwGrZyqnd2bWlzyyc4qoVKXfGfVjru/XBwgRhWZk
 riKa/JKIosrrkdUtGojOY+fK54p080RPIiLTz9cZGoYIKkBu/7jhPx19ksmesxZ7lSMQdNZilq7
 w85dO1ReK+K3T1+x5PRHiXPXUL67PmtxczZ35JY8Hl7AMAaspvtJGj+lKxXAtLGjeGnQdaZIdh7
 JiBduXRC+0olb5uJV/PxK5v03h4Os=
X-Google-Smtp-Source: AGHT+IHeCDoJcNX3dfoVZXeUgbiolQRo/Dg7EWiQkeksmSDshtIN+jSq7yuaxdsYfDHVfQQJQV0MdQ==
X-Received: by 2002:ad4:5ae1:0:b0:804:9cab:926e with SMTP id
 6a1803df08f44-87c206335b1mr246073746d6.38.1761070652250; 
 Tue, 21 Oct 2025 11:17:32 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02884878sm72831526d6.31.2025.10.21.11.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:17:31 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RESEND PATCH v5 2/5] pytest: add test script to validate Firmware
 Handoff
Date: Tue, 21 Oct 2025 11:16:55 -0700
Message-Id: <20251021181703.598342-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021181703.598342-1-raymond.mao@linaro.org>
References: <20251021181703.598342-1-raymond.mao@linaro.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Control the tests to depend on 'env__firmware_handoff_enabled'.
Changes in V3:
- Doc file is added.
Changes in V4:
- None.
Changes in V5:
- None.

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

