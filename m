Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D96C77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DAF80E9A;
	Wed,  2 Jul 2025 15:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ckqf4XqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00F681FEE; Wed,  2 Jul 2025 15:44:55 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7359D800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40ba3c10b3bso74275b6e.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751463892; x=1752068692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjCiYMjiRh59tq0JIFd9x39WtBDBWaIkLDMIY1besKI=;
 b=Ckqf4XqQc2Ga15RYNXHr6LxDd25rZkEf1HuQ72miOmc4i95SPQ0AwUpdbkEI5Jbr3F
 24lmI/nYiIfoOzAr79d0owZJsqMi9jw7q+6VwCnKEPGBSErNhgtkvjnycjvoR1r4ivah
 56lrJfShNehnhmDEefbaxfKGHMXK1fCrtX7BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463892; x=1752068692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjCiYMjiRh59tq0JIFd9x39WtBDBWaIkLDMIY1besKI=;
 b=sogXZhgOZ7Wbbq5qjQOZ125PUDSgltgoSqExRmakwOXYmf4NdywTUMKegMEFO3KM0g
 kIBSpp8mIHH5GCmssX73k+FSAgvGju2x9FgWPtnndwPIzb9gtprR+ThsEwZ89DVL15+m
 2HNch26iM9ZBC0/WcjE4UAN3E2+Ip8v4CpvyGHTBSrcfDGaF4qbarbAANVxcGjO+Dnw8
 0zGh9So0vfPQTSzGWfHcBOrYftnwLyn1uUgLwOSkvCoihq9gieAMLBNlnYt2pT0t9uQf
 QKQYmAQRGLsmNs1vntSCBlIu4WBP1RL0CvhnKbYAOoyxP1QBKZifCD2ciUITo6VZXiGF
 b7Bw==
X-Gm-Message-State: AOJu0YwwPLXtTZjg2wpppEaq4KvHXZeBiqoKpZRzQezoD9GgVTmPZfM7
 hQOclCmpgP/iGV4g19UjkyUVloxg4scAqwMEo4pfq7dSXH+SMP33/3FRvpm+7jHQmy78o7cemiz
 +dMdrEvQ=
X-Gm-Gg: ASbGncv7d6dCbAEkel5Kd3VgEmnEsgNBfGfeTnbKtlu4Alpw/Hfqw9pNsaaMONgUw4s
 31+iVdWoExF9F/xBJa4YSmNogCtBz9nBAD9PFwCFhE9zTYv+1hXXpmDnXywXXmBzjqqjH1WXlma
 QaX/0Ozt1Z3n8Mz/8OHUYkEMT1tzwf8b4qgFKDyxR8PL25ddroL1SajnLKb4jt6jEgCy8Q+I3aO
 ob3G3AjeMBevbupAt0ciMyXqsgIFDb3DgPi5tpEwF2S4QwMpBqnIWuXRLh9b5y3TX/tdj+3Zp7A
 4OYJm2QwxGlctF/FpNG/F4wj5wLBHYzc2nL96B1fl6sbF5I36nWdaOEt1nHoRO5yLK1tGEgCOwb
 6aRrHOBjoz5I3cqyiQRXK
X-Google-Smtp-Source: AGHT+IE7yLB2WNS/MtyKaobSu4ERwkaHi+fGrjYbqelVNUoVbtp1B1Hbby3Xs0KNN2ZPfFi2sE+BIg==
X-Received: by 2002:a05:6808:1a19:b0:401:e69a:8af2 with SMTP id
 5614622812f47-40b88540dc9mr1884522b6e.5.1751463892088; 
 Wed, 02 Jul 2025 06:44:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324054a2sm2570199b6e.31.2025.07.02.06.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:44:51 -0700 (PDT)
Date: Wed, 2 Jul 2025 07:44:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] boot: menu: Do not dereference pointer if pointer is NULL
Message-ID: <20250702134449.GA6424@bill-the-cat>
References: <20250630-scene_menu_fix-v1-1-9ccb9a49c4d8@linaro.org>
 <20250701204042.GD523899@bill-the-cat>
 <bc0d6906-c1a0-457d-900a-769f5186723c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y6wW32y7SFVaktSP"
Content-Disposition: inline
In-Reply-To: <bc0d6906-c1a0-457d-900a-769f5186723c@linaro.org>
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


--y6wW32y7SFVaktSP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 10:18:19AM +0100, Andrew Goodbody wrote:
> On 01/07/2025 21:40, Tom Rini wrote:
> > On Mon, Jun 30, 2025 at 05:06:07PM +0100, Andrew Goodbody wrote:
> >=20
> > > scene_obj_find can return NULL but this is not checked for before
> > > the return is dereferenced. Add a NULL check.
> > >=20
> > > This issue was found by Smatch.
> > >=20
> > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > ---
> > >   boot/scene_menu.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/boot/scene_menu.c b/boot/scene_menu.c
> > > index 17150af145d..9a6e37d1c64 100644
> > > --- a/boot/scene_menu.c
> > > +++ b/boot/scene_menu.c
> > > @@ -508,7 +508,8 @@ int scene_menu_display(struct scene_obj_menu *men=
u)
> > >   		return 0;
> > >   	pointer =3D scene_obj_find(scn, menu->pointer_id, SCENEOBJT_TEXT);
> > > -	pstr =3D expo_get_str(scn->expo, pointer->str_id);
> > > +	if (pointer)
> > > +		pstr =3D expo_get_str(scn->expo, pointer->str_id);
> > >   	list_for_each_entry(item, &menu->item_head, sibling) {
> > >   		struct scene_obj_txt *key =3D NULL, *label =3D NULL;
> >=20
> > This is in a slightly different place in -next, and I think the whole
> > function needs to be read and corrected for error handling. I think we
> > then will need to initialize pstr to NULL as well. Thanks.
>=20
> Hi Tom,
>=20
> I will rebase to -next and resend. I also added a NULL check for str but I
> am not sure what else might need doing though unless you have some
> suggestions?
> It looks to me as though pstr is not used if pointer is NULL so there sho=
uld
> be no need to initialise it?

Ah, I had to re-read the code again. We check for pointer before
dereferencing pstr at the end of the list_for_each_entry. Sorry for the
noise.

--=20
Tom

--y6wW32y7SFVaktSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhlN84ACgkQFHw5/5Y0
tyw2fwwAjl+h8cRKa+DJcul2aYn3dLtkHWPBxw5kjXD1oMVy1K5+/KfWdxS8yJWe
6eNt+Atk69Q12+NUQe2OSCd5L9bICy7Bj14bek/5aS2CwwH3j50GLNyZG+JxDAFQ
NK/dY1DxGf19OhgE8DfFdNM/uQtKwt4Cafdk6vCc5WTANQoacfqz8SLDaEWHAy7o
r1gxwRRlJ+xZjj6/9m4kBQZQJkDlZFMQQuLQOOVyHa8X2mO161Ia1fmGE55YX0Cn
p3FwWX8KULMGDOzdOA7IbIlnRHbsiyoHA0q1M8W3tq722/mCRy9RIVUIkRPVnSls
w5NVvlqlAWY9NGw4hBMrSjVwrXbb37dXF17F/8/m6I1Zx6m2RbZskTShfR3UqHxB
m66wxfFM5770gKuX7bqet/EbFYAzPRsImCcy6pGfuFLlhLOrj8eTR1uSfH9l3gw5
pxRe3hx9op2BiZPqoFs8lym2NFrgNZhy/0d3jt364GaFfPJFC4tAnkcHVgidEhe3
kR37I08R
=DtmD
-----END PGP SIGNATURE-----

--y6wW32y7SFVaktSP--
