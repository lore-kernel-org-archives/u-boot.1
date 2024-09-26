Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6E3CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B518888DF9;
	Thu, 26 Sep 2024 22:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vz7MBZ4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A86B88DF1; Thu, 26 Sep 2024 22:49:22 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D0988DFB
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-846bc787856so449167241.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383759; x=1727988559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBfI0pbQZbYLpCTKzyUnQXc4MhofCPOwM+2F3VhtbdA=;
 b=Vz7MBZ4TOU+H31l4gXeJBk2CI6S3dLsBYnM/lIixjdNdrGZi2GGgEu6Mb0dsOVX+cz
 mfVx/L8ShstqDAEy2KdJFvILNE3rrmjXolisK6r1e4v3aRGnM0V9zuRwCpwrC28dhMWw
 aAhVx2dPMQ6SBIgYRvvsC7foIoOT29cFO3yaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383759; x=1727988559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBfI0pbQZbYLpCTKzyUnQXc4MhofCPOwM+2F3VhtbdA=;
 b=wydAbLu2XOv9ipO2Gl9TzpUgsL8woW1kBcDqT2Rzd25d2dZkG6zt+uqxbtLjJmEjGa
 TNWUVlBCTd5C0NoEovbKyTzTVvReYQlGD2IDbLNBlBMUaWt5wVRQOTeOTv1F03RwvPoH
 FN+6ye1/bdoBRjKwt2FHWuCgnkE0Cml8tXMlBBzFfKwhZJBmG2ABBVT7/2dkgggP2idb
 r296qBF9/TB2D9VZIVmiMtSMnUG0l6Hud1NFQrYj12bcwEHzH8nCU9qnwSAfoar4cuXH
 XeFqyj6aSkZATj2KelWPPbcR2lG2+PrBNsLcJ3eCCITSVBEb9f7GZ5Ds9uJNH8dcVPb/
 ZqWw==
X-Gm-Message-State: AOJu0YzzUDVZQOHWWddQ1EBJ6vam/lil9VJ0FKmUpNdgw52DC6TaQUIt
 Cie2Yrdgbju8MFAOd0GWEVj33LwZHKXtc/P3MrEWzGsBYnAiGL1QQf37W+G4Ax6SioKSfq0Urfy
 f0A841Ok=
X-Google-Smtp-Source: AGHT+IEq/7bBHTl/gX7hlNvZipMfvLwvnCyQjojAFCZVfr9gcXD5/2aoocALBdGKJtEAHN80y2JOcA==
X-Received: by 2002:a05:6102:3f03:b0:497:6bb5:398a with SMTP id
 ada2fe7eead31-4a2d7f2d1e6mr1291552137.7.1727383759139; 
 Thu, 26 Sep 2024 13:49:19 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:49:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 09/27] socfpga_vining_fpga: Drop STATUS_LED
Date: Thu, 26 Sep 2024 22:44:29 +0200
Message-ID: <20240926204455.963584-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This feature is very old and does not use the LED framework. Drop it
from this board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/socfpga_vining_fpga_defconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index f64efcff6bd..1a90e129101 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -77,17 +77,6 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=48
-CONFIG_LED_STATUS1=y
-CONFIG_LED_STATUS_BIT1=53
-CONFIG_LED_STATUS2=y
-CONFIG_LED_STATUS_BIT2=54
-CONFIG_LED_STATUS3=y
-CONFIG_LED_STATUS_BIT3=65
-CONFIG_LED_STATUS_CMD=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-- 
2.43.0

