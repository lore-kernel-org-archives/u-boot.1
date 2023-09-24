Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0919DCE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D388A86BE1;
	Sun, 24 Sep 2023 22:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3QvY32l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AB886AE6; Sun, 24 Sep 2023 22:40:45 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A39C886BDD
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79fa416b7ffso130997439f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588041; x=1696192841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XHQG749kFNwHaXjCgrTN72qxQ19ISVuUnXeuXwdS4s=;
 b=k3QvY32lG5sPKhUSLCioNirKwDvpzOiWZENauVY26TNS4aFuHdNDfTfMomsX3VheVx
 HMu1BxVkMTwvb/UpPGWDJ1Zrbony12fn5Q4q0dHvASwSpGs9hvurOSpk1rZxSDvagUFZ
 pMVZoUSkEzsXQ6Rz4bOCZ4xdd2lpcn9XV2b7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588041; x=1696192841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XHQG749kFNwHaXjCgrTN72qxQ19ISVuUnXeuXwdS4s=;
 b=coe1w2hW7qqtaPIqO4CakcWfN+XaLDSS6vgLKbGFaPBgr/s56GMts2inuUUaVHBrS5
 sov+IuxDnFEBNsrcMDXTF/SbPChYSjtKPuHKIRkKrc74tmGtxqQIZsABSAqpIMerq5+N
 pwfTfy2mGHBNak/RqkzVabginKrUprfcvjLGfIlWPIaCB083pL+XyC5vbHfOZs+Rp3Ck
 n14n+ePUgRT15D/ROlXsOO3ZEy5JCyQAbbqRMB6TdrGLfAnnVtiWT5UwR8xqSHYfzTD+
 OIo/xUVIX0Oc0FO/orRW/KFhaTklLE4H3WrL68vYw/cg5tvPqtazYUp6+4okMUd6oLWR
 XE2w==
X-Gm-Message-State: AOJu0YyfrMll7DLXcK9q8J4yY84smiPfENvsR8W3AMYl90v+AvJFstCu
 uQCFqC/2nD4i8p4tXvP6WrRRht//zS8/tSBAlvc=
X-Google-Smtp-Source: AGHT+IFTwpklX5kMKaJFtlLg3ORdSe4SfqrgwQ3zCXlIDmwzTptPmw7EZKPBOdONvk+ZCDXc8FQ6Xg==
X-Received: by 2002:a6b:4a17:0:b0:795:16b8:85fc with SMTP id
 w23-20020a6b4a17000000b0079516b885fcmr4964505iob.0.1695588041301; 
 Sun, 24 Sep 2023 13:40:41 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 25/25] sandbox: Add a test for disabling CONFIG_CMDLINE
Date: Sun, 24 Sep 2023 14:39:43 -0600
Message-ID: <20230924203953.1829820-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

Now that everything is working, add a test to make sure that this
builds correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
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
2.42.0.515.g380fc7ccd1-goog

