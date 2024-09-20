Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB83CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C784887FA;
	Sat, 21 Sep 2024 04:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5fs8OsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1278839A; Sat, 21 Sep 2024 00:51:58 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E97F787E30
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so21606485e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872716; x=1727477516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NzTOuwtkIiYwClWTiai050AtuXNXIOHo/YChZTv1iL0=;
 b=I5fs8OsH8PlKWplA4OQZ39lr8j9/bdqbQpGrF6H9Mwpmpgq+gvoHJikkEhbuT3FU7t
 zP09TSNRoo7qQL0ZUAVkTwYJEtQKnmZRfejij/uvAF4UbcCj1QjFQsYUnqLsiHqH+rUm
 Z85gQrh7Hm7995HTZIvxv1aCJxB3Uz7GU8s+bSm+GmhgHoymY3p552erWJHVY3nBEmaJ
 QnMj8jXbpr3iVTKBSHP8AQUIUFfGAYhS+yNyoenrtTp52QPD6N23Hu56oSj2wExLFAk6
 NACQuBSG8azk/Xxwz04nsXtQFCxT81wfUqv4DgPfDG1ZppPJB3ld9wFPKw0W9wh62YrQ
 vzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872716; x=1727477516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzTOuwtkIiYwClWTiai050AtuXNXIOHo/YChZTv1iL0=;
 b=Is3RX5VRwpx/24+bxIjp6G6k33W9zNlVi+yO3+81/Vj7yh/aiXzKkq357Ysv9TB06o
 avGG86q8jCxnKzkUugG858H7hjMpKRsaGd4M/c5SQgl/RecsNGeuKtfoCi2O+IF96aR2
 gAhvQEgmwx7giMvgoQoyJ1QyICgqvzt0iOWXvexQgOi70e+8DtOYTbBU79sJ7lOnIYfn
 A2YpWakwPq171R0TDnFVtJxP1qmTqboCMlP4snx/i3WB6BUpzhEefiqKy6H+pHExgxib
 xzjLIWSia723FkZFsNqZyiRqUHT1VKwwDYIG5cszwUZy35dw0rR58JNJAfvKJI6JD62j
 Acaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwNJ6VAu+eSgSAuVqfJ1w6cr2Vzm8kJe+XxcrFV+/vo7HqGke8Z2bjDLJOvF2ZpAyg4Sr5NF4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp+ouWFO8wQVftc1P4MqvTthcLaDECl/JMUZWKV1N4dYjEEmMr
 pUBcB/i2xLwHEC/i/4Y45+Ow4Y/vN8B+7g55wu54fHDgvNTgcf6Y
X-Google-Smtp-Source: AGHT+IHf3OLJOs+beB/+o19pMp1YE+SXh6i63QRbOSnBvbT+aEo7jjUrrgHu7uzqN3YfbgM0oqwYhw==
X-Received: by 2002:a05:600c:354a:b0:42c:c1f6:6ded with SMTP id
 5b1f17b1804b1-42e7ad9afabmr30326365e9.29.1726872716254; 
 Fri, 20 Sep 2024 15:51:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 06/11] tftp: implement support for LED activity
Date: Sat, 21 Sep 2024 00:49:59 +0200
Message-ID: <20240920225101.2008-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

Also turn the ACTIVITY LED OFF if a CTRL-C is detected in the main
net loop function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 net/net.c  | 4 ++++
 net/tftp.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/net/net.c b/net/net.c
index d9bc9df643f..94bfde43f85 100644
--- a/net/net.c
+++ b/net/net.c
@@ -87,6 +87,7 @@
 #include <env_internal.h>
 #include <errno.h>
 #include <image.h>
+#include <led.h>
 #include <log.h>
 #include <net.h>
 #include <net6.h>
@@ -659,6 +660,9 @@ restart:
 			/* Invalidate the last protocol */
 			eth_set_last_protocol(BOOTP);
 
+			/* Turn off activity LED if triggered */
+			led_activity_off();
+
 			puts("\nAbort\n");
 			/* include a debug print as well incase the debug
 			   messages are directed to stderr */
diff --git a/net/tftp.c b/net/tftp.c
index 2e073183d5a..5cb06d2038b 100644
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
@@ -192,6 +193,7 @@ static void new_transfer(void)
 #ifdef CONFIG_CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
+	led_activity_blink();
 }
 
 #ifdef CONFIG_CMD_TFTPPUT
@@ -301,6 +303,9 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
+
+	led_activity_off();
+
 	if (!tftp_put_active)
 		efi_set_bootdev("Net", "", tftp_filename,
 				map_sysmem(tftp_load_addr, 0),
-- 
2.45.2

