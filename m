Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8B0CFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F48383ACA;
	Fri, 21 Nov 2025 18:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VMY54A/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15F683A5A; Fri, 21 Nov 2025 18:38:18 +0100 (CET)
Received: from mx-relay08-hz2.antispameurope.com
 (mx-relay08-hz2.antispameurope.com [83.246.65.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007F7839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate08-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=WPamtqOd/pIZZl69Twj8e5SGBMe0iJOleyh4r4y7HTI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746696;
 b=VUVm1uSD6K6lcKJ4FvK1TCCXopFu/igZVs2v7dKfEAvlILgWCwmlk7laWK02r6oMRaoGvCoG
 tHavfBucLLUi4by17UECxzD0cMv5Dk9bxZ4Tpu2/1tZcfo7Of2D+RJP0CqOBY4ySLnFMcPZIiHu
 DTiyJgX70oCEqM/E4/CrlYcHEQMvPBHA5c8d4VqwAnjb0MLKI8se5Yh94gmEAfK4Jfafvcpd6Sc
 us4D5kuxsRXUc+pbWFpbrsQGiIw7jP5nBy6nwafJZMfwNasg6J4bmBqyCJgvfdLp65nwfcU7tW1
 DvsHHCIMCaWUyeLabGTwKVBMPLbR0peCiSOBFdVig9Smg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746696;
 b=QW5PFLDDQUg9UaAOIBVJvlFoRUAlu+FJm/UIMNoLz5VkYwZcFP52B0FIDbOqErUdFzT3m/U7
 Dg+HRYYfZzQl1wLp/EupqLQUE5T0MqriK0WHmn5Iehy1dYFovgpic6ign8o5cF9bkf/2SljeV8d
 4szDjXM+j8MrbOYA2/NIdOKLsxIBdxQhKInlMrWOn/H8Z/0Yt4IwXACmDPreR3tL/gTCZE0JWY5
 pPvNKJR75kpXEAfBTmI/ujsyAI36htZCQI/93fU1iW6/2ES5tEMCKaZ5a30NYCRF1g+BLlUpjIO
 TPFbAD/F/g1UBuBFJJggn173QurM2netX7sdXre3zoNag==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay08-hz2.antispameurope.com; Fri, 21 Nov 2025 18:38:15 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 0458AA40A3C;
 Fri, 21 Nov 2025 18:37:52 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 7/8] net: fec_mxc: add unique bus and device names for DM_MDIO
Date: Fri, 21 Nov 2025 18:34:47 +0100
Message-Id: <20251121173505.6235-8-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
References: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay08-hz2.antispameurope.com with 4dCj9F4j8tz14djy
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: fd9463f61e0913f8387b1e222493ac88
X-cloud-security: scantime:2.293
DKIM-Signature: a=rsa-sha256;
 bh=WPamtqOd/pIZZl69Twj8e5SGBMe0iJOleyh4r4y7HTI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746695; v=1;
 b=VMY54A/ywJz9uBjHaIqnBLF4fZ09vnt16v8W1dokeoqBEusjKEnVxq/TaFvDyrOwl3h4wEN5
 nA6+rweJpf1o/+ntO5ReB+z4WTjucg9GMNCVvzbIQMcaW6r21/BZRG3iYG8fupW6PaaKTXSb2IL
 svCdw9//LV7kgB/XlqYRL9mOMEInC5NgmNMGY1y9QRTm0p+dGAqW9o+z5v3pEuFiYhelBmBqrEp
 wm4+k3p8YWiiCNTO77brMGKUFj2jnnpbEoaNFQaJXHEaDcF5Ef5j4lHl8jmftuBwJ7kMb3oyiSK
 zACHIi9kqRpfUdGC6YMszFK7yD4GzSeBY0bENDCzyW5QQ==
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:51 +0100
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

When using DM_MDIO on SOC with more than one FEC and not sharing the MDIO
bus the name of the driver and the bus needs to be unique. Since name
used in device_bind_driver_to_node needs to be a static string, add the
string to the fec_priv struct and reuse fec_set_dev_name to generate the
name with the device sequence number.

Fixes: 3b8f99a3e762 ("net: fec: add support for DM_MDIO")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 6 ++++--
 drivers/net/fec_mxc.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 6789bfe2500..f6ca87cee3a 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1067,6 +1067,7 @@ U_BOOT_DRIVER(fec_mdio) = {
 
 static int dm_fec_bind_mdio(struct udevice *dev)
 {
+	struct fec_priv *fec = dev_get_priv(dev);
 	struct udevice *mdiodev;
 	const char *name;
 	ofnode mdio;
@@ -1081,8 +1082,9 @@ static int dm_fec_bind_mdio(struct udevice *dev)
 		if (strcmp(name, "mdio"))
 			continue;
 
+		fec_set_dev_name(fec->mdio_name, dev_seq(dev));
 		ret = device_bind_driver_to_node(dev, "fec_mdio",
-						 name, mdio, &mdiodev);
+						 fec->mdio_name, mdio, &mdiodev);
 		if (ret) {
 			printf("%s bind %s failed: %d\n", __func__, name, ret);
 			break;
@@ -1369,7 +1371,7 @@ static int fecmxc_probe(struct udevice *dev)
 	 */
 	ret = dm_fec_bind_mdio(dev);
 	if (!ret)
-		bus = miiphy_get_dev_by_name("mdio");
+		bus = miiphy_get_dev_by_name(priv->mdio_name);
 	else if (ret != -ENODEV)
 		return ret;
 #endif
diff --git a/drivers/net/fec_mxc.h b/drivers/net/fec_mxc.h
index 12cc00423fa..8e95b539cd6 100644
--- a/drivers/net/fec_mxc.h
+++ b/drivers/net/fec_mxc.h
@@ -256,6 +256,7 @@ struct fec_priv {
 	int (*mii_postcall)(int);
 #endif
 #ifdef CONFIG_DM_MDIO
+	char mdio_name[MDIO_NAME_LEN];
 	struct udevice *mdio_bus;
 #endif
 #ifdef CONFIG_DM_REGULATOR
-- 
2.34.1

