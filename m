Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFA1C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A040808E6;
	Sun,  9 Feb 2025 13:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ya6gEPii";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SJa+FxRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B448083C; Sun,  9 Feb 2025 13:04:44 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F24A807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YrRGK62srz9ssc;
 Sun,  9 Feb 2025 13:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hw6Qr3o4IjXCnQW9GwyG9TOmCtdstRqe2Z0fQhSCSMA=;
 b=ya6gEPiicBqRgW952YU78SlNnHa9yedFSFz05dgaqT8P1vknqWxj2WtGYfEkesgoZTyg8b
 p0Pxo4Oll1abBgYn0wPutQXl2A0/yi+HJQSJ9psyTO/p7IcWVLlhozIQNuQSMLeYawtLvH
 8BY1ZbEm0/f1XVaHQ8Y8oHTZ5zuU1r2LrgfqUxepGvsRGRW3KxS6KiYVYBYlouZ17vTJHB
 1dhY5xA/+uJQefyKFflgfqUbZdxJay8uwI+eZj5N+SDKZozSipbCs99fSq82CGqLrbI0wg
 hldvMlatkfbZuaETWoIM83kNuBYMgkok3qJU3jQulTyVPhITdKMlJwrZFm3MpQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hw6Qr3o4IjXCnQW9GwyG9TOmCtdstRqe2Z0fQhSCSMA=;
 b=SJa+FxRFWuMeRPAoKWqFuIlYICJU8wAAfZKQqIlGNQa1C0BDouqZfJE/UBqtKr6F9yH7Yk
 FERicfddXdXhT3jT+jjzc0NTTnOCGraX+pGGOwVo6fARyJst1u09Pz0ekHppuouXUROc2C
 Y4VTP/C67d/an2nt0uEOR25ruKK1EkWFMDD9k8nk+6nq7Gfp5kmztoxDYWKiUUSip1f+Uj
 amvC+mwPFmmCeb44PCD145g/+SztGNo7fYzqMFQ/OTkUFGfxjx7I+EFBuuahRMSoxBQY93
 MVBiAbr/vryRJudzTTNHK2agfTy6ujwbROmMey3gDN8Vh/Mo+Krw/0opKeK7Mw==
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
Subject: [PATCH v2 02/24] net: sh_eth: Drop empty init callback
Date: Sun,  9 Feb 2025 13:01:28 +0100
Message-ID: <20250209120403.5321-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yp8yii38dorstrf87m7snbsax6ipzjz7
X-MBO-RS-ID: fb1df88658804f87605
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
 drivers/net/sh_eth.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index f1ce994cfd5..b607b9a3a43 100644
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
@@ -852,7 +847,6 @@ static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "sh_eth",
-		.init		= sh_eth_bb_init,
 		.mdio_active	= sh_eth_bb_mdio_active,
 		.mdio_tristate	= sh_eth_bb_mdio_tristate,
 		.set_mdio	= sh_eth_bb_set_mdio,
-- 
2.47.2

