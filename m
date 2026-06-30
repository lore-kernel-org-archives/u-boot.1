Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ABDC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A6F84AA0;
	Tue, 30 Jun 2026 03:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="lqRcF4Wd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 643AA84119; Tue, 30 Jun 2026 03:19:27 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72B484AA0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-13981833e13so4813488c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782363; x=1783387163;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JjbKlD/3xI24M4CMAA2u926uZRLYsnTjKBoXJlWQJ9o=;
 b=lqRcF4WdLSrHCyhtl9VUIAmk0oWRWC2DVCmaywxMSK+53f9o3josbBtGBhQjJcZkz5
 vs5livHpCYh5KVd3NfKdil5LHaEwJWhuh0aclpuXIwECT4UtZpf2CrbZr05k+xvIfnoF
 Triwsrf3wWB6y7j4DlM1caCzZbuu11D2kBE9BmRpfpl5qXFufNjZ/PXGrRvpNeYvg6sP
 4/FNppJQKbkI4UBgXxKFp4UPcZ1dtnMF6fOMRUUccwk2/YDfhZJfjDtbBCkHlESQbJGC
 UQhOUnwOyYQGZMgTQ7WS5oGd/csPnNU87KgCH3AWL7ZRAElKOtS4lLgnuJBjSfJb1ffX
 YQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782363; x=1783387163;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JjbKlD/3xI24M4CMAA2u926uZRLYsnTjKBoXJlWQJ9o=;
 b=qdHWnoYzzFTDDNW+jKNgHUO6pUiJoQiYghwSKwwZP1O+Wph7RtbvtMC5uAlUA8Odv0
 gQxGLWt5wOlMUyK0V36puwMLe3bXSQoSPso2cZaldp3ZaqTBxOa26toLkIhgeJrety9r
 bYGu89xVJVbjcuoq8gnKF18BtEruwOQcfh9CN8/o/di87+ZkIwFq4qcYTfcwOdYS0xrT
 7TDjrFjEu+mZNxTvzn7zE6DYSiHdxKx3DNNLgj/sb4oqIR+W1KQ2zOzNxQynvUZ5FYvV
 /b7QhbBISp4/CpZXxNDosQ74tZ0TqgzYw6J0WYrK6l9aAAa/qHp5GNxMRwUjGd930tPh
 qzqg==
X-Gm-Message-State: AOJu0YzmXf9G0jhI3ipe9ZWNDs3jkzAXvti5X9ZsDgfarfDJC3ydk3Wm
 Mrb+OCARJ25Ow6kkQN1xUyBw9eNwH2tGkx9jrlFstq6/MQBaWy97C8kmmfbqBP8guos=
X-Gm-Gg: AfdE7ckNu0gLmsC3xrYX3q1unX1L+DcLTL73O35ROL+Y+eVffbjN5GUIUc+zcd07tR4
 7upIFLPH+gSbR2L0xfhEIwEiUtucDQ6143DHR2nE/O2HcfAmToZt29BVIxKXlwv+2sIFVou6qiq
 xhQBHu9Gol4qrllNRzKYmlQA12SLBeqw5jI5YiE9kxw3mhGG7wKQuKwshBAPqFkbunLgi98bYgk
 OsKb4fq/RVKQciPUY5JgrrrYWO74BMlC3KSc3kLs6P9yQtyvZ+nus5gn49cRpq05DhLOZS4nK6g
 lro1JAjfDleWMcoMrn6S9grFqUTIj4nQeBA1cEF+hCxicYi2OH5fOxDU6oFU2Nwym2cukj0wP4E
 w7O770ViGhPoigzwo3nGT2se1ALJeQEPg3D9is8RNYo4A74/CHtbGnO0J/xNx2AREQKwUvGCnjO
 yQNK3nYEIwJ5PKFEO4tXsBTLHCAr+560O28WELLCRniCLGnAiOQuJzoHk9WpAR5Zibe3H10R9jt
 Hofi1mjisIxd7YKCj0L1o094ZaP0qiQYoIRU06/fJQxMX1fFcGhYQ==
X-Received: by 2002:a05:7022:117:b0:13b:20ad:b98c with SMTP id
 a92af1059eb24-13b2a1c0a81mr933578c88.30.1782782363091; 
 Mon, 29 Jun 2026 18:19:23 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:22 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:02 +0800
Subject: [PATCH v5 01/14] spacemit: k1: support multi-board infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-1-83f13347b3ba@riscstar.com>
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

Restructure K1 SoC support to handle multiple boards through a single
configuration:

1. Rename bananapi-f3_defconfig to spacemit_k1_defconfig.
2. Move all K1 board files to board/spacemit/k1/.
3. Replace TARGET_BANANAPI_F3 with TARGET_SPACEMIT_K1 and rename the
   board's <board>.h header to k1.h.

Eliminates the need for board-specific defconfigs while maintaining
hardware compatibility.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Link: https://patch.msgid.link/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 arch/riscv/Kconfig                                       | 8 ++++----
 arch/riscv/cpu/k1/Kconfig                                | 4 ++++
 board/spacemit/{bananapi-f3 => k1}/Kconfig               | 6 +++---
 board/spacemit/{bananapi-f3 => k1}/MAINTAINERS           | 4 ++--
 board/spacemit/{bananapi-f3 => k1}/Makefile              | 0
 board/spacemit/{bananapi-f3 => k1}/board.c               | 0
 configs/{bananapi-f3_defconfig => spacemit_k1_defconfig} | 2 +-
 doc/board/spacemit/bananapi-f3.rst                       | 2 +-
 include/configs/{bananapi-f3.h => k1.h}                  | 0
 9 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6..485067ed266 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,9 +14,6 @@ config TARGET_ANDES_AE350
 config TARGET_ANDES_VOYAGER
 	bool "Support Andes Voyager Board"
 
-config TARGET_BANANAPI_F3
-	bool "Support BananaPi F3 Board"
-
 config TARGET_BEAGLEBOARD_BEAGLEVFIRE
 	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
 
@@ -50,6 +47,9 @@ config TARGET_SIPEED_MAIX
 	bool "Support Sipeed Maix Board"
 	select SYS_CACHE_SHIFT_6
 
+config TARGET_SPACEMIT_K1
+	bool "Support Spacemit K1 SoC"
+
 config TARGET_STARFIVE_VISIONFIVE2
 	bool "Support StarFive VisionFive2 Board"
 	select BOARD_LATE_INIT
@@ -119,7 +119,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
-source "board/spacemit/bananapi-f3/Kconfig"
+source "board/spacemit/k1/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 14201df80f2..3701bf2b5da 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
+if TARGET_SPACEMIT_K1
+
 config SPACEMIT_K1
 	bool
 	select BINMAN
@@ -17,3 +19,5 @@ config SPACEMIT_K1
 	imply SPL_CPU
 	imply SPL_OPENSBI
 	imply SPL_LOAD_FIT
+
+endif
diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/k1/Kconfig
similarity index 79%
rename from board/spacemit/bananapi-f3/Kconfig
rename to board/spacemit/k1/Kconfig
index f89fa9af2c7..1c615f89b64 100644
--- a/board/spacemit/bananapi-f3/Kconfig
+++ b/board/spacemit/k1/Kconfig
@@ -1,7 +1,7 @@
-if TARGET_BANANAPI_F3
+if TARGET_SPACEMIT_K1
 
 config SYS_BOARD
-	default "bananapi-f3"
+	default "k1"
 
 config SYS_VENDOR
 	default "spacemit"
@@ -10,7 +10,7 @@ config SYS_CPU
 	default "k1"
 
 config SYS_CONFIG_NAME
-	default "bananapi-f3"
+	default "k1"
 
 config TEXT_BASE
 	default 0x00200000
diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
similarity index 61%
rename from board/spacemit/bananapi-f3/MAINTAINERS
rename to board/spacemit/k1/MAINTAINERS
index 131bad03181..b256cbe7978 100644
--- a/board/spacemit/bananapi-f3/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@@gmail.com>
 S:	Maintained
-F:	board/spacemit/bananapi-f3/
-F:	configs/bananapi-f3_defconfig
+F:	board/spacemit/k1/
+F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/k1/Makefile
similarity index 100%
rename from board/spacemit/bananapi-f3/Makefile
rename to board/spacemit/k1/Makefile
diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/k1/board.c
similarity index 100%
rename from board/spacemit/bananapi-f3/board.c
rename to board/spacemit/k1/board.c
diff --git a/configs/bananapi-f3_defconfig b/configs/spacemit_k1_defconfig
similarity index 95%
rename from configs/bananapi-f3_defconfig
rename to configs/spacemit_k1_defconfig
index adecbee10f2..fae561bbf8a 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -6,7 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
-CONFIG_TARGET_BANANAPI_F3=y
+CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
index f2220950a3a..1ece2ce9d02 100644
--- a/doc/board/spacemit/bananapi-f3.rst
+++ b/doc/board/spacemit/bananapi-f3.rst
@@ -29,7 +29,7 @@ built for SpacemiT K1 SoC as below:
 .. code-block:: console
 
    cd <U-Boot-dir>
-   make bananapi-f3_defconfig
+   make spacemit_k1_defconfig
    make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
 
 This will generate u-boot.itb
diff --git a/include/configs/bananapi-f3.h b/include/configs/k1.h
similarity index 100%
rename from include/configs/bananapi-f3.h
rename to include/configs/k1.h

-- 
2.51.0

