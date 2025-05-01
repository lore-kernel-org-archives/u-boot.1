Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900FBC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 14:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF750809D4;
	Thu,  1 May 2025 16:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KHDIcdOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF8580BAD; Thu,  1 May 2025 16:04:01 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C508D809A5
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 16:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6060200710bso455143eaf.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746108237; x=1746713037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AmLT5Ub8/wEUmu5VBq4mgm/riMwOb/tftAhoCMqgqqs=;
 b=KHDIcdOHYmTNaZZS7kgPPqtHK5Yn0G5r2IIvTqztipzhjYNiuE+HqaDI1TIQDR+HW3
 5lCNJVrkqYVSxfTF9eLPHY+x3+Id0eWJmwqZ/iFk1g+XR6wE18DMFXL2oKfnITRMnHi8
 XuV2RcqFOdBiGtCtJwI+bN+B6RggRplVSClgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746108237; x=1746713037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmLT5Ub8/wEUmu5VBq4mgm/riMwOb/tftAhoCMqgqqs=;
 b=J4ImC9MESpx7qPr3sLR7IYoIpSR7B9tp5gRDe6kqFf+SDo0DHv1rkfkH+Oj0Nfvf/c
 /UbvlhizLaRV23s5kdyuW+2hqMO/v8+kr74EHtwgTLeJY+Zv+8eFVlvvrwdomemRMNyt
 ANgdgvbV+gWyx24RgpQvE/lXursKds12mqL+OGle5OoP4IdTa4zLXsFdhjO1DfEx35vL
 Wr8dXkME55Dy4x6cKVpUqU07y8++qEdrM5jE97c8S9h+vKk5V2JyZlvI+91XRg7MZ0V9
 Bn0+zYt8W5bQHLttPetGwqPvcYHdelcMVrxz49G6l4fNZLkZ5GkBhUDeMFvy5gKcNLU8
 luKQ==
X-Gm-Message-State: AOJu0Yy6cg26zkmHEPnq7MtvBp/W6BU3SpQzlRboPRJwF8BUduwvE4++
 BYxDlI1xlD36D5gHFSJrT984H4TsQ4u5JHKBQ/aolfQB9BB3paUwyNbj1bwBhNc=
X-Gm-Gg: ASbGncuzpLEQsmReVPIfgUtHwSpxgPMssBl9Gr3GSsjS0ZW41FXqGEyAncURuA4bDm0
 JXS8x+iUVZm1m3F3+QwjLS5XC9oZG2hRNwyvS8U+Yc2lDxsKwRm+s3bHGxX+8pOFacwsbhdp8TX
 TkFHW6UN+QWrl/3UcpGvZvQXOhLFwD5CqT/iPtBR6kAnbzfcdDgxtQtnGI/8VYG3MG1SM+ul9q1
 O0NyLU1dJUMm5DVCPLMNw0r30GfR4mZlM+8Q35X9mMGXBAzaBLMQbIl1k3N/woLyvuiBBZV5xeZ
 TgKPlphIClkE6qn1CN96qO+89ifZC9OJDyxXGrsMRsVBzjff8r8ZhpmmIkneLiDygofORijaWUR
 pFw==
X-Google-Smtp-Source: AGHT+IFUSuaqOIY8RfVG8oPLDSWDvGw66kBF5x75Dsxw+fWceAp/iEDf+ykZbkiz8JkZTpHD/aPahQ==
X-Received: by 2002:a4a:e842:0:b0:606:293f:f37e with SMTP id
 006d021491bc7-607e19b2f3fmr1568229eaf.6.1746108237466; 
 Thu, 01 May 2025 07:03:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fb6fbbsm118960eaf.32.2025.05.01.07.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:03:56 -0700 (PDT)
Date: Thu, 1 May 2025 08:03:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] CI: Update the CI lab
Message-ID: <20250501140354.GC1261075@bill-the-cat>
References: <20250501012530.3954999-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yMc7qefdCnHDeIC0"
Content-Disposition: inline
In-Reply-To: <20250501012530.3954999-1-sjg@chromium.org>
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


--yMc7qefdCnHDeIC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 07:25:24PM -0600, Simon Glass wrote:

> Update the boards in the lab to match the current situation:
>=20
> - bbb and pin64 are working again

And were never disabled in mainline (since iirc I never saw them not
working).

> - samus and c4 are still broken, with no end in sight

Good to comment out.

> - new boards for colibrimx8, rockpro64, rock3a/5b, rpi5, zybo

Except the imx8 board doesn't work in CI in mainline and had it's own
long discussion that petered out.

Please v2 where you drop the line about bbb/pine64, and don't add
colibrimx8 until you or someone else are ready to work on the underlying
issues this exposed. Thanks.

--=20
Tom

--yMc7qefdCnHDeIC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTfz0ACgkQFHw5/5Y0
tyx3iQv/ZnML/aXuTU87RRg4W+vpF1d/TIguvpyvguosMudwL+QdL2P/Hf/bHGP+
5eZ9IYcAKCbe+HnAsd2jkGIB7rHjwI+2lZF5k/ssceWnP314Vk+VLjPBTAnRxk8v
tTSfg62ZVX7eLhglfDS6gflr/Cu66DXTJFTKPrkcXDjp1bQUx0UiMAklm0mxIwis
vSYquPY6Up4Ggp/dtYDaoQvFroBVAsLRgIKo5juOAiufTJReDyPjcqtNohsvcvQX
mlIM0ByoP+DOjB1XIsCH38SIH93mZD7/cKexYTRAXDGmsyZUAUWjGxk9Vt7HkMRD
HpDYQXdxhVix+jxVMMUxJSEBicFQEMfwcAZUGx03i7+EPczQdy/BtKtcALB++m9o
A9XwgTkBGn2yj0Itw9Yl0GYbbyJtFuOJ0CFGD/mgRHKhH2hphYbuxcgb7Xm08jNm
cusHv4h80lRuiDOxgjRm1FVZZmo07OXLbEOvzYztyJdHupHAtnC3lzu9o2xna2Q9
ne+HuPTU
=8OJS
-----END PGP SIGNATURE-----

--yMc7qefdCnHDeIC0--
