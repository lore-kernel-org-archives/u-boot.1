Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240CEC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F39087CF6;
	Fri, 19 Jan 2024 16:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P2DH0jkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A08187CF5; Fri, 19 Jan 2024 16:12:37 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB2187CF6
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78104f6f692so68654685a.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677153; x=1706281953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSJBOWNIRqSVYDzIiscSVAhg6hnt/+Kbpc+KtWN0q0k=;
 b=P2DH0jkxHHTizeZXFcULONzjL7hl6Dsj1AO27kjTtUntJ0nBtMng+V+lKc/S6mBdfd
 STzlwEqdJYjMzK3e3Vriq38KKqXEceWT0EIbfYEYC6zleGmmNsmGd2GesAbHy/uTV0kG
 3ZFkTXiuJO+s2mj2u9Lwg8nIOHVQ9nTAaazvcszy452F3KpsT0Re1vO5OzV/UeCcIIbO
 wt92ywARXpd8HynoTXsWicvXqtmjctF+YOwOz48TEJslsCMY7MX8CxslOd1+N6famAdt
 b85C/KmiDKW20mHjoq25WuoNaG/XTTGWZyCjeqHnZdPHfo/rC6qLjFdph1tyhSRgRYJc
 a9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677153; x=1706281953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSJBOWNIRqSVYDzIiscSVAhg6hnt/+Kbpc+KtWN0q0k=;
 b=DGaMnL59gqKSwsEUM7vvbPqA5vrWDolHsc12mhxrFToahEEXJllfv0fpLpq+4KjXDQ
 e78HRce0p0OdvNrEN0FWFp+l+lykfpTOTOCAZrZNz9u4K2Na8XAY/8ZMTlr9jJCqnuUd
 tTztRIGBdIQReo5FOzJCybKSQPefITaWfgVJ37ESed9gT+FDb0ltPRn4dsEAZUbA1rEq
 OvxZEaTmVX27dWLgk1stmq5y9SKvB+LU9IvkNJXBa/Nnkag1dLSG21lzqH9KSOpBHTXa
 kXUkuko251a3AkzO4c5s3+tYvcmQiJEXp6u/9yNrhtXZlmqtpwoE6P5DkeQ4b/6Oc7Kp
 p09g==
X-Gm-Message-State: AOJu0YwZa3T8OQ9V3ARsKhElN/pZxe2M1He3giAzgemVeB9aUdVl2wk9
 y01QVpGq8n7+QA79YyP+yJqXOKG5wi6iv5C7ElacJUJOFwPlkkLcgcHFaZBG74nRrW87+O4Zng/
 m
X-Google-Smtp-Source: AGHT+IHLgFGK94LrVBYQjufATmpaohdCUlPiZMH/6RrXpLp7+ES0Qsq20mVTpTMzYvKaeu4oWSussg==
X-Received: by 2002:a05:620a:1358:b0:783:47ff:34fe with SMTP id
 c24-20020a05620a135800b0078347ff34femr6078qkl.56.1705677153666; 
 Fri, 19 Jan 2024 07:12:33 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:33 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 6/8] arm: Get bloblist from boot arguments
Date: Fri, 19 Jan 2024 07:10:02 -0800
Message-Id: <20240119151007.715348-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

