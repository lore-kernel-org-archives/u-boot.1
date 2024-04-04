Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A490CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E92883EB;
	Thu,  4 Apr 2024 10:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isT2bof7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AED883FB; Thu,  4 Apr 2024 10:14:14 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E7E883C6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513e2373ef7so162090e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712218451; x=1712823251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=isT2bof7KXCIYdnRTWITv2nobXVgfZ9Qn3p6L854/uzXHmWsAuuawuJRVt3QqG4p/h
 OgSujSwbTvb0SWJX33+11H2rYG9xOGCpbJ7OyW5pOhknNaNpBvQd5E3shg4oXP0NaCoT
 BaoSkK6AFqAdXcRrEiDa3ZtZA/KVoGNi679GNL+T9kTDY1p8bmv/KWVT7e0Gr+oFwTrY
 CXFZGlVss7Bz/EBZISSSj3TXcML4Zl2zz1xbdOL/5zCTggqEKbPExoZpx5Poh+M8PLjI
 CfqmQT8th1DrWJv5JUEB06Nc0c6gM5w/lFuPq5jzzLZnnxsORM2wrsoqUt1jPzmx9anD
 9KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218451; x=1712823251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=VFKzuXHnKG85Ta7uypcsef4R+GRjgB+y04sTQMXKpqmY8RSKdEwSYyRyd97bhxnTZ1
 qW0SFy8jMO5CMxuC+pkmiC38EBt+frsXGrr8MN7z/hJoQQNRAlSSv6i72PxnagqfcSM3
 l5OnAjBT7mC/SBV2MAn63Vc35CGZW43NW0S7F/TdYZN2kDUeTNVz3qIZMlMU8A7e8/Zl
 7k5/vVE4neN59MlCipdOZOJcvVvma8XkNSFbrDVl3FHYIb+clsnxq0bTaXNgoE3/mL+G
 Ydrv/KlgTZ4vGs/NTzAkyMgl+aAPklhsgiAbPNK57LIN5dFAGqqfXpmHUROv5ly/WG3Y
 Kg5w==
X-Gm-Message-State: AOJu0Yy+gc5NuubJw/iWEpuHBMujMqj53sZ+fxGZ9o3+PCnvSIvtla/y
 HC8XVX30koq+V7E6qUWDkSEuPiPcrpvuO5YSXSxI8TnHtfxaW6ZgZi0pnOrLTwvNsg==
X-Google-Smtp-Source: AGHT+IG/TI1g+KaefDY3ycd1gGWRJebm6V/D7eT5KW8p/8jQQu/lOS1MWWA3kBNO8XcZw3hEUyzvow==
X-Received: by 2002:a05:6512:78d:b0:513:ec32:aa89 with SMTP id
 x13-20020a056512078d00b00513ec32aa89mr1099231lfr.2.1712218451271; 
 Thu, 04 Apr 2024 01:14:11 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 a17-20020ac25051000000b00515a9d5aad1sm2223747lfm.116.2024.04.04.01.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:14:09 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/5] test: py: add optee_rpmb tests
Date: Thu,  4 Apr 2024 10:13:51 +0200
Message-Id: <20240404081352.3224643-5-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
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

