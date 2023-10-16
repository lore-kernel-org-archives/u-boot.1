Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94309CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA1786F61;
	Tue, 17 Oct 2023 00:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KjGjuD7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097DD86EE3; Tue, 17 Oct 2023 00:34:09 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D514D86F65
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-66cee0d62fbso33801776d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495609; x=1698100409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Tffma6ecooOinpEResShLXQ2D3EQSbCsxGPO8zE/og=;
 b=KjGjuD7BfrCazTW/8+C9w2bi9cSokTovBHmvXkM2t/W1Sb5ZkxUOahKcMYlBbTWgdz
 eQbcg8LE0qgPaE4lXvagBsUo2LGqM0lTsAS5KkSY3/aEYHg/cA0+wn9Lr/NTV4Jec9L2
 kxxpog1Z7lDWDSVMY1zSwFyC6hu6yeDOK+hMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495609; x=1698100409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Tffma6ecooOinpEResShLXQ2D3EQSbCsxGPO8zE/og=;
 b=Y/1GJFaRYoPSoQURbtNMjC5DGZQ6B0Kr388RGBK90z19qb7jjoJ+PMEBPWjWSMD5yQ
 p2ngLjNC4xfUDKCQbJXZDZASU+0tdIbozXCCpxTj0SkQFUbLoUPkCg+8QpoSf2HHlaEG
 lsR5S4jjpDivQtRYlqhgsGpO+XklBQdZPrj4KmHpErkiTKEbaLZgQftZqDm3dBQz2DJk
 AGmspaz7QsDzJepdwpWMDCALDX1IbSWsxvoE9UBUDM0pETKqEQDMM9sApgGDsZKeVzyZ
 9IUPVJsDv8XXFuSqW/ILN/R1cfq1NYq3CSiEvAX9azcXJiBu22M3pTTkH54GRtN2rLLM
 SIlw==
X-Gm-Message-State: AOJu0Yzmbalw922escSh0/ZHxhXNeqn5NXubNWOhhFdwCV9aVVTx9KEa
 GBH/Vbgq9VCIwL16eNyAaXHHL+QUCmzDawayMmUgxA==
X-Google-Smtp-Source: AGHT+IFTiMCcYaMRnVI3rJQBNO3aHFNUniqBFGzIp2COKd3rhO/mHDelpGaFDHWsohgnFPAYeK20yg==
X-Received: by 2002:a05:6214:4114:b0:65a:fc5b:bc87 with SMTP id
 kc20-20020a056214411400b0065afc5bbc87mr745782qvb.58.1697495609707; 
 Mon, 16 Oct 2023 15:33:29 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:33:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 32/32] sandbox: Add a test for disabling CONFIG_CMDLINE
Date: Mon, 16 Oct 2023 16:28:23 -0600
Message-ID: <20231016222835.596572-33-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Changes in v3:
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
2.42.0.655.g421f12c284-goog

