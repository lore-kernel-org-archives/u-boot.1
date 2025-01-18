Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8DDC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 872A280778;
	Sat, 18 Jan 2025 07:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AXfBcQrg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ccausiMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA1080759; Sat, 18 Jan 2025 07:54:40 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39E180786
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZnQk3lQfz9stb;
 Sat, 18 Jan 2025 07:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1oDEe6RQp2a9axxKhCvMXTZCJ7gdz1tqdMVudNh+Nc=;
 b=AXfBcQrg7bsr4J/CHtFoNLt+4M9LUPowB3jRjWJZGOdM11k2SSSN3S0yrwnB9aurDRi+Gh
 y+KIFI1NNsUTez/M6gYth43xS6fZPLQ++cncv8yJnGNVXBisXfMMPBae243rJcwBkkozQF
 RoXrmOwqgGuSTerZc6uCvt6T6VEZmrssV/Xo3Z/CPKkVyZGnItLXybG2c7dWAnP8vxlQiO
 R82GEOC+uRREOw3Oz1f0dDBXHmIqob46kb7wkep4ydlZojMKNpoQjxbw1ztPhglTS23agO
 QLuYdeuQteKHKgoqeJw9defrMGFjqIdADxEIVndn7fo3cPQdCtnOPjFon3BWTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1oDEe6RQp2a9axxKhCvMXTZCJ7gdz1tqdMVudNh+Nc=;
 b=ccausiMunzuUV9WdZeLfWWhZ/4LHi3RZMuiO3U0sLcWLRhYDz3qrNuovM6wSdhjGLYBZWY
 zU2mEWb+bYs3pqN1+lZtPtUCjlQI6yiD0hELpluuj3Ba8oplMhhF0tr45q422oSSL0Z+jr
 0YE1XniJu5FadJwabIrGKHAIIItcWo90hlOyK7b5/ybt5LKGFrbUg+BDlyKdXyze3Fs693
 C3lmCR0AnE5s2QeJSS8u9IGC20M78r8/g8TGZ8J3rbQ1QDT61hSmww0KG434ksQmqgdt3v
 1fwIW7cIHnr273Ems80Fxo0bDuDESQUGMRPFvi+EXNLyUnHkAPjBHdqrGF3Kyg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/17] arm: mvebu: a38x: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Date: Sat, 18 Jan 2025 07:53:10 +0100
Message-ID: <20250118065402.172253-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f6ag1brf4wqds1f9p9nomx6jrsfabw5d
X-MBO-RS-ID: 9db342d602d5bf7e4d0
X-Rspamd-Queue-Id: 4YZnQk3lQfz9stb
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

Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
currently listed in bb_miiphy_buses[] array. This is a temporary
duplication of assignment to avoid breakage, which will be removed
in follow up patches. At this point, the bb_miiphy callbacks can
reach these accessors by doing container_of() on struct mii_dev.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/gdsys/a38x/ihs_phys.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 3370a4fa1a3..aa738016025 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -221,16 +221,30 @@ static int mii_delay(struct bb_miiphy_bus *bus)
 
 int register_miiphy_bus(uint k, struct mii_dev **bus)
 {
-	int retval;
-	struct mii_dev *mdiodev = mdio_alloc();
+	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
+	struct mii_dev *mdiodev;
 	char *name = bb_miiphy_buses[k].name;
+	int retval;
 
-	if (!mdiodev)
+	if (!bb_miiphy)
 		return -ENOMEM;
+
+	mdiodev = &bb_miiphy->mii;
 	strlcpy(mdiodev->name, name, MDIO_NAME_LEN);
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
 
+	/* Copy the bus accessors, name and private data */
+	bb_miiphy->init = mii_mdio_init;
+	bb_miiphy->mdio_active = mii_mdio_active;
+	bb_miiphy->mdio_tristate = mii_mdio_tristate;
+	bb_miiphy->set_mdio = mii_set_mdio;
+	bb_miiphy->get_mdio = mii_get_mdio;
+	bb_miiphy->set_mdc = mii_set_mdc;
+	bb_miiphy->delay = mii_delay;
+	strlcpy(bb_miiphy->name, name, MDIO_NAME_LEN);
+	bb_miiphy->priv = &(gpio_mii_set[k]);
+
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
-- 
2.45.2

