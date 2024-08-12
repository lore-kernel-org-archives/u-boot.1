Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67FEC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D728888806;
	Mon, 12 Aug 2024 12:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OR4IJnI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFE987D6B; Mon, 12 Aug 2024 12:33:16 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F1387F19
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f149845d81so47152311fa.0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458793; x=1724063593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c7wvb87HMZERBTWLcE0Zw9te/52TrDk6pCneIGETCws=;
 b=OR4IJnI7CAuM1DfzHpnsFOlxwOZ1+QOogzQdXC6I4lctLyBgnNnsS4An4POFAiN+xK
 dA/47QM1yNwMq4GxdTNSZ3wxdfbY1h5Vrj90Xhe6ShXUfpt+91aZrRMPJaTlQAoxVan0
 8YeZIn66kNpKGaIG/WCaduAF+yV7wwXGKIOON68y/EYtySsuFtPMi3GRvgou+WazFdnD
 DTJSJ7NgjmeP/hs1WTeho0flDm0B6stLiPgKDOSRCLMmyywswU1bbGLdUhtlgFNYWQ9C
 bd82VW4QHZHlXdPgdy88XdQKsJgfpSfpjpUBcoR2B4s6fX5PXrMVnCiH/5Dy6d6rUhYq
 5DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458793; x=1724063593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7wvb87HMZERBTWLcE0Zw9te/52TrDk6pCneIGETCws=;
 b=gInmV5WdeawwB/zZJvgTXhKMDcpenRvCz+ySqdOD2Jtof++5DuorPaRjoZgUkrDBSl
 0DhoNeoZpAv4pUngGaKwX5GBQj67o58Nq4g5wKlTzgNRqUOHfhczWPxyisW36F2N0VpG
 6+bJYRnhZqqD2IKy6Qh8FqnBVCglWoSXufsWiR8SaPdA2Wio3pBUsMHZYTRT169p9cQy
 gY9Qh+B+tLQpoRLiTRl8VbLa6Hv4B7cm3dQsSCdM9Ho0eldsbGQ/Yhq5ut4gEYg9ZQSk
 xcdl5sP6+bXQAopM/giceRPfON39eiXWNXGouhIcweLF1b9AD9IPAmZUmIUUFPiDMSQx
 ootA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu74O2Clm01bHFmka7fHBXo00gUyzIuAfP9ASql33PAom84Yi/jlvnU7ANw3oNNstaUg5ZCkG5+QFaEBnZ2WXCry+ruw==
X-Gm-Message-State: AOJu0Yzip1P1G5/mpYHSvIXzWY/HKBH/K5LKU/9h1ICOgnhnjf9GQMpx
 QuP1f6PV8c3QmSnFaFC/i3N3vvw7XKBfJ101bctKJ7/jGqzGic6b
X-Google-Smtp-Source: AGHT+IEaz1m49SXILOpzD+2eEGLWKzx9wJQ8aSM3RZI0JPoml+RmTbRrU7OEPcrgmuM5Wstx+W9gYg==
X-Received: by 2002:a2e:b8c1:0:b0:2ee:974c:596f with SMTP id
 38308e7fff4ca-2f1a6c68b39mr65867621fa.28.1723458792454; 
 Mon, 12 Aug 2024 03:33:12 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:12 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 6/9] tftp: implement support for LED activity
Date: Mon, 12 Aug 2024 12:32:48 +0200
Message-ID: <20240812103254.26972-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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
index 2e073183d5a..45c2455336a 100644
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
2.45.2

