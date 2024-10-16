Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C6FD2A53D
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 19:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A949F88D5C;
	Wed, 16 Oct 2024 21:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eD7zdf1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3FF88DC7; Wed, 16 Oct 2024 21:10:50 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A1C88D5A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 21:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-460464090d5so1500121cf.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729105847; x=1729710647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tmVgITRNrFLmdTkceMRlyzPTz7IOF5EcylRXCf2Jocs=;
 b=eD7zdf1BrIZQgmZVsIS/h0wtL3XIxF1dyKWBYYTAJ7P6Y2koW+Au7o0Fs4q56QGlHT
 KuJrChnv13HE+9hgWtAbApdaJmIPcCMXBrU8lqoE3hZ+Lj6HfsaMFce4xaArYqQowCnJ
 cgqO6Fu1VTqqBdj6P4sVJfGOqpimiBEKWEJyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729105847; x=1729710647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmVgITRNrFLmdTkceMRlyzPTz7IOF5EcylRXCf2Jocs=;
 b=J2jusYSSGvv7WYJmvdKFXVOt/R1YMC98xPnsz+S//sT1L5/Ddqi9WqeCwXXPlj82yd
 buln/pJD6n21NwAvXKV4NdgDQeivr4hIJnQOqbRdg8QRSeZ8eQwmK8oVu/vOJXtt4yxd
 qRav2gIsj2uCDcPwIlrwySYXVCZt1G2atbjnZ7GNoKKiu4zezKLX8WY0Z9u4y3cQkZC7
 poZZEUVw8LibJ1FCvTuohd9CLhCXQkTwSJM5x28PfsoKBkQg0W9FcW9ID87qWqQxf97Z
 MdpYXkuv+FhAIQJcP4p5+f88kSd0DY9SSlJRErFmm0JYdTuI6IypUtetl987w9DNBALD
 PojQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8QWR8FaL77cumZeyp7KZfl+bTQ5CnfR5kvg5ItvV5uTAOu4Z+rE1rAKOy3E1e8lnlqZUV/X8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/nsPPrn16N0yxpAzYCrt9Q3pYvGNtTUW5emHG6Rja3AzGn5/v
 vrVqarKXFQ2KSacjhYvo3XxzQHgFSpJwy1V8SqwGKUP2OOCEu1rMT+sRcW1gSKE=
X-Google-Smtp-Source: AGHT+IGnBM/Njzlx1DURI4Xn6Y4pRKWf/erE55JTGsxvjWdW2GUyYZh+cXNIgX6efZeOVhaRv1QCJA==
X-Received: by 2002:ac8:59ca:0:b0:458:4aec:2749 with SMTP id
 d75a77b69052e-4608a6d398cmr70215871cf.57.1729105846748; 
 Wed, 16 Oct 2024 12:10:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46090351d27sm9176741cf.47.2024.10.16.12.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:10:45 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:10:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Massimiliano Minella <massimiliano.minella@gmail.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2] cmd: setexpr: fix no matching string in gsub return
 empty value
Message-ID: <20241016191042.GG4959@bill-the-cat>
References: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
 <CAHTX3dLUTJ=FKyZT1NaWMsGwKpUwy0MBMsra7YwNQCPERYNDoA@mail.gmail.com>
 <20241008172035.GA66965@francesco-nb>
 <CAGS_c3WoCApeh4QVDrG7=tF=wwEsFStKmRphzfVGTtwKT9yJhQ@mail.gmail.com>
 <E9E05009-AEA3-49F8-BF73-2864D29BC422@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZVgfrmam2ahE98Fp"
Content-Disposition: inline
In-Reply-To: <E9E05009-AEA3-49F8-BF73-2864D29BC422@dolcini.it>
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


--ZVgfrmam2ahE98Fp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 08:17:02PM +0200, Francesco Dolcini wrote:
> Il 11 ottobre 2024 18:01:22 CEST, Massimiliano Minella <massimiliano.mine=
lla@gmail.com> ha scritto:
> >Hello,
> >
> >On Tue, Oct 8, 2024 at 7:20=E2=80=AFPM Francesco Dolcini <francesco@dolc=
ini.it> wrote:
> >>
> >> +Tom
> >>
> >> Hello Massimiliano,
> >>
> >> On Tue, Sep 03, 2024 at 01:06:21PM +0200, Michal Simek wrote:
> >> > HI,
> >> >
> >> > =C4=8Dt 8. 2. 2024 v 16:00 odes=C3=ADlatel Massimiliano Minella
> >> > <massimiliano.minella@gmail.com> napsal:
> >> > >
> >> > > From: Massimiliano Minella <massimiliano.minella@se.com>
> >> > >
> >> > > In gsub, when the destination string is empty, the string 't' is
> >> > > provided and the regular expression doesn't match, then the final =
result
> >> > > is an empty string.
> >> > >
> >> > > Example:
> >> > >
> >> > > =3D> echo ${foo}
> >> > >
> >> > > =3D> setenv foo
> >> > > =3D> setexpr foo gsub e a bar
> >> > > =3D> echo ${foo}
> >> > >
> >> > > =3D>
> >> > >
> >> > > The variable ${foo} should contain "bar" and the lack of match sho=
uldn't
> >> > > be considered an error.
> >> > >
> >> > > This patch fixes the erroneous behavior by removing the return
> >> > > statement and breaking out of the loop in case of lack of match.
> >> > >
> >> > > Also add a test for the no match case.
> >> > >
> >> > > Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
> >> > > ---
> >> > > Changes in V2:
> >> > >  - update documentation to describe the behavior
> >> > >
> >> > >  cmd/setexpr.c             |  9 ++++-----
> >> > >  doc/usage/cmd/setexpr.rst |  1 +
> >> > >  test/cmd/setexpr.c        | 10 ++++++++++
> >> > >  3 files changed, 15 insertions(+), 5 deletions(-)
> >> > >
> >> > > diff --git a/cmd/setexpr.c b/cmd/setexpr.c
> >> > > index 233471f6cb..ab76824a32 100644
> >> > > --- a/cmd/setexpr.c
> >> > > +++ b/cmd/setexpr.c
> >> > > @@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_=
size, char *nbuf, uint nbuf_size,
> >> > >                 if (res =3D=3D 0) {
> >> > >                         if (loop =3D=3D 0) {
> >> > >                                 debug("%s: No match\n", data);
> >> > > -                               return 1;
> >> >
> >> > This patch actually changed the return value from command.
> >> > In board/xilinx/zynqmp/zynqmp_kria.env we have
> >> >
> >> > bootcmd=3Dsetenv model $board_name && if setexpr model gsub
> >> > .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter*
> >> > $k26_starter; then run som_cc_boot; else run som_mmc_boot; run
> >> > som_cc_boot; fi
> >> >
> >> > and this patch actually breaked it because we rely on return value.
> >> > Changing return value is not described and I want to know if this
> >> > patch should be fixed
> >> > or we should update our commands to match new return value.
> >>
> >> Massimilano, any comment on this?
> >>
> >> This change broke also our use case - our board is no longer booting
> >> with v2024.10 U-Boot. I do not think we should change something like
> >> that without a clear reason and I was not able to understand it from t=
he
> >> commit message.
> >
> >The reason why I proposed the patch was that I found the behavior of set=
expr
> >gsub not consistent with the behavior of the same function in gawk, whic=
h,
> >according to the commit message that introduced gsub/sub, both commands =
are
> >closely modeled after. Also I didn't see a particular reason for returni=
ng an
> >empty string or throwing an error when doing a string substitution that =
provides
> >no match, so IMHO it was a bug.
> >
> >From a quick grep on the master branch it seems that the command is used=
 only in
> >board/xilinx/zynqmp/zynqmp_kria.env and include/env/ti/ti_common.env. In=
 the
> >first I see it has already been fixed and in the second the change has no
> >impact.
> >
> >It's unfortunate that it broke the boot of your board, maybe something a=
s it has
> >been done for the zynqmp_kria is feasible according to your use of the c=
ommand?
>=20
> The U-Boot commands are used (also) outside of the U-Boot repository. In =
my case it was a boot script that was relying on the previous return code.
>=20
> Of course, I can adapt the script to work with the new semantic. And I ha=
ve also to consider that my boot script might be used on an older U-Boot, s=
o in practice I need to handle both, and I did it.
>=20
> To me it was a bad decision to change the semantic here. My own issue is =
solved, as I wrote, but I would advise to just revert it.

Would you be able to write an update to doc/usage/cmd/setexpr.rst that
spells out our deviations from gawk gsub?

--=20
Tom

--ZVgfrmam2ahE98Fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQD6YACgkQFHw5/5Y0
tyyJtAwAkb1VOincan2Ix/L/zMHJvU9zNvTLZoBQJLFLIyxBdMUJvPX4hJyjaG5g
MHWuTO2vPhZHT6aLSiE/IWFfx2FR7y0hPjtI/GULyy+uEtRQLoiBhs+WyS6n0uXf
nFkILNbs8u4TIAMtcXgFfIdn2qIFKlSLIgFT98/WshpMb3VMYscQQc0iC1Q3WI+E
hzGTdA4PP+bA70cu0A+O1L6yssXqDJg4GdrAVeYFMYAEKyl83aEHmxCzOIzJZgX5
+KXCPMnHX8nQ3VhmTWWqs6fRn0VX1hQglbdYstpXRKXTkBEze6Is05syro0XbB8g
N1mJ4sTXToUf8HEmSn+9TwLWxtwD/nvUKcvMxV7GuCRN2iIYNvInc+S4JvPCXNv7
ujzKJxMmcAhf3uU+vzhI9yBeFyMoDSUSMDBYylc204GqH8Ief/x/YKBYFjvDS2oo
V11A3i6QaBv/FlGRrvtsj3w+YgLIRu059p+NTLC9Vo2wmLYTuRWcIGiAoS4SH6al
KUZl9yBu
=JEP/
-----END PGP SIGNATURE-----

--ZVgfrmam2ahE98Fp--
