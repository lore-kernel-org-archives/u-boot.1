Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAECCC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C9782385;
	Thu,  3 Apr 2025 23:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V8IyQdsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F5D8249D; Thu,  3 Apr 2025 23:48:56 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA0D8215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c1818c394so926035a34.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743716933; x=1744321733; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zwVBbJg4QJgTAfHqbu8UF7hFO5y9F/0cpoz5gUv+xfs=;
 b=V8IyQdsScFWBVpvAljydIZOdRLk4/edQqMRAY3ddP0tz1gIBu0n3tH0kWQ+87IV4sy
 srKojFVtMO9lJhFwfwkAyrWoMzfE/Lzlw2BJ9MpxtPvTMHIFdUN+KzXRDzpmTXpeq2AU
 80XNNAMFJAsbIdiT4bycdBRrJ4rK8RBUaUEsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743716933; x=1744321733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwVBbJg4QJgTAfHqbu8UF7hFO5y9F/0cpoz5gUv+xfs=;
 b=q4BmiIuCxyg95rf12e5bfZ24KRTnSR9Ns2d7mKIxo+6Lf6MqksiIOnoXLtUQyPzTro
 tjJHIqlf8zCf1tjUM8G1fYmlJAwYUR8oX0WwqVcmzYuj03hMnlfN4ISNYZKDdaveoRUZ
 +j0c4rhIHPpix2c+aPxD44TZ+CFMK+aPd1l0IIa8heW0KuIQntbUkzPtdcDjG7txsESz
 WpgfD5RuQv6v32OLtBFZaWeA3dcdleUqHRJD7cFap+NdNMlOm/C/vJSw5xd3+fp1l01m
 7uu9IN/AepeFUgvkdSRAKI/d1ZLIQRwlJme3O98z9rC+/XuP0Xu02CSCh677VhYphP2A
 UqkA==
X-Gm-Message-State: AOJu0YxMbemWtI9tj4nMZEJ7UfzUz87QlIwGMY29rQhhnkRpMRgR/nSH
 VnWkl0Vhgi7hLLiO7jiSG22kCwEhoFRDBXJGG3puXIlsHb/3x7zTSE14rWfEgBYbIcWvam+lxrN
 t4dw=
X-Gm-Gg: ASbGncspxXgiOdITUzJdJhmbBZVM+MnZRS5u0KmUx6xymg1PPaVLtfVzfQ9LHWWgMKq
 LwuSLn6MiAxse/SqtMmztNhxVDeHCVCBnaYvukC9RBWNeGdP8j4Vu7dtZg6DnXKZWqfNt6Mjj0H
 GUeKy6lbKGyRaWLCxMXPMZY4ZKs2SISHqFx2nU5xfevVwnxLIJPnOJMzQxBFx/X0h8vaPESK66M
 Xr2aI1xZVUflbcMlJucY3qPfgOgpV1Brd7VowxD0917hHKP1VTQEqpUUH4QoUUHASvpcPgtFnRh
 6fe0EYsJWYsl8jgpOp+BXWx8CF0+Kw1V6EqkItM67Jnt+tm0QXLBpmmQPGHzGGm9Gb2gPIEn2cE
 tbDZH6w==
X-Google-Smtp-Source: AGHT+IE1XF474mgWnfd6tH2RaHaXPJQZr9t/tSPQOy7CJVFmaX83Z80FpbZtzLmWMkxc9v7rSFS34A==
X-Received: by 2002:a05:6830:6015:b0:72a:449e:2b6e with SMTP id
 46e09a7af769-72e366b36e2mr864497a34.5.1743716932969; 
 Thu, 03 Apr 2025 14:48:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e30500de7sm390685a34.8.2025.04.03.14.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:48:52 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:48:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH] fdt: Allow OF_HAS_PRIOR_STAGE to be disabled in defconfig
Message-ID: <20250403214849.GN5495@bill-the-cat>
References: <20250403175408.2211779-1-sjg@chromium.org>
 <20250403190240.GM5495@bill-the-cat>
 <CAFLszTg-B7cx73O=TrtUTN2_862mf9Wd2MefqL0cB0PBrtrnjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JmWjCogtxLwksUjv"
Content-Disposition: inline
In-Reply-To: <CAFLszTg-B7cx73O=TrtUTN2_862mf9Wd2MefqL0cB0PBrtrnjw@mail.gmail.com>
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


--JmWjCogtxLwksUjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 09:40:18AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 4 Apr 2025 at 08:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 04, 2025 at 06:53:49AM +1300, Simon Glass wrote:
> >
> > > At present it is impossible to change the qemu_arm64 defconfig to
> > > obtain a devicetree from the U-Boot build.
> > >
> > > This is necessary for FIT validation, for example, where the signature
> > > node must be compiled into U-Boot.
> > >
> > > A proposed change to QEMU has been blocked for several years. As a
> > > workaround, the only option is to use QEMU's dumpdtb option, merge in
> > > the signature node manually and then disable OF_HAS_PRIOR_STAGE
> > >
> > > Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
> > > to hack the Kconfig. So update it to allow use from defconfig. This
> > > avoids needing to patch U-Boot to get this working.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Link: https://patchwork.kernel.org/project/qemu-devel/patch/202109261=
83410.256484-1-sjg@chromium.org/#24481799
> >
> > How about instead we do something like:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index b7311d3b754b..44e45a304cd0 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1080,7 +1080,7 @@ config ARCH_QEMU
> >         imply DM_RNG
> >         imply DM_RTC
> >         imply RTC_PL031
> > -       imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> > +       imply OF_HAS_PRIOR_STAGE if !QEMU_MANUAL_DTB
> >         imply VIDEO
> >         imply VIDEO_BOCHS
> >         imply SYS_WHITE_ON_BLACK
> > diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kc=
onfig
> > index 4c15c8bcb891..9053f2ff2f55 100644
> > --- a/board/emulation/common/Kconfig
> > +++ b/board/emulation/common/Kconfig
> > @@ -13,3 +13,10 @@ config MTDPARTS_NOR1
> >         help
> >           This define the partition of nor1 used to build mtparts dynam=
ically
> >           for the u-boot env stored on nor1.
> > +
> > +config QEMU_MANUAL_DTB
> > +       bool "Manually provide a device tree to QEMU"
> > +       depends on ARCH_QEMU # Expand more if needed
> > +       help
> > +         For some use cases, such as FIT validation of U-Boot itself w=
e need
> > +         to override the device tree that QEMU would normally provide =
to us.
> >
> > This way we don't start opening asking OF_HAS_PRIOR_STAGE.
>=20
> Yes that seems fine, thanks. If it ends up becoming a more general
> problem we can worry about it then.

Thanks. I'll let you make that up in to a more general and complete
patch, that was just me poking at the files for a moment.

--=20
Tom

--JmWjCogtxLwksUjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfvAj4ACgkQFHw5/5Y0
tyyXKAv/YJbngmyO1UllE7OuLM1Z0XMkYAqeq+L/DEAoDWRrpWseotjvyV/4xl33
ITMaTj4QpBAdGZc05pARUXO3nZpRqEqUAvEiKZ7cGmZd1vJaCs0zt8AQ8NHnIUNz
5NyPwT0G4ufbfv9LsnY3RhcdAQryHM+2n2q7svPBFdgsNezznft6tp9s53y9ceSE
wwbv1J3Dic++NHrnMfzOFW4DMte0dZXfaUFQmxxLIaxYgdhATbbu4xtq3SyeunO9
rh42quSZWGitwd5osS0USKbUnz7X1QaHqrwwYrIMMKWtF3+rE+858gyydq+a0zWu
cExjclUD4+Gx+lXdxt6/A8t8A2H0ILfG55UIZqW4nI1MdybEdi4iPHVBaN0tIK3u
nOdbVSEhWGb9Vre0YU2kPbu9FGt+rxUibU6ynG5Cr/eO5bxhFB5yo7aBw180XoVV
PlI165VIbyBsMKaZlkYGCNZ/GtFErryccwI6C5ubkIT/RyW852yfDC9XfZqEK0KR
kZL3eWmI
=zsZq
-----END PGP SIGNATURE-----

--JmWjCogtxLwksUjv--
