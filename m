Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E85D2F03E
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 14:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 997B784062;
	Tue, 27 Jan 2026 15:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dR/msWDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883698407B; Tue, 27 Jan 2026 15:56:00 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571868405E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 15:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45c7f550f46so1766205b6e.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769525757; x=1770130557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K35Awk1jgWytbPRKSVIinrEl0CjxYelSuGqGCPqpz/s=;
 b=dR/msWDMwRuuWjaQEn7mDhAQ8nA4LTAQ9V/spMMUu5KmcEXOUI7JmLppCO3D8M2QKt
 m8QZTnuK5wTP7HpFH3r1owx5YrfZRisIhcoD+hPW3qMJnQtNJzwWaQhXnVrLmkuHaPcC
 p4d0/hCgPHWLV9lcFNIYeTdBdUQqU6oHbeKFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769525757; x=1770130557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K35Awk1jgWytbPRKSVIinrEl0CjxYelSuGqGCPqpz/s=;
 b=eV8+9sQHGwsZ3SXSzVeLaK9i6iXucdKik5kGbxRimRokf5yrR0isJMw9EP8kK8rSoZ
 UqgXhBWvB2Sh7XEL0QYqiVYtEZl/B5SoaKwY6voztAIispPlM+ZlE4H6JttbkguecEGF
 F30KIup+3xOy1VOlNCb8PdS08TCc02fCFeaQvvAFkO4K6j/PVPp06nxCynwhollmqIQD
 MvgB89teqGVPSF7XFDoOEAvtQhlsJnqDsqoptVVxWdqrrXOWtb+3NldZCY+CkVMSaBWW
 /uGdZ8E1SiLUtD8LNfSLL3tJiyEcdLtxlPnLtjeq7xhUnpFOAH6r1yvx8W7vpmeMs5RZ
 THmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLjr+8zCU08PsxTJoyNXJNU9Eg8k6pjXYFPRT6rmtOpju0aT7E4rr1F0CdCKITsEyxm4slgtA=@lists.denx.de
X-Gm-Message-State: AOJu0YyRu0h6shpM0hI3ia8UU1t0zE6ZfvlzNftRrfMUaXmONNVN74uH
 a9maruCh54y3gXmObRM+59hgvb48Ns2oOONTSsrpOzCx0mqRADZ2XRPA7SWMDpVsWms=
X-Gm-Gg: AZuq6aIdRYsMkEkjAEe/eQLKTt1tVzmZ5b7Hat7eAc0lMGAeTtTZYjupEvu7goz03Ej
 8apBIvDcp7Dj5jyfQY2zAtP9cDR7OBskwyxL694+CyTtqDEUiJpKbIg2otwj5Y4zWM51oLaOv9s
 zVni3sZsUuDpntfPqFjBknocDdIhUYs5Ntw0QFGx/1pth8Z5btEAh7HGl5pgivTYblyLLjJSVbx
 RcwRi4CCWryomNScxLKq3WX82maDAlcyGDZLKyBhMlc6jwhrQxZoJBUiiWiZj4EG2+seVHWUd5G
 qtHTBP3JvrUhN0AfGuTB8YP4kdeRTYXpJz4CekWtmtG13lcwhkTOMpYR6zLHMgkXO+OiYHoaFDK
 2+ZGFbAIrml4vcFqGd7TWoP2ELLwwtALkD3FKa5EzvEElSPKVcd3mBeRiO91aqKXLHbO2am/fZR
 M5sZDFmBMUojLyWgD1M85+1ci0aKc3Jzb56rnLblEeCVyZObF/Zja5KotWkKtOUfdHssUYysJCT
 z0pLUfBseaqyNYAwTEFQ+G9UNkXKpsxxt3t+bY=
X-Received: by 2002:a05:6808:151e:b0:45e:b160:76e2 with SMTP id
 5614622812f47-45efc49417emr1128949b6e.6.1769525757059; 
 Tue, 27 Jan 2026 06:55:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b3bfeb6sm9940246a34.18.2026.01.27.06.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:55:56 -0800 (PST)
Date: Tue, 27 Jan 2026 08:55:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jamie.Gibbons@microchip.com
Cc: Valentina.FernandezAlanis@microchip.com, xypron.glpk@gmx.de,
 Conor.Dooley@microchip.com, Cyril.Jean@microchip.com,
 sjg@chromium.org, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, ycliang@andestech.com
Subject: Re: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay
 alignment
Message-ID: <20260127145554.GB3416603@bill-the-cat>
References: <20260120153314.95091-1-jamie.gibbons@microchip.com>
 <20260120153314.95091-2-jamie.gibbons@microchip.com>
 <20260123201540.GA2406606@bill-the-cat>
 <36c8cbb602754cdad8a20221548da8a79d81b3a2.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Uau5aQqZk9JtFvY"
Content-Disposition: inline
In-Reply-To: <36c8cbb602754cdad8a20221548da8a79d81b3a2.camel@microchip.com>
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


--7Uau5aQqZk9JtFvY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:26:33AM +0000, Jamie.Gibbons@microchip.com wrote:
> Hi Tom,
>=20
> On Fri, 2026-01-23 at 14:15 -0600, Tom Rini wrote:
> > On Tue, Jan 20, 2026 at 03:33:12PM +0000, Jamie Gibbons wrote:
> >=20
> > > After U-Boot's DTC/libfdt update, device tree overlay application
> > > could
> > > fail with FDT_ERR_ALIGNMENT due to the overlay DTBO being loaded at
> > > a
> > > misaligned address. Change the FIT image loader option in image-
> > > fit.c
> > > from FIT_LOAD_IGNORED to FIT_LOAD_OPTIONAL_NON_ZERO, to ensure
> > > overlays
> > > are loaded at properly aligned addresses and any alignment errors
> > > are
> > > resolved.
> > >=20
> > > Tested on: PolarFire SoC Icicle Kit
> > >=20
> > > Fixes: 0535e46d55d ("scripts/dtc: Update to upstream version
> > > v1.7.2-35-g52f07dcca47c")
> > > Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> > > ---
> > > =A0boot/image-fit.c | 2 +-
> > > =A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > > index 2d040e38d97..3a327d07784 100644
> > > --- a/boot/image-fit.c
> > > +++ b/boot/image-fit.c
> > > @@ -2481,7 +2481,7 @@ int boot_get_fdt_fit(struct bootm_headers
> > > *images, ulong addr,
> > > =A0			addr, &uname, &uconfig,
> > > =A0			arch, IH_TYPE_FLATDT,
> > > =A0			BOOTSTAGE_ID_FIT_FDT_START,
> > > -			FIT_LOAD_IGNORED, &ovload, &ovlen);
> > > +			FIT_LOAD_OPTIONAL_NON_ZERO, &ovload,
> > > &ovlen);
> > > =A0		if (ov_noffset < 0) {
> > > =A0			printf("load of %s failed\n", uname);
> > > =A0			continue;
> >=20
> > After talking with Marek about this more, we think this is the wrong
> > approach. Can you please try dropping the load_op test from
> > 8fbcc0e0e839
> > and seeing if that also fixes your problem? If so, please post a
> > patch
> > with that and a Fixes tag, thanks!
> >=20
> Dropping the load_op test added in commit 8fbcc0e0e839 does not solve
> the issue - failed on fdt_open_into for DTO due to misalignment of ov.

Ugh, darn. Is there another load_op check that can be removed to fix
that case? If not, then we need to pass in a new flag that means that we
always relocate the data. That was Marek's other suggestion as we talked
this over.

--=20
Tom

--7Uau5aQqZk9JtFvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjR+gAKCRAr4qD1Cr/k
Ci4jAQDQc+cccAHHK3mHD0uhF/oUNiXgr9bHUpm3kV11U9nEPQEAvMqGV7EEFVY0
wjOIJfxUbrN3uqWy1UWEP8AxeAnIQwU=
=pF9L
-----END PGP SIGNATURE-----

--7Uau5aQqZk9JtFvY--
