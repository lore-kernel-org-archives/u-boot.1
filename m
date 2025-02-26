Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AD2C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF7680FF0;
	Wed, 26 Feb 2025 19:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IthL1Z+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7614F810F9; Wed, 26 Feb 2025 19:45:13 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2173180FDE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 19:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1740595507;
 bh=Fnp6a8opSCXiH5NJdu5uivbBBZF3pe1CXyluh8+n8/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IthL1Z+mDeIRy9MWEa0lGyJWuHk/Pu+yUpLly7RG6NIpC0lCgla3ssiy2x+8/G+bz
 DWjrKUMxgWtqfjfffRiKEJZ6Z2sAXJ1ePvDmMtbGoolWSrzsV2+cWh0byYrEBuVBe9
 Vp0ye7gJ4Wt610s4QHa4xoYcm7h9KGmE3IEjb+XYFv1HMJIOoACl04BwkLctza1KBr
 XlIqC+snvRP/yQxa2+6RYGXgQD5JnJxCM1orXVIJxyyJxTzb3XgNir60Gb4HI9724H
 LDZy0Hq7NQ1zF0h1yVUOklDotw17isbNoI4K3JCExR+r7GsdESsGY6cwAbZY71iWlf
 OsSSrV6TZtAMg==
Received: from jupiter.universe (dyndsl-091-249-076-032.ewe-ip-backbone.de
 [91.249.76.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A18CC17E0881;
 Wed, 26 Feb 2025 19:45:07 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 32E35480034; Wed, 26 Feb 2025 19:45:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 1/4] usb: tcpm: improve handling of some power-supplies
Date: Wed, 26 Feb 2025 19:44:44 +0100
Message-ID: <20250226184506.64114-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226184506.64114-1-sebastian.reichel@collabora.com>
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
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

When the Rock 5B is booted with the current TCPM with its power supplied
by a "Cambrionix PDSync-C4" port it reaches the power-supply ready state.
Once that has happened the hub starts sending GetSinkCap messages, but
U-Boot already stopped processing PD messages. After retrying a bunch of
times the hub instead sends soft resets. Since U-Boot will also not
react to them, the USB hub will follow-up with a hard reset and that
cuts off the supply voltage.

Since the state machine is already prepared to handle GetSinkCap
messages, try to avoid this by handling incoming messages for another
50ms after reaching the ready state.

Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/tcpm/tcpm.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 0aee57cb2f4a..b754b4dcd0b5 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2229,6 +2229,17 @@ static int tcpm_port_init(struct udevice *dev)
 	return 0;
 }
 
+static inline void tcpm_poll_one_event(struct udevice *dev)
+{
+	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
+	struct tcpm_port *port = dev_get_uclass_plat(dev);
+
+	drvops->poll_event(dev);
+	port->poll_event_cnt++;
+	udelay(500);
+	tcpm_check_and_run_delayed_work(dev);
+}
+
 static void tcpm_poll_event(struct udevice *dev)
 {
 	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
@@ -2242,15 +2253,25 @@ static void tcpm_poll_event(struct udevice *dev)
 		    (port->state == SNK_READY || port->state == SRC_READY))
 			break;
 
-		drvops->poll_event(dev);
-		port->poll_event_cnt++;
-		udelay(500);
-		tcpm_check_and_run_delayed_work(dev);
+		tcpm_poll_one_event(dev);
 	}
 
-	if (port->state != SNK_READY && port->state != SRC_READY)
+	/*
+	 * Some power-supplies send GetSinkCap shortly after they are ready.
+	 * If they do not receive a response after a few retries they will issue
+	 * a soft-reset followed by a hard reset, which kills the board power.
+	 * Let's poll for 50ms after reaching the ready state to check if the
+	 * power-supply wants something from us.
+	 */
+	if (port->state == SNK_READY) {
+		port->poll_event_cnt = 0;
+
+		while (port->poll_event_cnt < 100)
+			tcpm_poll_one_event(dev);
+	} else {
 		dev_warn(dev, "TCPM: exit in state %s\n",
 			 tcpm_states[port->state]);
+	}
 
 	/*
 	 * At this time, call the callback function of the respective pd chip
-- 
2.47.2

