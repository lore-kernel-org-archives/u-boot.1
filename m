Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AE5CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 17:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2E5833F6;
	Wed, 15 Oct 2025 19:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MbkIei6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A9083303; Wed, 15 Oct 2025 19:03:53 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E26083303
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 19:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3c9662c5fb1so174970fac.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760547830; x=1761152630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RR5X9GDUbgIUNvffIeYoD9UoY9WV0lEvQZv9mmbebDY=;
 b=MbkIei6MYeS63w9igkANgMmYkSCo7g63pmOo8eKEn4Ss7dE8XHhJKgivG2x88wRH4p
 TGLjrEB7YG1DFyAd5DQ/zMwfi0llFrTglID+o+PqVomfohJonehYnV1xEHnI0hTKhKd9
 gZgyRh/MjM28Z4m+PCg5UoPGorgtcsRbJIsPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760547830; x=1761152630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RR5X9GDUbgIUNvffIeYoD9UoY9WV0lEvQZv9mmbebDY=;
 b=QDYTj+BqMyKRxOOzsUsyGmDfI/HXTG2cmH7Yp62boF/z7fvYf92AnOjUx2AMf//EV7
 DUua/CobaPN9cRCsDljrHfGf89VdEao1r/fx1BCtRBVZCgjB0vXiu8HJVO0p9ud3SWOw
 lkaPUJICWfUa2xIzdLdMWXmePW4CYvapyPqchIh7vwhpHKk2tdj7CMTElzzSAbKdUwgX
 KCjr9YGKMYfia5gFuou3v2d5P8ztpxpr1fcTdIhLzyAjheV4rm9CmnfAk4PojhbRY+pg
 wEBrcxvCFnOJ2X81OlLqwLuj41ygu49fT/ST8UkjXO9FukUsUKcah17PVcvMw3vaMJgS
 Jryg==
X-Gm-Message-State: AOJu0YzJAhQPPRju7YLHxxUwr7iO5Etz2mfit54n18fkly2W7+LCy3VL
 H1UnQuiI7XBdko7+1b6f79peiVZimWaG3sGyp2/QtN4JckTL6VlA89Su0aWfrTg7bAE=
X-Gm-Gg: ASbGncuHccAZmu6NrSXE9bN8R2dYuzADBQT4esI+cfpieVp77XvpMnTBMLQdJj4E0oy
 GVEJkY/kZ4VbhiFBJMlF69wRcmJZd1cOv/u6tWzpZmmOezQt4GbOeEEaRQf19Hq0wTt40c06tbv
 ne4i/VLdDrRZi7abESnr7kYmjBlcryEWr1746xg1EE7Tp/1R8MkFL4rheowMJs0ut/HjiC9Z6y7
 qxoD/qB4T+5KjAQCKdkAwL0fJOkuMBjndPwMG8UwgCRoFQ0Q2+PGkGZ4aacICwKADKBtJ0gdNz2
 SzE7j8k4qpMI7KiNVH8UACKmeP50kORNhq2vLx7/gzzg6XEFX0JStJjInkSsfbghfRficcq4Pb9
 TppxRE7CkSVhiutv8PhsiJOO+v/9ZexQW65zFPga3ijryoreqGTGVSg9Iq4LFaT3J9aF5gRywHN
 8Ix9Jy
X-Google-Smtp-Source: AGHT+IHjBl4+UGKRUh15OEANYpgnmXU6Vlgrn1CUFUb/WbBTEhOuTvAHNqQxhY4CIbajJpnSbSTc8w==
X-Received: by 2002:a05:6870:e307:b0:31d:66fd:298d with SMTP id
 586e51a60fabf-3c0f6d1ff02mr13148388fac.23.1760547826646; 
 Wed, 15 Oct 2025 10:03:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8e82749sm5461267fac.14.2025.10.15.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 10:03:45 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:03:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v1 3/5] arm: mach-k3: enable support for falcon mode
Message-ID: <20251015170342.GR6113@bill-the-cat>
References: <20251010131829.3737258-1-anshuld@ti.com>
 <20251010131829.3737258-4-anshuld@ti.com>
 <20251010160512.GE298503@bill-the-cat>
 <DDFEIZ4KAA9A.3IE2L0TRWHNXQ@ti.com>
 <DDIRVA05GD7I.PRFJAWPND0PE@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RW1gtFkwtCTZ7ihc"
Content-Disposition: inline
In-Reply-To: <DDIRVA05GD7I.PRFJAWPND0PE@ti.com>
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


--RW1gtFkwtCTZ7ihc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 02:31:49PM +0530, Anshul Dalal wrote:
> On Sat Oct 11, 2025 at 3:26 PM IST, Anshul Dalal wrote:
> > Hi Tom,
> >
> > On Fri Oct 10, 2025 at 9:35 PM IST, Tom Rini wrote:
> >> On Fri, Oct 10, 2025 at 06:48:25PM +0530, Anshul Dalal wrote:
> >>
> >>> With CONFIG_SPL_OS_BOOT enabled, U-Boot checks for the return value of
> >>> spl_start_uboot to select between falcon or the regular boot flow. Wi=
th
> >>> a return value of 0 implying falcon mode.
> >>>=20
> >>> This patch overrides the weak definition form common/spl/spl.c to all=
ow
> >>> K3 devices to use falcon mode with SPL_OS_BOOT enabled.
> >>>=20
> >>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >>> ---
> >>>  arch/arm/mach-k3/common.c | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>=20
> >>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> >>> index 5483ac9906c..41c96cbd4c5 100644
> >>> --- a/arch/arm/mach-k3/common.c
> >>> +++ b/arch/arm/mach-k3/common.c
> >>> @@ -425,3 +425,10 @@ release_proc_ctrl:
> >>>  	proc_ops->proc_release(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
> >>>  	return ret;
> >>>  }
> >>> +
> >>> +#if CONFIG_IS_ENABLED(OS_BOOT)
> >>> +int spl_start_uboot(void)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +#endif
> >>
> >> I've seen this in other parts of the series too, sorry.
> >> CONFIG_IS_ENABLED(OS_BOOT) doesn't make sense, it should be
> >
> > Is that because OS_BOOT by itself is meaningless and
> > CONFIG_IS_ENABLED(OS_BOOT) would always fall to checking for
> > CONFIG_SPL_OS_BOOT? I mostly stuck with CONFIG_IS_ENABLED to avoid the
> > extra three characters when using IS_ENABLED instead.
> >
>=20
> Apparently there are quite a few instances of CONFIG_IS_ENABLED(OS_BOOT)
> in the source even before this patch series. I'll change it to
> IS_ENABLED for this series in a v2 but for the existing instances, I
> think it's better to follow up with a clean up patch once all other
> remaining falcon series are merged.

Sounds good, thanks.

--=20
Tom

--RW1gtFkwtCTZ7ihc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/T6wAKCRAr4qD1Cr/k
CpphAP0TdqGlMDhnJ2E+Y9GpzAZZQUo/in9NfBW/u7G7fKSKFQD6AoG6ZB7S7IIC
EPpsepwikEweH0CfGeNZiUwy9LWdhwU=
=MaIY
-----END PGP SIGNATURE-----

--RW1gtFkwtCTZ7ihc--
