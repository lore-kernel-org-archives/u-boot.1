Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2604AC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A56E87CAE;
	Tue,  6 Feb 2024 23:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0469987CAE; Tue,  6 Feb 2024 23:32:05 +0100 (CET)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9E787C9E
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2d0a29b05bdso43821fa.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258721; x=1707863521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zZwH6BQM59B0gBxxu+whM69P6e5AhJiPuMx0+4kdAk=;
 b=ZUG8Jlg1fJnC06mGPdOu+9kXnRUnGFB0ELN6+CbXoWTRvaddduruuHcMTiC5HZoYdP
 HEWPj3cx4tbdXZ9iylZbYURcvtXEcVeFM5CwH1f1TNq9jdFlWkgTb+k50uc1IZzaTnfa
 qE6Na8H68Rw5lZCXwNNaZbggyhO6b7tAuMVGEJT1Iqs4ttSUSA3u/uXI854xpIR/eEsL
 1AmNSe3FDmk3sulzrr926/xzh80LtR6m44tCH6KZrNe/F/EaZ1sFWLr1lSyzYYzqS/Yz
 mWWF5TBkG0Lmxo9h08S50/+Xm7whd9kU3JxOIbI4iPmLVhD+wNF//jFL8xuqQ6RK3fgR
 /KNA==
X-Gm-Message-State: AOJu0YwyArG3CGD9N6hc9QMTp41T/SQ8NC/WwDMuhlziMHW5mPpZdvJO
 IBc1Jf8s6XylINt5KLZyV4nv6/mNSe1Ut7BL4SUtMAcxHQgXxIeVhDzszfjw6f7Ilg==
X-Google-Smtp-Source: AGHT+IHHNr5CY4UV6du1eTS+yyh3qwp5j8poFaVNjeVYn/mW70tKXhI3VOS2IGabJODOyS5cDymgQQ==
X-Received: by 2002:ac2:5059:0:b0:511:4a03:9dc2 with SMTP id
 a25-20020ac25059000000b005114a039dc2mr2811667lfm.2.1707258721383; 
 Tue, 06 Feb 2024 14:32:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUfgNa1F1f0s2loWFkFOpB9D4uFo6hH8J0KFTv/T9FCRU06lsWQsuc4zr/FN3r8ploNkz9al0sdQdwMhf0rtGAsRpxx3nEZvFLKCQkrVTF++Lvu6Kkwej1CqUdZ76KwUnPSy0XTdcBNqqxb5kFL+71SZ5H/yqr4Gw8qhQx6TB7gxgV604B9a8eqdRs4+pBNo0HyCWhQlNK+d6xHEOKjPpzEZi5GLvnawb1Y82xLyGSHcanRojUtmX1/yzu6jhgdb/NE3PRW2+oUwYYjbKnGCARWpNDgRBi5Ke7WHQCiqQ==
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 v6-20020a056512048600b0051140df84fdsm358462lfq.12.2024.02.06.14.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:32:00 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/7] avb: move SPDX license itdentifiers to the first line
Date: Tue,  6 Feb 2024 23:31:48 +0100
Message-Id: <20240206223153.3060433-3-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Move SPDX license identifiers to the first line, so it conforms
to license placement rule [1]:

Placement:
The SPDX license identifier in kernel files shall be added at the first
possible line in a file which can contain a comment.  For the majority
of files this is the first line, except for scripts which require the
'#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
identifier goes into the second line.

[1] https://www.kernel.org/doc/Documentation/process/license-rules.rst

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 cmd/avb.c                              | 4 +---
 common/avb_verify.c                    | 3 +--
 include/avb_verify.h                   | 4 +---
 test/py/tests/test_android/test_avb.py | 3 +--
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/cmd/avb.c b/cmd/avb.c
index 783f51b8169..ce8b63873f2 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -1,8 +1,6 @@
-
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2018, Linaro Limited
- *
- * SPDX-License-Identifier:	GPL-2.0+
  */
 
 #include <avb_verify.h>
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 59f2c25e0de..938a5383b5d 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2018, Linaro Limited
- *
- * SPDX-License-Identifier:	GPL-2.0+
  */
 
 #include <avb_verify.h>
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 1e787ba6668..2fb850044d9 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -1,8 +1,6 @@
-
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * (C) Copyright 2018, Linaro Limited
- *
- * SPDX-License-Identifier:	GPL-2.0+
  */
 
 #ifndef	_AVB_VERIFY_H
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 238b48c90fa..865efbca4de 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -1,6 +1,5 @@
-# Copyright (c) 2018, Linaro Limited
-#
 # SPDX-License-Identifier:  GPL-2.0+
+# Copyright (c) 2018, Linaro Limited
 #
 # Android Verified Boot 2.0 Test
 
-- 
2.34.1

