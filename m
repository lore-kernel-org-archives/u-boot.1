Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B5C30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47DD88548;
	Mon, 24 Jun 2024 23:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QN79LKwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D53088856B; Mon, 24 Jun 2024 23:46:44 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E937C88119
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57d203d4682so5795376a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265602; x=1719870402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TbWCl3JKt5osSAvU/qnIkSMhub8oYfz5yRddNUQP0tY=;
 b=QN79LKwgSpqFRawbky4lSXwWwm9FF822YkSR36gQzzH9a4JghK3Nd0vaWpP6xVXXR8
 FGnF5utY2pSk3c+zUN0sCvcl1IP2owNdxPTG5fJfgLbPlyWG2Fj4G9jQTcC9aUUT4Mox
 d2HRGAyRGifLPZiosB4bUqGf+gPVuXzqG07xnCZ4D1ucaVGGmjNW8Q6RWaGHs/ndUeYl
 Ow4WwoIXRrVnrMyacadQWKbSPT/pcLD7iGL3PqozSycRFkp2ooPLtxrNt/tAnDNoGMoy
 2Pk4FqqMW+aDsR7K9tWd9MHevmLJP5bp/qQMf5Q7URVomv5YmR3JRWsLalJWrU53R828
 5FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265602; x=1719870402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbWCl3JKt5osSAvU/qnIkSMhub8oYfz5yRddNUQP0tY=;
 b=avOMpWTBHQUx6/mj8sRKs3xUby/lEko97qKvoPw8qutYOyOe6VuocQtEs8dQ60pFhN
 1ri3iEDVl0zxDcMsqOOZXHYvaLYPSf/rOlsh16nS677hvOVy9DZKRa3txmkLgcgeTLIQ
 O+z+6+kiDL2QXztLiV9gwxaCJtNQCGin0AhRYBPyRxCzWMbXNB8+zahhPbbhpyj0Etzm
 MqudmbUyiZIicLqv33pyPXyZUU/Z3S+Xc6VmhwnoetvxH6muJZ8JlFS7KJPaNVXLgVoe
 F12ccepF4/jGX69qc5FK4T1SIbtsBJLvwDnnWOWkmnLhVtI3bYU/YIbsSfq1A/E1pOZf
 e42g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJqvgSLepEALJxqLqkqFrznW0qzM6suX57aOvMI/UUK4wQCTrpQ+mCjTxTsrwRxrjOb7mNCvj26ZV9DVJOrIDGfIwAOw==
X-Gm-Message-State: AOJu0YxIIFOykMGuTpVRPCZU1UDIdl+eAdXovS4fUixNEijoOfPoPcTn
 vDFzUfcMROnNtUP+TMwilfhDoAhn4BK4YgwuxKBnNue3EpB0YPI9
X-Google-Smtp-Source: AGHT+IFKx/VEyeM+qOoyvgdtHELXDV2BakmXeFk3IvpmKxrK+rKK4LjO2Gtoj7+8B0HoAf3CW1oisw==
X-Received: by 2002:a50:ab1b:0:b0:57d:524:8818 with SMTP id
 4fb4d7f45d1cf-57d457a1497mr4504598a12.20.1719265602299; 
 Mon, 24 Jun 2024 14:46:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 6/9] tftp: implement support for LED activity
Date: Mon, 24 Jun 2024 23:46:16 +0200
Message-ID: <20240624214626.24336-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624214626.24336-1-ansuelsmth@gmail.com>
References: <20240624214626.24336-1-ansuelsmth@gmail.com>
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

Implement support for LED activity. If the feature is enabled,
make the defined ACTIVITY LED to signal traffic.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 net/tftp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 6b16bdcbe4c..1d6609342a9 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -10,6 +10,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <image.h>
+#include <led.h>
 #include <lmb.h>
 #include <log.h>
 #include <mapmem.h>
@@ -192,6 +193,9 @@ static void new_transfer(void)
 #ifdef CONFIG_CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_blink();
+#endif
 }
 
 #ifdef CONFIG_CMD_TFTPPUT
@@ -301,6 +305,9 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_off();
+#endif
 	if (!tftp_put_active)
 		efi_set_bootdev("Net", "", tftp_filename,
 				map_sysmem(tftp_load_addr, 0),
-- 
2.45.1

