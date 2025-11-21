Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19069CFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68548394E;
	Fri, 21 Nov 2025 15:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NKPfk6F2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5977A83952; Fri, 21 Nov 2025 15:35:16 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF538393F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e0f19a38d0so1335938fac.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735713; x=1764340513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o5cVhYAEqmZl7VYMwC5kp0JxXJZJ2UV9IathljfeuwU=;
 b=NKPfk6F2woRyEbIngr4r764NCwL1YAQ48R9thBcKafGohudVInfhTIuS8wpk9Jcrin
 VDYLmRSJXL5f2qYvFnUaZwsSSXhkvtCtOgTZk1kwo9VZnTEgF5sUtV28SWvlysfnhR2+
 Go7zCIat0AoUMCThAGujDpwThhJYOSuvUbZgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735713; x=1764340513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5cVhYAEqmZl7VYMwC5kp0JxXJZJ2UV9IathljfeuwU=;
 b=HqumAZbMioXyUGSqZ154QNGY9eKBrdZ0GmI5Tv48VmOvaeJ/uWjaORTzLmvZUw/izz
 8ELglTAimy18TQHZ3FsgpK18vw9LnZrMajh1D9Mhvh0t7tZtiZtiujIWqL5pOJtbHvuN
 OaOeUUDo9gWHnghyhNs8UrXQIn9fOYTcKeDKEuWfv4ll1LEZh4pJrzmtYTEry39wIiyI
 bB9t/pTmEgd9hKjV1ne4fTMsw/lkZaOVJ4BQWoTH1ypY5aPICm0r92VTdcS1jr9IKmdr
 Cj8xpFwWe0wzoIQEsquh+OArCDwWvQt0N7FFcGyKdIH0Chb/prn9IuNL61X2/SMGOLBX
 L5GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUcOGoZka5/TE4PrZ/W/VYy1DnLA/YovxfS+rBjJMPJNbGZAX84u5DTcN6fI+SaJS7k69vhWY=@lists.denx.de
X-Gm-Message-State: AOJu0Yym2L3eWvr/oBezyIqJIL+Ygw11eVN1CNqiYRstoL1TfDjQqf91
 2QswZhNaWaO7EE12EMeZ5Qq3g+3FIALguA5S88Ane0HiUdW6aeQlqVcCOCE9wuqTCqs=
X-Gm-Gg: ASbGncsFZKuWhUeN4N07zkQ8p29KJyfm1Oxr1SG2ZLkjXUgMP5q3B15wP0otKKUTw2q
 y534mTxzI0lwuFETMgDeIK/dRmRC0rLL6HdysdxRvl/7ktIqUNhszGaI70TJY/HRkpS9n4cR0KT
 gjl4Lzm2p2HFqTDOEufvMRdMpux9TCe09yePZc39lSxQMvbFxmFMGNa2spEQJxSdwwutcZ6evjW
 lvEM3sqMEtuaCZRRcbgnICI3H9s9YY/6cUbHMy6FFyYLFRyZbsDMy0PFCoKAF3StQse+g+LKDF0
 MrgelKcPgsGjP5IuidPQG5fcoLXYtPe+P/jg4TUIikWEGrYerbxlg6hUkrMIND0TKOjDnZa6kOu
 XA6PIH5Oz/+ikI3qUtHE7uYiXFOf1yWsFo5GK5klu+nj20DPXLVwvzaJYWbp8wTIezpAnwIxcVA
 JEvoEDQERB4IC19O/sCQ4PHIKOCWzwmxJ+6nm/2MTVHXEA2e7h+A==
X-Google-Smtp-Source: AGHT+IFj/20vNnmIXIOCiugupvigNUhdToFruEc89n1lWAME9ooPk04lAJiwVjnaI5umHw5lxphoxg==
X-Received: by 2002:a05:6871:289c:b0:3e8:9b86:3c6b with SMTP id
 586e51a60fabf-3ecbe59b663mr1181751fac.44.1763735712774; 
 Fri, 21 Nov 2025 06:35:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c2d0e96sm2706133fac.2.2025.11.21.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:35:12 -0800 (PST)
Date: Fri, 21 Nov 2025 08:35:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-ID: <20251121143510.GX2125796@bill-the-cat>
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
 <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2T9LvvD/ybWLmRjL"
Content-Disposition: inline
In-Reply-To: <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
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


--2T9LvvD/ybWLmRjL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 07:25:46AM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Thu, 20 Nov 2025 at 21:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 11/21/25 12:40 AM, Simon Glass wrote:
> > > Hi Marek,
> > >
> > > On Wed, 19 Nov 2025 at 21:14, Marek Vasut
> > > <marek.vasut+renesas@mailbox.org> wrote:
> > >>
> > >> If CONFIG_OF_PLATDATA=3Dy , then the udevice has no valid OF node as=
sociated
> > >> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_defa=
ult()
> > >> call ultimately reaches ofnode_read_u32_index() which invokes fdt_ge=
tprop()
> > >> and passes result of ofnode_to_offset(node) as an offset parameter i=
nto it.
> > >>
> > >> The ofnode_to_offset(node) returns -1 for invalid node, which leads =
to an
> > >> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with =
SIGSEGV
> > >> because libfdt can not handle negative node offsets without full tre=
e check,
> > >> which U-Boot inhibits to keep size lower.
> > >>
> > >> Add dev_has_ofnode(dev) check and do not assign clock rate in case t=
he
> > >> device has no valid node associated with it, and do not call any of =
the
> > >> dev_read_*() functions for devices without valid nodes.
> > >>
> > >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >> ---
> > >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > >> Cc: Sean Anderson <seanga2@gmail.com>
> > >> Cc: Tom Rini <trini@konsulko.com>
> > >> Cc: u-boot@lists.denx.de
> > >> ---
> > >>   drivers/clk/clk_fixed_rate.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_ra=
te.c
> > >> index 95a77d2e041..5c32ae207fe 100644
> > >> --- a/drivers/clk/clk_fixed_rate.c
> > >> +++ b/drivers/clk/clk_fixed_rate.c
> > >> @@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice=
 *dev,
> > >>                                      struct clk_fixed_rate *plat)
> > >>   {
> > >>          struct clk *clk =3D &plat->clk;
> > >> -       if (CONFIG_IS_ENABLED(OF_REAL))
> > >> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
> > >>                  plat->fixed_rate =3D dev_read_u32_default(dev, "clo=
ck-frequency",
> > >>                                                          0);
> > >
> > > What is happening here? It should already be checking this:
> > >
> > > static inline __attribute_const__ bool dev_has_ofnode(const struct ud=
evice *dev)
> > > {
> > > #if CONFIG_IS_ENABLED(OF_REAL)
> > > return ofnode_valid(dev_ofnode(dev));
> > > #else
> > > return false;
> > > #endif
> > > }
> > I do not understand the question -- this patch _adds_ the
> > dev_has_ofnode() test into clk_fixed_rate_ofdata_to_plat_() , it wasn't
> > present before. Can you please rephrase your question / concern ?
>=20
> The dev_has_ofnode() function already checks OF_REAL, as shown above. To =
repeat:
>=20
> > > static inline __attribute_const__ bool dev_has_ofnode(const struct ud=
evice *dev)
> > > {
> > > #if CONFIG_IS_ENABLED(OF_REAL)
> > > return ofnode_valid(dev_ofnode(dev));
> > > #else
> > > return false;
>=20
>    ^^ returns false here
>=20
> > > #endif
>=20
> You are adding another check in the caller:
>=20
> > >> -       if (CONFIG_IS_ENABLED(OF_REAL))
> > >> +       if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
>=20
> dev_has_ofnode() will already return false if OF_REAL is not enabled.
> So what is the point of checking OF_REAL before calling
> dev_has_ofnode() ?
>=20
> I don't understand what benefit this patch brings.

I think the misunderstanding is that you're asking for this:
-       if (CONFIG_IS_ENABLED(OF_REAL))
+       if (dev_has_ofnode(dev))

To be made to clk_fixed_rate_ofdata_to_plat_(...) in
drivers/clk/clk_fixed_rate.c as it does not currently call
dev_has_ofnode(dev).

--=20
Tom

--2T9LvvD/ybWLmRjL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB4nQAKCRAr4qD1Cr/k
ClrbAP4h7f710YZKnMWWGlGlPEf5QHfojRgxoxXt9EuF69aN1AEA7JVxY/LI7UwE
ITXLEWWkJUWl7e5hvlFth5gblI8DogQ=
=LyQO
-----END PGP SIGNATURE-----

--2T9LvvD/ybWLmRjL--
