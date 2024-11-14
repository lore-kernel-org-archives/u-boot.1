Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED705D68B26
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B63895DA;
	Thu, 14 Nov 2024 15:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Em1kAmPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC946895EE; Thu, 14 Nov 2024 15:26:07 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D7C89584
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e601b6a33aso404799b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731594364; x=1732199164; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5aRHZP4n70vw54+0lCB/MaLlOruOBPWKczK/Ca+Qb4U=;
 b=Em1kAmPMGnTmIZ9b8xF5h6yMGSHlAOyUnXj70AFfBJnFXSyeK9hckGtHiAyMJKj1nf
 FUnDxvTN8+YmS5n+4OqVaIRxuVN5iV6mIGEKkLjHIOpw9qAz0eAQA1jWNvTXB8c+mFxE
 2kfAwqkikfs4KnruPXVEBbK7263Bn7Dpp1zJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594364; x=1732199164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aRHZP4n70vw54+0lCB/MaLlOruOBPWKczK/Ca+Qb4U=;
 b=XBVDbs8N3xlLqxVOpK/lNwvnxT4yrDaY6w6BZpKlfj/QnDVlJwC6WZ9VcQb9+dZ3OF
 Bk+WG/eccl0Ruks/T8VfFca/TXwCQIR4NT1iehK34AUqTnBnVbnklIFDD/Aoe5faE6Fu
 d2KH94wVUQnrT6txd0e2WBlwoGGpaomOSFd8EACh/NiD82yLF6MArzI9EWLnpFx4rbO1
 WSLEBX9t1Di7O1LpKAm6j7iueXHR+9HXZ2GAvv+s7PZU5x9SK1i5D1jH9DpdLAOergxM
 A9JtP/lbqbMZ82U/o7InmTKqlqC7TziGV1StKk74t5sQSeShvFmtGgKS1NcMK+OqkWKS
 WNuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPk5GjN6U0iUhv3N7IUstVxsUgmjVpQMwq49gR/rZzACi40cyFaiSzke7olH+PbKuFlT0KXjc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv+Sykl8xQovgFaCbELo4y/XzPco1eLdeNZtFsGZspFh7ffrux
 q1XUFt/uooFQ0Ki9MmcZ8uDfJTBMClg4lsKbg+XFafvONmqGkaDVNv+rpwGBZS8gMqoCcjO7LaC
 7vgg=
X-Google-Smtp-Source: AGHT+IHligFpqn+mZZ0bswYQ3lCirU6A+sEneZO56Spjr4t7CdEto7b3e/4JOdeQn9abuT7m79lD0A==
X-Received: by 2002:a05:6871:401:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-295e8dcc8f1mr7078285fac.22.1731594364065; 
 Thu, 14 Nov 2024 06:26:04 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5eea0288140sm326813eaf.41.2024.11.14.06.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:26:03 -0800 (PST)
Date: Thu, 14 Nov 2024 08:26:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
Message-ID: <20241114142600.GE3600562@bill-the-cat>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
 <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
 <5FA71CBD-F9AF-442A-8564-4F663F44BF42@gmx.de>
 <CAFLszTi9As9YFFoWuD9GW6gHpriZSNVCFmq5fKkdCi9jeRuqjQ@mail.gmail.com>
 <C4EB5D10-D037-49BE-BE0A-00BD3D1514FC@gmx.de>
 <CAFLszTiaDi7Sbrjsjt42UObz1Nb8SqM8CFBdcTOAXih3pJV3PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ntsaXWzuzHa4Zo1/"
Content-Disposition: inline
In-Reply-To: <CAFLszTiaDi7Sbrjsjt42UObz1Nb8SqM8CFBdcTOAXih3pJV3PQ@mail.gmail.com>
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


--ntsaXWzuzHa4Zo1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 08:53:17PM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Wed, 13 Nov 2024 at 11:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > Am 13. November 2024 17:03:03 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> > >Hi Heinrich,
> > >
> > >On Wed, 13 Nov 2024 at 08:17, Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >wrote:
> > >>
> > >> Am 13. November 2024 15:39:22 MEZ schrieb Simon Glass <sjg@chromium.=
org>:
> > >> >Hi,
> > >> >
> > >> >On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron.glpk@gmx.=
de>
> > >wrote:
> > >> >>
> > >> >> On 11/1/24 21:29, Mark Kettenis wrote:
> > >> >> >> From: Janne Grunau <j@jannau.net>
> > >> >> >> Date: Thu, 31 Oct 2024 23:48:02 +0100
> > >> >> >>
> > >> >> >> DM_FLAG_VITAL marks devices which are essential for the operat=
ion of
> > >> >> >> other devices. Removing these devices before their users can r=
esult
> > >in
> > >> >> >> hangs or crashes.
> > >> >> >> This potentially fixes EFI boot of Renesas rcar3 devices. Their
> > >clock
> > >> >> >> devices (and with this series the dart iommu) are the only dev=
ices
> > >> >> >> markes as vital.
> > >> >> >> The arm boot code already handles devioce removal in this way.
> > >> >> >
> > >> >> > There is a typo in that last sentence of the commit message
> > >(devioce).
> > >> >> > Otherwise:
> > >> >> >
> > >> >> >> Signed-off-by: Janne Grunau <j@jannau.net>
> > >> >> >
> > >> >> > Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> > >> >> >
> > >> >> >> ---
> > >> >> >>   lib/efi_loader/efi_boottime.c | 1 +
> > >> >> >>   1 file changed, 1 insertion(+)
> > >> >> >>
> > >> >> >> diff --git a/lib/efi_loader/efi_boottime.c
> > >b/lib/efi_loader/efi_boottime.c
> > >> >> >> index
> > >4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86=
b1804cd848b6
> > >100644
> > >> >> >> --- a/lib/efi_loader/efi_boottime.c
> > >> >> >> +++ b/lib/efi_loader/efi_boottime.c
> > >> >> >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI
> > >efi_exit_boot_services(efi_handle_t image_handle,
> > >> >> >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
> > >> >> >>                      udc_disconnect();
> > >> >> >>              board_quiesce_devices();
> > >> >> >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL |
> > >DM_REMOVE_NON_VITAL);
> > >> >> >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
> > >> >>
> > >> >> Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") add=
ressed
> > >> >> the same issue for bootm on arm. But what about about other
> > >architectures?
> > >> >>
> > >> >> This logic should be moved to drivers/core/root.c instead of
> > >replicating
> > >> >> code.
> > >> >
> > >> >We could have a common helper, but it should not be in driver/core =
as
> > >> >this ordering is more of a policy decision. Unless we can add a
> > >> >parameter telling dm exactly what to do...
> > >> >
> > >> >BTW, Heinrich, this behaviour is exactly what my bootflow_efi() test
> > >> >was supposed to check. But since it doesn't have the
> > >> >exit-boot-services piece at your request...
> > >> >
> > >> >Regards,
> > >> >Simon
> > >>
> > >>
> > >> Why can't we generally remove non-vital devices first if all are to =
be
> > >removed?
> > >>
> > >> I cannot see anything device specific here.
> > >
> > >No objection to that...but it needs to be in a new function, not becom=
e the
> > >default behaviour of dm_remove_devices_flags(), which is supposed to do
> > >what it is told and in one pass.
> >
> > dm_remove_device_flags() makes no specific promises concerning the dele=
tion sequence and its internal working.
>=20
> Do you mean in the function comment in the header file? We can
> certainly update that.

That seems like "fixing" the problem by documenting that things should
work in the seemingly broken way.

> > But obviously it will fail if non-vital redources are not deleted first.
>=20
> Either I don't understand that, or I don't agree. Can you give a
> specific example?

The Apple IOMMU? That's what got this thread started.

> > Leaving this broken function exported and writing a new one has no user=
 benefit.
>=20
> This function works fine. It is not broken.
>=20
> >
> > We could copy the old function to a new static function that we call as=
 needed from the old function name.
>=20
> Yes, that's fine with me. Also, did you see my note about the
> bootflow_efi() test?

But since your test passed (I assume) and real platforms are failing and
requiring a fix, I'm not sure this is a strong argument? Or did you have
a patch in a later series that fixed the problem here as well?

--=20
Tom

--ntsaXWzuzHa4Zo1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2CHgACgkQFHw5/5Y0
tyxPEQv6A44fiIHd56bagTvaisgx5FtozDwQGOApVfSnbVvTe4t2qONL2EyuEI47
J5JVRtB+AZ4GwypBTgHo+Ew59POh2BoJeNT9NqOqNeG5PBiPAmzrVqtCAkX27mv9
gJOjnoY+EBFsiotwvR+8WJlMGTiU5f2nNXQia7+isCjJcXLEXjYU1y64/VcVeSrk
qwIuSlim1tB/gNuBmO7i2hAlPJtMHN797PavleVvf4HF3HXI/QJMOcXqg9oNurHC
Y/E7ADxh/CwJpwion4OBcwjWqCWvmEEDHavbtY6+u48el82KDOHtGMB6N6BtKyZ9
zKoVgaNRkIhx03nIhbdTrdzPuC7m6yeIJeZ8RK9zKzGrMu6VdMphkFA//SqkTizj
f7OIBiv2NIq7Drm99UqGRN7eiKQuHynATmnyI8UDO8gStESh2Pl6M7ryaOvfVvvI
gyxdkU1kaLwsDX6zvYMQQOYZfMPPqCmS166mZyrJKOTLyyKckWN7hc54lEIP4hHv
FOKs0mIU
=CZWH
-----END PGP SIGNATURE-----

--ntsaXWzuzHa4Zo1/--
