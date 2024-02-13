Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF9C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD98687D68;
	Tue, 13 Feb 2024 12:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GKpSWD6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1146D87D65; Tue, 13 Feb 2024 12:43:56 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBED8078B
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 12:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cdbc42f5efso1246356a12.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 03:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707824630; x=1708429430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FTnUPibUhOuTNrMA8elbEzd9scGbIiPyDTvK4y6Qe5o=;
 b=GKpSWD6eWwYgoXgAkHDN1IPDKl1yLZ3nCFeYphM0vGFdiTv70kITXVUSTdxk2mhM/K
 bOfkQDu5CYK6g0wcvbx5AWgkLCBunrVzfWHW1UMuA9BLY2GeTpAG/QPnHqi08pJu8AK0
 IT1V26LOVHcnL0LTWQ4g23PIFvklVYB/PVe+7zAv4J/rH0+WBHXLZCzEaxpsRK2oD8sD
 P0pxms1q4DPjNz1fZZr4GG2DHZRap6ClcELDX4PpNMXpIg0d9M8KSKhY4FMP8ZiOJ/NK
 NCsHl2UGxTsiE7YBFT57p8xwpb+swnTtwCHz//ah5tJkT5oYTAh2AeakjCiw74mHs2Nl
 6tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824630; x=1708429430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTnUPibUhOuTNrMA8elbEzd9scGbIiPyDTvK4y6Qe5o=;
 b=cVwBGzda4GR3FQ9AbXnOE1BqnU7zlE7kNtOkx7t7sWMCFDm0uRTwABOZp2ZMBzVwmW
 pAtW4Cw7zC2BAmVMykG7/VbLgGYObI879Xj7BlPxOETXWmlgsormdU86NFmGhvW4lnR+
 M4vZF146cXNqAJbiHawRxrCE6NQKiF8t1tgvzPvam/BVa3LjQSiZWZrM1sLj3XM3EJpH
 JUCdi3kgS0vPXckwbCBkLQCqF36JjHAlH6Ip/UBHAS2JuXCVRTeFM6lb95NCXnGwkR+c
 3+dnERVzUsfr8hjC2/JRPa3FLkwblasWY9O3imOl5XmObmXcqbdPHSmhDpGoyw4uhKzn
 Qong==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb7mCIRPT2U+kV8f6mq2xgXoQYd5uzYArcN78j5TcYN30U1ZT0vecpkNhGl8XibJ0VMIxbqh7QIHwTgHMiYcci8meKcQ==
X-Gm-Message-State: AOJu0YxqmyrORRkT8mVR/gxKdEtAaIVSxSggtLVspCXV7rkeT4wV7aAA
 aZ5iT9PLz+DNA30dAlYNDxixSINWDqUGYX9FFRJQgEEIdcjSpC2TA4/nM+PS
X-Google-Smtp-Source: AGHT+IGG5yXzzJBVDfES727XT7R9FrU/jaCcPvwldb7597JGkeO8mt4SA5DANjB07p9lRD+UA09GBg==
X-Received: by 2002:a05:6a20:3d16:b0:1a0:5de4:517 with SMTP id
 y22-20020a056a203d1600b001a05de40517mr2468317pzi.5.1707824630213; 
 Tue, 13 Feb 2024 03:43:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUF3z8dRBAe5HGu1Uz0/NGB5/XxC6jJ2WI2101OiX8Oyxnkzs3+42S8J2t3wGtVqVMH5r36qNhefuJhrdh2YiY56hBBPtY6Pmt5O/oJjnQXig7BoNRCx0jfz5LOX2gNxu9iqm3ht/H/JmCNUmMbaGRoWU4=
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c0bb:2b3:6958:833])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a170902f28500b001d8f0e4bc32sm350795plc.144.2024.02.13.03.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:43:49 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: ian.ray@ge.com, martyn.welch@collabora.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/5] msc_sm2s_imx8mp: Convert to DM_SERIAL
Date: Tue, 13 Feb 2024 08:43:38 -0300
Message-Id: <20240213114342.2728075-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

The conversion to DM_SERIAL is mandatory, so do the conversion.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi | 8 ++++++++
 board/msc/sm2s_imx8mp/spl.c              | 9 ---------
 configs/msc_sm2s_imx8mp_defconfig        | 1 +
 include/configs/msc_sm2s_imx8mp.h        | 2 --
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
index c398a743f7..1a7b530d9f 100644
--- a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
@@ -63,3 +63,11 @@
 &pmic {
 	bootph-pre-ram;
 };
+
+&uart2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart2 {
+	bootph-pre-ram;
+};
diff --git a/board/msc/sm2s_imx8mp/spl.c b/board/msc/sm2s_imx8mp/spl.c
index fed0fbcba1..ed7a1b7d3d 100644
--- a/board/msc/sm2s_imx8mp/spl.c
+++ b/board/msc/sm2s_imx8mp/spl.c
@@ -168,13 +168,6 @@ static const iomux_v3_cfg_t wdog_pads[] = {
 	MX8MP_PAD_GPIO1_IO02__WDOG1_WDOG_B  | MUX_PAD_CTRL(WDOG_PAD_CTRL),
 };
 
-#define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
-
-static const iomux_v3_cfg_t ser0_pads[] = {
-	MX8MP_PAD_UART2_RXD__UART2_DCE_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
-	MX8MP_PAD_UART2_TXD__UART2_DCE_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
-};
-
 int board_early_init_f(void)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
@@ -182,8 +175,6 @@ int board_early_init_f(void)
 	imx_iomux_v3_setup_multiple_pads(wdog_pads, ARRAY_SIZE(wdog_pads));
 	set_wdog_reset(wdog);
 
-	imx_iomux_v3_setup_multiple_pads(ser0_pads, ARRAY_SIZE(ser0_pads));
-
 	return 0;
 }
 
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index bf1052db6f..9c27a72f8a 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -97,6 +97,7 @@ CONFIG_SPL_PMIC_RN5T567=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
index c1c1fd5a78..3c7d96cb3c 100644
--- a/include/configs/msc_sm2s_imx8mp.h
+++ b/include/configs/msc_sm2s_imx8mp.h
@@ -55,8 +55,6 @@
 #define PHYS_SDRAM_2			0xc0000000
 #define PHYS_SDRAM_2_SIZE		0x0
 
-#define CFG_MXC_UART_BASE		UART2_BASE_ADDR
-
 #define CFG_SYS_FSL_USDHC_NUM	2
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-- 
2.34.1

