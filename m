Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698AAC0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983EB80C77;
	Mon, 10 Feb 2025 16:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f8lakFuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A36B980BAA; Mon, 10 Feb 2025 16:53:05 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B54280548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so3180401276.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739202782; x=1739807582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wkaYZPPV0+CSfWSdmCXGqVEjvMel1Ghgx8JT686xvSI=;
 b=f8lakFuyGpzBJNNyVbh2uoTuSnM8ZdGqjkk8T91H4EJuFFA+nk79wGrbFHmLrGXj9p
 nVB40Uk/4O8b/80NlrhQLMllFhRCgAOVwn/ILupBQ8gjCLPCWS0tpofA/oYFLcAL2iGD
 LJldyMwM+jbVbBbuXlcJkUglTLC7/9r/WXGVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202782; x=1739807582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkaYZPPV0+CSfWSdmCXGqVEjvMel1Ghgx8JT686xvSI=;
 b=GnVhPSlXXbE/8fHXSRc9PvEnpF6oHRt0FS47CoSvkINuR7+FTZPuffoIJ6r2MlYsPZ
 exp3tQqe48K7OGcINJLm3DtUyIerhirjeUPHiplrfbSv1fbzm43WT59NQE+ZEgHLDc2V
 Fqza9xo1LwVKGnasN0nNBHlNhU2xKA//lc3j9jJrzF4wEWvom1gGhsnpBqa8O4L3GjF2
 QztUoyOGi9YbfacBYWwys1BRBNd3DjkO/YQon3K8ETG4LFPKW91M4Pho1yH4VhdbyvFt
 TjGDD1D2Xl7YkxgKMvOmzIRQwK5y3jHk2rfvOHWxvXOAzSSnhWZV3XgZhON7l2WatGW1
 mNtQ==
X-Gm-Message-State: AOJu0YwqJwvsWs/0dmjiqGBHALINs/Ur2k35izEV3OzsOu+Actdqal5n
 DDevgFqER4JwRGDOmwUs4ns5PBq3tdu0zJHHaYS/o44s6iQeArn4EDRHpeLSd4Y=
X-Gm-Gg: ASbGncvc7MmFcD5MxKwt/M9lUmgKI4amN4vUfIGPOl8ETVfmXwC1zs02HrW61zWxzC1
 P1JHAQxJM/pn2GoG8m0EfQKcpfa+2UiikedVTgOe7mkZn4+nvFs0fFw6qGoSkws0UgygBhEdWmy
 AAvRNb1Ai4tmpWMP99TC1V4m51nzEN+7FQ8BSBh1h7IeWYUKu9BD8UV24V133G4kRP4T9mBKNG/
 F/rsyoN/bHOzyCrjHfBd+RpadUep/ElUvc2s3TNqBV+R/pmL/Ls9w5vNKWU4lm0V9Obgu7bOv5r
 ImR7CuuBlxSh5FU=
X-Google-Smtp-Source: AGHT+IGJ6OK+ABYYReWwm/zGywUcYXD7NfNoeOb2V7fRay3rgzZcztOex6VX/KImnbJT/Who7Hu2OQ==
X-Received: by 2002:a05:6902:1b8d:b0:e58:30dc:615b with SMTP id
 3f1490d57ef6-e5b461c33femr11942571276.22.1739202781869; 
 Mon, 10 Feb 2025 07:53:01 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a1f00c7sm2547820276.9.2025.02.10.07.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:53:01 -0800 (PST)
Date: Mon, 10 Feb 2025 09:52:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>
Subject: Re: [PATCH v2 03/35] spl: Use CONFIG_VAL() to obtain the SPL stack
Message-ID: <20250210155258.GM1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="96WY7HK0R4w1rt2r"
Content-Disposition: inline
In-Reply-To: <20250209211502.2299245-4-sjg@chromium.org>
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


--96WY7HK0R4w1rt2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 02:14:24PM -0700, Simon Glass wrote:

> Now that we have the same option for SPL and VPL, simplify the logic for
> determining the initial stack.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--96WY7HK0R4w1rt2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqINoACgkQFHw5/5Y0
tyzuGgv/cyWiH3WJdSgj3o6ZZVh54aJOAfeEAoTS1DHf2TqNWvek8UThu4njxbS3
ZFPc31mbFvemkLUvdoHyu5Il2odx4XSQdNT4iTC+79UKKGGDt639QKMVXust+AxI
8JDchhjuS2YK52OVJGMG4CPCwDdxxP/suEFWPpPC6FzqZa+omPUP+0TlqDuQvgEY
yY+0tK255RQPey27OKrYqSiwhl7GhWUaClVJ55FvxrQjDjUErGJyBrmUSix+9sC8
8NcNpH/ZD9uQQc0yJTyef6tMOJYLKGmsuMVttwmJhKqLgVNefbMeHTt3YCj8sbNW
coaiGEu0FQ2zlHU9F40sXyKDg/0SmoZ9ysXHj2EfVwVu0jas6KyLWCIxExjokQSf
aqeADSN38/zfohg8XfEzAwFC7/wNeFOcOnIr2sU+AJfVT06k7+SLvvISnJOxTFxc
7Fb6EBJTsk2uKLUusa/1Au4l2j3gi8wM8vxNrVJw423I9lZ61Z8FjnywyC30wQDd
gTepgLg7
=OUAz
-----END PGP SIGNATURE-----

--96WY7HK0R4w1rt2r--
