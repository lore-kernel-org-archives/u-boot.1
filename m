Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF94C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 21:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7078829B;
	Sat, 30 Mar 2024 22:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoEh092Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA72882A0; Sat, 30 Mar 2024 22:03:49 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301018827E
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 22:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so963826a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711832625; x=1712437425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CTFdl/D/qPGgzR3fIA2Nmt6rzvd+1fk8N2lCmJ0xl1A=;
 b=OoEh092YioyT7AqasETo7IAwd646psr5onPH9L0Q4kAj34NKZRAqQTTszq7jBOQeOZ
 wipK1ehKHDhviak/Ta0JK3Lg1Vjt+CRfT3SDhsFUPEglq/NDw1QoIR6zMxdx/OCroSFX
 4SCFY6+gIQQLAyEFshEIk6+K9OiSXG/+BuZOa4v6Rfgk0q+IdO7yeoxUQUETJP6CJk+E
 hH+pQKHyb15JXdEHSDasuWgwfThxzbMEscEC7cRpDjKTB8JyiNPU4aXI4PxMKn6iyXdd
 DTinbdsM+rXPIz22CqDlg/L/SMr9/JVW10NpJKa5OC98H8lB/B8cciXr4WVReFe1XM6Y
 fGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711832625; x=1712437425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CTFdl/D/qPGgzR3fIA2Nmt6rzvd+1fk8N2lCmJ0xl1A=;
 b=NJTDXmhyKx8boribU5ExwmLJkWs2XO/em3kp/CR2mxaHaLTu2D+5+2OakU1Tar9rH3
 C+K83ZeQ0AfLC5vvUys1VURLnZLMMTy6rz1pWLdkGdYfhj5GbC8KaI7SSxMGcPJSysot
 qn41mLSQOduIezQ3ssbhu4lhodAAwWYQPxZ8SGoK//riNIlofw9ZIRRGJIqT2zsQ9p0O
 bKJ5Nechj/EGz4ygUjkBwZhLkxk7qBgizFCzqe2JsMhWf38T3pWHrlWgg/IyrtfjtVkH
 qHkBxzIc58WfXCHfa7WkTzrEF48r69r8De6+Puyinp7708INi1rCCqe6wYq4jOBPt2Je
 ZJDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE4rX72O9EV2JA1uC3bB9lLDIZpL9yLq4ymZy80BscswldCuw9drvsvMCXec5YstnIkgVkx4SLfQg+iyjvg4zJLFs+7A==
X-Gm-Message-State: AOJu0Yz8O2dSEMTMl1LSCZUZ/mS77OUK9pHyfPqj8Ee0QnKtBM68unBF
 6XF/adw2NQq9StkbZ7oRUMxMxy+93HoCmhhxtmmFrB/x65Jgfr1g
X-Google-Smtp-Source: AGHT+IGeLCrnPSczga/da2SOl6eRMc2Ez1dijm8RQ4CLYZ91auphT5Zxk3r1kHa4Ujb5OZFXlVx+ng==
X-Received: by 2002:a05:6a00:198c:b0:6ea:ba47:a63b with SMTP id
 d12-20020a056a00198c00b006eaba47a63bmr7004564pfl.0.1711832625525; 
 Sat, 30 Mar 2024 14:03:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3bdf:3f7c:9329:bd24])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5163666pfi.16.2024.03.30.14.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 14:03:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com,
 u-boot@lists.denx.de, cgmeiner@igalia.com
Subject: [PATCH v2] mx6cuboxi: Do not print devicetree model
Date: Sat, 30 Mar 2024 18:03:31 -0300
Message-Id: <20240330210331.2820862-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The mx6cuboxi_defconfig target supports several board
variants. All of these variants use the hummingboard devicetree in U-Boot.

Currently, the devicetree model as well as the board variant name
are shown:

...
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
Board: MX6 Cubox-i
...

Printing the devicetree model that is used internally by U-Boot
may confuse users.

Unselect the CONFIG_DISPLAY_BOARDINFO option so that only the
board name is printed in board_late_init() instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Remove checkboard and print the board name in board_late_init().

 board/solidrun/mx6cuboxi/mx6cuboxi.c | 40 ++++++----------------------
 configs/mx6cuboxi_defconfig          |  1 +
 2 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 8edabf4404c2..31d30cfbbd7b 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -381,37 +381,6 @@ static bool has_emmc(void)
 	return (mmc_get_op_cond(mmc, true) < 0) ? 0 : 1;
 }
 
-/* Override the default implementation, DT model is not accurate */
-int checkboard(void)
-{
-	request_detect_gpios();
-
-	switch (board_type()) {
-	case CUBOXI:
-		puts("Board: MX6 Cubox-i");
-		break;
-	case HUMMINGBOARD:
-		puts("Board: MX6 HummingBoard");
-		break;
-	case HUMMINGBOARD2:
-		puts("Board: MX6 HummingBoard2");
-		break;
-	case UNKNOWN:
-	default:
-		puts("Board: Unknown\n");
-		goto out;
-	}
-
-	if (is_rev_15_som())
-		puts(" (som rev 1.5)\n");
-	else
-		puts("\n");
-
-	free_detect_gpios();
-out:
-	return 0;
-}
-
 static int find_ethernet_phy(void)
 {
 	struct mii_dev *bus = NULL;
@@ -505,12 +474,15 @@ int board_late_init(void)
 	switch (board_type()) {
 	case CUBOXI:
 		env_set("board_name", "CUBOXI");
+		puts("Board: MX6 Cubox-i");
 		break;
 	case HUMMINGBOARD:
 		env_set("board_name", "HUMMINGBOARD");
+		puts("Board: MX6 HummingBoard");
 		break;
 	case HUMMINGBOARD2:
 		env_set("board_name", "HUMMINGBOARD2");
+		puts("Board: MX6 HummingBoard2");
 		break;
 	case UNKNOWN:
 	default:
@@ -522,8 +494,12 @@ int board_late_init(void)
 	else
 		env_set("board_rev", "MX6DL");
 
-	if (is_rev_15_som())
+	if (is_rev_15_som()) {
 		env_set("som_rev", "V15");
+		puts(" (som rev 1.5)\n");
+	} else {
+		puts("\n");
+	}
 
 	if (has_emmc())
 		env_set("has_emmc", "yes");
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index 27ceb22599a6..e3aba715aa58 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="if hdmidet; then usb start; setenv stdin  serial,usbkbd; setenv stdout serial,vidconsole; setenv stderr serial,vidconsole; else setenv stdin  serial; setenv stdout serial; setenv stderr serial; fi;"
 CONFIG_SYS_PBSIZE=532
+# CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
-- 
2.34.1

