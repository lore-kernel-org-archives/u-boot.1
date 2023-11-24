Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D07C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 19:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101E1876BF;
	Fri, 24 Nov 2023 20:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DD28760E; Fri, 24 Nov 2023 14:04:12 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4184487616
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 14:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=username@gmail.com
Received: from marcharch (unknown [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPS id 1D9771C05AD;
 Fri, 24 Nov 2023 14:04:07 +0100 (CET)
Authentication-Results: mail.nic.cz; dkim=none;
 spf=softfail (mail.nic.cz: 2001:1488:fffe:6:592e:6672:3345:e2e0 is neither
 permitted nor denied by domain of username@gmail.com)
 smtp.mailfrom=username@gmail.com
Date: Fri, 24 Nov 2023 14:04:05 +0100
From: YOUR NAME <username@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 tharvey@gateworks.com, marek.behun@nic.cz
Subject: Re: [PATCH] net: mv88e6xxx: add missing SMI address init
Message-ID: <6aqzodk7o73kp4jghj6zr3hat67u623fx6mcyhtbtcxg6w5qvf@natlnympnzna>
References: <4t2ccomf4epfozf2o5uzkp7c5lzzqhgkfpcfofojomssmzh5kw@76ljhmdjzla4>
 <20231122163841.09d1c6e8@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122163841.09d1c6e8@wsk>
X-Spamd-Result: default: False [-0.10 / 20.00]; MIME_GOOD(-0.10)[text/plain];
 R_DKIM_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_FROM(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Queue-Id: 1D9771C05AD
X-Spamd-Bar: /
X-Mailman-Approved-At: Fri, 24 Nov 2023 20:59:31 +0100
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
initialization. But i may try preparing a new version for them in the
future.

Regards,
Marek
