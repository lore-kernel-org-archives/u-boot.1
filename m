Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78434C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA2C88B77;
	Thu,  8 Aug 2024 00:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BlOVfySF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C96188AE3; Thu,  8 Aug 2024 00:48:22 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0256588B09
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso49201939f.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070898; x=1723675698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bLnFuS0aZWJkifhH0Qryx5VpIJGA0hEJ2OTlge3/Os=;
 b=BlOVfySFqQRHMpTf3VWZLgDGVCqolc9CSublE1VUjggbcrghAuNxFVRC+V+nMoMlt7
 UyBIF4+JWND+Rj5njE5O/QRaG+4aO3MOnzx919avKFkoWUkM0jDeRkSeDvRig+mIQiTZ
 07jAvhWWvT2r0JGdudyS/dWTnspSC+S0cICGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070898; x=1723675698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bLnFuS0aZWJkifhH0Qryx5VpIJGA0hEJ2OTlge3/Os=;
 b=p0fFF9cUaK+xhWHxsSorwMWJAgtPJW8XTq2uSL4OshgQZ/aI81S3ma3emW3mB0C/sm
 xPslxHQkSsWEExv2YvKHUH02RcAFml6M3ZW2IuCfjB4fgn5ubLJapbhm8HWuCdJ8+L7V
 MsZk5rne5yW5ExyXpnfKt9hivwfnJwPWBRDhAB2N3B5ZXQy8VMtUXrrBAYk37l6cSynd
 JNhgDuuf1VWw7+stf46wKWc+mytFUqJaYqs696kcp0U409k3wdx+GNc+AhSn2XfKF8o2
 cKFFA+oc/Rlv+JIip5TJmdpex6gJp3cKhkq6vKIYb2qlAbVUn7udw8BHtG3HlWfgdWg+
 Ziog==
X-Gm-Message-State: AOJu0YwtHvAPi/pm6O6BSqIaCp8BT+Y2AbxsSPzF1ahjScH1rku8ZHYS
 3s7ePv4iGShEVvQ0V032q5GwCm/bEjgwBBqdUd5lXrK2F6cTJqu2lNK3piaLW+3mHNEhfpb8CrI
 =
X-Google-Smtp-Source: AGHT+IFX1Oq3ZuG09XeB4RF77WxCd5hndYZVMiXsQzpCJ4VSIOaDuYPB9xm8HuMxoZoAQLpy2Ln/sw==
X-Received: by 2002:a05:6e02:154b:b0:39a:ebb8:15d2 with SMTP id
 e9e14a558f8ab-39b5eedb14dmr161355ab.8.1723070898575; 
 Wed, 07 Aug 2024 15:48:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 17/21] sandbox_vpl: Enable Universal Payload
Date: Wed,  7 Aug 2024 16:47:35 -0600
Message-Id: <20240807224739.3858517-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

Use the sandbox_vpl build to test UPL since it supports a real devicetree
in SPL. The sandbox_spl build uses OF_PLATDATA.

Enable writing the UPL handoff in SPL and reading it in U-Boot proper.
Provide a test to check that this handoff works.

Note that the test uses the standard devicetree rather than the test one,
since it is a lot smaller and fits in the existing bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/sandbox_vpl_defconfig |  4 ++++
 test/py/tests/test_upl.py     | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 test/py/tests/test_upl.py

diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 72483d8ba10..96e9211bd19 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -27,6 +27,9 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_UPL=y
+CONFIG_UPL_IN=y
+CONFIG_SPL_UPL_OUT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
@@ -35,6 +38,7 @@ CONFIG_BOOTSTAGE_STASH_SIZE=0x4096
 CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BLOBLIST_SIZE=0x5000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
new file mode 100644
index 00000000000..171079f8dba
--- /dev/null
+++ b/test/py/tests/test_upl.py
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2024 Google LLC
+#
+# Test addition of Universal Payload
+
+import os
+
+import pytest
+import u_boot_utils
+
+@pytest.mark.boardspec('sandbox_vpl')
+def test_upl_handoff(u_boot_console):
+    cons = u_boot_console
+    ram = os.path.join(cons.config.build_dir, 'ram.bin')
+    fdt = os.path.join(cons.config.build_dir, 'u-boot.dtb')
+
+    # Remove any existing RAM file, so we don't have old data present
+    if os.path.exists(ram):
+        os.remove(ram)
+    flags = ['-m', ram, '-d', fdt]
+    cons.restart_uboot_with_flags(flags, use_dtb=False)
+
+    # Make sure that Universal Payload is detected in U-Boot proper
+    output = cons.run_command('upl info')
+    assert output == 'UPL state: active'
-- 
2.34.1

