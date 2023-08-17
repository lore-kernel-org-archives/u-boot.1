Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F27C531DC
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D30D860AA;
	Thu, 17 Aug 2023 21:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="McQtsf2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1F686BCE; Thu, 17 Aug 2023 21:30:55 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2477D85F9F
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58d40c2debeso1769227b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692300652; x=1692905452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c+WVTRirh+AFYSBOlKe9qEXwsNjixV7Wt1GruAcUeeA=;
 b=McQtsf2bRuVoueaXgEh0byMRNtSDZI3FzAuZY4JCBpschlw24hfK65FcvsTc8c4ueO
 +5RJG+IUtC/Io0rtyGynY1Foc5zvz8ukpf2KO2O/8WNGpcUpup+Cdbb0fNvUJ7aUoNjH
 ReqWaW/o3EtM4pkvTQYagVr66I7agkCaDwrEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692300652; x=1692905452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+WVTRirh+AFYSBOlKe9qEXwsNjixV7Wt1GruAcUeeA=;
 b=XFF1JfaPIZkW9mu5dJd2JfBPNs5DHFHeuGrw0JsPyy9GNXpAdHM+3wJ21ofbTHfKcm
 2qhJINX6SDnp29c+082dfvfXZ61gwQd69MHpdiZ2qP6pu3zcFfUSWYrjVxrIv8K/t2T2
 wBfSP22QJkHSbWLWN2BKnvKAoCmMCe4RH0xUyOviDC8AiPm2Uoi4z6KfWuDSAPfeNZJY
 aMLVLpqhp4OD6mnO50yXfroqm78+027CzPJaIe/+xiM1DAvR81089rpet7O4moKTsDNd
 aQ5QRrW+KACI1cWLBxw/Iddc5J0oNXb/M5ABL96zoqc6bO4nJMqbbFBlgfTdXtAVAm5N
 nN4Q==
X-Gm-Message-State: AOJu0YzNYuQYXFWubY3AVRiQEkXg4V2GFsLSWtqnQEZ4oC5cgItIVglr
 XfA9L9WZhsws6THjfTQ2uOfIHg==
X-Google-Smtp-Source: AGHT+IHWPcaU4JEGnHNJHTltiDPb+TzgL2L4QwMiVK0RPmQ90QVu/SjUSRLpitTNOyvHRmyhEJ/8rQ==
X-Received: by 2002:a0d:fc05:0:b0:577:3c17:5b2c with SMTP id
 m5-20020a0dfc05000000b005773c175b2cmr380313ywf.27.1692300651862; 
 Thu, 17 Aug 2023 12:30:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a0de806000000b00586ba973bddsm59143ywe.110.2023.08.17.12.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:30:51 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:30:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Joseph Chen <chenjh@rock-chips.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] board: rockchip: rk35xx: Add device tree files to
 MAINTAINERS
Message-ID: <20230817193049.GU1515023@bill-the-cat>
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-3-jonas@kwiboo.se>
 <374a63d7-096a-e3a0-807b-c69112d8c46d@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BiRZY1EPEi/sQJ44"
Content-Disposition: inline
In-Reply-To: <374a63d7-096a-e3a0-807b-c69112d8c46d@theobroma-systems.com>
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


--BiRZY1EPEi/sQJ44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 10:46:14AM +0200, Quentin Schulz wrote:
> Hi Jonas,
>=20
> On 8/17/23 08:04, Jonas Karlman wrote:
> > Update MAINTAINERS files for RK3566/RK3568/RK3588 boards to include
> > related device tree files. Also replace space with tabs.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >   board/anbernic/rgxx3_rk3566/MAINTAINERS       |  3 ++
> >   .../neural-compute-module-6/MAINTAINERS       |  6 +++
> >   board/radxa/rock5a-rk3588s/MAINTAINERS        |  2 +
> >   board/radxa/rock5b-rk3588/MAINTAINERS         |  4 +-
> >   board/rockchip/evb_rk3568/MAINTAINERS         | 51 ++++++++++---------
> >   board/rockchip/evb_rk3588/MAINTAINERS         |  3 +-
> >   6 files changed, 43 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/board/anbernic/rgxx3_rk3566/MAINTAINERS b/board/anbernic/r=
gxx3_rk3566/MAINTAINERS
> > index 1c0d3fe7b5bf..6be16a47e8eb 100644
> > --- a/board/anbernic/rgxx3_rk3566/MAINTAINERS
> > +++ b/board/anbernic/rgxx3_rk3566/MAINTAINERS
> > @@ -4,3 +4,6 @@ S:	Maintained
> >   F:	board/anbernic/rgxx3_rk3566
> >   F:	include/configs/anbernic-rgxx3-rk3566.h
> >   F:	configs/anbernic-rgxx3_defconfig
> > +F:	arch/arm/dts/rk3566-anbernic-rgxx3.dts
> > +F:	arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
> > +F:	arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
>=20
> An easier way to deal with this is to use the "*" character since it's
> supported in MAINTAINERS file apparently (ag -Q "*" **/MAINTAINERS returns
> multiple matches in multiple files). So maybe replace it with something l=
ike
>=20
> F: arch/arm/dts/rk3566-anbernic-rgxx3*
>=20
> ?
>=20
> That way if the files eventually get split into multiple ones, get rename=
d,
> have one created (e.g. -u-boot.dtsi), they are all matched by that same
> line. Less maintenance here (and hopefully precise enough that we don't h=
ave
> false positives).
>=20
> Just a suggestion,

Using the "N:" syntax might be better-still, since you could do:
N: anbernic-rgxx3
And that covers anything with anbernic-rgxx3 in the name.

--=20
Tom

--BiRZY1EPEi/sQJ44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTedWkACgkQFHw5/5Y0
tyzQfgv/XbG2QmqHNiN+8jiQzTnM9EH4cKrytlXc7MlBSESFdFKKs3O1mfBHeT7i
qxId+sq6tCF+SuNVgOFCRfwbLHc0Bo5NAx0IkYU+0iZ5CR+Ogk2KmDx6C9JN4NUl
zgeUT10jedMNblcy7KZ17gQCSLIX1ER6o/IYal7mHMb1IN6OJh7YTj0E1uyPZo1y
AVxeR3F6qnnd8ya50AEIJ5VsJHGi+1vfoxc6R5epKzj3AKNcQUfp8gZybplVTRha
ZRPVsbIq3Z6cDW2bvsuwP9YIo5gLsrQzbiClsYI+aT46ZzIj+JOvqSAN3RdMT3zC
ddDraFLhXTXuRBCJoYyRloKCWK4KUm/pkA1GpXdKYCiKOEMPqm73rSnh2MPhtejN
kJbbI/cIlyZJaXytduXzMM7FoWiP7xdFoqXF7usP/N0VU/MNEJisGqnfmlXBRXoG
sM2tLNp6/hu2reVQFmiHO4Kapo9nlWXteB0zYiUSTolny/5BiI2AZWSY8lA/iptz
XewAzCLx
=NWTk
-----END PGP SIGNATURE-----

--BiRZY1EPEi/sQJ44--
