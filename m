Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C794DD767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6F7892A2;
	Thu, 31 Oct 2024 18:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hHijoMXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A369B8929F; Thu, 31 Oct 2024 18:54:10 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79942892DA
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1730397245;
 bh=zorlERACLF2S8eMJ5ZJytJvWKMVDGcQWENtfxCEoqVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hHijoMXPZCWWLDIzTmkk4MljP4GvLOusJpQY1tGHQg20FsB/G1qLCtBXE/GwDVimQ
 RKw3Ebz7LLhGqSW9PyL/AKZ/AKUU8RKX3nOJIcH2npu3bbm0WyE88EZ9IhaaYm56IP
 0HUYaytl+B/mR/g3p6obAsUr62Gm1QA/DxWqMLkpBqrOvRpy2n5pGEqmVJVD/qe48S
 zhI7sjU1likrZOHQ/yR2HbTGIBgr7tCG44Q1cw/6W6FMgAzrH8De1tMf6cW0pDHIdG
 UKuzDekKuwhFrv0GM+ja5p8osA0XTdypCC7WnEGkgSErzfncGfj0j/LLdwK8ERXYaq
 VrNYR767TH9og==
Received: from jupiter.universe (dyndsl-091-248-210-236.ewe-ip-backbone.de
 [91.248.210.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 07CAB17E36CB;
 Thu, 31 Oct 2024 18:54:05 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9949E480084; Thu, 31 Oct 2024 18:54:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 3/4] usb: tcpm: print error on hard reset
Date: Thu, 31 Oct 2024 18:50:32 +0100
Message-ID: <20241031175404.114773-4-sebastian.reichel@collabora.com>
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
2.45.2

