Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC4CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F314088E78;
	Thu, 26 Sep 2024 22:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SuOBH3S5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC7D88E7A; Thu, 26 Sep 2024 22:54:12 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9803088E58
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-49bd40d77e5so491839137.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727384049; x=1727988849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HEe4lVmRFg+1ABfBpSDh1VyQhcXPLKGlr2GD+uRsus=;
 b=SuOBH3S52mCoJENSIAM8nM2dn8jl8rVVl8aLHRlDydAG3HAOyu8pVtIApzFy0pB+vu
 wAWEG+9iqiXK05d3PutkqQnsOzhN1sjfGzpxsyia6xANsBKa20fjEMTG2k+u3Nhxz54e
 ZERzchbfF7pSR3El2KIQXUaaJRfbi+aAanoRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727384049; x=1727988849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HEe4lVmRFg+1ABfBpSDh1VyQhcXPLKGlr2GD+uRsus=;
 b=YvEaPlpsmoOMmNGHeIm5uQEfXq8Vg3KBb/9T36FjP0zWxsx4GY+d6THILpLd3M3qVT
 QwzFJVSvXp25gVXew+fwyxTthKhiEyKMHlgWD0q9jlY2ZfiNt/5uTrZi1NtEQjZ2BGC0
 RQwXastHoNs32O05PkIEYRmnOKcW3zUshpdoKyjrd2JoXmhQNHmnBXjMALFlitxGapbS
 ndOQD0ZKmN4tnZoBQnzrOkf9KoZ0RKiGHFzdrTjF4m0TX2Ase8f4aoSRLGyYaYyEWGu9
 guLpM//fqpshqrZDlVTVr7y8/l2iRd/2XRyMpGrtVOHzrvTST/HRt56/ZZZLQk7leLPO
 L29g==
X-Gm-Message-State: AOJu0YyXsiS/qaFeoBZAKDpeLSVj7QMwlWbCqtPu5qg7bbsPDHJpCkHG
 ss/VTapxO/ly35XTYpOZMPGcYqt2KTJlfNQ9CF66pvz8ULxXzaeBTQDOpYlm93kKcc+nmSW+Vmp
 xBKiRNf8=
X-Google-Smtp-Source: AGHT+IGX0qZh6i5cSN5XH0/8FYauHgsFusqkvZvrZisqfll8cH4azocdM5QAcvFc/N93Vh+aBhs+Yg==
X-Received: by 2002:a05:6102:304f:b0:49b:f52d:491b with SMTP id
 ada2fe7eead31-4a2d7f27565mr1190201137.7.1727384049331; 
 Thu, 26 Sep 2024 13:54:09 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:54:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH 26/27] net: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:46 +0200
Message-ID: <20240926204455.963584-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

 net/bootp.c |  7 -------
 net/net.c   | 33 ---------------------------------
 2 files changed, 40 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index 512ab2ed7c8..8a7806f3efc 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -19,9 +19,6 @@
 #include <linux/delay.h>
 #include <net/tftp.h>
 #include "bootp.h"
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
-#endif
 #ifdef CONFIG_BOOTP_RANDOM_DELAY
 #include "net_rand.h"
 #endif
@@ -370,10 +367,6 @@ static void bootp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	/*
 	 *	Got a good BOOTP reply.	 Copy the data into our variables.
 	 */
-#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_OFF);
-#endif
-
 	store_net_params(bp);		/* Store net parameters from reply */
 
 	/* Retrieve extended information (we must parse the vendor area) */
diff --git a/net/net.c b/net/net.c
index 1e0b7c85624..fef214f2ebe 100644
--- a/net/net.c
+++ b/net/net.c
@@ -99,10 +99,6 @@
 #include <net/pcap.h>
 #endif
 #include <net/udp.h>
-#if defined(CONFIG_LED_STATUS)
-#include <miiphy.h>
-#include <status_led.h>
-#endif
 #include <watchdog.h>
 #include <linux/compiler.h>
 #include <test/test.h>
@@ -613,19 +609,6 @@ restart:
 		break;
 	}
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII)
-#if	defined(CONFIG_SYS_FAULT_ECHO_LINK_DOWN)	&& \
-	defined(CONFIG_LED_STATUS)			&& \
-	defined(CONFIG_LED_STATUS_RED)
-	/*
-	 * Echo the inverted link state to the fault LED.
-	 */
-	if (miiphy_link(eth_get_dev()->name, CONFIG_SYS_FAULT_MII_ADDR))
-		status_led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_OFF);
-	else
-		status_led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_ON);
-#endif /* CONFIG_SYS_FAULT_ECHO_LINK_DOWN, ... */
-#endif /* CONFIG_MII, ... */
 #ifdef CONFIG_USB_KEYBOARD
 	net_busy_flag = 1;
 #endif
@@ -680,22 +663,6 @@ restart:
 		    ((get_timer(0) - time_start) > time_delta)) {
 			thand_f *x;
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII)
-#if	defined(CONFIG_SYS_FAULT_ECHO_LINK_DOWN)	&& \
-	defined(CONFIG_LED_STATUS)			&& \
-	defined(CONFIG_LED_STATUS_RED)
-			/*
-			 * Echo the inverted link state to the fault LED.
-			 */
-			if (miiphy_link(eth_get_dev()->name,
-					CONFIG_SYS_FAULT_MII_ADDR))
-				status_led_set(CONFIG_LED_STATUS_RED,
-					       CONFIG_LED_STATUS_OFF);
-			else
-				status_led_set(CONFIG_LED_STATUS_RED,
-					       CONFIG_LED_STATUS_ON);
-#endif /* CONFIG_SYS_FAULT_ECHO_LINK_DOWN, ... */
-#endif /* CONFIG_MII, ... */
 			debug_cond(DEBUG_INT_STATE, "--- net_loop timeout\n");
 			x = time_handler;
 			time_handler = (thand_f *)0;
-- 
2.43.0

