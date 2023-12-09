Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3530C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF3D870FF;
	Sat,  9 Dec 2023 19:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E1nvecck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A915A8764C; Sat,  9 Dec 2023 19:20:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7DF8269F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d279bcce64so28963097b3.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702146025; x=1702750825; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VnBPibyJdH7hS5w0DPYhUvGXZAOVk9AMXzv/mT/Q4fE=;
 b=E1nvecckY4cJ/6F8jYviJWSWtqUJ4JlotHF3W7Bg8RlKJ6RfoeJi/FSG92WhIClZrl
 lm3jO+/uYyLEBz7QSj8G7uNyTnW7eyK/nSaF3wt5vMw67wRUiu+ATE5WIF2Y+Ij+rRNP
 nnyoEkq9LHHGS57KJbe8Flvfy5ANS+yO+o/og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702146025; x=1702750825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnBPibyJdH7hS5w0DPYhUvGXZAOVk9AMXzv/mT/Q4fE=;
 b=lCGyuDdcrSYi0g2Ek4dNzfiaqf2ONqfH27Ivtk/tuRHzfV1+4GsvZgewjR+A/RaMBJ
 0HMNaW09H2Nr3glz5Lwp3sur+fJtSHzfgY1qflkjtyynDLe7pKKzPtRhEukRBD0TlI+M
 e5/AZeuxKt4Xo3l4XG4eX4tIJJ4Tblu+7CUz0sSuk/8geeRZnidh1EJO2PEP99J03xKk
 jH7L+lcQM5J30s3sJE+xhf7PDKJjwtfyzFH1+lUKAjAqz+DeqMmdrQyXHUZXKlA7Gzwz
 vruHybIYIAYDzV40/5cBwMBNVWqE5xVcl1ExClt4gWxxhAazwNagMPLyKa8HhywokkOZ
 qtnw==
X-Gm-Message-State: AOJu0YwMJgMrgjgsECZBnKxFaLMyJ+4xVr/a5chuUqm6byPB6wCX9LmF
 QEjlHMnbS20xKUGD873Zc001eQ==
X-Google-Smtp-Source: AGHT+IHVw5e3ARUXyvIK2GZKi7qsDrlqLQd63acCh4lapIw7d9QvpY3FXkgH5KhLIG9uVGGTnrcW6g==
X-Received: by 2002:a0d:c486:0:b0:5d7:1941:2c2b with SMTP id
 g128-20020a0dc486000000b005d719412c2bmr1502768ywd.88.1702146025171; 
 Sat, 09 Dec 2023 10:20:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a0dd707000000b00559fb950d9fsm1644290ywd.45.2023.12.09.10.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:20:24 -0800 (PST)
Date: Sat, 9 Dec 2023 13:20:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 08/14] fastboot: Remove dependencies on CMDLINE
Message-ID: <20231209182022.GS2513409@bill-the-cat>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-8-sjg@chromium.org>
 <CAO5Uq5Tow3D1THezrX5bFhM+0n+Dd8=ESQA5owHLLERMCjKkRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aEaSMy5+j+jeGivd"
Content-Disposition: inline
In-Reply-To: <CAO5Uq5Tow3D1THezrX5bFhM+0n+Dd8=ESQA5owHLLERMCjKkRQ@mail.gmail.com>
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


--aEaSMy5+j+jeGivd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 10:27:53AM +0000, Alex Kiernan wrote:
> On Mon, Dec 4, 2023 at 1:31=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > It is possible to boot a kernel without CMDLINE being enabled. Update
> > the implementation to handle this, and drop the condition from the
> > FASTBOOT config.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  drivers/fastboot/Kconfig     |  1 -
> >  drivers/fastboot/fb_common.c | 26 ++++++++++++--------------
> >  2 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> > index 11fc0fe1c800..837c6f1180da 100644
> > --- a/drivers/fastboot/Kconfig
> > +++ b/drivers/fastboot/Kconfig
> > @@ -1,5 +1,4 @@
> >  menu "Fastboot support"
> > -       depends on CMDLINE
> >
> >  config FASTBOOT
> >         bool
> > diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> > index 07f5946d9ed1..85935380e79d 100644
> > --- a/drivers/fastboot/fb_common.c
> > +++ b/drivers/fastboot/fb_common.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <bcb.h>
> > +#include <bootm.h>
> >  #include <common.h>
> >  #include <command.h>
> >  #include <env.h>
> > @@ -144,20 +145,17 @@ void fastboot_boot(void)
> >  {
> >         char *s;
> >
> > -       s =3D env_get("fastboot_bootcmd");
> > -       if (s) {
> > -               run_command(s, CMD_FLAG_ENV);
> > -       } else if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
> > -               static char boot_addr_start[20];
> > -               static char *const bootm_args[] =3D {
> > -                       "bootm", boot_addr_start, NULL
> > -               };
> > -
> > -               snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
> > -                        "%lx", fastboot_buf_addr);
> > -               printf("Booting kernel at %s...\n\n\n", boot_addr_start=
);
> > -
> > -               do_bootm(NULL, 0, 2, bootm_args);
> > +       if (IS_ENABLED(CONFIG_CMDLINE)) {
> > +               s =3D env_get("fastboot_bootcmd");
> > +               if (s) {
> > +                       run_command(s, CMD_FLAG_ENV);
> > +                       return;
> > +               }
> > +       } else if (IS_ENABLED(CONFIG_BOOTM)) {
> > +               int ret;
> > +
> > +               printf("Booting kernel at %lx...\n\n\n", fastboot_buf_a=
ddr);
> > +               ret =3D bootm_boot_start(fastboot_buf_addr, NULL);
> >
> >                 /*
> >                  * This only happens if image is somehow faulty so we s=
tart
> > --
>=20
> Doesn't this change the logic? Previously if you didn't set
> fastboot_bootcmd you'd fall into the bootm path (if CONFIG_BOOTM was
> enabled), with this, if CONFIG_CMDLINE is enabled then you will never
> hit the bootm path.

It's a subtle change in logic I think, yes. And also, we should
document (perhaps as a follow-up) what does and doesn't work in fastboot
today that depends on CMDLINE and parsing / executing commands as set in
environment variables. As with this patch yes, fastboot does not require
CMDLINE but it is also not as functional given that as I understand it
anyhow "fastboot_bootcmd" isn't just "bootm ..." but can handle various
state things and LED flashing and so on.

--=20
Tom

--aEaSMy5+j+jeGivd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0r+YACgkQFHw5/5Y0
tyyFSgwAuHigHOCl+alDxOrMVvm7tJvkR5hKuRzFFI4HmU5fUt57V3R8blQJQ1Z3
C/A2Svmw5hj42i9+WgjjTUq68ovS6DcmskZKy5bKDuiHwcndbqkLHNt+M4C5Bmh1
KTk9cTGNZ5IqC3iL5c7JIoEW5AhnXCVwZU9WIKpEjgU32BMc8knjDFUovfArFdt1
l+118iRC52/UaXQfXNBonvLbP7va68FNopRCzQrlhYBVUFqf+6/GNZCkEda3o98f
i/oZnf+9DCc99ZbnrqIUuyJJos0/TREHtPtFSVddCcgudUA3YhtMn7vi27csfuzQ
Mxe8oEUT6A7CAtvGJ1j3GJU5LKRLJKs5VsoYrXIOxmBK03vGtT7r0kbfHiEnUhZf
VgGFGhW+sx8xffdp18+rwfRRSphbkFtNaZHC+RwanquJwqKUq8KrSyPBKvtYirRf
ry9UmgD6XHhA7aXrSevjxLPSoAKqrAHnoY7dVEbtZK5vwzAlw3Vf7hM4CuOABUeN
xotB2ZBG
=GLMS
-----END PGP SIGNATURE-----

--aEaSMy5+j+jeGivd--
