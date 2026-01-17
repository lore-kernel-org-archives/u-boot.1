Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B3C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F03E83B71;
	Sun, 18 Jan 2026 14:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRgJqOZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45620836AC; Sat, 17 Jan 2026 22:00:30 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C007882BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 22:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6610b241d19so1572925eaf.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768683626; x=1769288426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GahH2AF1UcUiDuVvb80nI5y4c/AY4Kbnlt6Rn2t9yIg=;
 b=lRgJqOZWjRR1pvzowjdY7eUWfSRXOc8amCqd+nCXYryro0sLGRP5om2PQtYbdEkM1D
 kX99IGA5FssVr4D7kkD29Rz/7oYbyeSLO7C0JdU113V0UWbdwLAP911/mhBpD+4ckuGA
 WwQpp++Zj2rNlzIVxnjJQbLFEoDT/8C+LxI8dQtql7K/ZNScRy0kqAvLGhkJrhjpXkIq
 /5iGzfEmV3eLCH02PyHmcoFYp7ge3ZwZS3nycUJtcEA5y6cXqwlM7O6ZD1T9TOTjyx18
 rTFwq5avYx00oKK4r7krKvgl4MCBudF9GHXTroXzqO51tivqlXDGsWIfpiAeHFz4yed/
 d/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768683626; x=1769288426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GahH2AF1UcUiDuVvb80nI5y4c/AY4Kbnlt6Rn2t9yIg=;
 b=FYMj9lYajsdhbU8RwiLckdHbpT53ZMxlxo1O3vDPNWlfYGO9QhQU0WntfS64LKe/Vv
 Z2vuaBC9OH6hcvxyh13vNoV4OT/VmAgsrddjFppryXHC2SAXFhfkAmbGA3C8gkJLlsOg
 cMi/itlep/qaglad+2TPaQ6F7lzXid7euA+9pJgHZCAntm0eN9xCeX0m2TE54/jXXUu3
 Eb3qc4/LBEsgJpptZrLuvhl5D4tviJnM+uQ5ekUGN3P/zL+K4zZv1gGeAQXZoXufJYzd
 tX6hkWdeBeZEaamPEy6vWhPO6Nw1oxRKPyqztkx37VHM/1uE3vpcWs/HoBF8etFmUORN
 S6SA==
X-Gm-Message-State: AOJu0YyrqxqRO4fST4cOsogbcdHUBqdY+41BC8lM+tbfXVXkyr7hMD+d
 yHacdyEU3s/zYZF4dTz0Non9ChWJisCtBLmiektQRbe3GGkiFj0klpKuPKupcw==
X-Gm-Gg: AY/fxX6btB1jRBlEML5s4E2mMKyT8OveI8O9OIfKtlGRsym/2tHEas6Htz70WBm8Fm+
 6a2UR4+Ji0bh52bv5FTxKdFkZik/ez2J4yp+Erir6kZ7tnH4NxK5R5d9H6PKaFcbL8mMBxfty4y
 +Mw/rZy9bad7Iszd0TVjGxDMlvM1XTsa80RnG7qiE6jEL6pPIw+ss0Xc8YbeDnijF8hPhWgjIQX
 QA/V7oGpmJu1P0/L+2Df4cjOqUPTtProFeYVG/Egq8uWllAsRrrZHIi2mHA46u2Zvs0ijx6PEOZ
 iEnn9s+PqfnVUgbhIRVom/0XbWe4PmlYkR2E4oZE7FPQiwE+2+/fKZX8xdzvkcXNJMaDeEOb2TU
 3QzM3CyV3UOF5B1Z2MBmPFC84SujezHxAAYXB8tYc5hoQJOWqxYE7/mWbZJpdj+Z1CNR2grg8Wu
 aATqhS3+L2UCzq+9gyt0GB+YFQv+cobIVGEFzP9+y1aSFRd3UyY3DWcmIK0aXRTgkVD8sO8fQ=
X-Received: by 2002:a05:622a:1187:b0:4eb:a8ba:947b with SMTP id
 d75a77b69052e-502a1663e57mr110780231cf.24.1768676597756; 
 Sat, 17 Jan 2026 11:03:17 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:03:17 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 01/17] spacemit: k1: support multi-board infrastructure
Date: Sat, 17 Jan 2026 14:01:35 -0500
Message-Id: <20260117190231.977686-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

1. Rename bananapi-f3_defconfig to k1_defconfig.
2. Move all K1 board files to k1 directory.

Eliminates the need for board-specific defconfigs while maintaining
hardware compatibility.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/Kconfig                              | 10 ++++++----
 arch/riscv/cpu/k1/Kconfig                       |  4 ++++
 board/spacemit/{bananapi-f3 => k1}/Kconfig      | 11 ++++++++---
 board/spacemit/{bananapi-f3 => k1}/MAINTAINERS  |  4 ++--
 board/spacemit/{bananapi-f3 => k1}/Makefile     |  0
 board/spacemit/{bananapi-f3 => k1}/board.c      |  0
 configs/{bananapi-f3_defconfig => k1_defconfig} |  3 ++-
 include/configs/{bananapi-f3.h => k1.h}         |  0
 8 files changed, 22 insertions(+), 10 deletions(-)
 rename board/spacemit/{bananapi-f3 => k1}/Kconfig (63%)
 rename board/spacemit/{bananapi-f3 => k1}/MAINTAINERS (61%)
 rename board/spacemit/{bananapi-f3 => k1}/Makefile (100%)
 rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
 rename configs/{bananapi-f3_defconfig => k1_defconfig} (97%)
 rename include/configs/{bananapi-f3.h => k1.h} (100%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 79867656b15..ac50c1d7234 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -8,15 +8,17 @@ choice
 	prompt "Target select"
 	optional
 
+config ARCH_K1
+	bool "Spacemit K1 Architecture"
+	help
+	  This enables support for Spacemit K1 SoC family.
+
 config TARGET_ANDES_AE350
 	bool "Support Andes ae350"
 
 config TARGET_ANDES_VOYAGER
 	bool "Support Andes Voyager Board"
 
-config TARGET_BANANAPI_F3
-	bool "Support BananaPi F3 Board"
-
 config TARGET_K230_CANMV
 	bool "Support K230 CanMV Board"
 
@@ -115,7 +117,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
-source "board/spacemit/bananapi-f3/Kconfig"
+source "board/spacemit/k1/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 14201df80f2..4b621158334 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
+if ARCH_K1
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
similarity index 63%
rename from board/spacemit/bananapi-f3/Kconfig
rename to board/spacemit/k1/Kconfig
index f89fa9af2c7..9f9c806d00d 100644
--- a/board/spacemit/bananapi-f3/Kconfig
+++ b/board/spacemit/k1/Kconfig
@@ -1,7 +1,7 @@
-if TARGET_BANANAPI_F3
+if ARCH_K1
 
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
@@ -22,4 +22,9 @@ config BOARD_SPECIFIC_OPTIONS
 	def_bool y
 	select SPACEMIT_K1
 
+config TARGET_BANANAPI_F3
+	bool "Support BananaPi F3 Board"
+	help
+	  BananaPi F3 board contains Spacemit K1 SoC.
+
 endif
diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
similarity index 61%
rename from board/spacemit/bananapi-f3/MAINTAINERS
rename to board/spacemit/k1/MAINTAINERS
index 131bad03181..bd476c32719 100644
--- a/board/spacemit/bananapi-f3/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@@gmail.com>
 S:	Maintained
-F:	board/spacemit/bananapi-f3/
-F:	configs/bananapi-f3_defconfig
+F:	board/spacemit/k1/
+F:	configs/k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/k1/Makefile
similarity index 100%
rename from board/spacemit/bananapi-f3/Makefile
rename to board/spacemit/k1/Makefile
diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/k1/board.c
similarity index 100%
rename from board/spacemit/bananapi-f3/board.c
rename to board/spacemit/k1/board.c
diff --git a/configs/bananapi-f3_defconfig b/configs/k1_defconfig
similarity index 97%
rename from configs/bananapi-f3_defconfig
rename to configs/k1_defconfig
index a726ce84775..0bdc3c800f0 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/k1_defconfig
@@ -6,9 +6,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
-CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_ARCH_K1=y
+CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/include/configs/bananapi-f3.h b/include/configs/k1.h
similarity index 100%
rename from include/configs/bananapi-f3.h
rename to include/configs/k1.h
-- 
2.25.1

