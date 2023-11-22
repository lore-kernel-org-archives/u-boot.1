Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76122C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 15:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E281E86EE1;
	Wed, 22 Nov 2023 16:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="VMoN7mGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41AF8755A; Wed, 22 Nov 2023 16:03:12 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53E3863FD
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 16:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch (unknown [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPS id C0B9F1C1496;
 Wed, 22 Nov 2023 16:03:08 +0100 (CET)
Authentication-Results: mail.nic.cz;
 dkim=pass header.d=nic.cz header.s=default header.b=VMoN7mGi;
 spf=pass (mail.nic.cz: domain of marek.mojik@nic.cz designates
 2001:1488:fffe:6:592e:6672:3345:e2e0 as permitted sender)
 smtp.mailfrom=marek.mojik@nic.cz; 
 dmarc=pass (policy=reject) header.from=nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1700665389; bh=iiLdbs+dwHQ+aCSoH6sllYOmu1QGa8/FI8f7VucNYyg=;
 h=Date:From:To:Subject:From:Reply-To:Subject:To:Cc;
 b=VMoN7mGizh0jFT6+pcHqfeNGKv33xhfT6kbhkJCo85Wnf6VsXE3tSk04dKNXGtrUK
 Cr7DBFpdQvi8bsy7XNmjvw2biATYhrgkamSOPtfb+oHYcAUPdvAUyH9OKGEATapq6Z
 b4bNahQHC5ubSfZ9mYH2IqHL1qtAKI1XCFavMR9A=
Date: Wed, 22 Nov 2023 16:03:07 +0100
From: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 tharvey@gateworks.com, marek.behun@nic.cz
Subject: [PATCH] net: mv88e6xxx: add missing SMI address init
Message-ID: <4t2ccomf4epfozf2o5uzkp7c5lzzqhgkfpcfofojomssmzh5kw@76ljhmdjzla4>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.00 / 20.00];
 DWL_DNSWL_MED(-2.00)[nic.cz:dkim];
 DMARC_POLICY_ALLOW(-0.50)[nic.cz,reject];
 R_SPF_ALLOW(-0.20)[+ip6:2001:1488::/29:c];
 R_DKIM_ALLOW(-0.20)[nic.cz:s=default];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[lists.denx.de,ni.com,gmail.com,gateworks.com,nic.cz];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; DKIM_TRACE(0.00)[nic.cz:+];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ]
X-Rspamd-Server: mail
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Queue-Id: C0B9F1C1496
X-Mailman-Approved-At: Wed, 22 Nov 2023 16:21:19 +0100
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

Driver does not currently initialize the smi_addr field, but instead keeps
the default value. This leads to issues on systems with different hardware
configuration. We can fix this problem by reading the SMI address from
device tree.

Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 drivers/net/mv88e6xxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
index c073f81e72..4636dbf156 100644
--- a/drivers/net/mv88e6xxx.c
+++ b/drivers/net/mv88e6xxx.c
@@ -753,6 +753,12 @@ static int mv88e6xxx_probe(struct udevice *dev)
 		return -ENODEV;
 	}
 
+	priv->smi_addr = dev_read_addr(dev);
+	if (priv->smi_addr == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Invalid or missing SMI address\n");
+		return -EINVAL;
+	}
+
 	/* probe internal mdio bus */
 	ret = mv88e6xxx_probe_mdio(dev);
 	if (ret)
-- 
2.42.1

