Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03FACCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 18:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C676836D1;
	Thu, 30 Oct 2025 19:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sg9Kl0lJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A87836F0; Thu, 30 Oct 2025 19:09:47 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478EA83677
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 19:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3d1bc63d5f0so838788fac.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761847783; x=1762452583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n4Vz5rw+AxyfST2uKkJa7BNpjBpbrAF0d7CMZN18DUU=;
 b=sg9Kl0lJ53M6Y1FUiA2hMwZvtrRlru5S0qfQ/8h0DCcV+UYRH+25dPq7s3HWSxWMHJ
 e6LSB7vDVu/WMks/IR7OkIKt9XX4lSTDHpdh2VhicA1jILP/tCMCQVKUd963Arruk2gg
 OUn3hfsb0NhFzPxBoEoAd6KU/0j3cVIrrr2kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761847783; x=1762452583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4Vz5rw+AxyfST2uKkJa7BNpjBpbrAF0d7CMZN18DUU=;
 b=FZLJ2boYUt0VHmKGX6YqcE+gmCRPJSND4bUg/iVp2qufyGk5/N58lydtZScM9bVI8s
 1shtcZ7fRIStw/G3vXrVozz0PbPVuC0ygiNZQ155gmKjVqaa4scnIVK4S/bsfPk6m/EE
 HHM0GJEKVtN7E177M347e7byu4NikV6DRkFjG/NzWlEAMBbUZCssJo4/iWbNFMulgUeW
 K3YV0y0jYQusDdzVfi5ZUh7tM1Kbw7jNOyUR/SZ+CbvPP/7fmx/Vn/iUlg/A8tZCdpaB
 4JSNeRt03S47dfID4IAbPGccGjWnvj2M+H9LUJslvHAfMk8STvwhi2ByzUGGwshhm+or
 UpRA==
X-Gm-Message-State: AOJu0YziA/yp9lGt2BKgt2nJCIr3RhkZYSIqNujV8A9qPt+/71miRVwX
 KcpdC6IO5bnz3KJFMdMzUwyfwCKaBid5ay8to7u8QdnT9hdhSqbDjMEOfiN8dkOFqIHPvL+dl8c
 hVEF+R1yBpw==
X-Gm-Gg: ASbGncvQdV3cFDcPhnHlu7Ig+ubRrTHQS8s2L3qLKsf5u5nKk4IwtvEo3MQk1ayfX2L
 9S1jIB+hxQE+krR/pwXci8NjIWRPISznYOHKG61wbIYrf12APi5xGNovpdcesSO77eXfZrAxCSJ
 0G+pEMAiHcYLBMWmHAZ2EKSUFU0xoox0ULg75NA3ctaykiza6crrba8HDFCekLJn/22VHfJXBNM
 ro3AjHJwUN6Q8JbQUzFMZUvqnshkzTSzwCKr6SvAbvI1UAb0Bv/W3ztv5GtipJvL8YRkls9/ctk
 1RPjtEcPNt5UGp2VB7NH+eVaBx/Aou6lTQUK6qiWseZ3REDtbQOcWGxc9DG/neFsc0NvOfFEyJI
 Lm9yBA+gqbnJpRJ4g2L860DfPyreDW6eEPVRFYIE1dqEurBsNjU/HsV92+6CPgnywFf7MeXtosG
 Uri8aJxgrXUVBcI609kUOVcMnxGM7GgrlWyOuV+ehrb3Aib+kYQA==
X-Google-Smtp-Source: AGHT+IF+rdReuI/3FOC1QPhvfxtcx3mdgywQgVEax0SZ02oH/L2DNfzqQt0TyTmQ7XC/xaEPKkS5Sg==
X-Received: by 2002:a05:6871:c69b:b0:3c9:8689:35d1 with SMTP id
 586e51a60fabf-3dacbfabbf4mr317698fac.32.1761847783016; 
 Thu, 30 Oct 2025 11:09:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e395cbf1sm6113046fac.20.2025.10.30.11.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 11:09:42 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:09:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
Message-ID: <20251030180940.GY6688@bill-the-cat>
References: <20251030003359.1023-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qqax3UJbJmtup6HI"
Content-Disposition: inline
In-Reply-To: <20251030003359.1023-1-briansune@gmail.com>
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


--Qqax3UJbJmtup6HI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 08:33:59AM +0800, Brian Sune wrote:

> Since turning from old build flow.
> New Altera SoCFPGA requires converting handsoff
> conversion via the python script. This is from
> official provided, and now sync to U-Boot
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  .../cv_bsp_generator/cv_bsp_generator.py      | 100 +++
>  arch/arm/mach-socfpga/cv_bsp_generator/doc.py | 243 ++++++++
>  .../arm/mach-socfpga/cv_bsp_generator/emif.py | 424 +++++++++++++
>  arch/arm/mach-socfpga/cv_bsp_generator/hps.py | 571 ++++++++++++++++++
>  .../mach-socfpga/cv_bsp_generator/iocsr.py    | 203 +++++++
>  .../mach-socfpga/cv_bsp_generator/model.py    | 114 ++++
>  .../mach-socfpga/cv_bsp_generator/renderer.py | 196 ++++++
>  .../mach-socfpga/cv_bsp_generator/streamer.py | 102 ++++
>  .../mach-socfpga/cv_bsp_generator/xmlgrok.py  |  32 +
>  9 files changed, 1985 insertions(+)

I'm not sure this should live in U-Boot. And if it really needs to be
hosted by U-Boot and not hosted/maintained by altera somewhere, that
this is the right place in the tree for it. I assume you run this tool
on the output of some other tool?

--=20
Tom

--Qqax3UJbJmtup6HI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQOp4wAKCRAr4qD1Cr/k
CiItAQDYsM/YCps6+pRDhkZ8QTfEhz0Vj3Amhc7JNs/RIg4eOgEA41yMCugipVgR
lD7ZSz8Tr9Y3X3l/e2PIvwTaNIommQg=
=z9Lx
-----END PGP SIGNATURE-----

--Qqax3UJbJmtup6HI--
