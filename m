Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68D1C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 23:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19AC082B66;
	Thu, 17 Apr 2025 01:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n9zOYVHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C4982F63; Thu, 17 Apr 2025 01:31:42 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9999082B44
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 01:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d7f4cb75f3so929805ab.2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744846298; x=1745451098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=05zQdPKUcrZSzYwpMo/jRDmfQ3CmBBNwXX+onalUxWo=;
 b=n9zOYVHqoF8H2n7YlzjevVAXoeJbaB3r2IQiXl82Y/W/hhTCOgBVHwB2ReN7IjoC4u
 VvzUaNgbqLfdih6o6MxBaHVFtgNLRP5GtHNMrWsfsYVYqpXMMu2+yrVkza9HV+TqDv+k
 1PyDXvZFlWVIl9B/KZo1UMrWg0cmRdqvHCMdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744846298; x=1745451098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05zQdPKUcrZSzYwpMo/jRDmfQ3CmBBNwXX+onalUxWo=;
 b=fzrG3wMmz7/AttbAas7uUZvp5iZ4AsM/oze6Xfx4OF5ytbFMrd1Le5eVkc+d1Gg7Wy
 jkYq25+qyojwEseqPnyrIffmPBZ0cTBTvJKMS6/TIOpu0fd37+fxRVYWYqxZ61YT6TNB
 wHoG40wGF+zmDMZI9cvanHUr9IhGes98mEqi5MC8/kmKj/FZs+9OfXGG1fyjtyR6lGB8
 w0kjMJbYieotEf3Nc8hz/117UM2CaJE1g58GD1jogJTvnry5UZnzUW8pT7HiI3fOnLia
 qdwm4yDEP25n3Rp6fpgrKuPp8EqwO1OagrA3GlxlfSdii17dFE2Krl8Nnrg5TXH+i4zb
 /mzQ==
X-Gm-Message-State: AOJu0Yx9rNz6G0cwau8wGZCjM8cu9g75nWsuqBIgcD2kEjfiD2zRWzNm
 Shq/WyO8Skz0gTHMsXanIFyQw5UCoPM7BXQl3TCBKawaTF5bC/brLM0RlXRzDEQ2P3zl2XbjcMY
 =
X-Gm-Gg: ASbGncu+n1WLPCKhHkzPBc48gFmfWaLc0/UzXhdnBUAFb/R0vmw7Q0wFgFN0U05HwBi
 oOksF+66nF6H3YK4PxhqRmBe8th7IqywP3xE5BhqDnlK7l2d0a09CbyGqScFm3rG2aKXBJNno4v
 SeMkMXBaGB9QbJ14Vsr7a3uLjy8sBZgN7CWs/kDQg++rJ4gbOU4FbbW8F9ZdbJMGnf+gUGtTFv3
 nvKrusjDpl4CaUA2owxNiQO2W3vHTrv8Hhak/Ap0PjQzXfwdjJ5OSOM7OQm5xDew3qmrW3Y6cZX
 9NFh+Kz7FsEChvfdRes7f09GvKf3OMd3RmwDB0FdvRA6GUs9/sPcgS+nk7ySn0mDfwBGNNEyYd/
 Rv7orMAbois3Y
X-Google-Smtp-Source: AGHT+IFVHiXSrqp4GhTL3ZiabrS89zOq2GlVQtBxUmHREG64Z3tmi6HOovI1ywHrd/b9Pi8MGzpLRQ==
X-Received: by 2002:a05:6602:4c0c:b0:85b:505a:7e01 with SMTP id
 ca18e2360f4ac-861c5082d9amr415415939f.5.1744846298115; 
 Wed, 16 Apr 2025 16:31:38 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505dfeb06sm3923588173.95.2025.04.16.16.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 16:31:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 1/2] travis-ci: Add qemu_arm/64_spl board
Date: Wed, 16 Apr 2025 17:31:31 -0600
Message-ID: <20250416233134.2528387-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

These are similar to the existing qemu_arm/64 targets, except that the
'bios' is image.bin (containing both SPL and U-Boot) rather than in
u-boot.bin

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 bin/travis-ci/conf.qemu_arm64_spl_na | 32 ++++++++++++++++++++++++++++
 bin/travis-ci/conf.qemu_arm_spl_na   | 31 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu_arm64_spl_na
 create mode 100644 bin/travis-ci/conf.qemu_arm_spl_na

diff --git a/bin/travis-ci/conf.qemu_arm64_spl_na b/bin/travis-ci/conf.qemu_arm64_spl_na
new file mode 100644
index 0000000..9a0d9b3
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64_spl_na
@@ -0,0 +1,32 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+
+# Uses image.bin which contains SPL and U-Boot
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm_spl_na b/bin/travis-ci/conf.qemu_arm_spl_na
new file mode 100644
index 0000000..1646ea3
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm_spl_na
@@ -0,0 +1,31 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci"
+
+# Uses image.bin which contains SPL and U-Boot
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
-- 
2.43.0

base-commit: b580897053862411a291a477b2a11cf076a6f14c
branch: push3
