Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B637606A337
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wY0eyoI0;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=dquuOlMW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC66581219;
	Fri,  6 Nov 2026 18:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNuhzai2JZh2; Fri,  6 Nov 2026 18:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F6468118E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989380;
	b=T0LEDVj/kg3xZyYu99pcZ3OqryecXLhkqXARvZc4jjfMnIdHiCqIW+aJ/OCBCHpm8JoH
	 YJx6Cbll0/nlYpSInAJAKuIf0oNj4Vwab82XrVIqUA+1RzU1ub1lZzoth1lCsD3JQOgYi
	 S8tA9dbyYvu5cSIGOJIuF2c+6fDCa/scGgTCDswn2uW+6Rtl66Hw2OzoBHkxbHz0XUgmj
	 M8v6Yf7FsMqL0es4hCJ7n3Djwma/ZfxTdqU4FaW3a1V0zIizI4mlBLfVBdjev5VaypetN
	 +CJyrR+Q74CvHz9kjQQsjxAqEg4/ycdVPpw+1LeZnNPYDsok5qkFdmVt0DViwgLtxgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
	b=cY9q+R8bAhOAlf2zMbdtMUsL70h/YbdrcXqeHGiMhjv7thudzg/K7mgK1H8l39/uE6G1
	 SpTT7i3d81+X8BKYpYEMiCl0tdYcSgwg5EC2NQgvAa3ubXzyjpz80g8lyORzn9ejz8L3M
	 jTzPs1uSUB4ZT9yTCpYIvnfP4tCh4d75II6EPUrGwMkA8cKTU+2QPR7ziqxL5x2VQbq49
	 iporGJxdmrrllbwuMZn8XlSCbyCF/P5Uz2HncwvuT7nMT+UJdrPn9c1xPJ2JkfJDTHQP+
	 JFfVqNvGlI4eMzacGJpieuVkeksHyJzuOz1TQxBXCgL6JRfZ5vd7zoy1HW2Be2wwJeg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989380;
	bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wY0eyoI0UqXsJlHAHTfjcy1Z/0jpoyo0SGW/ugB4hp9FNiVoQYyShRGME8DC27UOh
	 upEmUlcFuhcLIcNg1BZ199RREbri/fsPWjHRCOyMRtD/1F0QvLbg/OAeC/cL3HTTGR
	 CGtLnAQprQpqQO2RjFoHc4OXWB+mCy+QR+axS8BXPFDPUhElaJzdLzQv0Y+2usIAx0
	 41ujMr3czZzTjP1VlLeVqHZElMMEt859MSlH9ubja2xNWxCtdiPao5J1JJiF5bLOyg
	 PLSHOC4KZ6WIFsc9rgik4+W5exNr2d5g7y2zTooRK255bBT/NhuHBTyoJ+nD3HqrHD
	 ZyE4UCrQYowzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F6468118E;
	Fri,  6 Nov 2026 18:23:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E8712AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FDB14087D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id koAnpyxSB0Y1 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBD8640802
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=dquuOlMW
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBD8640802
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:13 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8a4c72951b8so536424b3a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793985013; x=1794589813;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
 b=dquuOlMWwPKWDrgXc8PMN+xFCXn4O37XR1zJDkTqzJoIS/Z2MSLiyRmSr/eZGXbYYj
 NsrqjMuj1iVAwH5ZIhoiC5P8um8zPl0NvO64WxvkK1Iq3XEz0O7DCNjdBfwO2quqOkhP
 EbX6vxHYZF47VRLKU1AgK3+hHhN+6HnFKqnuPN9cCsmKYoFP7c/yM57kF6k+nHIBBjdv
 i4c671li/T+1O2JIXDBX+83/Ax5wAM4xdVQ7AaadJAO20IsCKJ1hHKv+bIYiDCu4beHf
 mMrOO9FY9pzWPLtRlDPlR/+6NdK8QmN5x8Wxf7lkVOAijUiMREjcfneiOaJGbKRqE7x5
 xsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985013; x=1794589813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
 b=Q3j3mjfljxUgDe1E2sHdxnz2iF7IsUtvUVTOfTfsmGw8ICfbJnLl9KhCWa4tRy5Fhr
 xBwx9aIxdwXwJxjUh0VqiXEREeCR2ItXi069AKucGFrzyWY3C4JAWKt2C3qf2eZ69kts
 rybkFnJNrilrDflPEgYTX0DKNey3UFyhMdRay31MvYd0KVuEoeY7ZOl0vJrG1y4BD4G4
 ksfw1Op+YyN3AzJoZqpj92oYVUaGrv0BZNW1PrswyQ0uXk9ZFlChAiZAD9Lzt+8yKflw
 0NAZ+I2z2yoobNSGYeMEsIetGlrY4nuddXL0W/Ro8Phy6Lv3x+6w6VxeeqI9vgl6pyNW
 nHpw==
X-Gm-Message-State: APuU4Z/7/fYq9sDRUtLzDdpM76yHoPc+89emzhhOO+IqwpaQ0aqp9YY6
 nStMfy9STPqONnw+Fq07ikS0/hM8wfor1vFUbNWvwYuR2A5juCCIp69ddGBjtwOYqy4=
X-Gm-Gg: AYBFou2QFHFD3kvz4cMuL5WDoNWhjH3rxwo22UZIu2qzm85+uSMHbbmAfktK8THTklu
 acSVkr+xS1b/bdky3MqsoEVXTr5stiv8gJGDCAVLEmynjcvSdVJHfJEG2RI9tv1NQmhiWM9nTPB
 VP7XS1kd1vF42n4SewVA3GuXCUJeK/JEyTcBqWR7GQB8hy4XtToy2ffCDAboFQ1iC6NKrBgeAsP
 kcWXnlmGVdeCalmQT3qlel7q+1+VhdRFKY/KE3HR+KqyCOXxUbdavqFklcntCdojGCoFQJD3TsI
 +ZaHW6pZYRgtmYE9oahtW1ooFkXzmGo8nPB1sN3SA6VvbgezyQpVNjjRy/dFJ0beTQlb4YJ72Cu
 Wi+lwMoVbuJJod0729hsAnhD+UtL8SE8+lI/Qi1B3ik8sfjVqakWNYWG5Gw3QQOgJnNQ65fJnPK
 aLLNb+/m99/gfcfbpbzqQmKSo10VWecXcqwmFlWSdQzcSIISM0Ogz6LBPsOfRBtreDN9xYXgJ8U
 xAlPFIaJgd9cpqtGpk7hTe++Q0Aeeez1UtJa1oT5lUSmLu3n0Uj98jl7QUGTd0hVyuULLlxwp3j
 ZYrhbTicfHwzIEZW11KL4TYfhYFwvmuqci5/4tuXT/khbOALerKVVZSsMQyNpcS2pls/xHsrKiM
 leatlSBuawMO1jCCd+Nu0eo4=
X-Received: by 2002:a05:6a00:bd83:b0:8a5:7006:1ecf with SMTP id
 d2e1a72fcca58-8b37bc5e612mr3211288b3a.39.1793985012802; 
 Fri, 06 Nov 2026 09:10:12 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b359dd36d3sm767461b3a.37.2026.11.06.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:12 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Fri, 06 Nov 2026 10:09:04 -0700
Subject: [PATCH v4 1/4] net: zynq_gem: don't tear down a shared MDIO bus
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-zynq-gem-remove-leak-v4-1-1995c70f540f@t0.technology>
References: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
In-Reply-To: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, James Hilliard <james.hilliard1@gmail.com>, 
 Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984944; l=2089;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=fuul5Qnlh9Fch/foZY3RqMLITYGSxwgHMgCVo1IduaI=;
 b=XQ6h2nopw8miKpVpop2wuyhSGPAYHC1FBWUZiewtdFPMwocdCZfZwz7pnKuZqaY15RJBZwWRL
 c4YAGwz3Bz3DoLavMHFdAZvm+Y7k5w2NTU4vq9xvA0kyD5PUeOkS24w
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:22:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_DM_ETH_PHY, priv->bus may come from eth_phy_get_mdio_bus(),
in which case it belongs to another controller. zynq_gem_remove() and
the probe error path nevertheless unregister it, and remove() also
frees it, pulling the bus out from under its owner.

The same applies to priv->phydev: phy_connect() caches PHY devices in
the bus's phymap[] and hands out the cached pointer, so on a shared bus
the phy_device belongs to the bus owner (and may even be the owner's
own PHY). Freeing it in remove() leaves the owner with a dangling
pointer.

Track whether the bus was allocated by this instance and only release
the bus and phy_device in that case.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/zynq_gem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 957d5251cb8af15899648e7e61d53205d35f3db6..d28b97d01d08da50049280fe2f75277506a4b740 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -257,6 +257,7 @@ struct zynq_gem_priv {
 	struct phy_device *phydev;
 	ofnode phy_of_node;
 	struct mii_dev *bus;
+	bool own_bus;
 	struct clk rx_clk;
 	struct clk tx_clk;
 	struct clk pclk;
@@ -998,6 +999,7 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	if (!priv->bus) {
 		priv->bus = mdio_alloc();
+		priv->own_bus = true;
 		priv->bus->read = zynq_gem_miiphy_read;
 		priv->bus->write = zynq_gem_miiphy_write;
 		priv->bus->priv = priv;
@@ -1040,7 +1042,8 @@ static int zynq_gem_probe(struct udevice *dev)
 	return ret;
 
 err3:
-	mdio_unregister(priv->bus);
+	if (priv->own_bus)
+		mdio_unregister(priv->bus);
 err2:
 	free(priv->tx_bd);
 err1:
@@ -1052,9 +1055,11 @@ static int zynq_gem_remove(struct udevice *dev)
 {
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
 
-	free(priv->phydev);
-	mdio_unregister(priv->bus);
-	mdio_free(priv->bus);
+	if (priv->own_bus) {
+		free(priv->phydev);
+		mdio_unregister(priv->bus);
+		mdio_free(priv->bus);
+	}
 
 	return 0;
 }

-- 
2.47.3

