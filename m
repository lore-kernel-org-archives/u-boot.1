Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58580C27C5F
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DD0884C8;
	Thu,  6 Jun 2024 18:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="htkmVV4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7860988428; Thu,  6 Jun 2024 16:30:47 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F55A87E1D
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42108856c33so13029975e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684245; x=1718289045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rtMC5JbP5BH/cFBWNtSST3rx9aK9f8wKNrTbXFX8p+0=;
 b=htkmVV4t9QDpk6wa3NkjJGlaymn1FdDPSBmleVKpCmKo5jqHtFTxiwslp2/AfI3Q5p
 GNlh29Vh45l2XST02n12LiX6inhdpPjFruniVEbik9184JzlM43eYnJkIjl7U8g+5ezK
 i8/psyrfZ+sWi13hzgfoeYLxSW5uuCpDvQfozqNwsb9LBtm7M1Bx+2FVoqWbUbANP8y0
 rs10iDKXf5J33sXj2pjT6tNdtwJ/56UHLtff2P+jgQU9b6MMcU/hhD+7bn9QtZyePLtJ
 WucTxI/6A/JNLl+3z37EV7jLSfa1vy0Xtq30CfO8StivZDAkZHbJSkOQA8b3qJTT2Yji
 9xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684245; x=1718289045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtMC5JbP5BH/cFBWNtSST3rx9aK9f8wKNrTbXFX8p+0=;
 b=U8X0mbqwa0edCMMY4mmDjItlT8s7k24YkckJa4Gx2Rg92JVooUhIqVzT79Y2DiPy0G
 RmcnVf//7zTyBgVnRSLezCLHyu6eIvj98P+T9k0GhseAK3SoW8sprlxeIbSZFEoXYa4R
 vJiloP9a5lRYJmeomBg8KBOFbNtbYTMi8mXxrk+yJoQAL+FGRQlC83l7BLwmDRRb/ZVN
 6HfaGXkZfgWUM0yVkKcU9bO6TwrxBfs/7tsmsngdY3QbgoLUNsUVuwzfQ7aF85h7k6Fa
 yWmMhAfYn/JIIYO8viQmBXq+UXp0gmSllDijlwlVTcwgOT3aRoYcOdCdbIY7ZM9ImeOL
 zemw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWKepZr1CxlG4pUsEYv2kGmAgw925cqYwSz92AUEX81JNouijGl7tC4FshsmP2nBgLVD9Yd7kvFLzzQmUfDTyiZe7tPg==
X-Gm-Message-State: AOJu0YxkAg8SXC5reEur/J5UiBy5oXsZYTKwU6+4gqxf3+jcHQnIKMvh
 NqfDlIxleBgEzTSmydBECVw0//p8eOPo7FG5kklcrSrCk+Qn6wfT
X-Google-Smtp-Source: AGHT+IHpy7C2AHXysN0PGfqHA421gqpvYARWPfWN5I/GXmNx5HNvQ1EK6Evysqohq42hD9XveE3LEA==
X-Received: by 2002:a05:6000:4c5:b0:34f:8f7c:8fe2 with SMTP id
 ffacd0b85a97d-35ef0d7a266mr2527104f8f.10.1717684244855; 
 Thu, 06 Jun 2024 07:30:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v2 5/8] tftp: implement support for LED status activity
Date: Thu,  6 Jun 2024 16:29:26 +0200
Message-ID: <20240606143024.20024-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143024.20024-1-ansuelsmth@gmail.com>
References: <20240606143024.20024-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

