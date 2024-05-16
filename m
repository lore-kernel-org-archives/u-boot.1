Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B66C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1176188353;
	Thu, 16 May 2024 14:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="fgmlHyqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5A088258; Thu, 16 May 2024 11:04:03 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142F08824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f0ef6bee72so3892526a34.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850240; x=1716455040;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDCiwIYhHKtlc4At4tn6kJDnwHAQxYQP3jwIHaLFCsw=;
 b=fgmlHyqMWC8FpVXaV5ULTk8VMwxImDwLxqKDByThg8tD7L/5TvPV7/s+kWZuSQssrF
 C5P0HOMdkFXvmMlIH010OP09erFhmP4HyzIOv8rBenf4Hg3SxqERP/BU0YNrZtNFBlgk
 sAP+4JnWV8zX6Ku/fqyI1Sxz/S+uiN2ONI14kjxzCMcKRaCXmQ4US7ILxMBXVei7/7+V
 tJkbZ3wce+kqARkARaFps4ChZyQSHxGdDzYXJWkY3h6ziAVtahyop8wkXfIDcUDCviqs
 HjU206mkCbEwO4fNNqvzv4Ls0V614nSPPytAsftnpdCKsCg/5tyj8aXm88Ba/p6SU1CH
 sUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850240; x=1716455040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDCiwIYhHKtlc4At4tn6kJDnwHAQxYQP3jwIHaLFCsw=;
 b=CmoU8t/Fhgn40Y14L9lW1CbviXUBn2gUJ9No5/aH2yt+iPaOXpLT7O+3kqFy2rkKdy
 vpDBV6/ixeQK2fg7O8mV7n1iQrsyb7FTBruGcWm7MWyaKHEMg1J2VIgui8KnxL0BC8Ep
 nCABdwz9wR4aDL68sszcpXpFqbNSOoYbxgeiSFTieUHmzz67L3N0nMRCT68996RWnkEM
 laRL1K5YLevakp1N+l41L2qrHglhvm3HFUaYo2LZwZXS8Lden67XhalMWDfp34od3X6x
 zvDw1EMtZ8GOPsV+Qkmk4BJpyb6ZvaSr3WF3sU+CZorTO9jkVHydlig5euznvaV43uj1
 W4Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6mxcwATY0oiEGuyQa2xzrwSReZ5UjgOdbFEUmlWtJAGPOD+ABzlRoLJyT1C6/QIM1XH3i4gM+X/giLP4aNR4so40FLQ==
X-Gm-Message-State: AOJu0Yyysjrch4+1TL3gM5JFdiKpvXOpQhDWHRoc0B8LNkQfE3sUciWe
 9NgH4It39RvaeUZQAeB6WJFVsGomaUisKZHjF7ZChVhGZM6k2jfJUftvegzwcxc=
X-Google-Smtp-Source: AGHT+IGx3GVFEhyBu9DEtYnUQIwpDYLGk+qgS205P657DTw72js1FvfxMhSFvV2uCMzrUv+rm7FbtQ==
X-Received: by 2002:a05:6870:2101:b0:23c:b686:f5b with SMTP id
 586e51a60fabf-24172a63f8cmr20397600fac.15.1715850239677; 
 Thu, 16 May 2024 02:03:59 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:03:59 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 7/9] rockchip: RK356x: Enable display cpuinfo support on
 all boards
Date: Thu, 16 May 2024 08:59:07 +0000
Message-ID: <20240516090031.2373-8-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Imply DISPLAY_CPUINFO Kconfig options to support on all RK3566 and
RK3568 boards, Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/Kconfig            | 1 +
 configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
 configs/bpi-r2-pro-rk3568_defconfig       | 1 -
 configs/evb-rk3568_defconfig              | 1 -
 configs/generic-rk3568_defconfig          | 1 -
 configs/lubancat-2-rk3568_defconfig       | 1 -
 configs/nanopi-r5c-rk3568_defconfig       | 1 -
 configs/nanopi-r5s-rk3568_defconfig       | 1 -
 configs/odroid-m1-rk3568_defconfig        | 1 -
 configs/pinetab2-rk3566_defconfig         | 1 -
 configs/quartz64-a-rk3566_defconfig       | 1 -
 configs/quartz64-b-rk3566_defconfig       | 1 -
 configs/radxa-cm3-io-rk3566_defconfig     | 1 -
 configs/radxa-e25-rk3568_defconfig        | 1 -
 configs/rock-3a-rk3568_defconfig          | 1 -
 configs/soquartz-blade-rk3566_defconfig   | 1 -
 configs/soquartz-cm4-rk3566_defconfig     | 1 -
 configs/soquartz-model-a-rk3566_defconfig | 1 -
 18 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1fd482e43b..2e9c71138e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -331,6 +331,7 @@ config ROCKCHIP_RK3568
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
+	imply DISPLAY_CPUINFO
 	help
 	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
 	  including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index a03509bf46..95f7cf0739 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -21,7 +21,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index eccc15a0ae..4955fd907c 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index 2076f55122..e6da8fd246 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-evb1-v10.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 66a33afbba..ba2d995cdc 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -20,7 +20,6 @@ CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 88593bfa70..384d0ecfc5 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-lubancat-2.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 4a6c320faf..b83796083d 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 7ab12e619a..5d500963a2 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index b5263caff6..7bea6e6851 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-odroid-m1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index e46acf3a3b..1441feb796 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-pinetab2-v2.0.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index 1ea8e0f40c..458d6d6e81 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index f61b2c181a..029c184177 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-b.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 48c8fcf5a6..8d6990c403 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -15,7 +15,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-radxa-cm3-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 496fee0e0a..2cfa34956d 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-radxa-e25.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 66ac2f6d7a..9ac9ef8827 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 82910daf7c..3d5344e43a 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-blade.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index 5744f1baa8..99e5dbe4fc 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-cm4.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index 920df9b622..656e0ef178 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-model-a.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
-- 
2.45.0

