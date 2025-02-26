Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2573C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B09C8118B;
	Wed, 26 Feb 2025 19:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BxTv7Lfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4399E810F9; Wed, 26 Feb 2025 19:45:14 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2163F80FB9
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 19:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1740595507;
 bh=7OaDpd2idE5ETWAiOZte0kuOU6ZYitEVWkDgDmqaQU8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BxTv7LfoAae43YSXPquVPmmwStgQirXCxaSBD0fo554R5O/si/Iif5L+zXXJocATJ
 z7+I7ZKbknkTeVyzoRDCXvXIVz2bFdTRWQN4Z2iwJbVI1covAv/Gn4wIE2Q6hbNKbU
 qV5AKg7gvrKkbztbo7N9bHNjkrlAbd8B4Ew3SR8FM46DMAOwNzVsoX3rLMcPtlWzHj
 4OBKCx22H/4ASIWjMbYoDE09DyQ+CPOf8JcX8OPwFcH9j6vW6cEWvyjiAyDj6LnwOq
 KD+ZYVIkWhkIzAkE2NHB2IpA4xlxW8i18BJzNBD8N1eBx/HCgb0camb4KanY1Hta/d
 4ipLyuFaCkMog==
Received: from jupiter.universe (dyndsl-091-249-076-032.ewe-ip-backbone.de
 [91.249.76.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 816AA17E0861;
 Wed, 26 Feb 2025 19:45:07 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 361F2480038; Wed, 26 Feb 2025 19:45:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 3/4] usb: tcpm: print error on hard reset
Date: Wed, 26 Feb 2025 19:44:46 +0100
Message-ID: <20250226184506.64114-4-sebastian.reichel@collabora.com>
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

A USB-PD hard reset involves removing the voltage from VBUS for some
time. So basically it has the same effect as removing the USB-C plug
for a short moment. If the machine is powered from the USB-C port and
does not have a fallback supply (e.g. a battery), this will result in
a full machine reset due to power loss.

Ideally we want to avoid triggering a hard reset on these boards. A
non-working USB-C port is probably better than unplanned reboots. But
boards with a backup supply should do the hard reset to get everything
working again.

In theory it would be enough to check the self_powered property, but
it seems the property might not be configured consistently enough in
system firmwares.

USB-PD hard resets should happen rarely in general, so let's at least
print an error message before the potential board reset happens. This
is also useful, since it immediately gives away which device triggered
the hard reset.

Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 786d92fa4c6f..909fe2ef4fcb 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -1711,6 +1711,8 @@ static void run_state_machine(struct udevice *dev)
 
 	/* Hard_Reset states */
 	case HARD_RESET_SEND:
+		if (!port->self_powered && port->port_type == TYPEC_PORT_SNK)
+			dev_err(dev, "Initiating hard-reset, which might result in machine power-loss.\n");
 		tcpm_pd_transmit(dev, TCPC_TX_HARD_RESET, NULL);
 		tcpm_set_state(dev, HARD_RESET_START, 0);
 		port->wait_dr_swap_message = false;
-- 
2.47.2

