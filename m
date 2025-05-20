Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1344EC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF0682CB8;
	Tue, 20 May 2025 14:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="er8PfT5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB4A82AB9; Tue, 20 May 2025 09:58:38 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49E382A4B
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 09:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-232054aa4ebso21570665ad.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747727915; x=1748332715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkJOlwCEYa+tQCPMVKUSgm9ALnwOtk5g9+SfAjqZlrw=;
 b=er8PfT5A0lvHcplqru0127zoM+8DhLp/h9o87ucBQPsr729yNaxnFA+KKU66Wnyytx
 AmCdyf9uQ2a5cmOKQQ6L2RPwOXSWVPe9duHOCFhVR/dg1sNMwj7WvcxvKo7wurgAkwA3
 WPSOx8uXpP6Apbi4a3qDTVdMV4DTLqtJOmNSCP6KumIK5ZWkpPWPajt2bAuJGkLDQtSD
 GMsbbj3g59yQnbOKdB/PaJrHFd2/QPZnQiihGIuWQ5dcE4+VnH0WZZ1dBiiqPxPX5rBK
 trEmfF9AUA8gghDT/NFTsijgh79qI2PikKrOBBXs92Uscwy8xvn5vnmuUnqltfuhfopO
 SPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747727915; x=1748332715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkJOlwCEYa+tQCPMVKUSgm9ALnwOtk5g9+SfAjqZlrw=;
 b=gNctQIeKD6H9Pre6YVq1U8vgblyzMyyanWhEKotF7nhn4xBdBjUpfM/qrAwjdy3IGB
 I2EOFjbQB6is7YqM1LRhMSgMCDlQ2ThC8Kq53ncehgbUeEDb8D3cd2JnRi3HFwDYi0S8
 qSf0FGqF70CgTJeOP4K1M8GMmQ3G4cy6FYjzf1ZRHj+jSzTe4bM43g6Hr5zmbvWfa6Jx
 3Xa80U3elkjmV8tsrzYXN8pwb7Viz6clbmf2ILTFHJOxdn5gkccmSj5Z41UovojGR/hC
 Rzou04YiEr4k2ezvFisSmHjmb1Q188sBsiJ8uaYUWSkhW0+i/0nVSdWlgKon2oKCCx5O
 v0sQ==
X-Gm-Message-State: AOJu0YxvB0QldNgdKrmYvymgoZoHOzb49cELldQ+q+gENIBKYirWoT+w
 4cFlPg74L2U+fskBuRlEbePM5tGo0F+LAH/vNS/s7yW2rIktA+lRx346i+EptxzB
X-Gm-Gg: ASbGncuvnCBEPrDPbryfpQXKi1OWyM6uNrTv+JBigQxGJWXz6nkZdHNLeLTNK6U8OOR
 Alpdot592zM3V2B02tWH6dAd/sYJ/WN8gftOPf4+hs380lJPaVuVOuiKf7csOPgdeOh6o7M3PL4
 H0e1SvkRf1gBPmvzqcHlR9mPTrVTKAZUlPjvxIHZHafB54P8vnVfQ1vjhkUsDuyigc2g7Jm6fn7
 XKkKQlxast+dBbdzPE9UCEzT9jRwUbgXalTC5JOUAS7M0w0CVsdTYHz+ajOpH4uPVLTdWNOA7T5
 yLVl4ePFct5Q+FDQCrE747m+00shouTNmKdhJzRv9YZyCeWSHWGZ0dLiD8WyV51yJxCDhCaXIaS
 Dj8qCy6POesQ3VPsiEMV6PrCk1YQ26qJOHEsNT2m17Xb7rS0=
X-Google-Smtp-Source: AGHT+IESttnpj49fRl3ZFBSxvTQCGx1wcCjz0z/aZTsE701B1m+8E2sCr7DcpvJgb2gQVvpIwjpW9A==
X-Received: by 2002:a17:903:2a8c:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-231d44d788fmr257862165ad.12.1747727914708; 
 Tue, 20 May 2025 00:58:34 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4eba49esm71544795ad.163.2025.05.20.00.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 00:58:34 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v2 4/4] test: py: add mkimage test for undefined image
 references in FIT configs
Date: Tue, 20 May 2025 07:50:06 +0000
Message-ID: <20250520075735.132308-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505100852.9364-1-aristo.chen@canonical.com>
References: <20250505100852.9364-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 May 2025 14:28:13 +0200
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

