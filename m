Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C932C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 20:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFF082E8E;
	Thu, 26 Jun 2025 22:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ggx634YL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAC082D88; Thu, 26 Jun 2025 18:20:42 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EBC82B34
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEDD644219;
 Thu, 26 Jun 2025 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1750954829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMnnWqyMFXgEiR+inAYnw8H+ngjg4tMEl+ocxqZ+2Dg=;
 b=Ggx634YLG9e6IQ0+kbMFpUx4uYLNAEuMKOk79A6yFOvj74FsolPt5vBA1wwyRl5+GRX9mW
 VNHej313nWoXG6hashAcXps1Wgahl+l/KbuCziIM8GMpRfzMZ97mgDZaH+sQGskNRyPt/1
 wY8sk9lzKLXH/jXNjoijTsZHQRqXhl5rvz/u7RL9hKNjTmn9J+VHY29nuOfxXCDo84+e8f
 3V9ad2PujHg4CIHMnFHAPF/VPHY8gTCfSH3hmnjAP+6/v0UyCfqxHVRj+K/1EufqSa2KjG
 JQTFiCl02ol0D8xjLQhpg7vpCw3xT/XjD4eBjSO0FmWqRZjncTrgC/VtEuSGRw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 26 Jun 2025 18:20:24 +0200
Subject: [PATCH 1/2] net: phy: dp83867: Allow excluding driver from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-bbge-ethernet-v1-1-5b544fb1898f@bootlin.com>
References: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
In-Reply-To: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeelieefteelffeuheevtdetkefhfffhteffkefgtefhkeevudeutdeugfffheegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepjhhovgdrhhgvrhhshhgsvghrghgvrhesnhhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrfhhrihgvugdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehmihhguhgvlhdrghgriihquhgvi
 iessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrnhgvvghthhesthhirdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtoheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhm
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

The DP83867 PHY driver is used by the BeagleBoneGreen Eco board, but adding
it to the am335x-evm defconfig causes SPL to overflow its size limits.

Add a separate option to enable this driver in SPL, so that it can be
enabled in U-Boot without adding unnecessary volume to SPL.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/Kconfig  | 4 ++++
 drivers/net/phy/Makefile | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3132718e4f80a5255e45cf73922dd71abb368888..8d88c14290033e36312c32479d19fa4dbde85ac1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -314,6 +314,10 @@ config PHY_TI_DP83867
 	---help---
 	  Adds support for the TI DP83867 1Gbit PHY.
 
+config SPL_PHY_TI_DP83867
+	select PHY_TI
+	bool "Texas Instruments Ethernet DP83867 PHY support (SPL)"
+
 config PHY_TI_DP83869
 	select PHY_TI
 	bool "Texas Instruments Ethernet DP83869 PHY support"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2487f366e1c68488707cc21f710530591bef7d8d..a119eb5e177b8a895f6d7a5b48e417feab620fb3 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_PHY_REALTEK) += realtek.o
 obj-$(CONFIG_PHY_SMSC) += smsc.o
 obj-$(CONFIG_PHY_TERANETICS) += teranetics.o
 obj-$(CONFIG_PHY_TI_GENERIC) += ti_phy_init.o
-obj-$(CONFIG_PHY_TI_DP83867) += dp83867.o
+obj-$(CONFIG_$(PHASE_)PHY_TI_DP83867) += dp83867.o
 obj-$(CONFIG_PHY_TI_DP83869) += dp83869.o
 obj-$(CONFIG_PHY_XILINX) += xilinx_phy.o
 obj-$(CONFIG_PHY_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o

-- 
2.49.0

