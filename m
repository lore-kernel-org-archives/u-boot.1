Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E879BC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241008070C;
	Sat, 18 Jan 2025 07:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CmYMtil+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S8g1LbO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0D780758; Sat, 18 Jan 2025 07:35:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A320A80657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZn0V1z3zz9sb6;
 Sat, 18 Jan 2025 07:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737182122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9+798ThtyquuZ4cmlWzckotXwQ8fBrw4xaGaBKN4z4=;
 b=CmYMtil+7WXm+FK9c2KU5hGamkW9b4LNkBUp6g8tjbFWmUjzmKko+wpuuzRLS6ODJ9mnwK
 jqn8JUS2jPz8ocdbeU7PKc942loP0+x5YSrDi2BEajudGW9koet+xsAGbG9OK5IpeCH9K2
 0cLx37LiSJxslJzrrM1xR6b/SjeK0UFNtrELDm+T2h23cdT5DjwxkJjXITl5d+f/eSZ+bB
 YGPd9v2To1Im28/LZi9jNBrdfG+Sm+e07RojB0XIiWB50lik5n29qbNHQJmai5CVSZzePZ
 ebBX0y10lNUGnoDh4QL4DZn5SlL2zvMpFrK2geC6GY6qc4xVPZSULI7a5CEZnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737182120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9+798ThtyquuZ4cmlWzckotXwQ8fBrw4xaGaBKN4z4=;
 b=S8g1LbO4YudPafv/vRPoKvtEbeuNjpiWXYI2U5O/rcl6AxCKmA0XTH9khmrl2vSGer9GJD
 MupLzl2UuH5dcarwZeYkN5BpHA5l4N6npvYANqgVJJFBhK2IDxi0Q0aN9CJi43ydnX9dXv
 NXxkZx0bA+mf9LqrnQcFb5kTjsSnxFjUycE31llFCdl7cfYFTSAfpXXQVm+MuvND18ewwa
 twQY6oN70fejt31yLLhCA4lbUoB1BKqM+a92AXQay12T/7tgfGHvpTAUvMm7YaDSliiJaT
 tGi3t+5rSwZNpHqXQnhqABhOw7v2c38BZWybv3nyvcRYT4RF+bYTgTC7hhqljw==
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
Subject: [PATCH 2/2] net: sh_eth: Drop empty init callback
Date: Sat, 18 Jan 2025 07:34:37 +0100
Message-ID: <20250118063458.137258-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118063458.137258-1-marek.vasut+renesas@mailbox.org>
References: <20250118063458.137258-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: psytspgiwx3bid5aoe4or77omxa8k3ng
X-MBO-RS-ID: e30275deaa22ad8e7a6
X-Rspamd-Queue-Id: 4YZn0V1z3zz9sb6
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
 drivers/net/sh_eth.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index f1ce994cfd5..8654f1b8085 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -777,11 +777,6 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 };
 
 /******* for bb_miiphy *******/
-static int sh_eth_bb_init(struct bb_miiphy_bus *bus)
-{
-	return 0;
-}
-
 static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
 {
 	struct sh_eth_dev *eth = bus->priv;
@@ -852,7 +847,7 @@ static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "sh_eth",
-		.init		= sh_eth_bb_init,
+		.init		= NULL,
 		.mdio_active	= sh_eth_bb_mdio_active,
 		.mdio_tristate	= sh_eth_bb_mdio_tristate,
 		.set_mdio	= sh_eth_bb_set_mdio,
-- 
2.45.2

