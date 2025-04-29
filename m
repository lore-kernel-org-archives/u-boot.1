Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4723BC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1988272A;
	Tue, 29 Apr 2025 16:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YHfOLI7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787338297E; Tue, 29 Apr 2025 16:15:36 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7588215F
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-400b948600aso1635868b6e.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745936133; x=1746540933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UwJEldTwZ5glMozcoErJXunvb0SKv3tNRNDpIN2zrYE=;
 b=YHfOLI7EiWb38w0DgzD3rQ/j7Rtw4jhLxGvUrgnjY7f24EC7ey+OT1/dkjYBr1j65R
 1Nxm45F0ZKLmb/Q2t5+5RRvgb7MA71U9s8d0lqzx5XoM3AE1CAjA9thrrBayhZci4bfP
 HNx42tNamRzSdAjirhTlYQDnJYihCw5dqyHiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936133; x=1746540933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwJEldTwZ5glMozcoErJXunvb0SKv3tNRNDpIN2zrYE=;
 b=PRb8vvduTiWe6d420ftjo6T3Jr+owdZDv5ENKiLdkCf5GWL2swqkSrggMtrlspmE0b
 6fdyXXsanyFIYUyVDN24RiuvmvdtHab5JOCT7jkMZbmnV0cti3lH1WVaEoJziWG2JVe3
 N86BzVt/wZ3sAxNq5s0CCdH8TI44hFORruyykwfiPFScIgXGd5o+sqTbM3HIUI8gnWYb
 rgWuyjR9cnW8idx7khOlUAGFxxK81M8LCPVPxu7MYJuFy6j9L+sHG5dmhoyLYQPYOTbS
 5pk5GZXG41JWgneXADp2PaGZaUQjHUe0Acvks13TtSOP1Dm1iLnp4+9WDgQz/WNpMbi5
 k1sw==
X-Gm-Message-State: AOJu0Yz3wLAo/VJyux8cFHt0umhrxW+ZsSDRbObX2XePWd2cJ5F+9Z52
 FpVTxwT8q8OL+IAT/k9ppS1p1BWQVRSt1D/GyP/WVp1IV51LaqYs3bU1KegVfR4=
X-Gm-Gg: ASbGncvyOjq3ihQLceJfUg28r0nxBtZ8MESmN7vTEVJf/m+1FXfYTiC813leb3805/4
 CkrhxzphpmFub840Vk6/nqO5qG0SrrPg09GaVuCvPQLoKyyB0NT56LWZRhh9k0X6YKUT6Nrmjvf
 QnoM8zRKDABkrmrGsDvdpXhGaZuNGx1PoSZSCou9B97FEZtNP5Jynjb3LFwNTlMyW5RnbJDI+x/
 3yWBSn/POfpRoxMIys/VrIPaD3tZLHkE3GMQUoOkVXJ4X4hpkq93EircSneo0elpeiEszPG+h9y
 iKDjISPya9nD3Yjar9833G3DxvKsvn9EBCieaSbff4zzRm7xIS6bCr7dOvfpiNK8yL9KLT7Sihj
 5fg==
X-Google-Smtp-Source: AGHT+IEhyNsSKQWu90cSPqZ82btn01SowwyzDTQ35pbTREELvCeAhMELthgHr9TotrHnKXNYMAUjRA==
X-Received: by 2002:a05:6808:3388:b0:400:b402:2403 with SMTP id
 5614622812f47-401fd7e39f1mr7781001b6e.32.1745936132746; 
 Tue, 29 Apr 2025 07:15:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60686e96dddsm262817eaf.2.2025.04.29.07.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 07:15:31 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:15:29 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?6Zmz5YGJ6YqY?= <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: Re: [PATCH] bootm: improve error message when gzip decompression
 buffer is too small
Message-ID: <20250429141529.GD1261075@bill-the-cat>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250428172439.GD5495@bill-the-cat>
 <CAJwFiG++7ikLUQBGiz8QXsY=R4WQkWnsWC_ETan5syk-poTu_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="56cLX6Z2chpWH0Vz"
Content-Disposition: inline
In-Reply-To: <CAJwFiG++7ikLUQBGiz8QXsY=R4WQkWnsWC_ETan5syk-poTu_w@mail.gmail.com>
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


--56cLX6Z2chpWH0Vz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 06:08:50PM +0800, =E9=99=B3=E5=81=89=E9=8A=98 wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B44=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:24=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, Apr 28, 2025 at 02:07:57PM +0800, Aristo Chen wrote:
> >
> > > Currently, when decompressing a gzip-compressed image during bootm, a
> > > generic error such as "inflate() returned -5" is shown when the buffe=
r is
> > > too small. However, it is not immediately clear that this is caused by
> > > CONFIG_SYS_BOOTM_LEN being too small.
> > >
> > > This patch improves error handling by:
> > > - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> > > - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
> > > - Preserving the original return code from zunzip() instead of overwr=
iting
> > >   it with -1
> > >
> > > By providing clearer hints when decompression fails due to insufficie=
nt
> > > buffer size, this change helps users diagnose and fix boot failures m=
ore
> > > easily.
> > >
> > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > I like the concept but:
> >
> > > @@ -573,12 +574,26 @@ static int handle_decomp_error(int comp_type, s=
ize_t uncomp_size,
> > >                              size_t buf_size, int ret)
> > >  {
> > >       const char *name =3D genimg_get_comp_name(comp_type);
> > > +     bool likely_buf_too_small =3D false;
> > >
> > >       /* ENOSYS means unimplemented compression type, don't reset. */
> > >       if (ret =3D=3D -ENOSYS)
> > >               return BOOTM_ERR_UNIMPLEMENTED;
> > >
> > > +     switch (comp_type) {
> > > +     case IH_COMP_GZIP:
> > > +             if (ret =3D=3D Z_BUF_ERROR) /* -5 */
> > > +                     likely_buf_too_small =3D true;
> > > +             break;
> > > +     // Add more if necessary
> > > +     default:
> > > +             break;
> > > +     }
> > > +
> > >       if (uncomp_size >=3D buf_size)
> > > +             likely_buf_too_small =3D true;
> > > +
> > > +     if (likely_buf_too_small)
> > >               printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\=
n");
> > >       else
> > >               printf("%s: uncompress error %d\n", name, ret);
> >
> > This is a lot of code, why not just:
> > if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
> >   printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> >
> Thanks for your suggestion! I am not sure if I get it correctly, do
> you mean that we should remove the original if condition( if
> (uncomp_size >=3D buf_size) ) that prints the error message?

Ah sorry for being unclear. I just meant we can handle the new print
more directly.

--=20
Tom

--56cLX6Z2chpWH0Vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ3v0ACgkQFHw5/5Y0
tyzFkwv/eevf4QPeOoXYNOT2PQ2FbzPbu1mlVpWrky6hj2h6vtZ3GsBgPDi9jvku
1OWbve7p5nQiCCSwZ1snTrT5FwxAz7ma+o7M/Lm6vFP0uVoft+W9n8NqsHWYK4NZ
+F6tc6TyjSG0iZ6T9E/OUs4t13Vf32ZNlI7bxlqPq12sj5FBCDnDE4GjLxtDm/VH
iZI5u0KzVq7ECL5cqI3tPMwA3/mm4C/Nai5BeGlWE6iwagW8g6uFJu3pY54892Q3
GrRZTAOZpMIHik+66qRObTP/d0hXxjL1u/9X6/REoVcq3lGI3nvAf86BgqmDLTze
1t7LwVWUAFhHA6bd6BMg8j3fuo6zr4W8q32idUokbafTeRtNIiqtjsfJZ4RCki4j
cs7XD1HIcYVUb78dCOyRmK5nfewvQzQlbxYhCA/ahYfPaCG5OpI4hkR40jgBnKhA
IrNn5hchjxtGpxp4y11EYYVqJvUf6vKb0tNuRBb2RXVds98tpPMqn4XouzwH84Gs
qK5D3Tkg
=KKgi
-----END PGP SIGNATURE-----

--56cLX6Z2chpWH0Vz--
