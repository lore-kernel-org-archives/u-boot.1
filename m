Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D858ECE7B13
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C51C84114;
	Fri, 14 Nov 2025 15:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fpXqfEKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A41284118; Fri, 14 Nov 2025 15:36:15 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671A983F54
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-656e585587bso441697eaf.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763130972; x=1763735772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TG/GK95ZLXnHkTghJKPf7Yfzg5BES1naTm/erF5eV08=;
 b=fpXqfEKMdBgDchfT7VYVmxca3sEBcH2oCt8I0ZHQY0RcwQIYewrlANNNZHHZZR5bAt
 ONle3IJzRtJwRk/E0F0cAhWKihDtpGtzZEFiJARANPqqhlOXSwoWniX/wbmEDmfOcxpQ
 hIzdNtLL19262rECOOWmc4AWO8jkFirDgpPKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130972; x=1763735772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG/GK95ZLXnHkTghJKPf7Yfzg5BES1naTm/erF5eV08=;
 b=qDsH8VGsTNHgmZcua42YKcofn4iidfQbSBIb5ougaNVbsQfR/w/isNVZ4MVMlmJmXE
 T/6iCQ4TjN2XoSWqm2bX5tRxTG19XR8aUvcXQtulzPHKhMsv+vHoDzFsXRcPmgLaGtJt
 s2M0AWpJ2oYgoro8YKdmRd3dFVuHBNIpSKiI5XheH7baHMLCipOnM5xZUYjUYkz0JPdh
 BPZqiPywYuorN/xQCsAV6lDOl5CFbEFEvBoc80zMmZdslW9yz/ky/+7MZw03MY1MswoD
 RqQluwksSFT3i/3Uw1R48+oItXhXjvtJ8BtRMu3zozkiIuwUoByjUVhfq3UK1UVsH4LP
 5M3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFHzVSwtwwDL4Dwqs3yXyo0bS89Iwa6KHP+F9pCoGAhNVp4Ji4qUT4djSVY82EBXGrHZxxJR0=@lists.denx.de
X-Gm-Message-State: AOJu0YyCI3SF5X7EWor7CLBgadOtxxxy/Fv68GpkRKdnrZTaVNfKNWMM
 EAM47jdhQmVj4KsVjHA5hVs/DwVKBcBE2BMZbpMUhsHTScBiXJ/wlgx5/fhltSPmCyk=
X-Gm-Gg: ASbGncuBOscikXezfgofr3YmmXP2fcGxp9sKhZkRhqSiXVm8GEDBw/ZVceGAZVBIUbq
 g6vGJkRsyG1R702k8EuPElRgnMJVTUJt0yJPe+xv8G9+1COub0RLMdQpGvDmDFgqq2cKCynl0cK
 CvBYVHwWvD+3ilyZQYVZahSbdR3kqK0C09XMYH6eF+ZR5trD9ySQJPf3l+Ni/wKzx6ddjS2JK7E
 1HQrq8Nb786vWWV6VPI1/unEthsUFWzABuXM4kiRJEZdlXciBneCHcB3ZwTEyHLX7fkr9S9iPJk
 0LXBKspUYTWgIq/4dz6+t0tFn89xnRlHCYkBllcrL7DZbWljXBPyzpzQSZJ9gy9h5BY40GcaOu0
 rh9Ulv0QUlLsBKAcFW1RIhqGVBsnPIZNvrWImsKDhmlEtrNXUorbrv8xYwzXa/yUpoVQLkTbSQj
 4DxCFKxO5OvE45UU/ZbAj+Rad4ucmqA0gjM6PLJTeu4cT4fl3t8g==
X-Google-Smtp-Source: AGHT+IHwxvqWFEjBLHGmjyKNuzzIFrqbtvJYMIdZYjZX6C6YesmKokjhIGOMdO5yr670iFJxt29qKQ==
X-Received: by 2002:a05:6871:bb0d:b0:3d3:9857:57f6 with SMTP id
 586e51a60fabf-3e869186c03mr1419565fac.43.1763130972127; 
 Fri, 14 Nov 2025 06:36:12 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522ae6e2sm2724192fac.16.2025.11.14.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:36:11 -0800 (PST)
Date: Fri, 14 Nov 2025 08:36:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
Message-ID: <20251114143609.GZ6688@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
 <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
 <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
 <fd30d6ca-fdfe-4096-8057-a952a6a4bb7e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2X/+qqlxOCBgn6xK"
Content-Disposition: inline
In-Reply-To: <fd30d6ca-fdfe-4096-8057-a952a6a4bb7e@mailbox.org>
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


--2X/+qqlxOCBgn6xK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 06:17:27AM +0100, Marek Vasut wrote:
> On 11/13/25 11:46 PM, Simon Glass wrote:
>=20
> Hello Simon,
>=20
> > > > > diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> > > > > index 071d998a0a5..55c2b3a10bb 100644
> > > > > --- a/drivers/core/ofnode.c
> > > > > +++ b/drivers/core/ofnode.c
> > > > > @@ -335,7 +335,7 @@ bool ofnode_name_eq_unit(ofnode node, const c=
har *name)
> > > > >    int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
> > > > >    {
> > > > >           const u8 *cell;
> > > > > -       int len;
> > > > > +       int len, off;
> > > > >=20
> > > > >           assert(ofnode_valid(node));
> > > > >           log_debug("%s: %s: ", __func__, propname);
> > > > > @@ -343,8 +343,13 @@ int ofnode_read_u8(ofnode node, const char *=
propname, u8 *outp)
> > > > >           if (ofnode_is_np(node))
> > > > >                   return of_read_u8(ofnode_to_np(node), propname,=
 outp);
> > > > >=20
> > > > > -       cell =3D fdt_getprop(gd->fdt_blob, ofnode_to_offset(node)=
, propname,
> > > > > -                          &len);
> > > > > +       off =3D ofnode_to_offset(node);
> > > > > +       if (off < 0) {
> > > > > +               log_debug("(not valid)\n");
> > > > > +               return -EINVAL;
> > > > > +       }
> > > >=20
> > > > Ugh this is really horrible, sorry :-)
> > > >=20
> > > > Better to put a wrapper around it than add all these checks, extra
> > > > code size, etc. Also in many cases the ofnode is known to be valid(=
TM)
> > > > so it might just be a waste.
> > >=20
> > > How would you propose the wrapper should look like ?
> > >=20
> > > Keep in mind, not everything is fdt_getprop( ... ofnode_to_offset() .=
=2E.)
> > > in this patch.
> >=20
> > I was thinking of
> >=20
> > my_fdt_getprop(fdt, node, propname, lenp)
> > {
> > if (node is not valid)
> >     return NULL;
> > return fdt_getprop();
> > }
>=20
> We would need a wrapper for almost every libfdt call, which isn't really
> better.
>=20
> > What does fdt_getprop() return when the offset is -1 ?
> If can_assume(VALID_DTB) , then crash on NULL pointer dereference .
> If not, I think FDT_END (premature end) or an error code.

How are we now getting in this state is a question. Are we being passed
an unaligned DT and trying to work around/with it?

--=20
Tom

--2X/+qqlxOCBgn6xK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc+WQAKCRAr4qD1Cr/k
CsEkAQC98PkSKMPIt87kgx8N2xnvv3u68m1aYHLZl1IY3cDe5QD/RqqsxOfVGgPE
iUAoiNSCdqs98K6OLR93ZIXIRdF9vgU=
=uqMC
-----END PGP SIGNATURE-----

--2X/+qqlxOCBgn6xK--
