Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4877FCEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169C4891E6;
	Tue,  1 Oct 2024 15:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ivsv+z0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1643E891C3; Tue,  1 Oct 2024 14:25:59 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28212891AC
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so50466205e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785556; x=1728390356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A1+S4Gc++tnnZtkwvTK7qVrM59nc2vc5QR6Psd2YE/Y=;
 b=Ivsv+z0HlPH7ddYYDV6PU6PA0WJIhgJXGHw5QPrcnhhiBJWBUCnnL0qDveRQ9Vd3u1
 N3jQ/PolkKk9zRRz7DHMXthTkTYFfTr8MQUBUS67gZNtG+yxSB44kg516yZoDg48D9tA
 7p5CX2uZEcZdmxF0XGBbJ5zQaxCJj1pbl24OB8txNOrXYLtAXyzZ2Vdmc78o9EU7X04f
 bSEiTp7G1MiQe8UcYnkwbtm9pAXceJv9CI+ZYtmgMgISwWrPFSrtGKuoAFq8eEfo2qXV
 pb952dJVIDboHtPS4cErCpH/w6+wS1XIutpw7n5OnV811D4fN88hi4rHI+IwPNFFbigj
 +M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785556; x=1728390356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1+S4Gc++tnnZtkwvTK7qVrM59nc2vc5QR6Psd2YE/Y=;
 b=nAOhoB8jsiNq6cfOBqb+XusUR+PXPEogeGf67KNQ9iHnX/xfhMWGGUxcbntZO9qbNg
 GubG1aHG2CjVHQm9CnErVlgmir41cSvtJ9nTSpyLdVc/mHbJrwBoEuAtxkE/pW9ziQmX
 Xhb3ItecqJrh95tPNn07eeVlWeL0V5R1gxyzMitvjxHx9H4wjNWw3NdgUFux/DVHjlrc
 os36EYirlLDa0/xz1gS78bE4t+LRMMbGUKwdwdiCdRFly8OQghGCpEaIz9oBffgHWNS7
 ptoI7K5JEYhG224UoQ5YoYWAv8QuXmLaE1zY1kOW9MiHnQxGYzuQHJInYMI0ks0/UowE
 SzNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw+JFzLWd8kcp+j+auZsUN9Ax3m74S3ST7QGy8Q2bciuwieN9t7hmRDiqMJ9LlG7QdXsuOxlA=@lists.denx.de
X-Gm-Message-State: AOJu0YwsqQ7TbInTUZ5iInU182+UDire7ZkDNIWtPVtAvtiHY0wtAyrH
 fdA+dR7ySdkAhVgXv/4Z9v5FytTp+AySzZd7OCnfrHsYoW/7Jxpr
X-Google-Smtp-Source: AGHT+IGKqHTWxwNRC0KyirEvT2sF19AWV15EM1XF9bPsbHNqrpeeBXE14Evv3mpwYkPUez8ty2VBaA==
X-Received: by 2002:adf:b1d7:0:b0:37c:ced2:843f with SMTP id
 ffacd0b85a97d-37cd5a9ee6fmr9583573f8f.16.1727785556316; 
 Tue, 01 Oct 2024 05:25:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 06/11] tftp: implement support for LED activity
Date: Tue,  1 Oct 2024 14:24:39 +0200
Message-ID: <20241001122511.8832-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

