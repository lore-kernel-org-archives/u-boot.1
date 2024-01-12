Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAED7C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD3B879D2;
	Fri, 12 Jan 2024 22:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eRQmOZVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F12786EA6; Fri, 12 Jan 2024 22:34:49 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA9487A22
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6813c12c1b8so8073666d6.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095285; x=1705700085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuNM/2ABUP/Cc6s5fZFZ3eOaWs8lpxClnlD+WoQXuT4=;
 b=eRQmOZVBpzETao7ufG0SivjgMcjTGgzus0chBtHcYY3oRrIl1h0LgKuM8AhDVh+Ucz
 HghApRKpssvnOn90DQltBUYvhqPsVwo5OCdijMQriMs6FnPEIX+GSc9vZuWzzeq1EIKt
 vVf9OIDbWnP1H/4mBgrEUnfnfLGUpAhujSFlv2KF/HA18K8mM9Pu3kkvWa/sAOkMf0v/
 bYjGpo0PwpuIHtYzRxIjNrKts+K2FqKTtr/c+TGJjoemLvS4drF+B2LdhAMmerF1cvBE
 1dVoYlHPnZ+iHIJ2r6uqZ4jw5tbc7uTnqt9kt17IpL2VBqSA+VMAxkPgXhxbZyGEASeK
 L0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095285; x=1705700085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UuNM/2ABUP/Cc6s5fZFZ3eOaWs8lpxClnlD+WoQXuT4=;
 b=Wex1f/C4WxKkUKLLq1t4ZsCkCkiEbHEaJ/rZTfWr6zo3izOwjMF231+xI8hO6jg1JW
 8iWo6GH/fatDh7KgPHE48FOV1lI5po4Fh+ckheU/11vtCkL4AMZ3JyLheNBuAehkAMIy
 Vu2REOBMiamrYZVCU7iRQ5KXUpg1ulUzn8hdbYbhzjxTUl6zHeUAXto8u9Txmj5papYR
 c+yDUFpwEISWBr/o8C3/Cgr5tWI94Z3ZxLs1Qyk8XrxzEnATlKHbCv4wNRdKp7wcD2h8
 7chfuAPPKosQwutePWwNzJd2nLPJObWSbvo7MjgvxTYKtxYRYJX0e/TjhSyq9zWLkrfY
 EAYA==
X-Gm-Message-State: AOJu0YzNilV/BP5qkNTC8sHz9utvxxA1wZr4r48BhxLCFs0z6fWmc+iu
 maUjkJ73MKyhxlsnxyC4LBqOD8bsAgspT4TUV+un+peoh8A=
X-Google-Smtp-Source: AGHT+IGuBmDwiP2yp+eXlyDUswN0uW3eTTu1h4EVSGsj/2N7A10qTj6HlMeRYv6lRPiFkz4ZWP0uUA==
X-Received: by 2002:a05:6214:f2c:b0:681:2fe1:30c9 with SMTP id
 iw12-20020a0562140f2c00b006812fe130c9mr1830397qvb.75.1705095285341; 
 Fri, 12 Jan 2024 13:34:45 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:44 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 6/8] arm: Get bloblist from boot arguments
Date: Fri, 12 Jan 2024 13:33:32 -0800
Message-Id: <20240112213337.185460-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
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
Add bloblist related options into qemu-arm default config.

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

 arch/arm/lib/Makefile        |  2 ++
 arch/arm/lib/xferlist.c      | 27 +++++++++++++++++++++++++++
 arch/arm/lib/xferlist.h      | 19 +++++++++++++++++++
 configs/qemu_arm64_defconfig |  3 +++
 4 files changed, 51 insertions(+)
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
index 0000000000..e9734959dc
--- /dev/null
+++ b/arch/arm/lib/xferlist.c
@@ -0,0 +1,27 @@
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
+	/* Check the register conventions */
+	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
+				      saved_args[1]);
+	if (!ret)
+		/* Relocate the bloblist to the fixed address */
+		ret = bloblist_reloc((void *)addr, size);
+
+	return ret;
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
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5100e193be..80a5409c51 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -27,6 +27,9 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.25.1

