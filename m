Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E18DC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 11:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3C287B66;
	Wed, 17 Jan 2024 12:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JWUimZ5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E966A878A5; Wed, 17 Jan 2024 12:14:12 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45AE87B67
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e741123acso13395964e87.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 03:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705490047; x=1706094847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBtd68KO61EeEygiGZlp1qwXarJjZbeV/YFS0ZUnw8k=;
 b=JWUimZ5pGxK8nZu68qDaAbEU9ciPtCxHz8kfIBLdE1zKXB1DNDaI2WQS70gkr8PhtK
 GGHiNhJypwphMwqZ0+4j6UP3aqDr8VOnU1aJLpWTcw2MQSWd6ZocfXumkwPqrml0gRzc
 CR6mnRY0sFT76RMRGOgkQIAYIikh3fXpdGXXvVA7nMF+QsB7G57CPyrUUg3K1B+9m8/a
 IVtTEsazwfiqQNHG4VcImVmNiQzSTNsXI4D3uszV97VCNAiqAHEEi9FVsecEbklBZh5n
 W99n9MogqipcT9yfYa5/Km93G2g7h+OunZ0x3qIsEaS3ZAsvzikvD97UjTIbYUzLmEJh
 XkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705490047; x=1706094847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBtd68KO61EeEygiGZlp1qwXarJjZbeV/YFS0ZUnw8k=;
 b=VAxDzO5xv9PuYpGg7ziw8fqdrLm3s96kyEfyh1/B4HUTj1himSKy/bokHFauRRC2Bp
 CwY1xrjvwx3Rr/eLcPociqdedO0xXBzPTXuXPSPk2veRQvbgykzx6lAJiMbAEHZAsM6w
 PNMiQCxcEVPfbG2ivcwnQs1RKRoU6viHqX2nlYTXx4lro4ZyuKPpiEqD3JdPfyp+XnTQ
 66VnOBz8Ed7iSWDuguuMG28qkDjBW9dvXtph0izMdyztPE9NgoaiAZ5+4Z99X1nrAViN
 cgCMTITuiILmJGPvJu+6d7mXGyP7rC1S5Enc8rqd4cUrzgHWvgpqgU1IUDwcgzlSDITz
 ElJw==
X-Gm-Message-State: AOJu0YwYxnyW0EczUdGe/+5J1P5rWkCCf6Ib+uh+QjnSol/Ahtru3wSm
 PYwgpPBMvYhXVd+VAoEb8V8=
X-Google-Smtp-Source: AGHT+IFLqcyaHBMkZfbvlcMmYXtr/EPC3gQ/iE7FeQiRPrw/91owxev54x8KHi/ZAJBlUoDxvzFraA==
X-Received: by 2002:a19:6519:0:b0:50e:b8d3:143e with SMTP id
 z25-20020a196519000000b0050eb8d3143emr3886558lfb.51.1705490046741; 
 Wed, 17 Jan 2024 03:14:06 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 eg42-20020a05640228aa00b00559b1b070a6sm1794111edb.32.2024.01.17.03.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 03:14:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 Thierry Reding <treding@nvidia.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: tegra30: switch to standard boot
Date: Wed, 17 Jan 2024 13:13:53 +0200
Message-Id: <20240117111353.219772-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117111353.219772-1-clamor95@gmail.com>
References: <20240117111353.219772-1-clamor95@gmail.com>
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

Switch transformer, endeavoru, grouper and x3_t30 boards
to bootflow scan.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/endeavoru_defconfig       | 2 +-
 configs/grouper_common_defconfig  | 2 +-
 configs/transformer_t30_defconfig | 2 +-
 configs/x3_t30_defconfig          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index f2c35e4f5f..7136a7e8f2 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -20,7 +20,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; bootflow scan; poweroff;"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 02ed8dbba9..6a1b719142 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -20,7 +20,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; bootflow scan; poweroff;"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index e4f76973eb..a142d82883 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -20,7 +20,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="setenv skip_boot 0; setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; if test ${skip_boot} -eq 1; then; else run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff; fi"
+CONFIG_BOOTCOMMAND="setenv skip_boot 0; setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; if test ${skip_boot} -eq 1; then; else setenv boot_targets usb mmc1 mmc0; bootflow scan; poweroff; fi"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 094a7d0709..b777d66653 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -21,7 +21,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; bootflow scan; poweroff;"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.40.1

