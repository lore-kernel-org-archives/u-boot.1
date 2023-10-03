Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C575E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF97187455;
	Tue,  3 Oct 2023 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F9yhnWGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F8587280; Tue,  3 Oct 2023 08:37:03 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160768724A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c27d653856so47160991fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315020; x=1696919820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2ciSo/hQAFJZlr9mvc1fYfNCqC4+KVsxGG+UwMXZV8=;
 b=F9yhnWGhkk5XaFmIV7cJ256O58Oc/tIggeV4MlcIR2Znse85AXvNlKmjQfD62Uj4oH
 iFM1CCta7kFaIN/66rHomSjbjStQot6VSBChrBeCkW8MOAjB1UNkn2MiTh03DEDSmkIr
 b4Y+g7ByF3mq99639osHJritjkmXtTmUWnSNT/RIwFNSlNqk1RSqZIZNxUFktxzU18Cu
 XKderWi4UguQWvVPtdutnsi2icaonPTKlIMhUEBSMUMEyhkNtcTwvFaC2al2gEHl2kgp
 /++T7CPQbT9ARN7uQMJzxxglasW/u2PjPkzjLL8zKdDt0SmL3cBH+pSPUcTftP4+HDuu
 grew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315020; x=1696919820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2ciSo/hQAFJZlr9mvc1fYfNCqC4+KVsxGG+UwMXZV8=;
 b=pPBAJY3JDuvVhee5cuUPhuQ+EHgvPQGQAh+aeJyuQOu3E/L5n5J80m+skEnn9ttb/3
 RD1kukcdkfcRBxyfrMxYKcsav75+OCL9ZnV0Nxd/676IljMiozm42YWfCxsn/DIC1Wlq
 cGp53L/lAGbvMoM0b2IF+Lu2AzGKpNY74jcquj+B5PsmsJAMlvQK8mFwXDRGKjsXcakl
 b/sxiVEZi0uRMyl9e/ENVnGFbRXzhqBqdEUeYrBnyTGoPvM/7TdoI+zLDzsWq1a8VeJN
 1rFAO86fCz0wQfHIw3RAPUOt12EQOjymx+Q+EPpINA3CaTL99/EMieBW5g6QezLRnw0H
 Ow2g==
X-Gm-Message-State: AOJu0Yy1GWPryEDfvbsOt6ZEVHcKvcqQFGDDy271BkUBXKENchXPU7Xy
 1dk8sZMMqbs4Pc/FrnxCGVQ=
X-Google-Smtp-Source: AGHT+IEYyB8Jvbe7Ej8TqsiPF7/KtwENCLhnYFjKkIahUGcLn62PaR7DBiVoslwo/YCYw6mINT7GEQ==
X-Received: by 2002:a05:6512:2150:b0:502:9fce:b6e6 with SMTP id
 s16-20020a056512215000b005029fceb6e6mr1199624lfr.1.1696315020320; 
 Mon, 02 Oct 2023 23:37:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 06/16] configs: transformer_t30: convert bootmenu option
Date: Tue,  3 Oct 2023 09:36:37 +0300
Message-Id: <20231003063647.42770-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

Convert refresh USB to enter console. Transformers have full size
USB and a dock keyboard so access to U-Boot console would be handy.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/transformer_t30_defconfig    | 2 +-
 include/configs/transformer-common.h | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 0f83ae7247..6050d26a05 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -20,7 +20,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv skip_boot 0; setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; if test ${skip_boot} -eq 1; then; else run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff; fi"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/include/configs/transformer-common.h b/include/configs/transformer-common.h
index dcdda1ec5b..3b7db0ab14 100644
--- a/include/configs/transformer-common.h
+++ b/include/configs/transformer-common.h
@@ -64,19 +64,14 @@
 		"else echo SPI flash backup FAILED! Aborting ...;" \
 			"poweroff; fi\0"
 
-#define TRANSFORMER_REFRESH_USB \
-	"refresh_usb=usb start; usb reset; usb tree; usb info;" \
-		"pause 'Press ANY key to return to bootmenu...'; bootmenu\0"
-
 #define TRANSFORMER_BOOTMENU \
 	TRANSFORMER_FLASH_UBOOT \
 	TRANSFORMER_FLASH_SPI \
-	TRANSFORMER_REFRESH_USB \
 	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
 	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
 	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
 	"bootmenu_3=update bootloader=run flash_uboot\0" \
-	"bootmenu_4=refresh USB=run refresh_usb\0" \
+	"bootmenu_4=enter console=usb start; setenv skip_boot 1; exit\0" \
 	"bootmenu_5=reboot RCM=enterrcm\0" \
 	"bootmenu_6=reboot=reset\0" \
 	"bootmenu_7=power off=poweroff\0" \
-- 
2.39.2

