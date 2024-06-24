Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CABEC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA0F882B7;
	Mon, 24 Jun 2024 14:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ApYY2r5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687BF882BE; Mon, 24 Jun 2024 14:33:17 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2729888137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d044aa5beso4759002a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719232394; x=1719837194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=16leo386kdyQHDuibzMPERFxISztzEmMgENhPhboQTk=;
 b=ApYY2r5sOuVfncUwm9msrjLYL1aFHCF3L3pqcr9YO+LpY1+equee4t5RMp21B9WYta
 Hnez09xSt6cd5mTkL7BTRbC7up6OBqVmx7ZUzcPE+PIuFK7q0vJW2kwjnhHCkAw1fc2D
 kNuiWtUUcuFtnE5wfZdMytat5lnU2Gy48udSv7s7BgBmS4ejTXY9jOYZTOFXY9JFRGZF
 MS6BOnBL7z5VPODgnv7Vc4IOwwO8gZi411Vmv1hKBdrvsFu/sLsNVqmDjqeC6devXUL9
 HT+663epxQES13NsulhVxPe7GjD3GmMJCcRf7tduYRHcPmsh5PvdrcpJrcJbaYjVkbu+
 IHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719232394; x=1719837194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16leo386kdyQHDuibzMPERFxISztzEmMgENhPhboQTk=;
 b=Y1nIW9oAsTeLqfD4/mPSM91YPDb33VxhABNtXggnI76qZFYH4aqXyCCqQfMMLhep/I
 dIS2AFpYAgmZaIBeD6oU02Rveu8UmesJytJSd/rxQ+QPGIS/nivjQYU8EPFho8qdskYA
 WTwUPIpRIq55kUt42O8Rbqc84PtaruXoq0EKRAiCicvOpd6fTPoaIyDmCbk8IbbbFJkv
 7uB50Yr/seyi+mvUofrdSlWWQO4Tjm4RhKeYUpe+HcbtBLotkYHCCOQLnyKBurXqi6vf
 lrnM9Mrsi6LDMZbmcNdAT0KHQZ0GyAE/qHcNOKNwY8SlSLW0gAdvUZYZWWutVR1ivINN
 wiOA==
X-Gm-Message-State: AOJu0Yx+dn2MREjOvx7ilgVfnFb9/V1AnrjjG3E67R4iJf720wSoRnhT
 ehqPuzSc88jfFxZEg3wZEeCfhQMYKG6JnYQOb36+32bR+QtOb68Sw3Gt1UcJ5ww=
X-Google-Smtp-Source: AGHT+IEUIpxoLuBv3jVLheTsiQgggFqECaoRbnSe7QBkKNKHeMTQHCnChjPhV2GwMn+h2HGCHgpZ1A==
X-Received: by 2002:a50:8e54:0:b0:57c:745d:110b with SMTP id
 4fb4d7f45d1cf-57d4bd56bd6mr2825884a12.3.1719232394485; 
 Mon, 24 Jun 2024 05:33:14 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30427976sm4654929a12.33.2024.06.24.05.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 05:33:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH v2] mach-snapdragon: move default environment to a file
Date: Mon, 24 Jun 2024 14:31:59 +0200
Message-ID: <20240624123255.2590424-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
environment to a file under board/qualcomm.

This is much cleaner and means we don't need to recompile on changing
the environment.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v1:
- Don't set bootfile
- V1: https://lore.kernel.org/u-boot/20240617085629.1744017-1-caleb.connolly@linaro.org
---
 board/qualcomm/default.env | 11 +++++++++++
 configs/qcom_defconfig     |  2 ++
 include/configs/qcom.h     | 16 ----------------
 3 files changed, 13 insertions(+), 16 deletions(-)
 create mode 100644 board/qualcomm/default.env

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
new file mode 100644
index 000000000000..dbf6f4e72600
--- /dev/null
+++ b/board/qualcomm/default.env
@@ -0,0 +1,11 @@
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+preboot=scsi scan; usb start
+fastboot=fastboot -l $fastboot_addr_r usb 0
+do_boot=bootefi bootmgr
+bootmenu_0=Boot first available device=run do_boot
+bootmenu_1=Enable fastboot mode=run fastboot
+bootmenu_2=Reset device=reset
+menucmd=bootmenu
+bootcmd=run do_boot
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 25fa8b0f7d2b..4ff280fc6e7d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -46,8 +46,10 @@ CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+CONFIG_USE_DEFAULT_ENV_FILE=y
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
 CONFIG_CLK=y
 CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
diff --git a/include/configs/qcom.h b/include/configs/qcom.h
index c13a847f62f1..b7d38866c51d 100644
--- a/include/configs/qcom.h
+++ b/include/configs/qcom.h
@@ -10,21 +10,5 @@
 #define __CONFIGS_SNAPDRAGON_H
 
 #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600, 3000000 }
 
-/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
-#define CFG_EXTRA_ENV_SETTINGS \
-	"stdin=serial,button-kbd\0"	\
-	"stdout=serial,vidconsole\0"	\
-	"stderr=serial,vidconsole\0" \
-	"bootfile=/extlinux/extlinux.conf\0" \
-	"preboot=scsi scan; usb start\0" \
-	"fastboot=fastboot -l $fastboot_addr_r usb 0\0" \
-	"do_boot=bootefi bootmgr\0" \
-	"bootmenu_0=Boot first available device=run do_boot\0" \
-	"bootmenu_1=Enable USB mass storage=ums 0 scsi 0,1,2,3,4,5\0" \
-	"bootmenu_2=Enable fastboot mode=run fastboot\0" \
-	"bootmenu_3=Reset device=reset\0" \
-	"menucmd=bootmenu\0" \
-	"bootcmd=run do_boot\0" /* first entry is default */
-
 #endif
-- 
2.45.0

