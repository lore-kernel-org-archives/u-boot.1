Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5EFE67814
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DA9890B1;
	Sat,  2 Nov 2024 23:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZcuFe8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D2C890D9; Sat,  2 Nov 2024 23:20:09 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5582D89080
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso2484620b3a.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730586005; x=1731190805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u581EJX4sUW51bS4jbnPZtdZVoeef+vK0be1S3L7EUo=;
 b=oZcuFe8nj2nNR36tpEJj7Nv/5tj8v5OBrhiLmmNBEr0ZuYhuYDqYjgtS8/IxQ7URfH
 7fuiXvfjXDHI0nlVt5jtjck8M6VtZsJh2JedFW7qT86ZH8nVDhPG1ct+pYlcS40Zm1In
 +mNw2EoTFO4pYlilOG6fm6o3BzRDT6A+OD3xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730586005; x=1731190805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u581EJX4sUW51bS4jbnPZtdZVoeef+vK0be1S3L7EUo=;
 b=Gl9RkXOP4RlnifDvsJ0pgvJ3Wms0yxJdGs9ZILdDOYs93mBsjfoPBHoDu9H4KTYebz
 o59sPVjtXv+ZTxeegEi8qiQYkPk+KcecSVi5Ijf+4ImIvYKUSiRyaMidWuupy/xd4fJh
 4CTEsqpFsHj4b0IcOWJ/TSsodHArrSVrmqBMQqnew/tTlv6rEe/YcjSEfeIx+agItm5L
 K1WRiZa+Wh1YOntsMEttZNI2+WDLq4Oh2+c1SruPLrOkD81Cc4zLXyisPzQfxLg5BeMM
 fKN/hGHQbkgS/9m+QUP6HQe3LQnd0j7WBnUGvCFPG2dQBksv9+ADjSvX+IaPHEmUOXL9
 zbQA==
X-Gm-Message-State: AOJu0YwbiRhucqO93L8/5OqGIhb4CY1939Hx3LIsDQsXvbeuDZPcH5sm
 hqgK5ZkIM8XoAitUI4lPI4Su3xUcX8QAdr2xsC78zthgRzjj6nKg5MaEQSiu5HLW9+ZgxNI4zhg
 JpQ==
X-Google-Smtp-Source: AGHT+IFH7SW0qg7sFvE5Z9iWbTFqgYuO7TRVBCVaccUjZ/Co/dYRPW4sdV2qc40o+4j7A6PP29/IAQ==
X-Received: by 2002:a05:6a21:1690:b0:1d9:1783:6a2d with SMTP id
 adf61e73a8af0-1dba5343d25mr11180074637.13.1730586004858; 
 Sat, 02 Nov 2024 15:20:04 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:20:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 01/25] eb_cpu5282: Drop status-LED code and enable LED
Date: Sat,  2 Nov 2024 16:16:59 -0600
Message-ID: <20241102221737.547938-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102221737.547938-1-sjg@chromium.org>
References: <20241102221737.547938-1-sjg@chromium.org>
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

Drop this old code. Swtich the LED options to use the new approach, in
the same commit, to maintain build-bisectability.

Both eb_cpu5282 and eb_cpu5282_internal are done together, since they
share code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update commit message

Changes in v2:
- Combine code-removal and defconfig changes

 board/BuS/eb_cpu5282/eb_cpu5282.c     | 20 --------------------
 configs/eb_cpu5282_defconfig          |  8 ++------
 configs/eb_cpu5282_internal_defconfig |  8 ++------
 include/configs/eb_cpu5282.h          |  6 ------
 4 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index c254da62bf4..cdd862c57d2 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -14,7 +14,6 @@
 #include <bmp_layout.h>
 #include <env.h>
 #include <init.h>
-#include <status_led.h>
 #include <bus_vcxk.h>
 
 /*---------------------------------------------------------------------------*/
@@ -160,25 +159,6 @@ int misc_init_r(void)
 	return 1;
 }
 
-void __led_toggle(led_id_t mask)
-{
-	MCFGPTA_GPTPORT ^= (1 << 3);
-}
-
-void __led_init(led_id_t mask, int state)
-{
-	__led_set(mask, state);
-	MCFGPTA_GPTDDR  |= (1 << 3);
-}
-
-void __led_set(led_id_t mask, int state)
-{
-	if (state == CONFIG_LED_STATUS_ON)
-		MCFGPTA_GPTPORT |= (1 << 3);
-	else
-		MCFGPTA_GPTPORT &= ~(1 << 3);
-}
-
 /*---------------------------------------------------------------------------*/
 
 /* EOF EB+MCF-EV123.c */
diff --git a/configs/eb_cpu5282_defconfig b/configs/eb_cpu5282_defconfig
index 271dbdf4dbb..c51a5db262e 100644
--- a/configs/eb_cpu5282_defconfig
+++ b/configs/eb_cpu5282_defconfig
@@ -35,12 +35,8 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=8
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/eb_cpu5282_internal_defconfig b/configs/eb_cpu5282_internal_defconfig
index 89a7925dffa..3627d25b990 100644
--- a/configs/eb_cpu5282_internal_defconfig
+++ b/configs/eb_cpu5282_internal_defconfig
@@ -33,12 +33,8 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=8
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/include/configs/eb_cpu5282.h b/include/configs/eb_cpu5282.h
index 26e4ade34ee..a4d1338c8fa 100644
--- a/include/configs/eb_cpu5282.h
+++ b/include/configs/eb_cpu5282.h
@@ -14,12 +14,6 @@
 
 #define CFG_SYS_UART_PORT		(0)
 
-/*----------------------------------------------------------------------*
- * Options								*
- *----------------------------------------------------------------------*/
-
-#define STATUS_LED_ACTIVE		0
-
 /*----------------------------------------------------------------------*
  * Configuration for environment					*
  * Environment is in the second sector of the first 256k of flash	*
-- 
2.43.0

