Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8335CE95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F5886F94;
	Sun,  8 Oct 2023 01:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LmPr+/Or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF79186E08; Sun,  8 Oct 2023 01:15:20 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5C986F2E
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3527428a402so12309335ab.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720406; x=1697325206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9Y5zyVtOGpNrfASkWxWb2z1nMrBMT90XqkH7nGJkmc=;
 b=LmPr+/OrlF2GvItE37F/PSN8YnXteVoC6z9I519dYQnrnNCs2fSEU3+QM/WN49ocrN
 uvreT/Dvg874MaYM25FQOKJ4Q/5VB/mVg4z8evX2GQC2/L4cTnB1wrvhT3viAjRLdQtN
 j0CBweyEpm/GqEbk+WxIo5YhHcoUccjB+cC+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720406; x=1697325206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9Y5zyVtOGpNrfASkWxWb2z1nMrBMT90XqkH7nGJkmc=;
 b=LAdO5iYlc8x77XYtSTAUdnmHJaSCHlP6ge6ghmawXFPMz51+LgZ1epyzlwNUc4CU1w
 OLKuLeUQtQtrcW/OXIuejy/kaxXZOKd1Fe3WHdA9TPyBsL4mnv1y2nPC2kQYjEBdYGha
 PYNtoB+Nis/WedfjgqxmLpIEdXvCvHNNJydu20yRelFZyzXxIsvgnfad7cCArkLGXpK9
 MSbX1bdj4mCezkRsZqoKdGHAw74D+xDL4/IjLtiLi9nLFkO1mnAoP4cbG4ZvTvk4niPy
 mZeuhBlj3VlUgrA/fjeWJPVqYqNyV/6D85V6ZEmnRtm72z3a8+tckDdu8+gVwe29V59T
 drXg==
X-Gm-Message-State: AOJu0YxeSJX+550KxYJA8OC1YocOhwlJRlKVkc0TwqydZpEcJKp0V8h0
 T/hty9k9OxDxN2NYKCVoFkJd9oOaPNze5wiVkkI=
X-Google-Smtp-Source: AGHT+IElEA6fxoAmJoAMLu5LQ2vghRaOEVgPq5XpMDcMki7U1ll+BfSmA1kZCyBemClOykaaynkV3w==
X-Received: by 2002:a05:6e02:20c4:b0:34a:c61f:9e99 with SMTP id
 4-20020a056e0220c400b0034ac61f9e99mr13962033ilq.9.1696720406171; 
 Sat, 07 Oct 2023 16:13:26 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 27/27] sandbox: Add a test for disabling CONFIG_CMDLINE
Date: Sat,  7 Oct 2023 17:12:46 -0600
Message-ID: <20231007231255.277623-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

Changes in v2:
- Rebase on Tom's LONGHELP series
- Correct 'of' typo

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
2.42.0.609.gbb76f46606-goog

