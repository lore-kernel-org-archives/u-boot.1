Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12872CFC296
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2BE83A97;
	Fri, 21 Nov 2025 18:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EYnGRO8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD9683A5A; Fri, 21 Nov 2025 18:36:54 +0100 (CET)
Received: from mx-relay149-hz1.antispameurope.com
 (mx-relay149-hz1.antispameurope.com [94.100.133.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF252839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate149-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=vtEKlrZsEzib4V/Kk6a1OBrqiYWpJ7eNWz9aB3ULsg8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746612;
 b=FMTba9qc36Oo4OOeZ1I3oVx9y3IrTgPgA6o3bp/11CRNRx7WFPYnLbvKlVETDSQ06r4TBEYH
 n1AZPobJm3m5+hQc3YJV1xjXHrRR43efPYqpUKoUbwG/aJofIHJTegwmO7W4KluZk90EZOCDLCh
 EJFwo2LG04jy8CyyNxgA0Kw8oPhCybxxdZ623vdEG90x0uL9AMQFtkV/qluIdqD9JRKuSQ5fA9K
 1e990KyAgNWmyV7xuDu51FTN5TON3/sCloX0QIVDUSYG405cylAFTYqBA4MOxAEaNU2S3wLEGAG
 7DWIAHN1XnV70F4z+7a+5vdi2wHuaIyM26Sh83OOEXIQA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746612;
 b=TF2uh2o6v3+HkSmeX3wY7SxrmhkFk7W/FWcICtcSiymDndI5D3NtpZx3rpwHIiTSE8m0KK3N
 9gJYK+Dn2PzAQbGh2P4t3wm5eFFumcMgP4PDBo+/o/Sd98XZAZGup+UHAiy7IMnzeTppSLqlbPG
 bJBMVBGzElG+6dqMrm+Yo1lL4GVTsm859aq3hcLI8+P0myG3sniFBWCXS2xiPryVoEb+SFRYBwW
 v4iMcZjSrXQye7cQTD0LTNsshFcixI3rTt2CCnxszwODXJn8Tsh46oXhelKbCj6eR8ZLh9imPQh
 DrvVFf4jwKwJrGJJn+e+XTHg0qUH931B3IlV7yURlJcow==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay149-hz1.antispameurope.com; Fri, 21 Nov 2025 18:36:51 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 73940A412A7;
 Fri, 21 Nov 2025 18:36:34 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 2/8] net: fec-mxc: prevent crash if no MAC address is set
Date: Fri, 21 Nov 2025 18:34:42 +0100
Message-Id: <20251121173505.6235-3-Alexander.Feilke@ew.tq-group.com>
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
 mx-relay149-hz1.antispameurope.com with 4dCj7l0Msdz18PZK
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 4cf30dd7d2c7ba48fcdadb3f6472df0c
X-cloud-security: scantime:2.092
DKIM-Signature: a=rsa-sha256;
 bh=vtEKlrZsEzib4V/Kk6a1OBrqiYWpJ7eNWz9aB3ULsg8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746611; v=1;
 b=EYnGRO8Lri/kO8cR6jD8Pli5CGiaEzfAGFfsmSRr9XRRtdR2oKv97v/jThPEovsKvx0Sf66C
 T4hlO/pE64RLbKP7Y/rdHX7Qd1iRutmJB2PkRRTvpsv6Ot2nm9LMzO6XLqbjAvAJX+F2gluq29w
 aOAaZOHaDBwhYWD4Nm33NUfJyb7KeLuVc56SxnU7DJ7GscIURj4PHwKMCD+XR9KRwjtCzfFW/ww
 IY/c48Ex3YEk/CmIQguHr6rLTpUVuGFBaR/6C7s1gpEKIOz9y37f3d4rHMqgm9zwtV7MdanTgL2
 ghXlwgtl4VLi9pRXL/qel6l0BDpfkv/F5k/5EDqDbh/8A==
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

If no MAC address can be found (either in ROM, device tree or env),
the post_probe of an ethernet device will fail and therefore
the device cannot be instantiated.

The DM_ETH_PHY (eth-phy-uclass) use case must not be mixed with
using CONFIG_FEC_MXC_MDIO_BASE.

This prevents following error for MAC not fused, no eth[1]addr
env is present and providing a random MAC is disabled:

Net:
Error: ethernet@5b040000 address not set.

Error: ethernet@5b040000 address not set.
FEC: can't find phy-handle
"Error" handler, esr 0xbf000002
elr: 000000008004e4b8 lr : 000000008004e4b4 (reloc)
elr: 00000000bfe984b8 lr : 00000000bfe984b4
x0 : 0000000000000000 x1 : 0000000000000020
x2 : 00000000bbe61e50 x3 : 00000000bbe6e1a0
x4 : 0000000000000020 x5 : 0000000000000020
x6 : 000000000000000a x7 : 0000000000000000
x8 : 0000000000000000 x9 : 0000000000000008
x10: 00000000ffffffd8 x11: 0000000000000006
x12: 000000000001869f x13: 0000000000002c50
x14: 0000000000000000 x15: 00000000ffffffff
x16: 0000000000000000 x17: 0000000000000000
x18: 00000000bbe61d98 x19: 00000000bbe4fa68
x20: 00000000bbe78c10 x21: 00000000bbe6e460
x22: 00000000bbe78c10 x23: 00000000bbe91780
x24: 00000000bbe6e510 x25: 00000000000001f8
x26: 00000000ffff8000 x27: 0000000000000000
x28: 0000000000000000 x29: 00000000bbe4fa10

Code: f900003f 9100a3a1 97ffff6e 35000100 (f94017a1)
Resetting CPU ...

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 471e3de44a6..629def541ae 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1364,17 +1364,18 @@ static int fecmxc_probe(struct udevice *dev)
 
 #ifdef CONFIG_DM_ETH_PHY
 	bus = eth_phy_get_mdio_bus(dev);
-#endif
+	if (!bus)
+		bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
+#else
 
-	if (!bus) {
-		dm_mii_bus = false;
+	dm_mii_bus = false;
 #ifdef CONFIG_FEC_MXC_MDIO_BASE
-		bus = fec_get_miibus(dev, (ulong)CONFIG_FEC_MXC_MDIO_BASE,
-				     dev_seq(dev));
+	bus = fec_get_miibus(dev, (ulong)CONFIG_FEC_MXC_MDIO_BASE, dev_seq(dev));
 #else
-		bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
+	bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
 #endif
-	}
+
+#endif /* CONFIG_DM_ETH_PHY */
 	if (!bus) {
 		ret = -ENOMEM;
 		goto err_mii;
-- 
2.34.1

