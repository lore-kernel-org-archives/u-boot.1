Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B22CF3959
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDD083FF7;
	Wed, 19 Nov 2025 17:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BDE83015; Wed, 19 Nov 2025 17:44:23 +0100 (CET)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A02583F20
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBS4N4tPQzhnB;
 Wed, 19 Nov 2025 17:44:20 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBS4M3HBpzCMH; Wed, 19 Nov 2025 17:44:19 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 17:43:48 +0100
Subject: [PATCH 4/5] net: remove unreachable legacy LED code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-legacy-led-unused-code-v1-4-bc0ae1235baa@cherry.de>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
In-Reply-To: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <hackpascal@gmail.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The code is guarded by a condition none of the defconfigs meet (that is
CONFIG_SYS_FAULT_ECHO_LINK_DOWN and CONFIG_LED_STATUS_RED both enabled),
so we can remove the unreachable code sections.

When doing that, there's no caller for miiphy_link anymore, so it can be
removed.

This in turns makes CONFIG_SYS_FAULT_ECHO_LINK_DOWN and
CONFIG_SYS_FAULT_MII_ADDR unused so they are removed as well.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 common/miiphyutil.c | 25 -------------------------
 include/miiphy.h    |  3 ---
 net/Kconfig         | 11 -----------
 net/net.c           | 35 -----------------------------------
 4 files changed, 74 deletions(-)

diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 274e88a4921..dd4cc3c2e4e 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -523,28 +523,3 @@ int miiphy_is_1000base_x(const char *devname, unsigned char addr)
 	return 0;
 #endif
 }
-
-#ifdef CONFIG_SYS_FAULT_ECHO_LINK_DOWN
-/*****************************************************************************
- *
- * Determine link status
- */
-int miiphy_link(const char *devname, unsigned char addr)
-{
-	unsigned short reg;
-
-	/* dummy read; needed to latch some phys */
-	(void)miiphy_read(devname, addr, MII_BMSR, &reg);
-	if (miiphy_read(devname, addr, MII_BMSR, &reg)) {
-		puts("MII_BMSR read failed, assuming no link\n");
-		return 0;
-	}
-
-	/* Determine if a link is active */
-	if ((reg & BMSR_LSTATUS) != 0) {
-		return 1;
-	} else {
-		return 0;
-	}
-}
-#endif
diff --git a/include/miiphy.h b/include/miiphy.h
index 96afe5f4030..817d77add37 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -29,9 +29,6 @@ int miiphy_reset(const char *devname, unsigned char addr);
 int miiphy_speed(const char *devname, unsigned char addr);
 int miiphy_duplex(const char *devname, unsigned char addr);
 int miiphy_is_1000base_x(const char *devname, unsigned char addr);
-#ifdef CONFIG_SYS_FAULT_ECHO_LINK_DOWN
-int miiphy_link(const char *devname, unsigned char addr);
-#endif
 
 int miiphy_set_current_dev(const char *devname);
 const char *miiphy_get_current_dev(void);
diff --git a/net/Kconfig b/net/Kconfig
index 42fcba5323f..e45ceb25106 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -53,17 +53,6 @@ config NET_MAXDEFRAG
 	  used for reassembly, and thus an upper bound for the size of
 	  IP datagrams that can be received.
 
-config SYS_FAULT_ECHO_LINK_DOWN
-	bool "Echo the inverted Ethernet link state to the fault LED"
-	help
-	  Echo the inverted Ethernet link state to the fault LED.  Note, if
-	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
-	  be configured.
-
-config SYS_FAULT_MII_ADDR
-	hex "MII address of the PHY to check for the Ethernet link state"
-	depends on SYS_FAULT_ECHO_LINK_DOWN && LED_STATUS_RED_ENABLE
-
 config TFTP_WINDOWSIZE
 	int "TFTP window size"
 	default 1
diff --git a/net/net.c b/net/net.c
index f579f6ac5bc..44ce0ba4011 100644
--- a/net/net.c
+++ b/net/net.c
@@ -88,15 +88,9 @@
 #include <image.h>
 #include <led.h>
 #include <log.h>
-#if defined(CONFIG_LED_STATUS)
-#include <miiphy.h>
-#endif
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
-#if defined(CONFIG_LED_STATUS)
-#include <status_led.h>
-#endif
 #include <watchdog.h>
 #include <linux/compiler.h>
 #include <net/fastboot_udp.h>
@@ -615,19 +609,6 @@ restart:
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
@@ -688,22 +669,6 @@ restart:
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
2.51.1

