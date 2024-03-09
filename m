Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5120FC54E49
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 21:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA8F87E4D;
	Sat,  9 Mar 2024 22:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1ZpB2tY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B23E87D5F; Sat,  9 Mar 2024 17:56:03 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32ADD87861
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 17:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so19850515ad.1
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 08:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710003354; x=1710608154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFxD3sfXzxh2GdJuXhUo6ZMG0EwUH6nk3bJvXfIeGck=;
 b=k1ZpB2tYPyC/Mip4BrpjqyKJGyw2eKgPbbGmlCfPx16IOzof9JQpACZ6DK2m+d/nJ3
 UxXwK3wFdoiR6qFKm2HUWJOfhcHSRiR5GeSjoEfubFR5oJZi0jiytf1Z8DH+Nk/3yaAu
 b5KGAcYiUfU+voyATY+q48CNyE+PC7NJ+IfxOqcJ4j6KxQhO9UXWkpYGtZ5A4kV0vY2f
 39BlJ9tsnB4iHWn+dvxGJpDT/IQuy4hpYMCF076Qm+Xa5KmsT3s6xI8ijFnRu/B5j5SH
 ZgFnzZy0lmTROYO+hFn+3Z58v5eG9xqzPRp4QCtqazlkwbloFFJcKAe28wvt01dLiDbS
 Cndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710003354; x=1710608154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFxD3sfXzxh2GdJuXhUo6ZMG0EwUH6nk3bJvXfIeGck=;
 b=r8ueCc23O/oW1carPz3kbX2bJ63rSCOvCV6vtNBxzaVR/9n1Ek6ZQq8Jmna8q4vrj9
 9VFOo7OgWfUWkDsZx1hDrwZ6AQLiTHeujqO6TMiFfDnh0ItsGwLdXvb9X4dC/pDKSGql
 yS3DiAhJWGBR16MgNRAb2Nj0iuMxfRvNw4NCA0QLET5M7hBaR/EM5mGODBTK5fm0HLB8
 LGoPAMKIQKgW2zJv3J/l48ozBqDVopYPeu6mx3P474a4pxUTx+G22/WBZmlDTSoeBr54
 JNxBOJ+ZVY34J5/8faRESoDOvxf15nlJVpMShwphtzCpix+8kxH//6zh3bPqdebCu54B
 c06A==
X-Gm-Message-State: AOJu0YxS3XOgHhRHm1K82kXbqC18EgFt1Ns6m67exg6QUY76eepBmSmm
 NNxtXTnYZF0uF2+yQxikS3qhzPRWkpO699dPli5oeqn7mnQ86zJ1mJdts1myQ9uHUg==
X-Google-Smtp-Source: AGHT+IGP+Xjj6lU22xkaA2ebOJHJcu2CmNmsqhBZh/tto2yLTxLYKyRu8PNRvYeuosCnxKb1Plff6A==
X-Received: by 2002:a17:903:1103:b0:1dc:fc84:198 with SMTP id
 n3-20020a170903110300b001dcfc840198mr2233515plh.29.1710003353970; 
 Sat, 09 Mar 2024 08:55:53 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 ju11-20020a170903428b00b001dd5ba34f3esm1529252plb.278.2024.03.09.08.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 08:55:53 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 1/2] riscv: cpu: cv1800b: Add support for cv1800b SoC
Date: Sun, 10 Mar 2024 00:54:56 +0800
Message-ID: <20240309165533.48795-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309165533.48795-1-seashell11234455@gmail.com>
References: <20240309165533.48795-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

Add Sophgo cv1800b SoC to support RISC-V arch.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

Changes in v2:
- Remove duplicate code in function cleanup_before_linux

 arch/riscv/Kconfig              |  1 +
 arch/riscv/cpu/cv1800b/Kconfig  | 12 ++++++++++++
 arch/riscv/cpu/cv1800b/Makefile |  6 ++++++
 arch/riscv/cpu/cv1800b/cpu.c    |  9 +++++++++
 arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++++++++
 board/sophgo/milkv_duo/Kconfig  |  4 ++--
 6 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
 create mode 100644 arch/riscv/cpu/cv1800b/Makefile
 create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
 create mode 100644 arch/riscv/cpu/cv1800b/dram.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ac52c5e6da..2c92b0d9f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -93,6 +93,7 @@ source "board/xilinx/mbv/Kconfig"
 
 # platform-specific options below
 source "arch/riscv/cpu/andesv5/Kconfig"
+source "arch/riscv/cpu/cv1800b/Kconfig"
 source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
diff --git a/arch/riscv/cpu/cv1800b/Kconfig b/arch/riscv/cpu/cv1800b/Kconfig
new file mode 100644
index 0000000000..7225b1210c
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+config SOPHGO_CV1800B
+	bool
+	select ARCH_EARLY_INIT_R
+	select SYS_CACHE_SHIFT_6
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER
+	imply CMD_CPU
diff --git a/arch/riscv/cpu/cv1800b/Makefile b/arch/riscv/cpu/cv1800b/Makefile
new file mode 100644
index 0000000000..da12e0f64e
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/riscv/cpu/cv1800b/cpu.c b/arch/riscv/cpu/cv1800b/cpu.c
new file mode 100644
index 0000000000..233a6a3d64
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/cpu.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int cleanup_before_linux(void)
+{
+	return 0;
+}
diff --git a/arch/riscv/cpu/cv1800b/dram.c b/arch/riscv/cpu/cv1800b/dram.c
new file mode 100644
index 0000000000..91007c0a3d
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/dram.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kconfig
index 2a458f291c..040a7487f1 100644
--- a/board/sophgo/milkv_duo/Kconfig
+++ b/board/sophgo/milkv_duo/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "sophgo"
 
 config SYS_CPU
-	default "generic"
+	default "cv1800b"
 
 config SYS_CONFIG_NAME
 	default "milkv_duo"
@@ -23,6 +23,6 @@ config ENV_SECT_SIZE
 
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
-	select GENERIC_RISCV
+	select SOPHGO_CV1800B
 
 endif
-- 
2.41.0

