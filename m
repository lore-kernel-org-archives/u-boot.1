Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0DDCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 13:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607D58828B;
	Thu,  4 Apr 2024 15:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITTEIPmp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF09883A9; Thu,  4 Apr 2024 15:20:11 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C0188288
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-513d492c3cdso264320e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712236809; x=1712841609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=ITTEIPmpvvnDZzVgUuvRdD1AVaXW/3FsEUHpYu9i/KxyPyfzOMAz8o4QN2ykkkIWx4
 3TZVZH5Bna/YkB/tBJmEzrf4BlV0stxmwA0u56mi70NRNs/yBghGIRcdBO+bGYiRitRs
 SVSaZbx4HKZaBBBldiuQXH9Cdth+QmCLOD7HBFS8u4dJuIKkWPFzmxP+7ABcWb3wGHio
 a9SKRUzroVxm1scRSzyaaTEIL29Ysj1gmS0BjJFL+wH2dHSN3+wD3ETNqKmuXsTX/+jl
 Lz8Rz7K0w6rS+bthVBX6hDcArkkdIgpLOTLAABHd5qTtDRlGAMpGv7JH8ECvuNja6O1u
 fKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236809; x=1712841609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=El0g1Qq/2t/hj5m/G9DJ+dfQQ4Ar5WETcRid860Zxuu8a/zz+RmHWt1bF09tiz9CI/
 M0CcqjYIcDZo1SY1aE5evD88tqSUTAnF8V0VxftfTy+IaYU2fKGYKSBzGds9MPkAx8k9
 7GlKN5TLSqeAV95e9PKd7nRoyHThao9DKdk8c651O12g0AYcqz5AHr+Q3yWKD5s8Hkyd
 RxVJ9eWXJigNrBzva1MHVyQXU3hEWu0QQ0scqMT7BmLwpCSX63Mu/ZnBfo4UQ5M7VYbO
 j9JCdtZarZK8bfmmIQWeBl/UHZtUAYM6zmNkWDhuQ/eJLPStaPQm/A8BI6hF+R4BcnUq
 CXSA==
X-Gm-Message-State: AOJu0Yzm6Lsd0loQNSleZvobXENfEvklIxhNJU/xta347RZOg0NCzzBm
 LLzoUJxmkIKyE3a74mKJrhNbM+xlj7O3PJ0gJ88OSCGGQK26jmZ5ys0M4YzhSgXFQQ==
X-Google-Smtp-Source: AGHT+IHIwlBn9GLZ5HhWeexdPSG4hHMqSyIJkcw8f+6QHTpCFyyY5X+145NIeALmmcjd3806CEOtWQ==
X-Received: by 2002:ac2:46f7:0:b0:516:d0ba:68fc with SMTP id
 q23-20020ac246f7000000b00516d0ba68fcmr586239lfo.6.1712236808589; 
 Thu, 04 Apr 2024 06:20:08 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 z19-20020a195e53000000b00516cc2153d0sm166737lfi.103.2024.04.04.06.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 06:20:07 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 4/5] test: py: add optee_rpmb tests
Date: Thu,  4 Apr 2024 15:19:50 +0200
Message-Id: <20240404131952.3252301-5-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
References: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
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

Add read/write tests for optee_rpmb cmd.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v1)

 test/py/tests/test_optee_rpmb.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 test/py/tests/test_optee_rpmb.py

diff --git a/test/py/tests/test_optee_rpmb.py b/test/py/tests/test_optee_rpmb.py
new file mode 100644
index 00000000000..8a081b5c494
--- /dev/null
+++ b/test/py/tests/test_optee_rpmb.py
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier:  GPL-2.0+
+#
+# Tests for OP-TEE RPMB read/write support
+
+"""
+This tests optee_rpmb cmd in U-Boot
+"""
+
+import pytest
+import u_boot_utils as util
+
+@pytest.mark.buildconfigspec('cmd_optee_rpmb')
+def test_optee_rpmb_read_write(u_boot_console):
+    """Test OP-TEE RPMB cmd read/write
+    """
+    response = u_boot_console.run_command('optee_rpmb write_pvalue test_variable test_value')
+    assert response == 'Wrote 11 bytes'
+
+    response = u_boot_console.run_command('optee_rpmb read_pvalue test_variable 11')
+    assert response == 'Read 11 bytes, value = test_value'
\ No newline at end of file
-- 
2.34.1

