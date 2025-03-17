Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E406C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 15:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCDE8081A;
	Mon, 17 Mar 2025 16:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XVYXHJJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546B38081A; Mon, 17 Mar 2025 14:38:55 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFA9800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so691160566b.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742218732; x=1742823532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VsxTsk0oraNQm0LWdF6trrCJbD0TB0300z0RaWixEkY=;
 b=XVYXHJJQkSolSBXl3dzCA1sqqHI0dcCe3O1oxFiihpj5znmlcwZ76oRmBpGxqAO6in
 lVQspW+vtGiVzbBhM5H2GNhMkXgRmd3fIvdsXOGENj2HPrVf9F9Y26k4Jh7ASTqMrYxt
 DmiSrDhtJ5wtCJvByjueEGEGtF5t4SsmKGvUjYjbP6qHZKjAEVMWYJ/X0TscWgrcrvjg
 0pUY93oEtzxM6y2nk7qlo3qgXrVIXhIbw9RzcnacHJYkHvuoVo7qkRWs32RvaJww9KnS
 31SSs/vuGDG3n6c26Um+m1PRb4gupcWaBPFfY0EU2JhJR0x+1aV7e4nUvWY8v5Q5OwrF
 obPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742218732; x=1742823532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VsxTsk0oraNQm0LWdF6trrCJbD0TB0300z0RaWixEkY=;
 b=sYgakayzU/nYdLoFYsh2ynA1dy1jAbIe8fNhMYKcQXRPK4oHF9LkJoMRKDoWBvuwlm
 uBCrKGuFqMAw6dDaTSd66TFA5GCqKdC5bvxWzueXXhu0dc6oLpTV/B5Q1LvI0uFxZRxu
 tph37y6Q4Im/959jLH8wAtsfMBKkLk+GhMSkUSaLXOrtKka2lDlK75qfSqxdiuQxqqMK
 XnRiFVvWYGGBbUBrXX+8Nsw0xWxjvU8j4NJEXpzBFquoA8kWBClRU0TwvypzQJPXGTXh
 o1vTzrXqkt4lPYZeBtjR8ZEmUurvHtGZeGFMMJg7vg2/QMJ23KfPGENwVSdrV9zCur3K
 OjPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJDnbzhhSERXvkrR6syngEttU8v5MW7uvWG6gvDMuerSivYasjgj5aKu09TacLzIeS/AWPQFw=@lists.denx.de
X-Gm-Message-State: AOJu0YzGTTSDyk3jC4H1syktTpER3HdlcA/CucZKyQFoYIYeQCYIsDhU
 7zRoCMJ8hLl9LBMQqKFXY9R5OFGnBrCNxC00jayisaFUkFYdQWpsNc6Jh1OqEis=
X-Gm-Gg: ASbGncuyxevKErpUf5lh5ZyVxAaMHm3FloX0ZyrAqrBuv6ilVscuVtc5oHMGtVgfvMq
 z99JzdG4sGFr638qQRFFrNc/mJVRPhzbKlIyii8eIsarE3K8sog/YlrqoQPhCU8lU4a52X/cl70
 g+fscVeVbWW/hMg8Gmpoyp+i4f6nNSZbGlKId78YB0uTPy8roaDGWpG/+QTZLCr8zHa/rAmtAV4
 YQgLU0dIT8zl0OrccKv3KV3tED6Z0aDvCE/rWCOorrv0dhFVL9IzKuKAVCowPy9WjP9r/ycZrzU
 KR4B/j9bnhwXWJLAArGAOh3aoYmv+uj7ZKRUFUqj3XDgMg9QMd+vR26NZJSbHVaR3MEEs5t4PAa
 KgBViekiUxTqPDaCrPAdhlqM=
X-Google-Smtp-Source: AGHT+IGz/mkJrJmaTYr3hvqf2h2xDRrf66wyZK9v+3QDEP7TM4n7th8i8lfYddbi9DDtFumjw3sj1w==
X-Received: by 2002:a17:907:2d89:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-ac3304d698cmr1431975466b.50.1742218731401; 
 Mon, 17 Mar 2025 06:38:51 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a495a3sm663734266b.159.2025.03.17.06.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:38:50 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: e@freeshell.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tang Yuantian <andy.tang@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Manish Tomar <Manish.Tomar@nxp.com>, Mathew McBride <matt@traverse.com.au>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Robert Marko <robert.marko@sartura.hr>,
 Lukas Funke <lukas.funke@weidmueller.com>, Peng Fan <peng.fan@nxp.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
Date: Mon, 17 Mar 2025 15:38:36 +0200
Message-ID: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Mar 2025 16:38:15 +0100
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

The EFI subsystem defines its own bounce buffer for devices that
can't transfer data > 4GB. U-Boot already has a generic BOUNCE_BUFFER
which can be reused instead of defining another symbol.
The only limitation for EFI is that we don't know how big the file a user
chooses to transfer is and as a result we can't depend on allocating the
memory from the malloc area, which can prove too small.

So allocate an EFI buffer of the correct size and pass it to the DM,
which already supports bounce buffering via bounce_buffer_start_extalign()

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/Kconfig                              |  8 ++
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/ls1028aqds_tfa_defconfig              |  1 -
 configs/ls1028aqds_tfa_lpuart_defconfig       |  1 -
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/ls1028ardb_tfa_defconfig              |  1 -
 configs/ls1043ardb_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/ls1043ardb_tfa_defconfig              |  1 -
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/ls1046ardb_tfa_defconfig              |  1 -
 configs/ls1088aqds_tfa_defconfig              |  1 -
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/ls1088ardb_tfa_defconfig              |  1 -
 configs/ls2088aqds_tfa_defconfig              |  1 -
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/ls2088ardb_tfa_defconfig              |  1 -
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/lx2160aqds_tfa_defconfig              |  1 -
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/lx2160ardb_tfa_defconfig              |  1 -
 configs/lx2160ardb_tfa_stmm_defconfig         |  1 -
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig  |  1 -
 configs/lx2162aqds_tfa_defconfig              |  1 -
 .../lx2162aqds_tfa_verified_boot_defconfig    |  1 -
 configs/ten64_tfa_defconfig                   |  1 -
 include/efi_loader.h                          |  4 -
 lib/efi_loader/Kconfig                        |  7 --
 lib/efi_loader/efi_disk.c                     | 78 +++++++------------
 lib/efi_loader/efi_memory.c                   | 16 ----
 29 files changed, 36 insertions(+), 101 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf08fe63f1e7..bb946e69254c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1417,6 +1417,7 @@ config TARGET_LS2080A_EMU
 	select ARCH_LS2080A
 	select ARM64
 	select ARMV8_MULTIENTRY
+	select BOUNCE_BUFFER
 	select FSL_DDR_SYNC_REFRESH
 	select GPIO_EXTRA_HEADER
 	help
@@ -1432,6 +1433,7 @@ config TARGET_LS1088AQDS
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select GPIO_EXTRA_HEADER
 	select SUPPORT_SPL
 	select FSL_DDR_INTERACTIVE if !SD_BOOT
@@ -1448,6 +1450,7 @@ config TARGET_LS2080AQDS
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select GPIO_EXTRA_HEADER
 	select SUPPORT_SPL
 	imply SCSI
@@ -1467,6 +1470,7 @@ config TARGET_LS2080ARDB
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select SUPPORT_SPL
 	select FSL_DDR_BIST
 	select FSL_DDR_INTERACTIVE if !SPL
@@ -1485,6 +1489,7 @@ config TARGET_LS2081ARDB
 	select ARM64
 	select ARMV8_MULTIENTRY
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select GPIO_EXTRA_HEADER
 	select SUPPORT_SPL
 	help
@@ -1500,6 +1505,7 @@ config TARGET_LX2160ARDB
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select GPIO_EXTRA_HEADER
 	help
 	  Support for NXP LX2160ARDB platform.
@@ -1514,6 +1520,7 @@ config TARGET_LX2160AQDS
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select GPIO_EXTRA_HEADER
 	help
 	  Support for NXP LX2160AQDS platform.
@@ -1529,6 +1536,7 @@ config TARGET_LX2162AQDS
 	select ARMV8_MULTIENTRY
 	select ARCH_SUPPORT_TFABOOT
 	select BOARD_LATE_INIT
+	select BOUNCE_BUFFER
 	select GPIO_EXTRA_HEADER
 	help
 	  Support for NXP LX2162AQDS platform.
diff --git a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
index 97eb7d9dca4c..e3b1018f6f8e 100644
--- a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1028aqds_tfa_defconfig b/configs/ls1028aqds_tfa_defconfig
index cc53c17f543b..5b7dd4bf7dd5 100644
--- a/configs/ls1028aqds_tfa_defconfig
+++ b/configs/ls1028aqds_tfa_defconfig
@@ -25,7 +25,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1028aqds_tfa_lpuart_defconfig b/configs/ls1028aqds_tfa_lpuart_defconfig
index 8da7271c7f85..a38c81e83199 100644
--- a/configs/ls1028aqds_tfa_lpuart_defconfig
+++ b/configs/ls1028aqds_tfa_lpuart_defconfig
@@ -24,7 +24,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
index 3f71a37559be..da225e1dad8f 100644
--- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
index 89e452bdb1a8..829cc5204d34 100644
--- a/configs/ls1028ardb_tfa_defconfig
+++ b/configs/ls1028ardb_tfa_defconfig
@@ -25,7 +25,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
index 1b41fe608dae..04ca2a3afd81 100644
--- a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
@@ -24,7 +24,6 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1043ardb_tfa_defconfig b/configs/ls1043ardb_tfa_defconfig
index ca100bd4bca9..a6ca63cd8f79 100644
--- a/configs/ls1043ardb_tfa_defconfig
+++ b/configs/ls1043ardb_tfa_defconfig
@@ -26,7 +26,6 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
index 6b4e834ad4a0..9c22d542a6f8 100644
--- a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
@@ -24,7 +24,6 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_defconfig
index a8f20f9b87b7..4eab8ea19e8e 100644
--- a/configs/ls1046ardb_tfa_defconfig
+++ b/configs/ls1046ardb_tfa_defconfig
@@ -26,7 +26,6 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index df86bf982ee4..31d56f587af8 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -29,7 +29,6 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
index df472eeb404d..c910b73634f9 100644
--- a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
@@ -26,7 +26,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_defconfig
index 8d640f6594b2..682007e803d1 100644
--- a/configs/ls1088ardb_tfa_defconfig
+++ b/configs/ls1088ardb_tfa_defconfig
@@ -28,7 +28,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index 8c86b8b11eb3..ea73a4cda971 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -23,7 +23,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
index 3fd1de967896..7f53397cdcb1 100644
--- a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
@@ -27,7 +27,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls2088ardb_tfa_defconfig b/configs/ls2088ardb_tfa_defconfig
index f053044fa56e..398dfe068015 100644
--- a/configs/ls2088ardb_tfa_defconfig
+++ b/configs/ls2088ardb_tfa_defconfig
@@ -29,7 +29,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
index 321ed71993b8..afb842978209 100644
--- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
@@ -28,7 +28,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_defconfig
index 465f07ee7f82..ec23ed384c44 100644
--- a/configs/lx2160aqds_tfa_defconfig
+++ b/configs/lx2160aqds_tfa_defconfig
@@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
index 478a01b566c6..71f4436eca06 100644
--- a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
@@ -29,7 +29,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/lx2160ardb_tfa_defconfig b/configs/lx2160ardb_tfa_defconfig
index 8fd18825569c..6be3890de3ed 100644
--- a/configs/lx2160ardb_tfa_defconfig
+++ b/configs/lx2160ardb_tfa_defconfig
@@ -31,7 +31,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/lx2160ardb_tfa_stmm_defconfig b/configs/lx2160ardb_tfa_stmm_defconfig
index cf65897af898..ef89b0f34575 100644
--- a/configs/lx2160ardb_tfa_stmm_defconfig
+++ b/configs/lx2160ardb_tfa_stmm_defconfig
@@ -32,7 +32,6 @@ CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_EFI_MM_COMM_TEE=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
index 46b6085a52fe..2b31be10899b 100644
--- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
@@ -28,7 +28,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_defconfig
index 41e0262f3ca5..43f8069cfde5 100644
--- a/configs/lx2162aqds_tfa_defconfig
+++ b/configs/lx2162aqds_tfa_defconfig
@@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx2162aqds_tfa_verified_boot_defconfig
index 7abfdbafbdf1..33b362c20b65 100644
--- a/configs/lx2162aqds_tfa_verified_boot_defconfig
+++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
@@ -30,7 +30,6 @@ CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTDELAY=10
diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index a65209e8335b..f35de31718f7 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -16,7 +16,6 @@ CONFIG_PCI=y
 CONFIG_AHCI=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=3
 CONFIG_MP=y
-CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e9c10819ba26..3ed27e97a083 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -894,10 +894,6 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 				    struct efi_loaded_image_obj **handle_ptr,
 				    struct efi_loaded_image **info_ptr);

-#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
-extern void *efi_bounce_buffer;
-#define EFI_LOADER_BOUNCE_BUFFER_SIZE (64 * 1024 * 1024)
-#endif

 /* shorten device path */
 struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 6130af14337e..bc08776ef4a6 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -490,13 +490,6 @@ config EFI_HTTP_PROTOCOL
 endmenu

 menu "Misc options"
-config EFI_LOADER_BOUNCE_BUFFER
-	bool "EFI Applications use bounce buffers for DMA operations"
-	help
-	  Some hardware does not support DMA to full 64bit addresses. For this
-	  hardware we can create a bounce buffer so that payloads don't have to
-	  worry about platform details.
-
 config EFI_GRUB_ARM32_WORKAROUND
 	bool "Workaround for GRUB on 32bit ARM"
 	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 5452640354e0..a0202032bb5a 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -105,6 +105,8 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
 	int blksz;
 	int blocks;
 	unsigned long n;
+	u64 bb = 0xffffffff;
+	void *bb_ptr = buffer;

 	diskobj = container_of(this, struct efi_disk_obj, ops);
 	blksz = diskobj->media.block_size;
@@ -113,27 +115,35 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
 	EFI_PRINT("blocks=%x lba=%llx blksz=%x dir=%d\n",
 		  blocks, lba, blksz, direction);

+	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && (uintptr_t)buffer >= SZ_4G + buffer_size - 1) {
+		if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
+				       buffer_size >> EFI_PAGE_SHIFT, &bb) != EFI_SUCCESS)
+			return EFI_OUT_OF_RESOURCES;
+
+		bb_ptr = (void *)(uintptr_t)bb;
+	}
 	/* We only support full block access */
-	if (buffer_size & (blksz - 1))
+	if (buffer_size & (blksz - 1)) {
+		if (buffer != bb_ptr)
+			efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
 		return EFI_BAD_BUFFER_SIZE;
+	}

 	if (CONFIG_IS_ENABLED(PARTITIONS) &&
 	    device_get_uclass_id(diskobj->header.dev) == UCLASS_PARTITION) {
 		if (direction == EFI_DISK_READ)
-			n = disk_blk_read(diskobj->header.dev, lba, blocks,
-					  buffer);
+			n = disk_blk_read(diskobj->header.dev, lba, blocks, bb_ptr);
 		else
-			n = disk_blk_write(diskobj->header.dev, lba, blocks,
-					   buffer);
+			n = disk_blk_write(diskobj->header.dev, lba, blocks, bb_ptr);
 	} else {
 		/* dev is a block device (UCLASS_BLK) */
 		struct blk_desc *desc;

 		desc = dev_get_uclass_plat(diskobj->header.dev);
 		if (direction == EFI_DISK_READ)
-			n = blk_dread(desc, lba, blocks, buffer);
+			n = blk_dread(desc, lba, blocks, bb_ptr);
 		else
-			n = blk_dwrite(desc, lba, blocks, buffer);
+			n = blk_dwrite(desc, lba, blocks, bb_ptr);
 	}

 	/* We don't do interrupts, so check for timers cooperatively */
@@ -141,8 +151,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,

 	EFI_PRINT("n=%lx blocks=%x\n", n, blocks);

-	if (n != blocks)
+	if (n != blocks) {
+		if (buffer != bb_ptr)
+			efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
 		return EFI_DEVICE_ERROR;
+	}
+
+	if (buffer != bb_ptr) {
+		memcpy(buffer, bb_ptr, buffer_size);
+		efi_free_pages(bb, buffer_size >> EFI_PAGE_SHIFT);
+	}

 	return EFI_SUCCESS;
 }
@@ -166,7 +184,6 @@ static efi_status_t EFIAPI efi_disk_read_blocks(struct efi_block_io *this,
 			u32 media_id, u64 lba, efi_uintn_t buffer_size,
 			void *buffer)
 {
-	void *real_buffer = buffer;
 	efi_status_t r;

 	if (!this)
@@ -184,31 +201,12 @@ static efi_status_t EFIAPI efi_disk_read_blocks(struct efi_block_io *this,
 	    (this->media->last_block + 1) * this->media->block_size)
 		return EFI_INVALID_PARAMETER;

-#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
-	if (buffer_size > EFI_LOADER_BOUNCE_BUFFER_SIZE) {
-		r = efi_disk_read_blocks(this, media_id, lba,
-			EFI_LOADER_BOUNCE_BUFFER_SIZE, buffer);
-		if (r != EFI_SUCCESS)
-			return r;
-		return efi_disk_read_blocks(this, media_id, lba +
-			EFI_LOADER_BOUNCE_BUFFER_SIZE / this->media->block_size,
-			buffer_size - EFI_LOADER_BOUNCE_BUFFER_SIZE,
-			buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
-	}
-
-	real_buffer = efi_bounce_buffer;
-#endif
-
 	EFI_ENTRY("%p, %x, %llx, %zx, %p", this, media_id, lba,
 		  buffer_size, buffer);

-	r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, real_buffer,
+	r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, buffer,
 			       EFI_DISK_READ);

-	/* Copy from bounce buffer to real buffer if necessary */
-	if ((r == EFI_SUCCESS) && (real_buffer != buffer))
-		memcpy(buffer, real_buffer, buffer_size);
-
 	return EFI_EXIT(r);
 }

@@ -232,7 +230,6 @@ static efi_status_t EFIAPI efi_disk_write_blocks(struct efi_block_io *this,
 			u32 media_id, u64 lba, efi_uintn_t buffer_size,
 			void *buffer)
 {
-	void *real_buffer = buffer;
 	efi_status_t r;

 	if (!this)
@@ -252,29 +249,10 @@ static efi_status_t EFIAPI efi_disk_write_blocks(struct efi_block_io *this,
 	    (this->media->last_block + 1) * this->media->block_size)
 		return EFI_INVALID_PARAMETER;

-#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
-	if (buffer_size > EFI_LOADER_BOUNCE_BUFFER_SIZE) {
-		r = efi_disk_write_blocks(this, media_id, lba,
-			EFI_LOADER_BOUNCE_BUFFER_SIZE, buffer);
-		if (r != EFI_SUCCESS)
-			return r;
-		return efi_disk_write_blocks(this, media_id, lba +
-			EFI_LOADER_BOUNCE_BUFFER_SIZE / this->media->block_size,
-			buffer_size - EFI_LOADER_BOUNCE_BUFFER_SIZE,
-			buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
-	}
-
-	real_buffer = efi_bounce_buffer;
-#endif
-
 	EFI_ENTRY("%p, %x, %llx, %zx, %p", this, media_id, lba,
 		  buffer_size, buffer);

-	/* Populate bounce buffer if necessary */
-	if (real_buffer != buffer)
-		memcpy(real_buffer, buffer, buffer_size);
-
-	r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, real_buffer,
+	r = efi_disk_rw_blocks(this, media_id, lba, buffer_size, buffer,
 			       EFI_DISK_WRITE);

 	return EFI_EXIT(r);
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 6d00b1862505..d7a8cb89e5b5 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -40,10 +40,6 @@ struct efi_mem_list {
 /* This list contains all memory map items */
 static LIST_HEAD(efi_mem);

-#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
-void *efi_bounce_buffer;
-#endif
-
 /**
  * struct efi_pool_allocation - memory block allocated from pool
  *
@@ -852,18 +848,6 @@ int efi_memory_init(void)

 	add_u_boot_and_runtime();

-#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
-	/* Request a 32bit 64MB bounce buffer region */
-	uint64_t efi_bounce_buffer_addr = 0xffffffff;
-
-	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
-			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
-			       &efi_bounce_buffer_addr) != EFI_SUCCESS)
-		return -1;
-
-	efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
-#endif
-
 	return 0;
 }

--
2.47.2

