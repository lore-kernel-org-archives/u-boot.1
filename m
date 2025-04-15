Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1330AC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9AE81F7E;
	Tue, 15 Apr 2025 23:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UYmXHLja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6559382A27; Tue, 15 Apr 2025 23:50:40 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9B081F6B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3feaedb39e9so1780351b6e.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744753836; x=1745358636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WU3YbvHvf+y56SNxSE04WvFfbetAsntn/y8Tu0zpxDU=;
 b=UYmXHLjajpNVgBzMQntXWYF1TPzOLBDvwL2eM6mXnxlPFVvELSxHooJeDpcqGqfXUx
 ChF5IBRTGJyNvGYWd/Paad7AHQYp77p9iA8jiWQEGgk9rFbtpWjNonK9cMSkQoppKWpK
 AjsI3F1mPvfXlqmYq6eZ4el1j1hGSDkBUIs3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744753836; x=1745358636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WU3YbvHvf+y56SNxSE04WvFfbetAsntn/y8Tu0zpxDU=;
 b=L4jPfc4LlsfWr/nMXPihLqgJFw8XcAeJ/CHYLM7sCsXx6dOzVpX34CF+5bF7nWFPBm
 fqJInMHvHJPk0OuFIskI10ils3UEc+2SfowNkQuyyH5Dymmi4t+DS2hLXwtMquaERQH6
 ZMt4CyZkXT7vl1ZWFQObvBC8NOdi0LuSGFVXMlHoyP2tDGSYs7vkgMtkZrjZzdKfTFpS
 eQb5YX1190/4E+U6crhFb/jA+wxw1sCjS1G71p8/l8bm5TpafISu/wBLpX+2JhGAq84Z
 klJeIVt9irw2NoT4pAA86SvK46hI57e2MQa89xVzK73TAojpWsEUyesqMqYaPsAC1LDo
 wrTw==
X-Gm-Message-State: AOJu0YyX2l7dE2U5hk7scATCOhpDbZHowvHcsbtHtvqLCMz41fYEMAfm
 b1toPwCoRbThXLUFfjdg6gkLW0pbqfYD4KEgb1fcpHpxDr0N8XW6+A1+kbC+PYPb44EEFJoSD0G
 6
X-Gm-Gg: ASbGncvmAJny1cxg48qEiSkVtbZ8jf1ENMHf6IS2jCHxejk69Vn4Kio5eIoNelod+Bx
 G4C5XpfPD6tWLSZFXI4yAykvwQVaPgSVc7TImEmwTmkKqY2jjBmfIpRzoi5Piv3EkKsXNLbwteq
 Bqko6liFa3QHJjugYJRQh19rnSg43mYLDa/dUGuvWVcGJ+6erYkYTWrlN04IF7baOpi05nZmiMd
 QqkiQU5xatqoueipxeHW90geIjqSp9limdPYEKfnDE5FOjuP7b2NZSHmUX7MNhqdg8gu1nl37Nt
 k1omVzAdkMx4k9ottxz0FDIlSn51+1ZyeKQAfZxpNZf1XQ3BvwNNPWxXvdjKvk7xlv/6nifpUEH
 W83pF
X-Google-Smtp-Source: AGHT+IGQCJDmy0I3jga33y4b4R89PcbkIG0OjpHkhISR27UZwtN9/Z/ouRfR8xSHMNwHwonpJxlccg==
X-Received: by 2002:a05:6808:21a1:b0:3f8:498c:9ef7 with SMTP id
 5614622812f47-400acb5d1bcmr724566b6e.24.1744753836646; 
 Tue, 15 Apr 2025 14:50:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-604a5c4bdb4sm79504eaf.27.2025.04.15.14.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:50:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Harrison Mutai <harrison.mutai@arm.com>,
 Manish Pandey <Manish.Pandey2@arm.com>, nd <nd@arm.com>
Subject: [u-boot-test-hooks][PATCH] Add support for FVP emulator and fiptool
Date: Tue, 15 Apr 2025 15:50:34 -0600
Message-ID: <20250415215034.1679664-1-trini@konsulko.com>
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

This adds support for the vexpress_fvp platforms. In order to do that we
need to add support for calling fiptool to update an existing "fip" file
with our U-Boot build. We also need to support launching the FVP
emulator itself. This is a little tricky in that we need to use "telnet"
to reach the created serial ports and cannot just use an existing
file descriptor for our needs. Finally, we add in conf files for
vexpress_fvp to make use of this, and a symlink for the
vexpress_fvp_bloblist platform.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Harrison Mutai <harrison.mutai@arm.com>
Cc: Manish Pandey <Manish.Pandey2@arm.com>
Cc: nd <nd@arm.com>
---
 bin/console.fvp                             | 28 ++++++++++++++++++++
 bin/flash.fiptool                           | 22 ++++++++++++++++
 bin/travis-ci/conf.vexpress_fvp_bloblist_na |  1 +
 bin/travis-ci/conf.vexpress_fvp_na          | 29 +++++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 bin/console.fvp
 create mode 100644 bin/flash.fiptool
 create mode 120000 bin/travis-ci/conf.vexpress_fvp_bloblist_na
 create mode 100644 bin/travis-ci/conf.vexpress_fvp_na

diff --git a/bin/console.fvp b/bin/console.fvp
new file mode 100644
index 000000000000..eacae7d107d3
--- /dev/null
+++ b/bin/console.fvp
@@ -0,0 +1,28 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
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
+# We must be passed the arguments to pass to FVP
+ARGS="${fvp_args}"
+
+"${fvp_binary}" ${ARGS} &
+
+# We need to wait for FVP to have spawned itself before launching telnet
+sleep 1
+exec telnet localhost 5000
diff --git a/bin/flash.fiptool b/bin/flash.fiptool
new file mode 100644
index 000000000000..23014f2bbe82
--- /dev/null
+++ b/bin/flash.fiptool
@@ -0,0 +1,22 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
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
+# Call fiptool to update an existing fip.bin file
+fiptool update --nt-fw="${U_BOOT_BUILD_DIR}/u-boot.bin" ${fip}
diff --git a/bin/travis-ci/conf.vexpress_fvp_bloblist_na b/bin/travis-ci/conf.vexpress_fvp_bloblist_na
new file mode 120000
index 000000000000..ef6f0a4ee827
--- /dev/null
+++ b/bin/travis-ci/conf.vexpress_fvp_bloblist_na
@@ -0,0 +1 @@
+conf.vexpress_fvp_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.vexpress_fvp_na b/bin/travis-ci/conf.vexpress_fvp_na
new file mode 100644
index 000000000000..0f99cc9aead9
--- /dev/null
+++ b/bin/travis-ci/conf.vexpress_fvp_na
@@ -0,0 +1,29 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
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
+if [ -z "${fip}" -o -z "${bl1}" ]; then
+	echo "The environment must point 'fip' and 'bl1' at existing fip and bl1 files"
+	exit 1
+fi
+console_impl=fvp
+fvp_binary="FVP_Base_RevC-2xAEMvA"
+fvp_args="-C bp.flashloader0.fname=${fip} -C bp.secureflashloader.fname=${bl1} -C bp.vis.disable_visualisation=1"
+reset_impl=none
+flash_impl=fiptool
-- 
2.43.0

