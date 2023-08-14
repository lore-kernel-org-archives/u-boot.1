Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F97C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C3A86722;
	Mon, 14 Aug 2023 17:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ku6PrK3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54FC867B4; Mon, 14 Aug 2023 17:15:26 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC8A86679
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-589f784a972so8454767b3.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692026123; x=1692630923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HG8a1m1EFiJeIn71OzryUJ1/qSid2/qnbuOWZKnw6QU=;
 b=Ku6PrK3oVnv5mqxxIXDVvOSXlMq06AspAekzN/84nTnEUODA8rCJ95PIE4fdbqnPT3
 kBJ/YSOs7eBTO/1Ufdb/RFiJfMkfmLsnOJjdGNhEKcFxhb4Hu8hIXEl3HiNNSjUszIlg
 rILxX4sufcFd8IQXcB4V/rSIGymquDBOAGGfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692026123; x=1692630923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HG8a1m1EFiJeIn71OzryUJ1/qSid2/qnbuOWZKnw6QU=;
 b=ck5bynOWI5O/Yq2hdjJ8vXt18+hYNWiuOCk8frOmUQ5LWTklrK96UEZ3v+5rJx8foW
 p7HfDBlUeZX3DvYpBO+5aCtmW9r5r6UGxbcxr8cwEnJasXagQTA3nkG+QlrtBVOtqMez
 T9QWKL14AFpeF/bjfdVGqR8UEUKDPH9iBS52IiGAeV5Vra9kV/dtBMxojleEr8DwPIZ9
 Rpe0Xb0CXfsN4nrvkTrh1gwhZWIvk2tbB8W9kqdPJN3XSib55Tz7ErGa9rvBYza3SUUz
 iFzv+JPGLvwoJIUXk1nHqJBYdj8w2RedCVWGgur6gps6L88mnuvnXKQenlKoXxiR1yhD
 asmQ==
X-Gm-Message-State: AOJu0YyoKMiLxFwnf6egZ2/hi08g7I8EYvYAtXUM0rTGVcPb5RDu8drb
 rkCdRM7XqrfVjaALFX6F2baW8bEOqw0CwlpWGmgFYQ==
X-Google-Smtp-Source: AGHT+IHXHqObJ91p0q3e3JBqvQ4gl4WW7EKkJjweU4pujbN1601dJw1JbZFzXTUCOfDXYfs6sH/xsA==
X-Received: by 2002:a81:8882:0:b0:585:f4e0:6532 with SMTP id
 y124-20020a818882000000b00585f4e06532mr7343309ywf.30.1692026123559; 
 Mon, 14 Aug 2023 08:15:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 w190-20020a0dd4c7000000b00583d67839fasm2815832ywd.121.2023.08.14.08.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:15:23 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:15:21 -0400
From: Tom Rini <trini@konsulko.com>
To: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: u-boot@lists.denx.de, Gabriel Hojda <ghojda@yo2urs.ro>
Subject: Re: [PATCH] odroid_xu3: Fix board environment variable
Message-ID: <20230814151521.GY3630934@bill-the-cat>
References: <20220608183014.1417881-1-trini@konsulko.com>
 <ZNGl-cmCNGhegE7T@Dell-Inspiron-15>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LAI5027tWY9o2yjt"
Content-Disposition: inline
In-Reply-To: <ZNGl-cmCNGhegE7T@Dell-Inspiron-15>
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


--LAI5027tWY9o2yjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 10:18:33PM -0400, Ben Wolsieffer wrote:
> On Wed, Jun 08, 2022 at 02:30:14PM -0400, Tom Rini wrote:
> > When migrating CONFIG_CONS_INDEX to Kconfig, on this platform we changed
> > what "board" evaluated to in the environment.  This in turn meant that
> > we would no longer try and find the correct fdtfile via the normal
> > distro boot logic.  Fix this by overriding board in the default
> > environment, as done on other platforms where CONFIG_SYS_BOARD is not
> > what we want to be in the board environment variable.
> >=20
> > Fixes: f76750d11133 ("Convert CONFIG_CONS_INDEX et al to Kconfig")
> > Reported-by: Gabriel Hojda <ghojda@yo2urs.ro>
> > Tested-by: Gabriel Hojda <ghojda@yo2urs.ro>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  include/configs/odroid_xu3.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/include/configs/odroid_xu3.h b/include/configs/odroid_xu3.h
> > index eb35d7b4ae2d..360815bc03ee 100644
> > --- a/include/configs/odroid_xu3.h
> > +++ b/include/configs/odroid_xu3.h
> > @@ -86,6 +86,7 @@
> >  	"rootfstype=3Dext4\0" \
> >  	"console=3Dconsole=3DttySAC2,115200n8\0" \
> >  	"fdtfile=3Dexynos5422-odroidxu3.dtb\0" \
> > +	"board=3Dodroid\0" \
> >  	"board_name=3Dodroidxu3\0" \
> >  	"mmcbootdev=3D0\0" \
> >  	"mmcrootdev=3D0\0" \
> > --=20
> > 2.25.1
> >=20
>=20
> Hi Tom,
>=20
> This patch doesn't appear to have fixed the issue. There is a report
> from Debian of it occuring even after this patch was applied [1], and I
> ran into it today as well with 2023.07.02.
>=20
> I looked into it a bit, and the problem seems to be that
> set_board_info() constructs the fdtfile variable using CONFIG_SYS_BOARD,
> so setting the correct value of the board variable has no effect. I
> think either set_board_info() needs to construct fdtfile differently, or
> things need to be restructured to allow CONFIG_SYS_BOARD to be set as
> "odroid".
>=20
> I would submit a patch, but I'm not sure of the right approach to take,
> and I would appreciate your help.

Thanks for the detailed report. I believe the problem is that
board/samsung/common/misc.c::set_board_info() should be doing a lot more
checks for if the environment variable is already set, before
over-riding them.  This is typically done around ethaddr (so there's a
number of examples to look at) and in this case I think everything other
than soc_rev / soc_id should have a check before blindly overwriting.
However, just checking for board_name / fdtfile already being set
before setting them is enough to fix this problem I think.

--=20
Tom

--LAI5027tWY9o2yjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaRP8ACgkQFHw5/5Y0
tyx8Vgv/QGHoJQuvmyOBUPDsGFMWemiGi88NL1D149r5b2yqsuJUaS3OUmlofNIa
yJZF3wodZUwr1qHLsITcabjR4S5slDrv9HiJnsedkOWAAd9hlD5rmteLwaa5rpDv
QnpJXJFqdPw4E70OOErIrbwsBcivWylLjiKBunW5++7JARNhSf2f2oV2RQA849zJ
E1aZlwm7RYFnfEGiPdPiLY5c/q6vozRI6QjZM9GWnRPCZm+NYeTKzUE35QRz7481
byG22kHlX0DSeiOEEXeK27LFUjqg8gjSE0BniODG+bVuCJP+c3IrqlaUQ3A0b6uj
JW8DMQExy371ske/eCSHjhSsdRhtFbYtcqcPOjj3GNQvBWjtIIyeT7XumXdOL+2L
7isvSW1RSw+yr7G6KfwJQvkVpR9amtBoAG39CUvjzadABYA+UwXaVc7WG9wMdJrk
4oRmgtRF3o6abKUDYO274shQSYVgdkGh2CODcDS8WPmZM4hQEyXIXGvDMqAXEzBi
5XtfkRe0
=68eq
-----END PGP SIGNATURE-----

--LAI5027tWY9o2yjt--
