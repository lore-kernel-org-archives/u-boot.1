Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E1EDE99F
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 10:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A82D86D28;
	Thu, 14 Sep 2023 12:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="rLlEalM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AD586661; Thu, 14 Sep 2023 12:16:48 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B307D86907
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 12:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bfb0a2682fso12102961fa.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1694686606; x=1695291406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kzOkItSZG/UX+Y5t6+ro3gfPM03fczSHVmobX4eWn98=;
 b=rLlEalM1AcobBT4ssWHkdHlrOsBfd59N/zk5XwtaopqCdf/ry7MWGQOV8F50syWCN+
 Vi0pF/gfCsZ0G3Dw6EsoihlSu9jZ3T5loKWEvbn28U7/RXPj8HG/XUlrGV5HvA0LwNTL
 77x2b4Ov1/i+mlZiDFn1CB/bjgbp1gmECvKDTnZxQpGZEBenHDCVJVwxlLvDdmXu7Sf0
 kB2zq5hLBhwFzJMCiU2R2475HFZszXJOwK87tRX6e+1kAty3+mSLF+iOmObe8GKWn+kV
 cNTo+TgTDjsYvbf9KWidfkcK/9aqBQuqIWHs0vgXJ9u9rb9zsSvRfFuuDFHMtoww6nTp
 0cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694686606; x=1695291406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kzOkItSZG/UX+Y5t6+ro3gfPM03fczSHVmobX4eWn98=;
 b=k4zNioQVPPC8LFK/dPfpuvHrHVtdN9vnI4pihdogU7MZG5vLiD3WtYNpBo3eAPAvhT
 M8cxCKyhEdWcQr6Jr8XgpVoFXD/xjUOyTw3a8GL+RvYUJq0SohPx0lHVXr1oFDnrZvU0
 cvLN39/jv+pa3FWkRg1HsQYhFmP3k2bkMRgmYyLt3w/Zl8zGmPV+zFvDMUbWoHprL4Iu
 Eixk4ptkSE9U7TxTljCiOdB8kSVm9jGWN3kLYuTnIII4rahvq3T/MARmJx3BlY/g7Ags
 /GXk7rJVRcdHsftgq5PRxYtYCADSohXy3Pw8kfQZBG5RLHKPOlsv7DPIp1MtPR+vRWaX
 5SPQ==
X-Gm-Message-State: AOJu0YxPtgIfu2G8sCWS9wBdfrIJVVfR1VwtH+ZGZ6mqvD6k4AvSG+VR
 TcrwcUX7s/R9gw7/IplUpmuMjA==
X-Google-Smtp-Source: AGHT+IF+5EaB6B1yZqsWKA8obk8X9KspvY8I4eP1t1Cnk/EBbcqScOKnwBynl3sZ49SPVNmfmuvo3A==
X-Received: by 2002:a05:651c:10cc:b0:2ba:cbb:47b7 with SMTP id
 l12-20020a05651c10cc00b002ba0cbb47b7mr4610019ljn.21.1694686605749; 
 Thu, 14 Sep 2023 03:16:45 -0700 (PDT)
Received: from fedora.. (dh207-96-100.xnet.hr. [88.207.96.100])
 by smtp.googlemail.com with ESMTPSA id
 y3-20020a17090629c300b009929d998abcsm783253eje.209.2023.09.14.03.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 03:16:45 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/3] arm: mvebu: Espressobin: move FDT fixup into a separate
 function
Date: Thu, 14 Sep 2023 12:16:32 +0200
Message-ID: <20230914101642.1603383-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
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

Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
which makes it hard to add support for any other board to be fixed up.

So, lets just move the FDT fixup code to a separate function and call it
if compatible matches, there should be no functional change.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 3ab6e8873d..da325e8c75 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -359,18 +359,14 @@ int last_stage_init(void)
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
-int ft_board_setup(void *blob, struct bd_info *bd)
+static int espressobin_fdt_setup(void *blob)
 {
-#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	int ret;
 	int spi_off;
 	int parts_off;
 	int part_off;
 
 	/* Fill SPI MTD partitions for Linux kernel on Espressobin */
-	if (!of_machine_is_compatible("globalscale,espressobin"))
-		return 0;
-
 	spi_off = fdt_node_offset_by_compatible(blob, -1, "jedec,spi-nor");
 	if (spi_off < 0)
 		return 0;
@@ -455,6 +451,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 		return 0;
 	}
 
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	if (of_machine_is_compatible("globalscale,espressobin"))
+		return espressobin_fdt_setup(blob);
 #endif
 	return 0;
 }
-- 
2.41.0

