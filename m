Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E1FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D06084857;
	Tue, 30 Jun 2026 03:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GRuzK6b5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD807843B6; Tue, 30 Jun 2026 03:19:32 +0200 (CEST)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A6384119
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so7286061c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782369; x=1783387169;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ALWlk0ctegIEi9W25MgCEqaCpDYTLm9GmOwdV+XfHg0=;
 b=GRuzK6b55jAubres2O8OVrwUp7GkCt6IHHs3aZ5NXfD2pVoQAqlnKok0pyB+n21YMp
 41ANJPrKbz68AX5DAGBEqF2pjOMq6bRaxOX9/tK1f6hjWtjRy4BVOGKq08ALms7dsKsO
 cLsVGy7LGm8jT2IgFTpB/iQmw1QvrYEO5pG4f4o3N37xDXMyj4u9e6hHlbfrSY3EoZGD
 HGKwykZkjdnF+EMjmr/WoNhNKzd0PBfO8nzBK4FczScHaMUxXwMsfuJTKM2SWhEV+kOs
 TzuZB5pjmuS5BC04X1rKWkrcI4OrlpG44pv6QQePzLf2YUAYYfNSvQi8La5uvWBYXscw
 NHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782369; x=1783387169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ALWlk0ctegIEi9W25MgCEqaCpDYTLm9GmOwdV+XfHg0=;
 b=Bk2U0TSKoNTpEuqNzm72qupB9yWGMT/gmCLKvYWiQcIPws9rZmpwkbwC/m/niZpEUK
 iVEyqL9H5+mlqbesvqudmk1Vr49qjh1OJNcC+rBljR7CReKARF0YA1mAWdxnkBA3tY7J
 wZaNfNdBB65JqFTifKeWG7TYwZg32hWUoD2IhPYkGO+hAQmqrh+k4iG0BOxgGtCrUein
 8VyZvYF4IgxHCgLZokexK5+ZyCBLu+emaDGIluNnBNTQKmwxFyAGbdkhsTnyZyuLClrW
 jELH70eNRJbMgZjYUVA6tre8oJwwYD4rStn8UdXrHd5keVaEnNaM7glkj+0FK7UMiAbr
 EjHA==
X-Gm-Message-State: AOJu0YyVk9Qg3/rqdrgd86NAGeGho/Et7IFl6K012mvpzRzoHiwX97fQ
 Q8fKh4rsjvEvpKm+9SlySv52QGHK+WYJVZPGfHjqB8zREQ63o7rcz4T6jl5KlbfSFG8=
X-Gm-Gg: AfdE7ckTF1cidZEEG090qRCU8ajPSCxWOem6Y1mDpDOBFs1PQJ3bC3+oeY/s4dWPKJu
 qf/jUkMx6SGgtFfSJTtoiaFgTMf53djHq7cSHXf9ilq8dWfwQlqBSssAqZA/QxLm/4FdTe3upqj
 JBoYZVaLUbNoLIc7ZFS9GGpuLU2P1UnVBgHihY4GUs/ppQO1Bxdeh/MKleruoOfXBX1I1Xcd8Ze
 IwmryT+qPA7lHr/cUhIFjfiq9ilW44WoU/IxE9uZA78VJGMXK8mfuXHiYMqs5tIiAQjnqd+bDAy
 4C9WFe1W0KgD4D6my4iLklsKYMczI99JdPTx3F3WzkHNFVeILUEif0YkJ/HJBh/DzR6Xv9DlIua
 rKUyEotMcE4cku4xk82rnMd5tpgLi+kSUmJz9S5Cn8oOxFCFuQt6ZiPzDngqFKKcj2Tu3d8yZdu
 h1z0JccNoDpAiRa0Sosr8M1aPMJ14OXPx5Sx2KGzIygX/+yBt+Ci0r9j6Nk4dHojgZQWmr8jw6J
 HKBM1EPxM0ufe5rhOzN4UNY+5YnwDFHLGOO5EIkim1lORFyAJHDZQ==
X-Received: by 2002:a05:7022:327:b0:138:33cc:d87f with SMTP id
 a92af1059eb24-13b2a147a6dmr1062351c88.5.1782782368428; 
 Mon, 29 Jun 2026 18:19:28 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:27 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:03 +0800
Subject: [PATCH v5 02/14] spacemit: k1: enable SPL with debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-2-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add SPL support featuring debug UART output for early boot
diagnostics on K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 arch/riscv/cpu/k1/Kconfig                 |  2 ++
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  4 ++++
 board/spacemit/k1/Makefile                |  2 ++
 board/spacemit/k1/spl.c                   | 24 ++++++++++++++++++++++++
 configs/spacemit_k1_defconfig             | 16 ++++++++++++++++
 include/configs/k1.h                      |  6 ++++--
 6 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 3701bf2b5da..b155535658d 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (C) 2025-2026, RISCstar Ltd.
 
 if TARGET_SPACEMIT_K1
 
@@ -9,6 +10,7 @@ config SPACEMIT_K1
 	select BINMAN
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
+	select SUPPORT_SPL
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 5c8789efddb..ef63b43f69f 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -11,3 +11,7 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
 	};
 };
+
+&uart0 {
+	bootph-pre-ram;
+};
diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
index 2168698402b..f9cbf4b0e06 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (c) 2025-2026, RISCstar Ltd.
 
 obj-y := board.o
+obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
new file mode 100644
index 00000000000..e15cf5f1abf
--- /dev/null
+++ b/board/spacemit/k1/spl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025-2026, RISCstar Ltd.
+ */
+
+#include <spl.h>
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	ret = spl_early_init();
+	if (ret)
+		panic("spl_early_init() failed:%d\n", ret);
+
+	riscv_cpu_setup();
+
+	preloader_console_init();
+}
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_NONE;
+}
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index fae561bbf8a..29050ece278 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -4,17 +4,30 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
+CONFIG_SPL_STACK=0xc083fb00
+CONFIG_SPL_TEXT_BASE=0xc0801000
+CONFIG_SPL_BSS_START_ADDR=0xc083fc00
+CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
+CONFIG_SPL_SIZE_LIMIT=0x31000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xd4017000
+CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x33000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_HUSH_PARSER=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
@@ -22,5 +35,8 @@ CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_DEBUG_UART_NS16550=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 97cf4d72df0..15a40f2128f 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -1,13 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ * Copyright (C) 2025-2026, RISCstar Ltd.
  *
  */
 
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#define CFG_SYS_SDRAM_BASE         0x0
-#define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
+#define CFG_SYS_NS16550_CLK	    14700000
+#define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
+#define CFG_SYS_SDRAM_BASE	    0x0
 
 #endif /* __CONFIG_H */

-- 
2.51.0

