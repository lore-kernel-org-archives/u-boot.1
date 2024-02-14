Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7F5C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 18:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DC887DCF;
	Wed, 14 Feb 2024 19:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="OxpFIJAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44ED87DA8; Wed, 14 Feb 2024 19:35:18 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC2587D85
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 19:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5620595f743so64845a12.3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707935702; x=1708540502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s29TXACrZKPSqpy1iYYJzibPmji9wvlhIkgklcdf6fU=;
 b=OxpFIJAQqxYMlcLc/hOhq7N3lZ1poK1UqR/1LQpGB5IhIOa56Nx/Z34yVc1Jy+ZIVn
 7MwFvledUicos2kemhK45HOds/QmIdG7EygOlRt19T0Ot9w0elhVvymtKjlngSH4tfMq
 DZOv+pR77xzAMohrU2e+Gs2mySfDD3YmCo6sBDHs+PItJaOvtb+G8PFQ7DySVxDKeW8m
 chy3wnZyoLy5PkUmAJXkxE73Desc5R6P1vCicHoR+FpCJj0IuCKHE9SN/wzMGShwWlPs
 fJKzr8bf1vKP0TCtv9QUbNQRIsudQGdM4I/hlngQaIyK/LALcv4827Y0y0tX79sL6izM
 1W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707935702; x=1708540502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s29TXACrZKPSqpy1iYYJzibPmji9wvlhIkgklcdf6fU=;
 b=FILNSfTbQkzuBeoMf4xBpSg96ju5xObZPaEFUJmuFYrRNLjBIw/EcZ2l5IUjZCDuJJ
 o8c63YaNIjXw/nBWh6LMwbNXJDwx+1TliX4nSdHPjdVwml5+EB94UPTyo09xwzUsmAua
 c+cMI/kp9jiNkbniZOIHGFkHC0W7lLNbbCiYHcBIv6YRyFDIQxCaduECdOO+J5yFhnaf
 lKBRp8UsVf9DNHYdTKJ+Jdb7yYhjCyDceH1tbezLKntvRs1dqHyOLyOlUbyf+hVZVkEE
 IBNIC+dX5X96TL8QEZOvdQ7B0EhJdT7zIHk5qw+5JRDHsS6aKJ24SGK6fE56h6Jj6QYT
 UTcw==
X-Gm-Message-State: AOJu0YwOH9cH4pZbMfoilHEJiVFoWPkiLQ9deEXKEJBKVe3Ie4v4/MGV
 UvR5EkcWQ2qW+V2lR1DbFW34YW/pkXqllSVPOYoOxEi3i9ZAF1Eqq5aohojhj0DIv+Ldj7dvAHQ
 WsXI=
X-Google-Smtp-Source: AGHT+IFWQLBzDdSwpyML87CPckM8J7dWKbcJXz/MT7dVl5SqOAR+adBRg0UnP3MnVArW0Is+2zQxfw==
X-Received: by 2002:aa7:c153:0:b0:561:8bc4:b05f with SMTP id
 r19-20020aa7c153000000b005618bc4b05fmr2709213edp.0.1707935701730; 
 Wed, 14 Feb 2024 10:35:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWZaA72XKC0cb/cHXt0V/QrvQSPV1gCqcwpX2AYyvBhPb7lxwUiX6Iv9jxpkx+SXii6bRuZMi5xUWdH8EQGD4S3cXo=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 o15-20020aa7d3cf000000b0056387e8b63csm554800edr.90.2024.02.14.10.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 10:34:59 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
X-Google-Original-From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/5] test: py: add optee_rpmb tests
Date: Wed, 14 Feb 2024 19:34:43 +0100
Message-Id: <20240214183444.493629-5-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214183444.493629-1-igor.opaniuk@gmail.com>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
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

