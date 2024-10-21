Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA70D0E6F8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D8C88DB2;
	Mon, 21 Oct 2024 13:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ih4O2QD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A257888EBB; Mon, 21 Oct 2024 13:38:54 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA01888D5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso600325066b.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510732; x=1730115532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfDrNGdimOCwh2BqK+clnvJDVezWeE0FHDqrFzkc1Xk=;
 b=Ih4O2QD2kKEENbclRHeTk5TlNF2YaQbua1oT/WZx7MgySboQYb4NeSrd6Ms5NLW4Th
 g7T4I2xPGprHkJF3WZII8+EYPR4mOwTg3zMu3XzeAoq7sYgm6xxNCYlfZC1RQqIn2SdB
 Mt0/+VieZxL9h0Z0zUiDEjmeSBD2/PViPRLlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510732; x=1730115532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfDrNGdimOCwh2BqK+clnvJDVezWeE0FHDqrFzkc1Xk=;
 b=DBTANDZlcFZMazT6Mpf9z29Y0bRhmHTfFe2zpdt6N+q0mGeqnIQ6Lk/lEqwPUHbssW
 xXE6Zofz+Xr2u3l+mJuTKLJpZ/LSaaUTiSBu0qMNwUy0PgwGFnaqtfeujXxm97P0kF8S
 Em1zN1FQhsFnhVFesEP1Vn0ITfnhZPN4HJoy3bHY8dGCED30n7KGp+FMsIdW6hd00bC5
 5qDHySqikBIPeFZmduxLL6L6MntK4oa/mDXcH4Z15S5on+hedTH9aaASJqhIU97MHnR/
 oMcRx1o4SQzfwaITFVA45utCCAcoPDJpD89uURVXv1GcDE/Sc0jVmcbNNNOC143U51ib
 U2fg==
X-Gm-Message-State: AOJu0YyF3zlXY4vyH+8SNUDouJQI+OH6feJNSZQIM9cmZ1DnirIBH3+0
 bbpFvxkWeOnR4wnQa8CrdELnE5cyHXd90+LQYdPLPQqdEkoZtUBaHXjIJyZ2W2zh6PhqKudrbfi
 Mv5dL
X-Google-Smtp-Source: AGHT+IGYF8Nk+geml1C1LqqoHAUzo7Yn2aDY6R2jYPONLSs00l04ppVq5Opn4BDXtnQYQJ3zfQh5fg==
X-Received: by 2002:a17:907:2ce6:b0:a99:e98f:e73d with SMTP id
 a640c23a62f3a-a9a69bab1femr1127041666b.37.1729510730461; 
 Mon, 21 Oct 2024 04:38:50 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 01/25] eb_cpu5282: Drop status-LED code and enable LED
Date: Mon, 21 Oct 2024 13:38:09 +0200
Message-ID: <20241021113839.318572-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

