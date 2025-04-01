Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0327C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E411881EC0;
	Tue,  1 Apr 2025 18:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0c9UaFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DED481F66; Tue,  1 Apr 2025 18:10:05 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97FE781E6C
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e6167d0536so6524968a12.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743523802; x=1744128602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXXxA9FbPfBuifZmu7skqXdauC3tyGR1bc2b8fzlVi0=;
 b=S0c9UaFXMRa+8222HxlSWIHYTfcb1S33pmntHZWaByLY3/UmxhiANSFfnQt4+Qiokr
 MWpJLzH9rsNA8ZhI0s1VQ50tqeLrh6cvUgZuVaPDcXSeVq+Y+y0SrucKwBzB5I8okPn/
 R9lRBDqWdIBrSwObKAEtf6eEfhkHn6Zy/Ti3LI50lcZ2GMoen2VES2H87gOnvtX+INCS
 GEfzc6JdFdEEJuHImpOjaUbCDe5JRVBxA6xYm78bFOFPIB9XeXx7nimMhXre67WYhOM5
 7QLGEFyieeIc3cHVIG1f1K3vpy2Xvu6B0tLevgVlv5nV+QcIe0rHaP7X4q2BjVkA3ovY
 tmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743523802; x=1744128602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXXxA9FbPfBuifZmu7skqXdauC3tyGR1bc2b8fzlVi0=;
 b=ZzUNyRJiGm4qtoiqFM4A2c/3fZU5Gz4OWVlM5qbUsAmALncEGJIudXPN4ykfZNjowt
 ESZKIcjE3V6IZKmDnb0m7g8XtSdvFhTCtXY7DgaID7M8iooBzqPU72/OvLSQQAqfakKD
 NKMUNBsro32UPgKUWGB/8Z0seZC2YzyDiQrkUET02TuO36mzsqChkrjTupbv7oSBYClz
 wpX9217ys6kq5ft0iOIU59wWcYlnkz1IZtH0RLeLdkY8LT08047NtRS3c4vUSd4DGuOS
 K5AJjDrZjAzNCQBW+RO9xzVjtEl8PTI8wzAQkUXojaaRGCdgMxutcIWUYzKcJU9ruvRU
 Wwyg==
X-Gm-Message-State: AOJu0YxuVNizDmdjdALekbdDdLGMpR4xwyq+Roh0uAeoTZuS+2bxKk7E
 oXoR6rA5brJXIo8jpG58/bWLGRj170g75vRCkP6ah+0AfZwiv9Q9
X-Gm-Gg: ASbGncvE3n+9Ks/pMQk/FC1wPsqP88zdlCfmQzFp5ZIbh8TAqfkgIYb5tf9BGbMATI0
 ffsk+nWs41NOHF+aEsoXJ+6CScOGvMu60jgVsgQlGzv36lLRvB3VeQoKuvKn3FtlhOGg7iZ3edb
 j2lUS82GsgbjFSgprRuEgrKZcX6bbX5fNt9dgAbggAi9EmwMueOtw28E4aRfkMNAIiNpP3tCE4p
 uLDtdNeVwyCVS4p106kGw+RFeK6Zt7ocROhu9Qi/TwgGD1oDQOmVeLsRsyskz4mSbgoZeDyDAoK
 TcE11/t38D1vRwJvX9rE4QU3usLp7Y0rlcNn
X-Google-Smtp-Source: AGHT+IFaDOaEqqNBe1UroK3p61YxTYoNuFXY9PKeg6nqHR3YEjcz2ki9BeQL7StezZub2G/swYRPQw==
X-Received: by 2002:a05:6402:50cb:b0:5e7:8be5:d189 with SMTP id
 4fb4d7f45d1cf-5f02b19626amr3148857a12.4.1743523801767; 
 Tue, 01 Apr 2025 09:10:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17dff0bsm7197965a12.70.2025.04.01.09.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:10:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alban Bedel <alban.bedel@avionic-design.de>,
 Peter.Chubb@data61.csiro.au,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] ARM: tegra: board: set CFG_SYS_NS16550_COM1 according
 to TEGRA_ENABLE_UART
Date: Tue,  1 Apr 2025 19:09:47 +0300
Message-ID: <20250401160951.69056-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401160951.69056-1-clamor95@gmail.com>
References: <20250401160951.69056-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Link CFG_SYS_NS16550_COM1 value to chosen CONFIG_TEGRA_ENABLE_UART Tegra
wide. Remove all CFG_SYS_NS16550_COM1 from device headers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/board.c       | 5 +++++
 include/configs/apalis-tk1.h      | 3 ---
 include/configs/apalis_t30.h      | 1 -
 include/configs/beaver.h          | 3 ---
 include/configs/cardhu.h          | 3 ---
 include/configs/cei-tk1-som.h     | 3 ---
 include/configs/colibri_t20.h     | 4 ----
 include/configs/colibri_t30.h     | 1 -
 include/configs/dalmore.h         | 3 ---
 include/configs/endeavoru.h       | 3 ---
 include/configs/grouper.h         | 3 ---
 include/configs/harmony.h         | 9 ---------
 include/configs/ideapad-yoga-11.h | 3 ---
 include/configs/jetson-tk1.h      | 3 ---
 include/configs/medcom-wide.h     | 3 ---
 include/configs/mocha.h           | 3 ---
 include/configs/mot.h             | 3 ---
 include/configs/nyan-big.h        | 3 ---
 include/configs/ouya.h            | 3 ---
 include/configs/paz00.h           | 3 ---
 include/configs/picasso.h         | 3 ---
 include/configs/plutux.h          | 3 ---
 include/configs/qc750.h           | 3 ---
 include/configs/seaboard.h        | 3 ---
 include/configs/surface-rt.h      | 3 ---
 include/configs/tec-ng.h          | 3 ---
 include/configs/tec.h             | 3 ---
 include/configs/transformer-t20.h | 3 ---
 include/configs/transformer-t30.h | 3 ---
 include/configs/trimslice.h       | 3 ---
 include/configs/venice2.h         | 3 ---
 include/configs/ventana.h         | 3 ---
 include/configs/x3-t30.h          | 3 ---
 33 files changed, 5 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-tegra/board.c b/arch/arm/mach-tegra/board.c
index 7ca56a3b081..8c946f0f117 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -236,18 +236,23 @@ void board_init_uart_f(void)
 	int uart_ids = 0;	/* bit mask of which UART ids to enable */
 
 #ifdef CONFIG_TEGRA_ENABLE_UARTA
+#define CFG_SYS_NS16550_COM1	NV_PA_APB_UARTA_BASE
 	uart_ids |= UARTA;
 #endif
 #ifdef CONFIG_TEGRA_ENABLE_UARTB
+#define CFG_SYS_NS16550_COM1	NV_PA_APB_UARTB_BASE
 	uart_ids |= UARTB;
 #endif
 #ifdef CONFIG_TEGRA_ENABLE_UARTC
+#define CFG_SYS_NS16550_COM1	NV_PA_APB_UARTC_BASE
 	uart_ids |= UARTC;
 #endif
 #ifdef CONFIG_TEGRA_ENABLE_UARTD
+#define CFG_SYS_NS16550_COM1	NV_PA_APB_UARTD_BASE
 	uart_ids |= UARTD;
 #endif
 #ifdef CONFIG_TEGRA_ENABLE_UARTE
+#define CFG_SYS_NS16550_COM1	NV_PA_APB_UARTE_BASE
 	uart_ids |= UARTE;
 #endif
 	setup_uarts(uart_ids);
diff --git a/include/configs/apalis-tk1.h b/include/configs/apalis-tk1.h
index 4c690a17856..dbb9881f6ab 100644
--- a/include/configs/apalis-tk1.h
+++ b/include/configs/apalis-tk1.h
@@ -12,9 +12,6 @@
 
 #include "tegra124-common.h"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #define FDT_MODULE			"apalis-v1.2"
 #define FDT_MODULE_V1_0			"apalis"
 
diff --git a/include/configs/apalis_t30.h b/include/configs/apalis_t30.h
index 87a679efde6..c806ad0d9da 100644
--- a/include/configs/apalis_t30.h
+++ b/include/configs/apalis_t30.h
@@ -20,7 +20,6 @@
  * Apalis UART3: NVIDIA UARTB
  * Apalis UART4: NVIDIA UARTC
  */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
 #include "tegra-common-post.h"
 
diff --git a/include/configs/beaver.h b/include/configs/beaver.h
index e622b7127e3..229b766eefa 100644
--- a/include/configs/beaver.h
+++ b/include/configs/beaver.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Beaver"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/cardhu.h b/include/configs/cardhu.h
index 3412b883cbb..c33c96a5eb4 100644
--- a/include/configs/cardhu.h
+++ b/include/configs/cardhu.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Cardhu"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/cei-tk1-som.h b/include/configs/cei-tk1-som.h
index fbd38b77fe5..7b09441258c 100644
--- a/include/configs/cei-tk1-som.h
+++ b/include/configs/cei-tk1-som.h
@@ -18,9 +18,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"CEI tk1-som"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/colibri_t20.h b/include/configs/colibri_t20.h
index bc616d14368..d96a87c059e 100644
--- a/include/configs/colibri_t20.h
+++ b/include/configs/colibri_t20.h
@@ -9,10 +9,6 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/colibri_t30.h b/include/configs/colibri_t30.h
index 1f474669a73..0c93f377361 100644
--- a/include/configs/colibri_t30.h
+++ b/include/configs/colibri_t30.h
@@ -21,7 +21,6 @@
  * Colibri UART-B: NVIDIA UARTD
  * Colibri UART-C: NVIDIA UARTB
  */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
 
 #include "tegra-common-post.h"
 
diff --git a/include/configs/dalmore.h b/include/configs/dalmore.h
index 095554157fa..82911eb6165 100644
--- a/include/configs/dalmore.h
+++ b/include/configs/dalmore.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Dalmore"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 /* Environment in eMMC, at the end of 2nd "boot sector" */
 
 #include "tegra-common-post.h"
diff --git a/include/configs/endeavoru.h b/include/configs/endeavoru.h
index 33d0021ec13..20ffda0d251 100644
--- a/include/configs/endeavoru.h
+++ b/include/configs/endeavoru.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"HTC One X"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/grouper.h b/include/configs/grouper.h
index b6ef6ff2ecb..834e249d148 100644
--- a/include/configs/grouper.h
+++ b/include/configs/grouper.h
@@ -11,9 +11,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"ASUS Google Nexus 7 (2012)"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/harmony.h b/include/configs/harmony.h
index cae7acdb70b..793fdffb277 100644
--- a/include/configs/harmony.h
+++ b/include/configs/harmony.h
@@ -13,15 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Harmony"
 
-/* Board-specific serial config */
-
-/* UARTD: keyboard satellite board UART, default */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-#ifdef CONFIG_TEGRA_ENABLE_UARTA
-/* UARTA: debug board UART */
-#define CFG_SYS_NS16550_COM2		NV_PA_APB_UARTA_BASE
-#endif
-
 /* NAND support */
 
 /* Environment in NAND (which is 512M), aligned to start of last sector */
diff --git a/include/configs/ideapad-yoga-11.h b/include/configs/ideapad-yoga-11.h
index c4e6b2a647c..0f98f890ef7 100644
--- a/include/configs/ideapad-yoga-11.h
+++ b/include/configs/ideapad-yoga-11.h
@@ -11,9 +11,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Lenovo Ideapad Yoga 11"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/jetson-tk1.h b/include/configs/jetson-tk1.h
index 9858f8ff2b5..2fb1c353ff8 100644
--- a/include/configs/jetson-tk1.h
+++ b/include/configs/jetson-tk1.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Jetson TK1"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/medcom-wide.h b/include/configs/medcom-wide.h
index 8dbe741278a..7694a2fc84c 100644
--- a/include/configs/medcom-wide.h
+++ b/include/configs/medcom-wide.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Avionic Design Medcom-Wide"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 /* NAND support */
 
 /* Environment in NAND, aligned to start of last sector */
diff --git a/include/configs/mocha.h b/include/configs/mocha.h
index 1c2eb906085..a84d599ccc9 100644
--- a/include/configs/mocha.h
+++ b/include/configs/mocha.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Xiaomi Mocha"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
   #define CFG_PRAM                     0x38400 /* 225 MB */
 #endif
diff --git a/include/configs/mot.h b/include/configs/mot.h
index 63931e90dda..28b8d504769 100644
--- a/include/configs/mot.h
+++ b/include/configs/mot.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Motorola Mot"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTB_BASE
-
 /* Tegra common post configuration overwrites text env in the board */
 #define BOARD_EXTRA_ENV_SETTINGS \
 	"stdin=serial,tegra-kbc,button-kbd,cpcap-pwrbutton\0"
diff --git a/include/configs/nyan-big.h b/include/configs/nyan-big.h
index c04d402deb0..84db4bc3bca 100644
--- a/include/configs/nyan-big.h
+++ b/include/configs/nyan-big.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Google/NVIDIA Nyan-big"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/ouya.h b/include/configs/ouya.h
index cc86c1002e3..a9f05ae5d01 100644
--- a/include/configs/ouya.h
+++ b/include/configs/ouya.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Ouya Game Console"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/paz00.h b/include/configs/paz00.h
index 950b3217642..2d8d1f652bb 100644
--- a/include/configs/paz00.h
+++ b/include/configs/paz00.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Compal Paz00"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 /* Environment in eMMC, at the end of 2nd "boot sector" */
 
 #include "tegra-common-post.h"
diff --git a/include/configs/picasso.h b/include/configs/picasso.h
index a58c7e5f353..0b08a562018 100644
--- a/include/configs/picasso.h
+++ b/include/configs/picasso.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Acer Iconia Tab A500"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/plutux.h b/include/configs/plutux.h
index 30bfce9f503..5d7e85d9284 100644
--- a/include/configs/plutux.h
+++ b/include/configs/plutux.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Avionic Design Plutux"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 /* NAND support */
 
 /* Environment in NAND, aligned to start of last sector */
diff --git a/include/configs/qc750.h b/include/configs/qc750.h
index ad9f9146bb7..f226d5a4c08 100644
--- a/include/configs/qc750.h
+++ b/include/configs/qc750.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Wexler QC750"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/seaboard.h b/include/configs/seaboard.h
index 8e98620422d..79de9f83876 100644
--- a/include/configs/seaboard.h
+++ b/include/configs/seaboard.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Seaboard"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 /* Environment in eMMC, at the end of 2nd "boot sector" */
 
 /* NAND support */
diff --git a/include/configs/surface-rt.h b/include/configs/surface-rt.h
index 1f0837e179b..58be786ca77 100644
--- a/include/configs/surface-rt.h
+++ b/include/configs/surface-rt.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"Microsoft Surface RT"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/tec-ng.h b/include/configs/tec-ng.h
index 5e49abb49fa..4e610164fa3 100644
--- a/include/configs/tec-ng.h
+++ b/include/configs/tec-ng.h
@@ -12,9 +12,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Avionic Design Tamonten™ NG Evaluation Carrier"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/tec.h b/include/configs/tec.h
index 05dd7c96f61..cb10c0397f9 100644
--- a/include/configs/tec.h
+++ b/include/configs/tec.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Avionic Design Tamonten Evaluation Carrier"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 /* NAND support */
 
 /* Environment in NAND, aligned to start of last sector */
diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
index 6a3d9b24036..1876d2cdc69 100644
--- a/include/configs/transformer-t20.h
+++ b/include/configs/transformer-t20.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t30.h b/include/configs/transformer-t30.h
index 792b958a302..37828d3a9d9 100644
--- a/include/configs/transformer-t30.h
+++ b/include/configs/transformer-t30.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/trimslice.h b/include/configs/trimslice.h
index 7d1ff2afd14..c4f6defddbc 100644
--- a/include/configs/trimslice.h
+++ b/include/configs/trimslice.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"Compulab Trimslice"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 /* SPI */
 
 /* Environment in SPI */
diff --git a/include/configs/venice2.h b/include/configs/venice2.h
index 353b5ea67c1..fa001afdc0f 100644
--- a/include/configs/venice2.h
+++ b/include/configs/venice2.h
@@ -14,9 +14,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Venice2"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
-
 /* Environment in eMMC, at the end of 2nd "boot sector" */
 
 #include "tegra-common-post.h"
diff --git a/include/configs/ventana.h b/include/configs/ventana.h
index 1d9c60ca7c6..7a6e0254545 100644
--- a/include/configs/ventana.h
+++ b/include/configs/ventana.h
@@ -13,9 +13,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING	"NVIDIA Ventana"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 /* Environment in eMMC, at the end of 2nd "boot sector" */
 
 #include "tegra-common-post.h"
diff --git a/include/configs/x3-t30.h b/include/configs/x3-t30.h
index c152af9b7e2..286de6a3af4 100644
--- a/include/configs/x3-t30.h
+++ b/include/configs/x3-t30.h
@@ -15,9 +15,6 @@
 /* High-level configuration options */
 #define CFG_TEGRA_BOARD_STRING		"LG X3 Board"
 
-/* Board-specific serial config */
-#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
-- 
2.43.0

