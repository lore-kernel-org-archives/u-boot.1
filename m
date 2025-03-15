Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D21CC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DD881F7B;
	Sat, 15 Mar 2025 15:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C/wS30Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD64481F63; Sat, 15 Mar 2025 15:28:55 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F70081F3A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso3704415e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048931; x=1742653731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XVbFJsWG7DimCHXXTKaOeY5y6+ozKvlWF4h/jkxTLo=;
 b=C/wS30Wf3EY/dYol7lgqw4MVsz9OmC6VIa+ipLziP1PYFYLUFvCHF+HzBwtTKLP1LX
 byE5dX637ZXkAIxQ4s/glhPQXUSRhWMZ61WSh1tZk6tjDL0gSOpTUKn+uVAULrtrp4NC
 HlCoF501nL9IrzpNqpVBvN28mRJLmowJrIqUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048931; x=1742653731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XVbFJsWG7DimCHXXTKaOeY5y6+ozKvlWF4h/jkxTLo=;
 b=rAmJ1b6cZfdGl9J21qfrMFC+USm3c1fzWJpnC6V8nIGanNwOGFTsmYqeH9StmQkERK
 Uci2wHzXTWFHQVKQVAIEH7RHxHHm+i4bfW74DYzzOwo1EX2QxtR2F6RP/QxeV7S61d8z
 OQXcC5jCIB13FdvJERdDGOpo67qnSIxkNtszJoZ16StB7e5yoX71wIgQZ3R+6KMjB5Zs
 9qPC3YE5dqGykxnwVKvx9O/LWJZ8hi7myIxI8rtIAqVlSCQANTZS43qdh6TfBaYjNHIU
 WMpjW7a0ULVRJ4Ld2dGn5phmbYk1WzhlZ8fUi2ff5VNX89RtOzsxD0Kzk6kCAB8ltRIs
 XkoQ==
X-Gm-Message-State: AOJu0Yzgfh9xvG9WQOFf+wuFkGemPzfKDHCa+RcCDto4885Sl8GHO/Ds
 Ztxfn6aw/uXiftQEuJxMDt69Laqj/WRZzcoOophMdSFWsfgnjXkmsJeuWm1ZDKjjt2JWdmTrQ0w
 Kvg==
X-Gm-Gg: ASbGnct0P8swLAia40o1QPfdT33FTjPv19buiqTwUVdzkyBlJ5IKLFGonMcV5dG4sNO
 edOCs6W6VQYtpkkMnAX1R4mr1HkCPYIXwnUa1/xX45sACmH/1tdi47UEzjk9P77za/xcfSqFdrX
 +IuAypLhVQifTyAHQPmaskcx0O8moC24ByYK2sifjg6YbejWEBULrraMmOmDv6BaWIsyboZfLqo
 d/Eg+/thTb+n48udGsdQiXgAThszW+u9kSiiJ7O7SZ2VH5jJejhEYO4f0q2Ekt/kBdmqVu6/XO4
 OtUUCZz4WVDL+9TDFx1lClT2Jldp2QWI1ChR/5PmZQ==
X-Google-Smtp-Source: AGHT+IF4olHiQxdAseL58KtYpVZwECICL3GivNpjzr7g6VcYXkgDoS+G2Ihj8JwJuHB2hPZ4o7qsPA==
X-Received: by 2002:a05:600c:3b87:b0:43b:ca8c:fca3 with SMTP id
 5b1f17b1804b1-43d1f235e79mr80544735e9.11.1742048931437; 
 Sat, 15 Mar 2025 07:28:51 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 46/46] test: Add a test for booting Ubuntu 24.04
Date: Sat, 15 Mar 2025 14:26:06 +0000
Message-ID: <20250315142643.2600605-47-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Changes in v5:
- Drop timeouts patch
- Use Ctrl-N instead of down-arrow to make the test more reliable
- Add more logging into the test

Changes in v3:
- Significantly expanded to correct e820 and other issues

Changes in v2:
- Add more patches to support booting with kvm
- Add new patch with a test for booting Ubuntu 24.04

 .gitlab-ci.yml               |  8 ++++-
 test/py/tests/test_distro.py | 61 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 test/py/tests/test_distro.py

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c6461f33982..0a7eef0a1d7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -572,7 +572,7 @@ coreboot test.py:
     - export USE_LABGRID_SJG=1
     # export verbose="-v"
     - ${SRC}/test/py/test.py --role ${ROLE} --build-dir "${OUT}"
-        --capture=tee-sys -k "not bootstd" || ret=$?
+        --capture=tee-sys -k "not bootstd ${TEST_PY_TEST_SPEC}" || ret=$?
     - U_BOOT_BOARD_IDENTITY="${ROLE}" u-boot-test-release || true
     - if [[ $ret -ne 0 ]]; then
         exit $ret;
@@ -747,3 +747,9 @@ zybo:
   variables:
     ROLE: zybo
   <<: *lab_dfn
+
+qemu-x86_64:
+  variables:
+    ROLE: qemu-x86_64
+    TEST_PY_TEST_SPEC: "and not sleep"
+  <<: *lab_dfn
diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
new file mode 100644
index 00000000000..bdf4ab657d1
--- /dev/null
+++ b/test/py/tests/test_distro.py
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025 Canonical Ltd.
+# Written by Simon Glass <simon.glass@canonical.com>
+
+import pytest
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
+        ubman.log.info("Pressing 'e'")
+        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
+
+        # Wait until we see the editor appear
+        ubman.p.expect(['/casper/initrd'])
+
+        # Go down to the 'linux' line. Avoid using down-arrow as that includes
+        # an Escape character, which may be parsed by Grub as such, causing it
+        # to return to the top menu
+        ubman.log.info("Going DOWN")
+        ubman.ctrl('N')
+        ubman.ctrl('N')
+        ubman.ctrl('N')
+
+        # Go to end of line
+        ubman.log.info("Going to EOL")
+        ubman.ctrl('E')
+
+        # Backspace to remove 'quiet splash'
+        ubman.log.info("Erasing quiet and splash")
+        ubman.send('\b' * len('quiet splash'))
+
+        # Send our noisy console
+        ubman.log.info("Noisy console")
+        ubman.send(CONSOLE)
+
+        # Tell grub to boot
+        ubman.log.info("boot")
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

