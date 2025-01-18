Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD7C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5FA8063E;
	Sat, 18 Jan 2025 07:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YXXCtY/M";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WjoprHqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16508073D; Sat, 18 Jan 2025 07:35:22 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 179C380312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZn0R3l3vz9sls;
 Sat, 18 Jan 2025 07:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737182119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6qj3dfPDMN2e7eEjgNJL25CflvkipdbQL30KEtHhXBs=;
 b=YXXCtY/MoQyPjOVRgsjvwOqEwzuQt5VC9+ISCjk0mihc3lgaPFl77BFW4Hm1odlz1YNdcD
 fLefIroPWL0n58vwvOIKaU2drhs5713DgUQ0xtUxJdbBLjzxXvM8NhwEDuUsWf0rZlXlyS
 3BUv2aaKyouENG2I3Dt1rQ4wETuTEjm8fgTTi5cUlZn668FTBzkoyyW4Bzm+bko7U4VF2W
 N0henV9nQHju0hICfXNSPs0jGvrFHWpap5EwYHYE//IvVq//5NRPKr33Pa+nCQboSUUCOm
 YgAX6FZPJ8F4NNUkl+z7kS8P7yAzZl/RKOozwr7tx8ZmEjk1WXhGGatuCpKY+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737182117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6qj3dfPDMN2e7eEjgNJL25CflvkipdbQL30KEtHhXBs=;
 b=WjoprHqOWOzUBEKsBEZPm9Rk0YQ+UXhA7tOz80CQ+1tQSITT8KoBW330ToqMDv11ilP0tL
 X4nimVyG+eN1B0JlQK1s1gsrHNpWjtWvpG5n3RGAiAm420HAKsPZeM0Voq7KSyvihBe///
 xoORAlH+Pb2uCFb+UdyxBfBDomkYxcBYFLbWFEsKbhpg+Ks51WxVyzZZxUiEvlsB62CtNP
 dfd1IYN228QwPx07zJSp6RI1TDS2slIhbZyISG8nSahh/0OJ87zAuFK3Sia5sbJPF0rxA4
 Hk1Ct6Sj8gf0Tp+yo3bVnAGdwsYh1lK71ZfKsBTcX0tBDyoC0BzqZuKi5WZoiw==
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
Subject: [PATCH 1/2] net: ravb: Drop empty init callback
Date: Sat, 18 Jan 2025 07:34:36 +0100
Message-ID: <20250118063458.137258-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4b5e8550f4bfb4f5b8f
X-MBO-RS-META: 88ab6dig95new749s9rdhoei3z85ujpc
X-Rspamd-Queue-Id: 4YZn0R3l3vz9sls
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
 drivers/net/ravb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 7286ad19598..f9c27f0f370 100644
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
@@ -626,7 +621,7 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "ravb",
-		.init		= ravb_bb_init,
+		.init		= NULL,
 		.mdio_active	= ravb_bb_mdio_active,
 		.mdio_tristate	= ravb_bb_mdio_tristate,
 		.set_mdio	= ravb_bb_set_mdio,
-- 
2.45.2

