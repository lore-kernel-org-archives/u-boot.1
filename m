Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAC0F46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 15:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC6C8352B;
	Mon,  6 Apr 2026 17:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JwLbIF/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F68A83C2B; Mon,  6 Apr 2026 17:41:12 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1E08341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-470145d7e07so1205295b6e.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775490069; x=1776094869; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Yd/zp2PVDwG/4WGZGWSARs9WR+Czvsz8TIQsuRBDlg=;
 b=JwLbIF/xtyrsz3x7zKtKOmBgssUQ6l1ef8C3XCwby0yDEPjbwmWYc9ymQLiz5CxgOh
 gzbTD7HdO0zigNcfAeQADEQgcpNDm2XBwJ1rmXEk0IQMAQp6uGVNYpKvyY4ll7r8yLIc
 zfNF4I58bqHNTT4qlWfFDK0+C65gX5/u6VysA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490069; x=1776094869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Yd/zp2PVDwG/4WGZGWSARs9WR+Czvsz8TIQsuRBDlg=;
 b=cg97MaP6sAI9DmKIbriZq6BeiN9bRtInigCewee1PoN9BvnS6h8K2kZBcu1qBm/9He
 csRw5AJfah/IqD6WKEPj05RQ3As12ym6i01s0ZKpYsXb3tuFcVQTfGdKaplBxvcw0Q/Q
 uWSJ4UdVTk5nTf5C9QRu5j0dGiDGbx0qbO5DRJrNcvDdO87mpmw85JOxz5rnLWlZPpoX
 5MA8bOtN+jOTvoLEOsv3jwwyZ1NcU5p9UmW57QbKqnsw4C7UlKNzdhv4oJEnI6/D7z1w
 A9fL2TH0LSaTa9Bybw+UeSigD44+Ma0iEGgyBWWWtnUzbOYTimGWS2jEmDIXkB79Pi88
 Bemw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Pb6ZsvNrwE817CixcRCRhBSP9MsIca8P5VaUJaxV3PVtilhfpkmT/AdVRUIpiVBazrt0u8w=@lists.denx.de
X-Gm-Message-State: AOJu0YwRttr+3yIXQkPVg69huc+YRbpLNXGsxEf/IwNVYghzcEMhCzen
 KF8lYSTT2tCyOWuHqvs7NlhlaQTg3KZMZjxhIGkyzhi6wBMO4TVqlAd6AqH71eiWo1n07q25/6n
 4rmyjzZE=
X-Gm-Gg: AeBDieuip+0cC05rNI4MVLmD4Rm6Hifl/qgUsrvpDdYI9iuQEu6fYBCDGGC7ZvkHmMp
 58+hMHNb/Rkj1rcq4GA4L3Q2Qid6CMMuGLyuWPHrHNX3H5cEeEIzx2A3Y7kxRfzC3YHwtz3iLcv
 iew8W6ZvG6YZRHuBncO0jvS3FqUkemXd+LjelsCNfnP8lOdv83mtAMwB4d3eGdvDTodVBNXdmqP
 QlR9q8PtlXO/v7jl9q37T4QydBEEgElslFF9YkwCend6TIvIeV/czax45rgSQ29EUCz9GzzFgiM
 RHcn3T4tBlGwA+XdsPgIvFWVp+C7EFMaENh16Yo5Vk/Q3ELXVOTfsmyo5UZ/GrSGFNkDA2kVvCF
 FH7b1OUrjD1VAgi69Y2xmtAJ70OEikYk92DMdTd3KBdcfHpXbMu9Ac8y5bhsmP7gi7C61RrUofx
 YJqNwasM9dsScbBWo9+AzLrOGxFfaUVdegAmm3zq11v/I0m/ss14QymPSev2jqt1oT9EZ0QTbAL
 FFkpPngSZbeb3bKtWJJqRwtOsJd5rdzqMBR+H7TEA+xAZfl
X-Received: by 2002:a05:6808:d4d:b0:466:f25d:3289 with SMTP id
 5614622812f47-46ef8219ecamr6768074b6e.36.1775490068675; 
 Mon, 06 Apr 2026 08:41:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm8181782b6e.0.2026.04.06.08.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:41:08 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:41:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
Message-ID: <20260406154105.GQ41863@bill-the-cat>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
 <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IDmJFTHH7Oc+CfR5"
Content-Disposition: inline
In-Reply-To: <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
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


--IDmJFTHH7Oc+CfR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2026 at 05:59:52AM +0200, Marek Vasut wrote:
> On 4/3/26 11:01 AM, Ilias Apalodimas wrote:
> > Currently, ram_base is calculated within setup_dest_addr().
> > However, upcoming patches that enable U-Boot relocation to the highest
> > DRAM bank require ram_base to be initialized earlier.
> >=20
> > The default dram_init_banksize() definition relies on ram_base
> > to calculate the start of the first bank. But following patches
> > will move that function to execute immediately before setup_dest_addr().
> >=20
> > So let's split the ram_base initialization in its own INITCALL.
> >=20
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   common/board_f.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 91c569da9682..7df92281c35a 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -329,6 +329,14 @@ __weak int arch_setup_dest_addr(void)
> >   	return 0;
> >   }
> > +static int setup_ram_base(void)
> > +{
> > +#ifdef CFG_SYS_SDRAM_BASE
> > +	gd->ram_base =3D CFG_SYS_SDRAM_BASE;
>=20
> Would it make sense to reset the variable to 0 in case CFG_SYS_SDRAM_BASE=
 is
> not defined ?

In that gd should be zeroed out do we need to?

> Or better yet, how about moving CFG_SYS_SDRAM_BASE to Kconfig with default
> value 0 ?

We don't set default values when a valid value must be provided for a
platform to work. It wasn't migrated to Kconfig as it's not really a
configurable value, it's something that if we could pull it from the
device tree, would be great. A someday middle-ground would be to mimic
how Zephyr uses the device tree and get some compile-time constants from
the device tree.

--=20
Tom

--IDmJFTHH7Oc+CfR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPUDgAKCRAr4qD1Cr/k
Csg1AP9Nd90hUldoCtvEO1r2/MQLB730lXRyAPLOslTRUN20DwEAyX92vUmXqhzv
Ue2TiCntAUYLYBzhsEnwGYop6PPfSgw=
=VmTt
-----END PGP SIGNATURE-----

--IDmJFTHH7Oc+CfR5--
