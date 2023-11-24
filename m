Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1ABC61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 13:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2460487164;
	Fri, 24 Nov 2023 14:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="liTglk6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0069E875F5; Fri, 24 Nov 2023 14:43:23 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A29387616
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 14:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch (unknown [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPS id 4DCFB1C181D;
 Fri, 24 Nov 2023 14:43:17 +0100 (CET)
Authentication-Results: mail.nic.cz;
 dkim=pass header.d=nic.cz header.s=default header.b=liTglk6A;
 spf=pass (mail.nic.cz: domain of marek.mojik@nic.cz designates
 2001:1488:fffe:6:592e:6672:3345:e2e0 as permitted sender)
 smtp.mailfrom=marek.mojik@nic.cz; 
 dmarc=pass (policy=reject) header.from=nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1700833397; bh=U/H+yzZwqi0fcwf/qZsQeM3ymGo0oobBgf4vs8C8CeY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Reply-To:
 Subject:To:Cc;
 b=liTglk6AydZHYjNrR5/h8dDhTRnwCDPiwun0eytkHcB2/VxHlw7VKIN5bBCBYaLu4
 LSmfUQHkYPfrXvLw+tDU1NW7Q2p4pgo1TsmN4Kf+zuFLbw5aePmJWuqsD8sBgx62/h
 dxHVyEcRBFLiUeQWIaIwWSpLBLgTSioJ6wVvDIaw=
Date: Fri, 24 Nov 2023 14:43:16 +0100
From: Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
To: Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 tharvey@gateworks.com, marek.behun@nic.cz
Subject: Re: [PATCH] net: mv88e6xxx: add missing SMI address init
Message-ID: <25ix2yb4s6tkydcl6ollfckxxklmybz6sgvyvpfacrcrxemqpn@4cjkqymjfmpe>
References: <4t2ccomf4epfozf2o5uzkp7c5lzzqhgkfpcfofojomssmzh5kw@76ljhmdjzla4>
 <20231122163841.09d1c6e8@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122163841.09d1c6e8@wsk>
X-Spamd-Result: default: False [-3.00 / 20.00];
 DWL_DNSWL_MED(-2.00)[nic.cz:dkim];
 DMARC_POLICY_ALLOW(-0.50)[nic.cz,reject];
 R_DKIM_ALLOW(-0.20)[nic.cz:s=default];
 R_SPF_ALLOW(-0.20)[+ip6:2001:1488::/29:c];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[nic.cz:+]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Queue-Id: 4DCFB1C181D
X-Spamd-Bar: ---
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

On Wed, Nov 22, 2023 at 04:38:41PM +0100, Lukasz Majewski wrote:
> Hi Marek,
> 
> > Driver does not currently initialize the smi_addr field, but instead
> > keeps the default value. This leads to issues on systems with
> > different hardware configuration. We can fix this problem by reading
> > the SMI address from device tree.
> > 
> > Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
> > ---
> >  drivers/net/mv88e6xxx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> > index c073f81e72..4636dbf156 100644
> > --- a/drivers/net/mv88e6xxx.c
> > +++ b/drivers/net/mv88e6xxx.c
> > @@ -753,6 +753,12 @@ static int mv88e6xxx_probe(struct udevice *dev)
> >  		return -ENODEV;
> >  	}
> >  
> > +	priv->smi_addr = dev_read_addr(dev);
> > +	if (priv->smi_addr == FDT_ADDR_T_NONE) {
> > +		dev_err(dev, "Invalid or missing SMI address\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* probe internal mdio bus */
> >  	ret = mv88e6xxx_probe_mdio(dev);
> >  	if (ret)
> 
> I've posted some time ago patches for this driver:
> 
> https://patchwork.ozlabs.org/project/uboot/cover/20230601100005.2216345-1-lukma@denx.de/
> 
> Unfortunately, those were not pulled...
> 
> Maybe you would find fix for your issue, or prepare new version of it?

I looked at your patches, but they don't fix the issue with smi_addr
initialization. But i may try preparing a new version for them in
future.

Regards,
Marek
