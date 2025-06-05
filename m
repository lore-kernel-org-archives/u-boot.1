Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B53C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 14:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13615803DF;
	Thu,  5 Jun 2025 16:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l3yxSGGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC1D8091A; Thu,  5 Jun 2025 16:21:43 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFBE80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 16:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a5840ec53dso11253291cf.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749133300; x=1749738100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b1BJy+WErXtg38FHgAarqmngEmuWs5gOIjS26F67izA=;
 b=l3yxSGGpmvZGdWoGM5uDNlYKygqkx/qJ5CT3LTkYIlx40CtCoIlDpOns2Ptsc8Rjop
 ip/IWfv6OWm7wCU24o7XCBFoWK+PszUbEeFKNLMBAiAtkxSQZqEH1rmlPECaCB8VRZQJ
 /7N3INMoA7wRkq3Lck8AKZ6gS1nQWHrjcqnDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133300; x=1749738100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1BJy+WErXtg38FHgAarqmngEmuWs5gOIjS26F67izA=;
 b=ok0xN0wda8Ruj56m33wdWGR6DMVI+EzLhoEy0jMVdtxSrbuvxlS0uYr92gI+5unXwa
 2uFgqGHF2iVS5aXI73P4gGqdG3bHR6VhSA1rKUB9hrLbjkoNXDeRDs8HJbp4az58fE+C
 ZWZxpDNxWD1BUvfPVqujloGsO4ZtW361Pd6vP0cY/FtTYIGI2eLNBmT1XJ7VINRZoncD
 AMpFnpALJ/IOV6qiJpl14tskjv4RBjtXdsnzl3/QSP/KF8wA8fWKLCWWmPyS4ghBBS+D
 t8WFO5BxnxliLlNHUdVbImcVZ7dd2kCb4H54sX6VgORP+UO0H88HcDRdV22rDZZKp8Rc
 xprg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGBniY8aH/Yzh5Xr3iicFfouaYs9sC0KsQySM23NeRowckI4zEoUjERxh9VpmVfMW0JjY+MVE=@lists.denx.de
X-Gm-Message-State: AOJu0YyEIyqiAJSiYJ2rzdEXy8zehIqQi9NY74dwo8+h8OS5oC/jNwUH
 Fyaws+1T6lVQlxj68cX2EliHAfzig5iUTtTj63i9VH+6tToJKn+12I1v23HIm8PeKhqA1WBlZw5
 PCw56eUQ=
X-Gm-Gg: ASbGncuSF5EBgt1doq3K1hHg8JEMUeVV0BYqIYt2bc9W7Z6hxZFch86KRguVT8OLIia
 xupM9ewAt8Q+csW68SWnh8rhhSU2oEoBt08EKPbdPPesvGXdxDcXHmQakCax4zOiCnR4ErBUgLL
 FHfkWrVGyMJ0r2sr8S/tx+SsBaFE8VhQBfW/uVjBnI1NeWcmFmBfJjuH98otBJr7IGa5Xs0g0Rb
 cJK3YDSPgLlhAdZrwQLENawleNi7b8TMcuv9UC/tbtSl5PBBzBD43ZCPytx4WNIoygOVCXkm4mx
 80dbHO/ij80V4/lEEtbcAcw7NjNQb+SbwgDXo4J2qXpAgdRw7Kt2pTbQe4d2T6RYN6NrngwJvSu
 BJOzaudRfB+cE
X-Google-Smtp-Source: AGHT+IFJgt+IQekmVBO6zx6qR8RJ0OKsFP6ipgQpeLiA6SipiVsMzx1ykX9Q1ujfvRVwmxtLV97/kQ==
X-Received: by 2002:a05:6808:3384:b0:402:11c2:253e with SMTP id
 5614622812f47-408f0f6fc75mr6071097b6e.21.1749133289871; 
 Thu, 05 Jun 2025 07:21:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c8b222sm2690447eaf.22.2025.06.05.07.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:21:28 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:21:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
Message-ID: <20250605142126.GV1382132@bill-the-cat>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
 <20250522143958.GJ100073@bill-the-cat>
 <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7S8g7XfPJduch4BC"
Content-Disposition: inline
In-Reply-To: <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
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


--7S8g7XfPJduch4BC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 10:16:54AM +0200, Neil Armstrong wrote:
> On 22/05/2025 16:39, Tom Rini wrote:
> > On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:
> >=20
> > > From: Dmitrii Merkurev <dimorinny@google.com>
> > >=20
> > > 1. Get partition info/size
> > > 2. Erase partition
> > > 3. Flash partition
> > > 4. BCB
> > >=20
> > > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> > > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
> > >   drivers/fastboot/Makefile     |  1 +
> > >   drivers/fastboot/fb_command.c |  8 ++++++++
> > >   drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
> > >   drivers/fastboot/fb_getvar.c  |  8 +++++++-
> > >   5 files changed, 63 insertions(+), 5 deletions(-)
> >=20
> > I know this was posted before I replied with more feedback moments ago.
> >=20
> > [snip]
> > > @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
> > >   	  defined here.
> > >   	  The default target name for erasing EMMC_USER is "mmc0".
> > > +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> > > +	string "Define FASTBOOT block interface name"
> > > +	depends on FASTBOOT_FLASH_BLOCK
> > > +	default ""
> > > +	help
> > > +	  The fastboot "flash" and "erase" commands support operations
> > > +	  on any Block device, this should specify the block device name
> > > +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
> > > +	  The mmc block device type can be used but most of the features
> > > +	  available in the FASTBOOT_MMC will be missing.
> > > +	  Consider using FASTBOOT_MMC on a MMC block device until all
> > > +	  features are migrated.
> >=20
> > A default like "" in order to un-stick configs that are now here and
> > enabling the option is wrong. If we're enabling new functionality for
> > platforms, it needs to be configured correctly. This leads to building
> > code on platforms that won't be used on the platform so we've likely
> > added run-time bloat for no benefit.
>=20
> I agree but what's the solution ? I'll prefer having no default as it was=
 initially.

No defaults is correct here, yes. It's just that the primary
dependencies need to be fixed so that platforms don't get stuck on the
prompt on features they won't actually use either.

Seeing what boards get stuck, and then having an idea on what
dependencies trip them up is tricky. What I usually do in this
situation, to see what platform is stuck on the prompt is:
- In one terminal, fire off tools/qconfig -sC. Then wait for it to
  seemingly be stuck with just one or two platforms left to finish
  syncing.
- In another terminal, 'ps uxwwww | grep make' to see what the build
  directory of one of those stuck platforms is, then manually save off
  the .config file, begin investigation.

That should provide what platform is asking this question and not having
a reasonable answer. Then it's a matter of seeing if it makes sense for
this platform to be here and so just needs to be migrated to this
functionality or if it's here because of some dependency problem, for
example what I was talking about in the previous part of this series.

--=20
Tom

--7S8g7XfPJduch4BC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhBp+AACgkQFHw5/5Y0
tywjJgv/c/Xdi405x3ekFECfWw61oW1zy6DKX6e7JGRdJMq65Bkc8C9+0MNJrQLu
We08Py/2s6N56yRkAMP2OpIEE9pEg5dz809sQUoP5j777gXgNTFVwNC7VotMcAqc
BmtwZXjcOYuzAS3bxDHK03qMkN8iUom9rLH6M3C7FJup+siS0Z/IvZiX3BQfIM8/
lgVg2NGiKfFJAfD1KBn0UwLwWiOR4mbi88t43SahfXtxQbjsJIJ5pCTXIeEQQsRi
W+y9ClgoJ/4VFMBmmmMDcJS76xFiN6Wn0sGATN+Yh5TnDnymkXayt8uw0RgU2lGE
87qJbJ11QEOPsYhakNKpUqUlSeA59gUkHg8GEyuItzq50I6wIKTYYBLVH5vfMK7M
5BaEy8NhuCOH4e9GoQ6r+XM299d8V+tOP4DfJRT6AYZ4jxTDVN3adHx6dOVLz73U
Baa3Hcwa2Z43cedgjituIH1fapcFem4snkU/LUr03i9SvNUxVMVJ6L3cONiu3BrO
258TwD2u
=OPND
-----END PGP SIGNATURE-----

--7S8g7XfPJduch4BC--
