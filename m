Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA6606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rd8k1oyI;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=gU25Ce6n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31A4F405F9;
	Tue,  3 Nov 2026 18:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvqacJEG1G-o; Tue,  3 Nov 2026 18:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 12BC140633
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793731875;
	b=c+0I/n8VUfs6BBPEbO67HWlXvaLfy+a6UJLrkMnoCoe5GiCMQ5qonp0MR7iCHikqQXqc
	 KE7XmA2Z1YJ8GIP4qBCp9iG9LtFM0H4YVm1Z+74V/JHNwUqhPUN5dYZjJf4yXygteS0HM
	 ++v6H3FMKMC8PtakB8Vv95uf5rykodgxtXNMjlKe1erWctMAousUUm5iRHdnVxnXPMsGZ
	 yX1/JXIkrKQKifDfglZxs3d7eYZiHl5fLgu0WZy8yACDkCx9IpK3kw5GT6HrzuYPsDsEo
	 rxch7NULyZFrVH7cVUzVWJSBxexb5xeUCoyJsZGalmGY18bgLaiMdT4blsMnJd7QWKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731875;
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
	b=L2hGZbzaW3rlwr+ut7v84myIwY07OSgN/MDuXx6GDtDKELbW6QuPzOKwFUG3skuYYVej
	 FlZsCxD1CRr2jYwAIWapiyNMHjcsaOuPl2sn2ZY1E5NLR8yjwS+pIQpUeQ8/r0J+Q9WM5
	 uJ5HjeRYtOkCKVWfYvxPXYuZhZ/BkHnWISKlvoRE9NI2OtCzhr4XPA4CVMFyzh47mD8p7
	 1kgdH7WKCkqKI9CTzb/NoYFCnrB47+W6vBUfddw1dLCAMBi6b7qBqLk40WRgtE2QsAhuJ
	 rh0uvOJl+5/9/0ufYNVEKeTk2O+PZ62JbusWWkJkVI1ggae0oKhCkUv5jr1q4n3zx9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793731875;
	bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rd8k1oyIsxy1oV+cP0ESGkbrWT7MiMCB2sbwekHyzyJQDuYDPjaakw+zEXaxE9sDl
	 TQnw/1ZOeDK19BbQZZM72DfXacJiBMUcflyR3YJmx4tG65biyvI/Tgs0J1peqHO29R
	 ylaRXr43SCJ+O2yfKVKNJ/A74eVIQE53VQrM+yN1vkqZMwrkWMIs/tsSwMHy7Wo4Ex
	 U7UQJD6hxFp+Tu3+s566Dy8pJjxQxyayKZGnDL+6xBIEAD/GRTmPVyZKlGnJuZanmX
	 VYY+2DVGSjHT+7alGz0aDKMYF8hUG2NoGwZj0s4OmsHG+6ZDyAjxLpr64bzTxpj75U
	 ixKHsS1UvxIsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12BC140633;
	Tue,  3 Nov 2026 18:51:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BB96A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1244E401FD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_4qSf0mtCTo for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CAB5D4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793731469;
 b=FVNUzHAmmzW81XgJ0fKvDMTWsSipOqGx41FLH5L7j+/RRz4fpmobcdj6ic3WCZTug7ZM
 redm0jrbBvNCO6X/jbYhguFX36wZHeW129e2D8fjIwGzmeP71kSO6PSTHhK7dkGAMvzs8
 6l/uwL5yo6pggnjXXrcNsyI6k599AyhRL0aiLwgomd8n3v8k8tkPErW2u+AaBY6ur3KWk
 sy+4PWcUvXCBIDBzKwRXXf9zOZ8076SvU/GI6DdUwT1hPMnS4dRIBapBTEMGkBXndh5Mj
 3y1URX04GW0S1vkI7w+j88qEvt8QQVxGXBvckZrLQ4w58I5kKxuTUxWeBQqB1q5VntA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793731469;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
 b=QryM1I8ESgi6dS5/0aWGgQ+TWCXO6qh8kLJbjA75qKYvpC0CNkKDixybokEHho9Xxug0
 QqUpS6fJzAHRLQF8ru7pimGBKF9HylznQCks2ZDbugWy3USeauN3L97L35z0GWSF3mzec
 U9LY3nRQwTBHF73NQovU80r93nAnh0hhIKdF0Dwq6bgzQRswoOu8S3Ud1fy59LnAS4Ytb
 jUOYoJivwqXPA5kT8Pl0LILt7iqjyNfI0jKnhTQhDiZ3lMXVWYlIHH1sC2DAtP8hN+LGX
 v0wv3JMqic3u2thNT3r3Il+BiCtOfOwptgWz+a9ZahbgbApZqUQlu31MEsa4XaUFGiw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=t0.technology;
 dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256
 header.s=google header.b=gU25Ce6n; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=gU25Ce6n
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CAB5D4009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:28 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3b094e649d3so17223a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793731468; x=1794336268;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
 b=gU25Ce6nfX5jD5Lt8nWKRl2Ig4U32FaZqIyCCOCHyfioOD/AvrqmP7jetQ9VzhMzcv
 qBXDmwo2O5WK/UDm9f5h5Y530bIAypSIBpv6sh3d9dPbDnet8l2Z3PaQsaaQY7SVtNhv
 4LX3hxBXFaV1rVQuIrrEsDbLxMiF92FObSj4DJ0Xx5DGWltoEVJU2A1AQiRUoSrcLMiv
 zgdxfLvTLLuDLetF9pHmV1yfCuq6oWY057viHcv4tMNeif2eJH7n1GrB6AKvNdDlild2
 24qg2mmitPr8etBWd2SMcQ1lBsnIsV7Cn2JpsMLss1Xel3NrAsB2seR7DRHOGgVdCAzV
 AIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731468; x=1794336268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lrbwKml7yOw+0P8gE95icVyYH/w+X8AQoyQOGHSq/c=;
 b=KWFbWt2fDaKhTGC4+jtSahoL+eGi8Vc2OG0pwqH3W9dUQfmNeT7e5EL7nA5RE10018
 CRAABoDsBS+osZ4x9h8JaNiWpoADYoxFDGyxEzG3AhEMGAgKIO3zbQ+AcnTfua9HEqIO
 VX4Gn6/evrzGBWWM/DP2+yzqPlZ3vVfabaSwRyW7PxcAX/kRnozqIHtPV54nZwbZt5is
 hxGLTILz60P19vapK/QxfMQQynt+Zqr3EJBMkIKDZsL65hr/GN4MkvCUKj8pHQhNAPAQ
 rPdHMc21mbQL7VfwHb0xkSj2tlPrkuo/C5ueRvUugvnEp8fb4AgeHlpr29ql5WwVDbcd
 615g==
X-Gm-Message-State: APuU4Z9AK7TtkMkgoV4T7DOjVyKSyhJ4CExlKCg4qfaskq/XP6Z7wGkn
 gBWs/Q3JZxcipLah2AwYZcU2Ub0413GE6MjhMeWtJeK5NuDLfmrxPZMK1pIyqjaJKnA=
X-Gm-Gg: AYBFou39l+/r0OWvFxVdKdRw03fzAG/CgZUwrNEkG2gSjJAUv6EZZEocLKa2JG3YJc1
 XoJG10EDbXws3aE+5ffTC5qutujW1CIgdR7NsiDU089F0mAuVUIDDtaiNK5yz3cW6vgH80KtIER
 Jz2/IZ4K5vsr6tk0gJsnYgJ/06gIzDB/dMgQRZ+Qmcku+KsMqJBPOHnjAeXhXM3CjduXZHVuETj
 WPzCZuCVwIw3SYTX5khRQvWvpdiD+pqGaKMOVjTetuyjbTP7+T2wpyTiuTOhWHxilFSZncz3wJN
 hEGTrCtkk3C+J/o79vUDBq1DiJLeyYte/kWTHHq81gt8wY9reFPhAuS0an1VBEEOaq6bgsxf9jY
 7rqQq/rcJcWXeTnnhPGfb8dPpQCTWB/RWL0vh4hdzBwYhPb6PLkHuaMD1bOhgGPatPeSVdfpu99
 G78xNJb6sECwKGBWlMRRpugabNzn5IyMQTntTroMeDXX5PlOe9TWjWpgqicmggNjYs64VQH5pfi
 A9hH5vdpFFj09q2U+qXuU2uWrYuBTQVaqUs/mzSpTh9qO8A3to3FoZSAdiwKLAM++coaHPmv51A
 vR9lxtRfiU1DAnGrBzV1H3k/3xQg1upBSJqGTVHKpty11CrgqUTyyv8ynQUm/Wddv5o7EnjQMEa
 w2w==
X-Received: by 2002:a17:90b:1c92:b0:3ac:a521:959 with SMTP id
 98e67ed59e1d1-3ae898166c8mr11472058a91.29.1793731467685; 
 Tue, 03 Nov 2026 10:44:27 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae880b1f71sm11496613a91.4.2026.11.03.10.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:44:27 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Tue, 03 Nov 2026 11:43:22 -0700
Subject: [PATCH v3 1/4] net: zynq_gem: don't tear down a shared MDIO bus
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-zynq-gem-remove-leak-v3-1-2f02ec0023f9@t0.technology>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731408; l=2089;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=fuul5Qnlh9Fch/foZY3RqMLITYGSxwgHMgCVo1IduaI=;
 b=O1N9O89x3qOo1DuS681rG9bGF+ocenCLiUqquD997LUGllww06Xd0akEOGi+0mgdvtA0+iswy
 2N3rWZLSSzfBxNRWel2+koxgTELIAcD3KvBMugGfmob2ILh0RLjF3Jr
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Tue, 03 Nov 2026 18:51:12 +0000
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

