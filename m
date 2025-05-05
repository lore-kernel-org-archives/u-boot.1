Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59439C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45AD820E8;
	Tue,  6 May 2025 01:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dam4qSKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE82820EB; Tue,  6 May 2025 01:43:27 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D283480079
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2d0920ce388so2426419fac.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488603; x=1747093403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/jMKlDATU1tGBsBvftufnEHu/ENGp++xDn+I+X4qahg=;
 b=Dam4qSKjTKZeYiLHfmd2mR33d+OL3IilclWPsVcHv/PjYmWWz3UQsvDTR338KtW0LC
 L1vn8eXUpbmTAuL+AE7bnjksDCoG6Yd+c5zPPD3JldP76Gee8Cpi9qB92xU7q2ZriuHc
 se62FG3sbBNfLHe54Lov4wiUCWf/TmGvmVXRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488603; x=1747093403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jMKlDATU1tGBsBvftufnEHu/ENGp++xDn+I+X4qahg=;
 b=jI9Y7utag9lwhHY/k8ilLP1IVrkkHnaam/CbbHKnObR4A7G74W+REZvUHG/TcgDnM3
 gxQLUTzu8gAfI0smIYgGlicQyJvY6HcekvfZr20WOSWZhyP2RVuIoIdlFsXyo3NXIX1K
 quu1XAytXE+BYHFu2B0lq0QhmU0vHGBj4lhWNnCiS5lOS8z0DaogQsv8RXu00eS+csny
 8+PqQZiPOHGYnAkmvTyin0gpKltG0TMBtqp8BYQ42bREDRqcywfQYohJQrFC0BsSbOiU
 TWSedTsYsAMaNeAo3RyvYM0bWz+vZbfWlPU78Ydcs5BSeUNIVSgfYA9qoARZJnC9Y4+n
 ByIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUypDq2qz33yG1p75nYFpFqGlP06ph4TxsEjzNSCJZgAOndojASi940E1Uee7s2dH3bcMAzdYg=@lists.denx.de
X-Gm-Message-State: AOJu0YyGR6iFfTbrSIkwseYTm0KSFmiIe42uvGXpJMfrvwnYPNtuL34X
 vAYqULqSteaHU9aAuO3a21gTsYverRCj2n6n6P0ehGBvLbZ+x0xdEf6N/sCi4f4=
X-Gm-Gg: ASbGncsM4HPtlMCyZLS8JOr9Zgs76hVyufVgzXf3GZN+gZRn+Xt7abVZRQV7S3icN0N
 eASpmOVNrBu3c5FFf5K+zrc0pplXMnwblBFGEs9cuX8eA+dmNuL+za59e0BqM/8bxJ4ZbUybQMo
 bl6pSXsTxESq3y/r2xnYtFHYnQSk6/u4yGZV06VSNUkB8Hca2c6Mr2j0XQbNP0w+bzbOMn3wiJW
 L0Xavg2KgEqxvMLhr6iYjSS36+4sT8IjtElXBYvOPNjN0uZVFPF9q28WKA+1Mw0IJxYfz/0jaWR
 nXfeJOe/mFeeG9WWHogPLodpYrh9tDHLqXFppkcrPtSjag+ITVYHCXFDvvh2iFPEhBjLRmRik0S
 toQ==
X-Google-Smtp-Source: AGHT+IETlOhrPoQgCXWSGGexMGvtDINz5WLUzmDRHMpsPXuXaxzMwxljhMsX1Od24JKtIB73rg+jWA==
X-Received: by 2002:a05:6870:70aa:b0:2d4:e8e7:2947 with SMTP id
 586e51a60fabf-2db3cd39a82mr445488fac.15.1746488603297; 
 Mon, 05 May 2025 16:43:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f753dcsm2277243fac.22.2025.05.05.16.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:43:22 -0700 (PDT)
Date: Mon, 5 May 2025 17:43:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
Message-ID: <20250505234319.GT5430@bill-the-cat>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
 <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
 <20250505221024.GR5430@bill-the-cat>
 <c0c51cdb-107b-4ebb-abae-8494d9fc63ae@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/5UhqLK0k5fWAJvc"
Content-Disposition: inline
In-Reply-To: <c0c51cdb-107b-4ebb-abae-8494d9fc63ae@canonical.com>
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


--/5UhqLK0k5fWAJvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 01:18:16AM +0200, Heinrich Schuchardt wrote:
> On 5/6/25 00:10, Tom Rini wrote:
> > On Tue, May 06, 2025 at 12:07:20AM +0200, Heinrich Schuchardt wrote:
> > > Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:
> > >=20
> > > > On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt wrote:
> > > > > Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 20=
25,
> > > > 21:03:
> > > > >=20
> > > > > > > Date: Fri, 2 May 2025 18:08:56 +0200
> > > > > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > > >=20
> > > > > > > On 5/2/25 16:49, Simon Glass wrote:
> > > > > > > > Hi Heinrich,
> > > > > > > >=20
> > > > > > > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > >=20
> > > > > > > > > The EFI boot manager bootmeth does not require variable B=
ootOrder
> > > > to
> > > > > > be
> > > > > > > > > preexisting. It creates this variable.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Heinrich Schuchardt <
> > > > heinrich.schuchardt@canonical.com
> > > > > > >=20
> > > > > > > > > ---
> > > > > > > > >    boot/bootmeth_efi_mgr.c | 21 +++------------------
> > > > > > > > >    1 file changed, 3 insertions(+), 18 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_=
mgr.c
> > > > > > > > > index 42b8863815e..1669cbed5bd 100644
> > > > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > > > @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevi=
ce *dev,
> > > > > > struct bootflow_iter *iter)
> > > > > > > > >=20
> > > > > > > > >    static int efi_mgr_read_bootflow(struct udevice *dev, =
struct
> > > > > > bootflow *bflow)
> > > > > > > > >    {
> > > > > > > > > -       struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> > > > > > > > > -       efi_status_t ret;
> > > > > > > > > -       efi_uintn_t size;
> > > > > > > > > -       u16 *bootorder;
> > > > > > > > > -
> > > > > > > > > -       if (priv->fake_dev) {
> > > > > > > > > -               bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > > -               return 0;
> > > > > > > > > -       }
> > > > > > > > > +       int ret
> > > > > > > > >=20
> > > > > > > > >           ret =3D efi_init_obj_list();
> > > > > > > > >           if (ret)
> > > > > > > > >                   return log_msg_ret("init", ret);
> > > > > > > > >=20
> > > > > > > > > -       /* Enable this method if the "BootOrder" UEFI exi=
sts. */
> > > > > > > > > -       bootorder =3D efi_get_var(u"BootOrder",
> > > > > > &efi_global_variable_guid,
> > > > > > > > > -                               &size);
> > > > > > > > > -       if (bootorder) {
> > > > > > > > > -               free(bootorder);
> > > > > > > > > -               bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > > -               return 0;
> > > > > > > > > -       }
> > > > > > > > > +       bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > >=20
> > > > > > > > > -       return -EINVAL;
> > > > > > > > > +       return 0;
> > > > > > > > >    }
> > > > > > > > >=20
> > > > > > > > >    static int efi_mgr_read_file(struct udevice *dev, stru=
ct
> > > > bootflow
> > > > > > *bflow,
> > > > > > > > > --
> > > > > > > > > 2.48.1
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > How do we know if the board is using EFI bootmgr? My unders=
tanding
> > > > was
> > > > > > > > that this was a way to find out?
> > > > > > >=20
> > > > > > > The boot manager must always run.
> > > > > > >=20
> > > > > > > The check for the BootOrder variable introduced in commit
> > > > f2bfa0cb1794
> > > > > > > is a bug.
> > > > > >=20
> > > > > > Well, at the time the boot manager did not attempt to boot the =
default
> > > > > > path.  So there was no point in running the boot manager code u=
nless
> > > > > > BootOrder (or BootNext) was set.  And of course before that com=
mit the
> > > > > > boot manager didn't run at all on non-sandbox builds that had t=
he
> > > > > > standard boot stuff enebaled.
> > > > > >=20
> > > > > > Anyway, I believe the thinking behind that commit is still soun=
d.  As
> > > > > > I explained earlier, I think that...
> > > > > >=20
> > > > > > > The boot manager handles in sequence:
> > > > > > >=20
> > > > > > > * Try to boot as indicated by BootNext.
> > > > > > > * Try to boot as indicated by BootOrder.
> > > > > > > * Try to boot default path for available media.
> > > > > > >     This will add Boot#### entries and update BootOrder.
> > > > > >=20
> > > > > > ...doing this all in a monolithic sequence isn't the best way to
> > > > > > handle EFI boot in the u-boot ecosystem.
> > > > > >=20
> > > > > > Your series moves the boot manager further down the list becaus=
e the
> > > > > > third step in the sequence has to happen late.  But as a result
> > > > > > BootNext and BootOrder processing will also happen late.  So wh=
at
> > > > > > happens if you have a board with two OS installations:
> > > > > >=20
> > > > > > 1. A generic Linux distro that boots via EFI.
> > > > > >=20
> > > > > > 2. Something like Armbian that provides an extlinux.conf file.
> > > > > >=20
> > > > > > Currently such a system will probably boot OS #1.  But after yo=
ur
> > > > > >=20
> > > > >=20
> > > > > This did not happen with distoboot. So migration from distroboot =
to
> > > > > standard boot results in a change that you want to avoid.
> > > > >=20
> > > > > changes it will probably boot OS #2.  And if OS #1 sets BootOrder=
 or
> > > > > > BootNext that will not change anything.
> > > > > >=20
> > > > > > So I think we need a solution where BootNext and BootOrder proc=
essing
> > > > > > happens early, like we do now.
> > > > > >=20
> > > > >=20
> > > > > As of today BootNext does not invoke the boot manager.
> > > > >=20
> > > > > If BootOrder is set the boot manager may fail because not all dev=
ices are
> > > > > detected as "hunters" have not been running. E.g. nvme scan and u=
sb start
> > > > > are only invoked after the EFI boot manager.
> > > > >=20
> > > > > I originally suggested to probe all boot devices before the boot =
manager
> > > > > runs, but users complained that this slows down their non-EFI boo=
t flows.
> > > > > This is why I now move it after all boot methods but PXE.
> > > >=20
> > > > Can we not see what BootOrder is and then ensure it's been "hunted"=
 ?
> > > >=20
> > > > --
> > > > Tom
> > > >=20
> > >=20
> > > A load option may only contain the partition GUID and the file path. =
In
> > > this case you wouldn't be able to tell whether it is for an NVMe driv=
e, or
> > > a USB stick.
> > >=20
> > > As numbering of devices cannot be expected to be stable, it is prefer=
able
> > > to use this short form of device paths for load options.
> >=20
> > Ah, OK. So could we check and if not found print a human understandable
> > error message, and continue on? I want to figure out some path that does
> > not change the pre-bootstd behavior.
> >=20
>=20
> In distroboot scan_dev_for_efi is invoked for every boot device and each
> time calls the boot manager. As usb start is only called in usb_boot this
> will result in behavior that is as non-compliant with the UEFI
> specification.
>=20
> We should reach a behavior that complies with the UEFI specification.
> Not changing former distro boot behavior is not a valid option.

Can we also not figure out some way to boot promptly? I was thinking
something along the lines of if we know BootOrder (or similar), we try
it. If we don't find it, we try again a bit later on when we can run all
the hunting that might be slow. If the only option is slow-but-compliant
I feel like a lot of use cases will opt out of using EFI boot instead.

--=20
Tom

--/5UhqLK0k5fWAJvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZTQ0ACgkQFHw5/5Y0
tyzB6gv9E1db3cAyah5NZEDqfzMFQ5PFpl63AVC919+mTcXeIXtTYd6s2LeEDKZE
OC2j1HE3mv0+n91Te5m6B1fJ/ZAM3StMWjfKGhQa9zGM/0G2teFc+S/OojQnaoss
fJ+klAlQKq4EsKJuElRToUzuSsiTRr8HGK7o2JoOPzFgzlnvyQrSzKetrVigl8OR
KKgMsRKq1DquSlYfNhaE5o/KTRYCjfZtfXvmU0/3cVgMRJlO7q4Rr+6ZywPh+wcb
xt9VQs+U2B0SAcXla/jIhGlX4LFaMJhw3bqNQtrYb5O0NEJXfUzasmzOBZ6g7KId
zt7HwGW3qVHmB+DSCzNziKRyeJ0zO6LrMzvO9SGo/zZ9U6Hbv7dtf1MCe7/6zX6P
yFGC67qwtqQIbcMs35p2UnpE+8Bk6hlmnK5OuHkHfCmKFab4NH0eHCc2M/QoZWjW
MPbs6haehKhcx9iztKrg1Ip+l2VkukrCBXu0RZMjNgGAgm+jrCAKzhosS+V7vJyr
l8CcF5on
=0pof
-----END PGP SIGNATURE-----

--/5UhqLK0k5fWAJvc--
