Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BDCFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F7683AA0;
	Fri, 21 Nov 2025 18:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Q1Y0o3Q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9E883A5A; Fri, 21 Nov 2025 18:37:12 +0100 (CET)
Received: from mx-relay126-hz1.antispameurope.com
 (mx-relay126-hz1.antispameurope.com [94.100.132.192])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20616839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate126-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=lsBdWJXY86SaMGfNttwzQ1SNd0g9FegmS4aV0KjcpNs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746629;
 b=GxbZ2L4dUoEjE3x2oiik9uHag7BM8O8oKI+3JmHhncX9/6xojsHQL86THtwYKt2q9vadAl54
 2Pv2AgeLLXQNTtmqsljK4OHMIhLScS7TCFXNqT2FF//HUWNmybn/RDMNQ3TcNZgvPSc2jZHrFER
 S0+n4v8t6bkm/W09SWvTgnjn9OSpfjkmcyhBIL4JkPQyLWCjKtmTAHWwJvtoAwtddPOLhIJpKZJ
 ob5zJfOxVsayTFV7AO8P6kS8WMk1C3jF8/JVvCG28KqnSCx9PYbQInvYNwk1rQIv5hoT/qYMDb3
 hO19c6eCilZhJ5nAQfhsHg4GHCPTdkv1g3hnRSu9ieuDA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746629;
 b=cXBR9CojIVCJIBnR3pNwjlcJ5tbwzwmv33QeVC69Au/ndQ7RkoHwIvHqMF6OmwjO4S1JvRpK
 e47l2Vmh16or0PBT93f2y44B1LxkscZG6SP82MQH+d2DabSgtuCtFCwbvG4dXFu8YelLhJ5z3Gs
 AQTxH0YlkgfYJdam8qn3AdgMQHtjArIKe1qGVdDGV04NCunqYiR3Qh2bw91pOOeR0DU3uGe+vgC
 Vy6jObOPxdHltjgAtdT9WxedOp4lk4Hmvzsu+ygqhS8rExeG2VL01X4WMRpiOBXyc56ctHMTUMJ
 SFPvEg8YQJWPLjELbFNycUA0YXCNP54qImaEAjyodfy/Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay126-hz1.antispameurope.com; Fri, 21 Nov 2025 18:37:09 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 73AB8A4076E;
 Fri, 21 Nov 2025 18:36:50 +0100 (CET)
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
Subject: [PATCH 3/8] net: fec_mxc: fix probe of MDIO bus for DM_MDIO
Date: Fri, 21 Nov 2025 18:34:43 +0100
Message-Id: <20251121173505.6235-4-Alexander.Feilke@ew.tq-group.com>
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
 mx-relay126-hz1.antispameurope.com with 4dCj830hWpz2LfV1
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8300485dc3335cf2070d8f2282f31a16
X-cloud-security: scantime:2.082
DKIM-Signature: a=rsa-sha256;
 bh=lsBdWJXY86SaMGfNttwzQ1SNd0g9FegmS4aV0KjcpNs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746629; v=1;
 b=Q1Y0o3Q7cWlPlaUzfB2FUd6OGLS89o7nca4yA1ue8cnkt/5VyKohA4aW/T6hJHkfNPdAebl0
 YYMpCgGhX7TqWdxBROpml8VtBVCUTPKLAXkQa6OIJP7FxyaVFf7obRt6JQDuzVbu126DZLPgZwz
 ix+VbrqzdfZsNDW3LeNpOMKuyY0XANRCZTYY1DaKKtuvlOJsPKgq78JwRN3EYpm878dtDk2mwPP
 bvMRR7CIGvsOUPjGNlqnRZQpUuIGtQL1IH9XXmUSh4RaO5RmsqQWJuIrLzUuQ+cbz7CLlFeg3Np
 XW8o2m94dUcSQGNpDmGkRqxTPzG8KpdAamp9i6e/rf0sA==
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

When initializing the MDIO bus the MDC signal needs to be configured.
Otherwise the communication over the bus may fail. Add the call to
fec_mii_setspeed to the DM_MDIO probe handler.

Fixes: 3b8f99a3e762 ("net: fec: add support for DM_MDIO")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 629def541ae..18c717855b4 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1051,6 +1051,7 @@ static int dm_fec_mdio_probe(struct udevice *dev)
 	struct dm_fec_mdio_priv *priv = dev_get_priv(dev);
 
 	priv->regs = (struct ethernet_regs *)ofnode_get_addr(dev_ofnode(dev->parent));
+	fec_mii_setspeed(dev->parent, priv->regs);
 
 	return 0;
 }
-- 
2.34.1

