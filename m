Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0687C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0483B81F0B;
	Mon, 31 Mar 2025 16:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ba4GNTAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3551281F44; Mon, 31 Mar 2025 16:11:02 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BF181EDD
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so2422211a34.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743430258; x=1744035058; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NVM24AKU18Zvh3ObIJPg8/8ytRp4gDo61z0C/Ed0SMk=;
 b=ba4GNTAtTTYgupF5Xfzy7mX2RjbmsnTCidsJBc0euElh8PLm9vEJT7LWPlmvwGkRs2
 v5LxuJbvTtnTxQ/2d2nTIG/I4ym613ynJpVkvaCSL5/QTZc8ntkeoEHCe/tQ3r2xODkn
 UYul/e12/VhTt6QbOBM0Y95YcomwLTD5RBP/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430258; x=1744035058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVM24AKU18Zvh3ObIJPg8/8ytRp4gDo61z0C/Ed0SMk=;
 b=DS1BGN6idT7bW2FiCJcT3hnWCFU/8jSw1oAGqst4KMw4bC90YocPNeP6nvkvpl4Zhu
 ShSJGuKEo47K2CarzJQfA8bWz3menmkfZCjTmoyRtW8TnL8Z+NiJMk2Z9RpN/8oBhbbd
 LbrmvLPC+F99lnl/uiVmRckUyH2niPtJZmdyR0RJqtk1InqXI7whr9fYHVZYuuUgt2qV
 XAayfkF6hOUhJe7rr9W6QJ7Iv3xhiOCg5W5ULnbL2RplxcEjH3duGEtVHjh0CTEMyPWF
 3bvIKnR0ub/h353STsIH3CdjwQouP4VwCihtvxvQsNhtOOsQFiqsPhwGBXpIkqjAVmTY
 Dfvg==
X-Gm-Message-State: AOJu0YxFc3c/1yZiujip3NaI2ua87naTdaOr/3xORUQRHcaaCw0g9hIx
 yCz3QnjOqVxi0qCSXH9jOmxxTXimfCFpn4PA816WZsyawhoIp4cICfUvtNUQgQRdsiOgCFsmGTl
 2
X-Gm-Gg: ASbGncvxXhipljlML/3jLykxBU9x9W9iD/Gig7Ip5SMswqF8WT4UzuyMFuAx1rzuZGL
 aoW1wOPIy3BHXYSo1hDWC8UeTAzCwcUiFUhTpqQFI3b+apOcHKnQMzuQzE3Y58rBiISDlKJwFrp
 5zNMDDm127MUtVPOfM6RpP+ZQOX7SJXS7ji8XM/1PZv42JQ/5qgG7T9WnIzHLLkXiHEzOdK+fHj
 GCTRZbl82/xpqS7HqUMOATKsSAx60wdOahVMvlByIpC4pnBUVDYsenF3NNCIB+Ozhi1kp3TzXVr
 n+XFJfHf0s4y1Cl3yFFDGIjTHMr88HUn8mwzP+6WMTPpMfYCT2F7aSqTxPnR3rASmPBiRx7aQYC
 eyNkE2w==
X-Google-Smtp-Source: AGHT+IHAXBP1X+6qvp1mCe+vH0FTlTHazedRHov8QTHoI3S8HXbtKIhz+nhtH7exjdBE35E80JvA7Q==
X-Received: by 2002:a9d:4f11:0:b0:72a:48d1:7fca with SMTP id
 46e09a7af769-72c599e19a7mr7057835a34.4.1743430257917; 
 Mon, 31 Mar 2025 07:10:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58092589sm1481699a34.2.2025.03.31.07.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 07:10:57 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:10:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
Message-ID: <20250331141054.GT93000@bill-the-cat>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <20250328235135.GF93000@bill-the-cat>
 <CAEfUkU+ECBuGjGrNra0JXq71BtWGJ4uqMfDS9qxxaFrZ9qy9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jLvRVjjZdk61otT+"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+ECBuGjGrNra0JXq71BtWGJ4uqMfDS9qxxaFrZ9qy9Rw@mail.gmail.com>
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


--jLvRVjjZdk61otT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 10:07:29AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Fri, 28 Mar 2025 at 19:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 27, 2025 at 04:13:17PM -0700, Raymond Mao wrote:
> >
> > > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > > is a default address for bootefi, bootm and booti to look for the
> > > device tree when launching the kernel.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  env/common.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/env/common.c b/env/common.c
> > > index a58955a4f42..a38e5d107a8 100644
> > > --- a/env/common.c
> > > +++ b/env/common.c
> > > @@ -16,6 +16,7 @@
> > >  #include <asm/global_data.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/stddef.h>
> > > +#include <mapmem.h>
> > >  #include <search.h>
> > >  #include <errno.h>
> > >  #include <malloc.h>
> > > @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char =
*buf, unsigned int len)
> > >       return env_get_from_linear(default_environment, name, buf, len);
> > >  }
> > >
> > > +static int env_update_fdt_addr_from_bloblist(void)
> > > +{
> > > +     /*
> > > +      * fdt_addr is by default used by booti, bootm and bootefi,
> > > +      * thus set it to point to the fdt embedded in a bloblist if it=
 exists.
> > > +      */
> > > +     if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src !=3D FDTSRC_BLO=
BLIST)
> > > +             return 0;
> > > +
> > > +     return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt=
_blob));
> > > +}
> >
> > This part is fine with me and makes enough sense, we can't do this
> > immediately so we need some check to know to do it later.
> >
> > >  void env_set_default(const char *s, int flags)
> > >  {
> > >       if (s) {
> > > @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
> > >
> > >       gd->flags |=3D GD_FLG_ENV_READY;
> > >       gd->flags |=3D GD_FLG_ENV_DEFAULT;
> > > +
> > > +     /* This has to be done after GD_FLG_ENV_READY is set */
> > > +     if (env_update_fdt_addr_from_bloblist())
> > > +             pr_err("Failed to set fdt_addr to point at DTB\n");
> > >  }
> >
> > I don't know this is the right spot. This won't work when for example
> > the environment is valid but stored in a file on FAT (or whatever) will
> > it?
> >
>=20
> I can add invoking 'env_update_fdt_addr_from_bloblist()' inside
> 'env_import()'. It should work in all the cases then.

That's probably closer? I'm not sure if it will or won't be a problem on
say re-import with "env import .." in that case, so please check.
Thanks!

--=20
Tom

--jLvRVjjZdk61otT+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqomcACgkQFHw5/5Y0
tyzs6Qv/eVNSYCj3lZKAZYW3N4BhJ0gnw1NQwm0Oaa0J6yN/0GyEMb8av5EDe90X
OoHLBN2JiAwBXaHHhEWMBiXB058m6U6X6k+mjjtWSXvitRFt6KuPnbvtZEWB4/oQ
p8WnLaaXkv3lzNRRNGULw81XTx6HBYRQns3YA+bNR8rhDhcUSpkVtf4GHUlcdCFM
J09S8LxWu88+VvXrD1nxUNrDFiT87IeaWUmLqo9BEZs/3JIAAzZDTsNhKqVh8i4C
9+usaC4MAQYG6dvopAbc9voZGkaa1TtrCNAtB2xjD/4SHGjnXB4OE1cUbNr/f7G+
+0eKfxWtfiRXxnKLMqG0tDmiAiHt5ABr3b6jEG97PLkn8wAywPJGWooVupCcBhHu
7YXtpXl4vRkBw4zx3IJo0wZSDsjz/jHEJdwkQT+czhkQiEec8vs+qLd8v7lfV4ix
AUnhzd5Iv0fET/sr++swfaoUNF1Vghut+syuKn/wQQke+fPSsZAGut/iE4Oc9L8b
SRyd4LE3
=LTBq
-----END PGP SIGNATURE-----

--jLvRVjjZdk61otT+--
