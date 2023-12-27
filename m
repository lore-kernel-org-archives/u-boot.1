Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1305C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 20:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95FC8775F;
	Wed, 27 Dec 2023 21:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f5Xm21tI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACCB8793E; Wed, 27 Dec 2023 21:11:36 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8602C87740
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 21:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbfe24c91dso977835a34.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703707893; x=1704312693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hSVkpjkDHSaUiWI/+ec7YRXKxPuGiP8z+5dyuEmaFKY=;
 b=f5Xm21tIVJQ+cR43DWlHZW3roBUsWRlrSGMKcuHgNmCUgGZ8pR/ICKKXFbB+3uaMou
 FOWyOFaoiYnMp3QoOpo1dRgRA/8ow4XPjBkQViz5yikXhkmhi7TKh/aka0aQAbjZkJLV
 csLVYliF6gy7Ezk2Bar0toa3X/JSWT0ir0yWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703707893; x=1704312693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSVkpjkDHSaUiWI/+ec7YRXKxPuGiP8z+5dyuEmaFKY=;
 b=cTvSdCFKRY5D2s6sxSxOthUGCFLTs+lzxJMf+7WpFf7QVklbtDIQTpWu0rhGqd+w+Q
 P3Pru/pp2iCIjnSZCuiZ3nxc7hupR8csg6re67Ma5UPo4bA2y+acAWr6UwxcPKS3ZNAy
 2Jj7YHJsU4WOEtoWscf6JyoQWAlA0zzfZH6ibS0annbmWt/T7/Evj+WhGZigrlPUPLnv
 KDEJ/4riq22nhJMoU38BwWVlUj8CSirZ/03f5IWPKhOwfrtPlFDOcNTqBCX9irKZz6J/
 55etRg3pvdIu3DtbkYBCitbHm+wUrYaEZOnNMnQ4MfAK1SEK6zE1FB+169TcU1oQ5Umn
 eztw==
X-Gm-Message-State: AOJu0Yx4kKA2LhmOJTkq+APlZEg6Mm7XPLhf75RM++Ts81OdtoeFhf9z
 feXwEcZNv63WOnY+MvdYaqTx6g8Zfcd7yQ==
X-Google-Smtp-Source: AGHT+IG78GN03PZzg/lrm/vC2ChyesZwMK94gwXqAIzlqarRwcu1f7Q6dH+x3mRhOJwf3Jcf6yKmPA==
X-Received: by 2002:a9d:631a:0:b0:6dc:2d8:703f with SMTP id
 q26-20020a9d631a000000b006dc02d8703fmr1608644otk.14.1703707893210; 
 Wed, 27 Dec 2023 12:11:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c67-20020a0df346000000b005e7d8d6e446sm6770028ywf.93.2023.12.27.12.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 12:11:32 -0800 (PST)
Date: Wed, 27 Dec 2023 15:11:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231227201130.GV2652760@bill-the-cat>
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P7peMy5dUfYMkrTR"
Content-Disposition: inline
In-Reply-To: <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
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


--P7peMy5dUfYMkrTR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 05:48:44PM +0000, Simon Glass wrote:
> Hi Ilias,
>=20
> On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tom,
> >
> > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > >
> > > > Standard passage provides for a bloblist to be passed from one firm=
ware
> > > > phase to the next. That can be used to pass the devicetree along as=
 well.
> > > > Add an option to support this.
> > > >
> > > > Tests for this will be added as part of the Universal Payload work.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > > The discussion on this was not resolved and is now important due to=
 the
> > > > bloblist series from Raymond. So I am sending it again since I beli=
eve
> > > > this is a better starting point than building on OF_BOARD
> > >
> > > I really don't like adding another option for "DT is given to us". Why
> > > isn't adding another enum to fdt_source_t sufficient, and if we have
> > > bloblist enabled, that will look for and use if found? Maybe some oth=
er
> > > code needs to be restructured and cleaned up too?
> >
> > Same here. On top of that the bloblist has a few items in there, e.g a
> > TPM eventlog. What are we going to do? Add a Kconfig for each item?
>=20
> No, but that is just a straw man. The DT is special and U-Boot reports
> where it comes from.
>=20
> >
> > This has been going back and forth for a while. I've lost count of how
> > many times I repeated the same proposal, but here it goes again. We
> > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > are scannable at runtime. Can't we use the combination of these 2 can
> > be used to imply we expect things from a bloblist. If we want to be
> > stricter in the future and explicitly expect the DT from a bloblist,
> > we could add a Kconfig option failing the boot if that's missing.
>=20
> I would like to have that Kconfig option now, not later. In my mind,
> the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> DT must come from there, or it is an error.

Determinism doesn't require a CONFIG option, it just requires an if/else
tree where we say what the "correct" priority list should be and then
set a flag so that we can tell the user where we found it too. This also
means that we can get whatever is going to use this mechanism to
migrate over, and have less of a chicken-and-egg type of problem.

> Also, repeating it doesn't make the proposal good. We agreed that
> OF_BOARD would eventually go away, so building on top of it is not
> setting us up for the future.

I wonder if OF_BOARD will ever go away, and I'm not convinced it will
either. Unless you just mean re-naming it and making a few ad-hoc
standards more easily re-usable, which also will need to happen
regardless.

--=20
Tom

--P7peMy5dUfYMkrTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWMhPEACgkQFHw5/5Y0
tyyDiQv9G5zlp6k7PWNh6Qii+tx9472T2pRPoYz8cIRCcFdsHGwnCVj9o/B6WFf3
ftiRdI9c7EGfMhlA9TK+H9akWcv57UbZEWBX1pnNGSslEUa3HJUC01USYi6r/nx6
5iHiIk7AM8k2msR0iJhkdVYa+iwezAF/qeTkGRGdHXTvGxzkdgUf03kjkKFEt+ML
lJGB2n1JPAFppH0+qXid62lu3XXVSHjNu6yqhE1MKyNyK88Q8XBn610eS6FBbGoq
4ZWHt3QIh9AKAb1DTSJC65tJThI51zVnQcoiMtxWm7fr3V4AQboyilmQhi52uoff
SEQ+tPUIMzJBeGcnzNDWR/WY4ExYOMgRsCgMqXlrq8aeeWQfuAWwot9mh6tgMW4K
uu3wRKiHz7bZCFeKGp2gdZ2eXq48k6vcWJtMC0777G0H4LKrlYpJ8oPXy7cbNdS3
AQzFzZi38lXBgnBz6I+Y438wxL5WaNR/nJNXInSvFXxE9OwZmqljHG+kxDbuUbwQ
n3QhalAd
=a99Q
-----END PGP SIGNATURE-----

--P7peMy5dUfYMkrTR--
