Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0E6C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D981F8860C;
	Sun, 21 Jul 2024 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n9f/hrfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78430881F4; Sun, 21 Jul 2024 12:10:13 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14C5882B7
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so1089568f8f.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556610; x=1722161410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bLnFuS0aZWJkifhH0Qryx5VpIJGA0hEJ2OTlge3/Os=;
 b=n9f/hrfuoiRy+n4agrQn6TixrzXTbmK05/fBTZIujMN1zi8919XknJwy6E9RYyXRaX
 xDQyAe0SQpNHx2MzXGqsXxoiNE31QvVi88nZI8CNwvp8ws8YL9Qyhk9iRRJErrSNcCnJ
 wD1Z+eKTib30zDbC8mGixySRkhvy6aP5GKvyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556610; x=1722161410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bLnFuS0aZWJkifhH0Qryx5VpIJGA0hEJ2OTlge3/Os=;
 b=TbAp0DBD2AwPkTvPMhwLVZD2qMjpkEIUo7DDbguutZpVC5/0duJmAkzoyBWt3GVZ3z
 E8iLau0ci6Ua3vYnQAmtYWtmSeq3s7fC3Y+fAiLSt3BRTvOcuVwIAaYriRaCrLU9A3iX
 jaeKn/wXEDZE2VOGqRCQJkj5B58L7iFtpV5IppDVtOYq/O7SPU9Ulh5de48ubvIZdZ3h
 PqaxJ4d1137LS/UVoBaEJ/FqyoKDyTLu94JXufVGgGz+v/DGPNX7wa1dga1q0Vm0yowy
 wX0G5P27pTMhSCDMLA4FVAU9FhrqFKHE3Z2q/ne1LTosx8QiCVloCDBqE6S41q005TTi
 zjtQ==
X-Gm-Message-State: AOJu0YxpqdmQPZgruCaNpOydzufyw0v/JKAWfFEuSLF7pl7tMihqWMqt
 pCMs01IE8XAcSNawikrWBNtUsSsNds3wO442j/keHKQHKkAr7Fqjo25gEUO5PSg/h69mpSDkt+Y
 =
X-Google-Smtp-Source: AGHT+IHnX1gzoZhX//Intw5tsZxi4fUpUWgs7yvLP/Kz/r3pewvPR6VbQLs6NDi0okkXcuYVeq+vbA==
X-Received: by 2002:adf:cd02:0:b0:363:776:821b with SMTP id
 ffacd0b85a97d-36873a3d5b0mr4648555f8f.0.1721556609767; 
 Sun, 21 Jul 2024 03:10:09 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/21] sandbox_vpl: Enable Universal Payload
Date: Sun, 21 Jul 2024 11:09:35 +0100
Message-Id: <20240721100940.3202027-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

