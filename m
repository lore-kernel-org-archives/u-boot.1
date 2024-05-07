Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65811C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A147188789;
	Tue,  7 May 2024 16:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kwy1hs5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EE388785; Tue,  7 May 2024 16:33:25 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648B188790
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43d2277d7e1so12125991cf.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715092400; x=1715697200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4K2b83Z/r9vVtptf4Xwb1q5aIJpjHcngOFBBSbYab0M=;
 b=kwy1hs5JhA45hGtSP12Niz7qHUYBjFupw/4PnDKHIQ3UYB+RMI4KnmMeQKZGMHgJPM
 jndktVVIn/AmI5OvtVgJn73gkqauj4GPF36v+3ej6xm0EdzfgrlVErp6aYG6kz5wifJa
 cx5d3Hs95xNQhhJlumAcAOBiSfUJVWDvN9gYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092400; x=1715697200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4K2b83Z/r9vVtptf4Xwb1q5aIJpjHcngOFBBSbYab0M=;
 b=w9Nq2CGdwzjFXWUDilNrVaFV7LhWWrjketXoYIg4IZJncKOUh4UGCy8a9rkdkrZKZ5
 Atx3dds0pVH3swU8LmVwUdIqmEusguFS5IDR+H3kumCurzNvkyolTFg8yHkzpXsyDoT9
 /5xczGldcG7hdRsbHvHxmOP1xFBoB6Ia2CaZcsJWRXCbw7im6emIcHV61speyFV+/1yu
 FQlfqFdqyL8zTWuOqBRnzSXWgoYdN2XUvoYa7s+ngxjN0h3AtrGYzDcosQtZF0xFP32f
 NuBRiKMUEMCVvZmUrfhLI7BqLWw7Hstjlv9ORgHyvzdKiPhso5hCv84k14VpSIvYzWqG
 LnYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+17I3UK1fC4HB/A/ZC0zTufm6ruYvRYTeEVkC7lwAvZH8M+sDf+S2CdyJy+XaamIP8op3kfSghZhne4BAWF0j77ESHg==
X-Gm-Message-State: AOJu0YyCnQMfhyw/z5Nk5EyhzDztiF//Pm6X9dsTFVXPlMqQFcx7X4cy
 Wv/56zkpaykuz6wMZy6WYHVldKW2ej8A18XvOq2BUHcXuP3c/ILlnZFOV6AN9sQ=
X-Google-Smtp-Source: AGHT+IEYt47kjWzMS0N17uefFvlXk7FXnTUStbtq+GMiGdOWphoEOs+Pi0x24LdV8bqZlq8qiPz9WQ==
X-Received: by 2002:a05:622a:491:b0:43a:b531:5e6f with SMTP id
 p17-20020a05622a049100b0043ab5315e6fmr17598545qtx.62.1715092400233; 
 Tue, 07 May 2024 07:33:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 br11-20020a05622a1e0b00b0043cd877f828sm5805137qtb.45.2024.05.07.07.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:19 -0700 (PDT)
Date: Tue, 7 May 2024 08:33:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v5 4/6] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20240507143315.GT2568172@bill-the-cat>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
 <20240506143846.1252377-5-martyn.welch@collabora.com>
 <20240507081428.GA17112@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4CMIdEcO7TDfrj0j"
Content-Disposition: inline
In-Reply-To: <20240507081428.GA17112@francesco-nb>
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


--4CMIdEcO7TDfrj0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 10:14:28AM +0200, Francesco Dolcini wrote:
> Hello Martyn,
> first thanks for your series, with this we might be able to drop some
> downstream branch.
>=20
> On Mon, May 06, 2024 at 03:38:44PM +0100, Martyn Welch wrote:
> > From: Sjoerd Simons <sjoerd@collabora.com>
> >=20
> > Provide config fragments to enable USB host as well as USB gadget and D=
FU
> > support for a53 and r5. This relevant fragment is included into the
> > am62x EVM a53 defconfig. For the r5, due to the smaller available size,
> > the config fragment also disables support for persistent storage to free
> > up space for USB support. This fragment needs to be included is DFU
> > booting is desired.
> >=20
> > The CONFIG_DFU_SF option is placed in the defconfig rather than the
> > fragment as this is known not to be supported on all boards that can
> > support DFU.
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>=20
> ...
>=20
> > diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.c=
onfig
> > new file mode 100644
> > index 0000000000..772bb2ab93
> > --- /dev/null
> > +++ b/configs/am62x_r5_usbdfu.config
> > @@ -0,0 +1,28 @@
>=20
> ...
>=20
> > +CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> > +CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
> > +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165
>=20
> This is making this fragment TI _board_ specific, while the file name see=
ms
> to imply that this is generic for the TI SoC. Other vendors, using TI
> SoCs, will likely want to use their own USB IDs.
>=20
> Not a big deal and no need to change it, we'll handle this in our own
> defconfig when we'll enable this, but I wanted to mention this.

One thing about fragments, at least so long as it's being processed
correctly, is that "make fooboard_config fragA.config fragB.config"
means that fragB.config will override fragA.config values. Not that it
shouldn't also possibly be re-done as either of:
1) am62x_r5_usbdfu.config + am62x_evm_r5_usbdfu.config
2) better use of imply keyword perhaps in the SoC stanza in one of the
K3 Kconfig files.

--=20
Tom

--4CMIdEcO7TDfrj0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6O6gACgkQFHw5/5Y0
tyx1Cwv6A8KVsHFXPKIPyug1w1Alglqr8/b4103AYUsg6wr9A7qovP+uFiQ09Sdc
I6pjTDdB+CTFWIh8sp7pEHFJwxHpuN7sLyNnFrCeR+G34gtW8rae4rqhxpPAfxjy
r2REFKz0TYAe4ecxxfLbbBn0bHhzI1IoB+zR4yi7lhFB5bwtrviDg2SEajqjga1Z
yLVnfoCPD22Bt/1nQdezTn37YIquIxEiD7hh8LBxFwpFOP7JI3DYJF058J182kjK
mHkUUdy0iJZAV/KdrMEmeZ8IpZHVOVs4MVvOZpGuB6wnaxsT9qhdn/q6lkbCGiwm
3ZnKl1QsUnuoaOYzLvPkkKgM4PVhypRCYYgPHnKJ3elNFGdAp/l4GXdME2V6ZOLq
eVD9WMD/PfbxZQ9SimP7McKqRX9l+j0fASxaxjKcZhhh0A4wD8lmmu+6HzcrnuV+
Nun5upEOsnfFuWx0vrZPgOxNxaPBauCw/c6eVAzWZOYlKHXBEiBC34Kuo/26h1ND
IsfxPJXL
=q7Hw
-----END PGP SIGNATURE-----

--4CMIdEcO7TDfrj0j--
