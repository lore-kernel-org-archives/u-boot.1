Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2701CC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED2E807B1;
	Mon, 10 Feb 2025 15:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TettNuDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7937180B98; Mon, 10 Feb 2025 15:51:22 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470EE8043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f6ae4846c7so36173457b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739199079; x=1739803879; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T/uKFMnDsvUD8woNyQ26soKd/bXyi37OZBgkBu8hN84=;
 b=TettNuDYHssP859uAVpm/7oiGPtjweN7lWOckIkEI2hTfCzCqnh4WDTYY6jsOon/MQ
 wp/2iRCMuEAJp2ryoAg8JeT/tudV/j/xee9kd5Vbi5cYvXb0FtmnMD9Nvjv/DslsQnff
 uP7pzR1G6HkBmFLCyxjEfO9eYT4vpdg7U4PbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199079; x=1739803879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/uKFMnDsvUD8woNyQ26soKd/bXyi37OZBgkBu8hN84=;
 b=nxEs9vdmCySI/OzXuxExkC5/jth0Qsquk5W+jPyjeC+fb2Nfy3rTO+NtRLFxw7DUns
 Ap4g10qGhwjQ6mwgHx1XY221Fm/AVumUAEHThESZYnVX27t8gwmOUrisS1gljsE99zTu
 J8Tf49Ak8bbSG9Bz2ILSITNEn0EX4FVOSmXhEJB9RqZFsUXihmGQJdC6ashVl+GSe3i5
 2r/fikbvBgUcrWFlAhLfmUi8vJ2W/cJxhRJZP4vY5i9Vn/t5WBAxnwj79Kg2MlSCUm6V
 pRxBcvHr+ZYTQAPubsZ1+faGJVzbPrf6tQf2UJPkQ5MVw75Iki1JYwLtVsDlUF8CnPEX
 yhKg==
X-Gm-Message-State: AOJu0YzYiKLtYR/5tqZGiZ321bilAn9UPC0cZJDnNO6USzDQSkBD5KY9
 er3o+BoIHoWLawn67iRBmVBiEvuzskDv0Y6VXA7sZ/IC2zj1VWZXD7cH1+Fp1h8=
X-Gm-Gg: ASbGncsnU/mEqJQjYR+URcvD4j1JdhrQrN4yLKuxEQU1arP04hifPiDE+zPPqcJk854
 1sNIwiMFvrtMWOr/TckwNmbsKyzTJGz1NJu0NSg+m4aZyBNm8NK1Bj9w9hT69iT6MzyRy01nvIT
 fYw4gJT5ge9ybXiymc982hRjb3uejl24uqVhKV3V0wvI0lftzVK3HjLDdNgiNT7sv+COPZbZv29
 VIvaIuvgAu2gj9c+AceAZXCzzkbY/lmUoavpMbcWAYaX1n5zClWU0wvy90qyvaYBbPTyRcUI+Zw
 Wlp5GGg6SYN/VIg=
X-Google-Smtp-Source: AGHT+IGv5zsDoZ7R7NX84DTz33VnaVlsX42Et/AEBKR8dpMNSK267eVPDhxomGzvSyoQIEDOydtcSw==
X-Received: by 2002:a05:690c:3809:b0:6ef:7d1e:bffd with SMTP id
 00721157ae682-6f9b2a04e21mr138922537b3.37.1739199079073; 
 Mon, 10 Feb 2025 06:51:19 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fce1fd3sm16880817b3.1.2025.02.10.06.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:51:18 -0800 (PST)
Date: Mon, 10 Feb 2025 08:51:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 01/29] Makefile: Avoid using TEXT_BASE if not present
Message-ID: <20250210145115.GG1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-2-sjg@chromium.org>
 <20250209180525.GR1233568@bill-the-cat>
 <CAFLszTirjS5kcqGc=NV1RF_7bHhhGPyKhnfV8WyV0H2y=GCW_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fHaGiw1P4VUOQ+P+"
Content-Disposition: inline
In-Reply-To: <CAFLszTirjS5kcqGc=NV1RF_7bHhhGPyKhnfV8WyV0H2y=GCW_A@mail.gmail.com>
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


--fHaGiw1P4VUOQ+P+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 06:06:38AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 9 Feb 2025 at 11:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 08, 2025 at 10:11:21AM -0700, Simon Glass wrote:
> > > This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
> > > conditions to avoid introducing errors in link scripts when it is not.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Depend on CONFIG_EFI_APP instead
> > > - Drop change to u-boot-elf rule
> > >
> > >  Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 2f7614191a1..f989c31073f 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1050,8 +1050,10 @@ LDFLAGS_u-boot +=3D -z notext $(call ld-option=
,--apply-dynamic-relocs)
> > >  LDFLAGS_u-boot +=3D --build-id=3Dnone
> > >
> > >  ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
> > > +ifndef CONFIG_EFI_APP
> > >  LDFLAGS_u-boot +=3D -Ttext $(CONFIG_TEXT_BASE)
> > >  endif
> > > +endif
> > >
> > >  # make the checker run with the right architecture
> > >  CHECKFLAGS +=3D --arch=3D$(ARCH)
> >
> > We should just test for ifdef CONFIG_HAVE_TEXT_BASE as the second
> > condition, that's already going to be never-true for EFI_APP.
>=20
> Yes, that's what I had in v1.
>=20
> The problem though is that the ARM app does have HAVE_TEXT_BASE
> enabled at present.

How?
config HAVE_TEXT_BASE
        bool
        depends on !NIOS2 && !XTENSA
        depends on !EFI_APP
        default y

is how we define the symbol.

--=20
Tom

--fHaGiw1P4VUOQ+P+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqEmMACgkQFHw5/5Y0
tyzvFQwAnI32Kkg0tLzjSMzqF6QDy0QQLxcyT/E1n26guxVehtY5Db614Vt7Uwiw
GCg/jrOlPOOu3U64zy3M5OuNMIEz8H+1UQMq9KQ8poZ4jvHRwrhIuarxiK07TKdA
HlcA9LjFpykeKVjoJM4DsOxkql+R3agqgxJX47xXOA9Ty9j6V9qg6/Uk4auF5MKS
ogqaqyj9ZefI7bpOLLXp9V8pI4JcMHflq/qzQBu3omQ5ReQVNNPqj7iC+S3lwU89
F8u2fSleAwqRnuGzXJsuv3BaIxD1kH6AuJYh4P3kmRkEov/v5jpsGtsieqVHDKuK
NunHtmoO5GwYtTTpKpRsb353Te9FMPdlw90sm46cfzF1YFj8SnMaN8w4t9G+qYek
gw4yVX6cgFCUtt/nsEg4nk4nepK5/HbaytweqsrBE3jwqN5SsPhwDquR/CMGdb9M
2pgYdUGj/Rnu6Y/UnHoQ6AJpXGZs0YW0QjAGBBMQL/tiYMSO1p9GEUNopPx8uQ4s
3Um2dJmP
=T8VT
-----END PGP SIGNATURE-----

--fHaGiw1P4VUOQ+P+--
