Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A313DC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B60381F4D;
	Tue,  1 Apr 2025 18:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JvdoWDmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D89481FC0; Tue,  1 Apr 2025 18:10:07 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CBB81F4D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so10828948a12.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743523803; x=1744128603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3lhOPtDXv/fa4I/zIoed7lVAkEC9eg8M1S6eOEgTeY=;
 b=JvdoWDmojbYiPLZRrWE4D0UJZ5+SjLNntR+M8e7Gf3sfIhr725Ar+ILJf61c18aJPe
 DvwCa6unhsoxwir7Ra3jrpdeSeX5eUkMJ3faEv+jNiXcy8sudjO6Zjim5iFKbgEoPxZq
 Bp50wM8sZ9lPq8jGWX8KkPJNcZboLnZOaVAejmJDrWypHK8/Y4CsPhQtOyfauTiPrzmd
 rOj3UBwdEyZ+w897EqUJ5vwXSqSkGVXmS/BD2JiAKjuiB2TEf8z+GgLVc9flbRL0p/SH
 WTBUxL/QCQawqUV9mGj4Wr2QhqMnCCJT1R1Caicoje5Tg9qz1C5owQQvq7OfqAdngxpR
 xXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743523803; x=1744128603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3lhOPtDXv/fa4I/zIoed7lVAkEC9eg8M1S6eOEgTeY=;
 b=e12PGMpdrt1P4z4d4xkkUhyCdpW06MdWUjBuVCm+yPG+EOZn4nvx+uhTwFBRpev6A2
 OHPEh0c9OAkKZdxG733exoJSvjrYjjA6C3V69zrH5cyDNFQOWMIFIQfmBJZ/GLRFhCsv
 seKEtejKpAG44H010MaSuaiyfsciUpGv5dxs7CdbLlhPsHlpzJuRYTiDpsp3YnxgzNK7
 clL/HDfpKKMBcKuKl3OBo9tAgQs0W5SnEJs616/bal1ocowBQxhQxfT0jEgeB/HtaDXa
 896ybdhcSi+x7IDHlcLkJg726lA8sDPjUT6tEeE+OLl2scJkDaNpu+oZrtAcnAXTvU2b
 SkmQ==
X-Gm-Message-State: AOJu0YwZVHpuEfQJ/aeBd8zr/R1YZDtdS7f69YjKdbtBW0zMSU6HHGFy
 51jCTEy/dfwaFmI1owgskPpW12p5I/GjAPyLu1sIqGcK2VzoGTXn0YmOqhMH
X-Gm-Gg: ASbGncsRdnyXXnp+edIaOACdF2eouUTH7Y3DR5T3QScjfASHTpgjDeE+5ZTCdhZD/MS
 WsqGbnLI5tET6LlGos2Dk7jhlfwzBAQ4/qEGFn3LwgDRJtjwstSSpN/AgVkX+LViqSbze6XHnJq
 iJr+BNol4WR6401b+v5gKJZb0GgBtFVOwVJ3902ZTd6ZXyWoKLzxhM0ojCQJ8XT1ygFltrhgtIm
 lU/bnoZZhYAvGm2oj/rAWZpiMyCF+t5tvFFdfkXH6W+aQkdwPgxtyYTQSGW4JssUkk/gcgjb1Fs
 VmiVCMLQrqJ+QqgRMsBg8EllhHAPp5VZ9v2z
X-Google-Smtp-Source: AGHT+IEZbWhJqCXRjPCmwBok6vqIJIsPSJNUS7bbaHRny5wyF7PXNPEwhdGB47mA57qUcjD1h3eQTQ==
X-Received: by 2002:a05:6402:51ce:b0:5ec:f769:cfa1 with SMTP id
 4fb4d7f45d1cf-5edfdd155cfmr9848374a12.29.1743523803181; 
 Tue, 01 Apr 2025 09:10:03 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17dff0bsm7197965a12.70.2025.04.01.09.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:10:02 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alban Bedel <alban.bedel@avionic-design.de>,
 Peter.Chubb@data61.csiro.au,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] ARM: tegra: convert CFG_TEGRA_BOARD_STRING into
 Kconfig option
Date: Tue,  1 Apr 2025 19:09:48 +0300
Message-ID: <20250401160951.69056-3-clamor95@gmail.com>
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

Convert CFG_TEGRA_BOARD_STRING into Kconfig option and move it into device
board Kconfig.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/board2.c             |  2 +-
 board/acer/picasso/Kconfig               |  4 ++++
 board/asus/grouper/Kconfig               |  4 ++++
 board/asus/transformer-t20/Kconfig       |  4 ++++
 board/asus/transformer-t30/Kconfig       |  4 ++++
 board/avionic-design/medcom-wide/Kconfig |  4 ++++
 board/avionic-design/plutux/Kconfig      |  4 ++++
 board/avionic-design/tec-ng/Kconfig      |  4 ++++
 board/avionic-design/tec/Kconfig         |  4 ++++
 board/cei/cei-tk1-som/Kconfig            |  4 ++++
 board/compal/paz00/Kconfig               |  4 ++++
 board/compulab/trimslice/Kconfig         |  4 ++++
 board/htc/endeavoru/Kconfig              |  4 ++++
 board/lenovo/ideapad-yoga-11/Kconfig     |  4 ++++
 board/lg/x3-t30/Kconfig                  |  4 ++++
 board/microsoft/surface-rt/Kconfig       |  4 ++++
 board/motorola/mot/Kconfig               |  4 ++++
 board/nvidia/beaver/Kconfig              |  4 ++++
 board/nvidia/cardhu/Kconfig              |  4 ++++
 board/nvidia/dalmore/Kconfig             |  4 ++++
 board/nvidia/harmony/Kconfig             |  4 ++++
 board/nvidia/jetson-tk1/Kconfig          |  4 ++++
 board/nvidia/nyan-big/Kconfig            |  4 ++++
 board/nvidia/p2371-0000/Kconfig          |  4 ++++
 board/nvidia/p2371-2180/Kconfig          |  4 ++++
 board/nvidia/p2571/Kconfig               |  4 ++++
 board/nvidia/p2771-0000/Kconfig          |  4 ++++
 board/nvidia/p3450-0000/Kconfig          |  4 ++++
 board/nvidia/seaboard/Kconfig            |  4 ++++
 board/nvidia/venice2/Kconfig             |  4 ++++
 board/nvidia/ventana/Kconfig             |  4 ++++
 board/ouya/ouya/Kconfig                  |  4 ++++
 board/wexler/qc750/Kconfig               |  4 ++++
 board/xiaomi/mocha/Kconfig               |  4 ++++
 include/configs/beaver.h                 |  4 ----
 include/configs/cardhu.h                 |  4 ----
 include/configs/cei-tk1-som.h            |  4 ----
 include/configs/dalmore.h                |  6 ------
 include/configs/endeavoru.h              |  4 ----
 include/configs/grouper.h                |  4 ----
 include/configs/harmony.h                |  8 --------
 include/configs/ideapad-yoga-11.h        |  4 ----
 include/configs/jetson-tk1.h             |  4 ----
 include/configs/medcom-wide.h            |  8 --------
 include/configs/mocha.h                  |  3 ---
 include/configs/mot.h                    |  3 ---
 include/configs/nyan-big.h               |  4 ----
 include/configs/ouya.h                   |  4 ----
 include/configs/p2371-0000.h             |  8 --------
 include/configs/p2371-2180.h             |  8 --------
 include/configs/p2571.h                  |  8 --------
 include/configs/p2771-0000.h             |  6 ------
 include/configs/p3450-0000.h             |  7 -------
 include/configs/paz00.h                  |  6 ------
 include/configs/picasso.h                |  4 ----
 include/configs/plutux.h                 |  8 --------
 include/configs/qc750.h                  |  4 ----
 include/configs/seaboard.h               | 10 ----------
 include/configs/surface-rt.h             |  4 ----
 include/configs/tec-ng.h                 |  4 ----
 include/configs/tec.h                    |  8 --------
 include/configs/transformer-t20.h        |  4 ----
 include/configs/transformer-t30.h        |  4 ----
 include/configs/trimslice.h              |  9 ---------
 include/configs/venice2.h                |  6 ------
 include/configs/ventana.h                |  6 ------
 include/configs/x3-t30.h                 |  4 ----
 67 files changed, 133 insertions(+), 183 deletions(-)

diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 6e9ef68caf9..68534dcbb22 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -96,7 +96,7 @@ int checkboard(void)
 {
 	int board_id = tegra_board_id();
 
-	printf("Board: %s", CFG_TEGRA_BOARD_STRING);
+	printf("Board: %s", CONFIG_TEGRA_BOARD_STRING);
 	if (board_id != -1)
 		printf(", ID: %d\n", board_id);
 	printf("\n");
diff --git a/board/acer/picasso/Kconfig b/board/acer/picasso/Kconfig
index 73c0aa08508..c801bd26c7c 100644
--- a/board/acer/picasso/Kconfig
+++ b/board/acer/picasso/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "picasso"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Acer Iconia Tab A500"
+
 endif
diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
index f935cce4225..5f25680d916 100644
--- a/board/asus/grouper/Kconfig
+++ b/board/asus/grouper/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "grouper"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "ASUS Google Nexus 7 (2012)"
+
 endif
diff --git a/board/asus/transformer-t20/Kconfig b/board/asus/transformer-t20/Kconfig
index d5fe4128289..2bf42825270 100644
--- a/board/asus/transformer-t20/Kconfig
+++ b/board/asus/transformer-t20/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "transformer-t20"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "ASUS Transformer T20"
+
 endif
diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-t30/Kconfig
index 915436ba6c5..04278f139dc 100644
--- a/board/asus/transformer-t30/Kconfig
+++ b/board/asus/transformer-t30/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "transformer-t30"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "ASUS Transformer T30"
+
 endif
diff --git a/board/avionic-design/medcom-wide/Kconfig b/board/avionic-design/medcom-wide/Kconfig
index 267647cb41f..741fc258b3a 100644
--- a/board/avionic-design/medcom-wide/Kconfig
+++ b/board/avionic-design/medcom-wide/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "medcom-wide"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Avionic Design Medcom-Wide"
+
 endif
diff --git a/board/avionic-design/plutux/Kconfig b/board/avionic-design/plutux/Kconfig
index 09a3ac940da..57324dc19e7 100644
--- a/board/avionic-design/plutux/Kconfig
+++ b/board/avionic-design/plutux/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "plutux"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Avionic Design Plutux"
+
 endif
diff --git a/board/avionic-design/tec-ng/Kconfig b/board/avionic-design/tec-ng/Kconfig
index 36a0cec1be1..34e2729fd60 100644
--- a/board/avionic-design/tec-ng/Kconfig
+++ b/board/avionic-design/tec-ng/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "tec-ng"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Avionic Design Tamonten™ NG Evaluation Carrier"
+
 endif
diff --git a/board/avionic-design/tec/Kconfig b/board/avionic-design/tec/Kconfig
index bc9751b1086..56b417950eb 100644
--- a/board/avionic-design/tec/Kconfig
+++ b/board/avionic-design/tec/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "tec"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Avionic Design Tamonten Evaluation Carrier"
+
 endif
diff --git a/board/cei/cei-tk1-som/Kconfig b/board/cei/cei-tk1-som/Kconfig
index 5fcb51f2f26..32ff61ac44d 100644
--- a/board/cei/cei-tk1-som/Kconfig
+++ b/board/cei/cei-tk1-som/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "cei-tk1-som"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "CEI tk1-som"
+
 endif
diff --git a/board/compal/paz00/Kconfig b/board/compal/paz00/Kconfig
index 30ba11d360a..0ddac85be12 100644
--- a/board/compal/paz00/Kconfig
+++ b/board/compal/paz00/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "paz00"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Compal Paz00"
+
 endif
diff --git a/board/compulab/trimslice/Kconfig b/board/compulab/trimslice/Kconfig
index 35769140347..b26c2970fe4 100644
--- a/board/compulab/trimslice/Kconfig
+++ b/board/compulab/trimslice/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "trimslice"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Compulab Trimslice"
+
 endif
diff --git a/board/htc/endeavoru/Kconfig b/board/htc/endeavoru/Kconfig
index 0b72c4a687d..f0967376647 100644
--- a/board/htc/endeavoru/Kconfig
+++ b/board/htc/endeavoru/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "endeavoru"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "HTC One X"
+
 endif
diff --git a/board/lenovo/ideapad-yoga-11/Kconfig b/board/lenovo/ideapad-yoga-11/Kconfig
index 67644409fc1..670a5bb700c 100644
--- a/board/lenovo/ideapad-yoga-11/Kconfig
+++ b/board/lenovo/ideapad-yoga-11/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "ideapad-yoga-11"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Lenovo Ideapad Yoga 11"
+
 endif
diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
index 53b6ab3e93c..5a3a67d9f3b 100644
--- a/board/lg/x3-t30/Kconfig
+++ b/board/lg/x3-t30/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "x3-t30"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "LG X3 Board"
+
 endif
diff --git a/board/microsoft/surface-rt/Kconfig b/board/microsoft/surface-rt/Kconfig
index 9e66897f6b1..7c8f67f21cb 100644
--- a/board/microsoft/surface-rt/Kconfig
+++ b/board/microsoft/surface-rt/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "surface-rt"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Microsoft Surface RT"
+
 endif
diff --git a/board/motorola/mot/Kconfig b/board/motorola/mot/Kconfig
index 8b76165ade7..3f6f03e95b5 100644
--- a/board/motorola/mot/Kconfig
+++ b/board/motorola/mot/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "mot"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Motorola Mot"
+
 endif
diff --git a/board/nvidia/beaver/Kconfig b/board/nvidia/beaver/Kconfig
index 23f7c945f57..be461214223 100644
--- a/board/nvidia/beaver/Kconfig
+++ b/board/nvidia/beaver/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "beaver"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Beaver"
+
 endif
diff --git a/board/nvidia/cardhu/Kconfig b/board/nvidia/cardhu/Kconfig
index 63ace66aa78..8a98ace70b5 100644
--- a/board/nvidia/cardhu/Kconfig
+++ b/board/nvidia/cardhu/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "cardhu"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Cardhu"
+
 endif
diff --git a/board/nvidia/dalmore/Kconfig b/board/nvidia/dalmore/Kconfig
index 96eaa01cf87..643e082ec06 100644
--- a/board/nvidia/dalmore/Kconfig
+++ b/board/nvidia/dalmore/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "dalmore"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Dalmore"
+
 endif
diff --git a/board/nvidia/harmony/Kconfig b/board/nvidia/harmony/Kconfig
index 328c94677da..1f2bfdfe5d8 100644
--- a/board/nvidia/harmony/Kconfig
+++ b/board/nvidia/harmony/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "harmony"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Harmony"
+
 endif
diff --git a/board/nvidia/jetson-tk1/Kconfig b/board/nvidia/jetson-tk1/Kconfig
index d90a74ea382..7a2ffd83c84 100644
--- a/board/nvidia/jetson-tk1/Kconfig
+++ b/board/nvidia/jetson-tk1/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "jetson-tk1"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Jetson TK1"
+
 endif
diff --git a/board/nvidia/nyan-big/Kconfig b/board/nvidia/nyan-big/Kconfig
index 341c8d75c21..b239d69f5e5 100644
--- a/board/nvidia/nyan-big/Kconfig
+++ b/board/nvidia/nyan-big/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "nyan-big"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Google/NVIDIA Nyan-big"
+
 endif
diff --git a/board/nvidia/p2371-0000/Kconfig b/board/nvidia/p2371-0000/Kconfig
index f94be12be1a..28e9f39045c 100644
--- a/board/nvidia/p2371-0000/Kconfig
+++ b/board/nvidia/p2371-0000/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "p2371-0000"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA P2371-0000"
+
 endif
diff --git a/board/nvidia/p2371-2180/Kconfig b/board/nvidia/p2371-2180/Kconfig
index 8622bdaa16b..ffb412229c1 100644
--- a/board/nvidia/p2371-2180/Kconfig
+++ b/board/nvidia/p2371-2180/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "p2371-2180"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA P2371-2180"
+
 endif
diff --git a/board/nvidia/p2571/Kconfig b/board/nvidia/p2571/Kconfig
index 7bc48748408..1fc1978c639 100644
--- a/board/nvidia/p2571/Kconfig
+++ b/board/nvidia/p2571/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "p2571"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA P2571"
+
 endif
diff --git a/board/nvidia/p2771-0000/Kconfig b/board/nvidia/p2771-0000/Kconfig
index 1b1116f0209..52a22b79734 100644
--- a/board/nvidia/p2771-0000/Kconfig
+++ b/board/nvidia/p2771-0000/Kconfig
@@ -13,4 +13,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "p2771-0000"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA P2771-0000"
+
 endif
diff --git a/board/nvidia/p3450-0000/Kconfig b/board/nvidia/p3450-0000/Kconfig
index 7a08cd88675..48a94e24d54 100644
--- a/board/nvidia/p3450-0000/Kconfig
+++ b/board/nvidia/p3450-0000/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "p3450-0000"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA P3450-0000"
+
 endif
diff --git a/board/nvidia/seaboard/Kconfig b/board/nvidia/seaboard/Kconfig
index 0924bde480f..df62519c652 100644
--- a/board/nvidia/seaboard/Kconfig
+++ b/board/nvidia/seaboard/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "seaboard"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Seaboard"
+
 endif
diff --git a/board/nvidia/venice2/Kconfig b/board/nvidia/venice2/Kconfig
index 6905f0014ea..7bd51c7a278 100644
--- a/board/nvidia/venice2/Kconfig
+++ b/board/nvidia/venice2/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "venice2"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Venice2"
+
 endif
diff --git a/board/nvidia/ventana/Kconfig b/board/nvidia/ventana/Kconfig
index c1ad7b76712..ea1146f75b7 100644
--- a/board/nvidia/ventana/Kconfig
+++ b/board/nvidia/ventana/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "ventana"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "NVIDIA Ventana"
+
 endif
diff --git a/board/ouya/ouya/Kconfig b/board/ouya/ouya/Kconfig
index 6bab40ce933..2db127f3e14 100644
--- a/board/ouya/ouya/Kconfig
+++ b/board/ouya/ouya/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "ouya"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Ouya Game Console"
+
 endif
diff --git a/board/wexler/qc750/Kconfig b/board/wexler/qc750/Kconfig
index 45a1e5e057b..29943358b84 100644
--- a/board/wexler/qc750/Kconfig
+++ b/board/wexler/qc750/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "qc750"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Wexler QC750"
+
 endif
diff --git a/board/xiaomi/mocha/Kconfig b/board/xiaomi/mocha/Kconfig
index 25c61d4169e..bb53cc56161 100644
--- a/board/xiaomi/mocha/Kconfig
+++ b/board/xiaomi/mocha/Kconfig
@@ -9,4 +9,8 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "mocha"
 
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Xiaomi Mocha"
+
 endif
diff --git a/include/configs/beaver.h b/include/configs/beaver.h
index 229b766eefa..21b37b78a30 100644
--- a/include/configs/beaver.h
+++ b/include/configs/beaver.h
@@ -9,10 +9,6 @@
 #include <linux/sizes.h>
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Beaver"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/cardhu.h b/include/configs/cardhu.h
index c33c96a5eb4..7fc2d85f7bd 100644
--- a/include/configs/cardhu.h
+++ b/include/configs/cardhu.h
@@ -9,10 +9,6 @@
 #include <linux/sizes.h>
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Cardhu"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/cei-tk1-som.h b/include/configs/cei-tk1-som.h
index 7b09441258c..aa4057d6da0 100644
--- a/include/configs/cei-tk1-som.h
+++ b/include/configs/cei-tk1-som.h
@@ -14,10 +14,6 @@
 #include <linux/sizes.h>
 
 #include "tegra124-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"CEI tk1-som"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/dalmore.h b/include/configs/dalmore.h
index 82911eb6165..0946588230d 100644
--- a/include/configs/dalmore.h
+++ b/include/configs/dalmore.h
@@ -9,12 +9,6 @@
 #include <linux/sizes.h>
 
 #include "tegra114-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Dalmore"
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/endeavoru.h b/include/configs/endeavoru.h
index 20ffda0d251..8cb3e414af2 100644
--- a/include/configs/endeavoru.h
+++ b/include/configs/endeavoru.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"HTC One X"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/grouper.h b/include/configs/grouper.h
index 834e249d148..aacbcf12658 100644
--- a/include/configs/grouper.h
+++ b/include/configs/grouper.h
@@ -7,10 +7,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"ASUS Google Nexus 7 (2012)"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/harmony.h b/include/configs/harmony.h
index 793fdffb277..beecb70cd0c 100644
--- a/include/configs/harmony.h
+++ b/include/configs/harmony.h
@@ -9,14 +9,6 @@
 
 #include <linux/sizes.h>
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Harmony"
-
-/* NAND support */
-
-/* Environment in NAND (which is 512M), aligned to start of last sector */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/ideapad-yoga-11.h b/include/configs/ideapad-yoga-11.h
index 0f98f890ef7..aacbcf12658 100644
--- a/include/configs/ideapad-yoga-11.h
+++ b/include/configs/ideapad-yoga-11.h
@@ -7,10 +7,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Lenovo Ideapad Yoga 11"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/jetson-tk1.h b/include/configs/jetson-tk1.h
index 2fb1c353ff8..e4ee5ce6be8 100644
--- a/include/configs/jetson-tk1.h
+++ b/include/configs/jetson-tk1.h
@@ -10,10 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra124-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Jetson TK1"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/medcom-wide.h b/include/configs/medcom-wide.h
index 7694a2fc84c..becff398a56 100644
--- a/include/configs/medcom-wide.h
+++ b/include/configs/medcom-wide.h
@@ -10,14 +10,6 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Avionic Design Medcom-Wide"
-
-/* NAND support */
-
-/* Environment in NAND, aligned to start of last sector */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/mocha.h b/include/configs/mocha.h
index a84d599ccc9..7255f31baec 100644
--- a/include/configs/mocha.h
+++ b/include/configs/mocha.h
@@ -10,9 +10,6 @@
 
 #include "tegra124-common.h"
 
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Xiaomi Mocha"
-
 #ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
   #define CFG_PRAM                     0x38400 /* 225 MB */
 #endif
diff --git a/include/configs/mot.h b/include/configs/mot.h
index 28b8d504769..018672cb28f 100644
--- a/include/configs/mot.h
+++ b/include/configs/mot.h
@@ -10,9 +10,6 @@
 #include <linux/sizes.h>
 #include "tegra20-common.h"
 
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Motorola Mot"
-
 /* Tegra common post configuration overwrites text env in the board */
 #define BOARD_EXTRA_ENV_SETTINGS \
 	"stdin=serial,tegra-kbc,button-kbd,cpcap-pwrbutton\0"
diff --git a/include/configs/nyan-big.h b/include/configs/nyan-big.h
index 84db4bc3bca..808cd908972 100644
--- a/include/configs/nyan-big.h
+++ b/include/configs/nyan-big.h
@@ -10,10 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra124-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Google/NVIDIA Nyan-big"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/ouya.h b/include/configs/ouya.h
index a9f05ae5d01..381941760e3 100644
--- a/include/configs/ouya.h
+++ b/include/configs/ouya.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Ouya Game Console"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/p2371-0000.h b/include/configs/p2371-0000.h
index a29d7135d0b..79240bd8ed0 100644
--- a/include/configs/p2371-0000.h
+++ b/include/configs/p2371-0000.h
@@ -10,14 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra210-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA P2371-0000"
-
-/* Board-specific serial config */
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* _P2371_0000_H */
diff --git a/include/configs/p2371-2180.h b/include/configs/p2371-2180.h
index 0b077aba659..24f3a7030e8 100644
--- a/include/configs/p2371-2180.h
+++ b/include/configs/p2371-2180.h
@@ -10,14 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra210-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA P2371-2180"
-
-/* Board-specific serial config */
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* _P2371_2180_H */
diff --git a/include/configs/p2571.h b/include/configs/p2571.h
index 5155aa7b1dd..0dbb45e7c2a 100644
--- a/include/configs/p2571.h
+++ b/include/configs/p2571.h
@@ -10,14 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra210-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA P2571"
-
-/* Board-specific serial config */
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* _P2571_H */
diff --git a/include/configs/p2771-0000.h b/include/configs/p2771-0000.h
index fc1b7c0302d..914c68ffdf9 100644
--- a/include/configs/p2771-0000.h
+++ b/include/configs/p2771-0000.h
@@ -9,12 +9,6 @@
 #include <linux/sizes.h>
 
 #include "tegra186-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA P2771-0000"
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif
diff --git a/include/configs/p3450-0000.h b/include/configs/p3450-0000.h
index 1138c1d306f..c5a74e8f8fe 100644
--- a/include/configs/p3450-0000.h
+++ b/include/configs/p3450-0000.h
@@ -9,13 +9,6 @@
 #include <linux/sizes.h>
 
 #include "tegra210-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA P3450-0000"
-
-/* Board-specific serial config */
-
-/* General networking support */
 #include "tegra-common-post.h"
 
 #endif /* _P3450_0000_H */
diff --git a/include/configs/paz00.h b/include/configs/paz00.h
index 2d8d1f652bb..ec123804545 100644
--- a/include/configs/paz00.h
+++ b/include/configs/paz00.h
@@ -11,12 +11,6 @@
 
 #include <linux/sizes.h>
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Compal Paz00"
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/picasso.h b/include/configs/picasso.h
index 0b08a562018..4b6837dc000 100644
--- a/include/configs/picasso.h
+++ b/include/configs/picasso.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Acer Iconia Tab A500"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/plutux.h b/include/configs/plutux.h
index 5d7e85d9284..becff398a56 100644
--- a/include/configs/plutux.h
+++ b/include/configs/plutux.h
@@ -10,14 +10,6 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Avionic Design Plutux"
-
-/* NAND support */
-
-/* Environment in NAND, aligned to start of last sector */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/qc750.h b/include/configs/qc750.h
index f226d5a4c08..2acafb488b1 100644
--- a/include/configs/qc750.h
+++ b/include/configs/qc750.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Wexler QC750"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/seaboard.h b/include/configs/seaboard.h
index 79de9f83876..4a2c6623ac1 100644
--- a/include/configs/seaboard.h
+++ b/include/configs/seaboard.h
@@ -10,16 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Seaboard"
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
-/* NAND support */
-
-/* Max number of NAND devices */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/surface-rt.h b/include/configs/surface-rt.h
index 58be786ca77..39f7dddf3d4 100644
--- a/include/configs/surface-rt.h
+++ b/include/configs/surface-rt.h
@@ -9,10 +9,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"Microsoft Surface RT"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/tec-ng.h b/include/configs/tec-ng.h
index 4e610164fa3..3d6cb0b5257 100644
--- a/include/configs/tec-ng.h
+++ b/include/configs/tec-ng.h
@@ -8,10 +8,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Avionic Design Tamonten™ NG Evaluation Carrier"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/tec.h b/include/configs/tec.h
index cb10c0397f9..becff398a56 100644
--- a/include/configs/tec.h
+++ b/include/configs/tec.h
@@ -10,14 +10,6 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Avionic Design Tamonten Evaluation Carrier"
-
-/* NAND support */
-
-/* Environment in NAND, aligned to start of last sector */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
index 1876d2cdc69..b82c6e34c8f 100644
--- a/include/configs/transformer-t20.h
+++ b/include/configs/transformer-t20.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t30.h b/include/configs/transformer-t30.h
index 37828d3a9d9..8cb3e414af2 100644
--- a/include/configs/transformer-t30.h
+++ b/include/configs/transformer-t30.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/trimslice.h b/include/configs/trimslice.h
index c4f6defddbc..beecb70cd0c 100644
--- a/include/configs/trimslice.h
+++ b/include/configs/trimslice.h
@@ -9,15 +9,6 @@
 
 #include <linux/sizes.h>
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"Compulab Trimslice"
-
-/* SPI */
-
-/* Environment in SPI */
-/* 1MiB flash, environment located as high as possible */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/venice2.h b/include/configs/venice2.h
index fa001afdc0f..bbebe53d17e 100644
--- a/include/configs/venice2.h
+++ b/include/configs/venice2.h
@@ -10,12 +10,6 @@
 #include <linux/sizes.h>
 
 #include "tegra124-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Venice2"
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/ventana.h b/include/configs/ventana.h
index 7a6e0254545..00f9909b122 100644
--- a/include/configs/ventana.h
+++ b/include/configs/ventana.h
@@ -9,12 +9,6 @@
 
 #include <linux/sizes.h>
 #include "tegra20-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING	"NVIDIA Ventana"
-
-/* Environment in eMMC, at the end of 2nd "boot sector" */
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/x3-t30.h b/include/configs/x3-t30.h
index 286de6a3af4..8cb3e414af2 100644
--- a/include/configs/x3-t30.h
+++ b/include/configs/x3-t30.h
@@ -11,10 +11,6 @@
 #define __CONFIG_H
 
 #include "tegra30-common.h"
-
-/* High-level configuration options */
-#define CFG_TEGRA_BOARD_STRING		"LG X3 Board"
-
 #include "tegra-common-post.h"
 
 #endif /* __CONFIG_H */
-- 
2.43.0

