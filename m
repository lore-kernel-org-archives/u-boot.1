Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DA2C27C79
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E2C887CF;
	Wed, 12 Jun 2024 04:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ol3Tv3UI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB1887B30; Wed, 12 Jun 2024 01:14:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A72688315
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4217926991fso35951125e9.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147697; x=1718752497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rtMC5JbP5BH/cFBWNtSST3rx9aK9f8wKNrTbXFX8p+0=;
 b=Ol3Tv3UIX0qmTshJqVEnjaaBnHPZlBeGUg6+siIUL3udFzrlgaBAKpYt+hhVn/PP9Z
 dYJtk6baL22IOrJXQ2sPG42QQn05OxPzQCfLxFgf2/xWV7tARYgSRg/uQ1aBVKPnzRiy
 zRodo61HZ0MwobMR8gKe+8d9S3L4P7DN17WLNdiumZm3X9hY3QHOlaEbC3kM+Gzazv5v
 3qNim+sFdLLvHtwOP74QXcK7+Wt5QrAg7rEaGwO3vGovQiaVs/nHkotjWGd3SwIoCTnx
 z65ueEpo8F+pNy8r39nQXq6aHel+kWNNATCI09rIp3k3UgtcA9bjqkQ/krc7Rc3oEdnB
 tkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147697; x=1718752497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtMC5JbP5BH/cFBWNtSST3rx9aK9f8wKNrTbXFX8p+0=;
 b=Ypol3D4VYR5XHHngbcrv7Xzo8oYRpT/9RquWqypAoWkdfiYbN94Ih2wllh6zLoa106
 FUgGfcVB1EqME5YeJ/JQvHtbZpgkufUoKI40tOAYjtzz2o/D5Yfe7yqxXm4XUyhDX8Pz
 G9aH01My+X5SGV97pMCCNEkaOiTSp86rzZXvGJ4gCHryiLf67nJbgUWVmEW+0pnvza4Q
 hlBxnSg7TckLpgrVhWnbaDcVfPMrSIppjphMUul642jB92tWTuq1PwZOuigmK5xmH1X1
 17gzQ9Df9hfozfz2YbGDMfNPhqjkB03M8L3TLoCFyTfZmRppEbMG8cnCKTWeJ9g4IKx/
 QqQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1hb2TksVPlaJXwy5JUZudiXdloscdyEZU87j9MMEnDOGy3B639k9+ZOYw+en8JigUm3/viJVssdA1PYkSw7Wcftv1EQ==
X-Gm-Message-State: AOJu0YzFdHA/jzR5n/+PQOWr+o/BZR7mbXFKPgV2gO+Wz6hw+6ptNdyv
 RO2ak53UlZi+Temi8R625ko7Cn5q7JDGJxnXDqTByvHTypJD8glv
X-Google-Smtp-Source: AGHT+IGAF71XS6N5m3CEASZWg4s4ENdE6Di4EanlP0MQm6A6yIvyioPv625Odxz6+WlG7Ow+KOP8nA==
X-Received: by 2002:a5d:4951:0:b0:35f:228e:e82b with SMTP id
 ffacd0b85a97d-35fdf79a2c8mr94708f8f.17.1718147696743; 
 Tue, 11 Jun 2024 16:14:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 6/9] tftp: implement support for LED status activity
Date: Wed, 12 Jun 2024 01:14:21 +0200
Message-ID: <20240611231435.10366-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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

Implement support for LED status activity. If the feature is enabled,
make the defined ACTIVITY LED to signal traffic.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 net/tftp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492..0515dc34d4b 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -19,6 +19,7 @@
 #include <asm/global_data.h>
 #include <net/tftp.h>
 #include "bootp.h"
+#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -193,6 +194,9 @@ static void new_transfer(void)
 #ifdef CONFIG_CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 }
 
 #ifdef CONFIG_CMD_TFTPPUT
@@ -302,6 +306,9 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 	if (!tftp_put_active)
 		efi_set_bootdev("Net", "", tftp_filename,
 				map_sysmem(tftp_load_addr, 0),
-- 
2.43.0

