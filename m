Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB492D767F5
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFB2892DA;
	Thu, 31 Oct 2024 18:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NqTTf1mY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F870892A2; Thu, 31 Oct 2024 18:54:09 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FCB9892CD
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1730397245;
 bh=pkPTFYEWHjGxwTXsiPVpHq2/ZEGdEm7WUvTSd1s02eg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NqTTf1mYS95L979/ANxoDc84hwAUwruTiKXu/I0ChmiqKi+9HAIWuEkqtXGTQDUPV
 CplmgASa3CeCOKlEOo7Y+MbLrFFIODFrLChAGnmS+n9+Sv8jOjXBlUIiCbuGJkpYWC
 mHyLGOa4BTi349ZYyhK+z43FfgmjbqY3Uri+sZyOzTnin2W54RCSU1nt0psvvNZBmK
 Ta5WYn9sqL3/VEfgAcaHaY+BBadilMp2BbfM0+E1Wig8XwnEpJO/ExHFDUAW7GCYJi
 IHh15hGjlvtRKNghjaVBTMOZiDw0VYLIPulZn4jk8NN2FK2yUqURolr61OLrZ15zZr
 RWfeUcnPtlc0w==
Received: from jupiter.universe (dyndsl-091-248-210-236.ewe-ip-backbone.de
 [91.248.210.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 02DF317E36CA;
 Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9665E48006E; Thu, 31 Oct 2024 18:54:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 1/4] usb: tcpm: improve handling of some power-supplies
Date: Thu, 31 Oct 2024 18:50:30 +0100
Message-ID: <20241031175404.114773-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031175404.114773-1-sebastian.reichel@collabora.com>
References: <20241031175404.114773-1-sebastian.reichel@collabora.com>
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
2.45.2

