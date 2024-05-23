Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9B6C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B3087FEE;
	Thu, 23 May 2024 19:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nyd81t24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8839E8811D; Thu, 23 May 2024 19:43:20 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5681A87E0D
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 19:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c99e6b8b1fso4159306b6e.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716486197; x=1717090997; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uh986r/vnTV8wafUBVOYOoRrnIkey7+bagnkhOZVeFs=;
 b=Nyd81t245ql9xJjfjQ3osPFxOAHBOW7BUY6TEFgyU9KdF+aaMuGtYud0i3pxiCwOnV
 dv5YQ4J+zi4yybmyfXSkZF2skhYn3cOgaQelbnd6BEJOxGXsQhmtQULVsGO1mAaK1/gS
 VYbefS9NaSS81/ZhwTweHBgcEgUyhIvdCvWNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486197; x=1717090997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uh986r/vnTV8wafUBVOYOoRrnIkey7+bagnkhOZVeFs=;
 b=lZU8nrkaQlduw9WWo+l1M9y00ApfTgYH4B0bHOwIZhqpMFL/qFzRbq+NpVhb861vM7
 DIrl/PO8qoi9hNu65NmAxvNqsTXOnXyOEV2+ZR7qrVgL7XCfMbs/vMvGS36iq1YEL8Xu
 2mRGiT8nBnlAw+fn8kl3hl+rwl6Gs35bPuuywU82so7KJH4gMuCK7rS4bl3NviGzooDz
 DPw5lkPXpSUfguCdI3dr1SBUC6EnJeNQyobnir1GLDmkmZjuZSgQrxwWsEDhqETiLFcM
 mXEcYVh+oM8Ki20g0neHj2JTHIMGZdIISvKIt4C4OaghHY+5yYs/9PiNieqv+L7b7zyV
 Bnfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgvhu/9FIC+iH6AQtI1LQijHfdyr1/fRfn6T5oWf6pwtUcbfjhdFf/YFojxC/QM54St+wIhwi3CRDpgdkmiQGOLUngvg==
X-Gm-Message-State: AOJu0Yx3PnCETzgOmHTqxEJR0QTGSLddQSrBcjIG+xu1yCIqLgHxvNUg
 Wq6adI0fU9/mXDSSsD1FKRYFHRve/etdd+e/V8Zo2WMCoTd3GUmiQJdfwG4gCPZdn3X0IwujNY2
 L
X-Google-Smtp-Source: AGHT+IGiiHTBE6OvWyuda7YuZBtv7oPQuaNlwd65QckoUrppPc0VobgbHw2pozIqVpdCPTu0NWFfew==
X-Received: by 2002:aca:1206:0:b0:3c8:533f:95a6 with SMTP id
 5614622812f47-3d1a774aca3mr41631b6e.53.1716486196919; 
 Thu, 23 May 2024 10:43:16 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7930325d5d0sm804760285a.75.2024.05.23.10.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:43:16 -0700 (PDT)
Date: Thu, 23 May 2024 11:43:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Andrew Davis <afd@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: mach-k3: am62p: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Message-ID: <20240523174313.GU2568172@bill-the-cat>
References: <20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com>
 <82b2503d-fda4-45fd-a576-2a5f3606587a@ti.com>
 <20240523171224.b3oi5hhngok7webk@bryanbrattlof.com>
 <20240523172256.4mciukajb5g2uizc@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JSGYUmzkK0Y7Xzco"
Content-Disposition: inline
In-Reply-To: <20240523172256.4mciukajb5g2uizc@bryanbrattlof.com>
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


--JSGYUmzkK0Y7Xzco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:22:56PM -0500, Bryan Brattlof wrote:
> On May 23, 2024 thus sayeth Bryan Brattlof:
> > On May 23, 2024 thus sayeth Andrew Davis:
> > > On 5/23/24 11:43 AM, Bryan Brattlof wrote:
> > > > The address we load TFA and OPTEE is configurable by the
> > > > CONFIG_K3_{ATF,OPTEE)_LOAD_ADDR, but the DT node reservations remain
> > > > static which can cause some confusion about where exactly these fir=
mware
> > > > are exactly. Fix this by updating the reserved-memory{} nodes when =
the
> > > > loaded address does not match the address in DT.
> > > >=20
> > > > Reported-by: Andrew Davis <afd@ti.com>
> > > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > > ---
> > > > Hello everyone,
> > > >=20
> > > > This is a little fixup to avoid any confusion once we're in the ker=
nel.
> > > > Because TF-A can be configured in U-Boot to be anywhere we want, we=
 need
> > > > up update the reserved-memory{} node with this change.
> > > >=20
> > > > Thanks for reviewing
> > > > ~Bryan
> > > > ---
> > > >   arch/arm/mach-k3/Makefile       |  1 +
> > > >   arch/arm/mach-k3/am62p5_fdt.c   | 16 ++++++++++++++++
> > >=20
> > > You'll want to rebase this on -next, these _fdt.c files all got moved
> > > into directories for each SoC.
> > >=20
> >=20
> > Ah! my bad, you're right this belongs in -next. v2 incoming momentarily
> >=20
>=20
> Wait no on second thought, this needs to be in v2024.07 also. I'll leave=
=20
> this for Tom for -master and maybe send out another version for -next to=
=20
> preempt the merge conflict for v2024.10?

If this needs to go in master then git should hopefully do the right
thing when I merge the next rc tag in.

--=20
Tom

--JSGYUmzkK0Y7Xzco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZPgC4ACgkQFHw5/5Y0
tyxn4Av/eWl2w5cjvAM4KeKubjXaGZthqir3OmXnoZrn91OObLlUtJmEIBEeXcRi
m8nOKOuWpYeNM8KwD47kVF4LberlXdGkc3KK8UscfEetpFDuTFLvy6RRvrJVLmtv
36ttDyEKeA2c/DNjsxSf0wJ6R+1VaV+pllLagH4IGa7xL3RrIoat+UqhQM/C0Nae
AXhPJdEuATStj0yxU0zObr1GkrxoyPxmWlPhQhH05QmW3e2hJjLqnk8uzI0LiEI3
FvgB1c5CQYAE1bleuiDf+hWyCdxmByNZ5fGydL5/tRtrxW5AoMgYcIRJEW3wpKqp
+FmzX+4AsGXzrYE+fXPpd81sTD8kKcghXMLIUqM5Pzkm1ZqyLEctoiVDzTSf/SDb
pa1QlkiPa1XHeckuYlN7vjBPqspUXxthiTwtNsFzGfWcw4oNZUq52kTkQL4nyE5Y
oK/oC1IcCOWPeGk4Q8D+yBaW1Gu3CAialgag3Kh9cXq+MyhFzqSDVQWL/friU1w/
KJXdypIq
=M8lX
-----END PGP SIGNATURE-----

--JSGYUmzkK0Y7Xzco--
