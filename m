Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B3D0E6F9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372F0890CE;
	Mon, 21 Oct 2024 13:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aDq0Ogup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454CE89319; Mon, 21 Oct 2024 13:39:17 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B578C88F28
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so594176466b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510753; x=1730115553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baaE2+Pgpt/p4p9R74oxiJtHpytGrov1+nWBQfFVDJ4=;
 b=aDq0OgupeP9RSTLqkG63HUsv5VV1YYhpISI+P8gbmMeABuAGDZplZEhXVfmqYNS7G0
 oTKZnpU8hXbZDWbg4nCcHzLwKmyGKBeX+S7Q2BeGQ4s6jLmmDGqbJSDUYivrQp2+6VUL
 ACCYWwjmslfb5Z9+3A5MSXkEb6On8CIbhEGf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510753; x=1730115553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baaE2+Pgpt/p4p9R74oxiJtHpytGrov1+nWBQfFVDJ4=;
 b=nKvd2gJehs7sS4vpSLpVjw7ZPYA5zgdADS3KwxhKh5YEzQgSCx74WnMtsrvEbGvkwd
 WPDn5joHTyvTSq+sY4vVFHwXxZjtefzXgMoRCn8GcjTDs+du7csu3foau0SupCNaEnOW
 ILs82z4P2LPGJ+FS3LvD4tUKXaopl2Vu2FiqL7vuivYmhKl90qhsioRB2Lb7FC19ss7G
 XVU2mH9YwlETIMc5Z60HPa65GtPH3WZwNBontkS4yPLdFt4hsGyV2FSP+D+6/c1Bs3L3
 OWSPyj3tiWnYw01pCbfqNhcygDvaJh57pdzX/FlpYXisWP0/JwGenxiF365b5Xj6/lGJ
 k25g==
X-Gm-Message-State: AOJu0YyopdO/9ZyhFG4olVjpeAL4qJBzhAb4LoeRSmVIow/sswnQzSE6
 /BIAbL0eVF5fs+5d2GBHxS2y6pnCu6BveuSVCADooi6qZMzDNo+XUBHmoC8ojLsYiT5DIlSfPHr
 dGQRj
X-Google-Smtp-Source: AGHT+IHUDsVXRaIuY26PHKh56JHAQXMUx4osaMANAhiLlFAsoHyFHVMDVyCBEkwIPgdTl3uci1y1zQ==
X-Received: by 2002:a17:907:9303:b0:a9a:67a8:4c0b with SMTP id
 a640c23a62f3a-a9a69cd3597mr961970066b.60.1729510752866; 
 Mon, 21 Oct 2024 04:39:12 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:12 -0700 (PDT)
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
Subject: [PATCH v2 24/25] net: Drop status-LED code
Date: Mon, 21 Oct 2024 13:38:32 +0200
Message-ID: <20241021113839.318572-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

