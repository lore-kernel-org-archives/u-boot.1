Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F70C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B642B82C65;
	Sat, 10 May 2025 15:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EABQ+2P6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F7882C57; Sat, 10 May 2025 15:44:29 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532E082A65
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54d6f93316dso3740320e87.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884666; x=1747489466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S44Fi0nM7BWEfTXV8u2lLj0ZATmP5sMzZBga4rh6gNk=;
 b=EABQ+2P6HcyzVPCwedHvh43AXDUzWVZ28cgyFMp1cWHpr2NKQNmOnkO0T9JB6eiWiJ
 Typd8hQJfw3Xu7DzI0tm/2b8ylR7FywOwsbbkxSPK+d+ytmQxAhTTWSH1O19CNlp8/q3
 eysMK3k6No/0uHhaFbbPRv/baPkIlAGyf9l+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884666; x=1747489466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S44Fi0nM7BWEfTXV8u2lLj0ZATmP5sMzZBga4rh6gNk=;
 b=YDkZ70e1vu/Ygw8CpcfUr2pBe6Zs4Sp693GM/8auaYo/Cpe+Yvi4tAYe/mYla8vngp
 FyJDnc1u05aNjpYZzdPoqpao1KP7jZTHfnK0xm/F1Uo0hyZ4U2rdwt39pszLvFjTX7qs
 bayOQizaLTv5pLshpuV4BwgQ+f3SkCyvvXyFjaggKXkiu7BEfbhenTxT3WD+DvukBAHy
 1KiaWTC2s2KE2mlISF8Fxq35beeDg4jnZGk/uBlrgfhi2NXZ84tTy/wDTmfrb+uzZA6n
 fnCp6S+B7jWsBrWtQj2RAO8728ZF0d8F+KjBk6CTPZN0psKr7w0Btboc9Cpbc7GRIel/
 pSeA==
X-Gm-Message-State: AOJu0YyZVaOdVr2VDqz3K4moQ1AZVQyeMJz/DUaqk2WMQ2m0OiG9Zrjr
 uvmCwGYmjZpTnQ+k1JYXnYMnCfaiLUtcmgnoXYdL/TKndbo3VviCHHlxZgiSJmJjETr6MXUQLHP
 Zt6O1bwLEaw==
X-Gm-Gg: ASbGncuIUp213/jzKXCXtfwmLP3thMaP887FinOlFX86zJ7ixY4bsj4NWWwTRJtuJBw
 fzyFhk7EvCeeBTGyaTtN24iTASYAX5f6xkswtXU55KI7bxXvUVTA07vY3VaULvVyPHFFI2hF8Wb
 5zXbCPjx1H175tgkNgSnKNeT2ODsWZO2gUhVsO0pHUA/BaQNG+lizV20zDXdiO3Y/m6+o3t9EDW
 NRU69zw0I5f6O6oGCIXRpRDCqWn1dxjiionj3NG0MSNGxEhIqQa51IYWHZJL242Q3axP1lUNnot
 pGLuswsN0+tDi1BPKO58fnHj0a2la+5HrT6HRLB5MdJKLZhZvgu9CyVaJn9w1rMpDVBd
X-Google-Smtp-Source: AGHT+IHEI6QIsPs11G0Wjs56WIFUiIZFYjWExC34Dg8STlyCHTz2fxsaNO2Rla5pPJtiQITThZKSXA==
X-Received: by 2002:a17:907:9810:b0:ad2:4144:2329 with SMTP id
 a640c23a62f3a-ad2414424e5mr98361766b.7.1746884655595; 
 Sat, 10 May 2025 06:44:15 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v4 18/22] sandbox: Add a way of checking structs for standard
 passage
Date: Sat, 10 May 2025 15:42:16 +0200
Message-ID: <20250510134253.1581164-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

