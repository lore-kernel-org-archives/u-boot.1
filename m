Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA243C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4DD86EE5;
	Thu, 16 Nov 2023 02:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ooDaI8xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898CC87045; Thu, 16 Nov 2023 02:47:13 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB028652B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77bcbc14899so15238885a.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700099230; x=1700704030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rfyxy6pFsz81PHN87zjpT07wTkxFGzWjFLZFMxF0Mzg=;
 b=ooDaI8xdBbdFb7iPU0uum98klH7FpoQkYkZeiFjgRGO7GdaBaUQ/PcuBoGqfeHiqlE
 aHwQXoYuWJ8iniG7+yyHm0EUWNZgIAMfEKa+73fCzxpxEnMQNsZxC3irAzw/Vbn1RHqw
 5vfwI5y1ROsB7uTJJGZdw4Q5B+i4xDIw3OiIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700099230; x=1700704030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rfyxy6pFsz81PHN87zjpT07wTkxFGzWjFLZFMxF0Mzg=;
 b=F71BET56mgvSMWm9yBbUevr5hDHsPa/TjNZtyOPbwFYxEcw1DupF9fRgbnbLRpuc+G
 nVGDfYr/XymjEdzjdahtnt6xG3Nuj9CiEPsghEWDUy8p+wVmuphJfa95SqBnFmA8q0+E
 hgrFf0sP1k4GR5tNmMEvPyY0vrsf9EXViIXRPIpppbnzFnL8U5QSkGiJIWPAjkceyMnC
 zTOFvob5TpZlWer8W337w10L3q1PaiiljDDxS53qmbHP8vxCQpVqvZbYAOnhgwzwK7vb
 0Ndeoz4p2MI/iryZs1A5M47wdobL9SPxyFYqSUSqTanAHOkXYwnIIMjUQnDqf/AyAgou
 u7eQ==
X-Gm-Message-State: AOJu0Yz9Z4iQi8xehTa+FmG0mIyJ4Eaw+DZApso7jf7eAxUJ1zcODyxo
 GlhE46uak6OQAav1QOqdMde//A==
X-Google-Smtp-Source: AGHT+IGUA8xTcEMyj/lFOcP74Nq0bmube/qXIocyDU1Q8tcwgRCpa5mPUcHAPTewtm+pH42uLWR6oQ==
X-Received: by 2002:a05:620a:1645:b0:778:9a8e:57c with SMTP id
 c5-20020a05620a164500b007789a8e057cmr6738983qko.78.1700099229842; 
 Wed, 15 Nov 2023 17:47:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 eb11-20020a05620a480b00b007742218dc42sm3931608qkb.119.2023.11.15.17.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 17:47:09 -0800 (PST)
Date: Wed, 15 Nov 2023 20:47:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 27/29] bootm: Adjust the parameters of bootm_find_images()
Message-ID: <20231116014707.GI6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-28-sjg@chromium.org>
 <20231115223800.GE6601@bill-the-cat>
 <CAPnjgZ379WFHcrVUYPTGZqhUvA95aaDKdfiqNGBOXt4hBrWrKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RmUIpxu1FL69nkNl"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ379WFHcrVUYPTGZqhUvA95aaDKdfiqNGBOXt4hBrWrKQ@mail.gmail.com>
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


--RmUIpxu1FL69nkNl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:42:19PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 15 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Nov 11, 2023 at 05:09:12PM -0700, Simon Glass wrote:
> >
> > > Rather than passing it all the command-line args, pass in the pieces
> > > that it needs. These are the image address, the ramdisk address/name
> > > and the FDT address/name.
> > >
> > > Ultimately this will allow usage of this function without being called
> > > from the command line.
> >
> > OK, so this goal is good.
> >
> > [snip]
> > > +             return bootm_find_images(img_addr, argc > 1 ? argv[1] :=
 NULL,
> > > +                                      argc > 2 ? argv[2] : NULL, 0, =
0);
> >
> > That we repeat this much harder to read test/if/else three times now is
> > less good.  Can we find some way to hide the complexity here in the case
> > where it's coming from a command and so we have argc/argv[] ?
>=20
> I can't really think of one. Ultimately this is coming from the fact
> that the booti and bootz commands directly call bootm_find_images(). I
> haven't got far enough to know whether that will still be true in the
> end, but I hope not.
>=20
> IMO the correct place for the logic above is in the command-processing
> code, where it decides which arg means what.
>=20
> I could imagine something like:
>=20
> static const char *cmd_get_arg(int argc, char *const argv[], int argnum)
> {
>    return argc > argnum ? argv[argnum] : NULL;
> }
>=20
> but I'm not sure that is an improvement.

I was thinking about this more after I sent this. And I think we might
indeed want an inline / macro to handle this case more generally as I
suspect we'll have similar cases where we need argN-or-NULL as we
refactor other areas of code to split "here is the command" from "here
is the library functionality" of it. Then we'll have:
ulong foo =3D cmd_arg_one(argc, argv);
ulong bar =3D cmd_arg_two(argc, argv);

librarycall(foo, bar, ...);

--=20
Tom

--RmUIpxu1FL69nkNl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVdJgACgkQFHw5/5Y0
tyzezgv/acHnWnkQkO5yHGRc7qNfBxVEbh9Gr4KnQLuzaFL/r4XKP0jLvcWzzUPI
H9Ee+hKhGaoi0BrBksFGXGmEzfEpwc/QTqZ6C7R4kvArE8fo7Y+br7k16iZEyFGg
Vb0E3dXfsEGqUMDbaY1jERC00P6kIJbGusrrhH7zsAHQxRZPM6K/7Nlm2jIuJk6Z
e65hpZYTtqrWZEjgYElzy7aP2URyVMIoN9zUmz5WqADVMswv5tfrMjp9hzQ1722T
CBTI51O8NtArifV1V+RVAl/Ky85OPzpbddRkvAPUIsj7QOToTz5L7vNz1cog6qre
5oteshUfJdS4TghdjTT2HIhGZDK7FQqlDwP8EWP6ZS1L3m2UJIStTsbEaPGo71sr
zy9WQETTVIWBz0SP/6oWXYG+DYW3vseNPMFqsyLL0KoL+GkOhTT5PfQO7RNeDIq9
tMWoDYos+D+AQ57oIb6Ph2Mj0W6vXso9s8kwgYTUonVioEJgTFSTyWbqsBWHZdcI
9Tymc9zq
=bMt1
-----END PGP SIGNATURE-----

--RmUIpxu1FL69nkNl--
