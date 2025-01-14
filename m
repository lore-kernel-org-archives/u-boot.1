Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4344CE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21E9806B7;
	Tue, 14 Jan 2025 17:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pSBtvXzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00E2806B7; Tue, 14 Jan 2025 17:59:05 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C238022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dcf63155b0so25891426d6.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736873942; x=1737478742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jdhy3heHRXU20Ejbzgm4jYVvedFSNfOUZ+uMnROk6Sc=;
 b=pSBtvXzlr6dNJ/z6qu6kdxCRQOLeEmfstI3N7yTH4vW6AW9BurdBH+0F8eCBkKulF2
 IGRwKNH2j4w5ruXoKeXIDbP2atzkuk8AERwOvHblMr1sOuXaiJhdL4kUa2/L8KCnMEcc
 uSZJuKQ4taTubCYGGxo9W44bjFvT06eb8ULDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873942; x=1737478742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdhy3heHRXU20Ejbzgm4jYVvedFSNfOUZ+uMnROk6Sc=;
 b=TxSNTIUaNXeyc8FYiEIcjqL/q7GVUVIeqygdoiXaR9+xDWgOZ2va9GyWaHrAh5+Mry
 HdmZa36XG+lZifC/iN0r7IRZ15fq+9OJej8Wgf9u/rVi8Ffo6ixd+Z1/QIjRcMNpO2cE
 BcM4/Z30uGxQ3db/nrIu685fWs7czWLUaIzZBVk6mJHl6nTPyjwTO9hSwIM6RTre8Q8l
 4uZVXFBHqCQ/R2lYbR5wEt4XJGbsJ6aM5vdaGnNms+Mv77/dxDvW7XaW4LzMS7jkoLjj
 FD2fY5OSIhG7W9h8/NeS+kkjntfuOop7UWR+UZ+xTH1P087b/DqNGJtaA9R5AkHgCEyA
 Wkkw==
X-Gm-Message-State: AOJu0YwzaVB9UMlIcxmTbvBbviQ6uoTav/DrgzYaX22u03WEUB8xOs6H
 vIwndqzkWrcmECZc7y4ZYhZ82zP3f3h+wHjRETCyx2lPlTKKbNEDBdcp7LpY/iA=
X-Gm-Gg: ASbGnctjrhCkhzH0RbRto1FdTjUXI9gpBe8wj1JxCw9LzzAY+O99VZFnp8NkgmS8/VJ
 1samyExVbs5AZ2RKQWBpG/j5lGXakQ0tAdBO3wb0vm/ecQmFNNcnVRkwGDGTLmv8C7YhXuRvvbM
 58v5iDKU0W76OhmlFoV2L+mhTrfsrA1da1fbnz7cp/FTX6LqNffrO4Bv3B0H2yGHxiqDR/yaaEi
 6tsqSifnL3xP77o7NRAOHVJkgu/C/p9fgsOZ/6/kL2UeuU2RJaIxA==
X-Google-Smtp-Source: AGHT+IH/SiMfsCy0Epyp9b0mKNoI462uw3+4ancwORYWpCfb/pKCB2q5T+gw7RBQMhI9JnKRPrreKg==
X-Received: by 2002:a05:6214:810e:b0:6e1:69ba:346 with SMTP id
 6a1803df08f44-6e169ba0649mr154053526d6.10.1736873942468; 
 Tue, 14 Jan 2025 08:59:02 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873215dbsm54481161cf.5.2025.01.14.08.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 08:59:01 -0800 (PST)
Date: Tue, 14 Jan 2025 10:58:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/6] blk: Make block subsystems select BLK
Message-ID: <20250114165859.GM3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-5-trini@konsulko.com>
 <9fbdbdbc-6708-443f-95a8-e04ee67dbd5e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8UE0mMSjmTz+NrTW"
Content-Disposition: inline
In-Reply-To: <9fbdbdbc-6708-443f-95a8-e04ee67dbd5e@cherry.de>
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


--8UE0mMSjmTz+NrTW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 02:45:25PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/20/24 11:22 PM, Tom Rini wrote:
> > The BLK symbol has a few meanings, one of which is that it controls the
> > driver model portion of a "block device". Rather than having this hidden
> > symbol be "default y if ..." it should be select'd by the various block
> > subsystems.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >   drivers/ata/Kconfig    | 2 ++
> >   drivers/block/Kconfig  | 7 +++----
> >   drivers/mmc/Kconfig    | 1 +
> >   drivers/nvme/Kconfig   | 1 +
> >   drivers/scsi/Kconfig   | 1 +
> >   drivers/usb/Kconfig    | 1 +
> >   drivers/virtio/Kconfig | 1 +
> >   7 files changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index 4fbb63a148ac..29ceab849c02 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -1,6 +1,7 @@
> >   config AHCI
> >   	bool "Support SATA controllers with driver model"
> >   	depends on DM
> > +	select BLK
> >   	help
> >   	  This enables a uclass for disk controllers in U-Boot. Various driv=
er
> >   	  types can use this, such as AHCI/SATA. It does not provide any sta=
ndard
> > @@ -9,6 +10,7 @@ config AHCI
> >   config SATA
> >   	bool "Support SATA controllers"
> > +	select BLK
> >   	help
> >   	  This enables support for SATA (Serial Advanced Technology
> >   	  Attachment), a serial bus standard for connecting to hard drives a=
nd
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> > index 5283d8981e09..cc75bad02b8c 100644
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -1,8 +1,5 @@
> >   config BLK
> > -	bool # "Support block devices"
> > -	depends on DM
> > -	def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
> > -	def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
>=20
> I believe you missed adding a select BLK for the PVBLOCK symbol?

In this case, PVBLOCK was one of the few (as it's newer) symbols that
was doing this correctly.

--=20
Tom

--8UE0mMSjmTz+NrTW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGl9MACgkQFHw5/5Y0
tyygugwAmYimqNHj5ROMncbDOw4x+iJG0503sAk0KJx5WFCPhxnxlpcZs7vuTB+E
WwcjGk3lXbh0+DOsuesMuGJEuldK5jURU85ZFmu/Uv8SEEKa/MzXGlbb3IGxRrzc
8G84mIijVIQ4e/lUkcyPsfwJXI4Y7KtX0VQcl3UVuVtqCabcQ8S/1pQu+qcOcYrp
H3kJnMfmjo4Pr85mFWQ4Bo5wT56S60Tzz1eiPB6g+mcSArdOYnd46hPsqIjZeHbn
FdATvLEStZHQeSB7ytjcQITTNpXUHaD+rTC0xCkRUpUJkYP+XDIPaEdx07lPsP3H
K5MByp7FLMNxaJ6JOc9Lqbsy1ny4vjXQdGLfv7Za9HRz+/oy9q8dLzsJuUwASNyZ
yrNsie1+4ujiXiq+xBAAbMbUZC/hSfxYj+3OobydRoeRjNFHDD6+jvL0Jv7KPHbc
eaoh3llEh0Nh3oCNm2Thh4zHTy/dPFqZwYoA++7RaGggcHTFre2NGFAztTtS9CAc
TFXZ/toi
=Hs2Z
-----END PGP SIGNATURE-----

--8UE0mMSjmTz+NrTW--
