Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16CFC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 08:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5C08837A;
	Tue, 11 Jun 2024 10:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718095890;
	bh=ujDJhuZ89mQIf8PwfYU+M7/4FN5Lwabw4ptIHAR0Vi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mC0qDqeYYOlA6Jc2rBHy9mTU5b0ywrDMyYTQvJp41cI/4HoONNpWrrrCG38GeCIc6
	 TcSX0KlJV8ZyFmYQO3ryIoxaccwl6BACejeLBxddb85s6xBttHDE53elwul2ep+9cS
	 CeUI9p4xM0AQb3nt6BXhAQnte2UqDWETuP5dcw5vglH2KYwCUv6SWb0ZGec4/Xe1Ui
	 3JfGYx2EwFmHFnLAXoxHBnDKvPU736eeu0bCafJdRIPDdaK/ggU/4GVmiH7FuL4Ae8
	 9apfbDn1Ue6KF2K0KP7dp4aRXzsXQ5MhLOcWIQyk4f5Sgodyo2UqHGLF39eZNwecbq
	 TYPOmPlQoSp3g==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D095586FB2;
 Tue, 11 Jun 2024 10:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718095889;
 bh=ujDJhuZ89mQIf8PwfYU+M7/4FN5Lwabw4ptIHAR0Vi0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=y57+Vj7R6lsHSqti0KBjkYihOTEjCnnUaW5Ardy0A6ghMcaxc+bJ8iFpXaiHkUfYa
 g7G7Nzi+3DRajCK9hC94Q8J4qoGQs8PaO+6jSXuUxYF26bkExZRad7610jtUXk/6rn
 6Mi+iVbMxwtUAF5RziHVr4ldDU2zGuOxfekZyVXa9XyXd3z5eBdmKWDY0anGSzusDE
 Scmf5gmFkhgErBekTu9fsCQMDBP/mefD5blzMEopOwwoU0A/ExiZVs5gdhXKGf3D4z
 T29Omq5F2KMFw0AMHX+K253GGgmvyS9GVtG7sgI4FTdwcNM6oO5knrA7puT2jqkLnf
 kcy2meEMnFnYg==
Date: Tue, 11 Jun 2024 10:51:27 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 3/6] usb: gadget: Drop usb_gadget_controller_number()
Message-ID: <20240611105127.3ab8cc38@wsk>
In-Reply-To: <877cew0wu6.fsf@baylibre.com>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-3-marek.vasut+renesas@mailbox.org>
 <877cew0wu6.fsf@baylibre.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jHNIhbfQcAL1YuM8Vd8o8eL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/jHNIhbfQcAL1YuM8Vd8o8eL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 09:20:33 +0200
Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Marek,
>=20
> Thank you for the patch.
>=20
> On dim., juin 09, 2024 at 23:32, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>=20
> > The bcdDevice field is defined as
> > |Device release number in binary-coded decimal
> > in the USB 2.0 specification. We use this field to distinguish the
> > UDCs from each other. In theory this could be used on the host side
> > to apply certain quirks if the "special" UDC in combination with
> > this gadget is used. This hasn't been done as far as I am aware. In
> > practice it would be better to fix the UDC driver before shipping
> > since a later release might not need this quirk anymore.
> >
> > This patch removes the newly unused function. Linux stopped using
> > this functionality in 2012, remove it from U-Boot as well.
> >
> > Matching Linux kernel commit:
> > ed9cbda63d45 ("usb: gadget: remove usb_gadget_controller_number()")
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> =20
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
>=20
> > ---
> > Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Cc: Lukasz Majewski <lukma@denx.de>
> > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> >  drivers/usb/gadget/gadget_chips.h | 62
> > ------------------------------- 1 file changed, 62 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/gadget_chips.h
> > b/drivers/usb/gadget/gadget_chips.h index 98156c312d2..316051686c4
> > 100644 --- a/drivers/usb/gadget/gadget_chips.h
> > +++ b/drivers/usb/gadget/gadget_chips.h
> > @@ -146,65 +146,3 @@
> >  #else
> >  #define gadget_is_dwc2(g)        0
> >  #endif
> > -
> > -/**
> > - * usb_gadget_controller_number - support bcdDevice id convention
> > - * @gadget: the controller being driven
> > - *
> > - * Return a 2-digit BCD value associated with the peripheral
> > controller,
> > - * suitable for use as part of a bcdDevice value, or a negative
> > error code.
> > - *
> > - * NOTE:  this convention is purely optional, and has no meaning
> > in terms of
> > - * any USB specification.  If you want to use a different
> > convention in your
> > - * gadget driver firmware -- maybe a more formal revision ID --
> > feel free.
> > - *
> > - * Hosts see these bcdDevice numbers, and are allowed (but not
> > encouraged!)
> > - * to change their behavior accordingly.  For example it might
> > help avoiding
> > - * some chip bug.
> > - */
> > -static inline int usb_gadget_controller_number(struct usb_gadget
> > *gadget) -{
> > -	if (gadget_is_net2280(gadget))
> > -		return 0x01;
> > -	else if (gadget_is_dummy(gadget))
> > -		return 0x02;
> > -	else if (gadget_is_sh(gadget))
> > -		return 0x04;
> > -	else if (gadget_is_goku(gadget))
> > -		return 0x06;
> > -	else if (gadget_is_mq11xx(gadget))
> > -		return 0x07;
> > -	else if (gadget_is_omap(gadget))
> > -		return 0x08;
> > -	else if (gadget_is_n9604(gadget))
> > -		return 0x09;
> > -	else if (gadget_is_at91(gadget))
> > -		return 0x12;
> > -	else if (gadget_is_imx(gadget))
> > -		return 0x13;
> > -	else if (gadget_is_musbhsfc(gadget))
> > -		return 0x14;
> > -	else if (gadget_is_musbhdrc(gadget))
> > -		return 0x15;
> > -	else if (gadget_is_atmel_usba(gadget))
> > -		return 0x17;
> > -	else if (gadget_is_fsl_usb2(gadget))
> > -		return 0x18;
> > -	else if (gadget_is_amd5536udc(gadget))
> > -		return 0x19;
> > -	else if (gadget_is_m66592(gadget))
> > -		return 0x20;
> > -	else if (gadget_is_ci(gadget))
> > -		return 0x21;
> > -	else if (gadget_is_dwc3(gadget))
> > -		return 0x23;
> > -	else if (gadget_is_cdns3(gadget))
> > -		return 0x24;
> > -	else if (gadget_is_max3420(gadget))
> > -		return 0x25;
> > -	else if (gadget_is_mtu3(gadget))
> > -		return 0x26;
> > -	else if (gadget_is_dwc2(gadget))
> > -		return 0x27;
> > -	return -ENOENT;
> > -}
> > --=20
> > 2.43.0 =20

FInally..... :-)

Thanks Mattijs for this cleanup.

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/jHNIhbfQcAL1YuM8Vd8o8eL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZoEA8ACgkQAR8vZIA0
zr3ScwgAjSfp0m/7jfMaEFDWdCQGR0GtdX+fFRT5KaKrqddQeQ0r3uOaDKXksCk9
zNK9qA7377pFa98RTsdUbdCn7Xs++3FHf6f/N6EvXn2/UGnXmEKIvoXWRO1nRGyh
2En7onpEOfctrUmHGiKkgPiOYsThTeJWYGtuF6VyrMW3qP1boa9RvRGt0UtL5Cwy
wjwrZqv0Uxuvy3LMhpRNnNKw9fZBiFJ7Qbt7MOZf5NXF3wkeEoX1oLT4+MIW03rg
S+eJBGqGMT6wENxq18VfEqQxFVrtADTvZzLcT9V/KMZun2B9BhlaIv0JlIJuSdtc
FA+xjEcnesqwd35lDxeLaDTgA/xrfw==
=KyDb
-----END PGP SIGNATURE-----

--Sig_/jHNIhbfQcAL1YuM8Vd8o8eL--
