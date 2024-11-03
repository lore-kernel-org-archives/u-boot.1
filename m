Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8B0E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C079891AD;
	Sun,  3 Nov 2024 01:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gdr+XG/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A36789312; Sun,  3 Nov 2024 01:38:56 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC2A8932C
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so34753475ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594331; x=1731199131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baaE2+Pgpt/p4p9R74oxiJtHpytGrov1+nWBQfFVDJ4=;
 b=gdr+XG/0csQ5qSbvqJ0theBZdSe+rw4dKcPW1z6t3MJ3hnOsW83kbgy70EnUSrtAco
 OGbDaIWwOZJxWNtQZKO29QkvjTK+KTM1Ty+ltDI88lAtsWMF+gO/6VPg1dfNY1of8CGh
 1a1zW3R51KiMX36bB564FZZo+TLsjE32zMNsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594331; x=1731199131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baaE2+Pgpt/p4p9R74oxiJtHpytGrov1+nWBQfFVDJ4=;
 b=Z7Gi6B51BuyGr/70lgeKrzFPn5vIfBriZzxfqnjSCsZUX3UY4p7UArjqlToQAhZyQa
 a4R/IZFiYWkQhdvkWMBuHAKy+GabcCSjsEL4Ht1DeWJ2VRttRP2BM1e2HIaANqNsIOlp
 4/70o4yT20ycxpnnw+wauoPAiDCJCy5ifrtdgNZSFF1ZXlzqs858bx10D2iIwGS7+HX+
 ynb4ka9/Vfwd8vBE/dC9UPfvmHZu4Qd63kvMT+2+wXBUW4yI54FfSvrg/79AWYoC4BIo
 NGf66ufTDX4nAcPNidrtPbwVqxj14wAsRJlqdQx2dnUYk+PZPuaTS5c6dza+KOIF9hJB
 uqMg==
X-Gm-Message-State: AOJu0Yzz3JNqgqRqcQgnE+zKKH5+NANUUNKt0VNISDurzPIXnTkAhAjT
 8KY/4YrGNExSPE13n5h8BWndG7weL/XdFu44bQpzjxWwSHvwLH2hqt646sYLs0OPcS1njvtPVgR
 hGA==
X-Google-Smtp-Source: AGHT+IEJUTx6zKbJIXfTaJBGdlRtCtv9X0IBHzjiDhaeAGJqgPQmmpyV+Z4meytDmrB+/r6WfAqq9A==
X-Received: by 2002:a17:903:2443:b0:202:28b1:9f34 with SMTP id
 d9443c01a7336-21103caeba3mr175299175ad.56.1730594331535; 
 Sat, 02 Nov 2024 17:38:51 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH v3 23/25] net: Drop status-LED code
Date: Sat,  2 Nov 2024 18:33:15 -0600
Message-ID: <20241103003322.626036-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

 net/bootp.c |  7 -------
 net/net.c   | 33 ---------------------------------
 2 files changed, 40 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index afd5b48094a..42462afda3e 100644
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
index f47e9fbe33a..fc869d8bd48 100644
--- a/net/net.c
+++ b/net/net.c
@@ -100,10 +100,6 @@
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
@@ -614,19 +610,6 @@ restart:
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
@@ -684,22 +667,6 @@ restart:
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

