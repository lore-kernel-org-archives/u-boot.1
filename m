Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D1DE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 20:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B489D89794;
	Mon,  9 Dec 2024 21:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ozr13BdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B32989797; Mon,  9 Dec 2024 21:33:34 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B2758977E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 21:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b676152a86so582662785a.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 12:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733776411; x=1734381211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VkIh7RXqs/d75Xu1jKR+4rbrNTyDN5XY+aS81KUcWc0=;
 b=Ozr13BdF8slSHvJc+bmQfDHGOVtOo6CxL9RAePivr/uR7cM2necVlKHP6wxnaiclUz
 mH0QapQmqyuI167SGTPZqSOxZkD9DTOUi3d7kfKQgExoN60Rmk9EmnAPLeSvLes7UKce
 20Q+4mrYlo72W5gDealt2IlfwsWl3neFfr5O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776411; x=1734381211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkIh7RXqs/d75Xu1jKR+4rbrNTyDN5XY+aS81KUcWc0=;
 b=gF71j3iavv74TfNqjA6EGMvORMRKWRda97DYKVTVsgr3Xwg2dxSktdNLcUxzWNGLBc
 NExg4mJl6ZwUUnbhmcqOIjqyfWGhGMwtAaYCTAKe86nxSZZ23z6rYwUbyRKKbKuxAriu
 Mkk4XxoFVwOM/WY6+AEimE4qJp0w7xvpfWN+VYhKphDpf0lFV8iLOsExicXWozz5qhyf
 yqaJBQAzP6vI6TapY3tPbAY/Xij1wKC+QF9jebcmQqirG1CSbREbkXCofO0RGFFo96Lb
 N7ZRZ0pNh1dQQ7gM/oC/xnlLQFCKFIvhora+e3vYDu5TT8s0GDBUTqqPtb42T5v3Pe35
 +SsQ==
X-Gm-Message-State: AOJu0Yy2jKfOEDqKkoKjbgFOCIvbf7U9HQB6JBFiw/JGEnPILaE/TW+v
 MfwyYvM0hCSVgjUsNw3gOuhTIfSwwg8pYO9f84wmOIMEuql2dSbvbvaB5SetFGA=
X-Gm-Gg: ASbGnctG2/TuFZ9H+4f0Y7dIBqvtHwG0SlTNuWYpTGWFLJ0ll/UDq2oviXMDqx/EIL1
 dxeh/h/cvaFpJ47vSkYxIZfnVo2U0tK55kkbFkPhslym/OTlJ8fGXjsE+EViPeijNmkN/OnVkPe
 w2I8UGllzoHCpno8e5cfCCZZS4RYk4c/zVZ70tsaOwqibdEpSU/Bce41643X+XkF9oqDKpqmK3o
 I+9dKWYFjuLFdlVf3YoXH457OuNQ3p/cXzHGu1nxfUupjHz
X-Google-Smtp-Source: AGHT+IEw7GlsAERUv56G9RQOyd73dMgW94vpV5aj/ncvyZ7EqjKvIeMyTsK9GUVRvUTDGfJtMiLTOg==
X-Received: by 2002:a05:620a:2b90:b0:7b6:c474:d87e with SMTP id
 af79cd13be357-7b6de6dad9cmr123235785a.10.1733776410914; 
 Mon, 09 Dec 2024 12:33:30 -0800 (PST)
Received: from bill-the-cat ([187.144.7.203]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d990baf2sm85483985a.113.2024.12.09.12.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:33:29 -0800 (PST)
Date: Mon, 9 Dec 2024 14:33:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Message-ID: <20241209203325.GX2457179@bill-the-cat>
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-6-sjg@chromium.org>
 <20241209190202.GU2457179@bill-the-cat>
 <CAFLszTgqahZeBccxEt+DUGy2CivC3ed-v8Dd1qR8SZ2mfyRoow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sr/3oP6hxX44ZYbp"
Content-Disposition: inline
In-Reply-To: <CAFLszTgqahZeBccxEt+DUGy2CivC3ed-v8Dd1qR8SZ2mfyRoow@mail.gmail.com>
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


--sr/3oP6hxX44ZYbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 12:27:18PM -0700, Simon Glass wrote:
> HI Tom,
>=20
> On Mon, 9 Dec 2024 at 12:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 11:20:01AM -0700, Simon Glass wrote:
> >
> > > The fdt_addr variable is used in extlinux as a fallback devicetree if
> > > none is provided by the boot command.
> > >
> > > The existing mechanism uses the devicetree provided to U-Boot, but in
> > > its original, unrelocated position. For the rpi_4 I am using, this is
> > > at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> > > is large.
> > >
> > > U-Boot already deals with this sort of problem by relocating the FDT
> > > to a safe address.
> > >
> > > So use the control-FDT address instead.
> > >
> > > Remove the existing comment, which is confusing, since the FDT is not
> > > actually passed unmodified to the kernel: U-Boot adds various things
> > > using its FDT-fixup mechanism.
> > >
> > > Note that board_get_usable_ram_top() reduces the RAM top for boards w=
ith
> > > less RAM. This behaviour is left unchanged as there is no other
> > > mechanism for U-Boot to handle this.
> > >
> > > In version 2, it incorporates some changes to fdt_addr, etc. suggested
> > > by Tom, as well as adding myself as a maintainer.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Drop patch to allow expanding the devicetree during relocation
> > >
> > >  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
> > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > > index 9122f33d88d..8f6ab1b1b9b 100644
> > > --- a/board/raspberrypi/rpi/rpi.c
> > > +++ b/board/raspberrypi/rpi/rpi.c
> > > @@ -3,6 +3,8 @@
> > >   * (C) Copyright 2012-2016 Stephen Warren
> > >   */
> > >
> > > +#define LOG_CATEGORY LOGC_BOARD
> > > +
> > >  #include <config.h>
> > >  #include <dm.h>
> > >  #include <env.h>
> > > @@ -325,19 +327,10 @@ static void set_fdtfile(void)
> > >       env_set("fdtfile", fdtfile);
> > >  }
> > >
> > > -/*
> > > - * If the firmware provided a valid FDT at boot time, let's expose i=
t in
> > > - * ${fdt_addr} so it may be passed unmodified to the kernel.
> > > - */
> > > +/* Allow U-Boot to use its control FDT with extlinux if one is not p=
rovided */
> > >  static void set_fdt_addr(void)
> > >  {
> > > -     if (env_get("fdt_addr"))
> > > -             return;
> > > -
> > > -     if (fdt_magic(fw_dtb_pointer) !=3D FDT_MAGIC)
> > > -             return;
> > > -
> > > -     env_set_hex("fdt_addr", fw_dtb_pointer);
> > > +     env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> > >  }
> > >
> > >  /*
> > > @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *b=
d)
> > >  {
> > >       int node;
> > >
> > > -     update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> > > +     if (blob =3D=3D gd->fdt_blob)
> > > +             log_debug("Same FDT: nothing to do\n");
> > > +     else
> > > +             update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> > >
> > >       node =3D fdt_node_offset_by_compatible(blob, -1, "simple-frameb=
uffer");
> > >       if (node < 0)
> >
> > Have you tested this to make sure that assorted overlays specified in
> > config.txt are still passed on correctly to the kernel? Or do we end up
> > being OK here due to board_fdt_blob_setup() meaning that we set
> > gd->fdt_blob to fw_dtb_pointer much earlier on, and that hook simply
> > didn't exist back in 2016 when commit
> > ade243a211d6 ("rpi: passthrough of the firmware provided FDT blob")
> > introduced some of what you're removing here?
>=20
> No I have not tested what happens with overlays, but I believe they
> are handled by the pre-U-Boot firmware. U-Boot certainly doesn't look
> at the config.txt file.

Yes, they're handled by being applied to the device tree we're passed by
the previous stage and stored in fw_dtb_pointer. So checking that the
device tree has the expected overlay applied is something that needs
doing before this can be applied.

--=20
Tom

--sr/3oP6hxX44ZYbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXVBIACgkQFHw5/5Y0
tyxasAv/TImOVVRmC5t6ayU5DhobzuW+535f62GTCWx+lXXjE9F8t4d6tZhkQXVu
s6Ko4dNX4gbedFpivWZ96bz+jHtd3AufHQrl6K5xo34mAtffLq9tzuJm3GU6k4IH
cnu761dh8BxVcrnp4chx+P15FgqSc2pol8sPqlb8lcxmNhoaFmYMJ/i1lE5wmTlm
nOmWyrBMiR7LzUWOBLCWBzP1o9FS2JtsDy7g1X4PVFYylYONZ5DZC7BgG6fFOeY5
wt9S2NAQeAWitxxudkEG2G9HaQHzzYrjyxX0hYJQLMtfYlq+Fj72cBmkUjwQYiGN
s4x++zbYSFanG+kMXSjMNSgTyu+WqPiWWmOtIc4gtadHBslw49apZMncuvRs6SOH
bg5BIc96IAXbbP3rUhriv4Qt1zNY7QVp4dBp1rwDS/SzFrjp6y48KocG8AUq4G9P
p4ZZ+BMU7Rc5QxsQx+PFAcfmCwdne/hCiMF2IuhX/wqrFVFASMS0cpV5fud3tJLf
CUmKND/K
=K6tL
-----END PGP SIGNATURE-----

--sr/3oP6hxX44ZYbp--
