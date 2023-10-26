Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2EDC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7F687BDF;
	Thu, 26 Oct 2023 20:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rNjVURGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1ED87B77; Thu, 26 Oct 2023 20:32:07 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B2987B9E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7789923612dso94729985a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345124; x=1698949924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WzWJpoQHx5+D0HoAoaQ26Oqa/Gs0v3iQByKj3cGA0I=;
 b=rNjVURGCh3ZSeLEtCY7ZLTxSXTwSFgWEIqoZJGNw48o6ZWiweKKOnzX1YDHDUeK3S4
 VLzC5ZltClulMvrcMvbtyVVhbEHFogAateICXKqQCT4P5GN+y45CusPQX/eiGmje48/v
 mtCUSJAL+6imyTYdsfnuRAcp9M0NH1PdkOqWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345124; x=1698949924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WzWJpoQHx5+D0HoAoaQ26Oqa/Gs0v3iQByKj3cGA0I=;
 b=GPOq0kZL0dgXN7xV0Dm6Pu8XuUE3+hKh3ORcAJC41aLiG4rnqBlHUDDvCblLv0kdO+
 Jclmgw3wI35txQOl/88cimRH8g06j+EqRtIoVrD4666pcInPTthgcfBi91HiQTx47X3n
 UEh7zQXyLIXK7iPXZm9uVCAsYER8elnlOmfbB1otnQ75/yarGQqwJZi+fUaAnWjJ5xsy
 9kWV0IMtQ5YELzVQj8VFIKWIUZ/W98W7ICknrY49Eket/xh0fKBiSprQiBzxm9isdsgB
 DtOoRxl1jaa+1X3BNAlovgndWzie+MmndNM0rKlAgkYIihjRAc5f9NnugZ1Ahrf9SlVh
 2rHg==
X-Gm-Message-State: AOJu0YyPkhrcWzcWWxsR8NRI67Umzmi53RirQSeHEWRTUF4oCHne+Mpa
 pBctTmzNuGj1ib6iqYVWzWjEZa0lw2kiktqnVVjRfQ==
X-Google-Smtp-Source: AGHT+IErKOjBo2eg4laZpw3AxfOziN9xBbjLHGs5u75cUlfJ57wmYdRueuA1T/z6fBp7hKC2D4nenA==
X-Received: by 2002:a05:620a:c4a:b0:775:a534:c010 with SMTP id
 u10-20020a05620a0c4a00b00775a534c010mr124222qki.57.1698345124124; 
 Thu, 26 Oct 2023 11:32:04 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:32:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 29/30] sandbox: Add a test for disabling CONFIG_CMDLINE
Date: Thu, 26 Oct 2023 14:31:37 -0400
Message-Id: <20231026183138.636948-29-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

