Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442B0E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B469089058;
	Sun,  3 Nov 2024 01:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U75Rb/WB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED6E89080; Sun,  3 Nov 2024 01:34:39 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365D688F50
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cdb889222so30108465ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594075; x=1731198875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u581EJX4sUW51bS4jbnPZtdZVoeef+vK0be1S3L7EUo=;
 b=U75Rb/WBvzxZclgF3xpN+dan+x5uSljMbEA7HeuhZ2Q1Zl8t+W+7pQzZNuBu3d09mq
 E7SDEUSQ+jYH57wZYpgLnVvsEQEU4WwAYQWEiVXa5KBolugTfyeseNNSOl8C+1HHSULo
 y9OGNVmJM1W5uOxekOmQGM3+nRgjG1bK/nk4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594075; x=1731198875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u581EJX4sUW51bS4jbnPZtdZVoeef+vK0be1S3L7EUo=;
 b=U8W+sSXlBZRwsWsMT0n1/cb46SMZKw28okqWUO1pFQGQ9DKUxhmVwMnp7Hq6hfEw46
 4tqqWWRFb1s2xjD2zjALokrlTYrFw5GLDVPzRbseJ8Qa5CfGvTv56hygKyc2Nw5xv/7u
 jgJyRaIsQH/uD7cz76OuASDoPf73wjIGNaP5y9cJqj4wg7ggGGi4s/hRA0DRC3ddXuM2
 +Nnt0BB/eGtDSpNG5CHUeWbPAufpbE8/6sBo4lBuY9qK2U25Ik3wgNH5QAqEK2oIcqvF
 +SPAS9zOFfGtANVXpol8E0j1drlITfb1JstemGdwXQDBpsh/cxY34cIs6bN67AD+rW/R
 uN3Q==
X-Gm-Message-State: AOJu0YyTmN7vth91UyeoPDzlf0wc/Gs4a2LSDL0zjCid8+/xIrWC5wX3
 MUvZK2ld+OllxnTcBTHqYOB2UMSJ22NYRuWeIiXQjXKrfPPHA3R2FodsB3nYPWNH6MvMHWwnaRF
 dKg==
X-Google-Smtp-Source: AGHT+IEHTK+hfqqE1+NBSAwaQtiUfpdlbOC306UU+AqaZpkQ8nnA7K40j2J/zzr8ct0HD40NsQWIgg==
X-Received: by 2002:a17:902:c40c:b0:20c:7d4c:64db with SMTP id
 d9443c01a7336-21103c7bfafmr152995755ad.49.1730594075007; 
 Sat, 02 Nov 2024 17:34:35 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:34:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 01/25] eb_cpu5282: Drop status-LED code and enable LED
Date: Sat,  2 Nov 2024 18:32:53 -0600
Message-ID: <20241103003322.626036-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

