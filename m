Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA26C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F2887258;
	Tue, 21 Nov 2023 19:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eU9Q+Y54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076E587258; Tue, 21 Nov 2023 19:12:19 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DD687590
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-66d122e0c85so20385846d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700590336; x=1701195136; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sKkq8rNINxTumRmwR4Xf3NFdvuSHLLiLHMUOPFPEhu0=;
 b=eU9Q+Y54kG/EtuPc1cRmOUWUlM4vNrANlVbImC4M4k3B1tv7t4FQQmujKSr7ETLOXU
 iyICJ4xCC3xABaUwWWF9gAez4Ns4p2T87cGWG/jB1bwHTzCGqZLmiBykTDfOfIpwS+wM
 eTf1Nwj0dC5WFcg+DYTIOdmmHgVMfSHq4tch0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700590336; x=1701195136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKkq8rNINxTumRmwR4Xf3NFdvuSHLLiLHMUOPFPEhu0=;
 b=SK2h4KethoE7VHfVHbiVHx4LI591iZkGSYplrkoiqXX4K2NEdnO2usRC24JIkDzKg1
 0k/QUKzRsd2wy7/mjC/wzFqCR+Eb2NpUfyUEv1hqNNMnMm97jtvinkCdv7XaOpGD8MFY
 pEf0bA13lxhPi9QdO6KwjG6A/C0NIq160LoLuvQhLydAgNScHE+eRdhlYsxoMObHTIb4
 uk1C6FyH9vvy+3kji0DcRWQRSpAUmxCY9jhb0JLN80jILy5X/2EljNm79MwYVqpaMPPG
 L3z7t7h6MBZkccpz98Hh+jxfQu+gQQTmL0ram34feLwiYE3CWkwpRH51QKLRhdIZOeE9
 LDLg==
X-Gm-Message-State: AOJu0YwgPUbCbRXKDiDyH8hmDTVfj2IH0QM2QKc4O5pcpHPXgrnXDFal
 9Z6i8BKFuhHZrNz7Xom81zDaiQ==
X-Google-Smtp-Source: AGHT+IGhgmoJDxesEtdehQGVwcZIPv4h6IoxujVN0KFJSbWEjh3ayy/nRs7VDbdplaJx1QqiE6czjg==
X-Received: by 2002:a05:6214:d89:b0:658:8f94:5e61 with SMTP id
 e9-20020a0562140d8900b006588f945e61mr13346171qve.43.1700590335734; 
 Tue, 21 Nov 2023 10:12:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a0cedc7000000b00677fb4dcabcsm3710340qvr.11.2023.11.21.10.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:12:14 -0800 (PST)
Date: Tue, 21 Nov 2023 13:12:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/29] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Message-ID: <20231121181213.GY2513409@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-3-sjg@chromium.org>
 <f5201167-c4a3-4867-ae9f-6110f685652d@gmx.de>
 <CAPnjgZ1X7k2THgD7-os04OXyrPgYwp+GgdQdtWvXg3s=ZjJnkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tb6eyf6xS5+6r60S"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1X7k2THgD7-os04OXyrPgYwp+GgdQdtWvXg3s=ZjJnkg@mail.gmail.com>
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


--Tb6eyf6xS5+6r60S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 07:49:32AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Wed, 15 Nov 2023 at 03:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 11/12/23 01:08, Simon Glass wrote:
> > > The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
> > > condition from the code it calls. Use the same condition to avoid a
> > > build warning if CONFIG_CMD_SAVEENV is disabled.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   env/mmc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/env/mmc.c b/env/mmc.c
> > > index cb14bbb58f13..da84cddd74f0 100644
> > > --- a/env/mmc.c
> > > +++ b/env/mmc.c
> > > @@ -495,7 +495,7 @@ U_BOOT_ENV_LOCATION(mmc) =3D {
> > >       .location       =3D ENVL_MMC,
> > >       ENV_NAME("MMC")
> > >       .load           =3D env_mmc_load,
> > > -#ifndef CONFIG_SPL_BUILD
> > > +#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
> >
> > According to README CONFIG_SPL_BUILD is not defined for TPL builds.
> >
> > I assume that we don't want to have below fields in TPL either. Please,=
 use
> >
> > #if CONFIG_IS_ENABLED(CMD_SAVEENV)
>=20
> I missed this comment in the new version. But note that
> CONFIG_SPL_BUILD covers TPL (and others) as well.
>=20
> It is a bit confusing. Perhaps we should introduce CONFIG_XPL_BUILD to
> mean anything other than U-Boot proper?

We can see if something like that makes more sense as we further
separate out "library" functionality from "command" functionality. We
might swing back to needing to save environment changes from the
non-cmdline use cases all the same (assorted canary type environment
variables, etc) and be back to needing to tweak this differently. So
what's here is fine with me for today.

Reviewed-by: Tom Rini <trini@konsulko.com>

=2E.. and just put that on the next iteration of the series.

--=20
Tom

--Tb6eyf6xS5+6r60S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc8v0ACgkQFHw5/5Y0
tyyfpgwAgmLyucQucL+eLuT8wXPwUImI8svecv9YwmEbXV15jmmbISRGwUolkXHg
RYE1SYzawHeONLJTN4EqOS17PJnIYl+4z13+n4Pe8K7clpib5gvYsun7B48NcJkq
wbdvLjqeaEQku5OJLEecko67N8gT0wgjiqaqTIvnqjeKHc07jipJOujYOzG0jiVM
i9+OUq47Kre6IypUhNeFnnMbAB+n5k7w+YAfE1rLrBbYXdRgtZtuG2CJfYGOrfwh
QIiDsvviDrDdRj+hK3ZFz79kzmxQadha1kUoMySciek4/bwYiw9ajiueFlgu199p
Qaa0IBYlfiURAILpp7lY+jRYJOyi68I0BoSDzD7YONCXUnOFyyoPNdEKLuNIGIoT
1Bez3ysApSQWyl7tvLsaWz6bfb/kYWzb0QGtVPxqFoFvGulocJpcocTTwTTTQ9v5
P8dX6UfroHTmPhZ7ktvjZKKr1U8D8JQ3E7ZkeWEB2T46dNuIs3hP3/QgSMtf00Qu
2DadFIdh
=A8gY
-----END PGP SIGNATURE-----

--Tb6eyf6xS5+6r60S--
