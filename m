Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F829C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB10981DFA;
	Thu,  6 Mar 2025 17:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N49chzGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6F181E72; Thu,  6 Mar 2025 17:06:32 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B2181DFA
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so68406339f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277189; x=1741881989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agAGdBNoas5c/RnTgHY5mNPdXr1Z092ltVStE0Kp5Kk=;
 b=N49chzGTHzJs4IhaqxqGu01j7tHGvKSPNucOH0kp5ezwCNWJR9Q+ZripSvVUtsXwC2
 C+rad5D4VVIjdPtrBW/Qj1jw7BbyXM5nayEztk1iTENEy0rhhJ6j9fs3tpYAaKv220/e
 qfsbne9rDwoLQXuuREHddUR/z6+iierVQ1R4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277189; x=1741881989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agAGdBNoas5c/RnTgHY5mNPdXr1Z092ltVStE0Kp5Kk=;
 b=lhMHNQceZaeQ6HvMiEpAGydrjP8Vibu77Q6IqbOGDqcUwvRmVchTe4Ib8yIT4kKMt1
 UiAZLeARSnxnoeDzD9wseVV4+PsgtUrdm9WQ7TnmiNmXCPtCx3hiCDfRC2ICwI90zwuk
 RDiQIDtCf7jgbM8q4Dfbac1E3txgMAJ4Yr16BCb/2dz4/nfk6AFlehLbgwA/H34YhYEy
 EL4n4EtS5d/bJdddq5uf6hp/NAsAJjG7YVzireDDxzEnjL9NxPbfmoaMNcJr4MHRl8CV
 j6SeY/HMQNsuuFzzpdDvt+8FktSDOQytF7D8wcoleSl58VxQ0TUNNZQA0bAGlY/z4Lch
 nL7g==
X-Gm-Message-State: AOJu0YzPHkC3/q1XptZBdqfacF2ezBRd1MsGp+5Zhk1fOx2jPjB+wOLs
 DIUNFrtWQ2jdhzAcsvFHlxefUjGvITxr0iB041w8NfqypaOWRdxfgTV2iIUVhoEiJkUvzutoaZA
 =
X-Gm-Gg: ASbGncs+E8/BFrvOFH3/BjNQKiGhrpKp+Ohc+Ce4zLXaelGq60Ix+EUFoBfd5zGnkuE
 llqpLVJG6GxN5VsvqHUdEi7JfJR6YYOa4YD66f7gJKRnl5Hw5BnBlKnWSP3UZ0hMxpkhwGAKMKW
 kGNsUMCLAqHfUhoXRE364LOH9MvsZhuckqbO37me/F4RMbDaQRFXJC/4ZWbUXThQQRiwlqHGNG6
 EKDMCrthPwRtVlEALxPpWrPrhrrVa5x31eGCR2QEfUiH/K69otcvPwPCDtQkufCVIxaGv2gfjAU
 2douqSDQHgxhNHprVkBu+gic9iLDZHCZWArrb6VqfvidG69zg8Q/wNAJ4gtDi2o98shF/LLHR7X
 d7uzGPQ==
X-Google-Smtp-Source: AGHT+IE8l/4KstJGn2HA5TZezdgxZ77HYM0ZeCwIzba07D0EywnqN0GnQ5CxxVcEYIeH437s2gxClQ==
X-Received: by 2002:a05:6e02:1d8d:b0:3d3:e287:3e7a with SMTP id
 e9e14a558f8ab-3d441962873mr415965ab.19.1741277188738; 
 Thu, 06 Mar 2025 08:06:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 47/47] test: Add a test for booting Ubuntu 24.04
Date: Thu,  6 Mar 2025 09:04:14 -0700
Message-ID: <20250306160428.3041057-48-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

(no changes since v3)

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
index c6461f33982..4c8af2890f4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -747,3 +747,8 @@ zybo:
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

