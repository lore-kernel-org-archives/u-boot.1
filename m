Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F54CD68E5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D1986D85;
	Tue, 10 Oct 2023 11:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="imozZEp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007EB86D65; Tue, 10 Oct 2023 11:03:23 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7FF86D78
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A858E000A;
 Tue, 10 Oct 2023 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696928587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMLE1EXnnNnrINQDbLNepPgxOCo1o/jRTTgHe7LN2gQ=;
 b=imozZEp6oY3A6al+5K1xlzGpxUQ8z3BfX320FPtEdMkBSSrMX//UK+pIiEiaLjRnHhG6B1
 J/RNa4Cur+vb4MQc0YRG35AE7IpXyD1YNJRcxNfgFb9x/vIt156NV8uylwLC++QfZ9LWdR
 jNG4PsX/ixHt8ckLnc5q/sbVvu9S25j3Fq2qDi/8f+Eo7wj8AndB4ImVWo/N3qgBBOBFTX
 GCiI2QismjfMmixaBuJUC32p45j/vtS9ZksghkuUTrr/of6mxRE0FKKvN2k6+ET/AL5ow/
 snX8BTh2dsbIs+bV3s6mFcHtTltsiBpyhB3gKHcGxUxni0CdIAhth75cPemShg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marek.vasut@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/3] cmd: Change the dependencies between CMD_BIND and
 USB_GADGET
Date: Tue, 10 Oct 2023 11:03:02 +0200
Message-Id: <20231010090304.49335-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010090304.49335-1-miquel.raynal@bootlin.com>
References: <20231010090304.49335-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

Today CMD_BIND defaults to 'y' when USB_ETHER is enabled. In practice,
CMD_BIND should default to 'y' when any USB gadget is enabled not only
USB_ETHER. Let's invert the logic of the dependency and use the weak
'imply' keyword to enforce this.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/Kconfig                | 1 -
 drivers/usb/gadget/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69cc..6cc3bf6c2d0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -996,7 +996,6 @@ config CMD_BCB
 config CMD_BIND
 	bool "bind/unbind - Bind or unbind a device to/from a driver"
 	depends on DM
-	default y if USB_ETHER
 	help
 	  Bind or unbind a device to/from a driver from the command line.
 	  This is useful in situations where a device may be handled by several
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 1cfe6022842..44f47a07207 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -17,6 +17,7 @@ menuconfig USB_GADGET
 	bool "USB Gadget Support"
 	depends on DM
 	select DM_USB
+	imply CMD_BIND
 	help
 	   USB is a master/slave protocol, organized with one master
 	   host (such as a PC) controlling up to 127 peripheral devices.
-- 
2.34.1

