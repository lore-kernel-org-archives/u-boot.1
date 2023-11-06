Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F61FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E45C8715B;
	Mon,  6 Nov 2023 17:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L2E/5hIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6E187125; Mon,  6 Nov 2023 17:33:33 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050F587137
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-779d0c05959so74932485a.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699288410; x=1699893210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y3Hl/+H9Cx5g0N51QiyyRoWJ3VktASOb4zi0ZFlQfw=;
 b=L2E/5hIO8oRnX6x2J6uFzQEA/3z/6qBwcCSd3TZnODVdG33XzcYJccqVRsW+icfJJC
 vutsQwX0TR59CMabsFYfs1sqy2gBiI5jQRhVuCazMdA/NhpRA629sSjnnkygKnefEMIp
 a1skGjbmxcLwMpnz/0ZbkSnNLlj5IdfJr7abRGYvOddnLW7EdbdfBfLPjSzjbhbQBkyG
 13NBy8sc26bx3VbpSWmnIeJ31FyOlM3rjmbqv0pCeOaw2P+EQWI6lZcASc4rBZGtXwPN
 krQNw8IDi53RQOF58i/L02lSdiOLUuRTNJn292FOaMwkOauGp24OSmSdkyGtVJ1puM6V
 H9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288410; x=1699893210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3y3Hl/+H9Cx5g0N51QiyyRoWJ3VktASOb4zi0ZFlQfw=;
 b=qO/ttqOcwiu8qDaep3uP8BiLxZFExEqBC0TPBZdJw/elwt8MP79iJNPEHvMjFDCgPW
 fpBwCRPMC6+L9YkCut2HY2zYPCz+u9bkNPSI14X7dr/wUT+P3+UNyzVniEE5hVYfycMb
 GIRUtaoNpAIzkPpQgyk+U1HBGP5ExK/Rr5mUidSOTronM6CJ4fTvRPNnfAvbOm2C4O/s
 HIGIlJMrgc+9/J3ee+1RoGKaz+xTtGuXPwYMfza+32++wf/jFI8Ytj7n3tC/hMRI64mJ
 K4QbIlO9aVXCFiFKns4k+7CU2+cZtNZ0fItCyF6zhk5ZEtXaMV6Cx7m/cXQWSYTS6qUT
 aujA==
X-Gm-Message-State: AOJu0Yx+SzrUzEDp8lWkEdJTT3QmJDolkxqxYh8zTB/bWwN6F52VlgCV
 T9s+NWDGm67l2RsQtOofW5TZAzgkmOc=
X-Google-Smtp-Source: AGHT+IFH6dRRGvKVnk6ENXYkJ7BvVi2BFQ1HfKWNd3wliIQYA4Su8mIhb4vWYHrUYuF2rjj9lYJWsw==
X-Received: by 2002:a05:620a:2711:b0:778:9b9f:ccbb with SMTP id
 b17-20020a05620a271100b007789b9fccbbmr32212298qkp.0.1699288409646; 
 Mon, 06 Nov 2023 08:33:29 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:91e3:ce2:e2f8:4628])
 by smtp.gmail.com with ESMTPSA id
 az42-20020a05620a172a00b0077407e3d68asm3407235qkb.111.2023.11.06.08.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:29 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] warp7: Convert to watchdog driver model
Date: Mon,  6 Nov 2023 13:33:23 -0300
Message-Id: <20231106163323.2883561-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106163323.2883561-1-festevam@gmail.com>
References: <20231106163323.2883561-1-festevam@gmail.com>
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx7s-warp-u-boot.dtsi | 10 ++++++++++
 configs/warp7_defconfig             |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx7s-warp-u-boot.dtsi b/arch/arm/dts/imx7s-warp-u-boot.dtsi
index 4f44598c9a27..98784fd7a2ef 100644
--- a/arch/arm/dts/imx7s-warp-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-warp-u-boot.dtsi
@@ -7,6 +7,12 @@
 	chosen {
 		stdout-path = &uart1;
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &aips3 {
@@ -24,3 +30,7 @@
 &uart1 {
 	bootph-all;
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig
index 26d992d3c2d8..4ceb0a4f2917 100644
--- a/configs/warp7_defconfig
+++ b/configs/warp7_defconfig
@@ -67,6 +67,8 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
@@ -80,5 +82,6 @@ CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_USBNET_HOST_ADDR="de:ad:be:af:00:00"
+CONFIG_IMX_WATCHDOG=y
 CONFIG_OPTEE_TZDRAM_SIZE=0x3000000
 CONFIG_BOOTM_OPTEE=y
-- 
2.34.1

