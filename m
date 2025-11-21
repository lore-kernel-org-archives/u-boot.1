Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06815CFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B3B83AA9;
	Fri, 21 Nov 2025 18:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="szCM/THB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0761B83A5A; Fri, 21 Nov 2025 18:37:27 +0100 (CET)
Received: from mx-relay176-hz1.antispameurope.com
 (mx-relay176-hz1.antispameurope.com [94.100.133.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20140839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate176-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=aSlhC/QRrWJ95OWNboW3voiNINL+mtp+2bt+pio8woc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746644;
 b=rVXqsQIn74nGzY6wu/JgQsYZX9NR97zFrlNoH9NimVHKTdmG+uOVufPooCuFdz0bYs267GEM
 ouIHHhViVE1JMyFU7yA0Z+jvDTAqSKJoQ2jJgHzXJCn0r8zzPwgLnFm7QKbl7wrwVXNahRAzpWO
 qrSRdb/gQcIG9F0PxTj7yj73jvYBNK0Vg3qDyuuaLK3LPxhjfykI8ragEdqSDOk1wWu3aGirhha
 HojWwGex8VDonI/vcIhJOh6A31d+0VoJ0rlAuVNcedlb2KLBo1n0EaVIkfguWSOtTy8v7CMaScl
 SEQCC/aI/cQM/DldAc9HUUFudlEWwe7ZnZDFsOrNp0IOQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746644;
 b=B+QZTeHW9O+nlwkxMEIhUyD6jggKQ/v/qF+g21s8pSAv7MSgmzJoD3a3zUETatuHFbpEj5FO
 7FI4TuVWLgHpXmP6LqNL4mDCc6WSgUNINIW3mLFqam9hq4RxfXYeNsUnprG9oM+8Ihw1qsq24va
 Si0ctrNOmWfzZSIndegy8jBZVoJB/jdR9C3QibpCzhERSukvuFiP9l86brj7syxsppV+hKLa+1T
 /iwBMl5x3HfYJpefvmswhb2VQteqeCbL85FDkPD9xR5VmpS+EEon8fmPBeVqTNeYxc+32EBm4Wb
 gf7qgQWk2c1k6XnYFlrZUD3Ul2uB7N5wVFUGoRYoxWNxQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay176-hz1.antispameurope.com; Fri, 21 Nov 2025 18:37:24 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id AEEDFA404E1;
 Fri, 21 Nov 2025 18:37:05 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Fabio Estevam <festevam@denx.de>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 4/8] net: fec_mxc: fix remove with DM_MDIO
Date: Fri, 21 Nov 2025 18:34:44 +0100
Message-Id: <20251121173505.6235-5-Alexander.Feilke@ew.tq-group.com>
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
 mx-relay176-hz1.antispameurope.com with 4dCj8L2MQVz1lt7y
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8b82c2611c1051663c9eb5661a330727
X-cloud-security: scantime:2.078
DKIM-Signature: a=rsa-sha256;
 bh=aSlhC/QRrWJ95OWNboW3voiNINL+mtp+2bt+pio8woc=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746643; v=1;
 b=szCM/THB7Sd6qTTf0Mg5kaPJ1sQBa8vRTb9eshPzTi5KbkreeOazXOVSPiDeXaI7KouGvAIZ
 /L27M0l6ixEes0KI1dP8UnvjD+Q9gevj4LdRVjcZScAYC23dFlWbvRWVL7Pq4p+0pSYVKhGwnbI
 F5bVNBzZWFke5qT+0Y9U+S1D3Zs+wACjmhLaioDpsDMZaClou5WH8zV1UUOau/q0YLJM+TTfwV5
 FDJhUgQmxqYRiaC9welBFthXc7LrID5ntUZNrnYJR6Br9sqLox7+kUiNnm0OdQ/oYKv5TbVB4HS
 wNg/ZtqlMhgwSaUJs4fFmelxuEE7Z4l+IYlU1ifC2+S/A==
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

If DM_MDIO is used and the FEC device is removed the mdio API
must not be used to remove the bus structure. Store pointer the
the udevice for MDIO bus created by dm_fec_bind_mdio and use DM
functions to cleanup the device in fecmxc_remove.

Fixes: 3b8f99a3e762 ("net: fec: add support for DM_MDIO")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 14 +++++++++++++-
 drivers/net/fec_mxc.h |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 18c717855b4..69a76e879b1 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -9,6 +9,7 @@
 
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
@@ -1089,8 +1090,12 @@ static int dm_fec_bind_mdio(struct udevice *dev)
 
 		/* need to probe it as there is no compatible to do so */
 		ret = uclass_get_device_by_ofnode(UCLASS_MDIO, mdio, &mdiodev);
-		if (!ret)
+		if (!ret) {
+			struct fec_priv *priv = dev_get_priv(dev);
+
+			priv->mdio_bus = mdiodev;
 			return 0;
+		}
 		printf("%s probe %s failed: %d\n", __func__, name, ret);
 	}
 
@@ -1431,8 +1436,15 @@ static int fecmxc_remove(struct udevice *dev)
 
 	free(priv->phydev);
 	fec_free_descs(priv);
+#ifdef CONFIG_DM_MDIO
+	if (priv->mdio_bus) {
+		device_remove(priv->mdio_bus, DM_REMOVE_NORMAL);
+		device_unbind(priv->mdio_bus);
+	}
+#else
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
+#endif
 
 #ifdef CONFIG_DM_REGULATOR
 	if (priv->phy_supply)
diff --git a/drivers/net/fec_mxc.h b/drivers/net/fec_mxc.h
index 77bfc1cbf45..12cc00423fa 100644
--- a/drivers/net/fec_mxc.h
+++ b/drivers/net/fec_mxc.h
@@ -255,6 +255,9 @@ struct fec_priv {
 	int phy_id;
 	int (*mii_postcall)(int);
 #endif
+#ifdef CONFIG_DM_MDIO
+	struct udevice *mdio_bus;
+#endif
 #ifdef CONFIG_DM_REGULATOR
 	struct udevice *phy_supply;
 #endif
-- 
2.34.1

