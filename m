Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C1CCD8CB6
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 20:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7731A863F9;
	Tue, 10 Oct 2023 22:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YLH7AoCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323E5863F9; Tue, 10 Oct 2023 22:17:34 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C378E86B79
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 22:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7b92cd0ccso18668757b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696969049; x=1697573849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gQYPXm13GNez0KWBvXwUI3Vsie7V/yKFPSgh5w5eQyE=;
 b=YLH7AoCF+psDf4scaRMNjGbACnuAYdDoV0Hs0iblUcs41ErblfWmYOZQ0X/N6GCxjp
 JCTyI9cl0XqlTUx+02ZUAt5Fxh2sEIFXW1UBdxm7yx/QgReKnu08ZhF2/bPwTHpNIEfO
 IzBizlWIv78+nZ9rU7XLZChJ/WuQJXw9PN58I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696969049; x=1697573849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQYPXm13GNez0KWBvXwUI3Vsie7V/yKFPSgh5w5eQyE=;
 b=Lz1OmP7k08YfSZ3/8OG6tnJomaqcr25OjE5VmydgWGRSi6oK3HKv3JUBDQDtBJQbKN
 qNcUi3Lyt7H+DvYfFaq5XpCCV5/NaMYthCur1dxCu3R/oYtI1JAMm2BlLiBoY84qHNar
 pABfsx3QVlIJb8YRLdw1g0VuBZ+RlbLu8La9hk05ZgK2QwEIathZ03W9FRxuC3KK3x5h
 LcfJmsnODYbUJddkfl8Ss475jChVq9Bt8RqWDsRR7Nqktaw20mDMo5O4z+lT3cZ3uHJg
 255PeAhwQ3AB2I49z/LoCA8LLw8WZ23lSF0HzPlNkKboMcy8qLABWPNYueyEXo6EV5HU
 ZLQQ==
X-Gm-Message-State: AOJu0YwgElULG49xSLu0bpPNFSHszb+15AKX1Hxi6w8nTKWdsmId1e+j
 wbMtu6yWTOItgcPtrPGSjHapiA==
X-Google-Smtp-Source: AGHT+IGCSfBXWbdZSRf1h1vXnh+Um/ntyAVro1UaXTqzz9GpjZga1/J8fV0GtNj0nmX78Sr0oCGejg==
X-Received: by 2002:a25:ad18:0:b0:d9a:60f2:a734 with SMTP id
 y24-20020a25ad18000000b00d9a60f2a734mr2800394ybi.36.1696969048865; 
 Tue, 10 Oct 2023 13:17:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a369-3392-aca4-1f00.res6.spectrum.com.
 [2603:6081:7b00:6400:a369:3392:aca4:1f00])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a5b0b0e000000b00d81425266c1sm3911030ybp.42.2023.10.10.13.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 13:17:27 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:17:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 10/15] cmd: blk_common: Use macros for the return values
Message-ID: <20231010201725.GB3119521@bill-the-cat>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-11-bmeng@tinylab.org>
 <CAPnjgZ082BzO4AGXvYqkaZPC_BkF1zc_AAW1zV9k31GnZhwpJQ@mail.gmail.com>
 <CAEUhbmX3hhOkUqj-2bj6BvrmE3zvsbeOtGUMK=mAs+Pg-Ay94A@mail.gmail.com>
 <CAPnjgZ1uaWkf+yWQ2_UiyYca3fNgLw0izRE0-zm0oeWybc4o9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5sZBkGh2Xo6buYFI"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1uaWkf+yWQ2_UiyYca3fNgLw0izRE0-zm0oeWybc4o9A@mail.gmail.com>
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


--5sZBkGh2Xo6buYFI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 08:58:04AM -0600, Simon Glass wrote:
> Hi Bin,
>=20
> On Tue, 10 Oct 2023 at 03:06, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Mon, Oct 2, 2023 at 9:42=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Bin,
> > >
> > > On Tue, 26 Sept 2023 at 02:54, Bin Meng <bmeng@tinylab.org> wrote:
> > > >
> > > > Avoid using magic number 0/1 for the command result.
> > > >
> > > > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> > > > ---
> > > >
> > > >  cmd/blk_common.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> > > > index 9f9d4327a9..ad9b16dc09 100644
> > > > --- a/cmd/blk_common.c
> > > > +++ b/cmd/blk_common.c
> > > > @@ -25,18 +25,18 @@ int blk_common_cmd(int argc, char *const argv[],
> enum uclass_id uclass_id,
> > > >         case 2:
> > > >                 if (strncmp(argv[1], "inf", 3) =3D=3D 0) {
> > > >                         blk_list_devices(uclass_id);
> > > > -                       return 0;
> > > > +                       return CMD_RET_SUCCESS;
> > >
> > > I really don't like this...0 is success.
> > >
> > > >                 } else if (strncmp(argv[1], "dev", 3) =3D=3D 0) {
> > > >                         if (blk_print_device_num(uclass_id,
> *cur_devnump)) {
> > > >                                 printf("\nno %s devices available\n=
",
> if_name);
> > > >                                 return CMD_RET_FAILURE;
> > > >                         }
> > > > -                       return 0;
> > > > +                       return CMD_RET_SUCCESS;
> > > >                 } else if (strncmp(argv[1], "part", 4) =3D=3D 0) {
> > > >                         if (blk_list_part(uclass_id))
> > > >                                 printf("\nno %s partition table
> available\n",
> > > >                                        if_name);
> > > > -                       return 0;
> > > > +                       return CMD_RET_SUCCESS;
> > > >                 }
> > > >                 return CMD_RET_USAGE;
> > > >         case 3:
> > > > @@ -49,7 +49,7 @@ int blk_common_cmd(int argc, char *const argv[],
> enum uclass_id uclass_id,
> > > >                         } else {
> > > >                                 return CMD_RET_FAILURE;
> > > >                         }
> > > > -                       return 0;
> > > > +                       return CMD_RET_SUCCESS;
> > > >                 } else if (strncmp(argv[1], "part", 4) =3D=3D 0) {
> > > >                         int dev =3D (int)dectoul(argv[2], NULL);
> > > >
> > > > @@ -58,7 +58,7 @@ int blk_common_cmd(int argc, char *const argv[],
> enum uclass_id uclass_id,
> > > >                                        if_name, dev);
> > > >                                 return CMD_RET_FAILURE;
> > > >                         }
> > > > -                       return 0;
> > > > +                       return CMD_RET_SUCCESS;
> > > >                 }
> > > >                 return CMD_RET_USAGE;
> > > >
> > > > @@ -80,7 +80,7 @@ int blk_common_cmd(int argc, char *const argv[],
> enum uclass_id uclass_id,
> > > >
> > > >                         printf("%ld blocks read: %s\n", n,
> > > >                                n =3D=3D cnt ? "OK" : "ERROR");
> > > > -                       return n =3D=3D cnt ? 0 : 1;
> > > > +                       return n =3D=3D cnt ? CMD_RET_SUCCESS :
> CMD_RET_FAILURE;
> > >
> > > CMD_RET_FAILURE is OK, but I would prefer not to use CMD_RET_SUCCESS.
> > > It is 0 and always will be.
> > >
> > > It encourages people to do things like:
> > >
> > > if (ret =3D=3D CMD_RET_SUCCESS)
> > >
> > > instead of
> > >
> > > if (!ret)
> >
> > I see your concern. However we don't change the return value type to
> > enum, so people can still use
> >
> >     if (!ret)
> >
> > I would still defend that we should use CMD_RET_SUCCESS.
> >
> > This is like EXIT_XXX defined in stdlib.h:
> >
> > #define   EXIT_FAILURE   1    /* Failing exit status.  */
> > #define   EXIT_SUCCESS   0    /* Successful exit status.  */
> >
> > One should use predefined macros whenever possible.
>=20
> I agree except for success, where I don't, sorry. It should always be 0 in
> U-Boot.
>=20
> People then have to look up the value and also we get things like
>=20
> if (ret !=3D CMD_RET_SUCCESS)
>=20
> It is a slippery and I would rather not start down it.

To be clear, we have a large amount of code today that uses
CMD_RET_SUCCESS in the way this patch converts to.  We do have a few
cases even of the kind of code you worry about seeing, but I think in
context clearer (it's in security or OTP fuse contexts) and the compiler
will do the right thing regardless.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5sZBkGh2Xo6buYFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlsU8ACgkQFHw5/5Y0
tyz5qAv/RWIvJ4agHoCCnToRsoTvNGQCzMMlrntSiQ+mDS2GFn3TJUfxRwyoHikc
pp77tC1BdwWAyri1ar7fnHwP48/AOXrUVDZT2/6WVojk/7zjqPKGb4rqRdlu+DsC
7cdXQx//R+QrmkCjgCXU7sb+McOusZxmCIh17Zi9rT+zUxDVlOXGM1mgJ4lRfUfz
4yP623IyiTsyhn0vRjk//5M0LGEtSJk7oh55HF7Xie/YhCxgnov7yF1jxL4AVFBs
wql4OnCwqYyVItmfYmE2wq1QnVDma02tXaPZ9iWsiTigD107af4DwtNQKKiyoZtE
I3aRx5aQJudNDHInlKuOur7K+pfWMPHjL4OMGlmzK4KuT94Qdl0iCbk+TO978jRC
WhXgTRhSlg9ZEcD58t+7fuyonPMLry2Tf0jW1n4pH0qU2TzeKB5YbgPyFBU+jysi
+5SOTxbu6QlgU2yk0XwT1ffDc0MEHkmlb8CsrIvWktQv+R/fi0fE42bOrwgTzmFY
z+1PnCvy
=Tw55
-----END PGP SIGNATURE-----

--5sZBkGh2Xo6buYFI--
