Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5189EC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386F48851D;
	Thu, 20 Jun 2024 03:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQaRGxQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B609884B8; Thu, 20 Jun 2024 01:04:17 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7581B884A9
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f27eed98aso247387f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838255; x=1719443055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b5LjNK/esDZdRRTnt9TAHNjYJvl21hCRveZYGfKaL6o=;
 b=XQaRGxQlKanyPv90HDpWQ4ePK+pdmTQe18CAdslvLqeMzkcn1IUpG5MYcB4sXDx/Oo
 N11/WJwRvBiU5PyHQXn1CdPiVdBlnJCbRYsWZv3HtH2BEuKyqPwrz0U4TnfZQ+bSsm5c
 0lAJEDLV4TREitznI4IduvE6yRIwRbcCY4WwCkExRLC8Sz8GyQdSUCDOvMJLptR23Y8J
 NszhnvUDl8J+Es3vFHQbfrKEL0TzOTQeURrVboYPftxfFoVlsactl1JUMh3UUxbMr6yA
 uM0HQIkz09NVT8BWrtCcdHrSjdL2OFaQDiCSVbo72iYx8YKhS4u5L4aLl9qBazQAwG1x
 6Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838255; x=1719443055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5LjNK/esDZdRRTnt9TAHNjYJvl21hCRveZYGfKaL6o=;
 b=UCOrnnmG78gXOdHdrdmW2SxgCD8AqdmQtYqaszVRyNXNcbGAnatzBzXWNgm/dEO1YQ
 Tp769NXNFIcDf5rtzSrfu/7q4BBF2vnyZ2W+32DQT1QUe+tPb0QXt9ikdt74KITbA8Gy
 MwoEQRn4Syo+EQvwd2XeuUEFz9c9vAIcc40KTgTaITRQnp4qV0psSNlLMd3FpPa1BBSi
 SopAaOHGj++aEyfSdkshd2/L/pJaUHz+KeZPxqlzx5tJBNUHr7O7uEzxfEkpyjGzRtzb
 rj/NOr5DUo3ntvzHPoAcH8MrcSVPTzS/3Ov4cRJ3KidcHjXJvdGzdCVe9Ue879QEkjhf
 hyRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz9sLW+CCnC0CCghx4UpXlHNrRXkoHbynFKbE3u+VcgiJumT3FffIJ6xBU989T9WrQ6XIqHtbizbSbC2NNrpvFFZ6nFQ==
X-Gm-Message-State: AOJu0YyzQ+CSAG8jMELK55qiFHhzkgszKVg7RXMk2S2AlepKmz+90YeR
 fmO2Cj4JyvkSrWTEjNsMZOSANZA6vCjd7adbgqlicQ/BkSDEIs1Q
X-Google-Smtp-Source: AGHT+IEofKAiUOlXMjQKfDy2YsduyOyna+k37GKQAQhNRP61ygQBT2OVrUrY4Lu7ZHSLBUT9klLUxw==
X-Received: by 2002:adf:fd08:0:b0:362:4d2a:7bea with SMTP id
 ffacd0b85a97d-3631998f66fmr2701042f8f.62.1718838254852; 
 Wed, 19 Jun 2024 16:04:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 6/9] tftp: implement support for LED status activity
Date: Thu, 20 Jun 2024 01:03:24 +0200
Message-ID: <20240619230400.8459-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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
index 6b16bdcbe4c..bcc31face7a 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -18,6 +18,7 @@
 #include <asm/global_data.h>
 #include <net/tftp.h>
 #include "bootp.h"
+#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -192,6 +193,9 @@ static void new_transfer(void)
 #ifdef CONFIG_CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
 }
 
 #ifdef CONFIG_CMD_TFTPPUT
@@ -301,6 +305,9 @@ static void tftp_complete(void)
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

