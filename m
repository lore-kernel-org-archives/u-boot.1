Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B045C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB8D830C8;
	Tue, 15 Jul 2025 08:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbzSwAtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF70082F14; Tue, 15 Jul 2025 04:53:29 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D0782AC4
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b2c2c762a89so4021219a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752548005; x=1753152805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkRqOcm9nRXDvcgXWhVINmj6JvK49QrdTuoqBqIKhh0=;
 b=jbzSwAtkv/cWs92FCkNo7460EKMhZIgR1T9F68+6tQqSgESeAV5NNrySITzTbOqtHi
 V3O2wit29T+JOAvxsR04EzqrjDN6hsdWEfwpGEbuuiGN1eHM3iXL9h2Z6edw0lcq6fJ3
 FM6tR4pvOdlcD6vf9AldvuTSKe3PZJMQbB/93YSq9qLc4/5qF9G+VBfBzHXF5pO4zg3A
 lxVE2hvnG/v/bvaDv4DY3+mqfGJNTYxOeCluu4PDnLt7LnimpmvTRMXTfdWPeJ25kflE
 PkvWZNXogcrVAHCfgRyMWb9VBBqHlC9+AYGRKQzzyHiRH3FpVdN6hN6lKF1lPp3cqE0d
 7RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752548005; x=1753152805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkRqOcm9nRXDvcgXWhVINmj6JvK49QrdTuoqBqIKhh0=;
 b=P36T0uH71sQ+Vg0nQ46319BJtudseZg15UAMhB04KuEeppfrrYGBgOSrx8Q1MhL0hM
 CQY0xrdbGxtSrZ2QEY+POJebECBrEflmLH2AlxzlNApVthg8NffWNe0Bfr5AZp2bNVW1
 K3PIyO82XOROdjfBvHdUXT5jk3AsBsTG2pMp2ufQ0U/xj7uDMLCVNqkBH9PZrn/gzP6u
 BGHjbmr9VHCLMIFnw9c0lQRnsAtmL7/E2kZO3rRWXqJ04a2xcCKaLJurOJC/miqgfbbY
 GbJPHx/Fh8Y5xwxDTfLe9Yp9y8wsFFpl8SDws90/KPmj2AjHqWFepWTQomoRYTbOBrqK
 XFVw==
X-Gm-Message-State: AOJu0Yym8YSo+nJDajCIiMu5ufsKpInWzLO6Z8zS0JaEMsYC5EROpMoQ
 AOAFHh3UJEVxtFPHJSF+B5fxNep7MUJfmuAV9NwFsj8f3igNH0JjMBqZMUdWmg==
X-Gm-Gg: ASbGnctra04nHLjISm8WXge1VXplCv9MbFPyGhVr6MCYqvwWz4nD2jnUkjwQN1nqiY1
 bLF6DeYpKSN/SFswA2hNZaL2hotpyru23a1hA8R20igSR2BVZFO4lve9OBLDbDfArSMwLD6rAkP
 CSRF9IPK6Ef7/VBqCUZOD7pURKvUMAJWmEb3oG0E1HiIBnGAQ1EUU5PRPncceByYQGQGeDHVZrq
 84dx3vIsq7NuoeokaLovb2vAeaLrKbIiOV7pvyG+Mxa2Glv5Q8jxFAMETTbkg5LoJXqJnTpEwHs
 0edRmQrmECyMknR/8HE2SpUWqurx0RhpUfNQLs2e2/ktUQFmJBHMMF868GOG7sYkbTNAXjpIr1s
 5KyslmoQSAZ/+QsVlJR9uIUVe6+eZE/pWbXFFMv+p8LxNnZUXviVt+i9pT+Ae1q3MlefMtaedIA
 ==
X-Google-Smtp-Source: AGHT+IFFdDIH8kmWoRHFrf9qYSOKw8hxJPjUrLQbL2a8Wf1pJ686uNIK/nIkgu/tuEb/mvCbYPSfJg==
X-Received: by 2002:a05:6a20:6a0e:b0:233:b51a:8597 with SMTP id
 adf61e73a8af0-233b51a8602mr14505793637.35.1752548004899; 
 Mon, 14 Jul 2025 19:53:24 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4ca28sm11777889b3a.134.2025.07.14.19.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 19:53:24 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ravi@prevas.dk, sjg@chromium.org,
 jan.kiszka@siemens.com, baocheng.su@siemens.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 3/3] test: fit: add test case for invalid default
 configuration reference
Date: Tue, 15 Jul 2025 02:52:54 +0000
Message-ID: <20250715025307.2013-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715025307.2013-1-aristo.chen@canonical.com>
References: <20250715025307.2013-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 08:33:25 +0200
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

