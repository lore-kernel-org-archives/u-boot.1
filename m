Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E8E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464C4801F5;
	Thu,  9 Jan 2025 16:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EygqEDCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F33580602; Thu,  9 Jan 2025 16:22:42 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02F180107
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso83097785a.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736436159; x=1737040959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ef1E8GEUU4Tqezfi9sPSazarltbceFW+Cz40B4Z0sQ=;
 b=EygqEDCgnLShBkdIUlHgBwl1U0Bt2kahVttGG+FCsBcoTK0vftRxIOh7VXOnRwSAxJ
 M74TOAlgOY6V2huQvh8z2DjolxZ9uAtvhLSaWsU6hNBJuWAh0mzrNqTruOgjYkZ6yL+V
 SoxDP2J/6mecgUPncqhr+DPtCrL0C/KV4lR3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736436159; x=1737040959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ef1E8GEUU4Tqezfi9sPSazarltbceFW+Cz40B4Z0sQ=;
 b=czwSapjXfdQX1yMWBLDVgV/7BffBNTRN4eAfWIsoGCS7wWHEzWvN0OKH4s7IQkDIfA
 xqfllw0Om4lffqGELNn3VesctC6LfOAUEPQqYUSfwqf7737v2bripclC0dpmUQC44SMG
 ojnarc9mcTqsLP+pYLEoGgrBBNI5Rm+5dBdZkIwDU5Z1Qe9MP+hThgeGXDO28S0w17F9
 4RIVWhLN9ucqqrz+CnURwYUL7AyYuvzW5U5Q5BpT0UCw5pP4PK1pPAl8EcAGjr0Pwfpy
 Gtb8NOJI/rfkG0IXReN3Wqb9atGIJA0mBwcu9GhFOmvQ78C/7t8ddIQ0ii4roRd346Q7
 3s/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQZeS0l+0SPpO2De8Bgxsiam8gvXDpxqJs3s+GEVUeVoSdKt48y2EhfTXPff4RDN1LaFN8GeE=@lists.denx.de
X-Gm-Message-State: AOJu0YyYqw4IBrAZsRKSbFstbx3vN9pKFmYVQ+07er7sYJoSs1L/mIhC
 DpI5H7oeM9jEOpRYwE4F5gjc6NRZLLjlcDtzLVAQQAGmsU2gA4T81GF3SZzrArw=
X-Gm-Gg: ASbGncs0K9jh2dP2ERCghWDQKzEQoHWr/3DIz1/4IndE7m8F9fu3PquXwZ3IeQclNEU
 I6/yRmnD7azwh+0idh3JxRvY17GthQFDi6hgHQlV3ImzFnFSeFIUFD1vSaqXnySHmzMIMe5PZpS
 wLeltabJTZs3cS9B/rTKw/IksdD8VkSLpQ4vVzBd0Y03sZi9noFBVkwjkWHe6aBaZg23xGku4w9
 9qov+Bw5MeSxRpS1dxqlB7sZhNaGwD6igwq32EpetrdE6W+RZGpF78=
X-Google-Smtp-Source: AGHT+IHnojOGgUeA5zwxlyMzOGEFRUNZYxa80FhGb6LMLmKr7ddRU+urbUoWy6TTITPsRQy6MxVEIg==
X-Received: by 2002:a05:620a:1b89:b0:7b6:f6ac:60e with SMTP id
 af79cd13be357-7bcd979c8f2mr1246651085a.36.1736436158630; 
 Thu, 09 Jan 2025 07:22:38 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce32381absm77092685a.8.2025.01.09.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:22:37 -0800 (PST)
Date: Thu, 9 Jan 2025 09:22:34 -0600
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
Message-ID: <20250109152234.GW3476@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
 <517d087e-4ac5-4fd5-a37f-d4d3aaa534bd@gmx.de>
 <CAFLszTjbDHvMvv3U+SaW0_7b4oajW8RRf6KYbF_jex34en6ByA@mail.gmail.com>
 <20250109150454.GT3476@bill-the-cat>
 <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="USfR+qHkf7HrB5+K"
Content-Disposition: inline
In-Reply-To: <CAFLszTgtP5vXT+HsvHP8i50KihetHf2-h3KPp2-f6M4XJ3+i8g@mail.gmail.com>
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


--USfR+qHkf7HrB5+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 08:11:58AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Jan 2025 at 08:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 08:01:13AM -0700, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Sat, 4 Jan 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > > >
> > > > On 11/13/24 16:09, Simon Glass wrote:
> > > > > This is another option to fix sunxi booting with bootstd, which m=
ay be
> > > > > better since it will work for all boards. We can then figure out =
how to
> > > > > automatically and deterministicaly decide when bootmgr should be =
used.
> > > > >
> > > > > This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > If this patch is applied, we don't need to drop bootmgr for sunxi
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >   boot/bootmeth_efi_mgr.c | 18 +-----------------
> > > > >   1 file changed, 1 insertion(+), 17 deletions(-)avilable
> > > > >
> > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > index 23ae1e610ac..095fa74fc60 100644
> > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > @@ -14,8 +14,6 @@
> > > > >   #include <command.h>
> > > > >   #include <dm.h>
> > > > >   #include <efi_loader.h>
> > > > > -#include <efi_variable.h>
> > > > > -#include <malloc.h>
> > > > >
> > > > >   /**
> > > > >    * struct efi_mgr_priv - private info for the efi-mgr driver
> > > > > @@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev,=
 struct bootflow_iter *iter)
> > > > >   static int efi_mgr_read_bootflow(struct udevice *dev, struct bo=
otflow *bflow)
> > > > >   {
> > > > >       struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> > > > > -     efi_status_t ret;
> > > > > -     efi_uintn_t size;
> > > > > -     u16 *bootorder;
> > > > >
> > > > >       if (priv->fake_dev) {
> > > > >               bflow->state =3D BOOTFLOWST_READY;
> > > > >               return 0;
> > > > >       }
> > > > >
> > > > > -     ret =3D efi_init_obj_list();
> > > > > -     if (ret)
> > > > > -             return log_msg_ret("init", ret);
> > > > > -
> > > > > -     /* Enable this method if the "BootOrder" UEFI exists. */
> > > > > -     bootorder =3D efi_get_var(u"BootOrder", &efi_global_variabl=
e_guid,
> > > > > -                             &size);
> > > > > -     if (bootorder) {
> > > > > -             free(bootorder);
> > > > > -             bflow->state =3D BOOTFLOWST_READY;
> > > > > -             return 0;
> > > > > -     }
> > > > > +     /* To be implemented */
> > > >
> > > > The EFI boot manager can boot based on:
> > > >
> > > > * variable BootOrder
> > > > * variable BootNext
> > > > * an existing file EFI/BOOT/BOOT<arch>.EFI
> > > >
> > > > It obsoletes bootsmeth_efi.
> > > >
> > > > >
> > > > >       return -EINVAL;
> > > >
> > > > We must always run the EFI boot manager if it is enabled. So -EINVA=
L is
> > > > wrong here.
> > >
> > > Well, I don't believe you have a solution, then.
> > >
> > > You did suggest putting bootmgr later, as we discussed on irc.
> > >
> > > For now, I think we should apply this patch (and series), while we
> > > sort out how to make bootmgr more incremental. It should not be
> > > scanning every available device before it starts, since that can be
> > > very slow.
> >
> > Heinrich and I talked the other day, and we think the right path is the
> > "later" path, where we don't try and use efi bootmanager until
> > everything has been probed, and also drop the single "efi" option. This
> > should mean that by the time we would be trying efi bootmanager most if
> > not everything that needs to be probed has been probed. It doesn't make
> > any sense to have "efi bootmanger" be more incremental as conceptually
> > it's point is to show the user all the options.
>=20
> What is the single 'efi' option? I hope you don't mean the EFI bootmeth.

Yes, the single EFI bootmeth. Because part of the issue with that is to
be compliant a bunch of things need to be probed. And rather than have
an option to be only semi-compliant, the preference is to be compliant
and just tried later in the boot sequence.

> Putting bootmanager at the very end is OK with me, if we really cannot
> figure out a way to know whether the system is using it or now. It is
> 'putting it in the middle' that I don't like.

In the case of no specified boot order, after block (and after very
special things like FEL) and before network is what makes the most
sense. We don't need to try and DHCP/etc for it, just need to know if
the interface exists (and so the user can say / have configured, to try
and boot it).

> How to handle the case where bootorder only specifies a subset of
> options? Ideally we would just probe devices related to that subset.
> That is what I was getting at.

Yes, that should work just fine, especially if we're in the middle?

The big challenge here is that conceptually, "bootstd" and "efi
bootmanager" are duplicate functionality. They are both "figure out what
on the system we should boot". The compromise is to try "bootstd" on
block devices first (the common case).

--=20
Tom

--USfR+qHkf7HrB5+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd/6boACgkQFHw5/5Y0
tyxE4gwAhIWPGUkeFatoJj5cEsSlzIJ+Lc3R+/QBS8PGlfa4x5Ny+IsiqMAWbYMG
lX2jld8FXQf6xEtYf2mbP60vNIhbrhP5I+cqs7R2pFeQQfSnvTmT0+P084g0dXxx
zInUZ3cZHSaYEz4WOMKxyimpvbE2YJgmeQ+2n0JVU5qajjJOJvOYl8ZKtYeEXxHe
xNSib6FdeMpypPijy5lNlpBjS/S2WfqRsoOMk2cWIkvOPYuWXlV5sEkum+DDkGo2
HcXIUbjj2w5k4xN81Q8/kyoNkfQ/qGGcwFdhr7JNE+HA/yqQEutTVBmtvAOSykB/
dN4NnMonDWBlI3EKN50E0DzcHqXZKR5EfnzVrI0yQviX9a27+wTxIAXHvRNsS/CY
VodRf1Spyh0uuZb9DvWXzjfXm99Ek0FnomKUC6o7Mw0vgQg/I3dkMpcVUeEupEJz
A1iqNYgo4w1ZE1sPmetloRXNJqjJL8Q8tbzI1XI6RIeXVLumg6kvc52lCcrbRLBB
3pWX85gZ
=Vako
-----END PGP SIGNATURE-----

--USfR+qHkf7HrB5+K--
