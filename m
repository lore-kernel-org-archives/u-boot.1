Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102F2C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 19:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803F787215;
	Sat,  9 Dec 2023 20:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="saXN40HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831A78753C; Sat,  9 Dec 2023 20:19:00 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1909A86F87
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 20:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-db539ab8e02so3449297276.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702149536; x=1702754336; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FgrG7I51pN+PKn7wXp+p+DiwK4m4BALlSOvITZ+n348=;
 b=saXN40HTD19Jq/ZTmg56rqO3gCXRmQw3C8zoKN12HNDqnvuxZkhZhljYfwny3XkDyF
 tqoZa6AgcKEYOKDH6YYUMjpfQJmb8IwVZ2eJDPUFCPUW8qPXIuQpCtjgxfxtZ/+A1VG6
 7YYoY/wFhlp0CBlqq/I+MS+NnUqSG9kczDHOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702149536; x=1702754336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgrG7I51pN+PKn7wXp+p+DiwK4m4BALlSOvITZ+n348=;
 b=BYKOPvI6wWsOMwCXgTdeKt9/5kwtfj1K6vgp52E+mAhrmi5PkwDva0LQnVLSUaGwsD
 zhdVD05DHfQ/JZ/uxHDF8ofLZaiNMt2579rcQ1oppcnvI4+xQLpWCjUvR3CmBi1mFauf
 gydwZ9cTNvDCwBjr7xJjOtibH8RXKiUgaCtAgzFN9IbHUMzrPnYagXtj8wPzgC3HnJyd
 G6maFF8hjrswWI043W9jQJwi+2hGJx7fgFT7+XzjlJHC4ZH9zeTsJfd+kHBHdq9OIdME
 8+1r33v94DeoehIEljjiTKTTQgD3WvexF1r4hSdTW/uG4pRTpXVKTcT4u+wPbsmtfjZ3
 d8LA==
X-Gm-Message-State: AOJu0YyFQvcRUED1xpNkwtjorxHygQgkCZsUP5l328s+iQR6/cwI/791
 9X5XtHNjWu35iHhFICKtVrOMpA==
X-Google-Smtp-Source: AGHT+IGp+oXWyQDTj5oDvTjFgjKOxBJA+Kea0CQGRpvCqpzfAqFwzKWUxfQnrp0Cxn8U5rls7J5HmA==
X-Received: by 2002:a25:abb3:0:b0:db7:dacf:ed6a with SMTP id
 v48-20020a25abb3000000b00db7dacfed6amr1113789ybi.75.1702149536415; 
 Sat, 09 Dec 2023 11:18:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 78-20020a250251000000b00da06fc45421sm1449213ybc.54.2023.12.09.11.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 11:18:55 -0800 (PST)
Date: Sat, 9 Dec 2023 14:18:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Message-ID: <20231209191853.GA2513409@bill-the-cat>
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QARGLhlPRws6Yhv5"
Content-Disposition: inline
In-Reply-To: <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
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


--QARGLhlPRws6Yhv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:

> Hi Tom / Kever
>=20
> On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur.com> w=
rote:
> >
> > Rockchip SoCs can support wide range of bootflows.
> > Without full bootflow commands, it can be difficult to
> > figure out issues if any, hence enable by default.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d812685c98..fca6ef6d7e 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> >         imply CMD_DM
> >         imply DEBUG_UART_BOARD_INIT
> >         imply BOOTSTD_DEFAULTS
> > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> >         imply FAT_WRITE
> >         imply SARADC_ROCKCHIP
> >         imply SPL_SYSRESET
>=20
> Can this please be merged in ?

I wonder if we shouldn't really globally default to BOOTSTD_FULL if
BOOTSTD_DEFAULTS for everyone.

--=20
Tom

--QARGLhlPRws6Yhv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0vZ0ACgkQFHw5/5Y0
tyz3RwwArBLwO9LQ6mibQhB7lOWJzpD91+Q+2zFEckOYfIEuBprdYAG8mUPF7+RT
Wd9aWs8i6xe8UTMs/dGZXJLPEsBqMbJeiCm6BQYtxZu+GgUDHBu8caHpfaFoqgpF
BYvsVkcUy86uAbZQDf09W7nVujRSnXOEGfYbFCtRxk3LP8C7RQbGvRM+bae+4SkS
ZvDf4H/8Z7D+x7HkCV2ub7eYl2+vS1z3vodtdIYwxdxLY1EaHK3DyUiwW63aCq5v
Z8lL8qd9k5oJop6vG6mtp5lm3DXKGGXnxgOlMbNQGfxCtzoym/dQFGjrRGIBMfDE
yRfW9mXwoLxAclqjzqlGhZGsTzVTYoOJujjXz8CnCjIBmZYf4M8JoHciGRXONEdf
ZSMBeuV5Ql6njBo8/i8YTyNPPSSAksGNFv1qSNgJFuR34bQQC3XpSvgLbHf4bOdM
pVlzgp5wsZqcqgsuLFhy3dl033DIL3G9zM7FwAcPTwp/Xha6cvkIAOm2iwny197p
NSpGI8ba
=5J/6
-----END PGP SIGNATURE-----

--QARGLhlPRws6Yhv5--
