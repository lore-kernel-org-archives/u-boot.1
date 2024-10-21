Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0447D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFD988EFB;
	Mon, 21 Oct 2024 13:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b8FAXr8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA4988EDA; Mon, 21 Oct 2024 13:38:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102DD88EFB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso633582466b.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510731; x=1730115531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IytC9cyVj0vkn5afwp5w6+qBX60mnhsAz9Y9WfQU29Q=;
 b=b8FAXr8GD++EOk4ZwgxV8BblbMDGVj0urCvnLv0ffQEUNr3hrSQtrcmT6Fyg8/Hq54
 nMeBbv1pNP+joOYYDSfSA52kX9z7IckwPmEHr7EhXwNFhApLD7EKF7Tgq1+NaMFYvuE0
 +nVWaiPbi9sXJOua176UJF6OWEwOPW/myhra4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510731; x=1730115531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IytC9cyVj0vkn5afwp5w6+qBX60mnhsAz9Y9WfQU29Q=;
 b=Qrww1uFVLKSVokvEzVP3GNKrDEQNm+gXzbQSNC2LdQ80E6g1rd77yMF8xheKzYVeyR
 YlfZNZCiNLRtr4UmRhJ5Pj4mFa02J0/PmDPDnHxh1SpQTq9Zz/qnTTKoWbvB2+/xIf9L
 6UGR+St0bZxcM25cU4RutlTDKqz3FF9kr1ZWpYE/mSCqAVxHrJYaZzuUuLv3MEniQcQT
 xFeBf7w/ZGVAFujI4edagblF7Jqas/eaWqzhyjKZwh3PIOR0E9UYs+BepM5GIk6yfWF8
 er9maGOuADSB/jppOqihViq/fnXXxOTdRHSsE7OgVDYDSMGDB2uwmIfduFBKbhX8I6DA
 nMWA==
X-Gm-Message-State: AOJu0Yy6Lp9WroQc9/oNwYWRucC30FKl6ddvE1NYcmO+ENznNRBHaPFJ
 Ebbsiq6142YtikHbH/UAqpiTKK5jtmREDERkOAfRZuBPmm9jx/mXU/VTM58vxxGr7V099atjXzl
 QEDgO
X-Google-Smtp-Source: AGHT+IHNMdB4jw6CYKiBomHOe2XlgWsoOqn73Xy8VFv7Uwb2FCHxAWJWogevbNReFT/I2s0EJsP5Zw==
X-Received: by 2002:a17:907:a4b:b0:a9a:421:720 with SMTP id
 a640c23a62f3a-a9a69c55b5cmr1155758366b.46.1729510731199; 
 Mon, 21 Oct 2024 04:38:51 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 02/25] vining_fpga: Drop status-LED code
Date: Mon, 21 Oct 2024 13:38:10 +0200
Message-ID: <20241021113839.318572-3-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/softing/vining_fpga/socfpga.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index ec2c7ea3631..700184cc575 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -8,7 +8,6 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
-#include <status_led.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -26,9 +25,6 @@ int board_late_init(void)
 	const unsigned int usb_nrst_gpio = 35;
 	int ret;
 
-	status_led_set(1, CONFIG_LED_STATUS_ON);
-	status_led_set(2, CONFIG_LED_STATUS_ON);
-
 	/* Address of boot parameters for ATAG (if ATAG is used) */
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
 
-- 
2.43.0

