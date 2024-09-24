Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FAECF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 08:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDAB882BE;
	Tue, 24 Sep 2024 10:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="ZUmjutJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5A48843A; Tue, 24 Sep 2024 10:49:45 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5267C87E30
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 10:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so9558062a12.1
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727167783; x=1727772583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKHnt7nvb5FQtlJj/WCddjdxFpRGJeGheuWZ8P4qKeQ=;
 b=ZUmjutJ5/+2xMyrzsd+l3SynJt2T5SqKZjQIog+JF8oMcKrb61HNHxqnsbKKTdEXbW
 d+8R964BtOGh/R+tHPvdM9PMMTvSmQ9rydo1XtgwJfCT9UAslqQTuwF+G1WSoYNz+jRB
 RUKdfzFCQSY1QfNxO0oBQZ+4iT9sYaR2QaZOZ1EbUOpmo4AzUvtjaIUtVLDrqt+PezPS
 UrXUDbz8BmjZYs5ojiwXKPzTxtWpPqtCmvwSP3XEM5xmiShzp/dtxy3JxwQ8kUUR+pHy
 0tjboCG9Tr7h782JdogdJl3Xn3hMPb4UKbZ33yxrNKczE9Qcp6mwGWzLEJJVLnrZmhyq
 hqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727167783; x=1727772583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKHnt7nvb5FQtlJj/WCddjdxFpRGJeGheuWZ8P4qKeQ=;
 b=dM+DxUWaK1YVUz0M+1/JHbbE9LkLy5IVTzbFs41T+vGPykJBj8kXrh1cwb1ciVgdbX
 PmEdxLG7tWhbeAP88VdNZ4Z8jyoUnuPzHFLVz1LgaSFxOQ6wDfMHQv7LI0AC8izkRsP8
 eZMP9lA/vdD22V+Pcxy0wrT852DF2DXLUetBUT7+J+Jpv5pAp2P7Bb7EqFn5kxPrNqAb
 /WiCmMh4a0hyr10A8oeEY3DjjZeTki2vt41BIo4YgX0izzUJQMQOaRIhgkpo4yfvMkj2
 GnwnCkEr/aGESVa9r1oz5cvww2ys3+j+q2h59mxV1BXk9r5w9Z8b5C+ykE/kq3yo3dcs
 YtDQ==
X-Gm-Message-State: AOJu0YzFTruCNwRppt4QwexB6UILapze89kxpj1RAWdocQ3+LbGLYl7x
 yb05CR3tRudk4B6RGxz9Ddb+AdcWnNdzdjzDxAw51n9GTdIc3eJVvwqw3AZrjm/1HoBECiKOxfB
 i
X-Google-Smtp-Source: AGHT+IESALhkdGLm+sM/SbICP7nE7drYw+LzFy3WK0qX0tw5WpFymnAZ/L4AxzvxpB25Yb3+4g7FJA==
X-Received: by 2002:a17:906:f5a0:b0:a8d:2b86:d76a with SMTP id
 a640c23a62f3a-a92d55cc92bmr243297266b.32.1727167782662; 
 Tue, 24 Sep 2024 01:49:42 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f33465sm58834266b.27.2024.09.24.01.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 01:49:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [u-boot-test-hooks][PATCH] travis-ci: Add qemu-arm-sbsa-ref
Date: Tue, 24 Sep 2024 10:49:35 +0200
Message-ID: <20240924084935.431168-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
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

Add support for testing sbsa-ref via QEMU. sbsa-ref has two SPI
NOR flash, one for Arm-TF and one for unsecure firmware, providing
ACPI tables to the OS.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 bin/travis-ci/conf.qemu-arm-sbsa_na | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu-arm-sbsa_na

diff --git a/bin/travis-ci/conf.qemu-arm-sbsa_na b/bin/travis-ci/conf.qemu-arm-sbsa_na
new file mode 100644
index 0000000..fea885f
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm-sbsa_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2024 Patrick Rudolph. All rights reserved.
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
+qemu_machine="sbsa-ref"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -smp 4 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/secure-world.rom,format=raw -drive if=pflash,file=${U_BOOT_BUILD_DIR}/unsecure-world.rom,format=raw"
+reset_impl=none
+flash_impl=none
-- 
2.46.0

