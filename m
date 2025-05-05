Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD885C3ABB9
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 22:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1169C8007D;
	Tue,  6 May 2025 00:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F6RzTKYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB7E38269F; Tue,  6 May 2025 00:10:31 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494858004F
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 00:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4034118aeb7so881101b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746483028; x=1747087828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ec8gG03amiKJg2L0Qk1KdpgdnVKn7dY/aoB8R4mvK8k=;
 b=F6RzTKYiMf70u8ojQ19kQYNUBBaFY3mOahk3NiFesz/m74+v1kep7DmYkLnFp5rUqP
 X2JNRixov9MlZ3KiBJBqHg2YCSu77iS4JoxmwlVlIUWfSBEy2bJZSRiri32VOXUbClbl
 hu8TDHRJPh2e6kItVc2aqcF6VQhTh8oUpv/W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746483028; x=1747087828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ec8gG03amiKJg2L0Qk1KdpgdnVKn7dY/aoB8R4mvK8k=;
 b=XTjxv+QvOL7jKGRdtFueKXQvEPUNzrRTcgU2ihTzYET6DzO9lR4+aehGx00WhwYQhL
 Q60crWZiwDoohXKlLNXep91nAR8Wuvv1JdEjM+J4oZFvrRc8S2k7paI/W8Wzkj2uywJ/
 z6LIjZen8gX2MhtPnFaLUhwq5ZCN2QloD4/mwgISiN3PzQpT46VnMmeUaE2l1Gr9Tble
 NJDe/qmK4LUlIqiicMfoxfpdwvobXgVn9CH6xFDIMZ/z4/b834OLsYNP/Fym49kUYS+j
 hIlUiEDn23rvxrb5nnFMUwcsLQ26NYE++59r/jC7D0AMauq21xd8tws7MNlBDotDRTW6
 AAVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmz6e3H5IVBe7IgHz2U4D12uZtozxoJ3YFJOm3aYlWeBPhRlv7VXzSCq2V0dF5JQ4Cr6cpiJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YwoWPSBQrNpKNFqJ0UgOd/IqjGwWBsSRTHKYCr0hJuNsUH/ma99
 S6niRgkjdgxw+u7f3Y90Oe0LBsQ1UidZnRurBRDrs+BvQTTzgqKWtNvWEPnPEq8=
X-Gm-Gg: ASbGncswDWPRm8SxNtkaMTFZ00fmKG9ysxrCvASbSmx3/+xHoTdFvWwtGVKcVwAJMcL
 xmEKmJXBG+PkKUe1Nz2qFzvPbHa4PGmUkQRGYeAplLwcZYTNcF10ZWZlfAB2qYBaBf5hO8RKbdc
 qaNuhOYVko8D+9k086p7UGnz+fzCObgjHEzZ+AWX6U0JiUC2RBQgzQbUck9qUiiXFP9bo4F2D0N
 fAjuJBnhkId2RrbKkUlnkF/FMjpZCVqLudEF4DJvkMPasxPkXvU4N80XgbFcK7cNfeMfT8HwH20
 vtGSY87rMd0za0g5kvlHrQTAlFgCH4u8LS7yTq2Chvap9MhDgzD/vi0T/cg8fCFc02UN2VGU4MP
 ofA==
X-Google-Smtp-Source: AGHT+IEUOKnTfavkUFmdYGxQ6mgjThwO/4F/TXOGyTLSrqYWQvMjyBWppAlm3c7q3C84dr32w72cEA==
X-Received: by 2002:a05:6808:1987:b0:3f8:889e:c13c with SMTP id
 5614622812f47-4035a5483f5mr5573094b6e.1.1746483027917; 
 Mon, 05 May 2025 15:10:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dc828a3sm2167219b6e.41.2025.05.05.15.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 15:10:27 -0700 (PDT)
Date: Mon, 5 May 2025 16:10:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
Message-ID: <20250505221024.GR5430@bill-the-cat>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
 <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4D5/RLHDXXEmXCbU"
Content-Disposition: inline
In-Reply-To: <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
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


--4D5/RLHDXXEmXCbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 12:07:20AM +0200, Heinrich Schuchardt wrote:
> Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:
>=20
> > On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt wrote:
> > > Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 2025,
> > 21:03:
> > >
> > > > > Date: Fri, 2 May 2025 18:08:56 +0200
> > > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > >
> > > > > On 5/2/25 16:49, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > >>
> > > > > >> The EFI boot manager bootmeth does not require variable BootOr=
der
> > to
> > > > be
> > > > > >> preexisting. It creates this variable.
> > > > > >>
> > > > > >> Signed-off-by: Heinrich Schuchardt <
> > heinrich.schuchardt@canonical.com
> > > > >
> > > > > >> ---
> > > > > >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
> > > > > >>   1 file changed, 3 insertions(+), 18 deletions(-)
> > > > > >>
> > > > > >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > >> index 42b8863815e..1669cbed5bd 100644
> > > > > >> --- a/boot/bootmeth_efi_mgr.c
> > > > > >> +++ b/boot/bootmeth_efi_mgr.c
> > > > > >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *d=
ev,
> > > > struct bootflow_iter *iter)
> > > > > >>
> > > > > >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct
> > > > bootflow *bflow)
> > > > > >>   {
> > > > > >> -       struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> > > > > >> -       efi_status_t ret;
> > > > > >> -       efi_uintn_t size;
> > > > > >> -       u16 *bootorder;
> > > > > >> -
> > > > > >> -       if (priv->fake_dev) {
> > > > > >> -               bflow->state =3D BOOTFLOWST_READY;
> > > > > >> -               return 0;
> > > > > >> -       }
> > > > > >> +       int ret
> > > > > >>
> > > > > >>          ret =3D efi_init_obj_list();
> > > > > >>          if (ret)
> > > > > >>                  return log_msg_ret("init", ret);
> > > > > >>
> > > > > >> -       /* Enable this method if the "BootOrder" UEFI exists. =
*/
> > > > > >> -       bootorder =3D efi_get_var(u"BootOrder",
> > > > &efi_global_variable_guid,
> > > > > >> -                               &size);
> > > > > >> -       if (bootorder) {
> > > > > >> -               free(bootorder);
> > > > > >> -               bflow->state =3D BOOTFLOWST_READY;
> > > > > >> -               return 0;
> > > > > >> -       }
> > > > > >> +       bflow->state =3D BOOTFLOWST_READY;
> > > > > >>
> > > > > >> -       return -EINVAL;
> > > > > >> +       return 0;
> > > > > >>   }
> > > > > >>
> > > > > >>   static int efi_mgr_read_file(struct udevice *dev, struct
> > bootflow
> > > > *bflow,
> > > > > >> --
> > > > > >> 2.48.1
> > > > > >>
> > > > > >
> > > > > > How do we know if the board is using EFI bootmgr? My understand=
ing
> > was
> > > > > > that this was a way to find out?
> > > > >
> > > > > The boot manager must always run.
> > > > >
> > > > > The check for the BootOrder variable introduced in commit
> > f2bfa0cb1794
> > > > > is a bug.
> > > >
> > > > Well, at the time the boot manager did not attempt to boot the defa=
ult
> > > > path.  So there was no point in running the boot manager code unless
> > > > BootOrder (or BootNext) was set.  And of course before that commit =
the
> > > > boot manager didn't run at all on non-sandbox builds that had the
> > > > standard boot stuff enebaled.
> > > >
> > > > Anyway, I believe the thinking behind that commit is still sound.  =
As
> > > > I explained earlier, I think that...
> > > >
> > > > > The boot manager handles in sequence:
> > > > >
> > > > > * Try to boot as indicated by BootNext.
> > > > > * Try to boot as indicated by BootOrder.
> > > > > * Try to boot default path for available media.
> > > > >    This will add Boot#### entries and update BootOrder.
> > > >
> > > > ...doing this all in a monolithic sequence isn't the best way to
> > > > handle EFI boot in the u-boot ecosystem.
> > > >
> > > > Your series moves the boot manager further down the list because the
> > > > third step in the sequence has to happen late.  But as a result
> > > > BootNext and BootOrder processing will also happen late.  So what
> > > > happens if you have a board with two OS installations:
> > > >
> > > > 1. A generic Linux distro that boots via EFI.
> > > >
> > > > 2. Something like Armbian that provides an extlinux.conf file.
> > > >
> > > > Currently such a system will probably boot OS #1.  But after your
> > > >
> > >
> > > This did not happen with distoboot. So migration from distroboot to
> > > standard boot results in a change that you want to avoid.
> > >
> > > changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
> > > > BootNext that will not change anything.
> > > >
> > > > So I think we need a solution where BootNext and BootOrder processi=
ng
> > > > happens early, like we do now.
> > > >
> > >
> > > As of today BootNext does not invoke the boot manager.
> > >
> > > If BootOrder is set the boot manager may fail because not all devices=
 are
> > > detected as "hunters" have not been running. E.g. nvme scan and usb s=
tart
> > > are only invoked after the EFI boot manager.
> > >
> > > I originally suggested to probe all boot devices before the boot mana=
ger
> > > runs, but users complained that this slows down their non-EFI boot fl=
ows.
> > > This is why I now move it after all boot methods but PXE.
> >
> > Can we not see what BootOrder is and then ensure it's been "hunted" ?
> >
> > --
> > Tom
> >
>=20
> A load option may only contain the partition GUID and the file path. In
> this case you wouldn't be able to tell whether it is for an NVMe drive, or
> a USB stick.
>=20
> As numbering of devices cannot be expected to be stable, it is preferable
> to use this short form of device paths for load options.

Ah, OK. So could we check and if not found print a human understandable
error message, and continue on? I want to figure out some path that does
not change the pre-bootstd behavior.

--=20
Tom

--4D5/RLHDXXEmXCbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZN0sACgkQFHw5/5Y0
tyxGkgv9HYwrur1jjSwDsq+p7KNp52HBlk3ZNteUhMjlI/ibZrmefUVbbVsCqLTS
RnN6S7S4kZIFn7D9cHLecHUqr8uSECFK0CbKBCefUH41/CmxVQtx2TrCssKZ97R7
f1YMJcPY25I0LLM2nnUY8BvD6aMBOzoCvHvN5ffAiGQp/tAZk+Acijm+jd95c85B
U36PvdvbNK9xpE2h2zOfSq5wjM0oRdc5ZX9keswMpdMEzWfFFOdAOAljKpPDiOBK
rqfi4pNHpcpPoiaPltm09QRyWqO8z92DX6ADmcBq2hWOu7y31Cul2gtB24FxuBZz
tkWc5cZhbedXf+CkPgwP7fzqHvqBQiygmLYTqrwx63ev4cQcK6r/8tJ9m+uiTYht
n2nw0i9yeotIL02Vy3sD11YBwhlVe8NTeQ/xMiuBnBpdE8j+/hz80MFICIkpU/AO
oqtmIatwcbqwWp8rDkTc9ztWbH/KItQ15XqvRRackmHDvj57crLWeUlQ3506eykt
g86icbpE
=/WEu
-----END PGP SIGNATURE-----

--4D5/RLHDXXEmXCbU--
