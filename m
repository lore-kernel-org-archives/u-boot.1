Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E757C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52BAD87CA7;
	Fri,  2 Feb 2024 13:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFpd7Nao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EAE87447; Fri,  2 Feb 2024 10:38:11 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5D7870E3
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so1716544a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706866687; x=1707471487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxPdCBd/TwVdbGpQnETuCM6FhhSGuchnZuUPq/fSgfY=;
 b=VFpd7NaoZN5qACZvYJRVA19XshFEqKIUSGagqPcLFPRI4LMN90sZ93DGN0cggYTj7H
 QG26Ojx21hQvHJ83d/A0OUNMFhOY/VVrttwQU8a+F8oRDFjHoTYUHbBwXP0QXjWzWorL
 8cAPWFCaySADiinkahjNcQ+SZiLhL2v4ZkMzdHEhQH9MNeRWRDcTbEiLRN32IhuaIlPH
 Fz65xXka1AHsrZcv1Hjv55JMmmr2OhZ8jfbYTwuRknlowEitYV++whMwDHvSvecG5TqJ
 wfuquYE5t5GMPs6HQWpnKPwop5OaoHxg5sTg3kYACb2FUZ+GCmhvFNiGmi0QPiyZchCX
 gnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706866687; x=1707471487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxPdCBd/TwVdbGpQnETuCM6FhhSGuchnZuUPq/fSgfY=;
 b=prLHVoQYlUF6ugECLf/aRu72FMkHkSn2WqUQi/UfXwewIYS2e78HiVkxu3Tw8dPjnH
 /scHd537RzwcN2ivRLbiwJoqwQnpPBBwsbVansKcigWwra9iq0obCRmKOnPyhhM/l7U2
 ZXAPoVRTXWL3yxRRXPgjfqJF4ozXk2HcmMCdVgj522Tjdy194h/1YEhjHzvIbd34YBc1
 ozVOs9stGobNsytiySSsxr9WUwRcYtjtlZmEnbWTKPr3xuIgelmJefW/1soiyCEQfIhS
 z4l6Oc5c9gFCRcxJuOeFl8Kc+wWbWHLn0BvbNo2mfFRLrTKIZai5MvSjX7hC/0D3RCoz
 hQiA==
X-Gm-Message-State: AOJu0YziEtu2DeI2lreG/luGzDWUb8p8JmU6ZjL4z3IYPdKqsbIcGU77
 GuV6EyvhzSjEnnKW5Cs1BeptfmK10BgttpaMcuO/zctLqs55JWCzbJzJaFE/qmhowIOF
X-Google-Smtp-Source: AGHT+IEHi5f+Ovgqkwd/6kEUb10lU4XbwlYGxxjeP9EXh8Ua5lTqeIR5vRmzQ5qlMwcpjyfAHKCjcg==
X-Received: by 2002:a05:6a21:9214:b0:19c:ac7f:c3e4 with SMTP id
 tl20-20020a056a21921400b0019cac7fc3e4mr8062154pzb.42.1706866687266; 
 Fri, 02 Feb 2024 01:38:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVii+mviEcIDi0AauJrO5iAczou4g/UTFApfVne7HEJtEFGG2ZdkWASr0xjlFTfTDFAPBwv+Rg5HN0bzG5ZVDERcABtnBPVq80C6mE+tAKpHbK8M2/wYQ2Ej9S/3K2prCslNtW6iyT5PV9FdxVMpPXSPjkzEI3VXyiy44JAMWUYBUKSJAlT1UuuTytnn7Gh5oPSR46JJjEdrbdCJI/5hhDr7dubH9nj+FcCz7yoVi9MSIuSZQiytVPqNYpEF+9/crCEBivTt2fws0MoLdGHEmabqozDJY1wVF0hD2Ktp17zxLbSClNVUtG8lhhGl9mRmCE3iiF2BHKf2EKYSIEZOC8KtpMb3wk=
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 mf7-20020a17090b184700b0028e2a0d297csm1331612pjb.41.2024.02.02.01.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:38:06 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 1/2] riscv: cpu: cv1800b: Add support for cv1800b SoC
Date: Fri,  2 Feb 2024 17:37:18 +0800
Message-ID: <20240202093748.330658-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202093748.330658-1-seashell11234455@gmail.com>
References: <20240202093748.330658-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

 arch/riscv/Kconfig              |  1 +
 arch/riscv/cpu/cv1800b/Kconfig  | 12 ++++++++++++
 arch/riscv/cpu/cv1800b/Makefile |  6 ++++++
 arch/riscv/cpu/cv1800b/cpu.c    | 22 ++++++++++++++++++++++
 arch/riscv/cpu/cv1800b/dram.c   | 21 +++++++++++++++++++++
 board/sophgo/milkv_duo/Kconfig  |  4 ++--
 6 files changed, 64 insertions(+), 2 deletions(-)
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
index 0000000000..f13c18942f
--- /dev/null
+++ b/arch/riscv/cpu/cv1800b/cpu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <irq_func.h>
+#include <asm/cache.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
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

