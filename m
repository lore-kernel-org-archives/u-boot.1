Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B502C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 20:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE7982E40;
	Thu, 26 Jun 2025 22:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="b/xww4JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44ED982D88; Thu, 26 Jun 2025 18:20:32 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9AD82B34
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DAF944256;
 Thu, 26 Jun 2025 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1750954828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BeiCATtRmIgB4hqP36/ht12UtiECV4C5jA8camgT1Xg=;
 b=b/xww4JZBAlERA95QEXmQ4eloc3yN0bn2J/oImxvnrY/UaZtZjHr3TzYisTGK4nmX8SVHK
 Yq8VdT1Ma83gZzaxsZd8JD6q7SxLRUtmXnMOtHktH3cQ+rvhIxQvrDnBI0UMj+qx9W19o3
 9qnjEj9cUAgeXZL6bdLyXYDXVcVigD5QqCXrbYzTowC/vr4NNIO037O9LBQ0C0Co1yNrK1
 /nLr9RuF5ikEB/Ew1Hzj4wsAV/O37PPfdaGKk6AkU27OD6Hb6aptQKLMaWjpiR+XKdZWLl
 WiBBHNpyiOe3gveyUenEwksyD0qVu9u3d1RTIKuTR9/kzKMEXSHTfOcIieWPnA==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH 0/2] board: ti: am33xx: Add Ethernet support for Beaglebone
 Green Eco
Date: Thu, 26 Jun 2025 18:20:23 +0200
Message-Id: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdzXWgC/x2MQQqAIBQFrxJ/nVBWkl0lWqi98m8sNCKQ7p60n
 IGZTAmRkWiqMkXcnPgIBdq6IudN2CF4LUyykUOjpBLWFofLIwZcwnUOZtTa9BZUmjNi4+f/zcv
 7ftE9g5lfAAAA
X-Change-ID: 20250626-bbge-ethernet-c3cea899a4be
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: "Bajjuri, Praneeth" <praneeth@ti.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdetffdvffetkeffhefgfefhfffhfeffteelleeilefftdffiefggedufeekgfeinecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepjhhovgdrhhgvrhhshhgsvghrghgvrhesnhhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrfhhrihgvugdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehmihhguhgvlhdrghgriihquhgviiess
 ghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrnhgvvghthhesthhirdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtoheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com
X-Mailman-Approved-At: Thu, 26 Jun 2025 22:17:29 +0200
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

Hello everyone,

This is version one of my series which enables Ethernet support on the BBGE
board. This requires three main changes:

 - Describing the MAC<->PHY link and DP83867 PHY accurately in the device
   tree
 - Enabling the RGMII1 pinmux configuration
 - Enabling the DP83867 driver

These changes are all applied in patch 2.

Patch 1 enables excluding the DP83867 driver from SPL. This is done to
avoid size issues when adding the DP83867 driver to the am335x-evm
defconfig.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Romain Gantois (2):
      net: phy: dp83867: Allow excluding driver from SPL
      board: ti: am33xx: Add Ethernet support for Beaglebone Green Eco

 arch/arm/dts/am335x-bonegreen-eco.dts | 19 +++++++++++++++++++
 board/ti/am335x/mux.c                 |  3 +++
 configs/am335x_evm_defconfig          |  1 +
 drivers/net/phy/Kconfig               |  4 ++++
 drivers/net/phy/Makefile              |  2 +-
 5 files changed, 28 insertions(+), 1 deletion(-)
---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250626-bbge-ethernet-c3cea899a4be

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>

