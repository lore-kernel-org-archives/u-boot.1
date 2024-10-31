Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7BFD767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE54892DC;
	Thu, 31 Oct 2024 18:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Lybebfbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDCA892C6; Thu, 31 Oct 2024 18:54:08 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518D1892A2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1730397245;
 bh=eA7GKK4qeaMLvkI0lUb8UEysR++5Azag8zGYbuOob2M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lybebfbb9nyEyTtN35ggF9b/tHaAhSEDwWuisYYfB+3zBbU1qJsKxnAFuEMJgiTo0
 wj0fwlQquj3wyAmns4P7SxzcNVtzUZvUhHeClJ3KHwiYpRal8t6YGvLzw1zPM9xfDS
 n8w/7d8pf0hEZxvKNHlP/rcxLRqCwbJhuz7fn0O/8Es6ETwyHXQzBcRoXc6c5+tTpe
 ZXHrpCeTvkxta6dbYERm/CO2PwxpXuPZDYqOoFoSa24dbPaxX0GbyAaRV5J106Kqwk
 dsri/yvjbhMIsRWlFq6BDPUTihe/QPhJMEy6Jiq7TBsSy4hIJXl51iALYyWxr6P/6y
 S8Rz0hJe6cdsw==
Received: from jupiter.universe (dyndsl-091-248-210-236.ewe-ip-backbone.de
 [91.248.210.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E0C8117E36BF;
 Thu, 31 Oct 2024 18:54:04 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9B273480085; Thu, 31 Oct 2024 18:54:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 4/4] usb: tcpm: improve data role mismatch error recovery
Date: Thu, 31 Oct 2024 18:50:33 +0100
Message-ID: <20241031175404.114773-5-sebastian.reichel@collabora.com>
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

On Radxa ROCK 5B I managed to get U-Boot into an endless loop of
printing

fusb302 usb-typec@22: TCPM: data role mismatch, initiating error recovery

messages by changing the data role in Linux and then rebooting the
system. This is happening because the external device (A cheap USB-C hub
powered through a USB-C PD power-supply) kept its state and the error
recovery path for non self-powered devices is not enough to change it.

Avoid this by swapping our own data role when the error recovery stage
is reached for a port, which is not self-powered. Right now data support
is limited anyways and once proper support is added we can use the data
role swap request to get the desired data direction after the initial
negotiation completed.

Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/tcpm/tcpm.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 909fe2ef4fcb..12d66d470f9a 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -833,6 +833,28 @@ static void tcpm_pd_ctrl_request(struct udevice *dev,
 	}
 }
 
+static void tcpm_recover_data_role_mismatch(struct udevice *dev)
+{
+	struct tcpm_port *port = dev_get_uclass_plat(dev);
+
+	dev_err(dev, "TCPM: data role mismatch, initiating error recovery\n");
+	if (port->self_powered) {
+		tcpm_set_state(dev, ERROR_RECOVERY, 0);
+		return;
+	}
+
+	/*
+	 * The error recovery will not help for devices, which are not
+	 * self-powered because the error recovery avoids killing the board
+	 * power. Since this can happen early on sending
+	 * a DR_SWAP request is not sensible. Instead let's change our own
+	 * data role. It can be swapped back once USB-PD reached the ready
+	 * state.
+	 */
+	tcpm_set_roles(dev, true, port->pwr_role,
+		       port->data_role == TYPEC_HOST ? TYPEC_DEVICE : TYPEC_HOST);
+}
+
 static void tcpm_pd_rx_handler(struct udevice *dev,
 			       const struct pd_message *msg)
 {
@@ -867,9 +889,11 @@ static void tcpm_pd_rx_handler(struct udevice *dev,
 		remote_is_host = !!(le16_to_cpu(msg->header) & PD_HEADER_DATA_ROLE);
 		local_is_host = port->data_role == TYPEC_HOST;
 		if (remote_is_host == local_is_host) {
-			dev_err(dev, "TCPM: data role mismatch, initiating error recovery\n");
-			tcpm_set_state(dev, ERROR_RECOVERY, 0);
-		} else {
+			tcpm_recover_data_role_mismatch(dev);
+			local_is_host = port->data_role == TYPEC_HOST;
+		}
+
+		if (remote_is_host != local_is_host) {
 			if (cnt)
 				tcpm_pd_data_request(dev, msg);
 			else
-- 
2.45.2

