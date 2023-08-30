Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C083BC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9000F8656D;
	Thu, 31 Aug 2023 01:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LCqCOjD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BDDA86552; Thu, 31 Aug 2023 01:30:12 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B948656D
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso11390539f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438207; x=1694043007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhdtSEg4x0SqHlaqOqm4IZOCiTZuJiajfX3g9Y29WEc=;
 b=LCqCOjD7QNUJwTUcIkXq3qc3QK8Kt5hhnnbLwkTWgGzT5znSuf9G7OEXcU6DZH3NgU
 UPEIZLvEx5FJxjMVQ+ephmdA/au+WADfmPig/kcaOWNRm1oT2ow4L5ICOOW06XkPWmeN
 gmWLq9uhdwAsSgOV0nk+Ecuq0gBRE3i77oFqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438207; x=1694043007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhdtSEg4x0SqHlaqOqm4IZOCiTZuJiajfX3g9Y29WEc=;
 b=cH4UI0Dvt8lCW4ffbGypuHFwAwyn3wF1+Lt89hx1SF5DQekZtVuYG/5Noebpr8EOmu
 akwZGjX5sb71WB5SXGV5vW6c6zQJJdVNnuJIpPYWrCaUuSuB4kEIevHKu6efeCfcmujL
 pBNnrMziEBUbO43LqaXMHMyWqSbHPGopX7kM9+I5d0LDur4VwBGRy6OWtV3TpDODKvAD
 9qMG+4Ln3RtYq+ImfLZkUwpj+YlaUQ6GfnBYvCdgRTeXoSkj2TetN+mpgDsM/dSFAhl2
 kccZ3sxFy4o80g8+nCLBa7c1LkCkfon6Fq4VtbY4pfpJvKg1Rk+H3onYFCKQiTmp81qg
 4A0A==
X-Gm-Message-State: AOJu0YwTumHQWpFwQo09lwK6edq1ykltZdj3acDuCBK73obrL+G4znQ/
 4LjAp2U2hPJVa8nURDqxjt7FUjzeK0gkD9YslWE=
X-Google-Smtp-Source: AGHT+IECKbwEhDSU2ZW1mnDZ2IOb0r0NE9bGRvnNCMiFRRhCp25sZqDlOq5Cnozg40yt72UdUwomsA==
X-Received: by 2002:a05:6602:19da:b0:786:71d0:ff9b with SMTP id
 ba26-20020a05660219da00b0078671d0ff9bmr4321857iob.10.1693438207504; 
 Wed, 30 Aug 2023 16:30:07 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 8/9] sandbox_vpl: Enable Universal Payload
Date: Wed, 30 Aug 2023 17:29:22 -0600
Message-ID: <20230830232928.2590178-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

 configs/sandbox_vpl_defconfig |  4 ++++
 test/py/tests/test_upl.py     | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 test/py/tests/test_upl.py

diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 27354b8b5ed..598ec9620b0 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -27,6 +27,9 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_UPL=y
+CONFIG_UPL_IN=y
+CONFIG_SPL_UPL_OUT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
@@ -36,6 +39,7 @@ CONFIG_BOOTSTAGE_STASH_SIZE=0x4096
 CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BLOBLIST_SIZE=0x5000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
new file mode 100644
index 00000000000..0b24053e222
--- /dev/null
+++ b/test/py/tests/test_upl.py
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2023 Google LLC
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
2.42.0.rc2.253.gd59a3bf2b4-goog

