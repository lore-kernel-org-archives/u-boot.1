Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44764C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7719282F67;
	Wed, 21 May 2025 14:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjgIHqXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E0C82D40; Wed, 21 May 2025 08:28:52 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD5F82BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-742b614581dso5010917b3a.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747808928; x=1748413728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkJOlwCEYa+tQCPMVKUSgm9ALnwOtk5g9+SfAjqZlrw=;
 b=MjgIHqXQ//JrIrnD6qPmsNOfLWMwB6BZQNEFvmlJri55f+J0JwlV1umS25ick+77KK
 7HMZOC2RiazOfbAx9xYV+bB3BzQgj8Ic4QQuAUHlyATCr9m9qYxiD7cTKOx0Wpz5UQvt
 hGWlgzqrhopg52z7zyCYrkm0kbW/BQj211pAXn+HIuVoDBamZmUBG+H8kSPMyLnoDmUw
 nGh2GtfGEbSwuHxJ3cYuZPpdjwCTHUVcK+GfEC67q0vcH20m75TG9z8xzf9oDDf52cYt
 pvU6UpzNXfAvQGozpBRpq20ObhIlcZKXTfu1oymLIBOTOxDzXkwdauZDNFBMe/NwZomK
 IiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747808928; x=1748413728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkJOlwCEYa+tQCPMVKUSgm9ALnwOtk5g9+SfAjqZlrw=;
 b=UkILWcPW7bPB26oH6y7dEfyMYYmoEvLAnLtkOmI4lvYZ9GUw0E5tJ0f29rNX+7NHLQ
 tnCjKjgW41nxU79Ku4+3/DnI+vwue+MJBIuq34s4xMmz3gr2YUHkKdzCTwKL4OPiY+oT
 4za9nglaBg+pEkOanGmvjzEli/UdXUpuMoYx0+yxl9lo3r24wdo2NGNyj2OC4t23NB5y
 h2Gvi1F0zNypbcY5wKeS/r4WvJKXJERr2hZgBmJK+gCjvcs0kZIrO12omJq6orzyU0gP
 9dWkQwzW9LuOigozkEU0crZL76ultcqPiyShFvGnpJnMJIBdcP0LH4wQb2qiNGTlzqbj
 l8Hw==
X-Gm-Message-State: AOJu0YwSUzEXOrUtqySV3mAY7c7aF8yXnZm3D3uVWmOISGGS2HTykqC8
 8IbKqZoQPanF6AabRaAtiAi3+8jlPdPptF0uRcPblrk7iWGQyOddvz8iF9mw7M5z
X-Gm-Gg: ASbGnct+ClPTnpNCsq2q8KaJoG1r53rZFLxQ5FbLJTQpiIxxy8Qon9S3Ja9TkYdmeEx
 sxRf1/TqaD5R0dykUbWLUWr8tt3iYwFvmPfTQEwaVZkMlCzXfX2u9fDTJEjTVm4BbIfdTnErX/5
 dciJzan52gfl6RE+0QGhoDU0F9/1+suR2gl8Gl24yA9Y/F1G+UJwDgi9ZvwBMvtJlJmAayvzKhG
 RFRQrdUL1fr9H5nlZ459/kcPE6AXAPnrCGKYjVUo+oN+shLk8q1Q3fiYgjzaZsyZeo8QEMKAYEG
 dMusHIv+f7KoCWde71x5GnLw7HtOVIkbJGhTqvU4D9gjn2np/duQuBrR1nIwNDqT6Rded9pGHHL
 F9/+/9+6pFW+WUy4lmpD4i1cXPc4zT4mG6zwgYT4=
X-Google-Smtp-Source: AGHT+IE56QcXLq4Jb2xP9NZsrsaGIgZETJ80sQLACGaeq72YyTYHwlTjt6CaPkkIHYdW/9iaFDz4ow==
X-Received: by 2002:a05:6a00:c86:b0:740:9e87:9625 with SMTP id
 d2e1a72fcca58-742acc8ff71mr27399518b3a.4.1747808927997; 
 Tue, 20 May 2025 23:28:47 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b884sm9277911b3a.95.2025.05.20.23.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 23:28:47 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v3 4/4] test: py: add mkimage test for undefined image
 references in FIT configs
Date: Wed, 21 May 2025 06:27:45 +0000
Message-ID: <20250521062745.3458-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521062745.3458-1-aristo.chen@canonical.com>
References: <20250521062745.3458-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
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

