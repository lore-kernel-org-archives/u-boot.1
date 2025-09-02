Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94925CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 12:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90725832EB;
	Tue,  2 Sep 2025 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="tQLwPSPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6B983AAF; Tue,  2 Sep 2025 12:07:32 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E70983A6A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=333b0acd5=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1756807649; x=1788343649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i1sxRzDe6p3xdUeDTNo9so0XxoYV27qYyeaGBSepbtU=;
 b=tQLwPSPZXwiFsD3BRvkAhBIbuNKJy6dNRSr5rL+O8nRlt7SmC16ck0f/
 bvpDaJfQKN1DcBGs9UPDZfV7N/tK71eskFoWOmY8sPm5pq221hXWtDC1q
 bznpWK+2onwmgMBtEgwX2KdFMYy+RDPHHelj3lN+tHxP6xIBb6xrRdsVc
 zyOhoPN/EY2w+5FXYXdfK0B7C+YryDjvBdZzV6odF8zJr+fda7idTfDUi
 yh+bDhThmEftFwwGKbfCu82B30GI/9XcQjFYjixERFn2LdcBfMc59uGXv
 HGZNyis/rg9WI0FgNZTvTK//Hgv6Pf7Xs6ODiEUVtqAAKMFPqonHEJRQe w==;
X-CSE-ConnectionGUID: U8DGPTI1SzmpoHU1gTA8dA==
X-CSE-MsgGUID: xaCfuVb0SwmpETgq14hmLw==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="46493798"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2025 03:07:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 03:07:15 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 03:07:13 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 1/6] board: microchip: icicle: rename all icicle files to
 generic
Date: Tue, 2 Sep 2025 11:10:58 +0100
Message-ID: <20250902101105.3218793-2-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
References: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 02 Sep 2025 14:59:00 +0200
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

Make all Icicle Kit files generic. This supports the addition of
upcoming support for other MPFS boards.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 arch/riscv/Kconfig                                         | 6 +++---
 board/microchip/{mpfs_icicle => mpfs_generic}/Kconfig      | 6 +++---
 board/microchip/mpfs_generic/MAINTAINERS                   | 7 +++++++
 board/microchip/{mpfs_icicle => mpfs_generic}/Makefile     | 2 +-
 .../mpfs_icicle.c => mpfs_generic/mpfs_generic.c}          | 0
 board/microchip/mpfs_icicle/MAINTAINERS                    | 7 -------
 ...s_icicle_defconfig => microchip_mpfs_generic_defconfig} | 2 +-
 .../{microchip_mpfs_icicle.h => microchip_mpfs_generic.h}  | 0
 8 files changed, 15 insertions(+), 15 deletions(-)
 rename board/microchip/{mpfs_icicle => mpfs_generic}/Kconfig (92%)
 create mode 100644 board/microchip/mpfs_generic/MAINTAINERS
 rename board/microchip/{mpfs_icicle => mpfs_generic}/Makefile (85%)
 rename board/microchip/{mpfs_icicle/mpfs_icicle.c => mpfs_generic/mpfs_generic.c} (100%)
 delete mode 100644 board/microchip/mpfs_icicle/MAINTAINERS
 rename configs/{microchip_mpfs_icicle_defconfig => microchip_mpfs_generic_defconfig} (95%)
 rename include/configs/{microchip_mpfs_icicle.h => microchip_mpfs_generic.h} (100%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 04eb0e6f23c..6e6e0dfd4b5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,8 +23,8 @@ config TARGET_K230_CANMV
 config TARGET_LICHEERV_NANO
 	bool "Support LicheeRV Nano Board"
 
-config TARGET_MICROCHIP_ICICLE
-	bool "Support Microchip PolarFire-SoC Icicle Board"
+config TARGET_MICROCHIP_GENERIC
+	bool "Support Microchip PolarFire-SoC Boards"
 
 config TARGET_MILKV_DUO
 	bool "Support Milk-v Duo Board"
@@ -108,7 +108,7 @@ source "board/andestech/voyager/Kconfig"
 source "board/aspeed/ibex_ast2700/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
-source "board/microchip/mpfs_icicle/Kconfig"
+source "board/microchip/mpfs_generic/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
diff --git a/board/microchip/mpfs_icicle/Kconfig b/board/microchip/mpfs_generic/Kconfig
similarity index 92%
rename from board/microchip/mpfs_icicle/Kconfig
rename to board/microchip/mpfs_generic/Kconfig
index 760dffc488b..8dcf55a0311 100644
--- a/board/microchip/mpfs_icicle/Kconfig
+++ b/board/microchip/mpfs_generic/Kconfig
@@ -1,7 +1,7 @@
-if TARGET_MICROCHIP_ICICLE
+if TARGET_MICROCHIP_GENERIC
 
 config SYS_BOARD
-	default "mpfs_icicle"
+	default "mpfs_generic"
 
 config SYS_VENDOR
 	default "microchip"
@@ -10,7 +10,7 @@ config SYS_CPU
 	default "generic"
 
 config SYS_CONFIG_NAME
-	default "microchip_mpfs_icicle"
+	default "microchip_mpfs_generic"
 
 config TEXT_BASE
 	default 0x80000000 if !RISCV_SMODE
diff --git a/board/microchip/mpfs_generic/MAINTAINERS b/board/microchip/mpfs_generic/MAINTAINERS
new file mode 100644
index 00000000000..3de99144c41
--- /dev/null
+++ b/board/microchip/mpfs_generic/MAINTAINERS
@@ -0,0 +1,7 @@
+Microchip MPFS Generic
+M:	Conor Dooley <conor.dooley@microchip.com>
+M:	Jamie Gibbons <jamie.gibbons@microchip.com>
+S:	Maintained
+F:	board/microchip/mpfs_generic/
+F:	include/configs/microchip_mpfs_generic.h
+F:	configs/microchip_mpfs_generic_defconfig
diff --git a/board/microchip/mpfs_icicle/Makefile b/board/microchip/mpfs_generic/Makefile
similarity index 85%
rename from board/microchip/mpfs_icicle/Makefile
rename to board/microchip/mpfs_generic/Makefile
index 72b0410dda8..dfe4b2634e6 100644
--- a/board/microchip/mpfs_icicle/Makefile
+++ b/board/microchip/mpfs_generic/Makefile
@@ -4,4 +4,4 @@
 # Padmarao Begari <padmarao.begari@microchip.com>
 #
 
-obj-y	+= mpfs_icicle.o
+obj-y	+= mpfs_generic.o
diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_generic/mpfs_generic.c
similarity index 100%
rename from board/microchip/mpfs_icicle/mpfs_icicle.c
rename to board/microchip/mpfs_generic/mpfs_generic.c
diff --git a/board/microchip/mpfs_icicle/MAINTAINERS b/board/microchip/mpfs_icicle/MAINTAINERS
deleted file mode 100644
index d092b5a8111..00000000000
--- a/board/microchip/mpfs_icicle/MAINTAINERS
+++ /dev/null
@@ -1,7 +0,0 @@
-Microchip MPFS icicle
-M:	Conor Dooley <conor.dooley@microchip.com>
-M:	Cyril Jean <cyril.jean@microchip.com>
-S:	Maintained
-F:	board/microchip/mpfs_icicle/
-F:	include/configs/microchip_mpfs_icicle.h
-F:	configs/microchip_mpfs_icicle_defconfig
diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_generic_defconfig
similarity index 95%
rename from configs/microchip_mpfs_icicle_defconfig
rename to configs/microchip_mpfs_generic_defconfig
index 9f933592c9d..0ed0cae93eb 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -9,7 +9,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SYS_MEM_TOP_HIDE=0x400000
 # CONFIG_DEBUG_UART is not set
-CONFIG_TARGET_MICROCHIP_ICICLE=y
+CONFIG_TARGET_MICROCHIP_GENERIC=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
diff --git a/include/configs/microchip_mpfs_icicle.h b/include/configs/microchip_mpfs_generic.h
similarity index 100%
rename from include/configs/microchip_mpfs_icicle.h
rename to include/configs/microchip_mpfs_generic.h
-- 
2.43.0

