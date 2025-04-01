Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A5C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8807781ECD;
	Tue,  1 Apr 2025 18:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WsrRgPsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1013682051; Tue,  1 Apr 2025 18:10:09 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0582A81F7E
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso10540364a12.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743523805; x=1744128605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SglPCMbJ7vpphWRDV9G+REgbV9Mcf3nAmteVau/tMb0=;
 b=WsrRgPsakg8uyMdx1ImdPf+Z+dsk51nwVZmFoIgWE30uF+CE3hDVVU4514bm3Cvfxw
 ieT5DQPYkBn/YhGj4/ajW4wd94J8X/w4RWJfiyJFCGNnhe+Q/1hKh4jPbkndufqBnk8R
 LVal2OYF3BEAiTvqd6BgBrzBe8M9z6DTHT6H7TTBE+kbhBK6aasZnp4kvVjETIdcWICA
 hXigEoCyooCJ5hYRmDLzI55X4pPR1Lcz99BndzduY2GN/ypttrGIJfS1QEfrGXoT9bAe
 PLn54Fvh26UVvB1NDp35EVdzzzhe5kbG+dpOjUdoyihu8LzpzDGmFE7Ue1IzWsuAndaZ
 /h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743523805; x=1744128605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SglPCMbJ7vpphWRDV9G+REgbV9Mcf3nAmteVau/tMb0=;
 b=wIzZM4U8HbKtAmYl0iQqcmeB3OZ3+vshxcskfnD5HZknz1CUJUmdxsLCrDkPB/64gZ
 f1SP9/l+UIydHcYfGUEaaG6uG5FgXA1Knt/dr0tPRY1tpg06/Lw6aM7qcgCzHBScmLqS
 mlnN7BGn0TWVGSeRVkkOEc62JgQfgWDr3aD+gt9ABo31oXT6mFgNGcCOplriOqN4N6I+
 TjpW0I6+8qp2fyTS3+7i7hZXz8pJ8EfqFV7UgBzyYtmbg+qz4PTJ5i+uh7UpKUmAtTgM
 dM7kQTJAy0TioHOxPOMZM4wHiCqTpvwzt6ELEwHntnTNX6v5OlYRdPbzN5SuG4YSB2jG
 EeqA==
X-Gm-Message-State: AOJu0YxUerZvav7xBfT0FlKbiX0WqHCQxKYP1G26nf+jk/UzMwmVG9mY
 NY8VsaFtBcNDDlzbhV0IbJyXyN2jH0zR0addmh5iEhoRssWelJbr
X-Gm-Gg: ASbGncs/r5TUQzEi1QlWSJ6uynzfbQpW7PChCRm76yp34hM0XQSDF5QvrCbeoiKz7TH
 O9DygZVA02BhiiCuNzyWujkHxq3jbu+K11HkjyAZaLXEqxa3g5hwcwCw3/3jS7+Y0e6q/KaeqYv
 CEqxQecd58RifR4rneS7/pxssGx0oEbfI38Mv1HVPxpNnpOrMKcA8W1tQAj4AQj8VpuVaX0ITK6
 oVNMDx55/ESoGG/EMXHsK7sXDecr7srmPHmpy167J+qTcgzU2wmKwsXmJlrw2xhC6pigcdF78Hf
 cOMy8sp+5tmDxcuZYFWIVROHsP6kfOJgRYGw
X-Google-Smtp-Source: AGHT+IGdDwJk81cRx3pON3DJxO6ow8GSirf9BStJbS5ulsy+16Q144fsq7P+fZnTxKcmmiwCChiBVg==
X-Received: by 2002:a05:6402:2709:b0:5e5:ca1b:c425 with SMTP id
 4fb4d7f45d1cf-5edfd101725mr11963243a12.17.1743523804756; 
 Tue, 01 Apr 2025 09:10:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17dff0bsm7197965a12.70.2025.04.01.09.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:10:04 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alban Bedel <alban.bedel@avionic-design.de>,
 Peter.Chubb@data61.csiro.au,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] ARM: tegra: replace per-device config headers with
 generic Tegra
Date: Tue,  1 Apr 2025 19:09:49 +0300
Message-ID: <20250401160951.69056-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401160951.69056-1-clamor95@gmail.com>
References: <20250401160951.69056-1-clamor95@gmail.com>
MIME-Version: 1.0
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

Most device headers contain SoC specific part and common Tegra post part.
Add a generic header which can be used by any Tegra device of one of the
supported SoC generations (T20, T30, T114, T124 or T210) without need in
device specific configuration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/acer/picasso/Kconfig                |  2 +-
 board/asus/grouper/Kconfig                |  2 +-
 board/asus/transformer-t20/Kconfig        |  2 +-
 board/asus/transformer-t30/Kconfig        |  2 +-
 board/avionic-design/medcom-wide/Kconfig  |  2 +-
 board/avionic-design/plutux/Kconfig       |  2 +-
 board/avionic-design/tec-ng/Kconfig       |  2 +-
 board/avionic-design/tec/Kconfig          |  2 +-
 board/cei/cei-tk1-som/Kconfig             |  2 +-
 board/compal/paz00/Kconfig                |  2 +-
 board/compulab/trimslice/Kconfig          |  2 +-
 board/htc/endeavoru/Kconfig               |  2 +-
 board/lenovo/ideapad-yoga-11/Kconfig      |  2 +-
 board/lg/x3-t30/Kconfig                   |  2 +-
 board/microsoft/surface-rt/Kconfig        |  2 +-
 board/nvidia/beaver/Kconfig               |  2 +-
 board/nvidia/cardhu/Kconfig               |  2 +-
 board/nvidia/dalmore/Kconfig              |  2 +-
 board/nvidia/harmony/Kconfig              |  2 +-
 board/nvidia/jetson-tk1/Kconfig           |  2 +-
 board/nvidia/nyan-big/Kconfig             |  2 +-
 board/nvidia/p2371-0000/Kconfig           |  2 +-
 board/nvidia/p2371-2180/Kconfig           |  2 +-
 board/nvidia/p2571/Kconfig                |  2 +-
 board/nvidia/p2771-0000/Kconfig           |  2 +-
 board/nvidia/p3450-0000/Kconfig           |  2 +-
 board/nvidia/seaboard/Kconfig             |  2 +-
 board/nvidia/venice2/Kconfig              |  2 +-
 board/nvidia/ventana/Kconfig              |  2 +-
 board/ouya/ouya/Kconfig                   |  2 +-
 board/toradex/apalis_t30/Kconfig          |  2 +-
 board/toradex/apalis_t30/apalis_t30.env   |  9 +++++++
 board/toradex/colibri_t20/Kconfig         |  2 +-
 board/toradex/colibri_t30/Kconfig         |  2 +-
 board/toradex/colibri_t30/colibri_t30.env |  8 ++++++
 board/wexler/qc750/Kconfig                |  2 +-
 include/configs/apalis_t30.h              | 26 ------------------
 include/configs/beaver.h                  | 14 ----------
 include/configs/cardhu.h                  | 14 ----------
 include/configs/cei-tk1-som.h             | 19 --------------
 include/configs/colibri_t20.h             | 14 ----------
 include/configs/colibri_t30.h             | 27 -------------------
 include/configs/dalmore.h                 | 14 ----------
 include/configs/endeavoru.h               | 16 ------------
 include/configs/grouper.h                 | 12 ---------
 include/configs/harmony.h                 | 14 ----------
 include/configs/ideapad-yoga-11.h         | 12 ---------
 include/configs/jetson-tk1.h              | 15 -----------
 include/configs/medcom-wide.h             | 15 -----------
 include/configs/nyan-big.h                | 15 -----------
 include/configs/ouya.h                    | 16 ------------
 include/configs/p2371-0000.h              | 15 -----------
 include/configs/p2371-2180.h              | 15 -----------
 include/configs/p2571.h                   | 15 -----------
 include/configs/p2771-0000.h              | 14 ----------
 include/configs/p3450-0000.h              | 14 ----------
 include/configs/paz00.h                   | 16 ------------
 include/configs/picasso.h                 | 16 ------------
 include/configs/plutux.h                  | 15 -----------
 include/configs/qc750.h                   | 16 ------------
 include/configs/seaboard.h                | 15 -----------
 include/configs/surface-rt.h              | 14 ----------
 include/configs/tec-ng.h                  | 13 ---------
 include/configs/tec.h                     | 15 -----------
 include/configs/tegra.h                   | 32 +++++++++++++++++++++++
 include/configs/transformer-t20.h         | 16 ------------
 include/configs/transformer-t30.h         | 16 ------------
 include/configs/trimslice.h               | 14 ----------
 include/configs/venice2.h                 | 15 -----------
 include/configs/ventana.h                 | 14 ----------
 include/configs/x3-t30.h                  | 16 ------------
 71 files changed, 83 insertions(+), 561 deletions(-)
 delete mode 100644 include/configs/apalis_t30.h
 delete mode 100644 include/configs/beaver.h
 delete mode 100644 include/configs/cardhu.h
 delete mode 100644 include/configs/cei-tk1-som.h
 delete mode 100644 include/configs/colibri_t20.h
 delete mode 100644 include/configs/colibri_t30.h
 delete mode 100644 include/configs/dalmore.h
 delete mode 100644 include/configs/endeavoru.h
 delete mode 100644 include/configs/grouper.h
 delete mode 100644 include/configs/harmony.h
 delete mode 100644 include/configs/ideapad-yoga-11.h
 delete mode 100644 include/configs/jetson-tk1.h
 delete mode 100644 include/configs/medcom-wide.h
 delete mode 100644 include/configs/nyan-big.h
 delete mode 100644 include/configs/ouya.h
 delete mode 100644 include/configs/p2371-0000.h
 delete mode 100644 include/configs/p2371-2180.h
 delete mode 100644 include/configs/p2571.h
 delete mode 100644 include/configs/p2771-0000.h
 delete mode 100644 include/configs/p3450-0000.h
 delete mode 100644 include/configs/paz00.h
 delete mode 100644 include/configs/picasso.h
 delete mode 100644 include/configs/plutux.h
 delete mode 100644 include/configs/qc750.h
 delete mode 100644 include/configs/seaboard.h
 delete mode 100644 include/configs/surface-rt.h
 delete mode 100644 include/configs/tec-ng.h
 delete mode 100644 include/configs/tec.h
 create mode 100644 include/configs/tegra.h
 delete mode 100644 include/configs/transformer-t20.h
 delete mode 100644 include/configs/transformer-t30.h
 delete mode 100644 include/configs/trimslice.h
 delete mode 100644 include/configs/venice2.h
 delete mode 100644 include/configs/ventana.h
 delete mode 100644 include/configs/x3-t30.h

diff --git a/board/acer/picasso/Kconfig b/board/acer/picasso/Kconfig
index c801bd26c7c..879b778aa53 100644
--- a/board/acer/picasso/Kconfig
+++ b/board/acer/picasso/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "acer"
 
 config SYS_CONFIG_NAME
-	default "picasso"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
index 5f25680d916..3bd712b274c 100644
--- a/board/asus/grouper/Kconfig
+++ b/board/asus/grouper/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "asus"
 
 config SYS_CONFIG_NAME
-	default "grouper"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/asus/transformer-t20/Kconfig b/board/asus/transformer-t20/Kconfig
index 2bf42825270..3e80d38d590 100644
--- a/board/asus/transformer-t20/Kconfig
+++ b/board/asus/transformer-t20/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "asus"
 
 config SYS_CONFIG_NAME
-	default "transformer-t20"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-t30/Kconfig
index 04278f139dc..34fd6f200f8 100644
--- a/board/asus/transformer-t30/Kconfig
+++ b/board/asus/transformer-t30/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "asus"
 
 config SYS_CONFIG_NAME
-	default "transformer-t30"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/avionic-design/medcom-wide/Kconfig b/board/avionic-design/medcom-wide/Kconfig
index 741fc258b3a..54474b5061a 100644
--- a/board/avionic-design/medcom-wide/Kconfig
+++ b/board/avionic-design/medcom-wide/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "avionic-design"
 
 config SYS_CONFIG_NAME
-	default "medcom-wide"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/avionic-design/plutux/Kconfig b/board/avionic-design/plutux/Kconfig
index 57324dc19e7..35b19dd2ea0 100644
--- a/board/avionic-design/plutux/Kconfig
+++ b/board/avionic-design/plutux/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "avionic-design"
 
 config SYS_CONFIG_NAME
-	default "plutux"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/avionic-design/tec-ng/Kconfig b/board/avionic-design/tec-ng/Kconfig
index 34e2729fd60..8782e7a2a67 100644
--- a/board/avionic-design/tec-ng/Kconfig
+++ b/board/avionic-design/tec-ng/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "avionic-design"
 
 config SYS_CONFIG_NAME
-	default "tec-ng"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/avionic-design/tec/Kconfig b/board/avionic-design/tec/Kconfig
index 56b417950eb..12cc4e1f4d0 100644
--- a/board/avionic-design/tec/Kconfig
+++ b/board/avionic-design/tec/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "avionic-design"
 
 config SYS_CONFIG_NAME
-	default "tec"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/cei/cei-tk1-som/Kconfig b/board/cei/cei-tk1-som/Kconfig
index 32ff61ac44d..9b944730e63 100644
--- a/board/cei/cei-tk1-som/Kconfig
+++ b/board/cei/cei-tk1-som/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "cei"
 
 config SYS_CONFIG_NAME
-	default "cei-tk1-som"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/compal/paz00/Kconfig b/board/compal/paz00/Kconfig
index 0ddac85be12..7fa47fc8c77 100644
--- a/board/compal/paz00/Kconfig
+++ b/board/compal/paz00/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "compal"
 
 config SYS_CONFIG_NAME
-	default "paz00"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/compulab/trimslice/Kconfig b/board/compulab/trimslice/Kconfig
index b26c2970fe4..226ebc228a8 100644
--- a/board/compulab/trimslice/Kconfig
+++ b/board/compulab/trimslice/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "compulab"
 
 config SYS_CONFIG_NAME
-	default "trimslice"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/htc/endeavoru/Kconfig b/board/htc/endeavoru/Kconfig
index f0967376647..ef50da9be45 100644
--- a/board/htc/endeavoru/Kconfig
+++ b/board/htc/endeavoru/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "htc"
 
 config SYS_CONFIG_NAME
-	default "endeavoru"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/lenovo/ideapad-yoga-11/Kconfig b/board/lenovo/ideapad-yoga-11/Kconfig
index 670a5bb700c..cd4aa32d86d 100644
--- a/board/lenovo/ideapad-yoga-11/Kconfig
+++ b/board/lenovo/ideapad-yoga-11/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "lenovo"
 
 config SYS_CONFIG_NAME
-	default "ideapad-yoga-11"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
index 5a3a67d9f3b..d2cdf860db4 100644
--- a/board/lg/x3-t30/Kconfig
+++ b/board/lg/x3-t30/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "lg"
 
 config SYS_CONFIG_NAME
-	default "x3-t30"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/microsoft/surface-rt/Kconfig b/board/microsoft/surface-rt/Kconfig
index 7c8f67f21cb..6afddb9b363 100644
--- a/board/microsoft/surface-rt/Kconfig
+++ b/board/microsoft/surface-rt/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "microsoft"
 
 config SYS_CONFIG_NAME
-	default "surface-rt"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/beaver/Kconfig b/board/nvidia/beaver/Kconfig
index be461214223..fe36d475b30 100644
--- a/board/nvidia/beaver/Kconfig
+++ b/board/nvidia/beaver/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "beaver"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/cardhu/Kconfig b/board/nvidia/cardhu/Kconfig
index 8a98ace70b5..92de3f2e669 100644
--- a/board/nvidia/cardhu/Kconfig
+++ b/board/nvidia/cardhu/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "cardhu"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/dalmore/Kconfig b/board/nvidia/dalmore/Kconfig
index 643e082ec06..8da3499b9f5 100644
--- a/board/nvidia/dalmore/Kconfig
+++ b/board/nvidia/dalmore/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "dalmore"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/harmony/Kconfig b/board/nvidia/harmony/Kconfig
index 1f2bfdfe5d8..eedee71cac9 100644
--- a/board/nvidia/harmony/Kconfig
+++ b/board/nvidia/harmony/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "harmony"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/jetson-tk1/Kconfig b/board/nvidia/jetson-tk1/Kconfig
index 7a2ffd83c84..9eeb55f639d 100644
--- a/board/nvidia/jetson-tk1/Kconfig
+++ b/board/nvidia/jetson-tk1/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "jetson-tk1"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/nyan-big/Kconfig b/board/nvidia/nyan-big/Kconfig
index b239d69f5e5..65fef3c063f 100644
--- a/board/nvidia/nyan-big/Kconfig
+++ b/board/nvidia/nyan-big/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "nyan-big"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/p2371-0000/Kconfig b/board/nvidia/p2371-0000/Kconfig
index 28e9f39045c..e2770781a25 100644
--- a/board/nvidia/p2371-0000/Kconfig
+++ b/board/nvidia/p2371-0000/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "p2371-0000"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/p2371-2180/Kconfig b/board/nvidia/p2371-2180/Kconfig
index ffb412229c1..8d97dc354b6 100644
--- a/board/nvidia/p2371-2180/Kconfig
+++ b/board/nvidia/p2371-2180/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "p2371-2180"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/p2571/Kconfig b/board/nvidia/p2571/Kconfig
index 1fc1978c639..1d41e9d68f4 100644
--- a/board/nvidia/p2571/Kconfig
+++ b/board/nvidia/p2571/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "p2571"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/p2771-0000/Kconfig b/board/nvidia/p2771-0000/Kconfig
index 52a22b79734..199e04da07e 100644
--- a/board/nvidia/p2771-0000/Kconfig
+++ b/board/nvidia/p2771-0000/Kconfig
@@ -11,7 +11,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "p2771-0000"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/p3450-0000/Kconfig b/board/nvidia/p3450-0000/Kconfig
index 48a94e24d54..9235c2a0c35 100644
--- a/board/nvidia/p3450-0000/Kconfig
+++ b/board/nvidia/p3450-0000/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "p3450-0000"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/seaboard/Kconfig b/board/nvidia/seaboard/Kconfig
index df62519c652..a6baeeb7f87 100644
--- a/board/nvidia/seaboard/Kconfig
+++ b/board/nvidia/seaboard/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "seaboard"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/venice2/Kconfig b/board/nvidia/venice2/Kconfig
index 7bd51c7a278..9ebaa2fa413 100644
--- a/board/nvidia/venice2/Kconfig
+++ b/board/nvidia/venice2/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "venice2"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/nvidia/ventana/Kconfig b/board/nvidia/ventana/Kconfig
index ea1146f75b7..b8654c24e0b 100644
--- a/board/nvidia/ventana/Kconfig
+++ b/board/nvidia/ventana/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "ventana"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/ouya/ouya/Kconfig b/board/ouya/ouya/Kconfig
index 2db127f3e14..c698f730412 100644
--- a/board/ouya/ouya/Kconfig
+++ b/board/ouya/ouya/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "ouya"
 
 config SYS_CONFIG_NAME
-	default "ouya"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/board/toradex/apalis_t30/Kconfig b/board/toradex/apalis_t30/Kconfig
index 9cd497091d6..6260f8eb7f4 100644
--- a/board/toradex/apalis_t30/Kconfig
+++ b/board/toradex/apalis_t30/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "toradex"
 
 config SYS_CONFIG_NAME
-	default "apalis_t30"
+	default "tegra"
 
 config TDX_CFG_BLOCK
 	default y
diff --git a/board/toradex/apalis_t30/apalis_t30.env b/board/toradex/apalis_t30/apalis_t30.env
index a8f2904bcd7..85d0a05d0e1 100644
--- a/board/toradex/apalis_t30/apalis_t30.env
+++ b/board/toradex/apalis_t30/apalis_t30.env
@@ -1,6 +1,15 @@
 uboot_hwpart=1
 uboot_blk=0
 
+/*
+ * Board-specific serial config
+ *
+ * Apalis UART1: NVIDIA UARTA
+ * Apalis UART2: NVIDIA UARTD
+ * Apalis UART3: NVIDIA UARTB
+ * Apalis UART4: NVIDIA UARTC
+ */
+
 set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff &&
 	setexpr blkcnt ${blkcnt} / 0x200
 update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} &&
diff --git a/board/toradex/colibri_t20/Kconfig b/board/toradex/colibri_t20/Kconfig
index a43acddb801..8a7295a41e2 100644
--- a/board/toradex/colibri_t20/Kconfig
+++ b/board/toradex/colibri_t20/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "toradex"
 
 config SYS_CONFIG_NAME
-	default "colibri_t20"
+	default "tegra"
 
 config TDX_CFG_BLOCK
 	default y
diff --git a/board/toradex/colibri_t30/Kconfig b/board/toradex/colibri_t30/Kconfig
index 68ef82b099d..643309fe856 100644
--- a/board/toradex/colibri_t30/Kconfig
+++ b/board/toradex/colibri_t30/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "toradex"
 
 config SYS_CONFIG_NAME
-	default "colibri_t30"
+	default "tegra"
 
 config TDX_CFG_BLOCK
 	default y
diff --git a/board/toradex/colibri_t30/colibri_t30.env b/board/toradex/colibri_t30/colibri_t30.env
index a8f2904bcd7..87919fbf155 100644
--- a/board/toradex/colibri_t30/colibri_t30.env
+++ b/board/toradex/colibri_t30/colibri_t30.env
@@ -1,6 +1,14 @@
 uboot_hwpart=1
 uboot_blk=0
 
+/*
+ * Board-specific serial config
+ *
+ * Colibri UART-A: NVIDIA UARTA
+ * Colibri UART-B: NVIDIA UARTD
+ * Colibri UART-C: NVIDIA UARTB
+ */
+
 set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff &&
 	setexpr blkcnt ${blkcnt} / 0x200
 update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} &&
diff --git a/board/wexler/qc750/Kconfig b/board/wexler/qc750/Kconfig
index 29943358b84..b449720a8b3 100644
--- a/board/wexler/qc750/Kconfig
+++ b/board/wexler/qc750/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "wexler"
 
 config SYS_CONFIG_NAME
-	default "qc750"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
diff --git a/include/configs/apalis_t30.h b/include/configs/apalis_t30.h
deleted file mode 100644
index c806ad0d9da..00000000000
--- a/include/configs/apalis_t30.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2014-2016 Marcel Ziswiler
- *
- * Configuration settings for the Toradex Apalis T30 modules.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra30-common.h"
-
-/*
- * Board-specific serial config
- *
- * Apalis UART1: NVIDIA UARTA
- * Apalis UART2: NVIDIA UARTD
- * Apalis UART3: NVIDIA UARTB
- * Apalis UART4: NVIDIA UARTC
- */
-
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/beaver.h b/include/configs/beaver.h
deleted file mode 100644
index 21b37b78a30..00000000000
--- a/include/configs/beaver.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/cardhu.h b/include/configs/cardhu.h
deleted file mode 100644
index 7fc2d85f7bd..00000000000
--- a/include/configs/cardhu.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/cei-tk1-som.h b/include/configs/cei-tk1-som.h
deleted file mode 100644
index aa4057d6da0..00000000000
--- a/include/configs/cei-tk1-som.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * (c) Copyright 2016, Data61
- * Commonwealth Scientific and Industrial Research Organisation (CSIRO)
- *
- * Based on jetson-tk1.h which is:
- * (C) Copyright 2013-2014
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra124-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/colibri_t20.h b/include/configs/colibri_t20.h
deleted file mode 100644
index d96a87c059e..00000000000
--- a/include/configs/colibri_t20.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2012 Lucas Stach
- *
- * Configuration settings for the Toradex Colibri T20 modules.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/colibri_t30.h b/include/configs/colibri_t30.h
deleted file mode 100644
index 0c93f377361..00000000000
--- a/include/configs/colibri_t30.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2013-2016 Stefan Agner
- *
- * Configuration settings for the Toradex Colibri T30 modules.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra30-common.h"
-
-/* High-level configuration options */
-
-/*
- * Board-specific serial config
- *
- * Colibri UART-A: NVIDIA UARTA
- * Colibri UART-B: NVIDIA UARTD
- * Colibri UART-C: NVIDIA UARTB
- */
-
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/dalmore.h b/include/configs/dalmore.h
deleted file mode 100644
index 0946588230d..00000000000
--- a/include/configs/dalmore.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra114-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/endeavoru.h b/include/configs/endeavoru.h
deleted file mode 100644
index 8cb3e414af2..00000000000
--- a/include/configs/endeavoru.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2012
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2022
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/grouper.h b/include/configs/grouper.h
deleted file mode 100644
index aacbcf12658..00000000000
--- a/include/configs/grouper.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/harmony.h b/include/configs/harmony.h
deleted file mode 100644
index beecb70cd0c..00000000000
--- a/include/configs/harmony.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010-2012
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/ideapad-yoga-11.h b/include/configs/ideapad-yoga-11.h
deleted file mode 100644
index aacbcf12658..00000000000
--- a/include/configs/ideapad-yoga-11.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/jetson-tk1.h b/include/configs/jetson-tk1.h
deleted file mode 100644
index e4ee5ce6be8..00000000000
--- a/include/configs/jetson-tk1.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * (C) Copyright 2013-2014
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra124-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/medcom-wide.h b/include/configs/medcom-wide.h
deleted file mode 100644
index becff398a56..00000000000
--- a/include/configs/medcom-wide.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- *  (C) Copyright 2011-2012
- *  Avionic Design GmbH <www.avionic-design.de>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/nyan-big.h b/include/configs/nyan-big.h
deleted file mode 100644
index 808cd908972..00000000000
--- a/include/configs/nyan-big.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2014
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra124-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/ouya.h b/include/configs/ouya.h
deleted file mode 100644
index 381941760e3..00000000000
--- a/include/configs/ouya.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2012
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2025
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/p2371-0000.h b/include/configs/p2371-0000.h
deleted file mode 100644
index 79240bd8ed0..00000000000
--- a/include/configs/p2371-0000.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2013-2015
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef _P2371_0000_H
-#define _P2371_0000_H
-
-#include <linux/sizes.h>
-
-#include "tegra210-common.h"
-#include "tegra-common-post.h"
-
-#endif /* _P2371_0000_H */
diff --git a/include/configs/p2371-2180.h b/include/configs/p2371-2180.h
deleted file mode 100644
index 24f3a7030e8..00000000000
--- a/include/configs/p2371-2180.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2013-2015
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef _P2371_2180_H
-#define _P2371_2180_H
-
-#include <linux/sizes.h>
-
-#include "tegra210-common.h"
-#include "tegra-common-post.h"
-
-#endif /* _P2371_2180_H */
diff --git a/include/configs/p2571.h b/include/configs/p2571.h
deleted file mode 100644
index 0dbb45e7c2a..00000000000
--- a/include/configs/p2571.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2013-2015
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef _P2571_H
-#define _P2571_H
-
-#include <linux/sizes.h>
-
-#include "tegra210-common.h"
-#include "tegra-common-post.h"
-
-#endif /* _P2571_H */
diff --git a/include/configs/p2771-0000.h b/include/configs/p2771-0000.h
deleted file mode 100644
index 914c68ffdf9..00000000000
--- a/include/configs/p2771-0000.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2013-2016, NVIDIA CORPORATION.
- */
-
-#ifndef _P2771_0000_H
-#define _P2771_0000_H
-
-#include <linux/sizes.h>
-
-#include "tegra186-common.h"
-#include "tegra-common-post.h"
-
-#endif
diff --git a/include/configs/p3450-0000.h b/include/configs/p3450-0000.h
deleted file mode 100644
index c5a74e8f8fe..00000000000
--- a/include/configs/p3450-0000.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2018-2019 NVIDIA Corporation.
- */
-
-#ifndef _P3450_0000_H
-#define _P3450_0000_H
-
-#include <linux/sizes.h>
-
-#include "tegra210-common.h"
-#include "tegra-common-post.h"
-
-#endif /* _P3450_0000_H */
diff --git a/include/configs/paz00.h b/include/configs/paz00.h
deleted file mode 100644
index ec123804545..00000000000
--- a/include/configs/paz00.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2012 NVIDIA CORPORATION.  All rights reserved.
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/picasso.h b/include/configs/picasso.h
deleted file mode 100644
index 4b6837dc000..00000000000
--- a/include/configs/picasso.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2024
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/plutux.h b/include/configs/plutux.h
deleted file mode 100644
index becff398a56..00000000000
--- a/include/configs/plutux.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- *  (C) Copyright 2011-2012
- *  Avionic Design GmbH <www.avionic-design.de>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/qc750.h b/include/configs/qc750.h
deleted file mode 100644
index 2acafb488b1..00000000000
--- a/include/configs/qc750.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2012
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2023
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/seaboard.h b/include/configs/seaboard.h
deleted file mode 100644
index 4a2c6623ac1..00000000000
--- a/include/configs/seaboard.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/surface-rt.h b/include/configs/surface-rt.h
deleted file mode 100644
index 39f7dddf3d4..00000000000
--- a/include/configs/surface-rt.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2021, Open Surface RT
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/tec-ng.h b/include/configs/tec-ng.h
deleted file mode 100644
index 3d6cb0b5257..00000000000
--- a/include/configs/tec-ng.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2013
- * Avionic Design GmbH <www.avionic-design.de>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/tec.h b/include/configs/tec.h
deleted file mode 100644
index becff398a56..00000000000
--- a/include/configs/tec.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- *  (C) Copyright 2011-2012
- *  Avionic Design GmbH <www.avionic-design.de>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/tegra.h b/include/configs/tegra.h
new file mode 100644
index 00000000000..0a880fdc1ec
--- /dev/null
+++ b/include/configs/tegra.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  (C) Copyright 2010,2011
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2025
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ *
+ *  Generic device header which can be used with SYS_CONFIG_NAME
+ *  for any Tegra device (T20, T30, T114, T124 or T210).
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/sizes.h>
+
+#ifdef CONFIG_TEGRA20
+#include "tegra20-common.h"
+#elif CONFIG_TEGRA30
+#include "tegra30-common.h"
+#elif CONFIG_TEGRA114
+#include "tegra114-common.h"
+#elif CONFIG_TEGRA124
+#include "tegra124-common.h"
+#elif CONFIG_TEGRA210
+#include "tegra210-common.h"
+#endif
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
deleted file mode 100644
index b82c6e34c8f..00000000000
--- a/include/configs/transformer-t20.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2022
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t30.h b/include/configs/transformer-t30.h
deleted file mode 100644
index 8cb3e414af2..00000000000
--- a/include/configs/transformer-t30.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2012
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2022
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/trimslice.h b/include/configs/trimslice.h
deleted file mode 100644
index beecb70cd0c..00000000000
--- a/include/configs/trimslice.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010-2012
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/venice2.h b/include/configs/venice2.h
deleted file mode 100644
index bbebe53d17e..00000000000
--- a/include/configs/venice2.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2013-2014
- * NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-
-#include "tegra124-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/ventana.h b/include/configs/ventana.h
deleted file mode 100644
index 00f9909b122..00000000000
--- a/include/configs/ventana.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010,2011
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/sizes.h>
-#include "tegra20-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/x3-t30.h b/include/configs/x3-t30.h
deleted file mode 100644
index 8cb3e414af2..00000000000
--- a/include/configs/x3-t30.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  (C) Copyright 2010,2012
- *  NVIDIA Corporation <www.nvidia.com>
- *
- *  (C) Copyright 2022
- *  Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra30-common.h"
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
-- 
2.43.0

