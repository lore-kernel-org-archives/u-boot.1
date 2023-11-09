Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD3FC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3A187450;
	Thu,  9 Nov 2023 17:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dw5CmeYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2808729D; Thu,  9 Nov 2023 17:25:20 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF8786F73
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 17:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1ead2e6fab7so583885fac.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699547116; x=1700151916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6pEXbF8u/dwVylyO5B2NRu7SLCmCb+jjPjF7chkBTM=;
 b=Dw5CmeYrLVHGKPG1Lw9Vc/g5t8Jlbg8pJx3KSYPx8bAU+9fZw52uqEPKOQBE9Aw4Sg
 ztooEszG9Sp0vzsgiSgy2L8geEMjZ3QTx4EV6rixNMn+HwV921omipfpmLbIQ5ArV6bQ
 ynS5mPAydsK4VMD3Bbp2rp/QMZrz4dwnzahuQEGeK5z4YptlWU2BxyTKngt4uvQW/qf1
 L9SBRG/19+QF4wHJ+O5E3lp2I37+rZecVDZon6bhExWQO3w0gSM6JBwzs3/qkmHTsY+V
 /iSHdplzM4RJwy5kO8D64XE0gP8l2xHhycfp1A7L/q8Ev3WZivseoNnoP/7+TeqbIBJW
 3E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699547116; x=1700151916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6pEXbF8u/dwVylyO5B2NRu7SLCmCb+jjPjF7chkBTM=;
 b=J3sPIFUzSLJsj49RCVcAZDWH+N9h4Ysp4lqGJVl/srvLv4Kza7ZT1A02dE1dCtV2fe
 19e6hkxa/yO9qwOT1TMzYS9eUXXJqe57wN6XVqcIMWSFI54Tx72GbjIqAv8yzve7IeZq
 1BvBckN+rTPhe7uXOyV/Zgn+cdUEhpWy0VYQtPz1uydalnxdKCOLzFEnk+SCNkzLUYAF
 55W08NAodRnCb1R6ml0fWdK6DSQfU+46x+PaIUqFndnqM4o7IiyIN2FMAmSNe3HY5Gpx
 CnuTyGVZSQxU9+UQ3WqA671nXRw7h6XF9qItZYaq2TRb9gblWfKTZJN+Aw6zYZOmCgc0
 bLPA==
X-Gm-Message-State: AOJu0YzpX4uqK5E6dZ7OKGxcfXHhaKq7SrT4frz1C+FQHgUCiAT5jUy7
 57Wntd0V/iB8CixOu0wnvYI=
X-Google-Smtp-Source: AGHT+IGl3k6cA2nLYqu6noJDgs2ZktgHgPDw5h6AIxlkRkxijNhoBOu6qapHYPuRbe7yAmOvHM5FdQ==
X-Received: by 2002:a05:6870:f81a:b0:1e9:97eb:15a with SMTP id
 fr26-20020a056870f81a00b001e997eb015amr6388893oab.36.1699547115848; 
 Thu, 09 Nov 2023 08:25:15 -0800 (PST)
Received: from debianfranco.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056a0015ce00b006c345e192cfsm10908304pfu.119.2023.11.09.08.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:25:15 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
X-Google-Original-From: Hiago De Franco <hiago.franco@toradex.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: u-boot@lists.denx.de,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 2/2] board: apalis/colibri imx6/imx6ull/imx7: Add fastboot
 bootcmd support
Date: Thu,  9 Nov 2023 13:24:01 -0300
Message-ID: <20231109162401.38941-3-hiago.franco@toradex.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109162401.38941-1-hiago.franco@toradex.com>
References: <20231109162401.38941-1-hiago.franco@toradex.com>
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

This commit adds support for Fastboot boot commands by checking both
CONFIG_CMD_USB_SDP and CONFIG_USB_FUNCTION_FASTBOOT. If either of these
configurations is set, it indicates that the board is in recovery mode
and can use either SDP or Fastboot.

The default option remains the SDP command, but if
CONFIG_CMD_FASTBOOT is set, it changes to 'fastboot usb 0' as
the boot command.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 board/toradex/apalis_imx6/apalis_imx6.c         | 13 ++++++++-----
 board/toradex/colibri-imx6ull/colibri-imx6ull.c | 13 ++++++++-----
 board/toradex/colibri_imx6/colibri_imx6.c       | 13 ++++++++-----
 board/toradex/colibri_imx7/colibri_imx7.c       | 14 +++++++++-----
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index fa6b7226fe..6fc14b5858 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -701,13 +701,16 @@ int board_late_init(void)
 	env_set("board_rev", env_str);
 #endif /* CONFIG_BOARD_LATE_INIT */
 
-#ifdef CONFIG_CMD_USB_SDP
-	if (is_boot_from_usb()) {
-		printf("Serial Downloader recovery mode, using sdp command\n");
+	if (IS_ENABLED(CONFIG_USB) && is_boot_from_usb()) {
 		env_set("bootdelay", "0");
-		env_set("bootcmd", "sdp 0");
+		if (IS_ENABLED(CONFIG_CMD_USB_SDP)) {
+			printf("Serial Downloader recovery mode, using sdp command\n");
+			env_set("bootcmd", "sdp 0");
+		} else if (IS_ENABLED(CONFIG_CMD_FASTBOOT)) {
+			printf("Fastboot recovery mode, using fastboot command\n");
+			env_set("bootcmd", "fastboot usb 0");
+		}
 	}
-#endif /* CONFIG_CMD_USB_SDP */
 
 	return 0;
 }
diff --git a/board/toradex/colibri-imx6ull/colibri-imx6ull.c b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
index 48fdb1e097..58f62a8a47 100644
--- a/board/toradex/colibri-imx6ull/colibri-imx6ull.c
+++ b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
@@ -187,13 +187,16 @@ int board_late_init(void)
 	add_board_boot_modes(board_boot_modes);
 #endif
 
-#ifdef CONFIG_CMD_USB_SDP
-	if (is_boot_from_usb()) {
-		printf("Serial Downloader recovery mode, using sdp command\n");
+	if (IS_ENABLED(CONFIG_USB) && is_boot_from_usb()) {
 		env_set("bootdelay", "0");
-		env_set("bootcmd", "sdp 0");
+		if (IS_ENABLED(CONFIG_CMD_USB_SDP)) {
+			printf("Serial Downloader recovery mode, using sdp command\n");
+			env_set("bootcmd", "sdp 0");
+		} else if (IS_ENABLED(CONFIG_CMD_FASTBOOT)) {
+			printf("Fastboot recovery mode, using fastboot command\n");
+			env_set("bootcmd", "fastboot usb 0");
+		}
 	}
-#endif /* CONFIG_CMD_USB_SDP */
 
 #if defined(CONFIG_VIDEO)
 	setup_lcd();
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index e6c9b10570..32940690a7 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -621,13 +621,16 @@ int board_late_init(void)
 	env_set("board_rev", env_str);
 #endif
 
-#ifdef CONFIG_CMD_USB_SDP
-	if (is_boot_from_usb()) {
-		printf("Serial Downloader recovery mode, using sdp command\n");
+	if (IS_ENABLED(CONFIG_USB) && is_boot_from_usb()) {
 		env_set("bootdelay", "0");
-		env_set("bootcmd", "sdp 0");
+		if (IS_ENABLED(CONFIG_CMD_USB_SDP)) {
+			printf("Serial Downloader recovery mode, using sdp command\n");
+			env_set("bootcmd", "sdp 0");
+		} else if (IS_ENABLED(CONFIG_CMD_FASTBOOT)) {
+			printf("Fastboot recovery mode, using fastboot command\n");
+			env_set("bootcmd", "fastboot usb 0");
+		}
 	}
-#endif /* CONFIG_CMD_USB_SDP */
 
 	return 0;
 }
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index f0356af008..7ef2e24307 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -360,13 +360,17 @@ int board_late_init(void)
 	setup_lcd();
 #endif
 
-#if defined(CONFIG_CMD_USB_SDP)
-	if (is_boot_from_usb()) {
-		printf("Serial Downloader recovery mode, using sdp command\n");
+	if (IS_ENABLED(CONFIG_USB) && is_boot_from_usb()) {
 		env_set("bootdelay", "0");
-		env_set("bootcmd", "sdp 0");
+		if (IS_ENABLED(CONFIG_CMD_USB_SDP)) {
+			printf("Serial Downloader recovery mode, using sdp command\n");
+			env_set("bootcmd", "sdp 0");
+		} else if (IS_ENABLED(CONFIG_CMD_FASTBOOT)) {
+			printf("Fastboot recovery mode, using fastboot command\n");
+			env_set("bootcmd", "fastboot usb 0");
+		}
 	}
-#endif
+
 	if (is_emmc)
 		env_set("variant", "-emmc");
 	else
-- 
2.42.0

