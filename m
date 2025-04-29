Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75637C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 19:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07EC829A1;
	Tue, 29 Apr 2025 21:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B15oUZe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D6B82A7B; Tue, 29 Apr 2025 21:17:21 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A9E82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 21:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c14138668so1735329a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745954237; x=1746559037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l786tExaKXRkkhdfHtwtzmqG0JZhpYVWzXkcseEoPOw=;
 b=B15oUZe+gGyW/+KoDIbdBc2pLHqiABOPIXXb5T63OCHK1mJuJK0Af22eiTwVqXP5DU
 d8Iaw4KnKYy6wzX5eHw3WRYSIXTTP7s5Wi94BtPaj4yznJADI4CRb0g+16DThTCLlXkk
 T+Rv5Imtqqfc8FiH+9ZBmhIoXHSsuQx2hZCuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954237; x=1746559037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l786tExaKXRkkhdfHtwtzmqG0JZhpYVWzXkcseEoPOw=;
 b=ZxYQPg0VgWomxqRb5JVZ5Xq+VG61nfflOSraIX3XTmN30V8ybOqhNoZZQBDPFZHDd/
 XveCmNXLCm7uMhEuW34VUvLwnqoVoQWdOQ7Ya04No6dmmFRTqmcozdVHhXY1NXpGkRWg
 uAkqa1kIIcOyrAMKdylxNMPd0N34Y86qSqlmufAr2Ig3trsh9jQh/96ag626t7bm+wtA
 5NgUHCa3aJ1ppoNc8vWJpBFQiu7K/yzuGAWyj/MxFkzx7+cz7Sj1yQtyq2yTLZ140hz6
 K/eBc9EgLQb0oPa2sG/qWcuIP8B0EXWmye8H9jTrrrF9d1nwVCdctt/6bDkcg5VtjjRU
 kvKA==
X-Gm-Message-State: AOJu0YzqFnbJiCG3pFAIxSKAHio0UjrPn90eDWUaBkwRee8kmDzDEswv
 3P19t+eOV53jsKdw2BjIz03ft338fCWhLKpkDl3j5Yz51eQ97zUR5ugeH01Wi90=
X-Gm-Gg: ASbGncsVM9KXlvg1Yc4RRMypnVGpg6IWF94va6yTSMCXlMNg3BFYXNsaiT4lRm0cbL1
 0+CRh1KyKpd68Umsr3N0JGnTgqvy1UK61laQrbzZNLwHNaAVvY8NFmEKKPJhGlZpo6iPS26Mz0n
 tzAz9wfuHvl+FyuKLpcCJpEorcTcF2inNIiNXDbgb1RIBGqn0nEBEnBZuN5p9DFzld5zPsRyDTe
 1T8la9sD0qQM+QNUM7vD4JfPuXdmWFSIUCp5EyEEQqVTTscRv6eR0LreKyfDLW1R5RW98j42Cac
 1WlPrj5UBPUN6WrQNxXjVn8XkB1/PMyCrrAIoZkG2HwxyEepKqY5/WkwA7tlpyIsBY0X9FL2WeI
 NYA==
X-Google-Smtp-Source: AGHT+IHRAe1fGBpe1AITKiKpG1lT9L98bY55Y1YwCAMoVylfDUhdsI7tvLcD1jFdsqvWKOLkLSlg+g==
X-Received: by 2002:a05:6830:6f8d:b0:72b:99eb:7ce3 with SMTP id
 46e09a7af769-731c0a9c6d2mr274279a34.18.1745954237228; 
 Tue, 29 Apr 2025 12:17:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973b7a5efsm2945300fac.35.2025.04.29.12.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 12:17:16 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:17:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: Re: [PATCH] bootm: improve error message when gzip decompression
 buffer is too small
Message-ID: <20250429191714.GL1261075@bill-the-cat>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250428172439.GD5495@bill-the-cat>
 <CAJwFiG++7ikLUQBGiz8QXsY=R4WQkWnsWC_ETan5syk-poTu_w@mail.gmail.com>
 <20250429141529.GD1261075@bill-the-cat>
 <CAJwFiGJTiDuFn-03vWbMPB2ui9jMTwWC2hcqMfDsgJieRAqqXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BY8FiHmdSAn/cSk/"
Content-Disposition: inline
In-Reply-To: <CAJwFiGJTiDuFn-03vWbMPB2ui9jMTwWC2hcqMfDsgJieRAqqXw@mail.gmail.com>
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


--BY8FiHmdSAn/cSk/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:15:58PM +0800, Aristo Chen wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B44=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:15=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Apr 29, 2025 at 06:08:50PM +0800, =E9=99=B3=E5=81=89=E9=8A=98 w=
rote:
> > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B44=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:24=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Mon, Apr 28, 2025 at 02:07:57PM +0800, Aristo Chen wrote:
> > > >
> > > > > Currently, when decompressing a gzip-compressed image during boot=
m, a
> > > > > generic error such as "inflate() returned -5" is shown when the b=
uffer is
> > > > > too small. However, it is not immediately clear that this is caus=
ed by
> > > > > CONFIG_SYS_BOOTM_LEN being too small.
> > > > >
> > > > > This patch improves error handling by:
> > > > > - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> > > > > - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when appli=
cable
> > > > > - Preserving the original return code from zunzip() instead of ov=
erwriting
> > > > >   it with -1
> > > > >
> > > > > By providing clearer hints when decompression fails due to insuff=
icient
> > > > > buffer size, this change helps users diagnose and fix boot failur=
es more
> > > > > easily.
> > > > >
> > > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > >
> > > > I like the concept but:
> > > >
> > > > > @@ -573,12 +574,26 @@ static int handle_decomp_error(int comp_typ=
e, size_t uncomp_size,
> > > > >                              size_t buf_size, int ret)
> > > > >  {
> > > > >       const char *name =3D genimg_get_comp_name(comp_type);
> > > > > +     bool likely_buf_too_small =3D false;
> > > > >
> > > > >       /* ENOSYS means unimplemented compression type, don't reset=
=2E */
> > > > >       if (ret =3D=3D -ENOSYS)
> > > > >               return BOOTM_ERR_UNIMPLEMENTED;
> > > > >
> > > > > +     switch (comp_type) {
> > > > > +     case IH_COMP_GZIP:
> > > > > +             if (ret =3D=3D Z_BUF_ERROR) /* -5 */
> > > > > +                     likely_buf_too_small =3D true;
> > > > > +             break;
> > > > > +     // Add more if necessary
> > > > > +     default:
> > > > > +             break;
> > > > > +     }
> > > > > +
> > > > >       if (uncomp_size >=3D buf_size)
> > > > > +             likely_buf_too_small =3D true;
> > > > > +
> > > > > +     if (likely_buf_too_small)
> > > > >               printf("Image too large: increase CONFIG_SYS_BOOTM_=
LEN\n");
> > > > >       else
> > > > >               printf("%s: uncompress error %d\n", name, ret);
> > > >
> > > > This is a lot of code, why not just:
> > > > if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
> > > >   printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> > > >
> > > Thanks for your suggestion! I am not sure if I get it correctly, do
> > > you mean that we should remove the original if condition( if
> > > (uncomp_size >=3D buf_size) ) that prints the error message?
> >
> > Ah sorry for being unclear. I just meant we can handle the new print
> > more directly.
> No worries, and thanks for your patience.
>=20
> Just to double confirm, would the following meet your expectation?
>=20
> if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
>     printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> else if (uncomp_size >=3D buf_size)
>     printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> else
>     printf("%s: uncompress error %d\n", name, ret);
>=20
> Or would you prefer combining the first two conditions into one?
>=20
> if ((comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR) ||
>     uncomp_size >=3D buf_size)
>     printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> else
>     printf("%s: uncompress error %d\n", name, ret);

The second option yes, and then someone in the future can add
(comp_type =3D=3D IH_COMP_LZO && ret =3D=3D LZO_EQUIVALENT_ERROR) ||
and so forth.

--=20
Tom

--BY8FiHmdSAn/cSk/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgRJboACgkQFHw5/5Y0
tyyVOgv/ZiMbPjzHNvtTYtF+ulHGV0Mvc04170/YDbmtl0o5vXSrMzyfqU1SlFGb
xsIHe5WzOF9CHVDhWdSa2wRikWkxMYVLGgTzoEi9OrALXFraKEELGyMUHA5h6IPz
Y3Mb6d1ir11b4Rb+sJxs5mHNNRarNn2lEsh3FEnmMR3K2kNshi39icQsgu9H5QTv
IYHrJBHmL5e/5yY6srPUVoSrOhp2GWl2fxMb0K/tfTmgNYaqsdq+sFjIGcm58x/x
ofdd59F2PwNQ8SwFFhgX6jIqQScmAmchYrVWKAyDKCaEry/YOOrEIGA1Jz+qdJRb
+lXq/aMxBwPrk1jOareTH3B0QdYFqJ8Z0ht7EjHKpIkv/EKtVZ/yeLP80swVdCg9
N9XBFGMz2WGzBpyChtWqQwk8aamZ5dWNvx/vjXLQUp1I5anIf7V+szuxtPo2RR9R
j6Ks5aY2rf9QGqFJtiUhcMisx062F13f2VpExkDmPzSxZ0zCYafjelpdJLj9TBs1
LOeXfLB5
=05ep
-----END PGP SIGNATURE-----

--BY8FiHmdSAn/cSk/--
