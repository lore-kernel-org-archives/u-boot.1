Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1B9CAC58E
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 17:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49ACA88B14;
	Tue, 17 Sep 2024 19:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="de/Q+v5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6668788BEF; Tue, 17 Sep 2024 19:03:54 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27E388B0C
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9a7bea3cfso378612085a.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726592631; x=1727197431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pW69Dd/ZWDLGkRpJjqa1BRCxaZfgA2DDKrZsl8v3UyA=;
 b=de/Q+v5uIBzjwL8SqepfCqybNxBcMT+GYhKktnZR+1PtK1f8pKtgDLcHZ/4v38eBWa
 PW5d/10wT3XAjdqNKNk411K38x2Cq3XQmsoQvvqvWXk+4IrMYxS4M+Zgea29ObXpViaE
 m3V1JsbxYvxo0joMCfbWTIyapqEAfWzp2FLic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726592631; x=1727197431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pW69Dd/ZWDLGkRpJjqa1BRCxaZfgA2DDKrZsl8v3UyA=;
 b=OqEPswPt/bCTJ9lwVIeJgW/oc+QK5BGdotM2vHISwHpIatDfYJNAjLH1JqsXJcoEQt
 JkGQqqpaJMY0swad1DbyIjptHSS39tq0qrnPjkYlg6WvUUIMe15HynFyLbuMxIlw2kmx
 4FX1dD+Ks+sUbAkuHi1CwOwVXxEzzeo+ktsxhbXkJo+/gx15inLZgKGcPEMyC1Swi1Z7
 jHxJzrg4IMHMyhJZOLeq8gki04FeIRATJVQFawvMIlpIxF0ypsvnZqktY37uJ6aRuDtt
 jSFl3ZxBaV2gHsoczI7hTbWXye3EgZauMxPcZU7ZwjQHQZ+ZEvqQcbmTwkHxO6d2bTJq
 +qQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRicmemP6Q0omxfPFLE8LdfG6IJSCYMgbzfRyONMQCcEVT6ZytTRdGXCtGaXxdLXU2p2RzyLU=@lists.denx.de
X-Gm-Message-State: AOJu0YynASbYWV+ZSVQpcIHf3aKmja6zQX6A/AqwRWG06nQsIlCUurV6
 rUThVpy/posa01x2KRIT/6iGyiUC3pO6LXD9Um79g9obylxttKoKJ+hnflFtfSw=
X-Google-Smtp-Source: AGHT+IEx4FpJwyjSwIHz6iURcWNfzWqo4L/6plvDg2nHna+KtKCfRL0UERupbOXGObmddFbixfeRzA==
X-Received: by 2002:a05:620a:1a94:b0:7a9:b268:3647 with SMTP id
 af79cd13be357-7a9e5f60e5dmr3248931185a.41.1726592630435; 
 Tue, 17 Sep 2024 10:03:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e98bd55sm377651385a.31.2024.09.17.10.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 10:03:49 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:03:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
Message-ID: <20240917170346.GN4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
 <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
 <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nw+qOvp3LPclOrIy"
Content-Disposition: inline
In-Reply-To: <CAFLszTj47fa7m2Xa4yi5NkcWNUGr4kiM1z4sAnrbd5rFUKq1Zw@mail.gmail.com>
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


--Nw+qOvp3LPclOrIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 05:42:31PM +0200, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Thu, 12 Sept 2024 at 09:12, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >
> > On 02.09.24 03:18, Simon Glass wrote:
> > > While sandbox supports virtio it cannot support actually using the bl=
ock
> > > devices to read files, since there is nothing on the other end of the
> > > 'virtqueue'.
> > >
> > > A recent change makes EFI probe all block devices, whether used or no=
t.
> > > This is apparently required by EFI, although it violates U-Boot's
> > > lazy-init principle.
> >
> > We always did this.
>=20
> Commit d5391bf02b9 dates from 2022, so I don't think that is correct.

Yes, but I also could have sworn that was fixing the behavior having
been changed again previous to that.

> > What problem do you want to fix? I have not seen any issues in our CI.
>=20
> The EFI test in this series hangs trying to probe a virtio block
> device. If you drop this patch and try the rest of the series in CI,
> you will see the failure. Or you could just accept that I investigated
> this, root-caused it and produced a suitable fix. This is a v5 patch
> which has had quite a bit of discussion.

And as I noted an iteration or two back, it's entirely unclear if the
problem is "sandbox virtio is broken" or "this code is wrong here".
Which in fact gets us back to ...

> > > We cannot just drop the virtio devices as they are used in sandbox te=
sts.
> > >
> > > So for now just add a special case to work around this.
> > >
> > > The eventual fix is likely adding an implementation of
> > > virtio_sandbox_notify() to actually do the block read. That is tracked
> > > in [1].
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> > > ---
> > >
> > > (no changes since v3)
> > >
> > > Changes in v3:
> > > - Add a Fixes tag
> > > - Mention the issue created for this problem
> > >
> > >   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
> > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > index 93a9a5ac025..2e1d37848fc 100644
> > > --- a/lib/efi_loader/efi_disk.c
> > > +++ b/lib/efi_loader/efi_disk.c
> > > @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_=
handle_t handle, char *buf, int
> > >   efi_status_t efi_disks_register(void)
> > >   {
> > >       struct udevice *dev;
> > > +     struct uclass *uc;
> > >
> > > -     uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> > > +     uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> > > +             /*
> > > +              * The virtio block-device hangs on sandbox when access=
ed since
> > > +              * there is nothing listening to the mailbox
> > > +              */
> > > +             if (IS_ENABLED(CONFIG_SANDBOX)) {
> > > +                     struct blk_desc *desc =3D dev_get_uclass_plat(d=
ev);
> > > +
> > > +                     if (desc->uclass_id =3D=3D UCLASS_VIRTIO)
> > > +                             continue;
> > > +             }
> > > +             device_probe(dev);
> > >       }
> > >
> > >       return EFI_SUCCESS;
> >
> > Please, do not spray sandbox tweaks all over the place.
> >
> > Can't you just return an error from the sandbox-virtio driver when an
> > attempt to read a queue is made?
> >
> > We are using virtio on QEMU. Why do we need sandbox virtio devices? Just
> > run the relevant tests on the real thing.
>=20
> Please go ahead with whatever approach to testing you wish. But
> sandbox testing is an important component of U-Boot.

Yes, but is sandbox implementing the "just be a state machine" part here
correctly, or not? It keeps feeling like "not" and that the reasonable
course of action would be to stop testing this on sandbox until that is
fixed especially since we can test this reliably on qemu.

--=20
Tom

--Nw+qOvp3LPclOrIy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbptnIACgkQFHw5/5Y0
tyxqBgv5ATspj0FaoKcdKq4ulBdi6L7J7AHOmFfM55GHbzuDeT6oxrxe8WmjfRNB
E4/XcTkEb8NMqbUKaBjGCHSgZ5Owii4mmAjLr9tneojXHScFaH8OKMUL2cjLZpyS
6wCLxopRGGNjoWiATxbu/4rDP5qSQvZzNdOkGGsy4iCTQdt8xJWRR0ohsHbQzB7T
IaQX7iOKvKUBdqF3iSalLMcmVcQHbyqSM/5c2GtGodFv0Lm9G6jGhv0rzUwhxjgt
ML+Tjw3b4WUMGkLFgw1scqHno6sHG79XT2Bx+xQB13XP3b7tw/HI4Ob+MDHFMGuy
PMSvLnQfX/rE0tIVX11Q7aPQ/FJwM0hKS4yKhINxCgAm0DGbvAzLJWdFo8mA5MuE
9K4FKdtgJFHY7k0x9QRixj38sx2n42eOaFeADDTA79r/XJ95bYs5Y0ePFe4lIosB
vPFV2Xl/y7+blacb8BuCk+NmhOVXNQcCx0tT9oXzu9HyS2HPJcoGmCWLjQxWzOHC
+06ztZuo
=xdgy
-----END PGP SIGNATURE-----

--Nw+qOvp3LPclOrIy--
