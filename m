Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B252CC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 20:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E737B8083C;
	Mon, 17 Feb 2025 21:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Avn2wYtX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA20480843; Mon, 17 Feb 2025 21:06:44 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A176807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 21:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so90119205ad.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739822801; x=1740427601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=E1q7n0e+ap9FB6v2vmMskCkDIN3sYlz9V2GLyt81DTA=;
 b=Avn2wYtXOTQ3mwnZgiN4h+CA8TN1SvxK3wFjAGs3Et/akTaF3yJZN/KCoi6iuybTsX
 8L4OAD5P+xngmQOduF2I/tT4x6YVyNNs7kXUk7sSZQGBr/+CJi+2kPFrvoR+KEnIg9hD
 ZtqFOILZAY+A0L2Yb8d+tXo3mW/qo4A3/7Om0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739822801; x=1740427601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E1q7n0e+ap9FB6v2vmMskCkDIN3sYlz9V2GLyt81DTA=;
 b=oYTylJ3acq7Y4g02osDgXV7ZctGQGGoTXsKu37kWXXAktz4jvoSBBtIwjknV830JQy
 fZMLiTe72LAF8KGE8liUz3zoB5jQuerDC0PLDPX/fz5U9FZSxcKzS7rdGhy241Nj5lek
 ma54T9wSE1GVA9hN4TyX7cxZEp1JZYx/y0Brtb361K94OudoQ8dB3DZGUg8OSR1fVM9m
 XtYC+wdQTf2lqJd3jhIRZWR/fGaKE45tgA4GagEdLLvzn/eVAnyT3S8ssZWKZUfEDQPg
 +Tcy1EIrK6oYMSE9eF8IRCz5pCCeuGYAdnuuhSvsSyWZXyBI5+Gh3IQ++P55lOzGkqyY
 vVTw==
X-Gm-Message-State: AOJu0YyYcedgMOC5W/N7w4+Wm0aXjQa2skwIdU6V6gb5YP7X/shtn7FO
 pTvLNNVcmRgZrllN7NpayEQ0LclagU9eWW5qsXEPPJQhQUx4bhHjYKtP2ywwNlX28WwJF6oFvPO
 k
X-Gm-Gg: ASbGncuph5zB6cKCeaPzbNqEkJvROaHffD/k+0EpC5IiwvhB48pIGYFFaZ9CQ9ciluB
 ZxqWRukznpGFflJ6u9+J9oqfS2XVPuPjIt2/9zzL/0cI9En+dwyXTNK8DrzDk81msBl2m6Gf4QK
 N45nnxr9de4Oyi0onR6wyHq5IbpchpjzMb9dlzC92097aRkgAuXAhQ1BvZaEliX0QpNSHVBrt2l
 MOl8iidMw8uqiOxqxDrvEaMSYQM9PYBuoDDVoQcieO1ZC8uZ69glvrE+6hietLxABjyVljS7XYA
 jcJQG6Hhx1HyHq8X
X-Google-Smtp-Source: AGHT+IG/XG1Lp4COrSBRru5Hh8m37SDX5xcFR5pHJVUiiuSN0RL4IlSvMCFfxbQwCtm6VM5FrVQVOw==
X-Received: by 2002:a17:902:d485:b0:220:ff3f:6cbc with SMTP id
 d9443c01a7336-221040ab8e5mr189018835ad.34.1739822801047; 
 Mon, 17 Feb 2025 12:06:41 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ba60c1sm8651949a91.44.2025.02.17.12.06.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 12:06:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH u-boot-test-hooks] py/konsulko-labgrid: Add sample rpi_arm64 /
 rpi_4 boardenv file
Date: Mon, 17 Feb 2025 14:06:38 -0600
Message-ID: <20250217200638.356583-1-trini@konsulko.com>
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

To match up with the sample conf file under bin/konsulko-labgrid, add a
boardenv file for the rpi_4 and rpi_arm64 variants (cannot be shared
with rpi_4_32b as we have aarch64 specific example test files). This
shows how to enable network based tests, including OS boot on the
platform.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 py/konsulko-labgrid/u_boot_boardenv_rpi_4.py  |  1 +
 .../u_boot_boardenv_rpi_arm64.py              | 84 +++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 120000 py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
 create mode 100644 py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py

diff --git a/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py b/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
new file mode 120000
index 000000000000..d6f7a632f391
--- /dev/null
+++ b/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_arm64.py
\ No newline at end of file
diff --git a/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py b/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py
new file mode 100644
index 000000000000..c7985a537348
--- /dev/null
+++ b/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py
@@ -0,0 +1,84 @@
+# Copyright (c) 2025, Konsulko Group. All rights reserved.
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
+
+env__net_uses_usb = True
+
+env__net_dhcp_server = True
+
+# The file 1MiBtest.bin is created with:
+# dd if=/dev/urandom of=1MiBtest.bin bs=1M count=1
+env__net_tftp_readable_file = {
+    "fn": "1MiBtest.bin",
+    "size": 1048576,
+    "crc32": "2fa737e0",
+    "fnu": "ubtest-upload.bin",
+}
+
+# Extracted from a previous U-Boot build.
+env__efi_loader_helloworld_file = {
+    'fn': 'EFI/arm64/helloworld.efi',
+    'size': 4528,
+    'addr': 0x00200000,
+    'crc32': '2b466005',
+}
+
+# Taken from an existing functional binary elsewhere.
+env__efi_loader_grub_file = {
+    'fn': 'EFI/arm64/grubaa64.efi',
+    'size': 724992,
+    'addr': 0x00200000,
+    'crc32': '8db3f0f1',
+}
+
+env__tftp_boot_test_skip = False
+
+# A build of upstream v6.13 arm64 defconfig and image.fit
+env__net_tftp_bootable_file = {
+    'timeout': 50000,
+    'addr': 0x00200000,
+    'fn': 'v6.13/image.fit.arm64',
+    'size': 28574720,
+    'crc32': '8513595c',
+    'pattern': 'Booting Linux on physical CPU',
+}
+
+# Based on the explanation in test/py/tests/test_net_boot.py
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x00200000,
+    'size': 64,
+    'timeout': 50000,
+    'pattern': 'Linux',
+    'valid_label': '1',
+    'invalid_label': '2',
+    'exp_str_invalid': 'Skipping install for failure retrieving',
+    'local_label': '3',
+    'exp_str_local': 'missing environment variable: localcmd',
+    'empty_label': '4',
+    'exp_str_empty': 'No kernel given, skipping boot',
+}
+env__pxe_boot_test_skip = False
+
+env__bootstage_cmd_file = {
+    'addr': 0x2400000,
+    'size': 0x1000,
+    'bootstage_magic_addr': 0xb00757a3,
+}
-- 
2.43.0

