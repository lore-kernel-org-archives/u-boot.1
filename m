Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A87DC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C167383AEA;
	Wed, 28 May 2025 14:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Biymj/V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F9D8397A; Wed, 28 May 2025 14:34:03 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B857183ABA
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85b38fb692fso81553639f.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435638; x=1749040438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S44Fi0nM7BWEfTXV8u2lLj0ZATmP5sMzZBga4rh6gNk=;
 b=Biymj/V+PAIkdg6sUmCvzaHVsppRAtljy3w6+6P3jHVBM7A5fMwc86KZpNe+39a0gZ
 mcT3ig8rXl/j2p9esAGST3lUiY5jur762h4qA2ZrTRqFwOEdcOZGEhu7gdGP2Q/+doLa
 CaNEwuhuonHGJPRUy84SZNbhH/Q6grO1FUOl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435638; x=1749040438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S44Fi0nM7BWEfTXV8u2lLj0ZATmP5sMzZBga4rh6gNk=;
 b=gwyydf7Rbol2WTRFOjkGVGdZBgHao+gRsJHEsazFzSw0wLCFdFlIiIrBRExs6Q/nw6
 cejDsDZbiLyjm7BHLERSDExjFi3rCKsxaloFx7wCI01+tRhT3ruCPNwmXvGClbv1BoRU
 EbMmlohe7hVoBX3pQ2M5vT+mm2M3mU7EGNFo9or4XVopVoFqmLfSKQfgKZC8zr2ENcHT
 nYEo9DITXOgWqExguXzTjRZ9JkGG9V5VVuLs0efV1HtWzMealf1AMm1hEBj6pY/l4vu+
 yiPvAEf7FnW2h8NiIJqs0jGT0OyKM65LgptL7SyOihvc23j7svY/MrC3qvhz/nimXnig
 YXaw==
X-Gm-Message-State: AOJu0Yw7hrDUe37FkpuowviS5g9RJDtwIQW6a0nQDnPicx0D9nRXta8Y
 C4PPMZI3ya8BBIgUqwWMoASNL+Tt/pmmvsPPhvG1mIcyD4uqFlt/Cd5o8OlE4z2RZmcX+l5r8Rx
 KAD28NhTf
X-Gm-Gg: ASbGnctSNyx7EuS6QW1Mii3IjhwzLLh4JHt5ePoC50kj2JgH7uzcExISQBOc8+yofGg
 6pbpAYr+t1sSrf2p95iGSrTbdafv/DLsBU/s2c3+KuNPoxmsHeGluNne+gIvQwpsvqLwnfAybvl
 On6Hac+7kpdJRk9k78Fkf2wmN5r8/1twcYoUrjLaRiRC3R0cNIR1hNNOHmM4utkDWk9PFUFKV9V
 TpM/9B83mxpXcS+TI7wQIX08qadrQ/zcGYoQCF3Xy3TVkR5B552pLb0uBO83u85gfX6H4f16PfW
 x6aUy7wGCmB21OPiavbT7Axh1+nTvHfkcpFHuqkA/yIKG/WPL59Jo0LDYCv0kYDdkBUzr8y9n/R
 wjy/gHVXw17qL
X-Google-Smtp-Source: AGHT+IHqqZ8uIaGOWRptjsx+TDZg6+RgXf9XvzRMX6AnjLkPyxFROPtY/rICACuj0BIeZsUb39LvZg==
X-Received: by 2002:a05:6e02:12c6:b0:3dc:5be8:9695 with SMTP id
 e9e14a558f8ab-3dc9b663fccmr154974635ab.3.1748435637854; 
 Wed, 28 May 2025 05:33:57 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v5 21/25] sandbox: Add a way of checking structs for standard
 passage
Date: Wed, 28 May 2025 06:32:23 -0600
Message-ID: <20250528123236.1138632-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Add a file which can be used to check that structs used in standard
passage do compile. No other validation is done at present, but could be
considered later.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/sandbox/Makefile        |  3 ++-
 board/sandbox/stdpass_check.c | 34 ++++++++++++++++++++++++++++++++++
 include/stdpass/README        |  4 ++++
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 board/sandbox/stdpass_check.c
 create mode 100644 include/stdpass/README

diff --git a/board/sandbox/Makefile b/board/sandbox/Makefile
index 411b53c2b8d..d9b56adbbb8 100644
--- a/board/sandbox/Makefile
+++ b/board/sandbox/Makefile
@@ -2,4 +2,5 @@
 #
 # Copyright (c) 2011 The Chromium OS Authors.
 
-obj-y	:= sandbox.o
+obj-y	+= sandbox.o
+obj-y	+= stdpass_check.o
diff --git a/board/sandbox/stdpass_check.c b/board/sandbox/stdpass_check.c
new file mode 100644
index 00000000000..c8ddb635f57
--- /dev/null
+++ b/board/sandbox/stdpass_check.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This file compiles all the struct definitions for standard passage, to ensure
+ * there are no errors
+ *
+ * Copyright 2021 Google LLC
+ */
+
+/* BLOBLISTT_U_BOOT_SPL_HANDOFF */
+#include <handoff.h>
+void check_spl_handoff(void)
+{
+	__maybe_unused struct spl_handoff check;
+};
+
+/*
+ * See also doc/develop/std_passage.rst
+ *
+ * Instructions:
+ *
+ * 1. Add your header file to U-Boot, or to include/stdpass if it is not used in
+ * U-Boot
+ *
+ * 2. Add a function below to include the header and use the struct
+ *
+ * Template follows, see above for example
+ */
+
+/* BLOBLISTT_tag here */
+/* #include <stdpass/yourfile.h> if not used in U-Boot*/
+void check_struct_name(void)
+{
+	/* __maybe_unused struct struct_name check; */
+}
diff --git a/include/stdpass/README b/include/stdpass/README
new file mode 100644
index 00000000000..a972121f40c
--- /dev/null
+++ b/include/stdpass/README
@@ -0,0 +1,4 @@
+This directory contains standard passage structures
+
+See doc/develop/std_passage.rst for instructions
+
-- 
2.43.0

