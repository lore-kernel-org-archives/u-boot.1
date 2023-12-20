Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05CDC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E2A877C4;
	Wed, 20 Dec 2023 14:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uR90IruR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46ED6877CD; Wed, 20 Dec 2023 14:25:09 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFD587727
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so3966573276.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703078706; x=1703683506; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=01P/vlPdXmnLKO8P4AkPbCSG8znawYVu4i4ZC4fClKE=;
 b=uR90IruRpV/qQLV1KX9jGCpz9jiuLR09p9iAIoI9lt2NJa5Xa37msMOQrb2hiljpju
 EObKV1PXjjTBU87sXODhRRe212LqBd3acPy00Hh1WJQVf7B3uMZSuiWjImSaKBTrFC7P
 sKYjQko9tHf1BYnsW//066qXDkzIUv0V8j3fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703078706; x=1703683506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01P/vlPdXmnLKO8P4AkPbCSG8znawYVu4i4ZC4fClKE=;
 b=vlJleDmc9X1Ij9Ru8K5lXPETBCI/Hl/LORwESazrVi0Sk+6lx6hVmfYdl6koKjKbVs
 SLxy93G1SaX80RjwGuF/HBv9vyuR0U80q1iyUxEgRFr0/4T924HHYvoPbV1iQ+huZuKq
 NLCxUSdV1dMGWHxRHEHsg2/oxCd2S06v7lgrzcBQ81jRcRb6yeCqkB3ZDxN4SGQfqAjZ
 0Xa0uFVUwmVA0BbdVr3C8d+AE2nOWUjYFxVdtnHJaNESVihC3cAsKugBLfC2m99lwdV0
 ySSdjduY57+zMfppjV0xRWu1YHL04K5shXS1uCoaBIPLrWx0UFgZbTf4sJtrd4LkGQap
 3rCg==
X-Gm-Message-State: AOJu0Yyc4c6/sj+RVEl2Q9ZUysDy3fYooZZ3WY17NDWInlBDcqsouzdu
 YCSB5BE09kXySoOKeDsZ7w2ViA==
X-Google-Smtp-Source: AGHT+IHAcasPkoFJSw9UpEagF8/3GOGgjZu4MwplpeNz2Zl4M32blicQRzPvXib6d3wqnO72LyjxKg==
X-Received: by 2002:a05:6902:38d:b0:db7:dad0:60e9 with SMTP id
 f13-20020a056902038d00b00db7dad060e9mr11570414ybs.118.1703078705796; 
 Wed, 20 Dec 2023 05:25:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a25e312000000b00da05d771097sm9261596ybd.22.2023.12.20.05.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 05:25:05 -0800 (PST)
Date: Wed, 20 Dec 2023 08:25:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
Message-ID: <20231220132503.GK2513409@bill-the-cat>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
 <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
 <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
 <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9xtbXm0nk8rI0y39"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
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


--9xtbXm0nk8rI0y39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 09:46:27PM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 18 Dec 2023 at 15:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> >
> >
> > Am 18. Dezember 2023 16:01:40 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> > >Hi AKASHI,
> > >
> > >On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> > ><takahiro.akashi@linaro.org> wrote:
> > >>
> > >> Now it is clear that the feature actually depends on efi interfaces,
> > >> not "bootefi" command. efi_set_bootdev() will automatically be nulli=
fied
> > >> if necessary efi component is disabled.
> > >>
> > >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >> ---
> > >>  fs/fs.c | 7 +++----
> > >>  1 file changed, 3 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/fs/fs.c b/fs/fs.c
> > >> index f33b85f92b61..82ee03b160e9 100644
> > >> --- a/fs/fs.c
> > >> +++ b/fs/fs.c
> > >> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[],
> > >>                 return 1;
> > >>         }
> > >>
> > >> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> > >> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > >> -                               (argc > 4) ? argv[4] : "", map_sysme=
m(addr, 0),
> > >> -                               len_read);
> > >> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > >> +                       (argc > 4) ? argv[4] : "", map_sysmem(addr, =
0),
> > >> +                       len_read);
> > >
> > >As I understand it, this is setting the boot device so that (if it
> > >happens to be an efi application) it will know which device it came
> > >from. But this is a hack. For bootstd, the device is known as it loads
> > >the kernel.
> >
> > Please, consider what happens when the user interactively executes the =
load and bootefi command from the console.
> >
> > >
> > >Also it does not deal with memory allocation (nor can it).
> > >
> > >Where are we using the 'load' command to load a kernel? The distro
> > >scripts are deprecated.
> >
> > Some users use boot.scr scripts
> >
> >
> > >
> > >At some point this code should be removed. Is it too early for that?
> >
> > Yes, as long as we allow users to invoke the bootefi command with an ad=
dress pointer.
>=20
> So how about we create the new path, with the info passed in as part
> of the bootefi call? Then we can remove the call from bootstd, at
> least.

Why? It's not clear to me we'd have this information available at that
point unless we stored things to pass along at that point too.

--=20
Tom

--9xtbXm0nk8rI0y39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC6y8ACgkQFHw5/5Y0
tyxUFgv/Q3tMYCy+gu55HnbObqYRdpy8CUgQxfp50Ignyz4DFLGFL+jy8WIr7sSu
iUPzVatGfMggDwbOsqFD94eVjjHkuYVsI8CfOKatqt7sXmU23iQdyRRnNHxgADtN
0QYyVQGJBQ3AHxY4TRfguvrfaXKMp9wiDCy1V7Si4hwOsjcu73tovnx9SoMkDaTc
uvunlMkfOdLVMKa2hHePGLi+c/hGCQ/gb7XnLq4p2eoT7BUZntFBxusfaTnQKYXy
zuRbZYffOwBy5EzPwfUkwH0hPT1KRiT8t80HwynifsPDRIQT2WLapdWWvXSMibQw
lyiVHLvp02eX2idBtegLZueIZexgw8rboKVv1QJMPnoZAC9S5miir5K8CLIn1w7C
2zPl2Zkgp0f4UBdiZwIgkMoa0KLQK++ieTJscj6+NBLPTvUXQfw3TqYAij1A0dap
k05mCl5jk2zCna9o79k9XAf6KAX1YfB9NaZwVCiiEnBuf8ozgmuu5MmVt9/PChRj
T/xJaR2c
=JgjS
-----END PGP SIGNATURE-----

--9xtbXm0nk8rI0y39--
