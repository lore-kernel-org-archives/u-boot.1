Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE938C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727E882C4D;
	Tue, 10 Jun 2025 14:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RESJYd+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B60680C83; Tue, 10 Jun 2025 09:41:53 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF84805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2350b1b9129so33143815ad.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749541304; x=1750146104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkJOlwCEYa+tQCPMVKUSgm9ALnwOtk5g9+SfAjqZlrw=;
 b=RESJYd+DDpQr/oabYuUR4P5Rq/1s3tgUY4UbSveJB2ETbSQTr/RWJMf6X8UXLN1IiB
 JCFEn6F+tz/Zl31E5dwAGo7B80Mors0KWwjmpRRl06rUUwvxuXvmX0G49W3XELFcGLY2
 4l6XXmRoVTRQD3FUWyyi4bhYohWjZ1OExx0Eu/ROz2aSGf1bEb36i1tYTkhHk4JoyzP0
 pepla25tY279vtheL3suFS6R6w5/CCSeq/Vm4v1eAt+lzHIUDTE0U/b4Vl4dSNxt5/3G
 sHRM2XebwYuYXnOk5L7SsI24LD3r+weEF7+m0EYpFyKaSh1X39uPJS3djqsjs/GTG+n5
 c5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541304; x=1750146104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkJOlwCEYa+tQCPMVKUSgm9ALnwOtk5g9+SfAjqZlrw=;
 b=D9I3x1wkHjtl9uFwrgZt8Jjrff25OWwZhU/CZAnyICrT3J94mXp+3lAJYrqe5Pnfr/
 mJpHzeOkekxYvzsMvCR5OhbSu7eUPOxGtEluvKRyJGYQ07qChyedOThXhyjCjt++tGvW
 m7D8qcokRFItc753pOuhFKLDJF71TdAIdWXDB8GreHMkXXXMtNsALv2SWdSv8pFEjjKd
 5KxhBt78P7f4yb1AihvTXDn7434HkjhTDFApmpZFx/zb4jWsVvaKS9TUkrL+lpEm+feI
 K7rWcDKSb5xns4h69FwtwtT7WnDi443JWvm+uB9hXc9vYt6uKBdo/2az4blGjnE4PVDE
 MEiw==
X-Gm-Message-State: AOJu0Yw1btolsGMZ8FQYFSq/PIhJITV3+xeFSRnEUmMZw7/er9GVNk3R
 SjNoWOUOovHHO6QKXegHoQ6cckw13ilux225qZpoP6CTVe0zU17LotKl66jvqvDa
X-Gm-Gg: ASbGncv7FmE/J5FMR+//ytywk6p9IsaCPsc571sdfN8lCkPwlH5PxX54ycbbCBDKMEn
 UjUSzL923aC8GkGdhoAXycOLRg7PZzxjD/ReFBR6BMzCpxyqrl5emzkXRojGiuGK8ipcuoRvAmL
 bQbKVOIFUjCWkQ29lApYYBUzxpJ7dkLpJN+73OY2tCYQWeK37lxTX9bGMw2JZyQLOH0Plc9Ks5w
 RQovobIGybAOdCf98FTff8eIkmGtRi1QgRYJEII7OSvUmIHmmzxP75IDKoiDnI1zdKah+gtkOnR
 M2vRmPYRkv8l7l9xBWsifIH5or5aroXUW9Izg1Iomu3wcYJfPujypT3DrngU6OVxw073R7+WRz9
 3aTY2QY0FblY8+uSic56qYu0jQCfo2rYWKsQ=
X-Google-Smtp-Source: AGHT+IFBNZHHivpuBDim0eDleh59TjEi1TudIb5/D43JzZEXDx7ZFu3DI1Hpa06t8QQay9nsrvlXjA==
X-Received: by 2002:a17:902:ea0d:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-23601d7e29emr240769335ad.40.1749541304469; 
 Tue, 10 Jun 2025 00:41:44 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092640sm65201945ad.54.2025.06.10.00.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 00:41:44 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com,
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com,
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
Subject: [PATCH v4 4/5] test: py: add mkimage test for undefined image
 references in FIT configs
Date: Tue, 10 Jun 2025 07:41:20 +0000
Message-ID: <20250610074121.8308-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610074121.8308-1-aristo.chen@canonical.com>
References: <20250610074121.8308-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jun 2025 14:57:04 +0200
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

Add a test case to verify that mkimage correctly rejects a FIT source
that references a non-existent image from a configuration node.

This test introduces a minimal ITS that defines a valid kernel image
but references a missing "fdt" image under the /configurations section.
The test asserts that mkimage fails with a clear error message, as
introduced in the new validation logic.

This helps ensure the validation logic behaves correctly and prevents
regressions in future FIT enhancements.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_mkimage_validate.py | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 test/py/tests/test_fit_mkimage_validate.py

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
new file mode 100644
index 00000000000..af56f08ca10
--- /dev/null
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2025
+#
+# Test that mkimage validates image references in configurations
+
+import os
+import subprocess
+import pytest
+import fit_util
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+def test_fit_invalid_image_reference(ubman):
+    """Test that mkimage fails when configuration references a missing image"""
+
+    its_fname = fit_util.make_fname(ubman, "invalid.its")
+    itb_fname = fit_util.make_fname(ubman, "invalid.itb")
+    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
+
+    # Write ITS with an invalid reference to a nonexistent image
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
+        conf@1 {
+            kernel = "kernel@1";
+            fdt = "notexist";
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
+    assert result.returncode != 0, "mkimage should fail due to missing image reference"
+    assert "references undefined image 'notexist'" in result.stderr
+
-- 
2.43.0

