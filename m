Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7875DC47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A237F87955;
	Tue,  2 Jan 2024 23:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gLCgSzj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C81E787787; Tue,  2 Jan 2024 23:14:01 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29BEC87987
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-680c7cf2ab3so2645636d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233628; x=1704838428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXPTjh9Y+wQHlfrrteXc3Yv88k+u52uz/xRtSt935eQ=;
 b=gLCgSzj8o+AT0WrgYTNxCJ0roURGyeq56+s6Jj3oprbjjVY7t8KPUSWu4TzzDqOure
 oDdgOhh4LEwrKVO0szKUe9j5gLtDNasHqRhqaeK+Z4HbHmXECQ13fSQgwPA3HR7irufN
 jNsXnw8/Yvu0adfzwY4pWQ+KC16r3MLT4+8ZC/jCTaIqKyahcSpbZguIjHQEyRtz5RwX
 052WbzUcjQUCJ3KmcMDp82lxdnkeaO4IiEjqFVR2LMkawHWrJdVpMQ5AzksW1a7jHnD4
 tKY739WlzulSJzvFPC2X89wqiyF9Y+U4Dh0a8uosltYxb6OmMUZr2r4ghd0LHPJaQLJU
 i59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233628; x=1704838428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXPTjh9Y+wQHlfrrteXc3Yv88k+u52uz/xRtSt935eQ=;
 b=ETyK/POcsmlnbStxGzCEbihjDjL63++MiYRwbsU7k7fiZjaJl+zuJ/ech9eCvKi6dm
 cDll5lGhN/lu+JVXpOT20LPesKgy+b99PlOoJzBw3IJvg+Ll85lyeTtu6awFt90pRelT
 01jEJ84oDC8rPiUTKnDFba17Yk1PjEI8LvF7oulLtOi4/Fs+FvvGvizWr0i08gHwbLmR
 gNiYwOqrPqKth/l75kw82ev8YgIvXzmjO3YzN3LghfqSh9yMZPD8ndBEHY5X8D/yB/SF
 76480sWHatX1Y5BPFx1YsQ2XJaYneBLTzG1U1CzrnHJYbkL6tFVNXWjqw4/UsztnIicr
 8NfA==
X-Gm-Message-State: AOJu0YzyneNiJlIsDHReAM1eS3HGnoWT3fbVPGFxniCtFRSMRG43uDzB
 91ewvYPS9U9I9axhU+u0/xb5yWm6vxEJgJqZYZf9gQGpu4U=
X-Google-Smtp-Source: AGHT+IG8DT89K0SMmUw3oCn2L2nBZ4+DX+A1e+85Q//Anfn0wq3McSlzEp3UnQlbgaSmXOd2/u30Ug==
X-Received: by 2002:a0c:d6c5:0:b0:680:2fa:8e58 with SMTP id
 l5-20020a0cd6c5000000b0068002fa8e58mr14885145qvi.103.1704233628567; 
 Tue, 02 Jan 2024 14:13:48 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:13:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>
Subject: [PATCH v4 6/9] arm: Get bloblist from boot arguments
Date: Tue,  2 Jan 2024 14:12:31 -0800
Message-Id: <20240102221237.1007090-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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

 arch/arm/lib/xferlist.c      | 38 ++++++++++++++++++++++++++++++++++++
 configs/qemu_arm64_defconfig |  3 +++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/arm/lib/xferlist.c

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index b1bcd37466..0023c55d0d 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -85,6 +85,10 @@ obj-y	+= psci-dt.o
 
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
+ifdef CONFIG_BLOBLIST
+obj-$(CONFIG_OF_BOARD)  += xferlist.o
+endif
+
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
 extra-y	+= eabi_compat.o
diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
new file mode 100644
index 0000000000..163d20c11c
--- /dev/null
+++ b/arch/arm/lib/xferlist.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <linux/types.h>
+#include <errno.h>
+#include <bloblist.h>
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
+int xferlist_from_boot_arg(ulong addr, ulong size)
+{
+	int ret = -ENOENT;
+
+	if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
+		return -ENOENT;
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
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index c010c25a92..418f48001c 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -69,3 +69,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
 CONFIG_TPM=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
-- 
2.25.1

