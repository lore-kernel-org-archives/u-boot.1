Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0406DCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49DF846C6;
	Tue, 19 May 2026 00:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="MTa6at10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FC0846AE; Tue, 19 May 2026 00:27:59 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA3C8465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so29135555ad.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143275; x=1779748075;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W+PV1alv1/OCRoeRy+eVckicBk2gma9tlvn2PaK9LJY=;
 b=MTa6at10qV6q/IDcsr1hP+hq/Ujz7SQmuUJUcHErftR3nrLxL8NWXUhdY5SlcSIuXL
 CZX5BItLFkN/xhep4qutf3vQsi0OqO0GPYYihxgLTZRKgZ05QBPPVyLxpv6HJozomcer
 r3iA5yBshUJD8bKloTJATsjA8jPnV3wxLvmLGzNOi1srqKdUdrryED1APPYLuBEeCcWL
 lYDjVAFVJ6ykiuPJkI7+gUK+68HGFcRe1YQYWw8RtCF9NAg24lXhMPOA0l0WjUzmaUBt
 2gAwipi5Hw1eEbvPyg0l0UEUsElIves24dyLOVHlNATvqKKK5FocGhUQfRlGa8ppNs6M
 0eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143275; x=1779748075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W+PV1alv1/OCRoeRy+eVckicBk2gma9tlvn2PaK9LJY=;
 b=rBjFzXEdB4Pmo4So46KnQ+Ucrd1IXqKREF4wxxhz8KkaLJqZ4B08EQ6pBKAhghnqTS
 KFqdf6PijOEvqHnliCUaD6TYuCUyYwkGcyNXoDqLbPkz4uK3qcEf/04EicbWsPjtWilK
 EgZCYvdQwP/JWuGcx+/tC7+dnnGad7P4bPo+bIbVAIpL42AMqiJnjK3oGD4wMmMtiypl
 vXTBB8Ejk7nEiGM3lu5ZyqBzObL3uEgfjQ2QzLme75IIKVtBKBt+KewDCD1B8RR8GQqR
 TB9EUktcukcBIx0NwBLnvnWzQTbptKiQRaNVAyAOvuLGpLYNBUH5JOt0yajZdWuxXy9p
 YtGQ==
X-Gm-Message-State: AOJu0YwBy+P0TzDd4aGdgFR2RsG7DlCrLUHujQIlwTsY0/6GDZn7pZ9c
 NuzfXIpdywgLTXcoC1TyvNQNnotAQTzrsVx6s9qfoqQv6lZATTb27n0TGSuEjm3J92k=
X-Gm-Gg: Acq92OG+G5CMrf/fxm0lAiD8+mPe1WcRG70Qdqp+Hi3ZUpMr2/l7omAoDdOSe9zjrcQ
 9ZTK2aI0Qhw8P8qyBzaz+eTD2pH2tZSd1PFW+nwLjX64vW45Jz3YVyVIhnwAY5GQtexDz7wJSNk
 qL/Gc+t1kwsGH+f+MGf60Iy8PaKH2dv1taVXjq3TnqNRg/pPbNgIQOL3f0tHRvCn6rl74PDfY2a
 Pv8bU9Vxei0NUE8iHUYLNsnC4pgOUnK9iCH4/hGlHm85mss8FQcIWgUQn03HkWOzlmry9AmmAli
 PaCpjG3c5NyEzTzbPdj/neKpnvbpfyp7toHMjen5wVVyUgKZ5RQYHh2/Yiv+2oCWCjgWZBD2m7c
 r2gv5CvN9WqKKiMjaq+AWhSEbgUGJcVieqNPUXjMjGwRYfpKu8W8qlnhtSyMgh47JgCCEtGVGXQ
 xo+Cc56Keuqi3TwVerjYmXR1zXIOKfAnZbjFaaOQioaXk=
X-Received: by 2002:a17:902:8601:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2bd7e963b09mr134620365ad.39.1779143275568; 
 Mon, 18 May 2026 15:27:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:27:55 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:19 -0400
Subject: [PATCH v4 01/14] spacemit: k1: support multi-board infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-1-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

---
v4:
- No change.
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
2.43.0

