Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476F6C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131A6884CA;
	Wed,  5 Jun 2024 21:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSKI8RGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8916A8831D; Wed,  5 Jun 2024 21:22:07 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106C788369
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4210aa012e5so2699255e9.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615324; x=1718220124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMtQynVUynIygMJG+HZoR5ODD0Kxq9UV2wpCO2Dk7eU=;
 b=GSKI8RGuBlaPWcKrxTwOz6Ut/nhcDxRUY23r9iDj51M3qxyiqDTM1ey37+SpYqF8uD
 PsrSLx3BwfDNUFZ8l+MlJRwhBj4JNro86VzkOMZn/rz7g4SmBrDo6LHrYL2ZIkx1IUXq
 RGevFXMdFVJv0iOeXU6r3PK2fT8/zT3sWFuRzZtClGar1WqtnYc3TkHx96MbBjyiceEl
 5JxbBnG8aT3aCTwmTayRch1cPvHev1kckGbjmfrUHls5bGu8PfnECFVBFRGDkfnIxyc2
 h6L34ZlFiZUauBPUZVipRY0E+dsMO/bD3M3IzV1WkCO01c45jveUayHVAQkcHnKGWczV
 WzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615324; x=1718220124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMtQynVUynIygMJG+HZoR5ODD0Kxq9UV2wpCO2Dk7eU=;
 b=vbZvHL3UbvCuAbVptFvI9lNtgACmYYI5mFEY93glRvyLHepinWC4AyuqjzIg3euRKp
 5u0HyOpcWoQ5pRijkVIdQsyAgWxVLhMZJg9g9ikmm+5o+Ym9xO+XOHMVQ9Fe9s1ahnid
 smpS54Twbj05xAsybmOQ3ReK0r4VAPYhdyQnIeIS0IWRIKfGKZQSOl0p42+MiWUg7kXo
 8XR/KW/rKOCEHs3QVW9pzuTyIWfPSnwJxKYphaqnkCL0F557FW7vVPoaa0y7dimdUXzN
 sT7oFHjjdKjNI0te0pSLiNgaZE4emcOgpd/WLHXlY3pLRsFinBdXh6Z/F9rlCe1m/yIw
 kXPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuF/dy5q+F6pqJsvlyScUaQYrA+ai7je5Ey8Fg3p80RSr4CLLeDL2QLRS7zWNOc68UPa5FPDtnvNvDOgjH8Mv9+I5Fsg==
X-Gm-Message-State: AOJu0YwDiRsQc0hWw4Jmyoo6fHMkoCHQ9+Nm+UrqbA5YPlqRH+3M1gJo
 3HYIiZ948Wj6hfVYOdKbfg81nVpmQRJBq5t3Jlr8CkJ0Zz3ZUS4b
X-Google-Smtp-Source: AGHT+IF/DLKpxiFUV75gz22btwZA5UcxYrHoZb3JmMGS3S6+dahFuKAktbgTaShNUPBrB/VsohhVog==
X-Received: by 2002:a05:600c:4ed1:b0:421:54f7:c294 with SMTP id
 5b1f17b1804b1-4215632d74fmr29771825e9.29.1717615324462; 
 Wed, 05 Jun 2024 12:22:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:22:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 5/7] tftp: implement support for LED status activity
Date: Wed,  5 Jun 2024 21:21:37 +0200
Message-ID: <20240605192146.19052-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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
 net/tftp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492..07dea321bb4 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -19,6 +19,7 @@
 #include <asm/global_data.h>
 #include <net/tftp.h>
 #include "bootp.h"
+#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -193,6 +194,10 @@ static void new_transfer(void)
 #ifdef CONFIG_CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+		       CONFIG_LED_STATUS_BLINKING);
+#endif
 }
 
 #ifdef CONFIG_CMD_TFTPPUT
@@ -228,6 +233,10 @@ static void show_block_marker(void)
 {
 	ulong pos;
 
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
 #ifdef CONFIG_TFTP_TSIZE
 	if (tftp_tsize) {
 		pos = tftp_cur_block * tftp_block_size +
@@ -290,6 +299,9 @@ static void tftp_complete(void)
 	/* Print hash marks for the last packet received */
 	while (tftp_tsize && tftp_tsize_num_hash < 49) {
 		putc('#');
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+		status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 		tftp_tsize_num_hash++;
 	}
 	puts("  ");
@@ -302,6 +314,10 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+		       CONFIG_LED_STATUS_OFF);
+#endif
 	if (!tftp_put_active)
 		efi_set_bootdev("Net", "", tftp_filename,
 				map_sysmem(tftp_load_addr, 0),
-- 
2.43.0

