Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D45EC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CF780657;
	Wed, 15 Jan 2025 15:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qTWNoAL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3C2806D4; Wed, 15 Jan 2025 15:33:59 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F7780269
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467918c360aso77210131cf.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736951636; x=1737556436; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U+LllPAvFbhgNqPy7+3brVpiNYkhTZFeD2Mus4KJjcA=;
 b=qTWNoAL2MFVZcEB17JW2taCQHQLR9p5S1VQb+PkYBYvyetY75NbjeZ4P0q6xBV4nXY
 3PtnCRxwjqapIQbkWNWQnFYJBaiPD09wQ43wgokGOK6B0pOv5IvNr4ruWK2/E07oyXeq
 m+hwz2kjzl73Z3ALB5QK6LUC8q3KCIvtRrYNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736951636; x=1737556436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+LllPAvFbhgNqPy7+3brVpiNYkhTZFeD2Mus4KJjcA=;
 b=HaL92Jwg1g+9XNlAN1EloNuvEax6gIo5FJruETxbOOBwRICZGeQqHTPXohHCMI4/rn
 hM1zKtPu5WLiK4mdx5HB2DSvuQhK2onckmYXmMtm/HdZ3AZS7fHCiximT+iMpYWLrPzE
 XP806/MdQ7udiL9b2dvmxJyRWmM7tXNAv8u58Kh39sBDAqE3AsQRFoNwJFVurgT9/Bf4
 j1QL3im5ljinIxvakfYl4S9rDsEjXonq/V30/GuaQHUpIxjOsrX1svd8mI6ugo9GK1k6
 a1pzogpLeFyi8eU2Zs8jpfcV2jZydBAmFdIXwkgofvvVRV1yJwqq6wcHNMNAwX8gUs+v
 JdkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvqksgpWlA7m0iImkuSDRpuvgc6WifIy18MyZ1Rdz6l8Qi1pIxXccsaqj6OPNNYJJZOU37Jyk=@lists.denx.de
X-Gm-Message-State: AOJu0YxS567ZKYuDZ1YKg3ZrbjZCawyUqhQydY0Lh3LkG/E2JERBn35r
 johVcf2j/VXJsNhjHMt4KQ5Q1+4Q+QbWfIaXyuS5Y2wwogO/4pBGsd8EZYTDupA=
X-Gm-Gg: ASbGncsKmBmRS3fZxZYam5LwQ3HJt0/PcTTFqDIHYR7Ie5kLvPQRVUSeY0g1UYpInS0
 E7TaNbFAmSN+2pYRzDNB9j2fJ0Md6b84P2GqbvXuywtD3XNjlLLX7fIMNyiKvh4wpcMZMQTtSJM
 fw4l3Vdb356MsbMpXXntzrpA2jaqq77HhEu166LnnoTZxPzzXMrlmUQR1uierI86hW2Kw4zDQGX
 eA6hj2vvg4lFxwlBaAFQ8sjhwzv9NvxxDrxud+A9uPVMPN0KGjd2Q==
X-Google-Smtp-Source: AGHT+IG5Xxb/QZdibU1D5TQeDI+acGME0n9EsrjYHspbQhPSs1rv87cy+Sp9PRpRCtI2Dp/mC37kgg==
X-Received: by 2002:ac8:5906:0:b0:467:62aa:c6d2 with SMTP id
 d75a77b69052e-46c70fd1f3amr420593391cf.9.1736951635933; 
 Wed, 15 Jan 2025 06:33:55 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c87340bafsm64661581cf.32.2025.01.15.06.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:33:55 -0800 (PST)
Date: Wed, 15 Jan 2025 08:33:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work
 for non-sandbox setups"
Message-ID: <20250115143351.GV3476@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
 <20250109150454.GT3476@bill-the-cat>
 <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
 <20250109152234.GW3476@bill-the-cat>
 <CAFLszThy9OkfMMbbyzUvWF19rvTRk64q62J+Lhk=U0VABwZNbQ@mail.gmail.com>
 <20250110170531.GK3476@bill-the-cat>
 <CAFLszTgHe5ZOvD_6w=hGhA2E97kPXxLS7tPPZWMm0_w4gGn58A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AUvcdSpozHc42Lt4"
Content-Disposition: inline
In-Reply-To: <CAFLszTgHe5ZOvD_6w=hGhA2E97kPXxLS7tPPZWMm0_w4gGn58A@mail.gmail.com>
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


--AUvcdSpozHc42Lt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 06:22:40AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Jan 2025 at 10:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 10, 2025 at 06:41:00AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Jan 2025 at 08:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 08:11:58AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 9 Jan 2025 at 08:05, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 11/13/24 16:09, Simon Glass wrote:
> > > > > > > > > This is another option to fix sunxi booting with bootstd,=
 which may be
> > > > > > > > > better since it will work for all boards. We can then fig=
ure out how to
> > > > > > > > > automatically and deterministicaly decide when bootmgr sh=
ould be used.
> > > > > > > > >
> > > > > > > > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d=
9c7.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > > If this patch is applied, we don't need to drop bootmgr f=
or sunxi
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > > > > > > > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > > > > > > > >
> > > > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_=
mgr.c
> > > > > > > > > index 23ae1e610ac..095fa74fc60 100644
> > > > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > > > @@ -14,8 +14,6 @@
> > > > > > > > >   #include <command.h>
> > > > > > > > >   #include <dm.h>
> > > > > > > > >   #include <efi_loader.h>
> > > > > > > > > -#include <efi_variable.h>
> > > > > > > > > -#include <malloc.h>
> > > > > > > > >
> > > > > > > > >   /**
> > > > > > > > >    * struct efi_mgr_priv - private info for the efi-mgr d=
river
> > > > > > > > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevi=
ce *dev, struct bootflow_iter *iter)
> > > > > > > > >   static int efi_mgr_read_bootflow(struct udevice *dev, s=
truct bootflow *bflow)
> > > > > > > > >   {
> > > > > > > > >       struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> > > > > > > > > -     efi_status_t ret;
> > > > > > > > > -     efi_uintn_t size;
> > > > > > > > > -     u16 *bootorder;
> > > > > > > > >
> > > > > > > > >       if (priv->fake_dev) {
> > > > > > > > >               bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > >               return 0;
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > -     ret =3D efi_init_obj_list();
> > > > > > > > > -     if (ret)
> > > > > > > > > -             return log_msg_ret("init", ret);
> > > > > > > > > -
> > > > > > > > > -     /* Enable this method if the "BootOrder" UEFI exist=
s. */
> > > > > > > > > -     bootorder =3D efi_get_var(u"BootOrder", &efi_global=
_variable_guid,
> > > > > > > > > -                             &size);
> > > > > > > > > -     if (bootorder) {
> > > > > > > > > -             free(bootorder);
> > > > > > > > > -             bflow->state =3D BOOTFLOWST_READY;
> > > > > > > > > -             return 0;
> > > > > > > > > -     }
> > > > > > > > > +     /* To be implemented */
> > > > > > > >
> > > > > > > > The EFI boot manager can boot based on:
> > > > > > > >
> > > > > > > > * variable BootOrder
> > > > > > > > * variable BootNext
> > > > > > > > * an existing file EFI/BOOT/BOOT<arch>.EFI
> > > > > > > >
> > > > > > > > It obsoletes bootsmeth_efi.
> > > > > > > >
> > > > > > > > >
> > > > > > > > >       return -EINVAL;
> > > > > > > >
> > > > > > > > We must always run the EFI boot manager if it is enabled. S=
o -EINVAL is
> > > > > > > > wrong here.
> > > > > > >
> > > > > > > Well, I don't believe you have a solution, then.
> > > > > > >
> > > > > > > You did suggest putting bootmgr later, as we discussed on irc.
> > > > > > >
> > > > > > > For now, I think we should apply this patch (and series), whi=
le we
> > > > > > > sort out how to make bootmgr more incremental. It should not =
be
> > > > > > > scanning every available device before it starts, since that =
can be
> > > > > > > very slow.
> > > > > >
> > > > > > Heinrich and I talked the other day, and we think the right pat=
h is the
> > > > > > "later" path, where we don't try and use efi bootmanager until
> > > > > > everything has been probed, and also drop the single "efi" opti=
on. This
> > > > > > should mean that by the time we would be trying efi bootmanager=
 most if
> > > > > > not everything that needs to be probed has been probed. It does=
n't make
> > > > > > any sense to have "efi bootmanger" be more incremental as conce=
ptually
> > > > > > it's point is to show the user all the options.
> > > > >
> > > > > What is the single 'efi' option? I hope you don't mean the EFI bo=
otmeth.
> > > >
> > > > Yes, the single EFI bootmeth. Because part of the issue with that i=
s to
> > > > be compliant a bunch of things need to be probed. And rather than h=
ave
> > > > an option to be only semi-compliant, the preference is to be compli=
ant
> > > > and just tried later in the boot sequence.
> > >
> > > Well then you need a way to disable the single EFI bootmeth?
> >
> > We have BOOTMETH_EFILOADER already.
> >
> > > > > Putting bootmanager at the very end is OK with me, if we really c=
annot
> > > > > figure out a way to know whether the system is using it or now. I=
t is
> > > > > 'putting it in the middle' that I don't like.
> > > >
> > > > In the case of no specified boot order, after block (and after very
> > > > special things like FEL) and before network is what makes the most
> > > > sense. We don't need to try and DHCP/etc for it, just need to know =
if
> > > > the interface exists (and so the user can say / have configured, to=
 try
> > > > and boot it).
> > >
> > > Apart from FEL, we also have ChromeOS, Android, QFW.
> >
> > OK? Yes, bootstd needs to handle "we're in a special update things
> > state". I'm not sure if QFW counts as a faux-block device or not. And
> > ChromeOS I would have thought is "try and boot like $this from $device".
> > I don't know if by "Android" you mean booting the OS, or the AVB state
> > machine. The former would be like ChromeOS and the latter the special
> > state machine case.
>=20
> Standard boot is designed as a generalisation of the boot process and
> is able to cope with most use cases. Everything uses the same
> algorithm, at a high level.

That will be tricky as some of those use cases have their own required
order of operations.

> > > > > How to handle the case where bootorder only specifies a subset of
> > > > > options? Ideally we would just probe devices related to that subs=
et.
> > > > > That is what I was getting at.
> > > >
> > > > Yes, that should work just fine, especially if we're in the middle?
> > > >
> > > > The big challenge here is that conceptually, "bootstd" and "efi
> > > > bootmanager" are duplicate functionality. They are both "figure out=
 what
> > > > on the system we should boot". The compromise is to try "bootstd" on
> > > > block devices first (the common case).
> > >
> > > Are we trying to make boot slower?
> >
> > We're already in the slow path, because we're making guesses. But no, we
> > aren't trying to make anything slower. This should potentially faster in
> > the non-EFI case since we won't be trying to EFI boot every block device
> > until we have exhausted the non-EFI methods.
> >
> > > A better way to design this would be to integrate the EFI stuff with
> > > bootstd, rather than duplicating things. For example, a way to convert
> > > a BOOTxxxx device into a bootdev would permit faster booting, since we
> > > can just work through the boot order and request each device in turn.
> > >
> > > Once we give up on that and ask the user, we need to probe all device=
s.
> >
> > No, we're trying to untangle "EFI", "EFI bootmanager" and "bootstd".
>=20
> By neutering bootstd?

No, by taking one generalization of the boot process algorithm out of
another generalization of the boot process algorithm.

> It would be better to update EFI to make use of
> bootdev, for example. Heinrich did a patch to use the 'hunt' feature
> of bootdev.

There's "EFI" and "EFI bootmanager" and I'm not sure which one you're
referring to here. But yes, Heinrich has had suggestions on how to work
with bootstd, including suggesting what I'm also seeing as the best path
forward I believe.

> > > The monolithic init of EFI_LOADER is creating quite a few problems. Am
> > > I the only one that sees it?
> >
> > Yes, because your "monolithic init is a problem" is the subsystem
> > maintainers "monolithic init makes us spec compliant".
> >
> > And when we're in some sort of "probe the device and see what can be
> > booted" the subsystem maintainers would rather be spec compliant.
>=20
> We don't need to be noncompliant with spec. But some thoughtful design
> would help us a lot.

Maybe. But that's also not the part your problems with the EFI_LOADER
subsystem that you've been talking about in this thread. This thread is
about "can we probe less?" to which the answer seems to be "only if we
stop being spec compliant". Or if strictly speaking still spec compliant
but breaking the rule of least surprise and so forth.

> > And for the role I played in this confusion by suggesting how to
> > integrate things privately and has now gone off the rails, I am sorry
> > for the confusion and wasted efforts. I don't know if I was unclear or
> > misspoke.
>=20
> I'm not sure what that relates to?

I know at some points I had given you some advice on how to integrate
EFI in to bootstd. And since that seems to have gone in the wrong
direction I'm acknowledging that and trying to reset things.

--=20
Tom

--AUvcdSpozHc42Lt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHx0gACgkQFHw5/5Y0
tyzzKQwApZ2oWQTmy6B/wQAA8sCb91JntaEKhWBlYmdHkxSNANP1XyXHV4KqQ1WZ
OrWp5mnf/TyuwwMhAFQSQ5GS4Hl9KWk/0LMdDngotBwa16UX5KhmYRNt63H/MJ/p
woV75w1Rm6RREhbLxZmjD21HLsm7BKR93+6dnjrcVE8GdFMsUz/hyAMMuvSkykyP
srWjvUTuiuiAbEAonH5bN93cMZU6a55Kr1nf/InPUSpucUj3ol6XywoVtxYCpFtF
5ZB7jD/Z5ZqZW5rjjG6laxFZ5DpeiKXN31AHZVmYMQwyeZIFoausKMCjkWp0+gkK
DT0LjdiJ8UmldGKVFwIv3S371DA0y4b6fsFiF6nQnQslkmFondCwGuQKyr0jWt7T
WGdpXyC/kt5OdJCUH+pxhpJj06by9ELpZRNXf0IHQFE10f7fUCOAxcRiOYVPgcHl
ty/67CY/7rNdx9m2Oy//iOVXzith79KNKlwyOAoFx6EqRDhB7IeLVX8dQt1bYebX
DYkQKLcl
=nmeq
-----END PGP SIGNATURE-----

--AUvcdSpozHc42Lt4--
