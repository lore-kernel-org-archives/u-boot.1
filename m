Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915EF1090236
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0571C83EEF;
	Thu, 19 Mar 2026 15:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J8IJnAez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6822183F2D; Thu, 19 Mar 2026 15:54:30 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C720D83CF3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-467161c4b89so480351b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773932065; x=1774536865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MgpDNUHgk6bP2mWiIi3ysjr+1oDwvNYlYXyT7bDnvsM=;
 b=J8IJnAez3Gw0Ye5bO+aVXDa7yiIAimw9gryno5FP1KMsHuHz+ZucMajhm8RvBhVHpr
 Zpi+6cfx7g6En9HE1H+qO72r2VK3MMmebfqBB0irwGMilqmGvHTi91FsTQ7cEdu9iqFE
 EB5LOG7iZo2Np/4mbXz/9+9V9evq0uSh68TqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773932065; x=1774536865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgpDNUHgk6bP2mWiIi3ysjr+1oDwvNYlYXyT7bDnvsM=;
 b=ryq2pi28e8hVZ3FtQIpa1QIigDrdK3Vm2yXKZdaDmyrb2xshN+B4DUSssrUA8E2lFj
 tn6EWBipq+Tv+x9erjJ931l+bNrzWPQ1bj0MO9S6O+akFrbbHI54IrTosiDpDSZVEW2F
 w/l919IlY8UouBhLp0hS+POPvZQ1mncdkHdecLupidjoVt2bMkjmXW+wuqKnW7LGtI2X
 RU64919cUSqwrP28iaAzuCzvb6YJvATtGSldItnwHvqj6LBgplh/zj1sIddIrTGdKCHd
 x9JC32hP4NQfvsNk9BzkHjRsmkj30+rAEJIfpFgyRQ4T0rAXRyMyXrxJzT6+Q/lLzunZ
 szpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0JpjnbtBWg5F3VzWCIZbrRDCu4/6mxu4cLqCOz+L94zm2D8zcDzqv87fupGtXszBK5w4j1UE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyjh3toFhRHgM0sjYrRYIudUcMvfCrBLAYF3m1OQxexVKyauLbS
 jUuXMmsVc3FKg+89la8p6Z5ujU65ExAxnP3aASptN8dcv5Qo4ESBHmGiqoCSSglDpLY=
X-Gm-Gg: ATEYQzwopijLK/xAawHkEtIhtkf73yJMJ6utBXefO/UkEJB0i/yoM+XFNBMajjOksLe
 uKArUWgK3IMmywNrmWQuuJpQs/CA+VDBqoCq15AZBoEtu0+5iP/kJc7iTJ8wQDZIUm6OIWJg12j
 R9N784E9HXPnbrWFqCSPUBXDALpub23evBPfRkbyqvycZRT21KmFNLtqi6Q4uLaR0oBIIHpbMtI
 5SBfqXjOJk0qHoibSMELHJ0XfvqkQfh9IK5McIn3vFzYi6Jk9tj6a+XQyJxTVA8BwvFiDrp62qX
 iUkkALHPYAz23mGlpQS6xB0ZXiiGa9kELBziaiABgQgqc40JaDINaNmkiiiCxmIKzulhR/MfJu+
 ZwkkzmeYfKFnK7JCYoFrmxOE1tlElxlAt8bDXIyAyYHgym1MDBLFai/+s/+9vHNO/ebv4V3xxqE
 s/Jnqud2N3hqqDQqpFVNtE4ZdKOmJad5ENXpobKde6nEBuOm9cCm9qeV8yNdQ1Ta/BAGs313woW
 LX1ST0Pgty0mkpV3J0jJbgYXgWi+6npXQW78wejpQzHU0j46YnxVWtiTx4=
X-Received: by 2002:a05:6808:144b:b0:45e:84e7:c20b with SMTP id
 5614622812f47-467ba1e6ed0mr4843979b6e.25.1773932065241; 
 Thu, 19 Mar 2026 07:54:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2c2d51esm6193633fac.11.2026.03.19.07.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:54:23 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:54:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, Ashish Kumar <Ashish.kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: ls1021atsn: enable serial driver
Message-ID: <20260319145421.GT502704@bill-the-cat>
References: <20260318142949.2479033-1-mwalle@kernel.org>
 <20260318142949.2479033-3-mwalle@kernel.org>
 <20260319141919.7i4lvuivexnek2ni@skbuf>
 <20260319142505.GS502704@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZVqGx3L/FtOQ3sG9"
Content-Disposition: inline
In-Reply-To: <20260319142505.GS502704@bill-the-cat>
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


--ZVqGx3L/FtOQ3sG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 08:25:05AM -0600, Tom Rini wrote:
> On Thu, Mar 19, 2026 at 04:19:19PM +0200, Vladimir Oltean wrote:
> > On Wed, Mar 18, 2026 at 03:29:16PM +0100, Michael Walle wrote:
> > > Switching to DM_SERIAL disabled any serial driver. Re-enable it again.
> > >=20
> > > Fixes: 191b10ac70d7 ("PowerPC / Layerscape: Finish migration to DM_SE=
RIAL")
> > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > > ---
> > >  configs/ls1021atsn_qspi_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_q=
spi_defconfig
> > > index e36d336d84b..37629d88c48 100644
> > > --- a/configs/ls1021atsn_qspi_defconfig
> > > +++ b/configs/ls1021atsn_qspi_defconfig
> > > @@ -68,6 +68,7 @@ CONFIG_TSEC_ENET=3Dy
> > >  CONFIG_NVME_PCI=3Dy
> > >  CONFIG_PCIE_LAYERSCAPE_RC=3Dy
> > >  CONFIG_DM_SERIAL=3Dy
> > > +CONFIG_SYS_NS16550=3Dy
> > >  CONFIG_SPI=3Dy
> > >  CONFIG_DM_SPI=3Dy
> > >  CONFIG_FSL_DSPI=3Dy
> > > --=20
> > > 2.47.3
> > >=20
> >=20
> > Ok, in ls1021atsn_sdcard_defconfig it is selected by
> > CONFIG_SPL_SYS_NS16550_SERIAL=3Dy. In ls1021atsn_qspi_defconfig it isn't
> > selected.
> >=20
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>=20
> And the ls1021atsn_qspi_defconfig example isn't great, ugh. There's
> certainly other platforms I didn't migrate correctly in that commit,
> I'll go take a look now.

It's 39 platforms and I'm running a patch through CI now to make sure
everything builds still with them enabled.

--=20
Tom

--ZVqGx3L/FtOQ3sG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabwOGQAKCRAr4qD1Cr/k
ChT/AQDbBOrseBoOoacdgINZW4TQU/TjUtacmvUlqb35rrzFEwD/SroZG8VYOo8F
z534cu+uiR4+7WepU882TpCba+8h+QE=
=suPu
-----END PGP SIGNATURE-----

--ZVqGx3L/FtOQ3sG9--
