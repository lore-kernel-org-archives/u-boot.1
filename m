Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0531C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4866383092;
	Tue, 15 Jul 2025 16:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNDhT57C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3969482FAB; Tue, 15 Jul 2025 15:04:01 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA88A82BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 15:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-74b52bf417cso3450619b3a.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752584637; x=1753189437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkRqOcm9nRXDvcgXWhVINmj6JvK49QrdTuoqBqIKhh0=;
 b=aNDhT57C3Uf1vvwFWE9mjSH3cVPvHirAugaRg8HFnxp79uNjZcCgDraHiYzAin+8C8
 RPvCcCVr6GikQBaeahgC3+0t8bmcnLCf6hgbTZrVqfd7h75jXITr0rOnSYvdzEHuYsQ3
 w15YaqQmmW/55iUoogUiuK2g9It/LREET48UfO4x0T+AIds3T2RvOCfykOcsGsO3PvZ/
 cWx37LUWFqb98HYQM6BxJAm2miBzASgSS3av0qOYDqroj1GxH7AQ/JHO88vmlixhk2pR
 tfHS2DnSDJJFIuPZ3nqL23CcWUZyMBPjV4PIrOKIds/bd88nQdYiJGHqcEcB1+ROh3lT
 7+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752584637; x=1753189437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkRqOcm9nRXDvcgXWhVINmj6JvK49QrdTuoqBqIKhh0=;
 b=IgqzIZBWWavvpmuWwocoupDXakMtUZ4quYSk+g7ZmTHMh9okoZdKSxqs/r99EWCp3l
 wBmZlmPQ+Oa92GCIJ+aafXwzripnxi5XIvmVgzJad9CShWLk2Yq0LdcbZMOIC+4RzpQW
 ytzCd116ieDas5yXMqy/66bZiQ32+I/2pkyhj+UiN5SRwX8gZuZ0570dRmiadQvvm3Yc
 NX5viB2Prt7NVkaNwrJ8Q9m5US1j4vRz5hyn29mIinN1+rwzwJlIn0Zw/DFvNo9LOLM+
 VJv+4yGWdRTUlalobsTbN4IEbSl7pW3eg4iLL94GinBch3/gRSgHk4RhqFdTsl0FAON0
 qZqQ==
X-Gm-Message-State: AOJu0YwXFOVijgiILxcDAln583HoSSTbtiPyVgayuIQ0sgyusTZbrDAV
 2J1hXyEw+fHymefM4mhsDSke39QnhlBM0FA9Q9EgLxxywXg38tL04lk0+xnMSQ==
X-Gm-Gg: ASbGncv3Ie84Mu2puzIKC2YknkVkiGS3xC9g4A+6mx4QYKoIi9zqANARGAiSG4gcmPq
 cw2Dw997kW21PTYigNPvsN2gqk3rpWhn7X18Aixtf6ykDtuQl6F99lmGqrF4CuGTZ0Z5f4QZGEH
 jD2tZit/S/zMjhvDVmZv5OsS+Sj0h/65Vo0a4BuvZaUMPR/KS1UUyw2p6YqNuS5hKb9xFYnM579
 cRBIvZ1RtMXCqsuNvLg1bPFhNVTx5c1OWEyBtNtUQf2XBe/EuVaqYjzroW6C00iqX9lAdffn2YW
 tQGCB/WP6mSeVSObZEPqG2pK3U6FOxjBhz9BmXIduFdW1P2sCdTRJdyhnmGTja4+oy4KVLkWDEF
 xuGScjWRcZJ/rFyNTx3dnoXR5cJo3rNw4bYyrUqa0BYT4trNGMCNL0Ary3GSdW1aedcJ3JZY=
X-Google-Smtp-Source: AGHT+IFJDRy/Qo3UW8j2pV66C3KGreHdiAT6CpUdeHnZdXhoWau269mnMwV0fCioTUgLvjmDoeOHgQ==
X-Received: by 2002:a05:6a00:6ca3:b0:755:ad06:b6d1 with SMTP id
 d2e1a72fcca58-755ad06c6e8mr4379613b3a.20.1752584636773; 
 Tue, 15 Jul 2025 06:03:56 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5fc9sm12392356b3a.2.2025.07.15.06.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 06:03:56 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jan.kiszka@siemens.com, baocheng.su@siemens.com,
 sjg@chromium.org, ravi@prevas.dk, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 3/3] test: fit: add test case for invalid default
 configuration reference
Date: Tue, 15 Jul 2025 13:03:07 +0000
Message-ID: <20250715130317.3886-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715130317.3886-1-aristo.chen@canonical.com>
References: <20250715130317.3886-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 16:47:06 +0200
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

Recent changes to mkimage introduced a validation step to ensure that
the 'default' property under the /configurations node in a FIT image
references a valid configuration subnode. If the referenced node is
missing, mkimage will now return an error.

This patch adds a Python test case to verify that mkimage correctly
fails when the 'default' configuration does not exist. The test creates
a minimal ITS with an invalid default reference and checks that mkimage
produces the expected error message.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_mkimage_validate.py | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index af56f08ca10..ef974c8c762 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -7,6 +7,7 @@ import os
 import subprocess
 import pytest
 import fit_util
+import re
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.requiredtool('dtc')
@@ -56,3 +57,47 @@ def test_fit_invalid_image_reference(ubman):
     assert result.returncode != 0, "mkimage should fail due to missing image reference"
     assert "references undefined image 'notexist'" in result.stderr
 
+def test_fit_invalid_default_config(ubman):
+    """Test that mkimage fails when default config is missing"""
+
+    its_fname = fit_util.make_fname(ubman, "invalid.its")
+    itb_fname = fit_util.make_fname(ubman, "invalid.itb")
+    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
+
+    # Write ITS with an invalid reference to a nonexistent default config
+    its_text = '''
+/dts-v1/;
+
+/ {
+    images {
+        kernel@1 {
+            description = "Test Kernel";
+            data = /incbin/("kernel.bin");
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x40000>;
+            entry = <0x40000>;
+        };
+    };
+
+    configurations {
+        default = "conf@1";
+        conf@2 {
+            kernel = "kernel@1";
+        };
+    };
+};
+'''
+
+    with open(its_fname, 'w') as f:
+        f.write(its_text)
+
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    cmd = [mkimage, '-f', its_fname, itb_fname]
+
+    result = subprocess.run(cmd, capture_output=True, text=True)
+
+    assert result.returncode != 0, "mkimage should fail due to missing default config"
+    assert re.search(r"Default configuration '.*' not found under /configurations", result.stderr)
-- 
2.43.0

