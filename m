Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8D2C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2534987517;
	Fri, 20 Oct 2023 23:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F0Xyjsq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCB48752F; Fri, 20 Oct 2023 23:53:07 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6733686F46
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ce2c71c61fso853716a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697838784; x=1698443584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WzWJpoQHx5+D0HoAoaQ26Oqa/Gs0v3iQByKj3cGA0I=;
 b=F0Xyjsq7Fl5tZqItF246JLDnCKTeaWapZm+yGZFI9c7INy4iOR/1YdWj0/Jz2PrhJB
 9jjbsRO7DJNMXleC6YDhuDgG7CuoucX6SGmjgAzHrc6pp/WhpN1CZMzE2/tZkto9hbI8
 p/DwUf6pdcIBj/RXwOwdIL+E8yOdQAnRtRis0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697838784; x=1698443584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WzWJpoQHx5+D0HoAoaQ26Oqa/Gs0v3iQByKj3cGA0I=;
 b=EFbA1pnPXnFf+1AbT6mGaFIQmDjnP7vdscpKxuE+OEfqPrutxL00WqBD/SgM9TPQT9
 fusoKagdZ8ARRPlrwFyz6rGBz+dwOXtmO7HM03f89+2Gdwz4nf4lCZI3mELf3jyEAQKG
 qP1eVOfb5ppiXYUb9eErSApiP6EBKEELzMRg9Lx+U9l9STN3g85ufrXkt0BRZ6eXYGhC
 n+kkxZOrtjwJAQkAOntkdFlo8KUoEbfo/AQQGHwS8M09t2l+Rk7LM77b5iz9tBaSprGW
 JJmPbKeWoTmQV9EulUQpt0tP7AdgpmOYV9yNIp1ducFmmvOZZ3qxQ3VR0JTjr38/So3/
 SAjA==
X-Gm-Message-State: AOJu0Yxp+Hn9PLfOZr9Ufn/sGb1fjllVB8xSNVHYC0rQI5LhnQCcD6+P
 ZuvsQeA5q5nVLTBUEPNofqXP13v8qz6J1JYQG/7ghQ==
X-Google-Smtp-Source: AGHT+IEKuuWRvCiG3hBLBSsjMiZRDuJ1lTdmlTrL2Kcya80vVqAhEIDGJvPmG+Ej1sRZfl0GKzfYHQ==
X-Received: by 2002:a05:6830:4387:b0:6bc:de62:86b with SMTP id
 s7-20020a056830438700b006bcde62086bmr3738214otv.7.1697838783863; 
 Fri, 20 Oct 2023 14:53:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 x63-20020a81a042000000b00583803487ccsm996111ywg.122.2023.10.20.14.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 14:53:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v4.1 1/2] sandbox: Add a test for disabling CONFIG_CMDLINE
Date: Fri, 20 Oct 2023 17:53:01 -0400
Message-Id: <20231020215302.3511807-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-24-trini@konsulko.com>
References: <20231019150105.714407-24-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Now that everything is working, add a test to make sure that this
builds correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_sandbox_opts.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 test/py/tests/test_sandbox_opts.py

diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
new file mode 100644
index 000000000000..91790b3374b4
--- /dev/null
+++ b/test/py/tests/test_sandbox_opts.py
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+
+import pytest
+
+import u_boot_utils as util
+
+# This is needed for Azure, since the default '..' directory is not writeable
+TMPDIR = '/tmp/test_cmdline'
+
+@pytest.mark.slow
+@pytest.mark.boardspec('sandbox')
+def test_sandbox_cmdline(u_boot_console):
+    """Test building sandbox without CONFIG_CMDLINE"""
+    cons = u_boot_console
+
+    out = util.run_and_log(
+        cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
+               '-a', '~CMDLINE', '-o', TMPDIR])
-- 
2.34.1

