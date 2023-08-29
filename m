Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A2C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 15:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A29F86508;
	Tue, 29 Aug 2023 17:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HqrNu9cF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A28A86508; Tue, 29 Aug 2023 17:15:19 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC44B86517
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 17:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5921a962adfso52019167b3.1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693322114; x=1693926914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kpkMXQ433iGB70oVIvaM+xAKbbn90q6W1wkWJ3MpJVs=;
 b=HqrNu9cFtC2rdTi59SCHGpBlE9yIzUgW98pJy8ABuo5pojbK3w1JXtQUTQf2Eq0Fcw
 H56WvsHeGm8SCt3I+4dluEgZHRqNo8m0uO6zBiDTpMvjZPKAaaPlunJjj/ZeJu9or11A
 IIcvucKI32f6InNjDEsvXZ0gbyoEq36ebjQ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693322114; x=1693926914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpkMXQ433iGB70oVIvaM+xAKbbn90q6W1wkWJ3MpJVs=;
 b=YgNfJB1j/oeJMcT59DnQ1KM2meCFu0JA7pyyydg0zIt/5l6ixUKYn51rbBHXPnBVuA
 fxI80/bUcm9GLMBARIBD7pUkA1knXaO6VcDpbIvZdaCdLurl0oE3DSYP4DAFeHLEH4nf
 kOOA2rAOUlntymLWw1hLeB9Sl9DZIk8lBv5tdBPM5lo5wnsK/pVuj/03BlaBgrc/SMRt
 iLn6D29KYeYrQYoD3smTB3PqyYhZcNtPXiQIkmtnzWC+Ib5yDyAV2r4NBcxT6die0GaE
 LqI811CsbmBOnvZSAy7iviiEKCJjHPfUNnHHcOE6LiMaxcEb5arB8r47DwsR4lvgH5pF
 SOAQ==
X-Gm-Message-State: AOJu0YzWUP5KmxrNu9vPf+yEFE8dkK7YeO4xFk1s9xkntA6bDIvW1Y0E
 /Di/ngN+zIqnpTozwR535PaBiA==
X-Google-Smtp-Source: AGHT+IHiTQa6E687u8jBcD775gosmfKX1PY7YvXgHX70t+wlxI8sP8446A/kL34iVsJLJpr2+Xo4Qg==
X-Received: by 2002:a0d:c947:0:b0:589:fcb2:d57f with SMTP id
 l68-20020a0dc947000000b00589fcb2d57fmr30814430ywd.37.1693322114375; 
 Tue, 29 Aug 2023 08:15:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a815216000000b005837b48d16csm2786938ywb.84.2023.08.29.08.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:15:14 -0700 (PDT)
Date: Tue, 29 Aug 2023 11:15:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, u-boot@lists.denx.de,
 lukma@denx.de, seanga2@gmail.com, git@amd.com
Subject: Re: [PATCH] clk: Dont return error when assigned-clocks is empty or
 missing
Message-ID: <20230829151511.GE3953269@bill-the-cat>
References: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
 <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
 <20230825143959.GH3953269@bill-the-cat>
 <3d815d7d-a091-6f58-9d3d-c65e9eac8f41@amd.com>
 <20230828155009.GG3953269@bill-the-cat>
 <572b8fb7-32c2-3364-a3dd-baee48b9330a@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VirkEIAIT9jyNaqz"
Content-Disposition: inline
In-Reply-To: <572b8fb7-32c2-3364-a3dd-baee48b9330a@amd.com>
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


--VirkEIAIT9jyNaqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 09:18:53AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/28/23 17:50, Tom Rini wrote:
> > On Mon, Aug 28, 2023 at 12:25:30PM +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 8/25/23 16:39, Tom Rini wrote:
> > > > On Fri, Aug 25, 2023 at 09:15:09AM +0200, Michal Simek wrote:
> > > > > Hi Tom,
> > > > >=20
> > > > > On 7/11/23 11:51, Ashok Reddy Soma wrote:
> > > > > > There is a chance that assigned-clock-rates is given and assign=
ed-clocks
> > > > > > could be empty. Dont return error in that case, because the pro=
be of the
> > > > > > corresponding driver will not be called at all if this fails.
> > > > > > Better to continue to look for it and return 0.
> > > > > >=20
> > > > > > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > > > > ---
> > > > > >=20
> > > > > >     drivers/clk/clk-uclass.c | 8 +++++++-
> > > > > >     1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > > > > > index dc3e9d6a26..f186fcbcdb 100644
> > > > > > --- a/drivers/clk/clk-uclass.c
> > > > > > +++ b/drivers/clk/clk-uclass.c
> > > > > > @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct ud=
evice *dev,
> > > > > >     			dev_dbg(dev,
> > > > > >     				"could not get assigned clock %d (err =3D %d)\n",
> > > > > >     				index, ret);
> > > > > > -			continue;
> > > > > > +			/* Skip if it is empty */
> > > > > > +			if (ret =3D=3D -ENOENT) {
> > > > > > +				ret =3D 0;
> > > > > > +				continue;
> > > > > > +			}
> > > > > > +
> > > > > > +			return ret;
> > > > > >     		}
> > > > > >     		/* This is clk provider device trying to program itself
> > > > >=20
> > > > > What's your take on this one?  I didn't get reply from Sean.
> > > >=20
> > > > I guess, what's the validated upstream dts where this is the case?
> > > >=20
> > >=20
> > > It was found by incorrect DT. It means I don't think there is any DT =
which
> > > contains this issue.
> > > But that being said we can extend current clock tests to cover this c=
ase.
> > > Please look below.
> >=20
> > Well, if the DT is invalid (and yes, we can't easily run the validation
> > suite in U-Boot today), I'd rather go with a debug we can optimize out
> > so that the next person with an invalid DT can more quickly find their
> > problem and we don't work-around it instead.  Or am I missing something?
>=20
> There is already dev_dbg print above. It means when user enable DEBUG it
> gets information about it.
>=20
> The thing is that it just sync behavior with the linux kernel.
> You can look at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clk/clk-conf.c?h=3Dv6.5#n90
>=20
> There is also one more example like this.
> 	clk-test4 {
> 		compatible =3D "sandbox,clk-test";
> 		assigned-clock-rates =3D <654>, <321>;
> 		assigned-clocks =3D <&clk_sandbox 1>;
> 	};
>=20
> But if you prefer to fail in all these cases I am also fine with it.

Ah, OK.  Yes, I guess matching the kernel here is a good idea then.  And
yes, updating the tests next.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--VirkEIAIT9jyNaqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTuC3wACgkQFHw5/5Y0
tyxrnwwAp6Ek4kaKMoFBsdMsLttkooyhVNb30yk3eVkfeAlhltcNfabR8G0xucfu
LNSnhTHqKLLiB9Ob889eurSb9W8m8o4/vbjNI7DHKt5wspkrWy2MH+Ufu9o2O191
5vugENaait8QAuJN9n4Em3X7nVVBp5qooB0qoaFC85cQDfgaEQAWpQQP4vslrnyd
hKRCIYMsuyE4+KyUGvYY6azD6XU0ix/zolpP0kv9Xa6DO2qFTnZHlxmfryh7Epwe
qfTHWHlH8pmPmcY1CY267jEeUUUQRH+oXToBtrTjRSjBQhgrW4N/9XEMfohnyVPi
1E4vEhhcEbuDlngKEdeqMRbmfj+oYS9a2z252qFSPXjMz9xBIh4i5r7vxfnvtM0q
nIBmSxvJAd37CA9a2uiFFZ1VzeWs4csRP3vDUjORuWV6HCput0IGuAeTtpf66Z66
8g9sxg050Y1n8KL+QoWKKxMy+YdfKvFBcPRVwS6yWZtDvKiRqKOchoon1jpmY8l/
3yFIF1Rx
=M1Dv
-----END PGP SIGNATURE-----

--VirkEIAIT9jyNaqz--
