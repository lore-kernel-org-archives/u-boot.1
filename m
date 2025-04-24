Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D204C369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A65180FA8;
	Thu, 24 Apr 2025 10:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kfgk5Y5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C6D82063; Thu, 24 Apr 2025 10:29:23 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F2980F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30bfc79ad97so20548841fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745483360; x=1746088160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/YRV+ZSosK4lp0xTluVyXAibMfA7ewfDl4PT9HJv/w=;
 b=kfgk5Y5wr49JIW/tc54PA+hVSk6YJwMQRvrhG9NQNfTkdvAJKNnIADEnu1zQ+mno8p
 Pe8BjedKnuMmdyJh3HNCtL4GfkJ7uKfCLCu33ss6GQ5Fm1vnEHXr66r5VapKNhhP0Xz3
 nEw+LkHWWp7SJ9nwHhs7xtYClNZdQE7fsCeopSPwmo0624dbUWiD0D1MtpnwkjoaNARa
 43IO753fw37TUuxRerUzU/dfXX+ErLWe7EJ5jhTqodL2HyXP1a4JgS00PHM0tv0WF7OC
 wJjiHBFjQrrHAEi4JEB0kutJKa5eyFr7/9rGwOToxivCbFH7XlKS3iQkc1L38RTNlbT+
 vLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483360; x=1746088160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/YRV+ZSosK4lp0xTluVyXAibMfA7ewfDl4PT9HJv/w=;
 b=jFpLXqibOX3DhaHzoHAu+8bSVf4GbMpHTYYwUBH5djAS8YZtvvisDLpwxx80ufp7Bx
 X/rrBtgkmmF7q3tbyacT3VvUhvq8Z0IIJGVnIH7j0dyCXfFLDE11eRGdvN8t4xvOoGd2
 nsjSGhXpAn2Tb+UkLOSNL/j4YzvcI/BPYdu9zWsTetdKdNavoDbyMYSIzoKPryah9PRf
 4sZGbzVGKPsGRQsm5KQtP9mXClFqjAqkfHAm2eSmg1epGGughpxAjyWpdXMxTs43aSqh
 85SLyl3AAHtURv/wqjD688c92NiNYCPtmT9/jmBe074RSJxUuKI4h27PtaxIYmQXuR50
 iFsQ==
X-Gm-Message-State: AOJu0YwyztoAKZx1u3+m5aVy2saayKZCwUwyEsAbLNgUYk5HmqaD9HT3
 /X4FYuj5DDf6O8RRadstTtVsZ4sn0snkaKwFldScfLVOqpblEkJZ
X-Gm-Gg: ASbGnctkMvJjkSOLQN7Tud5+2d3+Qp7ubmd72HXxZBqZiHB0JNAGZDxL6kOl4q1HgsG
 6ml9InsyTH9mtvrsZ3mSr/D/OCnY4Px436hnyNsw4p4TgiQxnz+RlSEwzXjUg7sSzTjYRfPKVfM
 oEznKp8iEqL8RJuQpG+MUA700ZQ0D+5wDg+1UYYb3mSGAamf+idAYg0TBdcCzgKFj1Iv1L2mzB0
 9I3L1t1L7R86ud51HavwsrCJhUn8Pe7cvUAhYSGI7m2evhwRke7ARV86OlKD3xPWXHSybB7ZLOE
 Visf0p/Wa+F/Vgl3ADqPu/632BXpEuMP
X-Google-Smtp-Source: AGHT+IFF3hTRrrlqu58HbHB9kbpzkEFIZ/P+BpgnfYhuobVUtl5ZUtAXEUOKOFxFaJsWal6+RpCNlw==
X-Received: by 2002:a2e:800d:0:b0:30b:c9cb:47eb with SMTP id
 38308e7fff4ca-317cd63605dmr3690281fa.13.1745483359980; 
 Thu, 24 Apr 2025 01:29:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d16a832csm1627581fa.67.2025.04.24.01.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:29:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] ARM: tegra: set default SYS_CONFIG_NAME from SoC
 Kconfig
Date: Thu, 24 Apr 2025 11:28:32 +0300
Message-ID: <20250424082834.17538-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424082834.17538-1-clamor95@gmail.com>
References: <20250424082834.17538-1-clamor95@gmail.com>
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

Since most boards now use the same generic device config header, move its
setup to SoC Kconfig instead of setting SYS_CONFIG_NAME in each board's
Kconfig.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig              | 3 +++
 board/acer/picasso/Kconfig               | 3 ---
 board/asus/grouper/Kconfig               | 3 ---
 board/asus/transformer-t114/Kconfig      | 3 ---
 board/asus/transformer-t20/Kconfig       | 3 ---
 board/asus/transformer-t30/Kconfig       | 3 ---
 board/avionic-design/medcom-wide/Kconfig | 3 ---
 board/avionic-design/plutux/Kconfig      | 3 ---
 board/avionic-design/tec-ng/Kconfig      | 3 ---
 board/avionic-design/tec/Kconfig         | 3 ---
 board/cei/cei-tk1-som/Kconfig            | 3 ---
 board/compal/paz00/Kconfig               | 3 ---
 board/compulab/trimslice/Kconfig         | 3 ---
 board/htc/endeavoru/Kconfig              | 3 ---
 board/lenovo/ideapad-yoga-11/Kconfig     | 3 ---
 board/lg/star/Kconfig                    | 3 ---
 board/lg/x3-t30/Kconfig                  | 3 ---
 board/microsoft/surface-rt/Kconfig       | 3 ---
 board/nvidia/beaver/Kconfig              | 3 ---
 board/nvidia/cardhu/Kconfig              | 3 ---
 board/nvidia/dalmore/Kconfig             | 3 ---
 board/nvidia/harmony/Kconfig             | 3 ---
 board/nvidia/jetson-tk1/Kconfig          | 3 ---
 board/nvidia/nyan-big/Kconfig            | 3 ---
 board/nvidia/p2371-0000/Kconfig          | 3 ---
 board/nvidia/p2371-2180/Kconfig          | 3 ---
 board/nvidia/p2571/Kconfig               | 3 ---
 board/nvidia/p2771-0000/Kconfig          | 3 ---
 board/nvidia/p3450-0000/Kconfig          | 3 ---
 board/nvidia/seaboard/Kconfig            | 3 ---
 board/nvidia/tegratab/Kconfig            | 3 ---
 board/nvidia/venice2/Kconfig             | 3 ---
 board/nvidia/ventana/Kconfig             | 3 ---
 board/ouya/ouya/Kconfig                  | 3 ---
 board/toradex/apalis_t30/Kconfig         | 3 ---
 board/toradex/colibri_t20/Kconfig        | 3 ---
 board/toradex/colibri_t30/Kconfig        | 3 ---
 board/wexler/qc750/Kconfig               | 3 ---
 board/xiaomi/mocha/Kconfig               | 3 ---
 39 files changed, 3 insertions(+), 114 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 67bd2398bfd..c3c352eceb1 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -198,6 +198,9 @@ source "arch/arm/mach-tegra/tegra124/Kconfig"
 source "arch/arm/mach-tegra/tegra210/Kconfig"
 source "arch/arm/mach-tegra/tegra186/Kconfig"
 
+config SYS_CONFIG_NAME
+	default "tegra"
+
 config TEGRA_PRAM
 	select TEGRA_SUPPORT_NON_SECURE if TEGRA114 || TEGRA124
 	bool "Support reservation of the protected RAM"
diff --git a/board/acer/picasso/Kconfig b/board/acer/picasso/Kconfig
index 879b778aa53..947cd2b1f18 100644
--- a/board/acer/picasso/Kconfig
+++ b/board/acer/picasso/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "acer"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Acer Iconia Tab A500"
diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
index 3bd712b274c..82529908607 100644
--- a/board/asus/grouper/Kconfig
+++ b/board/asus/grouper/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "asus"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "ASUS Google Nexus 7 (2012)"
diff --git a/board/asus/transformer-t114/Kconfig b/board/asus/transformer-t114/Kconfig
index 2d7630422de..5c25ea82dde 100644
--- a/board/asus/transformer-t114/Kconfig
+++ b/board/asus/transformer-t114/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "asus"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "ASUS Transformer T114"
diff --git a/board/asus/transformer-t20/Kconfig b/board/asus/transformer-t20/Kconfig
index 3e80d38d590..3a06c79e4bf 100644
--- a/board/asus/transformer-t20/Kconfig
+++ b/board/asus/transformer-t20/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "asus"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "ASUS Transformer T20"
diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-t30/Kconfig
index 34fd6f200f8..dbbc3210528 100644
--- a/board/asus/transformer-t30/Kconfig
+++ b/board/asus/transformer-t30/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "asus"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "ASUS Transformer T30"
diff --git a/board/avionic-design/medcom-wide/Kconfig b/board/avionic-design/medcom-wide/Kconfig
index 54474b5061a..b2fbae639ca 100644
--- a/board/avionic-design/medcom-wide/Kconfig
+++ b/board/avionic-design/medcom-wide/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "avionic-design"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Avionic Design Medcom-Wide"
diff --git a/board/avionic-design/plutux/Kconfig b/board/avionic-design/plutux/Kconfig
index 35b19dd2ea0..cf9894cf0c6 100644
--- a/board/avionic-design/plutux/Kconfig
+++ b/board/avionic-design/plutux/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "avionic-design"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Avionic Design Plutux"
diff --git a/board/avionic-design/tec-ng/Kconfig b/board/avionic-design/tec-ng/Kconfig
index 8782e7a2a67..a410fdb9317 100644
--- a/board/avionic-design/tec-ng/Kconfig
+++ b/board/avionic-design/tec-ng/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "avionic-design"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Avionic Design Tamonten™ NG Evaluation Carrier"
diff --git a/board/avionic-design/tec/Kconfig b/board/avionic-design/tec/Kconfig
index 12cc4e1f4d0..ae4d1e24ffe 100644
--- a/board/avionic-design/tec/Kconfig
+++ b/board/avionic-design/tec/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "avionic-design"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Avionic Design Tamonten Evaluation Carrier"
diff --git a/board/cei/cei-tk1-som/Kconfig b/board/cei/cei-tk1-som/Kconfig
index 9b944730e63..ddaf8a7771f 100644
--- a/board/cei/cei-tk1-som/Kconfig
+++ b/board/cei/cei-tk1-som/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "cei"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "CEI tk1-som"
diff --git a/board/compal/paz00/Kconfig b/board/compal/paz00/Kconfig
index 7fa47fc8c77..ce2e381b7b0 100644
--- a/board/compal/paz00/Kconfig
+++ b/board/compal/paz00/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "compal"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Compal Paz00"
diff --git a/board/compulab/trimslice/Kconfig b/board/compulab/trimslice/Kconfig
index 226ebc228a8..b5a38359a54 100644
--- a/board/compulab/trimslice/Kconfig
+++ b/board/compulab/trimslice/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "compulab"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Compulab Trimslice"
diff --git a/board/htc/endeavoru/Kconfig b/board/htc/endeavoru/Kconfig
index ef50da9be45..d9734f00c2b 100644
--- a/board/htc/endeavoru/Kconfig
+++ b/board/htc/endeavoru/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "htc"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "HTC One X"
diff --git a/board/lenovo/ideapad-yoga-11/Kconfig b/board/lenovo/ideapad-yoga-11/Kconfig
index cd4aa32d86d..328ebe22280 100644
--- a/board/lenovo/ideapad-yoga-11/Kconfig
+++ b/board/lenovo/ideapad-yoga-11/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "lenovo"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Lenovo Ideapad Yoga 11"
diff --git a/board/lg/star/Kconfig b/board/lg/star/Kconfig
index 58523121750..7e50a4677f5 100644
--- a/board/lg/star/Kconfig
+++ b/board/lg/star/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "lg"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "LG Star"
diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
index d2cdf860db4..534c5aa97c1 100644
--- a/board/lg/x3-t30/Kconfig
+++ b/board/lg/x3-t30/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "lg"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "LG X3 Board"
diff --git a/board/microsoft/surface-rt/Kconfig b/board/microsoft/surface-rt/Kconfig
index 6afddb9b363..245284202cf 100644
--- a/board/microsoft/surface-rt/Kconfig
+++ b/board/microsoft/surface-rt/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "microsoft"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Microsoft Surface RT"
diff --git a/board/nvidia/beaver/Kconfig b/board/nvidia/beaver/Kconfig
index fe36d475b30..32f2918adc9 100644
--- a/board/nvidia/beaver/Kconfig
+++ b/board/nvidia/beaver/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Beaver"
diff --git a/board/nvidia/cardhu/Kconfig b/board/nvidia/cardhu/Kconfig
index 92de3f2e669..8081c9ac25a 100644
--- a/board/nvidia/cardhu/Kconfig
+++ b/board/nvidia/cardhu/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Cardhu"
diff --git a/board/nvidia/dalmore/Kconfig b/board/nvidia/dalmore/Kconfig
index 8da3499b9f5..a8d7f1c8ca6 100644
--- a/board/nvidia/dalmore/Kconfig
+++ b/board/nvidia/dalmore/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Dalmore"
diff --git a/board/nvidia/harmony/Kconfig b/board/nvidia/harmony/Kconfig
index eedee71cac9..dfbb71cdfd4 100644
--- a/board/nvidia/harmony/Kconfig
+++ b/board/nvidia/harmony/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Harmony"
diff --git a/board/nvidia/jetson-tk1/Kconfig b/board/nvidia/jetson-tk1/Kconfig
index 9eeb55f639d..c89eedf4562 100644
--- a/board/nvidia/jetson-tk1/Kconfig
+++ b/board/nvidia/jetson-tk1/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Jetson TK1"
diff --git a/board/nvidia/nyan-big/Kconfig b/board/nvidia/nyan-big/Kconfig
index 65fef3c063f..9c27c9a8351 100644
--- a/board/nvidia/nyan-big/Kconfig
+++ b/board/nvidia/nyan-big/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Google/NVIDIA Nyan-big"
diff --git a/board/nvidia/p2371-0000/Kconfig b/board/nvidia/p2371-0000/Kconfig
index e2770781a25..659b81775f0 100644
--- a/board/nvidia/p2371-0000/Kconfig
+++ b/board/nvidia/p2371-0000/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA P2371-0000"
diff --git a/board/nvidia/p2371-2180/Kconfig b/board/nvidia/p2371-2180/Kconfig
index 8d97dc354b6..07cd2406f84 100644
--- a/board/nvidia/p2371-2180/Kconfig
+++ b/board/nvidia/p2371-2180/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA P2371-2180"
diff --git a/board/nvidia/p2571/Kconfig b/board/nvidia/p2571/Kconfig
index 1d41e9d68f4..eb6e8016d91 100644
--- a/board/nvidia/p2571/Kconfig
+++ b/board/nvidia/p2571/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA P2571"
diff --git a/board/nvidia/p2771-0000/Kconfig b/board/nvidia/p2771-0000/Kconfig
index 199e04da07e..960e7015488 100644
--- a/board/nvidia/p2771-0000/Kconfig
+++ b/board/nvidia/p2771-0000/Kconfig
@@ -10,9 +10,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA P2771-0000"
diff --git a/board/nvidia/p3450-0000/Kconfig b/board/nvidia/p3450-0000/Kconfig
index 9235c2a0c35..eddf71f4073 100644
--- a/board/nvidia/p3450-0000/Kconfig
+++ b/board/nvidia/p3450-0000/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA P3450-0000"
diff --git a/board/nvidia/seaboard/Kconfig b/board/nvidia/seaboard/Kconfig
index a6baeeb7f87..f60a65676de 100644
--- a/board/nvidia/seaboard/Kconfig
+++ b/board/nvidia/seaboard/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Seaboard"
diff --git a/board/nvidia/tegratab/Kconfig b/board/nvidia/tegratab/Kconfig
index 25468bb57f5..a55c1c3810e 100644
--- a/board/nvidia/tegratab/Kconfig
+++ b/board/nvidia/tegratab/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA TegraTab"
diff --git a/board/nvidia/venice2/Kconfig b/board/nvidia/venice2/Kconfig
index 9ebaa2fa413..23d9d2ae39c 100644
--- a/board/nvidia/venice2/Kconfig
+++ b/board/nvidia/venice2/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Venice2"
diff --git a/board/nvidia/ventana/Kconfig b/board/nvidia/ventana/Kconfig
index b8654c24e0b..ae50f36a210 100644
--- a/board/nvidia/ventana/Kconfig
+++ b/board/nvidia/ventana/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "nvidia"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA Ventana"
diff --git a/board/ouya/ouya/Kconfig b/board/ouya/ouya/Kconfig
index c698f730412..24903c92bc0 100644
--- a/board/ouya/ouya/Kconfig
+++ b/board/ouya/ouya/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "ouya"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Ouya Game Console"
diff --git a/board/toradex/apalis_t30/Kconfig b/board/toradex/apalis_t30/Kconfig
index 6260f8eb7f4..f07fed94415 100644
--- a/board/toradex/apalis_t30/Kconfig
+++ b/board/toradex/apalis_t30/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "toradex"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TDX_CFG_BLOCK
 	default y
 
diff --git a/board/toradex/colibri_t20/Kconfig b/board/toradex/colibri_t20/Kconfig
index 8a7295a41e2..c8e3a14204b 100644
--- a/board/toradex/colibri_t20/Kconfig
+++ b/board/toradex/colibri_t20/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "toradex"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TDX_CFG_BLOCK
 	default y
 
diff --git a/board/toradex/colibri_t30/Kconfig b/board/toradex/colibri_t30/Kconfig
index 643309fe856..f3b7b8f6d90 100644
--- a/board/toradex/colibri_t30/Kconfig
+++ b/board/toradex/colibri_t30/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "toradex"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TDX_CFG_BLOCK
 	default y
 
diff --git a/board/wexler/qc750/Kconfig b/board/wexler/qc750/Kconfig
index b449720a8b3..b53beef9eb9 100644
--- a/board/wexler/qc750/Kconfig
+++ b/board/wexler/qc750/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "wexler"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Wexler QC750"
diff --git a/board/xiaomi/mocha/Kconfig b/board/xiaomi/mocha/Kconfig
index 3e1e076986c..11fd84fcd40 100644
--- a/board/xiaomi/mocha/Kconfig
+++ b/board/xiaomi/mocha/Kconfig
@@ -6,9 +6,6 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "xiaomi"
 
-config SYS_CONFIG_NAME
-	default "tegra"
-
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Xiaomi Mocha"
-- 
2.43.0

