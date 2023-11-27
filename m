Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F5AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01D38769A;
	Mon, 27 Nov 2023 15:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cphpnRUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128DB876BF; Mon, 27 Nov 2023 15:08:19 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40C987585
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5cc66213a34so42503217b3.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701094095; x=1701698895; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tN6fPA1NOL95gmRZVQkZ3nPVMbdtFMiX0UHTgKdWNNc=;
 b=cphpnRUs5e6s+A+8CqFKUYF4w6IpWsunL+ehmbEZe4ZJ4GqKg6UIW88Lvn+xNjLLX+
 f8yp0/DDiBAzmUN5LCgaNfz22/0YAxst43Ykb425nRdPlXDChS/WIQ/afNEtVn3QaGWO
 cJH4n8OKtWMZ7qaEQDEgW9Dpc6yAkXKQjKCas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701094095; x=1701698895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN6fPA1NOL95gmRZVQkZ3nPVMbdtFMiX0UHTgKdWNNc=;
 b=fdHD89SdhmYSsti73MtNbuHIxdBPB9hIgDHdQNqhJoaTc/4GVhOPB9qkTJrTUnf1fH
 2275fw8wE0lN+31FDmjmeYwQXsaKCmi4cUTNGZy4nFEPUQsgac3DzP5anGe0EVi4Jo30
 c1oex+JUERZdNs8r3ZVI60aobarpBTj3F5zNffaGoKvCWX8oIEsNfb4xRnvRqP6yC+0d
 ZgriFZf/kPNznbPaFyV52rx7eXmbRAnp9fT/jyXHqg6Er4F31x5Sdj6b14fVR/Z9DtwH
 QLZZZewHdOpBSkhF8EC+LN1rG3Vcd/OQ5cWU7GDHK5Qnpv13jkvix0J5yN7vynHqiVtN
 QM9g==
X-Gm-Message-State: AOJu0YxpCENJO65aeI1CfZwx93pt80JQWYUqBUtHswkaxMVKc7N5FCyu
 qyO7XQDoGkaDe+KIttQHwy76Kw==
X-Google-Smtp-Source: AGHT+IHDeI/QuKddEywyBsDNzS210Ro2H14b2aKZnhUAhiUXAaLHJStHKqx1vsuTujvQlo/vSjnICQ==
X-Received: by 2002:a81:79d4:0:b0:5c9:70b9:84d5 with SMTP id
 u203-20020a8179d4000000b005c970b984d5mr9938730ywc.8.1701094095503; 
 Mon, 27 Nov 2023 06:08:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a0de605000000b005ccc70e7dc1sm3284482ywe.87.2023.11.27.06.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:08:15 -0800 (PST)
Date: Mon, 27 Nov 2023 09:08:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
Message-ID: <20231127140813.GF2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zci3Jdjdkk+lp472"
Content-Disposition: inline
In-Reply-To: <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
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


--Zci3Jdjdkk+lp472
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
> On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
> >
> > > Increase allowed binary size to fit lwip code.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > ---
> > >  configs/am335x_evm_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defcon=
fig
> > > index f048e60f7f..9fd608bd76 100644
> > > --- a/configs/am335x_evm_defconfig
> > > +++ b/configs/am335x_evm_defconfig
> > > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
> > >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
> > >  CONFIG_RSA=3Dy
> > >  CONFIG_LZO=3Dy
> > > +CONFIG_SPL_MAX_SIZE=3D0x29000
> >
> > As probably a problem for other platforms you made this change on too,
> > you can't do this. The link limit is here because that's the limit the
> > hardware (and ROM) imposes.
> >
> > You might need to either:
> > - Figure out how to make lwip even tinier for the SPL case
> > - Limit the old network stack to just for SPL, and a later task is to
> >   reduce what's in the old stack to just what's also needed within SPL.
> >
> >
> Thanks Tom. All these size changes need to be reviewed.  Some of them are
> ok, I think like for x86 or qemu virt, but some of them might not work.
>=20
> Question - Do we need networking inside SPL rather than in the main binar=
y?
> Is it a real use case?

Yes, the device supports loading SPL, and then SPL loading U-Boot both
over USB RNDIS as well as regular physical ethernet.

--=20
Tom

--Zci3Jdjdkk+lp472
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVkosYACgkQFHw5/5Y0
tyyJTwv8Drq4iqhpeneNvmHcKYrxwP2dHNe64ZnxVPE/mpQ3zPfw3ou0K5/SiJje
r3zjv7uY/2Jl8kYWBFC7pCtp6yXRXgHILE53aXISBWXO96PqHBd2UdvV5xssyoL2
NruwJh15qmoXdvsoKVOSnHAP+CQs9u/oKKpQGTFYGBGi4vzDMrVQmijUr14V08/E
UiWSLsCxpK0o60b115Wmh0JHgnJLoK0An75YuD6VNXcvKUyGvyMR5IORfrUPs7+K
AHgcsZ3Q7uKZdf7bd5vsCyGWIUCzWRnOYGHPr7skInRaoQVPsNqphFg+mOoP5Flm
JRFwMsPgbB2+2BoXqWZW4y19CZMDhTeL5y9coB2okkmobLRkAAVJA9zSBNOot8GZ
yFpHorFW2vrQwgXiKVuORz6/Hkv2ctQbo1U0mEApV5DFNyGGF09um0w5HUO7g5CW
zf6vZCBrt8WQMpxIpoRZyaDwH6YtODaGx1DH0rv9rNmPddk7Oym7j3RWM5PKREaA
prFu3381
=aor4
-----END PGP SIGNATURE-----

--Zci3Jdjdkk+lp472--
