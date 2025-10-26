Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD9FCCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EAD83849;
	Sun, 26 Oct 2025 16:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lm93PwE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC0E82E34; Sun, 26 Oct 2025 16:43:21 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4AC83849
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-44d9bd21422so1289291b6e.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761493398; x=1762098198; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T4Bxt71Pn7Kx9lP8j4ikfH0RB7U84g4BVRC5dLpBTD8=;
 b=lm93PwE88dUJYlA205uA5nht2KZ7zV1DRGuwI/823qtKgoyvRyyIj0Y32RcSetQyuC
 p3AWLzSyjEjxcjmT8pJnT51HbQAg0UMV3yPHDEbp7F43wOOK+8JIAjemudLrY9vJnu6r
 kDz35FE7YWWyToGqh4u/DqPUi4B1zSuaLOZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761493398; x=1762098198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4Bxt71Pn7Kx9lP8j4ikfH0RB7U84g4BVRC5dLpBTD8=;
 b=BN1g1op52PBwacFe0hqyDLN9LFH6zFJ4M3esWHVLk8EMatGhJrkq3Fodw5eAhPGAIM
 zC/ZjndBZo9jgeUgUF7ohK3MKqp1AVqKcPLHRCD3D2eu/J47WeukD9wq4cBEDOpnqEMw
 eMTaZbMZdAxL6SReSFPG/QFmAJRXFPfYi3dLpVTaaZRVYxBtPoC8HOhGhlVNqfULofiS
 0mVHXFLioITEHQj9CkFZZIextYVP3rK1CcmtcdzOsN+DVoColTWQPwmju9KBf73oQ/1a
 gahufMdQCrDV5hm1SHMSl4DD62kwjkKXL7nuQQoaG58PXpD0cRMUs+A7uLuyBwuXmYHj
 nndA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb5HOtpJYNZCdmNRAb5sSSjdJLelnX9Cftfb4th5pOYogMbBkK9E9E91fmzafNpHKniDQrcTw=@lists.denx.de
X-Gm-Message-State: AOJu0YxGtlINwXOLwg45U8peJhlggPMI+ouWPa0Wn56Bm5H2gqhmWKYj
 PBJ7jwBQOXHFT2/imMunhziaS31WvNgqBfJyPz0sU8WSH2hSidCKg5OP1OM4l/c07h1xMKbz7vV
 rrmOu64Avow==
X-Gm-Gg: ASbGncsrMI9Z2bzYKrFrMrrmkkFTW8kEQCxVr4R5/nJZEuwEC4kzrBpndS6Y6BcD0hg
 liMyUVEfKE/lcHe+eHqxMKBZKdbXqKME0Hk9swMsei+d9ZMemELxisiL8cCIdscmy1AK8GyRBCt
 PM3Ox98T6BiU4fhDHYcoyBMoCyyHA4BDc0qqUuZ7M83RUPjHxbv6aUPdbTKWo6DnBmHxiNN/ffq
 dKG6Mb3McdjrT407N3OLMFZ/xoOXlWc6iUbmiqUNonsKAllQ6GryUzwWhn9gOLDO/qlwcT1j3CN
 Tv2m8pmhDDDYk+ee2zAfuTIMHyIfLFmPtaIvhxA2kanuIN/RdZcCxC2o0drQlYhS4sffP+b1lxL
 k4ejpiPFd57gymdcLuEYYEZ+9uc4ra+Y5prWs+Np0EEsoJ2V/3Y5i8Vqi4awQKY9r/cFMp5MknU
 ISDe4f2FoxjJBNc+RraAUTInb71LCjyMONNZhlt59/ux/WuM97IQ==
X-Google-Smtp-Source: AGHT+IHajztz1tRh4wZs46Lbi6t6c0Q9Kv8S79N8D6pVuN8vsYMjIf0xWS9RnZldTSykg7ggJ9+Onw==
X-Received: by 2002:a05:6808:3a0b:b0:44d:ab15:6af2 with SMTP id
 5614622812f47-44dab1577f5mr1927220b6e.21.1761493397806; 
 Sun, 26 Oct 2025 08:43:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e21d77sm1196034b6e.3.2025.10.26.08.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 08:43:16 -0700 (PDT)
Date: Sun, 26 Oct 2025 09:43:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul Kocialkowski <paulk@sys-base.io>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 gss_mtk_uboot_upstream@mediatek.com
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
Message-ID: <20251026154314.GW6688@bill-the-cat>
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
 <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org>
 <aJJGvQpoYUWWjwrB@collins>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GCC9oxLarXfDfDhX"
Content-Disposition: inline
In-Reply-To: <aJJGvQpoYUWWjwrB@collins>
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


--GCC9oxLarXfDfDhX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2025 at 08:00:29PM +0200, Paul Kocialkowski wrote:
> Hi,
>=20
> Le Mon 14 Oct 24, 10:43, Marek Vasut a =E9crit :
> > On 10/14/24 9:06 AM, Sky Huang wrote:
> > > From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> > >=20
> > > Remove unnecessary CL22 phy reset before ethernet phy driver
> > > probe. Lots of ethernet phys requires driver to load firmware.
> > > Before that, CL22 phy reset may lead to malfunction.
> > >=20
> > > Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> > > ---
> > >   drivers/net/phy/phy.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > > index 716a1d46111..e6fed8c41d7 100644
> > > --- a/drivers/net/phy/phy.c
> > > +++ b/drivers/net/phy/phy.c
> > > @@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct mii_de=
v *bus, uint phy_mask)
> > >   static void phy_connect_dev(struct phy_device *phydev, struct udevi=
ce *dev,
> > >   			    phy_interface_t interface)
> > >   {
> > > -	/* Soft Reset the PHY */
> > > -	phy_reset(phydev);
> > >   	if (phydev->dev && phydev->dev !=3D dev) {
> > >   		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
> > >   		       phydev->bus->name, phydev->addr,
> >=20
> > This needs clarification and likely has to be handled differently. Remo=
ving
> > the reset would leave the PHY in potentially undefined state.
> >=20
> > Which PHY is affected by this ?
>=20
> Good hunch. I just bisected down to this commit as I had some issues with=
 my
> Allwinner V3 board using the internal CL22 PHY. The symptom is that the L=
EDS's
> polarity was inverted. Network still seems to work (although not tested b=
eyond
> ping).
>=20
> This change can have very significant consequences in general, which were=
 not
> explored at all in the commit. This may break many boards that do rely on=
 that
> PHY reset, in various scenarios and for various reasons.
>=20
> I think it should be reverted as soon as possible to restore previous beh=
avior.

I'm wondering if anyone has further comments here? If I do go and revert
this what is then going to break on the MediaTek side for example?

--=20
Tom

--GCC9oxLarXfDfDhX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP5BkgAKCRAr4qD1Cr/k
CmbPAQCvrJMGRHzmc+xxRkgK8tVdRpBeuntydRGOIQHJSfHtZwEA77pu8XYDS/Wf
3jGmpplFHHNJ6ziWmrkQJeffgLksEgU=
=MvFd
-----END PGP SIGNATURE-----

--GCC9oxLarXfDfDhX--
