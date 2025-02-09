Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121DC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E5C80834;
	Sun,  9 Feb 2025 13:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="czOIoLW4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qOhjq+E6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9AB80819; Sun,  9 Feb 2025 13:04:42 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744F2807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YrRGG2G7Wz9ssH;
 Sun,  9 Feb 2025 13:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ThIZsNp2yxGYMwcwftg2MVJAg+bdGzhxXzKOj46flX8=;
 b=czOIoLW43abxcrLyAId+1CB4uc7SJ5sOY/KT9TqlFNzG/Df2zFWEITW2i7Cdcp+UF3g8Pi
 h65dt1HWtoo3ZLYoAcFwY6Jur8HxLyYNWQfPgGtyfL0n7oVrIVrPz0xh89EpT4/VGsFooY
 D0glAYZ913BRR90HGkrFCoaalSK/lWniemHq+GHlSVOZNM242eq3v9Jq+TCDNDdi4NwyOO
 LCOEhE/ZMBByeVRedy+/ZDERoNx/i4g88aTWXHvP43bz1+1CmTBm2VgjRd4EnXM3bhjju9
 N101UKYaU49YZGy/aj6zfOF3sx68HOS8TSoClmBhaz7V0YyAsjXnMgnmAym40w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ThIZsNp2yxGYMwcwftg2MVJAg+bdGzhxXzKOj46flX8=;
 b=qOhjq+E6um68lUUj0SMlV6utk9XXxVK3Ss58bnC7dT4BoYkxAzOjEOfCiJYPec3PJegKFH
 ua0lUrYn6V42meLGT3KtFGJYszL9CngfYFrW+MBv1Cb161t+vZJsO2H4h2hHVlthrXeghz
 McdtWO9AH9o7aWWoC98JvIv9DyA+ynr1yNNLutT8oEE8WEr32OSkEIE3Rg8z5HxMDswPSa
 T4lCWMdp4+VkewJ3Tlfg3lQHQtvbSyRfiti9EQyzqsRcC2wE7mEAyPa/JcpAbSHbyBv0el
 ohizHnNcOhFJ3LbNBoPXFjJJG33ZXj6dG5yGg6xcLUD7Er1woHLGLgOsDQ3jiQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/24] net: ravb: Drop empty init callback
Date: Sun,  9 Feb 2025 13:01:27 +0100
Message-ID: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11b2e380bb4af422b13
X-MBO-RS-META: fssx7m3879bqsaypko8zsdr56kxja37f
X-Rspamd-Queue-Id: 4YrRGG2G7Wz9ssH
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

The init function does nothing, the bb_miiphy_init() already checks
whether the .init callback is assigned, and if not, skips calling it.
Remove the empty init function. The entire init callback will be
removed in follow up patches.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
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
V2: Drop the = NULL assignment early in here.
---
 drivers/net/ravb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 7286ad19598..5df557da7da 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -560,11 +560,6 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-static int ravb_bb_init(struct bb_miiphy_bus *bus)
-{
-	return 0;
-}
-
 static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
 {
 	struct ravb_priv *eth = bus->priv;
@@ -626,7 +621,6 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "ravb",
-		.init		= ravb_bb_init,
 		.mdio_active	= ravb_bb_mdio_active,
 		.mdio_tristate	= ravb_bb_mdio_tristate,
 		.set_mdio	= ravb_bb_set_mdio,
-- 
2.47.2

