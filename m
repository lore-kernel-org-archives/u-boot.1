Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B0EC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B908070C;
	Sat, 18 Jan 2025 07:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hwn96XpT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ngaSfX1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF7880657; Sat, 18 Jan 2025 07:54:30 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8AE80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnQW1xfVz9sqH;
 Sat, 18 Jan 2025 07:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=plAnGfB6NvQZt8VtNQW/Nl1i18c5PIIHZwacMDmzLEU=;
 b=Hwn96XpTSY2pN5Aad6rJTlwWESA4IY98fZIV5r/thGWlu3zBl+sumUx6OxXR5RVGlwnUL0
 ojo0rzaXRiIvMleR5KfjgDiuCZuweQ9cd5NxE+CK9PVKMamMQq7PGit/e8Qs78pTwDPIxi
 8Dn7Px+o9+4NFOxzWdb5/+a94VZoTrxIyarye8pSbTx6Rh9oTQ/GZQGYh9ooioUrkAdwXF
 Pw8JG8aVyRTlSiVkJdbvJDlpUkzQFh5wNKqEc+Z6IieimVGUmp/8hlLEeu6tyP7lpJRcun
 OYdWPr68PWRwmaJ/iO+rb3kMAPlKoegUYWc7QahiG8pIrbicuE85uRmthjoRJg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=plAnGfB6NvQZt8VtNQW/Nl1i18c5PIIHZwacMDmzLEU=;
 b=ngaSfX1zGx8f5P1eoKUPYvKH/U2HUP6aHin7IpPt8Hq5k3Vs7fRFk8nXzo3w19u6SSIGob
 iDlcvwKzIlETs7RV42pDBJyiETDwg5TUSaXLezgYq84Zx2R9NRqj4vzw3z8ClH0JSLxwCx
 bW0K+OaQ98kxe8FLE3qMuaJFvunhB5QQ2Wj2fiDe+zMxHPFAcdydP+YnhaPIwY2OTLTZ+Q
 xlw/ekaar78okdARJ+xbC3HMmkUfB6DGImMOD/XJ7OhoHOGyuAyl056uVMS/8FFOdrgy7p
 UrflAvWVZ/fprWw/1WvP6cuuwSgFRmAquFRyhZU+x6JU9h6ybcQ43yqg4vI0cw==
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
Subject: [PATCH 01/17] miiphy: Introduce mdio_init()
Date: Sat, 18 Jan 2025 07:53:05 +0100
Message-ID: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sto79e7gp8nk38jcubi3nqd8454qj7hi
X-MBO-RS-ID: bc44cc7d29ee048774d
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

Introduce mdio_init() split off from mdio_alloc(), which is used
to initialize already allocated struct mii_dev.

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
 common/miiphyutil.c | 13 +++++++++----
 include/miiphy.h    |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 9b8744e5d8b..2a034d3a77c 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -65,6 +65,14 @@ void miiphy_init(void)
 	current_mii = NULL;
 }
 
+void mdio_init(struct mii_dev *bus)
+{
+	memset(bus, 0, sizeof(*bus));
+
+	/* initialize mii_dev struct fields */
+	INIT_LIST_HEAD(&bus->link);
+}
+
 struct mii_dev *mdio_alloc(void)
 {
 	struct mii_dev *bus;
@@ -73,10 +81,7 @@ struct mii_dev *mdio_alloc(void)
 	if (!bus)
 		return bus;
 
-	memset(bus, 0, sizeof(*bus));
-
-	/* initalize mii_dev struct fields */
-	INIT_LIST_HEAD(&bus->link);
+	mdio_init(bus);
 
 	return bus;
 }
diff --git a/include/miiphy.h b/include/miiphy.h
index 1e6c7041fdc..f385f3f47e7 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -44,6 +44,7 @@ struct phy_device *mdio_phydev_for_ethname(const char *devname);
 
 void miiphy_listdev(void);
 
+void mdio_init(struct mii_dev *bus);
 struct mii_dev *mdio_alloc(void);
 void mdio_free(struct mii_dev *bus);
 int mdio_register(struct mii_dev *bus);
-- 
2.45.2

