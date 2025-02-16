Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA5C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1CB80FDD;
	Sun, 16 Feb 2025 21:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X6monr6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA962808B6; Sun, 16 Feb 2025 21:46:06 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E6F180F77
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8557f4789daso18641239f.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738760; x=1740343560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwNrabfA5C2+X0Tx7GS4RtZuU2IB0ZiLtWeiaSJswtc=;
 b=X6monr6lgyD1fm4IlNOjotNioKHYN/gqx0W+ZPB2GJWE5NYObYl+ZlqgR2Tkj+jNpL
 bdL60FW0euvHzCIvlKOwBdPE2IQ3u8UE+JlT/jNK40XS9a8C4f7onnShQU2n1NWnSO62
 du/iRmqq5Y3uTOgQkYKqU6BM18u74DaA6HK9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738760; x=1740343560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwNrabfA5C2+X0Tx7GS4RtZuU2IB0ZiLtWeiaSJswtc=;
 b=uXK8yDXtBDd6rxNHlhtQ5Z8TW4WfAR4ckNWhlhKEE6A0rph999jH2KdtlF6VdHnrP8
 MNi3BnTi9zzbPYzJTsvP36cfoMou0B1/Ug9uMxU/2w5+0ePyF3DTP2/CSCfSJeGfW1S7
 ZDEOziigpmzzu2fVRySQP/xG7GazyyLSjOEnPNlsgC9/JOyj5Vihyz5wxRNzh1numnvi
 ESkNmGD4zHpFi3kfXUNf7QasDAQ1DDRqh0yL30w1o90JbIpXxzNauyutiThb21IaKtO+
 ZITFiUy+QnprsxSY4ZERcF7gyj1IzS4YafO8YZO15SvFpig+J545pD539kUf+EtTMyxN
 DH+Q==
X-Gm-Message-State: AOJu0YxPk70E0yynVEuXijTFj1lzFKp84ARPcoEj+90CCAcRioQlX9NO
 uFuA0Rrdpgv8UE7ywM1+pt6ix12g8YytLoayd0Se3lCFG43HJy445vhAKtOfnZM9LH/DGOPDygw
 =
X-Gm-Gg: ASbGnct2q57jBYE/iopvgc3NoTccyytjkTjW7MA1Ei/OXgVCiDPjqEqU55IvLIwNgLj
 pkRqkEVJiYqj+K4Vdph7KVN9XGqhyakNxYRAQfmSdc0GJgYIZKyvla09tbSgQRPfkqTWb0PIVDH
 sLPI07cP8qJUvgVxtVbKteqWVbEQ6e7pbUKaqvTUqXItC9d3T42a+HMiAcIMRoS+GjJ/ME1ret4
 3/eTUwDDXjXiJ2Qov9qElQ0xh9QDNv7731q1XZXEXtS0je6KA9eOUHutr0E8/tbphwFC3xSc/BT
 Mkrq+H3RLiGucSvn1MJvZuogcXe7KHLNe+Vj6t67jWQ2dPPE5vFp
X-Google-Smtp-Source: AGHT+IHZv4pRpKy+hEwToOkhQ/LwujdxlbhLGFUunG6+mBI9Eex3y3JZ0nJmlAWWc+9I+a8CcXXLUA==
X-Received: by 2002:a05:6602:1509:b0:855:1f81:24b6 with SMTP id
 ca18e2360f4ac-8557a0b9a73mr771409639f.4.1739738760404; 
 Sun, 16 Feb 2025 12:46:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Date: Sun, 16 Feb 2025 13:44:13 -0700
Message-ID: <20250216204421.3560012-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

