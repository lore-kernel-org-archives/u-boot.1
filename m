Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D99CC3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CF982982;
	Tue,  6 May 2025 16:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c/PtWWMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5017C829E7; Tue,  6 May 2025 16:29:57 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC5F800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2c2504fa876so2006004fac.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746541793; x=1747146593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LjtgM7jDqnPHvdNZFMGrtD7FrlKZ3HSPQ7OWoInouSQ=;
 b=c/PtWWMBsoSdihMdO7OHi3wM6cml953qJkNxyIm4Q3ONOtH3hCSLyAAlmZm40g8XmD
 jOiSktsHGaA7ffyo58Oa92fEWq4V8HvOGuP6sPialXrfAiEjLPFxPV0X54fvX7hr7J5g
 FCQNQCJgZDadNb5KsleQFLbx7v2UYl40cHF1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541793; x=1747146593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjtgM7jDqnPHvdNZFMGrtD7FrlKZ3HSPQ7OWoInouSQ=;
 b=XPEj843emp0KBvLhXKHuIQIwqhHAfxrPpNDyYopRfmT7KvwuWsjHoX6jaQyCOk494a
 IAglT9iELI2c9DbYSDpVNPkKEq+PSF3A6tdqIWzuc38un7OtfFSMqgptJSOaFpROEUWP
 W5ZCjQGd6XsqTweQYI/B15fsMj22AiaMOFB63ilmq9TNw8q7hF0Y2DI34NzSu+s03jvS
 +T0wesNP9Y/j00HHv79ouMyVAGdTzPcPim+9mc9lB6TPUt0Vnoaf8gzjSd5f015P7G3Z
 a2HtogRpU+w1rd3WUKhFquJha6GpnQwPOWFXela+Q/ZkcKwihK1YT0GuP62dz9cXP77Q
 BA9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/u5HCPAVsYQWG0qPEyGwbkYf44QffiXKER6ttxd8Lxae4VzLwhFz+GZkoa0R0Xnl0ULa+aow=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0RGUEeDWQPnnCv7SPe8KNkjnGQFhN2GfkNcQzRo/tapoUs0uH
 q4x/tuePr86apUcMHeeQrQNMMGAKmYW0Z7OwqE0IpqjeZp/BfmVVUeYtap/z2pE=
X-Gm-Gg: ASbGncs2Ue0MmlwCxmCdkVybk/GX02fmzBSiUXQv1LwR2QIkovImAN3ldYQ0EOE6ujE
 nZmufTdtGxxlDIEXBPGkru6P5L9VcYcsNgPnB51KS72yo3VlrUmhe7DB9eCyR1Dw0PLu5dnsruy
 uTtuwxiJQVK2VtpeVFrVor6iEZroA4KElneLUWxsBKPzuSC+WNxW3ysVGrOxUX1ldHzL89jjZ5M
 VW4YKvo+NhXnuWseDXZgjtsei+MBnIxw/RxKNAsYYh4sFR4p6anZAJl1M/q+jbWALaBJ+Wxyt2S
 +6qANVGiOMs99WmuzFOhjOrml6ZXZ5Go9D/3ILAKu1E+Dl2mE/yOCtfhCEwQDD2yPjsaJLty4lF
 Kyw==
X-Google-Smtp-Source: AGHT+IGWAYzViNU+sfclYwhB/2RHHZ8KtcvHK8Jd5AmuK/ku9RcFYk040MdjlBiDm09/FF+gJV+F5A==
X-Received: by 2002:a05:6870:242a:b0:2b8:ec17:66e9 with SMTP id
 586e51a60fabf-2db38be9969mr2062590fac.11.1746541793439; 
 Tue, 06 May 2025 07:29:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0edc665sm2665743fac.20.2025.05.06.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:29:52 -0700 (PDT)
Date: Tue, 6 May 2025 08:29:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: heinrich.schuchardt@canonical.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, tuomas.tynkkynen@iki.fi,
 patrick.rudolph@9elements.com, mkorpershoek@kernel.org,
 u-boot@lists.denx.de
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
Message-ID: <20250506142950.GV5430@bill-the-cat>
References: <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
 <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
 <20250505221024.GR5430@bill-the-cat>
 <c0c51cdb-107b-4ebb-abae-8494d9fc63ae@canonical.com>
 <20250505234319.GT5430@bill-the-cat>
 <87v7qe82av.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jNPZVZbe/0nyputF"
Content-Disposition: inline
In-Reply-To: <87v7qe82av.fsf@bloch.sibelius.xs4all.nl>
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


--jNPZVZbe/0nyputF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 12:24:24PM +0200, Mark Kettenis wrote:
> > Date: Mon, 5 May 2025 17:43:19 -0600
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Tue, May 06, 2025 at 01:18:16AM +0200, Heinrich Schuchardt wrote:
> > > On 5/6/25 00:10, Tom Rini wrote:
> > > > On Tue, May 06, 2025 at 12:07:20AM +0200, Heinrich Schuchardt wrote:
> > > > > Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:
> > > > >=20
> > > > > > On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt w=
rote:
> > > > > > > Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Ma=
i 2025,
> > > > > > 21:03:
> > > > > > >=20
> > > > > > > > > Date: Fri, 2 May 2025 18:08:56 +0200
> > > > > > > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.=
com>
> > > > > > > > >=20
> > > > > > > > > On 5/2/25 16:49, Simon Glass wrote:
> > > > > > > > > > Hi Heinrich,
> > > > > > > > > >=20
> > > > > > > > > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > The EFI boot manager bootmeth does not require variab=
le BootOrder
> > > > > > to
> > > > > > > > be
> > > > > > > > > > > preexisting. It creates this variable.
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Heinrich Schuchardt <
> > > > > > heinrich.schuchardt@canonical.com
> > > > > > > > >=20
> > > > > > > > > > > ---
> > > > > > > > > > >    boot/bootmeth_efi_mgr.c | 21 +++------------------
> > > > > > > > > > >    1 file changed, 3 insertions(+), 18 deletions(-)
> > > > > > > > > > >=20
> > > > > > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_=
efi_mgr.c
> > > > > > > > > > > index 42b8863815e..1669cbed5bd 100644
> > > > > > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > > > > > @@ -47,30 +47,15 @@ static int efi_mgr_check(struct u=
device *dev,
> > > > > > > > struct bootflow_iter *iter)
> > > > > > > > > > >=20
> > > > > > > > > > >    static int efi_mgr_read_bootflow(struct udevice *d=
ev, struct
> > > > > > > > bootflow *bflow)
> > > > > > > > > > >    {
> > > > > > > > > > > -       struct efi_mgr_priv *priv =3D dev_get_priv(de=
v);
> > > > > > > > > > > -       efi_status_t ret;
> > > > > > > > > > > -       efi_uintn_t size;
> > > > > > > > > > > -       u16 *bootorder;
> > > > > > > > > > > -
> > > > > > > > > > > -       if (priv->fake_dev) {
> > > > > > > > > > > -               bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > > > > -               return 0;
> > > > > > > > > > > -       }
> > > > > > > > > > > +       int ret
> > > > > > > > > > >=20
> > > > > > > > > > >           ret =3D efi_init_obj_list();
> > > > > > > > > > >           if (ret)
> > > > > > > > > > >                   return log_msg_ret("init", ret);
> > > > > > > > > > >=20
> > > > > > > > > > > -       /* Enable this method if the "BootOrder" UEFI=
 exists. */
> > > > > > > > > > > -       bootorder =3D efi_get_var(u"BootOrder",
> > > > > > > > &efi_global_variable_guid,
> > > > > > > > > > > -                               &size);
> > > > > > > > > > > -       if (bootorder) {
> > > > > > > > > > > -               free(bootorder);
> > > > > > > > > > > -               bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > > > > -               return 0;
> > > > > > > > > > > -       }
> > > > > > > > > > > +       bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > > > >=20
> > > > > > > > > > > -       return -EINVAL;
> > > > > > > > > > > +       return 0;
> > > > > > > > > > >    }
> > > > > > > > > > >=20
> > > > > > > > > > >    static int efi_mgr_read_file(struct udevice *dev, =
struct
> > > > > > bootflow
> > > > > > > > *bflow,
> > > > > > > > > > > --
> > > > > > > > > > > 2.48.1
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > How do we know if the board is using EFI bootmgr? My un=
derstanding
> > > > > > was
> > > > > > > > > > that this was a way to find out?
> > > > > > > > >=20
> > > > > > > > > The boot manager must always run.
> > > > > > > > >=20
> > > > > > > > > The check for the BootOrder variable introduced in commit
> > > > > > f2bfa0cb1794
> > > > > > > > > is a bug.
> > > > > > > >=20
> > > > > > > > Well, at the time the boot manager did not attempt to boot =
the default
> > > > > > > > path.  So there was no point in running the boot manager co=
de unless
> > > > > > > > BootOrder (or BootNext) was set.  And of course before that=
 commit the
> > > > > > > > boot manager didn't run at all on non-sandbox builds that h=
ad the
> > > > > > > > standard boot stuff enebaled.
> > > > > > > >=20
> > > > > > > > Anyway, I believe the thinking behind that commit is still =
sound.  As
> > > > > > > > I explained earlier, I think that...
> > > > > > > >=20
> > > > > > > > > The boot manager handles in sequence:
> > > > > > > > >=20
> > > > > > > > > * Try to boot as indicated by BootNext.
> > > > > > > > > * Try to boot as indicated by BootOrder.
> > > > > > > > > * Try to boot default path for available media.
> > > > > > > > >     This will add Boot#### entries and update BootOrder.
> > > > > > > >=20
> > > > > > > > ...doing this all in a monolithic sequence isn't the best w=
ay to
> > > > > > > > handle EFI boot in the u-boot ecosystem.
> > > > > > > >=20
> > > > > > > > Your series moves the boot manager further down the list be=
cause the
> > > > > > > > third step in the sequence has to happen late.  But as a re=
sult
> > > > > > > > BootNext and BootOrder processing will also happen late.  S=
o what
> > > > > > > > happens if you have a board with two OS installations:
> > > > > > > >=20
> > > > > > > > 1. A generic Linux distro that boots via EFI.
> > > > > > > >=20
> > > > > > > > 2. Something like Armbian that provides an extlinux.conf fi=
le.
> > > > > > > >=20
> > > > > > > > Currently such a system will probably boot OS #1.  But afte=
r your
> > > > > > > >=20
> > > > > > >=20
> > > > > > > This did not happen with distoboot. So migration from distrob=
oot to
> > > > > > > standard boot results in a change that you want to avoid.
> > > > > > >=20
> > > > > > > changes it will probably boot OS #2.  And if OS #1 sets BootO=
rder or
> > > > > > > > BootNext that will not change anything.
> > > > > > > >=20
> > > > > > > > So I think we need a solution where BootNext and BootOrder =
processing
> > > > > > > > happens early, like we do now.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > As of today BootNext does not invoke the boot manager.
> > > > > > >=20
> > > > > > > If BootOrder is set the boot manager may fail because not all=
 devices are
> > > > > > > detected as "hunters" have not been running. E.g. nvme scan a=
nd usb start
> > > > > > > are only invoked after the EFI boot manager.
> > > > > > >=20
> > > > > > > I originally suggested to probe all boot devices before the b=
oot manager
> > > > > > > runs, but users complained that this slows down their non-EFI=
 boot flows.
> > > > > > > This is why I now move it after all boot methods but PXE.
> > > > > >=20
> > > > > > Can we not see what BootOrder is and then ensure it's been "hun=
ted" ?
> > > > > >=20
> > > > > > --
> > > > > > Tom
> > > > > >=20
> > > > >=20
> > > > > A load option may only contain the partition GUID and the file pa=
th. In
> > > > > this case you wouldn't be able to tell whether it is for an NVMe =
drive, or
> > > > > a USB stick.
> > > > >=20
> > > > > As numbering of devices cannot be expected to be stable, it is pr=
eferable
> > > > > to use this short form of device paths for load options.
> > > >=20
> > > > Ah, OK. So could we check and if not found print a human understand=
able
> > > > error message, and continue on? I want to figure out some path that=
 does
> > > > not change the pre-bootstd behavior.
> > > >=20
> > >=20
> > > In distroboot scan_dev_for_efi is invoked for every boot device and e=
ach
> > > time calls the boot manager. As usb start is only called in usb_boot =
this
> > > will result in behavior that is as non-compliant with the UEFI
> > > specification.
> > >=20
> > > We should reach a behavior that complies with the UEFI specification.
> > > Not changing former distro boot behavior is not a valid option.
> >=20
> > Can we also not figure out some way to boot promptly? I was thinking
> > something along the lines of if we know BootOrder (or similar), we try
> > it. If we don't find it, we try again a bit later on when we can run all
> > the hunting that might be slow. If the only option is slow-but-compliant
> > I feel like a lot of use cases will opt out of using EFI boot instead.
>=20
> I think that is possible.  But it will require tighter integration
> integration between the EFI loader and the standard boot device
> hunting code such that devices are probed as we walk to options
> specified by the BootOrder.
>=20
> A complication here is that a Boot#### option doesn't necessearily
> have the device encoded into the boot option.  An option can reference
> just the GUID of a partition and many OS installers create such
> options.  So if we see such an option we do need to probe devices
> until we find the right partition.

Right, I recall Heinrich mentioned it could (might often be?) a GUID
instead and so we might need to hunt, check what we found for a GUID,
repeat. I am assuming that would not be an expensive operation however.

--=20
Tom

--jNPZVZbe/0nyputF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaHNoACgkQFHw5/5Y0
tyy69AwAjeZe24PsFJz4Db1qSL0ROkHPxTWkzmFDDLFxnRgkj7F2rIpPuV63TnyK
++4ziE+ad83cLaWGee17TANRfPFlpYqYQHHiZS20bKpafrE6P7aJsuZBg/83FhB5
PLmZM2RAWEjhw1EoMzmam/6DFM2NyRCrFy+ih8wFn2WrdvIAXTfjJFLzqUPlJVzc
GNwrYk93euY7oLXZSpcrWccf/z9J4FTA4q/b6r/li5BjNP05VpFRwpoTWO5zXE/p
LErB+MAlIfGhGd9VcjMHS6LeMwTi3JevocGXYqEJ9P05FbF3ggw/zw+mFifx3Gf5
SGc2rbQdeKvtS7Mbs7XH9+pcqINEP/4jMAOZRKVT1svckyW262pNTpsDsCB9fVp1
jfeVDIcM3QgQBL5VeYJ8jVoXafRsz3cwSGX4DaRvOcpXje10eBQqoglI0nMXK2jX
HkJu2Kiz73+4c4NsYunnsMzNdAbc46vFWco9gjuQIDj3Pbfa0Cm7m2rjShLe1pxy
ty6So5ri
=Z21+
-----END PGP SIGNATURE-----

--jNPZVZbe/0nyputF--
