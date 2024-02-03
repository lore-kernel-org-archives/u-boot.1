Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A2BC4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C713A87B6B;
	Sat,  3 Feb 2024 17:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lTcC6SF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5497987A4B; Sat,  3 Feb 2024 17:38:09 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 162F987BCE
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-68c4673eff5so19487276d6.1
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978285; x=1707583085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSJBOWNIRqSVYDzIiscSVAhg6hnt/+Kbpc+KtWN0q0k=;
 b=lTcC6SF/MT8eOluRkqeTZtzSfd1HdJi1MkXWm8Nlf9sHYfRBhqj6p5DRh9Y4Kg9iSB
 UAld2pIX9orOVcvHJ/RHKNYRAj2UT0YdVf2vwFtNWFKbhOo3+dcsRXH9KWx1FwYe+8Ng
 Ov91Y2b7Kk9rL3jaU1RuXcW4gLGq0asOQFCrBAaH5ZtqZmq5PgzWOWYeqXEgU80MLGmL
 etZtjVw0a1kHRLVmSKOouV+sMUvZgoa7aibvr+hL3PHhREBjdYMGDfskwYJr90vZfO0j
 0Fm+t1ZZP3Y7aCao5r9XlHL0HA7zezPdm6rzTLoKywmXFirAXnm4lVTUkzYt3y2mul+y
 HiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978285; x=1707583085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSJBOWNIRqSVYDzIiscSVAhg6hnt/+Kbpc+KtWN0q0k=;
 b=dzA2heReqxsS4dzjqbNRneBlPOOItkZZKJGmSM5qUvJmOmR8Cc3BLbUjSTR89c6r76
 hH3v7qlwaPMrIyfXrvUBtHtXdfhXuMeC5TVUPtFxLohCpOG6Yj1JeGVK5TEjh7reBy8x
 nJUZK0fJPORovE+Iz7tTVY9j0zphPvetBrLs21/6MOw+JCzj0rvOvyhXtVQ1lz343/Hz
 wl1iEJjNpNv2ncNMtVIx/LWnjMi+fys4LzgpCAnXobiS8qgK3iiguVkuVOQtdCywTcdA
 zQIqUdKsOvA+XFOXfnW7hqUqKabDOcg1fAup9EHmkAf6nhiXzoJmogYHSI9Qto4PUpn1
 CrPg==
X-Gm-Message-State: AOJu0YzzQ+J6FQ7MiCzS5k4ArF41kgZbBoynxK5vlLI/0kqmchuD+Sft
 zmPQKiWbu53BqyEVmSqBPv5aIUsu2kny6jO/KaQD05pXVdPugMHfC4fWWxLMDUOm+V93adYRJW6
 x
X-Google-Smtp-Source: AGHT+IHyQkxS0yD/FOIM+yBVgZghp0tIq3OlIwJ2MNpn7Nnm85MFhm2sCr1qCzTsmTY5A0RX7JGccg==
X-Received: by 2002:a05:6214:410e:b0:68c:8268:b5c4 with SMTP id
 kc14-20020a056214410e00b0068c8268b5c4mr2026907qvb.45.1706978285451; 
 Sat, 03 Feb 2024 08:38:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXcmjHf1C+jZfD4D44RbVpBpGk7vWFJZqSz4ntFmX4GWI+OPSRg8kOl+Yz9hafDOV0JSr5kiLpaK+yZSo0f0k1r43J+rtPhPpupJAn27keFwI+TTi+h+ia8GrECTJHu4OjxUyD/BXlRSGdmb4OMUJYjhLxb3bFvns+bu4y3B8yqaRLBf8bgNqQKdxnPWsSS2ySe8xPcE/cH2Q/kKvuLNepWD6nOeO6OIKVptu4P/41DL9Rd97OZ3wHTqSaGFjGGExditsExuZX3ujeczrpRYFjB6ApS6+kAbiy6etBv1ewzOD4OUi6st9U7bQRXkSwkKgwg7Zl0qZ5Es33jtUti3lZeAkseaNDozLqNR32eTic+dYDR0L8H42+tMcTzZcF10Ew=
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:38:05 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v8 6/8] arm: Get bloblist from boot arguments
Date: Sat,  3 Feb 2024 08:36:25 -0800
Message-Id: <20240203163631.177508-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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

Add arch custom function to get bloblist from boot arguments.
Check whether boot arguments aligns with the register conventions
defined in FW Handoff spec v0.9.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Remove low level code for copying boot arguments.
- Refactor board_fdt_blob_setup() and remove direct access of gd->bloblist.
Changes in v3
- Optimize board_bloblist_from_boot_arg().
Changes in v4
- Move the function as an Arm-arch library instead of a board-specific one.
Changes in V5
- Drop the dependence on OF_BOARD.
- Move external declaration to header file.
- Adjust the position of BLOBLIST in defconfig file.
Changes in V6
- Drop imply OF_HAS_PRIOR_STAGE from qemu-arm.
Changes in V7
- Revert changes in V6.
- Remove BLOBLIST_ settings from qemu_arm64_defconfig.

 arch/arm/lib/Makefile   |  2 ++
 arch/arm/lib/xferlist.c | 25 +++++++++++++++++++++++++
 arch/arm/lib/xferlist.h | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/arm/lib/xferlist.c
 create mode 100644 arch/arm/lib/xferlist.h

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index b1bcd37466..67275fba61 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -85,6 +85,8 @@ obj-y	+= psci-dt.o
 
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
+obj-$(CONFIG_BLOBLIST)  += xferlist.o
+
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
 extra-y	+= eabi_compat.o
diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
new file mode 100644
index 0000000000..f9c5d88bd4
--- /dev/null
+++ b/arch/arm/lib/xferlist.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <linux/types.h>
+#include <errno.h>
+#include <bloblist.h>
+#include "xferlist.h"
+
+int xferlist_from_boot_arg(ulong addr, ulong size)
+{
+	int ret;
+
+	ret = bloblist_check(saved_args[3], size);
+	if (ret)
+		return ret;
+
+	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
+				      saved_args[1]);
+	if (ret)
+		return ret;
+
+	return bloblist_reloc((void *)addr, size);
+}
diff --git a/arch/arm/lib/xferlist.h b/arch/arm/lib/xferlist.h
new file mode 100644
index 0000000000..60d79c1a8e
--- /dev/null
+++ b/arch/arm/lib/xferlist.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
+/*
+ * Copyright (C) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#ifndef _XFERLIST_H_
+#define _XFERLIST_H_
+
+/*
+ * Boot parameters saved from start.S
+ * saved_args[0]: FDT base address
+ * saved_args[1]: Bloblist signature
+ * saved_args[2]: must be 0
+ * saved_args[3]: Bloblist base address
+ */
+extern unsigned long saved_args[];
+
+#endif /* _XFERLIST_H_ */
-- 
2.25.1

