Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0CAEF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75A283AA9;
	Fri, 13 Feb 2026 21:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GAwq5XPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7218383CB5; Fri, 13 Feb 2026 21:29:15 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0230E83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-463a94f8475so408979b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771014552; x=1771619352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UDqdbM5Hg87+YRWrmUCdVq80eviGK1Y8LtiC3xbnvPM=;
 b=GAwq5XPS0BF4PsTKFLysPQBenmGYQTXcOdEtOcpLqZdUa/xFqeG6TvlpdBkGKiNxKR
 SVj6UXpMJQi+OHOOpUM8tHl+sRoli7MJUItkhj0R2TrgcDMsrl0gmV7z9uT9s0HxKJh1
 nRudYfbNui5XFaXbFCs/xo+bN8vJ6/B5P2e1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014552; x=1771619352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDqdbM5Hg87+YRWrmUCdVq80eviGK1Y8LtiC3xbnvPM=;
 b=VzvIVmgpZfLtkdRekrWTC8WK7Zxc2NFrh5eliK02cKJyT3hvnFgVI5z7jsG3NRAFgG
 6N8ZUuUFbVAPcde6FIjgumy8S3Ry45bUMTBAaXeDJSiw9R2sQRkyeBgTRI767EKxDDKv
 93VucgITdDJUvz0DxEF+p0dG0pdoE8K19bpi0CGWgNHqkK2Qv9AuXoKP5TZvDW/7OIGQ
 oYj3ZlmgqG2iQqshkf74HQLDRDXyxXnIIVEFsb3IU7BDRpZjGi4MrMttGrVl0OVIuuH5
 Nxe1tOcHFPpkLIbE8ZnX9oGO2XqXqFiqhpVvlsvWIrmWffJOhuEo4VjiDOcIaJY0xdX+
 nWVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNX1uNUupDqyPsGXDzEzvyz6mODGRmeJJWkWtUfc4NoeYoIqm5UrTNHg+IjHibRfzuAhttX/M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf41vbrGkrDR9i8rLAWOlLxIyxmHGcn1p5jKai0a25sNVPPqC7
 x57M1kv2cgvOhIN6cjfWq482QbOS/Z990d73MMZAOSu5ymRZy1gvtH9IOgmiOL5pjuw=
X-Gm-Gg: AZuq6aKzFnLU3OajhPjv0PSz6qMzVduc/RxD2nKEyHwwt+ummHBe0UtD2s0gRpSLjGD
 slBv69nFsJ1QOC8fSXdfpikeXTWCpCQVoRT+VKahXA4SNJTt6c12Tw2VX9lub6Gi47ye/qHVKlU
 3+aoam0dDsTnrG7dMJgue/+1nkSOHtwEq+gFjGjNeVFjhXppr1gcvFBZPBFCAd/DrqOnbj1+OIL
 eSz7qhvmmCLT1brevmjOW3PV4v9Vn8snTnIGtYDPxDcye0eipHMppTPVtttq2B5FeoeByZVcjT3
 Hmhkp78IX03OzPwAvoGg7vAy2s3uGCmCt9NQ/ip+08T+bfVXYAV2ziFXocyOFkrhHYMHp/GJSHo
 wk6GVw7229BkhpntTrkJBhESNUh/ceo9qDyQxbhXUzPIrRqNsfN2sPcnF35MJNXmUKPvHfIvllA
 JuVDbjWWTc4jLztzEJwru6lMsZMSKpmBpsQuucU13bxepYLVq4pykiEUd4QJq/W0tBMfnRJ2K5C
 wFEVBe3D09lqsxAIaENc9NDR5M3RxTW/qcgbCNNO2Mym3qm9FL2OnK90sapHw==
X-Received: by 2002:a05:6808:10ca:b0:44f:f025:303e with SMTP id
 5614622812f47-463b00359bamr848758b6e.6.1771014551604; 
 Fri, 13 Feb 2026 12:29:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40f062ee328sm1071820fac.4.2026.02.13.12.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 12:29:11 -0800 (PST)
Date: Fri, 13 Feb 2026 14:29:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Francois Berder <fberder@outlook.fr>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
Message-ID: <20260213202908.GM2747538@bill-the-cat>
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
 <20260213165658.GJ2747538@bill-the-cat>
 <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
 <20260213180100.GK2747538@bill-the-cat>
 <CAFLszTgFvec5DTx_c-TF0nAVAitp5MLX6aqgxoCoko0Lw4tqCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lA9O6W+b9iTyCi3T"
Content-Disposition: inline
In-Reply-To: <CAFLszTgFvec5DTx_c-TF0nAVAitp5MLX6aqgxoCoko0Lw4tqCA@mail.gmail.com>
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


--lA9O6W+b9iTyCi3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 01:19:54PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 13 Feb 2026 at 11:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 13, 2026 at 10:53:25AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 13 Feb 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> > > > > On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> > > > > >
> > > > > >
> > > > > > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > > > > > Free buf if spi_flash_read_dm fails.
> > > > > > >
> > > > > > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > > > > > ---
> > > > > > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/s=
f_bootdev.c
> > > > > > > index 017a74a3016..720faf51a1f 100644
> > > > > > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > > > > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > > > > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice =
*dev, struct bootflow_iter *iter,
> > > > > > >
> > > > > > >   ret =3D spi_flash_read_dm(sf, env_get_hex("script_offset_f"=
, 0),
> > > > > > >                           size, buf);
> > > > > > > - if (ret)
> > > > > > > + if (ret) {
> > > > > > > +         free(buf);
> > > > > > >           return log_msg_ret("cmd", -EINVAL);
> > > > > > > + }
> > > > > >
> > > > > >
> > > > > > can we use a devm alloc method to get rid of the extra free han=
dling?
> > > > >
> > > > > No, because this isn't the kernel and devm alloc doesn't always f=
ree
> > > > > here. Making that no longer be the case (always freeing) is on my=
 list
> > > > > to look at doing (drivers that use devm alloc always implys/selec=
t'ing
> > > > > DEVRES).
> > > >
> > > > We've since changed so that devm alloc does behave in U-Boot the sa=
me as
> > > > the kernel (except in xPL phases), so Tudor's suggestion is a good =
one.
> > >
> > > I still like the idea of having this patch so that others don't hit
> > > it. Does it show up as a leak on any code-analysis?
> >
> > I'm unsure what you're suggesting. If we can switch these to devm alloc
> > functions now that we match the expected API of the linux kernel
> > (outside of xPL where we don't care about leaks) we don't need to
> > manually track frees here.
>=20
> Yes I understand that. But it still looks like a memory leak. Does
> coverity flag this as a memory leak?

What we have now, or what devm alloc does?

> Also, most boards do in fact leak, if this is correct:
>=20
> ./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
> 132 matches

That is not, no:
$ ./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
1389 matches=20

--=20
Tom

--lA9O6W+b9iTyCi3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY+JkQAKCRAr4qD1Cr/k
CuoRAQDT7fvLfxKhYSzhWoAwjy5V1+u5+OhUQZlozi12MEvucwEA+3XoJJHHwmbZ
MlGcc+6hv+R+g00kAPA8tlsm5NE0VQk=
=6/2S
-----END PGP SIGNATURE-----

--lA9O6W+b9iTyCi3T--
