Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAF9C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043BB80FC2;
	Sat, 22 Feb 2025 21:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WzLq278E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="buuIcm0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1285880F92; Sat, 22 Feb 2025 21:36:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C8E800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z0f0X4wv6z9tfy;
 Sat, 22 Feb 2025 21:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9NFyhi0AOyGaPvoQ8HIdh2YeWqRQBdaEMXOyQVF6K4=;
 b=WzLq278EeSchuyl89EoT5V33LwOk2VeVO4eGMNywwj/WnaVx/3KvWRdVBRMyUBnnGrmg/l
 TeK439Tjl/o4g8cvdbbHCGviU1wcWUzRS4UdPQ0NxDcq8f0IrVS8MyPOr/ql41dUK8VfVQ
 IYfwVB5atTAdPxkdYSq45Sc+Xxjk0kPyXNjOXjyMO6yPbNIc6dSv8abACOXeSiYnveBsUO
 nJROEGl0Z7bv8IVoPXX+3Zleidlh6nUKL1AVTHPsGqEkLX5ovUUUbUcjRqwynsaqLC3ked
 ypvBu6jTyAg9RI/IDiiRUgbDV0WWrliebCuJelTY8i3Wd+qUne6aFsCsGMSG8w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9NFyhi0AOyGaPvoQ8HIdh2YeWqRQBdaEMXOyQVF6K4=;
 b=buuIcm0s93Np7RpcL3EnlOnfhPycAXb6FQ3olHkqn0wDQV5y0PJAPLxoopv72eMpZqNUDZ
 lPHZ1SXt0wOew0IpEs8R9rkUau27msKr88XBMFzJE4cghzc9RWUs0VLsnPDyBNtCJHwiw4
 uLAnwagHyNXEfjqNRd+JRgCnW45bfWJlmo5oMs38aeR9utM542d+yX+Min+Eg8WmeVE+1A
 zv0/7rKutPP7lbGoa79UaXpPODWx352nX+F8pS16i1T6hmMrYNNSY+ou/lYLb4AEkloGQ8
 xUSfUxec2X4mHVDmZWnL6IMcg5Q9FkhiYHYwB3YVxWtNbUXGXbqVftv81P5Fzg==
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
Subject: [PATCH v3 08/23] arm: mvebu: a38x: Call bb_miiphy init directly in
 driver probe
Date: Sat, 22 Feb 2025 21:33:18 +0100
Message-ID: <20250222203511.195437-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3f2679b9aa552b7b329
X-MBO-RS-META: wg4ews7wwa4gpjceps1c8o9aqfn1fus1
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

All the resources needed by this .init callback should already
be available by the time probe function runs, simply call the
init callback directly and set the bb_miiphy init callback to
NULL. This shouldn't break anything on this hardware, but would
be nice if someone could double-check and test that.

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
V2: Reorder this earlier in the series
V3: No change
---
 board/gdsys/a38x/ihs_phys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 3370a4fa1a3..86708ee6715 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -236,7 +236,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 		return retval;
 	*bus = miiphy_get_dev_by_name(name);
 
-	return 0;
+	return mii_mdio_init(&bb_miiphy_buses[k]);
 }
 
 struct porttype *get_porttype(uint octo_phy_mask, uint k)
@@ -318,7 +318,6 @@ int init_octo_phys(uint octo_phy_mask)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name = "ihs0",
-		.init = mii_mdio_init,
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
 		.set_mdio = mii_set_mdio,
@@ -329,7 +328,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 	},
 	{
 		.name = "ihs1",
-		.init = mii_mdio_init,
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
 		.set_mdio = mii_set_mdio,
@@ -340,7 +338,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 	},
 	{
 		.name = "ihs2",
-		.init = mii_mdio_init,
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
 		.set_mdio = mii_set_mdio,
-- 
2.47.2

