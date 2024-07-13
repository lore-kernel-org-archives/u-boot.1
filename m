Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC2C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6017288863;
	Sat, 13 Jul 2024 09:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E37DZUgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FCA88861; Sat, 13 Jul 2024 09:04:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9FA88842
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so17915485e9.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854236; x=1721459036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bLnFuS0aZWJkifhH0Qryx5VpIJGA0hEJ2OTlge3/Os=;
 b=E37DZUgkpFcuwz7umDELb0vbZSKQbC0s/VQebRTqiKvaREvlRkR1XhQNm8Z4tnb+Xz
 7vJDRiJM+Nld2j5qBnP1JsscZu10TDLQoR/15AUPJwU/Bt5TySOxHazkBh+jS2OI1qwa
 eocKZF/SzzvXPLGfT7qdcFxfeRy91r0jQqA9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854236; x=1721459036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bLnFuS0aZWJkifhH0Qryx5VpIJGA0hEJ2OTlge3/Os=;
 b=etHtftVOGo+8LqsDsEMQ5A5himsqbIKU21UOSs1gGq90DTVRT9gDgsGZsuVtITudja
 VSIft/mBn8BqwAAVq9mjFzsWJg2aInBZQHLyF8fu9fVslQIf13bTRKVGbn2MwBZerSIk
 geGKYMynegPFhi07fms0BomR602ZbHfiP8xtu3BWpIKrkBu2MuLftHbGeQS1bkt5yGqP
 CTb66PTiQlwA5lBYS+I6iCyhkhfW3K/JLjB4uB9Bb/gMpJMxZzb/2R3u9rSpq0Y9pGzL
 Dh29Kp5S2KLTs76xrWysK7UKv7izTunNoyyNmkSfKjGJOY56qbdxu0y+WoseieecrV4K
 7PNw==
X-Gm-Message-State: AOJu0YwVbVNquQObBSCpj7/QclnuvINCHRF9q3OfefwsS07t+k//LfYj
 2IOItRN3xnzpPOIFH6ynctGwvHgi1UjYMscCFY6tIYgzSKOoATx1MnEpxJ6ybZZHApsjxnjMVMA
 =
X-Google-Smtp-Source: AGHT+IF/mgXITjSVPntEq+9l5d55WhXXhVYoUUF6AUEpqpfvoklS6wrAxFkxh2uNXjxeez1IRfezXQ==
X-Received: by 2002:a05:600c:2248:b0:426:641f:25e2 with SMTP id
 5b1f17b1804b1-426708f14d7mr97816775e9.25.1720854236461; 
 Sat, 13 Jul 2024 00:03:56 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/21] sandbox_vpl: Enable Universal Payload
Date: Sat, 13 Jul 2024 08:00:51 +0100
Message-Id: <20240713070055.2172883-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

