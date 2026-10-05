Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71783CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BF1340698;
	Mon,  5 Oct 2026 14:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnbt4uLDqcvz; Mon,  5 Oct 2026 14:01:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D37940699
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791208868;
	b=USGtEzapfO5pyQZxRHessEy/6PrRrq2IuEsJ+9HHUCh/FIFiARZDAnuDJupeXAxoiyl5
	 Ot59JNWFJYkulEu1leNUZ8wr1tnnrH/7AauOfcDdqVvzUUNSUAMZgpJuAjJYIGgqSFVpv
	 oM7uJ+qBhKcLHjmYE96z2fYPXS0AZqTjQ/WN10tYViFuitGACtq71/iT2YK4YNkVBMypB
	 r0hPqY3xiN7/es3/koslywX2hv2ye+5HMEOhZl74ldp1OawGShlIjBMiuvMczsTZa70GT
	 GpFD8ijL9ml0y7dOc4mcIOzXdd7MlVZHwIeJd8hFoXowAV1UP/h6foUwZb8tSULLCPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791208868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8ITs71KRgsgmpgc9LjGcs5P8uwwsWBif4lD4OtkhNr4=;
	b=Bj3PYH4LTVu4Ydxu03SJI4eVTzsb5I7dfG56wdqNi8F2xq7nVqNqoMWJmbFXKajPupFL
	 wzOxP/Icu4lOhSXYP0x3SlOFksnyBdkWK3tk1QP84Eifa5IJN9/K7NCSQAJX3cYVvyC/p
	 nz/bCncFW8oIPBt8NFL6N89WZpyDAbVONk8diP1UwqIUiMzCA7kqqYoCm1tx7d6vMmESi
	 76m93B5C6NWsXsEwkRbckJtkGPy9BhSVfULhSDIOeH4Q8vhn1cyPHVMfIvUGGXtuvH+I8
	 wEGWFHXqnPqT6OUU33fbB/uTUWk8DHcQLVP5cIcScp3GiyWTooBvpm5blE9BjSw4+Nw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791208868;
	bh=8ITs71KRgsgmpgc9LjGcs5P8uwwsWBif4lD4OtkhNr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NmMgmA91On+cXVISoDYPRONKnYBCCnTJ/jqytUgdGDWJoM+6hwcJmDc48Oqp7HrPc
	 GZHjtIzr6LUnHsZzyc/vxedgigT/uwFHW3+5n/FoWwOKRVq3bQ+3F9QNPUZdj6Lxff
	 1Qks/MLWdpEfsvTBKkJolV4hGsXuIdSOJIMMjYiW+3YCQDfeauivo4DD0nl6oduVrx
	 ZKnPhnNkMmOU/3RqMgqKZ6g+SZAPmccd5eesuOdHVMdKj4RKXDA3KDRPsUbrPeSPs0
	 LsRKbqgotMi19+oBRMu7TLRnYXqNUNJHyjd6pYj81cOLdxnCAcPGA19xd2ufihzBKg
	 3f3My1pRRW48Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D37940699;
	Mon,  5 Oct 2026 14:01:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC797338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2B2580A96
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spPP0gqAzZDz for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0001D80A76
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791208452;
 b=CR0+pPVgzYzjRFhba24MiewO0lNnVfSnOVF7UDZFI2ib2UAyjNSxZHJL+3tD6pSxHweF
 FIaECYvEq6JOB4spTwm2t6UqNVLUJU7SW1R58FqeYCZlnmlUP4ziWHBLQYEa1QAMSBIyc
 5DlTj5SAaBs4QNMEarJGI5N9cfpvuGPP5fFAwt5w9469nRwg/5w2D8X9+adfHYtn5dEEy
 imNZGrbqRmiVYQdDhy5MR/DCicrVqfH6deKHlzfUhFkxyiAfOiUuk5Vg4bTnKkFjUsnWa
 pAkjf9aorAAnTZwHGB8SESLc5hWCfvp9fh6tPEGitH9Jc4VdPzX3ONxAKsk3xtxXrsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791208452;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=8ITs71KRgsgmpgc9LjGcs5P8uwwsWBif4lD4OtkhNr4=;
 b=MH9NlwhP4vgRPaMNin2Pu/mObYi/RAZxkxqunx/SW97p56Vsmnf8hAn2VFjG7sG2vkQ5
 Fq3XCUbt7YUtnvsow5+tpkuCzyglBg6Fy2kfWqnRq6pP2seAmK05O7szHBol7Sxg1NbUy
 OG7vfNlIWNl2v8sVJWYJBoqX5catuTyfK/WUoOJZBzjgvDhPFlOLu3Is+CuErKh8sSQxZ
 SuaxitChtbINRIqwhQIiW/meCzaRpDt9+0rVEelU8o7nISqmngwfjCM3aWDzd//VPe2aq
 U8vlNLA2ZUvIPibLENvLMJjRgDa5rhOamn3fkatag2Zvgat7TGYEE0hxZpG80XRW5XA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=1I00VcAi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=1I00VcAi
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com
 [IPv6:2607:f8b0:4864:41::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0001D80A76
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:54:10 +0000 (UTC)
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8acdb1ddd96so10911207b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1791208449; x=1791813249;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ITs71KRgsgmpgc9LjGcs5P8uwwsWBif4lD4OtkhNr4=;
 b=1I00VcAiZrtHD6Cjje6+WTgB6jWCWnNVZwPKrVAutsLCVuUBtfCDtJj/l5yEIgIKqs
 +XsU6b1R6oVHoCk7tYyATqvL7D/39BN+WU/CbWIQgwxmpy/kr03mzYFWuLvVz3eE4PE1
 W7OqdxotPkE8tnNlR9frogp8GeOV90C1rVErZ/YHWqR9ETL2liVaPCVEpAI/l2CI9Rpc
 AsuV+0+PQMXeA6DyufYxBrvGWqx7HkGrbu4kz2/teR9y6WIEobuL4c/IBnYP6vbBJZG3
 Uao06Oe6j9ouQH94HtVs7Hy1I33aBhF+Vsmeawonnhe5BeHbsPUlUWWrNXt8bkz6kXfQ
 NMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791208449; x=1791813249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ITs71KRgsgmpgc9LjGcs5P8uwwsWBif4lD4OtkhNr4=;
 b=e0hfWbdrVhkltTzNXRms4SP3pvj+Z9nVWzdKsaTO+L2bhoxXRR6ppvIKAhUdI/O2Ht
 2vtffiH+0r/k7bAdHBUgG3bPQveSGd2jLmaPqKFKS8J19zwa8qgucXAWbfYAglHuKldk
 H1XmoF3epqvSZJdSp6X+q8Ib/vpPUmTONkEUmVuQXs+w0tr9Czyy20BR+rFeCXtrY/0H
 W5z6cdjLgXmOgbc/nP576u49YdTiEzAUgOrEJ/56BRZBX0q7QRAxFexMcZ27xGZNQQMY
 yV0IApPfPGPQByO2hvdKfAwavaUiwxeU1dJX7PIvZEyVzofRZ3HjoQfj4Xq43hRAdkCG
 PKcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRWZuvtEuHJIRBNaOxi3h0YTT6xh0MMBKq4TLIs9IxYIV6TmCsW3liMK5c/PNSqX916sSeCkg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLCPMHgZ/BxgSptdpHGCfJRgKKYstZ1Ob8l8SUYC7SsSoSnG+OT
 5oZ82l7yszMaTtki6E3+X+M5r+Qe4BX5TTHHKDzJjwuRyrUT+g6NWhcmLIS0jpUPHyuOZk2tU0m
 RDLuxEYiq2ev9ngaCaoA8vd8RrzcbT58MDg9mAYPpKrRpOlIIlqqLXWZsRtIHySp3mNL4A/ip5l
 LDtpg=
X-Gm-Gg: AYBFou3UlOzb3jUr2tqBoNi8p73SJeUiC9d7TozCuRF8QZFuCP+ce9NqGEoEDCE1r1M
 tx7jcir1zv2qubxEdYECHyUKIRE5vHZVSTWHHb6MZo0D+MofTsXV0JyK68PmQgILetc3mgGnDSA
 +8bTzf+l2/1IRco0xVmZc4ZmiIKHGe4bhD1Sde7JywteF250eSxEOuQRTQn7t9v2oc2zwlhsTEq
 sgp89k16DscTgeknOAbDNErIMM8cmMeQtNTdiZzPrfOqqWkt6b604NmLxduIZipdxY3JozU16xB
 8lrByk8nAlnh4CQtejoFExLzwJBsH3+S+b/0P4/24Khs3oKfMxTs46MvfBwoVqEBi3vNUv43Yb+
 GJYg/f6xfR6UPxWyaGgnq6hqoeSArIRR/8DjAsjBKvY2WrHvKhh9cFrIZmAXILUn0YopWTmJSIu
 ZZiDhq17vLxmRRgFEhU/WFNprkSQO6Od+KS/flNf+oWOcZoDsRLcTzRP+RPdchLsc=
X-Received: by 2002:a05:690c:6d83:b0:879:44a6:1076 with SMTP id
 00721157ae682-8ae397b974bmr41470347b3.32.1791208449366; 
 Mon, 05 Oct 2026 06:54:09 -0700 (PDT)
Received: from strozzi ([66.193.28.125]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ae30120b8csm38852867b3.4.2026.10.05.06.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:54:09 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 Sean Anderson <sanderson@brivo.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v2 1/2] net: designware: Use if instead of #if for DM_MDIO
Date: Mon,  5 Oct 2026 09:54:02 -0400
Message-ID: <20261005135406.509901-2-sanderson@brivo.com>
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

Where possible, convert ifdefs on DM_MDIO into ifs.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

Changes in v2:
- New

 drivers/net/designware.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..ff7294ab4f4 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -137,15 +137,16 @@ static int dw_bb_mdio_reset(struct mii_dev *bus)
 
 #endif
 
-#if IS_ENABLED(CONFIG_DM_MDIO)
-int designware_eth_mdio_read(struct udevice *mdio_dev, int addr, int devad, int reg)
+static int designware_eth_mdio_read(struct udevice *mdio_dev, int addr,
+				    int devad, int reg)
 {
 	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
 
 	return dw_mdio_read(pdata->mii_bus, addr, devad, reg);
 }
 
-int designware_eth_mdio_write(struct udevice *mdio_dev, int addr, int devad, int reg, u16 val)
+static int designware_eth_mdio_write(struct udevice *mdio_dev, int addr,
+				     int devad, int reg, u16 val)
 {
 	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
 
@@ -162,7 +163,7 @@ int designware_eth_mdio_reset(struct udevice *mdio_dev)
 }
 #endif
 
-static const struct mdio_ops designware_eth_mdio_ops = {
+static __maybe_unused const struct mdio_ops designware_eth_mdio_ops = {
 	.read = designware_eth_mdio_read,
 	.write = designware_eth_mdio_write,
 #if CONFIG_IS_ENABLED(DM_GPIO)
@@ -170,7 +171,7 @@ static const struct mdio_ops designware_eth_mdio_ops = {
 #endif
 };
 
-static int designware_eth_mdio_probe(struct udevice *dev)
+static __maybe_unused int designware_eth_mdio_probe(struct udevice *dev)
 {
 	/* Use the priv data of parent */
 	dev_set_priv(dev, dev_get_priv(dev->parent));
@@ -178,6 +179,7 @@ static int designware_eth_mdio_probe(struct udevice *dev)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(DM_MDIO)
 U_BOOT_DRIVER(designware_eth_mdio) = {
 	.name = "eth_designware_mdio",
 	.id = UCLASS_MDIO,
@@ -208,7 +210,6 @@ static int dw_mdio_init(const char *name, void *priv)
 	return mdio_register(bus);
 }
 
-#if IS_ENABLED(CONFIG_DM_MDIO)
 static int dw_dm_mdio_init(const char *name, void *priv)
 {
 	struct udevice *dev = priv;
@@ -234,7 +235,6 @@ static int dw_dm_mdio_init(const char *name, void *priv)
 
 	return dw_mdio_init(name, priv);
 }
-#endif
 
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
 static int dw_eth_bb_mdio_active(struct mii_dev *miidev)
@@ -757,24 +757,24 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
 	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
 		eth_phy_set_mdio_bus(dev, NULL);
 
-#if IS_ENABLED(CONFIG_DM_MDIO)
-	phydev = dm_eth_phy_connect(dev);
-	if (!phydev)
-		return -ENODEV;
-#else
-	int phy_addr = -1;
+	if (IS_ENABLED(CONFIG_DM_MDIO)) {
+		phydev = dm_eth_phy_connect(dev);
+		if (!phydev)
+			return -ENODEV;
+	} else {
+		int phy_addr = -1;
 
-	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
-		phy_addr = eth_phy_get_addr(dev);
+		if (IS_ENABLED(CONFIG_DM_ETH_PHY))
+			phy_addr = eth_phy_get_addr(dev);
 
 #ifdef CONFIG_PHY_ADDR
-	phy_addr = CONFIG_PHY_ADDR;
+		phy_addr = CONFIG_PHY_ADDR;
 #endif
 
-	phydev = phy_connect(priv->bus, phy_addr, dev, priv->interface);
-	if (!phydev)
-		return -ENODEV;
-#endif
+		phydev = phy_connect(priv->bus, phy_addr, dev, priv->interface);
+		if (!phydev)
+			return -ENODEV;
+	}
 
 	phydev->supported &= PHY_GBIT_FEATURES;
 	if (priv->max_speed) {
@@ -962,11 +962,10 @@ int designware_eth_probe(struct udevice *dev)
 	} else
 #endif
 	{
-#if IS_ENABLED(CONFIG_DM_MDIO)
-		ret = dw_dm_mdio_init(dev->name, dev);
-#else
-		ret = dw_mdio_init(dev->name, dev);
-#endif
+		if (IS_ENABLED(CONFIG_DM_MDIO))
+			ret = dw_dm_mdio_init(dev->name, dev);
+		else
+			ret = dw_mdio_init(dev->name, dev);
 		if (ret) {
 			err = ret;
 			goto mdio_err;
-- 
2.53.0

