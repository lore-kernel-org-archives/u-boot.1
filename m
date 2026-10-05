Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ABECA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4180E406B2;
	Mon,  5 Oct 2026 14:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnOC0rQWzAZ1; Mon,  5 Oct 2026 14:01:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CBED5406BE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791208871;
	b=nDHc9avwNugltZLnkipN8xrJbp619MKlyPAIYZYUsx7CbByYpWpd/ZHFuFX08A8B05wL
	 qWGQaJOCa/XLev60IPyUxg0Yv08/btrdnm+7uyAjr/70ghXmQFkdM/uPQda3BjGNO5Ge6
	 W8RnMKLWdtYuvo+/ZkmySFFDOfFb+SIa2zyMFpE9ffjFNRHYcyB/k11OvaDPTKRq0e90Q
	 n8wY+yleTvfz2tTFjr7fzTXKIAepztT4SJ31razx54C/zEVo2x/zLrrlYxagQQ4a2hGWg
	 6KTjxaxFZH99v+m3l22DJ36aW2jMMs0X+9HCjdZkvHlJ0duWUDpwasLTvdBnQyKLK3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791208871;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/U+PnyT2iWh9/WvOCXsxIjB6wGFmSPn+xfP4fP8k/tA=;
	b=P7leIFqrCtNLYFgo9VPzx0XBxJEcixnPkpDna+VqOpZV7eWOM5MmWtXVwgSg7hVTCzMz
	 sQMCI71iIac3pNSWuVxHHDMjGls+CQB+iqneRkplkBVIxf3Qu2lsAld+IDPu7bR9fkqey
	 loL6yPSbgp4pzUlrPWl9ZfQ3WVaaZgH5/3WRl8SEIkWTVxKdn/D//qIR/XAShKkggJGUE
	 /yoszb28By2rOj7xWdTEgsqYC9gJj4H0BhzK9PPv8qLPlu+37VP8JkT14PgrNijjzJ82a
	 /j2RKrk+93j3iePf5h/imKPiJTo7Pm1Tb29eR2luegWeCYu1xb4rZ8zMpMgTBmQG3HQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791208871;
	bh=/U+PnyT2iWh9/WvOCXsxIjB6wGFmSPn+xfP4fP8k/tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v6B8/TwBIhqCgQlLjd0T5FQVQutlxihets85UyCZFqZ3wFbN1fN++oYGAD5APiNG5
	 qicujMpt92wWqV6sX3UNb8PpO/G6FV8mOT7wglfU4JiApXyke+zspl69PsrkiV9I3l
	 Lxn2CgL20/VEHr2w/AtNBhm01IQ29NQLwcqNiS1LWyLIC0+mWy/OWCPzr1WXvN+4+T
	 DPm8DWnVfyyo1Qacn+6iznRfPUrWiLjZ5IKXbHlOFy7SawF2NgS/hQgtx0aN6EONaK
	 N8QSWqs/xw7bKd/6Rx9Ttm3O68t9nPw4ixVB+pm6F6DRe6IdJ4V+CjVbDNrpe6RNEz
	 9Xqg3cvPzB6Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBED5406BE;
	Mon,  5 Oct 2026 14:01:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E30D32E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8D4660643
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWBe_91advnj for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:54:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 99709605E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791208453;
 b=CAoBUY+ugbiqn4fAUQ9wpSy/0/Jo2mfqbrjI3HstkOh6xfmv5k+HBN4tAwQiFXzhpi7D
 5UGHVlBgQPDEtEvYZYfN8awo53QzsTvpl9aUW35ww9OK4Q/DRWRv87JrIx43B0syg2Olg
 VQ65rxKBd/7po0FDVcZ36j7HbQE9Vyxh+3YZ8m9yp4rJ1/7EyBH0zr2cjPlFC3xgJHpF6
 9hvNrwL/MgVaUHO8IyRY27ao3cyTNTIvl1P3f4PHGvlxC71xTSzcP7GsO7rJLCJ18iQAX
 Z5Bk8UbWKV0l2z+NjqCDsURKV3gd8X5iKJOFRhp+XSRBUWd/I7M4eBHSxYjAtGX7Eww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791208453;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=/U+PnyT2iWh9/WvOCXsxIjB6wGFmSPn+xfP4fP8k/tA=;
 b=g/5bbkEvFdEUsy3bJsZ/6u8Vk+Q4YK6NfK23ZSdFncbyI1+eZZisN/xHXkS/5dmldgsi
 FoG3U0VB5HiuamnKOl/18jJT3h2F0HWEDewMMmQIhKYpLoKxWAPdX7qRhz9oL103fZba4
 uySEazcQhsHDNk9iRh27KVUuDMafW0c1zZzQwXUyV2xBOGodFqARQzuejDG9tqxlAUk9b
 rzJhLiV6IXMoYSSHHOMS9S9/R7Wh2L7ZNjuIWzEvIsjVRyT1JQwDeGwIj9awgZGykjo6e
 VaGl6Rio3pEVLgSWWowm+pb1FLFKW7mXrhzGA2g7qYh+cbpad/YO62ldulIKYzwVAnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=hBslLAXp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=hBslLAXp
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99709605E8
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:11 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8aca54b75d4so5480277b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1791208450; x=1791813250;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/U+PnyT2iWh9/WvOCXsxIjB6wGFmSPn+xfP4fP8k/tA=;
 b=hBslLAXp7m3AWAQgfQVXKcHM4ri8Z/yAGzdhY2J4jZJkzX9BlbxJT1+IDBsemq/TNl
 vrHQAbWK2cK3XMCzPsO5frAUOkomIH5es6TwDrg8AT5/MD95U0EItDutm7hz361Z2ICz
 GeMoGRXQ75+Gjtqyhj18sit3H+74UhBwDYJuYd6mgiiDCmaMFCW8WKWRw1729ztLRcKc
 jdE4B8Mrc/5/at1p3KOgACQnrjGUUiA4q48GKRPH5NMGW6dlXSr6zQdojzpuQN8CzG38
 84R5AbYI1NWYJTEaOVkRjqwazS66jh340oZvxPxvJ1M3yb6PpyyUXLRiRjo9PKjQtNLI
 GW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791208450; x=1791813250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/U+PnyT2iWh9/WvOCXsxIjB6wGFmSPn+xfP4fP8k/tA=;
 b=WkO0xBsD0PXKdErB101nBnJa79bujisfdtmNNGxik+s546s2H/XT/XJgzwz9+8PgNC
 BBaIcq3SCZwNXohsdfziuLhLTb9D6zA/+eiPsCy1t3EGYHN5JM6ctHZYl4HUD9A/eya5
 EyvFQnLJJcIxxtRvOec36nwdB3Wk3rl9ac56gFCeYZq5WZ/R4C+EJ/3KcXlNkimuTgHR
 coga6I+lX5ddvQMocSsR+VYgkG3S3SAkPd9kyyiPGUJ73VnRUWd+2NY8+ZKMZTJAktpb
 oGMn5IaYMoJaTN0tymfkLi/1v6jJodHkFbGk0d2+V3I+qnG0YY5mis4GfutOLxAQdnYi
 5M8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs2+7yNL4dHDh0gwf4Q9BN9O5iCbh3AvRSytnpnCAUmdJYwRov1ylPrP5P0kU+/gtrQa/47Mc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n/Z0X0TO4iOKFNc509SHQm4n63tAfgLE+eRd3gCgbeVPS4mQBD
 bPb+hBkL19mZuWjbZiCKTTujpcBumWnAiXFDi+Pf+/4V9zcd3XyDserYhJ5O7Y+eG909onEn8jS
 RyPCzZhLgEVqOVyagD7lCuceEIzpiMYGcVQo1riLCOlnYT7Ddt2xMJy/1a74tSkk=
X-Gm-Gg: AYBFou3ChC4bf0GbnjZoiwGc1RHKcfDyDRk+JeBplJdCq3vm5S9ZNiP4YQL0nNnQ2UA
 tryPYBXb5jES0rzqhh4Jt+a4BzZSYl2vW4f6RSDUj5tWqfC0t3kuDBRFZhcvHn1COP3Z0rkXYpp
 NuPJm+P6ireDZtaavrcqMSL9WTerJqYFU0YKqN7uxPeUoIllm47r4ivKyf1tmWpzcN700L1/Qt5
 c+3/vJVu6hQrZ131uKXTOOYsOOadlPJbg0z55iRDIu0QYEYoXv8FpYy0D92+s7mTSvjJ2vKZHCg
 m/I2YH3GxBOYleFhNfSRo4BtT0Rv5uZw8OTPzC2q4J6592nBTD/6KJyjBKlGXN9KaDYET9hzH8D
 hI/XkKqNzsyawxRTKkMPj3/dUIds3lZFLHsGnUUN9YvQVw0zNTrooxQoJMvhIHKd8MpnER79X8/
 RxbuihiUtZKLMd0BpxEE5w0ukUTZGM9gb36HNST9zI4F6XebEz9UekU9qCIlS7LUU7
X-Received: by 2002:a05:690c:95:b0:873:5c7b:c132 with SMTP id
 00721157ae682-8acdaf00b28mr62547427b3.26.1791208450288; 
 Mon, 05 Oct 2026 06:54:10 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae30120b8csm38852867b3.4.2026.10.05.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:54:10 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 Sean Anderson <sanderson@brivo.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v2 2/2] net: designware: Fix MDIO bus getting bound multiple
 times
Date: Mon,  5 Oct 2026 09:54:03 -0400
Message-ID: <20261005135406.509901-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005135406.509901-1-sanderson@brivo.com>
References: <20261005135406.509901-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes in v2:
- Fix warnings about mdio_err and dw_mdio_init not being used
- Fix missing else clause when bitbang MDIO is enabled

 drivers/net/designware.c    | 30 ++++++++++++++++--------------
 drivers/net/designware.h    |  1 +
 drivers/net/dwmac_meson8b.c |  3 +++
 drivers/net/dwmac_s700.c    |  3 +++
 drivers/net/dwmac_socfpga.c |  3 +++
 drivers/net/dwmac_thead.c   |  3 +++
 drivers/net/gmac_rockchip.c |  3 +++
 7 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index ff7294ab4f4..2ca21c373db 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -210,15 +210,14 @@ static int dw_mdio_init(const char *name, void *priv)
 	return mdio_register(bus);
 }
 
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
@@ -232,8 +231,10 @@ static int dw_dm_mdio_init(const char *name, void *priv)
 	}
 
 	printf("%s: mdio node is missing, registering legacy mdio bus", __func__);
-
-	return dw_mdio_init(name, priv);
+	ret = device_bind_driver(dev, "eth_designware_mdio", dev->name, &mdiodev);
+	if (ret)
+		debug("%s: not able to create mdio bus\n", __func__);
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
@@ -855,6 +856,8 @@ static int designware_eth_bind(struct udevice *dev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_DM_MDIO))
+		return dw_dm_mdio_bind(dev);
 	return 0;
 }
 
@@ -962,16 +965,15 @@ int designware_eth_probe(struct udevice *dev)
 	} else
 #endif
 	{
-		if (IS_ENABLED(CONFIG_DM_MDIO))
-			ret = dw_dm_mdio_init(dev->name, dev);
-		else
-			ret = dw_mdio_init(dev->name, dev);
-		if (ret) {
-			err = ret;
-			goto mdio_err;
-		}
-		priv->bus = miiphy_get_dev_by_name(dev->name);
 		priv->dev = dev;
+		if (!IS_ENABLED(CONFIG_DM_MDIO)) {
+			ret = dw_mdio_init(dev->name, dev);
+			if (ret) {
+				err = ret;
+				goto mdio_err;
+			}
+			priv->bus = miiphy_get_dev_by_name(dev->name);
+		}
 	}
 
 	ret = dw_phy_init(priv, dev);
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
-- 
2.53.0

