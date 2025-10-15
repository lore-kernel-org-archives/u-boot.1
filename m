Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37194CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F70835C6;
	Wed, 15 Oct 2025 16:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gshMqwa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF4E835B3; Wed, 15 Oct 2025 16:19:23 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD66800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-554f1c13bcaso2785508e0c.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537959; x=1761142759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9CiTaziwmBZU/GYIGN13kFJS49Kch6bBwwnvyES0Bo=;
 b=gshMqwa55pNGUVgNsVyo4ajVhiEut5Vh2ESxOha/C5NijCqei7If9e3wM+9t070bat
 uIYYyCmWeHQiwPaBPSa5dMdvcz8/G0e/eeefaapHoYiQVUqScewEwCBS1UgL31gsF8zK
 Ajd9wQfdxCsdef9eIYFdSOMqRigaiUVt+s5+6egdIBqomI78rnKl6N3Sz1JjrvvjAUUl
 ibAVLJhCLv6DYs2E5tnNxq1rj8MbixgkoF6oRRiu0iP1JRqfQ1WQ+BiOhp4XzGt3ypqg
 heZtb+Wv9Ybq9bFEAxmNo3P35TS3//wA6K/Y52JVzCWQC3PhGoScIzeaqRsKZ3K5fufz
 D4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537959; x=1761142759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9CiTaziwmBZU/GYIGN13kFJS49Kch6bBwwnvyES0Bo=;
 b=asPTqLmzP/FUCoujkc+t5HvpG41M2pCgIvUUOWtbK944CG7sPwgfsxPuigxeCjKTHp
 vBoAxWQ0f0c5a312KETMX9yhhOkyNWOJdSecaQG33BMskYqoBz7qwY0EV1pViymB21Jr
 hIsZcItZPraDZEdi2GbMNdOWbKDoaT8EQ6nDVrIS+vbZMTVw4z1PX9L30FF0y98ZDl0K
 9zd+1kql3+jS75L9XP+w06DQVfJGU5k/zZKAIL9+HtvhyGHUEbkhQDm23mQjjy5ACO+y
 pNQKG1jmn/qXME2qvioAua40PdIxJ2obsTw4NX+kvetcpT0C0WlXeLS2Fr6FzBUavKUW
 IN3g==
X-Gm-Message-State: AOJu0Yxpk+yqr/xwuexJUxHTxxoQ1u7ag43vxQA5PpC/LhB+WBMW81LZ
 epSCwygVZMJiensYHe2UpJCjvIfCbdcjTecd0MwPIcSm29dvSp4uaVU9VqKgsKKQPywE70t+s79
 2PLWU
X-Gm-Gg: ASbGncu0wmRknNQfIJKaGQp8RHIE6yZ9tip1eQUj6dc+OZk89ytFsyYPR0GAWP66t3Z
 x08Bchc+cBONHogVT8X0SWgTxg0IXR9fonGeDR6NMyOYJ6si8pfrbfkxUZz0aY7MbTtbIbUCJZ6
 vNl3Inw99G3OIxm66x60PEQ6M7b31Pl6VpG+4tnYA5vATDbHX3b6MND4GPbMLncNsqYeeRJZuoX
 aJx14Wee6b9m2CLQ/Vee9Th1P7IO6gm+9Q5DLame1KfHHl/SoaQGF6iicv/XQcmCkT0fjrXlibN
 PPEuPMJmdizzrjNNbplMSf6fgnf6bKKfGXrPf+g4w6vb6cBRV5fZX9EbiTlZEm7wj8ikuV4MfEU
 iEFS7mC0PvcUZXCPXV8JHzPF6Cy9sjZgP55omSUjtJfCFT8MhyymvsP5aRR6/LlQL4zZnu0xNTu
 QGc7c=
X-Google-Smtp-Source: AGHT+IHhjJbc1btBeE1MnX+uiTg19vlupu0yv1hkkDY6erwBaYEEBE5hZJv3SC5X24b1iw5RmeDScw==
X-Received: by 2002:a05:6122:181d:b0:544:a84d:d3ac with SMTP id
 71dfb90a1353d-554b8aa92f8mr10384443e0c.5.1760537959273; 
 Wed, 15 Oct 2025 07:19:19 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 2/6] pytest: add test script to validate Firmware Handoff
Date: Wed, 15 Oct 2025 07:18:46 -0700
Message-Id: <20251015141856.4168612-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
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

