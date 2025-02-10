Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10963C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 17:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4928D80A55;
	Mon, 10 Feb 2025 18:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PVePE/Ql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E8A80AE5; Mon, 10 Feb 2025 18:06:56 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6725280821
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 18:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6efe4324f96so39740117b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 09:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739207213; x=1739812013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ThDmQyVu7MpFZiRVoiSV4DU8r9kIAKshrVbsAN1glH0=;
 b=PVePE/QlJ0UzIqcYGHLYtHV6N5wE0C+PBELbvksdYsNeOdYU1bVcRaEd0mE2PB3VtY
 hZ+DW7Wmd7FRd69PPLFBlr39aRX2UvYJ9e3l4DqvrFM0s6JhLcBIcKDjDfV3ZjAEr3SS
 B5QOT+iX7lYzj6tMCtR3siTr6i2sZSf/CcGsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207213; x=1739812013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThDmQyVu7MpFZiRVoiSV4DU8r9kIAKshrVbsAN1glH0=;
 b=NzRjeP/+xbkUqTtpCpejB4ijYK+jE7VW5CddhXMqOHx/vH72Be/H3sYX0JCUU6z1M6
 By2LJNTqv95vxPfTbQVfOmW11/BAjwjiarB++szNgPw5HSDHDGXPbLoYpBPCkT4eg/xM
 JLp8M/VnFfxYuAakuolMkJt/iAMI1iGqC36thW5AD/GJxQ7IbNe2ge0SRSHNguNiD6EX
 YJ/M6i5zYmxDBJ8xJPUuzNRtAtvB/1DfaKtJuKAo8WsC9GIEswrC9UKKpuh7maiP8CQ9
 9A0TuCReqCsU/zIwWVv21GhBgelraPLr2rWH2x3Cub/A3oE1uvRuOSXrDKQmoy2VEt51
 PCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWIxv00g6LqvfBFH6hqLzjt57BtIisBOnoSeopqQJ5MrnAw3NiTxDeVVuuaC7Qn9mvlOPvKO8=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ2eVOjfQURCJ2fd/h6sutxouHjgnXD+Fdxa5ni0RIOUwYNS82
 fUdpEtygm8RKN6K3H48k8ArCzJ3aVhf1+WVWd7XXoBJVYX2/nfGmypkgeKmOZJmZqexpnA/tCNf
 W
X-Gm-Gg: ASbGnctLpfNIbbQrTCp/hEu5K0ocFhPditeUjg7Zoe8dCND00znrPgVboisE2nJw3LB
 5uIWfjKfRI0l1kQutdR+aHJHIMRsEb3mtKS7isdtTkTm6o+XzpPos0XZVFVeE3QCdu9UJVTMz9K
 on5CjN6qJ61riuNQ3IWpgTCg3ddmfuFiC1C3BguNOeiasyK9QaE/jir6ShU45PJ7Tic4lXpZazq
 HnlE3kj9tmrpzFdgvbej13XFCyBOHxvZVbd+82kMexqwGMGSx7LFdeBi/AzKgOa94XqUdm1rWkv
 1PclnYJj5QpId+o=
X-Google-Smtp-Source: AGHT+IFnph3OAZM/9m+t20Ndbjwg+CagWK1AkjAaMaWbHUxJf9BWqzjhzzjsqHM7mkfv7JssPnW6gg==
X-Received: by 2002:a05:690c:4804:b0:6f9:9cd3:7f97 with SMTP id
 00721157ae682-6fb0b48d722mr5878967b3.13.1739207213179; 
 Mon, 10 Feb 2025 09:06:53 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1f1f7sm17424097b3.43.2025.02.10.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 09:06:52 -0800 (PST)
Date: Mon, 10 Feb 2025 11:06:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 05/29] rockchip: Allow RAM init to happen in SPL on rk3399
Message-ID: <20250210170649.GP1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-6-sjg@chromium.org>
 <d6eb6aa3-8b38-4bf0-942f-ffc8a068e444@kwiboo.se>
 <CAFLszTi3VMhdX=n8GvvG3ZW7=oy3Eac9KaSBaCaBi7m17e0gfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2gv2ckWQWx0ifx6n"
Content-Disposition: inline
In-Reply-To: <CAFLszTi3VMhdX=n8GvvG3ZW7=oy3Eac9KaSBaCaBi7m17e0gfQ@mail.gmail.com>
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


--2gv2ckWQWx0ifx6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 07:26:38AM -0700, Simon Glass wrote:
> Hi Jonas,
>=20
> On Wed, 5 Feb 2025 at 15:18, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Simon,
> >
> > On 2025-02-05 02:54, Simon Glass wrote:
> > > TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
> > > want to be able to update the RAM-init code in the field.
> >
> > If I understand your description here, you mean that both TPL and VPL
> > are meant to be "burned" onto the board and not intended to be updatabl=
e?
>=20
> Yes, that's right. If you look at [1] and click on 'vbe-intro' there
> is a diagram that shows the flow.
>=20
> >
> > Is this a typo or do I misunderstand something? Else I do not understand
> > why you would need TPL->VPL->SPL, please explain.
> >
> > >
> > > So when VPL is being used, init the RAM later, in SPL.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockch=
ip/sdram_rk3399.c
> > > index 6fa8f268770..9ac16dfdc71 100644
> > > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > > +++ b/drivers/ram/rockchip/sdram_rk3399.c
> > > @@ -194,6 +194,7 @@ struct io_setting {
> > >  static bool phase_sdram_init(void)
> > >  {
> > >       return xpl_phase() =3D=3D PHASE_TPL ||
> > > +             (IS_ENABLED(CONFIG_VPL) && xpl_phase() =3D=3D PHASE_SPL=
) ||
> > >               (!IS_ENABLED(CONFIG_TPL) &&
> > >                !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
> > >                !not_xpl());
> > > @@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) =3D {
> > >       .of_to_plat =3D rk3399_dmc_of_to_plat,
> > >       .probe =3D rk3399_dmc_probe,
> > >       .priv_auto      =3D sizeof(struct dram_info),
> > > -#if defined(CONFIG_TPL_BUILD) || \
> > > -     (!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> > > +#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
> > > +     !defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
> > > +     !defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
> > >       .plat_auto      =3D sizeof(struct rockchip_dmc_plat),
> > >  #endif
> > >  };
> >
> > These two conditions are starting to get ridiculous.
> >
> > With "[PATCH 24/29] rockchip: Allow SPL to set up SDRAM" you are
> > depending on TPL_RAM to decide if RAM should be initialized. Maybe that
> > is something we can use here to simplify?
>=20
> The problem is that TPL_RAM means that the ram driver is present,
> which isn't the same thing as actually doing the RAM init in that
> phase. If we had a Kconfig value for 'phase' then we could perhaps
> have CONFIG_PHASE_RAM=3Dtpl or something like that. I plan to get back
> to my rejected XPL series soon and that is something I could
> incorporate when that goes in.

Please note that if you're going to revisit the "XPL" series I rejected
you need to do what I asked instead or there's just going to be a larger
gap between mainline and your downstream fork.

--=20
Tom

--2gv2ckWQWx0ifx6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqMiUACgkQFHw5/5Y0
tyyRwgv9FPnzL3j6R5T40OgxbiScCTb+lunaCiplFk/VH5Ct5YlKZygWZg/PrjxH
x87gD6Rw0rafaWgZalqKdioyHjKf8n/f4UPpTW407OMj/pMFHtOBwsz4/F5aFLOo
VHYQyHvJcuEYcr4N3eZM8cuayTlzp3M64VvGRJbpQjPv0shfYQo9seAZIhBJ0k4O
MsEMNhhAVCTIM6P0pUQmQ0TjUIFtHrs95ctjoptzpfrwyfVS4qtcgLbrJARu8fP1
ufsVZMFRgFoPjqAvsF9cSFX6Y+elih0xXnK1eGx1E5Lj4ce2isz8sUBCaJVVcmZ0
j2XvFLO0CMoF2+exDyjJYfmFW5mTB/PczYbs2yC2NLbWPpg8DZbLB9wbP1Qfmhh2
BmUD6L23hm6RbNsvcRB2adCohxApqlxlfvXfT0Kqd9Qd+SkhAzHai6tR0b/3VcfS
VVCj0U/QM1r3pKP1WiOKrUnTaNqHX5tybjW/AFWD3nI9vxSrIIwBdjEqf3kaulSC
tl01mbEx
=11md
-----END PGP SIGNATURE-----

--2gv2ckWQWx0ifx6n--
