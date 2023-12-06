Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9AC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 14:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE30876C0;
	Wed,  6 Dec 2023 15:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="QlxC7uus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D76E87663; Wed,  6 Dec 2023 15:36:02 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF76F8766C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 15:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch (unknown [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPS id 0F3A71C116E;
 Wed,  6 Dec 2023 15:35:58 +0100 (CET)
Authentication-Results: mail.nic.cz;
 dkim=pass header.d=nic.cz header.s=default header.b=QlxC7uus;
 spf=pass (mail.nic.cz: domain of marek.mojik@nic.cz designates
 2001:1488:fffe:6:592e:6672:3345:e2e0 as permitted sender)
 smtp.mailfrom=marek.mojik@nic.cz; 
 dmarc=pass (policy=reject) header.from=nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1701873358; bh=RRGhGKsWRAVyJPvu+D9iqhssDRBYv9s3F7Jya1M70dk=;
 h=Date:From:To:Subject:From:Reply-To:Subject:To:Cc;
 b=QlxC7uusH53AIWlWuufuqW4xGu7FLNjD7+tb54RSvsvIBHJaFv5FAYWHsc2FWuAlH
 RV+QDq9UfUV3uKcA6L1OVOi39QyuYf+zV0E0yeBJ0rlHtQTei1xDuKN/4p85MNZJJ1
 R0MyFYAEpK/ue5VXrb35m05QdEENJsP6FJwdj49w=
Date: Wed, 6 Dec 2023 15:35:56 +0100
From: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 tharvey@gateworks.com, marek.behun@nic.cz, marex@denx.de
Subject: [PATCH v2] net: mv88e6xxx: fix missing SMI address initialization
Message-ID: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F3A71C116E
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.00 / 20.00];
 DWL_DNSWL_MED(-2.00)[nic.cz:dkim];
 DMARC_POLICY_ALLOW(-0.50)[nic.cz,reject];
 R_SPF_ALLOW(-0.20)[+ip6:2001:1488::/29:c];
 R_DKIM_ALLOW(-0.20)[nic.cz:s=default];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[lists.denx.de,ni.com,gmail.com,gateworks.com,nic.cz,denx.de];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; DKIM_TRACE(0.00)[nic.cz:+];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Rspamd-Server: mail
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

The mv88e6xxx driver does not currently initialize the smi_addr field, but
instead keeps the default zero value. This leads to driver being unusable
on devices where the switch is not on address zero of the mdio bus. Fix
this problem by reading the SMI address from device tree.

Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 drivers/net/mv88e6xxx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
index c073f81e72..8fbbc1cacc 100644
--- a/drivers/net/mv88e6xxx.c
+++ b/drivers/net/mv88e6xxx.c
@@ -745,6 +745,7 @@ static int mv88e6xxx_probe(struct udevice *dev)
 {
 	struct dsa_pdata *dsa_pdata = dev_get_uclass_plat(dev);
 	struct mv88e6xxx_priv *priv = dev_get_priv(dev);
+	fdt_addr_t smi_addr;
 	int val, ret;
 
 	if (ofnode_valid(dev_ofnode(dev)) &&
@@ -753,6 +754,13 @@ static int mv88e6xxx_probe(struct udevice *dev)
 		return -ENODEV;
 	}
 
+	smi_addr = dev_read_addr(dev);
+	if (smi_addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Missing SMI address\n");
+		return -EINVAL;
+	}
+	priv->smi_addr = smi_addr;
+
 	/* probe internal mdio bus */
 	ret = mv88e6xxx_probe_mdio(dev);
 	if (ret)
-- 
2.42.1

