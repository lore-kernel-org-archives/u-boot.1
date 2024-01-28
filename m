Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46258C47DA9
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 14:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0312687E48;
	Sun, 28 Jan 2024 15:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FIBA/HCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1997388092; Sun, 28 Jan 2024 08:06:44 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3E188084
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 08:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d73066880eso15284365ad.3
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 23:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706425599; x=1707030399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaoLOUh0hKHmpS85EdmzZjXBoHLe33m/pKIVxR2KLuU=;
 b=FIBA/HCjixxrpemq1efYP6Ol0wdf26utvTrEWKreso2gS83jljaJNvuVYGj+QEn4EG
 lTsq34nEdT/MXrz4UGk9HEN2ZaV2a8P2ZjCds9Gk0mgwdyHotU8Uen346dGP3EPHZS84
 azZfAy/kmy3EVgWXhG1I/Rl4mO7UarDCnmQUPbtYfEM4B+i23cRmw4H7TTCPIxS3wupR
 RN5PLxRflgjm14YOz+IMm5xoFHf19CRIjmRTb0JDTkkH5JYS5gP67dxqoYzi+wBo1nkE
 TxSLsE7tV1e4FKZvu/qlYw8f+81TjZww2CUoS/73DFd5QygY9a7QiwtovLAcZKcvw7UR
 LURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706425599; x=1707030399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HaoLOUh0hKHmpS85EdmzZjXBoHLe33m/pKIVxR2KLuU=;
 b=JmDwZXHjQGF9dcuMbYcT4iRly3NrXlNTAOJw0UdmXN3OCtemBNQ2sSx13e/4yrV154
 ZeoLc4+ZSLuA7uXM2MF3Zlxfx7v0WlGGru92GD/aBS1hpI6SJhO+I56V3VXFkXd1/cCV
 eJbmwCBfnJiSnEBACKGiVd5SnwjQavA9j+MaQkXoIG0UM3RZkC1kJXeg4Kt4gBgR8j0b
 kCgZ66M6rzMLiDgpRxvyddm/4t59SlB/zhCaR9uZesmCEKOlJQm1cvzXxV11RKgNMQmW
 IPVEuRmLePTqacUUMssOyi8un7BJ6KdJvqdnmGgfZSf6o+Z7ThJhD/sRD7uoEMq1C4c5
 TRiA==
X-Gm-Message-State: AOJu0YwbDD2NApo7JjcftWtgA/P76Yqtg1KZg6zYf21wakXl0kI2rJ8O
 VsolleyzZEL5xn8h5CZ+s0f0ip579YopX5YtYS12nTQoqpA+Iyb8D6Y7q3sZfznQVslz
X-Google-Smtp-Source: AGHT+IE+yfaCHQS8MUDBXWlTx1Bm7GBEJ2m/HuGqUWW+8rVKd7HXthdNzfS3+zuc563CS5fVVe+QJQ==
X-Received: by 2002:a17:902:cecb:b0:1d5:636:2f9f with SMTP id
 d11-20020a170902cecb00b001d506362f9fmr3436722plg.25.1706425599219; 
 Sat, 27 Jan 2024 23:06:39 -0800 (PST)
Received: from localhost.localdomain ([115.216.236.184])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001d88b4b87f9sm3287297plb.192.2024.01.27.23.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 23:06:38 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>,
 Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v4 2/3] riscv: sophgo: milkv_duo: initial support added
Date: Sun, 28 Jan 2024 15:05:25 +0800
Message-ID: <20240128070614.7702-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240128070614.7702-1-seashell11234455@gmail.com>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 15:10:42 +0100
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

Add support for Sophgo's Milk-V Duo board, only minimal device tree and
serial console are enabled, and it can boot via vendor first stage
bootloader.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

(no changes since v3)

Changes in v3:
- Enable EFI loader

Changes in v2:
- Fold the defconfig patch to first patch
- Remove unnecessary environment settings of consoledev and baudrate in
  config

 arch/riscv/Kconfig                 |  4 ++++
 board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
 board/sophgo/milkv_duo/Makefile    |  5 +++++
 board/sophgo/milkv_duo/board.c     |  9 +++++++++
 configs/milkv_duo_defconfig        | 23 +++++++++++++++++++++++
 include/configs/milkv_duo.h        | 12 ++++++++++++
 7 files changed, 87 insertions(+)
 create mode 100644 board/sophgo/milkv_duo/Kconfig
 create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo/Makefile
 create mode 100644 board/sophgo/milkv_duo/board.c
 create mode 100644 configs/milkv_duo_defconfig
 create mode 100644 include/configs/milkv_duo.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 67126d96af..ac52c5e6da 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
 
+config TARGET_MILKV_DUO
+	bool "Support Milk-v Duo Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -83,6 +86,7 @@ source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
+source "board/sophgo/milkv_duo/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kconfig
new file mode 100644
index 0000000000..2a458f291c
--- /dev/null
+++ b/board/sophgo/milkv_duo/Kconfig
@@ -0,0 +1,28 @@
+if TARGET_MILKV_DUO
+
+config SYS_BOARD
+	default "milkv_duo"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "generic"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo"
+
+config TEXT_BASE
+	default 0x80200000
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select GENERIC_RISCV
+
+endif
diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo/MAINTAINERS
new file mode 100644
index 0000000000..651a0592f7
--- /dev/null
+++ b/board/sophgo/milkv_duo/MAINTAINERS
@@ -0,0 +1,6 @@
+Milk-V Duo
+M:	Kongyang Liu <seashell11234455@gmail.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo/
+F:	configs/milkv_duo_defconfig
+F:	doc/board/sophgo/milkv_duo.rst
diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/Makefile
new file mode 100644
index 0000000000..a087013f5c
--- /dev/null
+++ b/board/sophgo/milkv_duo/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y := board.o
diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
new file mode 100644
index 0000000000..eaa47be173
--- /dev/null
+++ b/board/sophgo/milkv_duo/board.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
new file mode 100644
index 0000000000..9eca6abfbc
--- /dev/null
+++ b/configs/milkv_duo_defconfig
@@ -0,0 +1,23 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
+CONFIG_IDENT_STRING="milkv_duo"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_TARGET_MILKV_DUO=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="milkv_duo# "
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
new file mode 100644
index 0000000000..0b4109dc1f
--- /dev/null
+++ b/include/configs/milkv_duo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE         0x80000000
+
+#endif /* __CONFIG_H */
-- 
2.41.0

