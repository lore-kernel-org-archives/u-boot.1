Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FD5C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED928315B;
	Thu, 17 Apr 2025 20:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ECrtj+Uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B14983125; Thu, 17 Apr 2025 20:17:20 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423DE83158
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d46fddf357so3803515ab.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913836; x=1745518636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S44Fi0nM7BWEfTXV8u2lLj0ZATmP5sMzZBga4rh6gNk=;
 b=ECrtj+UqiggNl7dSmSTUt0+jxwLWlNVn3h6l2vuTHL5/BZz7iM23qh3y0aR+PeiYdQ
 R3sLmAU8FI+dvSYKWZ8hql1IXRkniJaWWcnoSyGx82KK/djJQQIkOjgj43wKZ12+wlsg
 xlmN7AfmueMFqRiwfeLCk0NtjCM4RVHlpMx1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913836; x=1745518636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S44Fi0nM7BWEfTXV8u2lLj0ZATmP5sMzZBga4rh6gNk=;
 b=pixdzsqAeOxd7plm1yOYNHzha998ehx3JKe6ivm10vklKKpWr8eMRabvaZwJ/nWKZ/
 5emERoMrKSl5n1yHMaLmma+3wmkPWg7Nc6y13dh8QI9SI6tqCNaq5tVq+kBKKF5rcsHE
 WK9LgR4h1eeEB0YYfzqWrgeYyYRBjJFRChBt7KNtQgQl+c4Xz1XdmF+CHLPS3KXKslki
 5hoRB1Xgw9pmJ6j1APGGlh+VauSS0yxf9lVqFcCvXXEI5AhZYIC0JSqA8dsmm41IGIa6
 5hupEREVXIRf9YNNig354VXafwIk2P0Zd/heU/kcoHl5Oryrv/xkpyZffKfbvUjSr1RO
 +3LQ==
X-Gm-Message-State: AOJu0Yw2tlK5VorK8ugj/3uoPYzulwQMVOOxAL0zZ7HAN5wkIiRps60b
 r5iC0QeGWL8954EAxu8BcXjrrooV4r77Ky3uFDnDJOYPyefhsOU0yz/b8DbN9ug/E/G26aqV8MY
 =
X-Gm-Gg: ASbGncuZEUxh0x8kuduDjG8eu55chZmHkg8/KGdaayRZ75m7mhkr3LjS5aygNlo51Tl
 SgAi0JUorWqyJM2cTJme9Yc0mRB033F3Zk191iR/XWBEIj7e4SeZ57W37BZnLLPkxouvCtZOWRd
 NDjrbIl1h0BE6sxNkSfekOqZ+TTeM3eS45GooYCMGzhggNiMjbLgQjTik/6I7WPVeZ2TdWb0q++
 t7/Qmk2ylSqolYeBAew9VgOdXCKl6erDGNq7nh/Z1fnitujHsWteNnNa3nwyIWPM4EzPkh957am
 mb07n0s71Bu3C189oreuwH6yvrBtDLOZBS+h/HuH4srFDGFgctfgLeXD8VfLrkIJqkg4fXpKNZ0
 vOA==
X-Google-Smtp-Source: AGHT+IHothKVWz5a4RhmTxWlt9dd0c1MZK5KGGopQ4erGCl82y67FsQQNuQZ/zc/PTCZSuSlUiYcZA==
X-Received: by 2002:a05:6e02:12ce:b0:3d3:dfb6:2203 with SMTP id
 e9e14a558f8ab-3d88ee50613mr916655ab.19.1744913836316; 
 Thu, 17 Apr 2025 11:17:16 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v3 18/22] sandbox: Add a way of checking structs for standard
 passage
Date: Thu, 17 Apr 2025 12:16:00 -0600
Message-ID: <20250417181613.1355024-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

