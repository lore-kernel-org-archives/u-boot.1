Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911A0CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C055683071;
	Tue, 16 Sep 2025 18:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dCDgeKsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460998309A; Tue, 16 Sep 2025 18:12:56 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E026803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-42403ec3e29so28392735ab.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039172; x=1758643972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9dMG7ivC0AsPeSeCe4pOYMNC3MRnZ6XsV4QE15xbE10=;
 b=dCDgeKsRUOGrjtx5OyY0gjypUW3AaXnpldzkuYPYoBBR6U+U03u02I6zOARWIQFFnm
 U7oihT8H4XtU4m8Hz5OxWajkH9he9Fcir5VWdDmlXhLm1GeVWBEhjE2u59mymoZg2EWh
 gqTmkXS6nyDw7NST6iiMf5pcazj749MkWg8lXl7RixSMKBJVIjpx1L2KyzDFfIP/qwVI
 Jnuf5n+NfRKhTMgbN4uWI+AjdRg8l5bI++F5uKCcoSmLzHCJvnHxJQtkyl0FDZ99Fa26
 DobyqJIwKNYul81FuiFCSk1jk18azdcKV29ri4GZaYsnayaUXjnsZksebWqOqtipSeSD
 GALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039172; x=1758643972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9dMG7ivC0AsPeSeCe4pOYMNC3MRnZ6XsV4QE15xbE10=;
 b=qtApE0GHVds+12fjN1ZRZ4fD7jIu6n1zZ8Fn6HAIKC3Pr7nmY1xTj8Px3AoIQiLZ/A
 8sGZEnsVsBa6h9EKBveQk2emowTIw1qXfPVXJDtvXlAA8oOMcW8UqRTN94tpbqkaw1b7
 58glG9MbbG02qo6cG6VM/OfSj+1+DsY+9NNOqRXdVCpUIBVMlSjXdWvN6E7xCPsVXMPy
 IjxqsIb8C2T91eqifZ2qMCFvFYsvLznpZDjS4DRAcuUSg7tz8vwGW5wKJXpfMiM+nXFb
 31v02knscA+3uUBGOvjdSU5sksZ2tAI+pl0S9YKV/fiOKNtEug+i+QsI1SKpwaE9ssBn
 ZBgQ==
X-Gm-Message-State: AOJu0YxIMpUiAxGEsK3gCU44o4tbWLXs7HvSGJHhU+nYR06fGbLiDdHj
 tvzhy3REPNOl/sNxZIORVdvcKeADNVbgV+ZZfeCuQYFuOZUenGvpo5W1jAmT665dcPXKDnNYhLD
 CoHqj
X-Gm-Gg: ASbGncvVtEX50A5eG2mypYnLlAkB8tSmumxszFhsl3ifXfGzbl3/D0520ADOQKGP8aL
 MaErEqQRFSZkTKYwzfYiaCedtkp2gNB+uB6xuT+O+Y5eb6yz8QjZZ3unFTOkCCIyIh9o/zAsw6v
 kICcm3D+CX7xzDABcEJOsUMio+0gSwnxEqzRAsC81nOL2ZB3SLwkzl5QqAPPTmdjZyZwzeYVKpF
 EUDIH1Fw/XKCBrAoIZf6A+jGaA99161siEhujXHU8XfYqxeE4cZEdnuw2o4InawBOxsvzk/mf4h
 PeCghB7lIUwNwrr8bOVDaYMb3NLFfsTaklyzo9t+Z50u23rz4vXboxOFwPHdHyAu5WihVIUKRYN
 /D21a5M2BfZTBGrnoi4bei8dyOi6SEhAdLSrlqjJX7NOQ8rck9kxsTeRnbGhS6KpKaoO0WcwKSc
 IQZvKUrLl4dg==
X-Google-Smtp-Source: AGHT+IF7Jusr6KPZmRc0gxZhJGxDYs7BMx2/0NO3DUkeTvbI77WROM3wdmhWPTEMPmuLyYSGRtna5Q==
X-Received: by 2002:a05:6e02:12c6:b0:3e9:eec4:9b59 with SMTP id
 e9e14a558f8ab-420a5f26edbmr182312275ab.32.1758039171561; 
 Tue, 16 Sep 2025 09:12:51 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-515151af149sm2771334173.81.2025.09.16.09.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:12:50 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH u-boot-test-hooks 1/2] bin: add helper script for testing
 swtmp with TF-A
Date: Tue, 16 Sep 2025 09:12:24 -0700
Message-Id: <20250916161230.32140-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The existing 'qemu.swtpm' does not run swtpm_setup to configure the
algorithm, by default it enables all algorithms it supports, but TF-A
currently only support sha256 and measured with sha256-only, enabling
other algorithms causes more measurements at U-Boot and then leads
to eventlog mismatching.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 bin/qemu.swtpm-tfa | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 bin/qemu.swtpm-tfa

diff --git a/bin/qemu.swtpm-tfa b/bin/qemu.swtpm-tfa
new file mode 100644
index 0000000..cbcddef
--- /dev/null
+++ b/bin/qemu.swtpm-tfa
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: BSD-2
+#
+# Copyright (c) 2025 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
+# Based on qemu.swtpm
+#
+# This script launches swtpm to emulate a TPMv2.
+# It explicitly configures swtpm with sha256-only.
+#
+# The parameter -t makes it unload when the connection to QEMU is
+# terminated.
+#
+# To make use of it add
+#
+#     qemu_helper_script="swtpm-tfa"
+#
+# to the board script and the following arguments to qemu_extra_args
+#
+#     -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock \
+#     -tpmdev emulator,id=tpm0,chardev=chrtpm \
+#     -device tpm-tis-device,tpmdev=tpm0
+#
+# U-Boot must be built with CONFIG_TPM2_MMIO=y.
+
+rm -rf /tmp/tpm
+mkdir -p /tmp/tpm
+swtpm_setup --tpmstate /tmp/tpm --tpm2 --pcr-banks sha256
+swtpm socket -d -t --tpmstate dir=/tmp/tpm --tpm2 \
+--ctrl type=unixio,path=/tmp/tpm/swtpm-sock
-- 
2.25.1

