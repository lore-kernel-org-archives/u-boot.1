Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C460FCA197
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 22:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566C383BC8;
	Mon,  9 Mar 2026 23:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U02EAAxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D537983BC8; Mon,  9 Mar 2026 23:14:04 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582B5839DF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 23:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4670464029eso958150b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773094440; x=1773699240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nr6sgQwH3T3L6yTkMiInEzKM0CYQt1IWg7N6q2pajMA=;
 b=U02EAAxaPlC2/1NPTVMrjVC32DJ2X56HLGBU+o6eEBTaNFAJtRsLtMujj2txUklDNR
 TVoR+tNcKfBQALH7MK6hw1D70Eeb5/hpmS+ZmuOcBHKtiBhjHDCgktz9SCk94BBa9P2J
 S7oF3HlfAupvcNC3MW04wn8a6BNL1qLCR0B8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773094440; x=1773699240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nr6sgQwH3T3L6yTkMiInEzKM0CYQt1IWg7N6q2pajMA=;
 b=Nn1e7l3YnC7FBm5HG4LbcQ+BGIJrtm/5hrOZfBs1+2bvtwHwBtGyZ+jLrRzJiug69M
 gkOAUOxKTXQnBold0TgdKQCjgxwV08h9KNdaxexEhWQM0z+ZPb1G+VR7Yo9Gl1rFORvH
 7614SPTQBrQDzto4+WsbPbCfO6O3Z/2thxm2qKD8uw4MBSe48fboBUAIPAJhZTpanAh9
 Dtuz3LV89LJe2/zcpTqb4cdr/+5pAnMUFBsFRuxkpNgf+AhiJR7ThMxk7zckMawJLaLz
 k7zNHRS0Lys5+wQzlRYWRoi0mNk9IJ0kfBhQ6HN2+seyu2TuBQPBbXfT1hewKzmg84D5
 HB+Q==
X-Gm-Message-State: AOJu0YwoU8xYt9yNvugMNPZcyR9VHGt/89g7q/HVd/ppMELNcOkEL1cF
 +oT5ZgHMRnby03nPdx38fRR2S/GbokbRvnCZBFckKqNlXpBT/tkRu4LcRnh66d8OgvA=
X-Gm-Gg: ATEYQzyerngKcdBup5LWlrICXe4S8oXvBsT7VI6ob5EjZ+VwrFNMO9Siih1YZxh/bYr
 CNvNqVbd6mqsm7dhCgOAqZ8WvCGxQnYr0/ve/0vXfv2olBSmKtDAs+IxSwUyrGSJQT5IcMzOO63
 QwY92bG9gKWgE9n2QGIf2FlAzLtzfNft93r+JX+DSqzW8WEd3vh+LL3Deo1y2Ait9jbqhBImbwc
 +yw0f8xRLW9/K7chjrEB0CSW1eQ9VapbzECn0j+JwSFvgt2oPDYT6IAEjQ2LkFxKXD6RPszq1Nw
 t1vDDR94urZeIj4pxVh3peymlHL9GStzYCRNyPrsbI+tUmgZ6IuOsOwQvEbPBZQJeHmR6rECl47
 Y+Z3+3XiLzfAfo72h7JIxHokbrMHTXU4ZUY84GXNJ6YI95Ff2+R71TddUsaDG+AjOWUEKdQWy51
 ofZYF37Rzu0uzaM7pY3pA8O98D6+HvjnqPr6bWm8QoyLEelGZqwUYm9Wtuu6IfM5m3OubexL94A
 CBnij3MWr520/ui0TEPnoXJYcgtT+3LwtFJe/Et/e8v6Q==
X-Received: by 2002:a05:6808:4f1f:b0:467:4a7:e3f6 with SMTP id
 5614622812f47-46704a7e7aemr2842534b6e.2.1773094439946; 
 Mon, 09 Mar 2026 15:13:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ed12cb34sm4777219b6e.11.2026.03.09.15.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:13:59 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:13:57 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260309221357.GG1388590@bill-the-cat>
References: <20260309212331.GF1388590@bill-the-cat>
 <22806ad3-cdc4-4f5b-94e7-21e541abf9cb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ZZho3zpl62p5EQV"
Content-Disposition: inline
In-Reply-To: <22806ad3-cdc4-4f5b-94e7-21e541abf9cb@gmail.com>
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


--+ZZho3zpl62p5EQV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2026 at 11:05:27PM +0100, Rapha=EBl Gallais-Pou wrote:
> Hi Tom,
>=20
> Regarding both stm32_dsi errors:
>=20
> It seems those errors are not linked to the patch you merged recently,
> because it does not change the lines mentioned by Coverity.

Ah, likely so, yes.

> Calls to device_chld_{remove, unbind} are introduced by commit a6d047c0a8=
6b
> ("video: stm32: remove all child of DSI bridge when its probe failed").
>=20
> My guess is that since my patch changed the file, it triggered the Coveri=
ty
> Scan for the whole file.
>=20
> Regardless, ret is overwritten right after the calls, so I don't think
> checking the return value matters here except if there is a log informati=
on.
>=20
> Tell me if you want me to provide a fix, but in this case I'm not sure to
> see the point.

It would be good to match the usual pattern (drivers/scsi/scsi.c and
drivers/ata/sata.c) even if it's an unlikey chain of events. Please send
a patch, thanks!

--=20
Tom

--+ZZho3zpl62p5EQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa9GIQAKCRAr4qD1Cr/k
CgRTAP9Vzb1kIwOBWN2itCbcS9N9JdbX/FPUeQiJY+S4IWrwXwD/QfgTttM2etNt
qj8Yrm/oBpiGnt142y/uktbNtClRuQI=
=fvXP
-----END PGP SIGNATURE-----

--+ZZho3zpl62p5EQV--
