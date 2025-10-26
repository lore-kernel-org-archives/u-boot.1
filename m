Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9882BCCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 17:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE21832AD;
	Sun, 26 Oct 2025 18:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jaJvyAwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D86F83623; Sun, 26 Oct 2025 18:55:34 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEEF82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 18:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-44dabf29d02so674487b6e.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761501330; x=1762106130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+GciuwmRV1/Up6+/J0bFvFnV8LpIr7jaRZL6ghvZNXY=;
 b=jaJvyAwN8OrSXPH0rLNAjBHMQbPFei9w6O7Feco8rjcfOJ24k+rjbZhBdBVNkTHSD7
 fHg9gPldPBG2XubB+7l4pd+sO3sB72HpyDbp9zfkl7nrXPbhFNeR1naJBNMSA71OeWuW
 kJ7+oirCoa7PrmVcgO6nwKhUo6y/oDKqnsW0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761501330; x=1762106130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GciuwmRV1/Up6+/J0bFvFnV8LpIr7jaRZL6ghvZNXY=;
 b=BnXyOdSxHAnrRGWpqSd76rrwM8FeHqXSZdnWD+KZBuvrzRQRcKwdSBr4udCJY/NC4y
 UX88/kYnhovcaWEB18gS4olyqeINJM2fkULOS8Tyb8MG4GEEfbKZyEDhixyO8ZdM6afk
 pwcKpSCi5J5jwz5Y+E1/9ieqCjtCzVrZ7qz7WWuwbv3XgCAtFrbl4BFo3udvf78KoP8W
 cMdDNeazM58mchTi2DjDVkNBow+biFrisX2HXxEMbaB/+l8fGhJaDLECjFbUJpCXJ+i+
 R0hootQ9XrkPDj6s2LiGZkyEDtkj4LPfYsVUWa7hfw4gr8lh96MdWTKzS9Nyc0zk5AGI
 /qjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJP4I8gdkNDoQ/2sUimJxQwEYUCBLvuOGei8NEoYUi5hFlGz252uXwK4uSmLUt5RRKsQKsAOk=@lists.denx.de
X-Gm-Message-State: AOJu0YyL14ihUHNmiE4Vr4258Nfut+04z8QCMx10MKBneA32cxNuX478
 iIsslD92hZKho9+hAN4R3v8ZSgEBPW55blybgJ3VtGVL+N9Y6tbx2di7KNozolYIHWc=
X-Gm-Gg: ASbGncsNBH3UsN3YXPUHfQhMSuiBxcoFyOkiWT0NXWAmLc8TlSqpqMPrNWm0kIPHNTW
 g21gq3ehkm/lHIGfJXK8eHj3wNjEu2rCefWKQksuT+nKxU5p/2IuMow6le9chJGHlLACpI6lNZf
 nTg1s1ZJ/ecUXdkPp6DwP+9o5arq84sVGMjsZTHFEJiTfiP+gavV9u7d0euEs/tbvmmZ5vl6+i6
 xiAfu9Gi9oRAvXl0bcN+ejoqaIYHbsv2qGAV0HBVLHsOU7ZjZABxNZ0YDM8X7cbMP05tomT6RAQ
 TSBNB7cm1h5jznCt7N1GphTYHQgLGwEWpE12IlXRNWo9jmy9uvQ2PwReSbOuutaCfj/QW2KUKpY
 9c2SOS1bbmspJFhNoHm0ca0HON7bq9pdOofWH3CpS9G6h9w+fdoQ3NrP69TE7BCAO0dZ6xX38RV
 EMtPjO5GDbEnto9RYZbHiWpS6kx6E8GmB7LeWZvGgkEv1Aa14PEA==
X-Google-Smtp-Source: AGHT+IGZgJfqmc0oOv4m/gHrNbegz4seTFmxhtj1Q4RCq1SerdKmSMs8yYU/oFjNhTZiTrlT9rL3CA==
X-Received: by 2002:a05:6808:3442:b0:44d:ad7e:3846 with SMTP id
 5614622812f47-44dad7e47d0mr1621261b6e.8.1761501330098; 
 Sun, 26 Oct 2025 10:55:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e2018dsm1258069b6e.1.2025.10.26.10.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 10:55:29 -0700 (PDT)
Date: Sun, 26 Oct 2025 11:55:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 gss_mtk_uboot_upstream@mediatek.com
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
Message-ID: <20251026175526.GX6688@bill-the-cat>
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
 <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org>
 <aJJGvQpoYUWWjwrB@collins> <20251026154314.GW6688@bill-the-cat>
 <e88eceb2-7292-4888-8fbc-8022cabceb41@mailbox.org>
 <aP5bJyRg-yq7PCqE@shepard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ug8+wCr7zCcO5eYP"
Content-Disposition: inline
In-Reply-To: <aP5bJyRg-yq7PCqE@shepard>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ug8+wCr7zCcO5eYP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 06:32:23PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Sun 26 Oct 25, 16:56, Marek Vasut wrote:
> > On 10/26/25 4:43 PM, Tom Rini wrote:
> > > On Tue, Aug 05, 2025 at 08:00:29PM +0200, Paul Kocialkowski wrote:
> > > > Hi,
> > > >=20
> > > > Le Mon 14 Oct 24, 10:43, Marek Vasut a =E9crit :
> > > > > On 10/14/24 9:06 AM, Sky Huang wrote:
> > > > > > From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> > > > > >=20
> > > > > > Remove unnecessary CL22 phy reset before ethernet phy driver
> > > > > > probe. Lots of ethernet phys requires driver to load firmware.
> > > > > > Before that, CL22 phy reset may lead to malfunction.
> > > > > >=20
> > > > > > Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> > > > > > ---
> > > > > >    drivers/net/phy/phy.c | 2 --
> > > > > >    1 file changed, 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > > > > > index 716a1d46111..e6fed8c41d7 100644
> > > > > > --- a/drivers/net/phy/phy.c
> > > > > > +++ b/drivers/net/phy/phy.c
> > > > > > @@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct =
mii_dev *bus, uint phy_mask)
> > > > > >    static void phy_connect_dev(struct phy_device *phydev, struc=
t udevice *dev,
> > > > > >    			    phy_interface_t interface)
> > > > > >    {
> > > > > > -	/* Soft Reset the PHY */
> > > > > > -	phy_reset(phydev);
> > > > > >    	if (phydev->dev && phydev->dev !=3D dev) {
> > > > > >    		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
> > > > > >    		       phydev->bus->name, phydev->addr,
> > > > >=20
> > > > > This needs clarification and likely has to be handled differently=
=2E Removing
> > > > > the reset would leave the PHY in potentially undefined state.
> > > > >=20
> > > > > Which PHY is affected by this ?
> > > >=20
> > > > Good hunch. I just bisected down to this commit as I had some issue=
s with my
> > > > Allwinner V3 board using the internal CL22 PHY. The symptom is that=
 the LEDS's
> > > > polarity was inverted. Network still seems to work (although not te=
sted beyond
> > > > ping).
> > > >=20
> > > > This change can have very significant consequences in general, whic=
h were not
> > > > explored at all in the commit. This may break many boards that do r=
ely on that
> > > > PHY reset, in various scenarios and for various reasons.
> > > >=20
> > > > I think it should be reverted as soon as possible to restore previo=
us behavior.
> > >=20
> > > I'm wondering if anyone has further comments here? If I do go and rev=
ert
> > > this what is then going to break on the MediaTek side for example?
> > Let's revert it, and if MTK stuff breaks, let's fix it properly then.
>=20
> Agreed, keeping it only saves one setup but sacrifices many others. This =
is
> definitely not right.
>=20
> An immediate solution to support Mediatek would be to add a config
> option (enabled by default) for the PHY reset. Or maybe this could be des=
cribed
> in the board file somehow (this is a policy decision so I don't think any
> approach based on device-tree would be relevant here).

OK, can you please post the revert and cc the MediaTek people,
explaining what you ran in to? Thanks!

--=20
Tom

--ug8+wCr7zCcO5eYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP5ghgAKCRAr4qD1Cr/k
Csw/AQD4PMo9+i87oMHXRrxNFq2b416WVd+ggXpAdTdK248jsQD/UbviqRLE53lk
xAkA7dCeyR27cwA+ZVUU9KuKLEy6YQI=
=0WE8
-----END PGP SIGNATURE-----

--ug8+wCr7zCcO5eYP--
