Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D885606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kNQEZmEf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PgxnyNfU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BA766061F;
	Mon, 26 Oct 2026 23:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JckRq6DEv-z2; Mon, 26 Oct 2026 23:46:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABA5360603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058408;
	b=SX2yy1+Ce2+w7thdQ9tQIPpZEWtlZ2gOKwXjJfNWbUbPZj2P5twkTst/NB1LVTHtlEW8
	 +7yvUZ38w5cupeEjA135qWq2FBYR2hVplY0U00qMdqvj+4afYMTXVRwuf4x+nwPU5BwnP
	 oJajvJxAmgmfaFWUFNs5cEaHO/bo6n0eVcBoccNC1PcQxHX2ZNDd4UutCUaVtkSUmXuOo
	 sh6IjqZ4Wb2fBDr27WMWyKVkSoXDEaJvjCLLcaVId1J2HrBjA/QWXoBwX+4544A1z+gMk
	 J9WR5D/C4TWbRnUf/VNlFJ5HOwaVRAYVNyNvm5+rEc1MkAdoyoOn4rjJQXWmAiE/+Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6tnI5kzsZVZh/c3uDkZzJBQ9eVJ9XkpQkaN/8Hf9G3Q=;
	b=gkn77SXDbfVx3jUOvnr8lMNmphh6fZzyTAd84X4nq5d3OSSL+WbIIiWH5q8jHdbZlAMY
	 6fEG4Tfl65zYDTAPedigMHDlFLdiMyIr7F3P0wgIS2L+HtmAcXQYuWne/PK2wwB7pAepa
	 OrONePz1gXQw5UcauJ+2lOhQqLyd+ZmIx2uTDf1ZfVldToBNCEsOqM8tx9DMzN4sX+SyP
	 oyWTCzMKJUAH79V6OgAwYuXP6A5r9h8dxnQgUSNw9Rk9BsD8zdIbaqDeaGij4J+DShyxr
	 hEEdImNQgQjqICudkJ1aoP/Q+zGoy23mRF4FZgSzBy4qCT1xbIrT1v8lWTaOBIMlFMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058408;
	bh=6tnI5kzsZVZh/c3uDkZzJBQ9eVJ9XkpQkaN/8Hf9G3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNQEZmEf3s0ln5ITyMu7t6qIHNZrs9aMJY2LXsnfp1GwglkJD7VyOQnjcvI4sbPFy
	 r1+3v6y8Yn7ROjmN/yaihD0RByei4rLzUhCVQpvsU+u0LXm+pxMtXrgHDPz65Xcw1K
	 E1+wQDAKZE4+hbCwhOZt5LqRfPq4QVpy4WTTe8/2Y7fh8xBHBVrljFu0pNeNrY3epe
	 rHv8twmaASSai9smx97Y8Ya/uW8UuXmegLtCDu4hNDc7TyX95pU5rpKTL1bzWPSOqf
	 SbP+b6jcSLhWWFD734IDiuvwH2Zvb8s65bevmyNurkxy2D6WjSiV+aHKcoy5H3IHTL
	 Vt7j/dHQuwlog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABA5360603;
	Mon, 26 Oct 2026 23:46:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC7083421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DE7A4050E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56ZVR-q2hh_3 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E89A44050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058403;
 b=fwvxUtVbSAP+iivLqYNP19j3PhIow/9QB081FTnMKDW+3ZoMXG9dsIXyHgfc3bdq/izI
 Us+iFmuxrEl5bUIrO/UUmRq7qMUp266EzczHx669VGR/oyYGa/E6oH84JQEDVWvbj975N
 Z7wKpNN7b8zhz1QxrvQnzp/SB7Ej+Ch9lHwBT351PlXMUzJPWTQE7QaSN1hAs93JctyvQ
 fL1q2WhhbfnDWO8WAKZRaI3zQgTp2x2nO5SOzNKbpS0yf6nOzQvHpKLbJbEEnRY0R5BOc
 ZPD6kqzT5SEmkquck//nSYSC5Q/qmOwUgRY0uLxLrx0eL1cq5/vvKgci/BPilHgEdHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058403;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=6tnI5kzsZVZh/c3uDkZzJBQ9eVJ9XkpQkaN/8Hf9G3Q=;
 b=GMYQKa75133/ZJ6sV5Wc+PsUvldnCrqPuW9ylgog9XVxxIMmrVt3s6sW+undkIwPhxpk
 VqWf1upxSKmKTj1AwscGqM/j/BuMsJGLENgmY0T8GHMqOl5Zvan64t2h0ifweyL+0GsiS
 s7Kk9D61wOhJpbzPoEizLA9u+cjvYKN9qH8qWnW2rP+Ykawh224Mh+WttzEe3UXiG6Jc3
 6wsFVNdcWYKRWn3zsewsjGBJhCKNRMOoGsCCXZEMfMrhFS1r+fpWZ+H90KMrtzo0kINl5
 a31OhSDUJCb2IwliSITeHugs45ls8n72IdKCk0XD+R+Dz4N46RZ3ERuDpjWe2pzWnmQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PgxnyNfU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PgxnyNfU
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E89A44050C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:42 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-8479f46ecd8so1659749a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058401; x=1793663201;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6tnI5kzsZVZh/c3uDkZzJBQ9eVJ9XkpQkaN/8Hf9G3Q=;
 b=PgxnyNfUvOnL82roDm3/8QqGIZSqNaHdGN3PFLufNWKvlOE/C52lvaXMzgMMDydOxA
 g2Tp3HrYvMAInlPlVcdUiebFlqG3jgNTY6hfjX4sBGMJiU1hMTnpQXD7ZB2TTi3on4a/
 0hfXr42UpWoAqtVWfGeIyW2gOVcBEVBKRIJ3g7FFqoxwtnRlEPmi1Jc6/LHX/UD3O0Kw
 kM2novrmYu5QzmrVLZoz1M7f8jk4nnXj9Pfo7Lty652vvn0il2oJg5eWQnLRE0XlqO7C
 90/HY3vf9tAd96BNb9TIudFLz3/FD+wINwLwjqn1AGDmFNOsuR/ZrqK3n1HdgFdigrHI
 nkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058401; x=1793663201;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tnI5kzsZVZh/c3uDkZzJBQ9eVJ9XkpQkaN/8Hf9G3Q=;
 b=SOpJ4G5MPxd51gY1S27dv9LY2Ww6VGbCO8CMrU8jnkkT/SqZj3ucm79LxkINX52L9n
 2fN+lsJPd1l0c/BjBvWZH4ztFsmZ/w+7YC+a9VPgqmopXGipTuyKSu8hiZAIpySdqyNw
 2K3xukn92vhANNpCOHPdvrM9jmFedkrFmR/HMkKYu//tG2qknqm/Aq/BZPqlP9GlbWX5
 pSl5KtGNNhoj3HxetKKhtOb+X549mQzi2B3zwuV107K85KzRexGINcxedAoVrC1BhGNY
 lpdh8TPEd65tE0YqGc31e387LUGVDarp1PE/sKXdMR6Rfz0LNnwKrOi3nsBoNKpL5vm9
 20hA==
X-Gm-Message-State: AFq9FYLEqSJlxlgR9ntlt0OkFgBuve6nfnZm6f4+czUq/5aSImOMM7H3
 QbpyOavcy6q50s7hNIqZ98DhtWqvIVLqsxqqGaHH18g8nS3X8YSjPBLH
X-Gm-Gg: AYBFou00fJwJwkUQq4uAgLwHGkZqQpxhjXJgreVFjpMlInwM9umK5DPVYB2fm9KjAnt
 BApA49sqsjBnOzoHxvzBoqEFi2bD+5nq5BX88tGYkYlKc8JDgpHx9DCyFOegD0uwrMzuz+tDEHA
 KzNzlUi2eJlqePyLq0de8dDCmHcDW1PHl1Enfif7/gtNuIuxObn2Xm9UMnQzWZL6EzNt/N+dtTg
 82dvj5h3eUXjpmvphOFTLptYuRX2SkspxPRGeN9P1WAdOxlfIZ2i/vGZeBjz+kUaKZCg5ysAwBc
 WVsvCc+il0eUA4O5CWQq9qiFH8tOgWhsAyyuFRR7uwxDKbEFL3pElwQJ/ay+m3SBRzmFFHEa0Mg
 W7xgAz+kS8E67b3zmAvn06hi90eevWY8PJgWbiuCSJkPZd6zuqDCOtSlJWNzvcTc1rdymGB3Aoy
 dvFLi0ttrFNdz656NMl6cvVVvZ0yLLPVfE3JGnXSQLx8nghjRW+clIqqCq1o6uBc2SHWn0K3Bdt
 lec7u0RCiSifhN9mm4W+K5j3WE1s26x6hT8QMSgQHaVtQeGrRP8ScKrcUom/YQx3Vn/TxTlI/eY
 /aX2RqH5c3JlAWkkcHeDn9MkG4acJ6blqSFvT22PeNh1jYWiA3IKzGHqOh2y+Anv/nc4NUs3k00
 PYv2oiSzBaNjv054C2iKtaKajKNCqxmd0chCwk6yejN1rCzH4l6EhfNW3HvSI/byAFXjMaeFUe4
 6Ll0I=
X-Received: by 2002:a05:6830:3144:b0:814:8259:781e with SMTP id
 46e09a7af769-850faa98a7dmr8746932a34.1.1793058401542; 
 Mon, 26 Oct 2026 16:46:41 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:34 -0600
Subject: [PATCH 2/9] net: sun8i-emac: propagate MDIO and PHY setup errors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-2-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sun8i_emac_eth_probe() currently ignores errors from registering its
MDIO bus, and sun8i_phy_init() ignores errors returned while configuring
the attached PHY. A failed PHY configuration can therefore leave the
Ethernet device registered even though it cannot operate.

Return both errors to the driver model. Retain the newly registered bus
directly instead of looking it up again by name. Free an unregistered bus
if registration fails, and release the PHY and unregister the bus if PHY
setup fails. This lets a later probe retry without a stale MDIO bus
referencing the private storage released after the failed probe.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/sun8i_emac.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 41c52f56d7a..29562e14e16 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -353,9 +353,8 @@ static int sun8i_phy_init(struct emac_eth_dev *priv, void *dev)
 		return -ENODEV;
 
 	priv->phydev = phydev;
-	phy_config(priv->phydev);
 
-	return 0;
+	return phy_config(priv->phydev);
 }
 
 #define cache_clean_descriptor(desc)					\
@@ -635,9 +634,11 @@ static int sun8i_mdio_reset(struct mii_dev *bus)
 	return 0;
 }
 
-static int sun8i_mdio_init(const char *name, struct udevice *priv)
+static int sun8i_mdio_init(struct udevice *dev)
 {
+	struct emac_eth_dev *priv = dev_get_priv(dev);
 	struct mii_dev *bus = mdio_alloc();
+	int ret;
 
 	if (!bus) {
 		debug("Failed to allocate MDIO bus\n");
@@ -646,11 +647,18 @@ static int sun8i_mdio_init(const char *name, struct udevice *priv)
 
 	bus->read = sun8i_mdio_read;
 	bus->write = sun8i_mdio_write;
-	snprintf(bus->name, sizeof(bus->name), name);
-	bus->priv = (void *)priv;
+	snprintf(bus->name, sizeof(bus->name), "%s", dev->name);
+	bus->priv = dev;
 	bus->reset = sun8i_mdio_reset;
 
-	return  mdio_register(bus);
+	ret = mdio_register(bus);
+	if (ret) {
+		mdio_free(bus);
+		return ret;
+	}
+	priv->bus = bus;
+
+	return 0;
 }
 
 static int sun8i_eth_free_pkt(struct udevice *dev, uchar *packet,
@@ -707,10 +715,20 @@ static int sun8i_emac_eth_probe(struct udevice *dev)
 	if (priv->phy_reg)
 		regulator_set_enable(priv->phy_reg, true);
 
-	sun8i_mdio_init(dev->name, dev);
-	priv->bus = miiphy_get_dev_by_name(dev->name);
+	ret = sun8i_mdio_init(dev);
+	if (ret)
+		return ret;
 
-	return sun8i_phy_init(priv, dev);
+	ret = sun8i_phy_init(priv, dev);
+	if (ret) {
+		free(priv->phydev);
+		priv->phydev = NULL;
+		mdio_unregister(priv->bus);
+		mdio_free(priv->bus);
+		priv->bus = NULL;
+	}
+
+	return ret;
 }
 
 static const struct eth_ops sun8i_emac_eth_ops = {

-- 
2.53.0

