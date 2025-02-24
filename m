Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE69C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649C480F91;
	Tue, 25 Feb 2025 00:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9D8jl4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F1081417; Tue, 25 Feb 2025 00:08:35 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F06814BD
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-855a1f50a66so127302239f.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438511; x=1741043311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhDiT2/QcnNbKtha99okNeLSo+uqtFiyXb4bBMuvFFc=;
 b=L9D8jl4EV5X73nZmHyA0gU7pTnrCPtfQlHIrITa39sQfv2+7+YTSwj8zxlD7qTpyhF
 9AEdbFRBdrvv5jSGZetHNtXuNPc/od9Jq4gQ7MC9THnLYOg9fcY7ieZgi0e3dYmmAg9T
 Bqw8+JH4HZHyJOYCrnuxAQ4ytCAVb0PWe1KF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438511; x=1741043311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhDiT2/QcnNbKtha99okNeLSo+uqtFiyXb4bBMuvFFc=;
 b=iQxrTGu5KLuz+Bzv3YsvfRjA3gzeeVNFgGNvFTnd/FvUVg4DGmO9pduuhTasnmiojw
 Hx7xEnl3UJGSMuMymSZIIE7OrGXJvcNVy1ugLV+CnNMt3ifiN4oH9z/byqrD8Y3+sLS/
 uHNUY4im2uQSCGTRUTBiq+HBxKaPchFtd7bhYLSLp98J/i1mTWh4ZpsawPKKIZ+8LKCZ
 3XublJV0Eay1QpmqsDwdbErfSguKIv7p/PyqAlEZskU9je/vvb+9vTAxxdkdHcmbfneL
 igQKaP3jFYlo2ttsRQYQb/D80WVNiEI8BfOk1YsV2XIpe4+MEeGHs6LL65w77Ds9Ht+U
 qcmQ==
X-Gm-Message-State: AOJu0Yz5WMb5jTKnasIv7gUyqfOkr7YEFuHWvsMPOLbFRN+Jc76rtEH7
 fexRzQ+jBTjI/BYAXG5a0SU2De15Yas345Eqw14YzB6qDSJnz5l6SF6KRYy/9LBIbEt9aavF5Kc
 =
X-Gm-Gg: ASbGnctjj3q15GOzD86Zk7s2bQANDrrzoweuH4M6zVaoD0DMpaJ5MsJeZ1x6uNzNLZI
 8hAIJzBBNP9w1lObsByzpy9XgNz5bJW6LVFgDNlABy/T8Lkcj5stGchIocTeMZ1Wgp/shNotDNI
 Jj0YMON7Hj7CAP4P4vA8EvSVuEYjwguG50HFuPU0QBA/1DB1x2Y57ecKPw3HeSkitYGT1v2WBP8
 g7JSfOlMsSUyifPbMe+5no+kM2At7cy0ByT8EVWg0BPfC4sOjHkrB7hFNjxWa0MXXVQDAyu6rix
 RkheO3p3HB0vDBfcycOcEImpVCb7bF22thSH0uwT6iTDBk7CCzMSrH0fDl2WtMk=
X-Google-Smtp-Source: AGHT+IHTgk1aty0TEdwpNzYH3hlWj6sJijRi1oMPJ18Rl8io48tssTuM3EiCskKmEoGNPHxJ+/SOeQ==
X-Received: by 2002:a05:6602:6c16:b0:855:a437:141d with SMTP id
 ca18e2360f4ac-855da9cb178mr1901178339f.6.1740438510846; 
 Mon, 24 Feb 2025 15:08:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 44/44] test: Add a test for booting Ubuntu 24.04
Date: Mon, 24 Feb 2025 16:06:33 -0700
Message-ID: <20250224230640.2665206-45-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

Now that U-Boot can boot this quickly, using kvm, add a test that the
installer starts up correctly.

Use the qemu-x86_64 board in the SJG lab.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Significantly expanded to correct e820 and other issues

Changes in v2:
- Add more patches to support booting with kvm
- Add new patch with a test for booting Ubuntu 24.04

 .gitlab-ci.yml               |  5 ++++
 test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 test/py/tests/test_distro.py

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8c49d5b0a79..ec799e97c10 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -745,3 +745,8 @@ zybo:
   variables:
     ROLE: zybo
   <<: *lab_dfn
+
+qemu-x86_64:
+  variables:
+    ROLE: qemu-x86_64
+  <<: *lab_dfn
diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
new file mode 100644
index 00000000000..51eec45cecc
--- /dev/null
+++ b/test/py/tests/test_distro.py
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025 Canonical Ltd.
+# Written by Simon Glass <simon.glass@canonical.com>
+
+import pytest
+
+DOWN = '\x1b\x5b\x42\x0d'
+
+# Enable early console so that the test can see if something goes wrong
+CONSOLE = 'earlycon=uart8250,io,0x3f8 console=uart8250,io,0x3f8'
+
+@pytest.mark.boardspec('qemu-x86_64')
+@pytest.mark.role('qemu-x86_64')
+def test_distro(ubman):
+    """Test that of-platdata can be generated and used in sandbox"""
+    with ubman.log.section('boot'):
+        ubman.run_command('boot', wait_for_prompt=False)
+
+    with ubman.log.section('Grub'):
+        # Wait for grub to come up and offset a menu
+        ubman.p.expect(['Try or Install Ubuntu'])
+
+        # Press 'e' to edit the command line
+        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
+
+        # Wait until we see the editor appear
+        ubman.p.expect(['/casper/initrd'])
+
+        # Go down to the 'linux' line
+        ubman.send(DOWN * 3)
+
+        # Go to end of line
+        ubman.ctrl('E')
+
+        # Backspace to remove 'quiet splash'
+        ubman.send('\b' * len('quiet splash'))
+
+        # Send our noisy console
+        ubman.send(CONSOLE)
+
+        # Tell grub to boot
+        ubman.ctrl('X')
+        ubman.p.expect(['Booting a command list'])
+
+    with ubman.log.section('Linux'):
+        # Linux should start immediately
+        ubman.p.expect(['Linux version'])
+
+    with ubman.log.section('Ubuntu'):
+        # Shortly later, we should see this banner
+        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
+
+    ubman.restart_uboot()
-- 
2.43.0

