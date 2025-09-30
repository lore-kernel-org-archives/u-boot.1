Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FFBCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 08:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E068352B;
	Tue, 30 Sep 2025 10:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WRxEMdBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A0883544; Tue, 30 Sep 2025 10:06:13 +0200 (CEST)
Received: from mx-relay86-hz1.antispameurope.com
 (mx-relay86-hz1.antispameurope.com [94.100.133.253])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F417683526
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0361cc115b=matthias.schiffer@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate86-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=7PBXapjxcBhEuPhdurYTJ3NxJYZSLfeA5DDJ/mLRyKw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759219568;
 b=tO7oQM6LY4zySt5Amo0iSUbcwI8l5lwNRmwb5fJ00VnyZl8y9aJ5zmgJfADJ9rxeJnQrCHDl
 VO6Hfssatz1K6in0JeWIPXVRLIDITwrHKcRG1mDFE+MsjGnTLFN6BWDOMxfKF9ywRxHjal1+O/3
 UOvRylG+vAoeHumbrqhPDm1llawkdW5h/IjudZ1g6rhOtnrfomCMEO6M6NYhw+58xMPAMWY8XPK
 +MngXAa+2mEaHL2keOSj3Li4qQU2qaV8QyFhRS1qJBfbz6V/3lqmqzN9O3SMJDgW5V8LoFbp0/D
 W91fRQSgNL4UFXYAk3yxuFJLQv//qw9P4iBsUG925ZWWA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759219568;
 b=sAX8c04lh2ueUCGgupEZ2WNPpIEU7zmzd94Dq36GFW5efeqFuCCo/1VJMQ8wbYSB5pDNzIfq
 jFtgE0VNsbgmc+e07UHeLiBXxnBLgWEoEw6O3cs92LDRRMqBB1AYwItI92Wfm+9wnBHGwxIOFiO
 5VaARJfN1CviUOYBDvSGHBXJK2GJHkEkp5SoVQikr1qwQtQLvfRgjZNzQMb67Ng50y2znri5CB3
 9mr0WhS+idhZZrpIhI4eb97zMojMhpWHDnC5bCzzcZcqAgSPfMbhzTsbdXgkKW4ow4TUDwKowMb
 tEvSB8kY4DR/1RW9qlC7XOiz/d/gqO/BLKLk6oc2tom6w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay86-hz1.antispameurope.com; Tue, 30 Sep 2025 10:06:07 +0200
Received: from schifferm-ubuntu.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: matthias.schiffer@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 B3A04220CEA; Tue, 30 Sep 2025 10:05:33 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] net: mdio-uclass: introduce dm_eth_phy_connect_interface()
Date: Tue, 30 Sep 2025 10:05:10 +0200
Message-ID: <c432fdec88cf9f051b488e187ca683ccf8f80667.1759218200.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay86-hz1.antispameurope.com with 4cbVwt1bF2z17RrG
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: b4c75395800c2dd50323e06272fc0f0d
X-cloud-security: scantime:5.674
DKIM-Signature: a=rsa-sha256;
 bh=7PBXapjxcBhEuPhdurYTJ3NxJYZSLfeA5DDJ/mLRyKw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759219567; v=1;
 b=WRxEMdBtAneKpzFRjyGaPtp8iya3S4ZdyAayEyxsoxwzOB+ANsAQUvgEUzdNYHEdKdeFZFu5
 l8CWmrZZXXZMsQ0Jw/WtKdMZ47pasfcocWgyoduCxuSMmKLmb+JF+9Hdh2quS0mJmUmaD5z7Q41
 LJxrVuvyInuIBNPHr1nH4+24Ce5S89/F1HYJLCmQ9OH1ClTkC3Xn99cEwmRWtkcYvv0dxP9uKhT
 TsF2FelfhbBNKz35dqNESMa+IhT9ESDm9w/JtpuCJPQYgVh3RRF/E6bsjPgtO+HXiNtTqRSH9aQ
 H79G5o99/SOAixtK8ses3lwVJOGoLj44cBzP+JBNjvoiQ==
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

dm_eth_phy_connect_interface() is a variant of dm_eth_phy_connect() that
allows to set the used PHY mode, in case the MAC driver needs to fix it
up. The previously static dm_eth_connect_phy_handle() is renamed and
extended for this purpose.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 include/miiphy.h  | 15 +++++++++++++++
 net/mdio-uclass.c | 18 ++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/miiphy.h b/include/miiphy.h
index 00d0b9b6a43..96afe5f4030 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -192,6 +192,21 @@ struct phy_device *dm_mdio_phy_connect(struct udevice *mdiodev, int phyaddr,
 				       struct udevice *ethdev,
 				       phy_interface_t interface);
 
+/**
+ * dm_eth_phy_connect_interface - Connect an Eth device to a PHY based on device
+ * tree with custom PHY interface
+ *
+ * Picks up the DT phy-handle and from ethernet device node and connects the
+ * ethernet device to the linked PHY, while allowing the caller to specify
+ * the phy-mode to use.
+ *
+ * @ethdev: ethernet device
+ * @interface: MAC-PHY protocol
+ *
+ * Return: pointer to phy_device, or 0 on error
+ */
+struct phy_device *dm_eth_phy_connect_interface(struct udevice *ethdev,
+						phy_interface_t interface);
 /**
  * dm_eth_phy_connect - Connect an Eth device to a PHY based on device tree
  *
diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
index 4f052ae432c..64af689d2df 100644
--- a/net/mdio-uclass.c
+++ b/net/mdio-uclass.c
@@ -242,8 +242,8 @@ struct phy_device *dm_mdio_phy_connect(struct udevice *mdiodev, int phyaddr,
 	return phy_connect(pdata->mii_bus, phyaddr, ethdev, interface);
 }
 
-static struct phy_device *dm_eth_connect_phy_handle(struct udevice *ethdev,
-						    phy_interface_t interface)
+struct phy_device *dm_eth_phy_connect_interface(struct udevice *ethdev,
+						phy_interface_t interface)
 {
 	u32 phy_addr;
 	struct udevice *mdiodev;
@@ -282,8 +282,10 @@ static struct phy_device *dm_eth_connect_phy_handle(struct udevice *ethdev,
 	phy = dm_mdio_phy_connect(mdiodev, phy_addr, ethdev, interface);
 
 out:
-	if (phy)
+	if (phy) {
 		phy->node = phynode;
+		phy->interface = interface;
+	}
 
 	return phy;
 }
@@ -292,7 +294,6 @@ out:
 struct phy_device *dm_eth_phy_connect(struct udevice *ethdev)
 {
 	phy_interface_t interface;
-	struct phy_device *phy;
 
 	if (!dev_has_ofnode(ethdev)) {
 		debug("%s: supplied eth dev has no DT node!\n", ethdev->name);
@@ -303,14 +304,7 @@ struct phy_device *dm_eth_phy_connect(struct udevice *ethdev)
 	if (interface == PHY_INTERFACE_MODE_NA)
 		dev_dbg(ethdev, "can't find interface mode, default to NA\n");
 
-	phy = dm_eth_connect_phy_handle(ethdev, interface);
-
-	if (!phy)
-		return NULL;
-
-	phy->interface = interface;
-
-	return phy;
+	return dm_eth_phy_connect_interface(ethdev, interface);
 }
 
 UCLASS_DRIVER(mdio) = {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

