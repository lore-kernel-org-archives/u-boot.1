Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138C7D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA2689293;
	Thu, 31 Oct 2024 18:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HefU4wbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2A788B0C; Thu, 31 Oct 2024 18:54:07 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5652F892C0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1730397244;
 bh=Djmv19inRNW1H5XahSGnal8hXt6BX3BFWCjb9eZe2K4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HefU4wbsD57OPy6TX/wLRv7deoshUxAFgrqKFvF5LBHgF3qJDCFCKa8Dk9D/GIEb5
 ijjGi/rHx/n51fNA7u7oHN/Z3b1A+lGjc6Ux8d76bRohcKcB8SQ6wWJBVFugnCe1xJ
 fjCt2IsY8reqE73dNUWM5rJHYFbNDMqXhK6cbwXuRtj4zo7cdXKa5JReR5uOgrZzxM
 tKjZBFJB9jYB39892cmwCKvRTsXQCZb1LZyHpJ5kuVaMBEBMxJrrcdaeXSORfifW84
 h8TLvpFp9fls77qBD3HgGJ4utRCQqKE6Vt/I9tvq4DnmFdqh9Slp1vt0ufFpdfuXHK
 EwNBIbJmID2ZQ==
Received: from jupiter.universe (dyndsl-091-248-210-236.ewe-ip-backbone.de
 [91.248.210.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DF8BA17E36BD;
 Thu, 31 Oct 2024 18:54:04 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 976BF480083; Thu, 31 Oct 2024 18:54:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 2/4] usb: tcpm: avoid resets for missing source capability
 messages
Date: Thu, 31 Oct 2024 18:50:31 +0100
Message-ID: <20241031175404.114773-3-sebastian.reichel@collabora.com>
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

The current TCPM code implements source capability message handling
according to the USB-PD specification. Unfortunately some USB PD
sources do not properly follow the specification and do not send
source capability messages after a soft reset when they already
negotiated a specific contract before. The currently implemented way
(and what is described in the specificiation) to resolve this problem
is triggering a hard reset.

But a hard reset is fatal on batteryless platforms powered via USB-C PD,
since that removes VBUS for some time. Since this is triggered at boot
time, the system may get stuck in a boot loop.

For example I noticed the following behaviour on a Radxa Rock 5B
combined with an affected power-supply:

1. The system is booted up with current code
2. A reboot is requested
3. U-Boot TCPM / fusb302 driver sends soft reset and waits for the
   source capability message
4. No new source capability message is send by the power-supply
   after the soft reset
5. U-Boot sends a hard reset
6. The board resets, but the fusb302 registers are not reset. This
   is because of a hardware glitch. The serial pins are high when
   no data is exchanged. Apparently the RK3588 has protection diodes,
   which leak some voltage into the power-domain. The Rock 5B serial
   pins and the fusb302 are using the same 3.3V power domain and the
   leaked voltage is enough to keep the fusb302 registers alive.
7. After the hard reset the power-supply sends another source capability
   message, which is auto-acked by fusb302 (because the register state
   is kept) even though the U-Boot driver has not yet probed. Once the
   U-Boot driver probes it sends another soft reset and waits for a new
   source capability message, which never arrives.

Fortunately the affected power-supplies (I have two setups showing this
behaviour) support sending a source capability message when explicitly
being asked. Thus an easy workaround to handle this is deviating from
the USB-PD specification and sending a Get_Source_Cap message and
waiting some time longer before doing the hard reset.

Note, that I recently added the same workaround to the Linux kernel
with a slightly different rationale (since it needs to take over from
U-Boot).

Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/tcpm/tcpm-internal.h |  1 +
 drivers/usb/tcpm/tcpm.c          | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/tcpm/tcpm-internal.h b/drivers/usb/tcpm/tcpm-internal.h
index 561442090027..4861f4d13866 100644
--- a/drivers/usb/tcpm/tcpm-internal.h
+++ b/drivers/usb/tcpm/tcpm-internal.h
@@ -30,6 +30,7 @@
 	S(SNK_DISCOVERY_DEBOUNCE),		\
 	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
 	S(SNK_WAIT_CAPABILITIES),		\
+	S(SNK_WAIT_CAPABILITIES_TIMEOUT),	\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
 	S(SNK_TRANSITION_SINK),			\
 	S(SNK_TRANSITION_SINK_VBUS),		\
diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index b754b4dcd0b5..786d92fa4c6f 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -1424,7 +1424,8 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
 		return ERROR_RECOVERY;
 	if (port->pwr_role == TYPEC_SOURCE)
 		return SRC_UNATTACHED;
-	if (port->state == SNK_WAIT_CAPABILITIES)
+	if (port->state == SNK_WAIT_CAPABILITIES ||
+	    port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
 		return SNK_READY;
 	return SNK_UNATTACHED;
 }
@@ -1650,10 +1651,35 @@ static void run_state_machine(struct udevice *dev)
 			tcpm_set_state(dev, SOFT_RESET_SEND,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
-			tcpm_set_state(dev, hard_reset_state(port),
-				       PD_T_SINK_WAIT_CAP);
+			if (!port->self_powered)
+				tcpm_set_state(dev, SNK_WAIT_CAPABILITIES_TIMEOUT,
+					       PD_T_SINK_WAIT_CAP);
+			else
+				tcpm_set_state(dev, hard_reset_state(port),
+					       PD_T_SINK_WAIT_CAP);
 		}
 		break;
+	case SNK_WAIT_CAPABILITIES_TIMEOUT:
+		/*
+		 * There are some USB PD sources in the field, which do not
+		 * properly implement the specification and fail to start
+		 * sending Source Capability messages after a soft reset. The
+		 * specification suggests to do a hard reset when no Source
+		 * capability message is received within PD_T_SINK_WAIT_CAP,
+		 * but that might effectively kil the machine's power source.
+		 *
+		 * This slightly diverges from the specification and tries to
+		 * recover from this by explicitly asking for the capabilities
+		 * using the Get_Source_Cap control message before falling back
+		 * to a hard reset. The control message should also be supported
+		 * and handled by all USB PD source and dual role devices
+		 * according to the specification.
+		 */
+		if (tcpm_pd_send_control(dev, PD_CTRL_GET_SOURCE_CAP))
+			tcpm_set_state_cond(dev, hard_reset_state(port), 0);
+		else
+			tcpm_set_state(dev, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
+		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 		port->pd_capable = true;
 		port->hard_reset_count = 0;
-- 
2.45.2

