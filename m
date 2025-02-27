Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA4EC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA2C810FE;
	Thu, 27 Feb 2025 15:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="E7oLWScn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B656781113; Thu, 27 Feb 2025 15:48:30 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C931E80BA4
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8FD0823058;
 Thu, 27 Feb 2025 15:48:28 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mH3WiVRzWYn; Thu, 27 Feb 2025 15:48:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740667688; bh=EYka4PhaQi1nT2x9oAfYHP1aPW2tiHeHwGrWUOMYXL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E7oLWScnOe5tMD/7r2wFCNCucmIv4slAZ+rnMutR3qhDM5Yo0sT2mDomkWrxwAhF+
 dtpq85oYP0kztkpdXN+tMHa+yuBHUQz2rKyDQGGMkl3yfUjqCwSmPgg34mEKooMYiz
 3V86G8o3OmH/B9DB+S9vBSyXjiQIw8H2CpOHmjQPFumZqfWrr4S4GAvqQh0zSA/02P
 V0dT3g19KCuD6RYUnGg9q99zhSGVjnWRf/kjc9jh5cZ/LR2EonOcYBb9Hs+opRBfFW
 VUkS6iXU976JGpTNP0WjdKwXo65Yjgb7QXnfZ4fCr+6OjKN4hrluqOpUZUl68gtZ5n
 +KJSlecfdHAEQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/5] riscv: lib: Add a default implementation of
 board_fdt_blob_setup
Date: Thu, 27 Feb 2025 14:47:29 +0000
Message-ID: <20250227144734.61458-2-ziyao@disroot.org>
In-Reply-To: <20250227144734.61458-1-ziyao@disroot.org>
References: <20250227144734.61458-1-ziyao@disroot.org>
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

It's common for S-Mode U-Boot to retrieve a FDT blob along with taking
control from SBI firmware. Add a weak version of board_fdt_blob_setup to
make use of it by default and avoid copy-pasting similar functions among
boards.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/lib/Makefile |  1 +
 arch/riscv/lib/board.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/riscv/lib/board.c

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 268116f3757..b33f9c646dd 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_$(XPL_)SMP) += smp.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-y   += fdt_fixup.o
 obj-$(CONFIG_$(SPL)CMD_BDI) += bdinfo.o
+obj-$(CONFIG_OF_BOARD) += board.o
 
 # For building EFI apps
 CFLAGS_NON_EFI := -fstack-protector-strong
diff --git a/arch/riscv/lib/board.c b/arch/riscv/lib/board.c
new file mode 100644
index 00000000000..77bc174b047
--- /dev/null
+++ b/arch/riscv/lib/board.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RISC-V-specific handling of firmware FDT
+ */
+
+#include <asm/global_data.h>
+#include <linux/errno.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+__weak int board_fdt_blob_setup(void **fdtp)
+{
+	if (!gd->arch.firmware_fdt_addr)
+		return -EEXIST;
+
+	*fdtp = (void *)gd->arch.firmware_fdt_addr;
+
+	return 0;
+}
-- 
2.48.1

