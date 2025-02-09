Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0280AC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C0A80885;
	Sun,  9 Feb 2025 13:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PZcIxh0O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lyaL6jHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0922780BA4; Sun,  9 Feb 2025 13:04:57 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9F380A29
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YrRGZ5NfHz9spj;
 Sun,  9 Feb 2025 13:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FH3efhVwlBV4EG43O6r7iQI+LkiLkZr0lSPA5zJe1Q=;
 b=PZcIxh0Ocy7ymkZsvkPCiKJErl8O1Pqa1+355MDvZjVWdcVgoL8/GJuEezwHCTNZ7bM28q
 R3vKXtlgB52TRYU02gsNe2tr8VB+dxANlkg9ukP9tTAojEd1DCI4tucdr95hO+uBzwSMzO
 WA68gGZ8iZJGVdeM1H1SR70/gETa9fdFHLH/SConrqG0XAQdQgQam0H/V/+HhPekRfU7pi
 I9GKblW8lv1sb4lntMx8E+mmXF41h7BpJ9sK6SbyO6pMQx+upyo2KeuGl07TdzrfY1Mh18
 /DXpq36OPhbMDGJbQVTnG8Ns/Fmg/LaoA+d85YwM3iRrAyW34jszXkw9rj5zTA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FH3efhVwlBV4EG43O6r7iQI+LkiLkZr0lSPA5zJe1Q=;
 b=lyaL6jHJiO483BgubrzGwJLOeBU8DtlhICqWXGHaTZx/G/Ztf9B6RNbnfzd6WW/ftBmmD0
 q+HWA6+Jz4h92M1WLGY5F5xfLbUvHEv3wtFPYBVCZ/3NlSOHvWpy+3dBmmOAgfOlirAF72
 c+4HYGOBW+3c9ilqmt+wxF4W3iTu5ohBv4WWtvzBYgp/i2XVHgmEcbzCUjgRZnal4nEef+
 xhn6JawqnSnWtDyImDtiek5rvh922ODO+X0yszWOGDXDVgdqdK6StpCdL+xXw50cNHp0x7
 KCLjzdWIaSFgtFDNfYbYDC+4135AXTjSc0m4+9/z1YmLZFcD7SpE3/CCc3+9SQ==
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
Subject: [PATCH v2 08/24] arm: mvebu: a38x: Call bb_miiphy init directly in
 driver probe
Date: Sun,  9 Feb 2025 13:01:34 +0100
Message-ID: <20250209120403.5321-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 517e363d81253152f07
X-MBO-RS-META: edo585cy75fty37yqs7rkkt57tuw5f1s
X-Rspamd-Queue-Id: 4YrRGZ5NfHz9spj
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

