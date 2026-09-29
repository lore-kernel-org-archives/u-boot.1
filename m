Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FBECA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90461810CE;
	Tue, 29 Sep 2026 20:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cf5pnp6JxGgf; Tue, 29 Sep 2026 20:32:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A0CBA810C6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713968;
	b=Q1OSb5GMWtD9+/oKrDWE/B41e44clagKKbk0S3K/5fy23SZlC29lVOSlyo+s/FZCaxbb
	 TfuMgmMv2krsqOU4nTgF7Wy3LycbcX86Hmbu9XauV1Y5+svlLunzp0ItZP00z/5Xo5cmt
	 2uoyIR6rF1mPPIUYAdKOqSKeOKT295k+SXGl98dmsOWfLL6D9zGCDtLDUVj/2BYGW10GQ
	 rFrY1OjEmYiTmRN17f8k8tG/sT9ow/BUxHp/eAeeCu0IiuZlnZho8iMp60it71wlUMQ4m
	 BlAgjok/UwPas7S7gFsa3QADO1wiE5vBEwsilWiS+0bqhPCLrpyuJBZPs7Oem/RaFNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
	b=c3GAMIY7ghA6nnhidRcD3h/azER1WbvTJxPo4Ah1mSLduxKuz4+Bk8iuftQkyWkbnAiM
	 Xx/4oYFqZgpviOuL9LnJUNrR65a/U6NncQguw/ICtgn/a4eIiUJfVTCVRiEeazptfEA5D
	 52ZqYT0QybP2tM6OK2P5992T69zgkXiVGbJJoKI6cchF/1iczMJ4NNDOUgTbbDKPLTJ8K
	 8irNgsWiaBv7h0u/E+SZk2kE3CzyG5hKMROo/C77mUUhqL1GqlrU6BvYVEkGwsunzr8Db
	 KCPIckk+D5h/nBb5FZFfVHuIgGhXjU6ZraM+KXHgp7dKGtv4LgsNWgvek5h2sgPL9+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713968;
	bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QRAV/SQUpAp8bnhz+78uiAfuMku1iCSGrzpQIXVsYs7XkskjFTgv0igWp/DW6WhtP
	 r5Yt1tvxnt45rMDhLUS1A0GgxLYzPgT6bxGY4MhI8qmyAdzDQ1IBOzEBHTx1I2CgFp
	 Foqxt3jFprfq5gek80jvT3Zyh9SkQ/Sq3NFxG68ykOXO03XJMeFP3R/5O6/pM1jehd
	 B/dbAWT5bv/0oYzlOD+ryCqXUdU4r+k13rq0ez8CTkTKAnWKiWFDmwNeCCrrnfiFgv
	 /PYU3XqTK0Tu2WqcYCl5X/V9PB2+QC1J4/5g6YHLHUtkQb/l+jNnBdTZlWT6F+V7xo
	 cUpzQLnlhbX+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0CBA810C6;
	Tue, 29 Sep 2026 20:32:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C974F14C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB4E3407B2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9N4A4HrnD9Qu for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D7ED440766
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790704861;
 b=Whdr3Iiy6HiixDW4QIo3dEc+cZ0PXlGxBm5fv8FR4cZ6digx2CLux9ESlzkf8jXi2H8I
 i+zMFBD37lBO5blZLILV0RBfaNLtwuzP0FADB92kTSa+gubZa1HFrlI8yW/KaUhmABNy3
 T3r5POOE0WJlqWDkZ9g+dPZwgerIGAQwNNS3jTjwwUD4wVIUVId2pcWQmH9vvTAVxkUdp
 DSu4jArMXR16piKaDC5w8ntdQz2cq2JMhd7mjApYqWkH7wdcEoeHCgN0bq+4nROCChiKN
 c09qGncGY0UnRKcAfQTf38zDn1a3Kato5Zq6zJdHXYJOug5cslF/uVWkeEX1zgmA/aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790704861;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
 b=BhrQihQ8dE1Hk6F91vxXgLX0+aixXCQ+Mcfq/K4dFwAi9VVAAvK6ddbFlVQPebjOhN9t
 mCvbTHNyNfV8r+JHfU8jNkEvA1foWbV4Z8rTXL9ClCC+IfYOyiWzDl8rcbAK0OiD4wuFx
 pxS/Lnj0V4bGpJ1BmHCx4Rc7fHMZppSEDpclqdSmxi0c+tCKAfASMmD6ORRnUvtW2cLBD
 bklvcsSQyvvNaPAZCgFKaN93f63FlP3M4QZyXC6HYlPrpK2pZGW5vdpZt4FVm1aZy7Kps
 tsX4Tq9pcRKcScFAHy+Xt3lMBrb6Bl7fSLig89rcHHUYAg7681IgC9+WmAxREu9aYlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=cTfX4R6X; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::e;
 helo=mail-qk2-x0e.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=cTfX4R6X
Received: from mail-qk2-x0e.google.com (mail-qk2-x0e.google.com
 [IPv6:2607:f8b0:4864:34::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7ED440766
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:01:00 +0000 (UTC)
Received: by mail-qk2-x0e.google.com with SMTP id
 d75a77b69052e-53122c5bbb4so51313251cf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790704859; x=1791309659;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
 b=cTfX4R6Xu4GZi6pW358ZwOMFV13C73FGqKRN7KvgVfRxOSDIZlpEhrITZu1X82IcKd
 KV2lTsFYWEfg+j7B+vn1uaenUDo8m6iejBP0wgObx9q6PzHq1K+eV54zo6jerNAvw8rm
 DDC3otudVodFxevoLlly4hilhBEPn3dK9PsQ4Hn6WzE5ldJSe4yCO7VX1Woc70oxepoU
 rBLU8quVJ8nIZavnshI8YlEqPZ8pd9tSvi+mzvl1Lr4y1J+Uqe0O7bpD0Y6kLF8F+ngE
 TISy4F4/BVs9lSp5UHmjhDYhEs955CjXOqtQlly6k3OKJtfLcd/L+YRnjDtY6zCIWWRt
 3Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704859; x=1791309659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPIKFqFNfAsJh2si3aegTlSdSHRw2sKEWB5DaHLmFa0=;
 b=JrtmgsVfZoZYNNdMA+tnt6xGs0CGmg4MG5prVbUdFRxVdWX76+hRRPS2OPYBHzYN/T
 d+JA1+6bcC7OSrb3iS6g9OClv5Oe7EIAkdiMOxPDHCt0kb91EreaJ2WGP3Nshnnp9wA9
 FC9IthlaQEOIwhaXNYaskk0EGJoz7eih328Gixve7Vk4JnvO1XYjpgQcjzr8zbAqfC0y
 7z4/GGi4kMf4fMOWsNEMCteX6/7OPSgSlyVe+UfWIxtne8VD0oBfRzaAC5DgLVfufa7S
 tq1M7Hzfuvpib3scer+ImkIxTq2i9nchduLMiW6eMClBZHMDCmyTsYYDhHWP55HiPXU6
 xB3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYxIf8NnymLQC5OeL6HL/0dLsQ4qfgY6BiPWO4wSzTOhZqz79vifGeTmJQ8f+kzCBbRjUhTnI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mRn9NhZdw+jQcVFa7yM+pctTZiwUJrsEOo14HtPcBkPLMWMC6H
 Jwj2heFquhx9m/hXIYh3myigOyiOJLCMRXV/m0GKUl4vqbej+Vor4hvuJt2YMBMWXTelEQ4qbIa
 O/S0JhUMAYiLmFKZK1G2RvBXTAX71tGfWFbSZZz+pluk+U1gj8zKbQ7871cHZhKw=
X-Gm-Gg: AYBFou1wUC1nETp3dtZeBL4NdEHZrHqIo9y7wD7ZDLJ57zSUTmQQ66Crf08N+vLJE/j
 52+IHNJJPgyoU0oAS7mHzJCq+UULolfPmPqkc+6cr4fFaMcvqAuua7yr7WoQnbfgXksk23/U35H
 kmmzOCWaNjl1/ncTUmqKAnC64kdbY4P0gZOBUr1WPeTTbrl1MJwLT1VzLSHPss6jtHVMQmLdgnq
 Ypk2k1r+KnbP7PbIwmz58iPoc/y7LzLNCeasVFakwz0KJ7bN/5fFduS3cN8Jg8gkBZ8Thqk+XMB
 ehkDn70x19F3iYPJDXoAg9Kef+COC68eQp5VywJ5HgWqnsw41w+ENLxYqpFMbkYfbVi243csh9I
 xrH4AWPmHIJatHi7YjivqiBtB5WhIKbQRX4jFdxQsY+/rUsX26uxA25GLVabIIhbL7LxqDFhJGp
 V9ikoVtwBQlWXyrxmmTbNJpq/urBJxrU3VWdP2OOlOOly4eMUjj5d8YdHlGa7RTysB
X-Received: by 2002:a05:622a:1816:b0:531:2243:436a with SMTP id
 d75a77b69052e-5336a5eba19mr159311cf.55.1790704858503; 
 Tue, 29 Sep 2026 11:00:58 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53369c4dfe3sm895901cf.31.2026.09.29.11.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:00:57 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sanderson@brivo.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH] net: designware: Fix MDIO bus getting bound multiple times
Date: Tue, 29 Sep 2026 14:00:53 -0400
Message-ID: <20260929180055.3439132-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

designware_eth_probe may be called multiple times for a given device.
such as if the first probe (or post_probe) fails for whatever reason.
When this happens, subsequent probes still try to bind the MDIO bus,
creating several duplicate copies of the bus (all possibly sharing the
same of_node). This can cause an infinite loop in dm_mdio_probe_devices
if we have been probed at least once already:

dm_mdio_probe_devices()
 device_probe(dwmac.mac0)
  device_probe(dwmac)
   designware_eth_probe()
    device_bind_driver_to_node(dwmac.mac1)
    return -EFOO
 device_probe(dwmac.mac1)
  ...

Prevent this by binding the MDIO bus in designware_eth_bind instead of
designware_eth_probe.

Fixes: 5160b4567c71 ("net: designware: add DM_MDIO support")
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/net/designware.c    | 35 ++++++++++++++++++-----------------
 drivers/net/designware.h    |  1 +
 drivers/net/dwmac_meson8b.c |  3 +++
 drivers/net/dwmac_s700.c    |  3 +++
 drivers/net/dwmac_socfpga.c |  3 +++
 drivers/net/dwmac_thead.c   |  3 +++
 drivers/net/gmac_rockchip.c |  3 +++
 7 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..256e474a565 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -209,15 +209,14 @@ static int dw_mdio_init(const char *name, void *priv)
 }
 
 #if IS_ENABLED(CONFIG_DM_MDIO)
-static int dw_dm_mdio_init(const char *name, void *priv)
+int dw_dm_mdio_bind(struct udevice *dev)
 {
-	struct udevice *dev = priv;
+	struct udevice *mdiodev;
 	ofnode node;
 	int ret;
 
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		const char *subnode_name = ofnode_get_name(node);
-		struct udevice *mdiodev;
 
 		if (strcmp(subnode_name, "mdio"))
 			continue;
@@ -231,8 +230,10 @@ static int dw_dm_mdio_init(const char *name, void *priv)
 	}
 
 	printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
-
-	return dw_mdio_init(name, priv);
+	ret = device_bind_driver(dev, "eth_designware_mdio", dev->name, &mdiodev);
+	if (ret)
+		debug("%s: not able to create mdio bus\n", __func__);
+	return ret;
 }
 #endif
 
@@ -855,6 +856,9 @@ static int designware_eth_bind(struct udevice *dev)
 		}
 	}
 
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	return dw_dm_mdio_bind(dev);
+#endif
 	return 0;
 }
 
@@ -961,19 +965,16 @@ int designware_eth_probe(struct udevice *dev)
 		}
 	} else
 #endif
-	{
-#if IS_ENABLED(CONFIG_DM_MDIO)
-		ret = dw_dm_mdio_init(dev->name, dev);
-#else
-		ret = dw_mdio_init(dev->name, dev);
-#endif
-		if (ret) {
-			err = ret;
-			goto mdio_err;
-		}
-		priv->bus = miiphy_get_dev_by_name(dev->name);
-		priv->dev = dev;
+
+	priv->dev = dev;
+#if !IS_ENABLED(CONFIG_DM_MDIO)
+	ret = dw_mdio_init(dev->name, dev);
+	if (ret) {
+		err = ret;
+		goto mdio_err;
 	}
+	priv->bus = miiphy_get_dev_by_name(dev->name);
+#endif
 
 	ret = dw_phy_init(priv, dev);
 	debug("%s, ret=%d\n", __func__, ret);
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index cccf9d54e02..3618300f4c5 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -249,6 +249,7 @@ struct dw_eth_dev {
 	struct mii_dev *bus;
 };
 
+int dw_dm_mdio_bind(struct udevice *dev);
 int designware_eth_of_to_plat(struct udevice *dev);
 int designware_eth_probe(struct udevice *dev);
 extern const struct eth_ops designware_eth_ops;
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbace..cb9de81a819 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -157,6 +157,9 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.id		= UCLASS_ETH,
 	.of_match	= dwmac_meson8b_ids,
 	.of_to_plat = dwmac_meson8b_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe		= dwmac_meson8b_probe,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 76daab961c0..d95f2111a5b 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -56,6 +56,9 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.id     = UCLASS_ETH,
 	.of_match = dwmac_s700_ids,
 	.of_to_plat = dwmac_s700_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe  = dwmac_s700_probe,
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index a55f3e29f9f..64bb2dbfbe3 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -143,6 +143,9 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.id		= UCLASS_ETH,
 	.of_match	= dwmac_socfpga_ids,
 	.of_to_plat = dwmac_socfpga_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe		= dwmac_socfpga_probe,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/dwmac_thead.c b/drivers/net/dwmac_thead.c
index 138d71a6202..5843bed49cb 100644
--- a/drivers/net/dwmac_thead.c
+++ b/drivers/net/dwmac_thead.c
@@ -280,6 +280,9 @@ U_BOOT_DRIVER(dwmac_thead) = {
 	.id		= UCLASS_ETH,
 	.of_match	= dwmac_thead_match,
 	.of_to_plat	= dwmac_thead_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe		= dwmac_thead_probe,
 	.ops		= &dwmac_thead_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 2b6080dd9ee..1d21cb2606d 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -790,6 +790,9 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
 	.id	= UCLASS_ETH,
 	.of_match = rockchip_gmac_ids,
 	.of_to_plat = gmac_rockchip_of_to_plat,
+#if IS_ENABLED(CONFIG_DM_MDIO)
+	.bind		= dw_dm_mdio_bind,
+#endif
 	.probe	= gmac_rockchip_probe,
 	.ops	= &gmac_rockchip_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: dw_mdio_bind

-- 
2.53.0

