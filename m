Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0274C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9AB87933;
	Mon,  4 Mar 2024 18:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTEq/evT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DDE986F6E; Mon,  4 Mar 2024 18:45:16 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716A787EBB
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d90b322b0so870941f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574313; x=1710179113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=XTEq/evT0cpaD15fDmt/uvSBmm/6VQLSlMYEf77Wn7Cy/2dDuD4WwyBNmgj8LWldXf
 OKd3Yg3dL48UZgTlF+XU8KhOo4Yk+TimSLJdJryi3avVUMWUUepjCzFeF1ZwZODOoj/W
 MDFsj1QXBu3BkmcIp02HqzUr9wFAlqW/B+t+Pks/eLBUozysYWXd2BVdHxKfUvePcjM3
 dD3Qlip55olD52pioAo7dneupi77dPG77v/kQM8o6uUMlBzyfkzSDjOdzyKvKi5TN99e
 ev7xHy3/pBI6F+M/aVhVJhK92EQqhZRO5f76yWk/qYr51YkkFNCbTe68Kx/ggL5gDz+M
 uo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574313; x=1710179113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=Y8LQLLRHqV+6Gz/+Sf549zK/y0ySML0wyIHW4po1j2mj+RnVOCfLl7C4wng807w4LC
 8xEu/J1IPycDnZSlfSeDpcrWPeae6f0hZR2UdEotaI8B+NEZ6ByIxXDW/EX/ednChfzV
 RCWXYq5x1lecaA+XEFi0zy5Y2RSMIcKOw5sW4e4VqINO70upMBRa0ZlzLbDUBBfPKOrC
 HMBGXdjXfGdVLVsbw21IPWMIVbzOvh82dwkNE/OO74yu/iNf2ZjHF/LRXQtSdi0yzc7M
 p/Pf5L2nQVYzBIwcvFwRHQZcN5wXqmpjCt8ELkdkmGaYZC5c4FHbOY3nmRJh/T2wV5Bx
 k7Sw==
X-Gm-Message-State: AOJu0YyH4ZJ4NPvziTVXQOMwRTvmQx4jP1BEbB/X4wiJfTbZ6WdtLqq1
 WWJq7RdLhTOqFF3JyFS3I1r0p+5hT4EL/ZPVwDNlyRZtXIGxo3yjMOo+cWd3ZY8=
X-Google-Smtp-Source: AGHT+IFs/b0Zvpz1y2QeFxQIQYCDGSL1eW8jBsi6HJZlaJQWKQ40X2mOG/4xy1X+OQuZVhWEj5/uQQ==
X-Received: by 2002:adf:e78c:0:b0:33d:9ee1:48db with SMTP id
 n12-20020adfe78c000000b0033d9ee148dbmr7167870wrm.2.1709574312914; 
 Mon, 04 Mar 2024 09:45:12 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 r18-20020adfca92000000b0033dcc0d1399sm12761370wrh.25.2024.03.04.09.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:12 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/6] test: py: add optee_rpmb tests
Date: Mon,  4 Mar 2024 18:44:53 +0100
Message-Id: <20240304174454.1484507-6-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

