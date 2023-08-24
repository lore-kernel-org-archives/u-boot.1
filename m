Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0625C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D07A862EB;
	Thu, 24 Aug 2023 17:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dkp2yC3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DBD862EB; Thu, 24 Aug 2023 17:18:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6817D83F7B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so4897495a34.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890284; x=1693495084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YP8iWGFGcCSs+VSvKOg2/vP3cfPl9GrRJYkFh+pI3AI=;
 b=dkp2yC3B9O2uwN6rbiMgj+2Lo9TVOadYryXoolHd2/SXVmOMvZKR78frKPfTj1EKB1
 c76XUKGpKJ0SKvxy+2EElKVAhirW2rtMGRuH3ql/ttJW743nRixz5j6B3QE0bBt1wkuF
 6zduera22Rw/reeeyU2C9jT3N8jb5Y+FMH9Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890284; x=1693495084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP8iWGFGcCSs+VSvKOg2/vP3cfPl9GrRJYkFh+pI3AI=;
 b=fe4MRN9oNvohW5RtSL/RAnLqhGFZBOmr9W+XmPkZmLfYyd75OU8nCazvT7qSCSLEtq
 M+gu9FRhb3w9sbAt4KoiCNzebaMhyGSpCGkpMcFCCb8FT6B9rMzb61Iha+8wGRbc9FGv
 Giw6su05lZAW4gnvFfIDCIXdqYIhh/rwlyOCmbmHw7o8gUwHtm2zueeH/OdnF726SuC6
 44OmL62gnLPeeCaPPg8QwnCtGTW0/gYFZzDMZfpgKtuuRef7TApOiVpY6HFzKyIfaR9i
 1At0WwKyLMBfff9MGMRkdglkuzegrsk2ywXlkkYl3LoMpLxNnnywAh6bwZKV8Sk4rmxR
 Rf6w==
X-Gm-Message-State: AOJu0YwX+4J0yzkAqxacl5TbmH7VHB39t1PrOcudHO+vTnAS/CkxeKgp
 aEWFl2dNAgiuw6CAcd1gyi5NIiy968ddLmdyJiP8Qw==
X-Google-Smtp-Source: AGHT+IE8flaP9uMitqfOihlVRgYnSY/r73kshNqWXweVrBXMVt/f/YtnTPq6LEDZicwLFEkRUyuZ9w==
X-Received: by 2002:a05:6358:2484:b0:139:be3d:d032 with SMTP id
 m4-20020a056358248400b00139be3dd032mr16555464rwc.0.1692890283949; 
 Thu, 24 Aug 2023 08:18:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 x81-20020a25e054000000b00d712798a09bsm128496ybg.64.2023.08.24.08.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:18:03 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:18:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michael Walle <michael@walle.cc>, u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: remove Vikas Manocha
Message-ID: <20230824151801.GA3953269@bill-the-cat>
References: <20230824074436.2929639-1-michael@walle.cc>
 <20230824135441.GJ3953269@bill-the-cat>
 <93ef967c-8e9b-fbab-5186-4b1e3f11428f@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FDwAS+lnrdZA+IAZ"
Content-Disposition: inline
In-Reply-To: <93ef967c-8e9b-fbab-5186-4b1e3f11428f@foss.st.com>
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


--FDwAS+lnrdZA+IAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 05:09:25PM +0200, Patrice CHOTARD wrote:
> On 8/24/23 15:54, Tom Rini wrote:
> > On Thu, Aug 24, 2023 at 09:44:36AM +0200, Michael Walle wrote:
> >=20
> >> The mails are bouncing with
> >>   550 5.1.1 User Unknown (in reply to RCPT TO command)
> >>
> >> Remove the entry and mark the ARM STM STV0991 arch as Orphan.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> ---
> >> CCing other ST people, maybe someone want to take over instead.
> >> ---
> >>  MAINTAINERS | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 84de9de531..57ede4bea9 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -641,8 +641,7 @@ N:	stm32
> >> =20
> >> =20
> >>  ARM STM STV0991
> >> -M:	Vikas Manocha <vikas.manocha@st.com>
> >> -S:	Maintained
> >> +S:	Orphan
> >>  F:	arch/arm/cpu/armv7/stv0991/
> >>  F:	arch/arm/include/asm/arch-stv0991/
> >=20
> > This misses board/st/stv0991/MAINTAINERS where he's also listed.  So,
> > someone needs to step up to maintain it all, or we should look at
> > dropping it.  Thanks!
> >=20
>=20
>=20
> Hi=20
>=20
> Unfortunately, the last significant update on this board was done in 2015=
=2E=20
> On our side, Patrick Delaunay and I, we never worked on stv0991,
> we don't have any hardware and we have enough work with STM32 platforms ;=
-)
>=20
> So we will not oppose to drop stv0991 platform.

OK, lets just drop stv0991 after v2023.10 is out then.  If someone else
doesn't prepare a patch I'll do so in a while.  Thanks!

--=20
Tom

--FDwAS+lnrdZA+IAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTndKkACgkQFHw5/5Y0
tyziyQv/aiFucPNXawm2l+/aHQnJGYledFKs/rQc3Yu0JUK54XNYDhgj+40dPrWZ
yh6ChKxUbIjMBFsuRyHRwItMvyDq/E6VpDRIPrsc4sRljXyZcnEvpKGsj5WjR5Qp
Ex9tz0K7cvqCqgYQr5fst+f00tohHMcp40Fx6JyOmAumrmJ4qj2BWrCinCXT/1be
Z6mNMD5AUPrnCqK602L8mX8eIEFY37MRcYv8VD5qCtlddW1NwNBLRwgLn7Xvp99S
WCAiWhFPPVcv4FkwqDrotHAxjx+ZmOrp7bOVAFudGto3c367qTcxf0d6wIi3kbZ2
sPbTS5rzRWlS0eUHjfs4uXD1lH3xJQKXi/qNgB5n6skH+AD9fSc5L6EomsCVOJeG
uuBrlHJ8nhdoGhDmRe9jab3l+KzLh+LYIG1xgRbDLOT639uZs58NlXbdfErDDqXJ
oRWJxTqlAJzlrOtYeYg0RllZ6ZAi9/3q0XnbGxd9BIOkuljV5xaIiCtDu8065uo5
G0rogIJr
=Ubfj
-----END PGP SIGNATURE-----

--FDwAS+lnrdZA+IAZ--
