Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76856E7719D
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 17:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2346800D0;
	Fri, 10 Jan 2025 18:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/wUIhiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7435C801F5; Fri, 10 Jan 2025 18:05:39 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E3C80050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 18:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b9ad0e84e6so224176885a.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736528736; x=1737133536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Iw/f2J5PPJ/bpX/divms+cNBge6RwcSBR7kZzBsdooY=;
 b=a/wUIhiYnrGEMkaaZ1liBGxcgEuNJiUixTXQK9IdpdVo4Qq+kfUxyLrbzvOu7Xccwm
 sMbg2wetN2e/l9/jMi84zkdilC1zUdJLcljwrrggtEwqc4lspQA9MLYjij6bXv5i8WwA
 ct8dpu0xXBNGWwt0Zzth8s560v1NdiRmurHaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736528736; x=1737133536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iw/f2J5PPJ/bpX/divms+cNBge6RwcSBR7kZzBsdooY=;
 b=d1XkxV1r4BQB2jDle89KMkwdH+lm8gJRn/4DoHQfLMEoZIpxJ/ncWlzBIyH/1ni5cl
 NFkhiBNDnwANjzmfzJ4a0VloHM5ntXArpdnARskTG0idvyP/wfFHV+gWRygxxbBQjKZJ
 SEp9+xwqxAqlM9my0Ni3tVDP4DtLNP/y3JqmKNUzm7ALc0K0YlALpKJrPaVAfwBWvupm
 p8QE0k6715t79odEMTZhLj6X4ehGhV+WFg1eucN8/WsiqisuUabQGyiSgt/vx2XspC+o
 Pn8lt3jZlcioyOXaQplyS8+NutXEQb+lsm2Q+XE6yveevCgI/O36+BCIpmIokTyZG6IV
 c64Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+MfNUIPrH4cNqf3Xx+V55vB4xxocSRrB6B/ywb3Y1xdkKEdSQh0B4H5+Nfdux0YIqF01FDPs=@lists.denx.de
X-Gm-Message-State: AOJu0YzZad5goqwbXwzpWjf15US0Z8if7JehfoT9BBnMzkI3emGcd6T/
 isWOtFbGxWqq+j0/ZnWyAFo/F1teJgY+/K1i7MYyEqXxiN3sltnKqQZH8d6xyLE=
X-Gm-Gg: ASbGncsR9JZuqgaDvGexZAK5wvOKUvRen4LTNW/FIUkstA4YExSWrtSs0Pw45idXepv
 WwGA3HpJyBxJdQr2RKU7/9e1Cz1trndZGy6sb9TT5W4zI+lToid9ReVvHMQO72XVcWvfy4talpA
 vDcaocYsmXo7uuxtP/4XGJAgxBf2uwZ5Axbuw5M4lA/1N5Z8NS/QLK5zHyy3S0PJO35f9Gs8Rvp
 LI4XBSJ2pE/O0qbWXXWGs3/ymfvGHMhLmJxaivnb8CKQtmi2NO8hUc=
X-Google-Smtp-Source: AGHT+IGV8zgV+0H6G3jaBoyvLHjMffkTs5rwfQRMrgN123RY3oRLeXD2vLj28NqCG6BqNresfXFmDA==
X-Received: by 2002:a05:620a:2490:b0:7b1:19f4:c6e0 with SMTP id
 af79cd13be357-7bcd97bdeb6mr1762276885a.51.1736528735521; 
 Fri, 10 Jan 2025 09:05:35 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3281697sm191045785a.67.2025.01.10.09.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 09:05:34 -0800 (PST)
Date: Fri, 10 Jan 2025 11:05:31 -0600
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
Message-ID: <20250110170531.GK3476@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
 <20250109150454.GT3476@bill-the-cat>
 <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
 <20250109152234.GW3476@bill-the-cat>
 <CAFLszThy9OkfMMbbyzUvWF19rvTRk64q62J+Lhk=U0VABwZNbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+1Kx8ajUq07DMi+4"
Content-Disposition: inline
In-Reply-To: <CAFLszThy9OkfMMbbyzUvWF19rvTRk64q62J+Lhk=U0VABwZNbQ@mail.gmail.com>
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


--+1Kx8ajUq07DMi+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 06:41:00AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Jan 2025 at 08:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 08:11:58AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Jan 2025 at 08:05, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx=
=2Ede> wrote:
> > > > > >
> > > > > > On 11/13/24 16:09, Simon Glass wrote:
> > > > > > > This is another option to fix sunxi booting with bootstd, whi=
ch may be
> > > > > > > better since it will work for all boards. We can then figure =
out how to
> > > > > > > automatically and deterministicaly decide when bootmgr should=
 be used.
> > > > > > >
> > > > > > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > > If this patch is applied, we don't need to drop bootmgr for s=
unxi
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > > > > > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > > > > > >
> > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > > > index 23ae1e610ac..095fa74fc60 100644
> > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > @@ -14,8 +14,6 @@
> > > > > > >   #include <command.h>
> > > > > > >   #include <dm.h>
> > > > > > >   #include <efi_loader.h>
> > > > > > > -#include <efi_variable.h>
> > > > > > > -#include <malloc.h>
> > > > > > >
> > > > > > >   /**
> > > > > > >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > > > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *=
dev, struct bootflow_iter *iter)
> > > > > > >   static int efi_mgr_read_bootflow(struct udevice *dev, struc=
t bootflow *bflow)
> > > > > > >   {
> > > > > > >       struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> > > > > > > -     efi_status_t ret;
> > > > > > > -     efi_uintn_t size;
> > > > > > > -     u16 *bootorder;
> > > > > > >
> > > > > > >       if (priv->fake_dev) {
> > > > > > >               bflow->state =3D BOOTFLOWST_READY;
> > > > > > >               return 0;
> > > > > > >       }
> > > > > > >
> > > > > > > -     ret =3D efi_init_obj_list();
> > > > > > > -     if (ret)
> > > > > > > -             return log_msg_ret("init", ret);
> > > > > > > -
> > > > > > > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > > > > > > -     bootorder =3D efi_get_var(u"BootOrder", &efi_global_var=
iable_guid,
> > > > > > > -                             &size);
> > > > > > > -     if (bootorder) {
> > > > > > > -             free(bootorder);
> > > > > > > -             bflow->state =3D BOOTFLOWST_READY;
> > > > > > > -             return 0;
> > > > > > > -     }
> > > > > > > +     /* To be implemented */
> > > > > >
> > > > > > The EFI boot manager can boot based on:
> > > > > >
> > > > > > * variable BootOrder
> > > > > > * variable BootNext
> > > > > > * an existing file EFI/BOOT/BOOT<arch>.EFI
> > > > > >
> > > > > > It obsoletes bootsmeth_efi.
> > > > > >
> > > > > > >
> > > > > > >       return -EINVAL;
> > > > > >
> > > > > > We must always run the EFI boot manager if it is enabled. So -E=
INVAL is
> > > > > > wrong here.
> > > > >
> > > > > Well, I don't believe you have a solution, then.
> > > > >
> > > > > You did suggest putting bootmgr later, as we discussed on irc.
> > > > >
> > > > > For now, I think we should apply this patch (and series), while we
> > > > > sort out how to make bootmgr more incremental. It should not be
> > > > > scanning every available device before it starts, since that can =
be
> > > > > very slow.
> > > >
> > > > Heinrich and I talked the other day, and we think the right path is=
 the
> > > > "later" path, where we don't try and use efi bootmanager until
> > > > everything has been probed, and also drop the single "efi" option. =
This
> > > > should mean that by the time we would be trying efi bootmanager mos=
t if
> > > > not everything that needs to be probed has been probed. It doesn't =
make
> > > > any sense to have "efi bootmanger" be more incremental as conceptua=
lly
> > > > it's point is to show the user all the options.
> > >
> > > What is the single 'efi' option? I hope you don't mean the EFI bootme=
th.
> >
> > Yes, the single EFI bootmeth. Because part of the issue with that is to
> > be compliant a bunch of things need to be probed. And rather than have
> > an option to be only semi-compliant, the preference is to be compliant
> > and just tried later in the boot sequence.
>=20
> Well then you need a way to disable the single EFI bootmeth?

We have BOOTMETH_EFILOADER already.

> > > Putting bootmanager at the very end is OK with me, if we really cannot
> > > figure out a way to know whether the system is using it or now. It is
> > > 'putting it in the middle' that I don't like.
> >
> > In the case of no specified boot order, after block (and after very
> > special things like FEL) and before network is what makes the most
> > sense. We don't need to try and DHCP/etc for it, just need to know if
> > the interface exists (and so the user can say / have configured, to try
> > and boot it).
>=20
> Apart from FEL, we also have ChromeOS, Android, QFW.

OK? Yes, bootstd needs to handle "we're in a special update things
state". I'm not sure if QFW counts as a faux-block device or not. And
ChromeOS I would have thought is "try and boot like $this from $device".
I don't know if by "Android" you mean booting the OS, or the AVB state
machine. The former would be like ChromeOS and the latter the special
state machine case.

> > > How to handle the case where bootorder only specifies a subset of
> > > options? Ideally we would just probe devices related to that subset.
> > > That is what I was getting at.
> >
> > Yes, that should work just fine, especially if we're in the middle?
> >
> > The big challenge here is that conceptually, "bootstd" and "efi
> > bootmanager" are duplicate functionality. They are both "figure out what
> > on the system we should boot". The compromise is to try "bootstd" on
> > block devices first (the common case).
>=20
> Are we trying to make boot slower?

We're already in the slow path, because we're making guesses. But no, we
aren't trying to make anything slower. This should potentially faster in
the non-EFI case since we won't be trying to EFI boot every block device
until we have exhausted the non-EFI methods.

> A better way to design this would be to integrate the EFI stuff with
> bootstd, rather than duplicating things. For example, a way to convert
> a BOOTxxxx device into a bootdev would permit faster booting, since we
> can just work through the boot order and request each device in turn.
>=20
> Once we give up on that and ask the user, we need to probe all devices.

No, we're trying to untangle "EFI", "EFI bootmanager" and "bootstd".

> The monolithic init of EFI_LOADER is creating quite a few problems. Am
> I the only one that sees it?

Yes, because your "monolithic init is a problem" is the subsystem
maintainers "monolithic init makes us spec compliant".

And when we're in some sort of "probe the device and see what can be
booted" the subsystem maintainers would rather be spec compliant.

And for the role I played in this confusion by suggesting how to
integrate things privately and has now gone off the rails, I am sorry
for the confusion and wasted efforts. I don't know if I was unclear or
misspoke.

--=20
Tom

--+1Kx8ajUq07DMi+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBU08ACgkQFHw5/5Y0
tyyh3Qv9GDoPG6vWzc7nXmkIUCmlAodd0py6O5gYrAMZIHV5H5Q9b82fAvWMTbrw
5wuPP3E1v2Jiwp3Ii1r3CQGuaMdk6eqoAxz1SGkrddONXaGAurSn7dtqhf+RHWG2
+1jb2k5Aqfwujt0gjCea7mehWjBRzVAmqPfmWwJhzFczfdAwDbhaM13o9UjrnUli
/1g+8Tr5JMfhlwuO2v2r8UKknVsl7ZAC+c089B5ziIzdJgLa5ebCNcsEmxmDJasi
vji/uwt9hwefTSeYd9QnYxbXnwXptrmuYtpZhr9ftle/b25Bvqt9WpmAnGmKttqT
epdh4deBNZS3gwt8UkukMibr5+c43gpy72LJtF9T7QB1mhC9kbNxs71WzsMKWBWE
6XNRrQYuRM1XCTZDB0qduY7ftjDd3Ea4F+7JmQgwUcGuUqfOsrbDD/5df+qKSdkK
DA6cL+0yhZDzrblv/0pUgRzxMUTCrR90dafcE+ZilJC9Nzy8CkG8tIGk7X9EUDN3
oAdWGCxZ
=nlTf
-----END PGP SIGNATURE-----

--+1Kx8ajUq07DMi+4--
