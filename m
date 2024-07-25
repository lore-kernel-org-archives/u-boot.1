Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD2CC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B01880DE;
	Thu, 25 Jul 2024 20:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fzUSdEQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6963C88286; Thu, 25 Jul 2024 20:27:39 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F5B86D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 20:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d4071e9b93so113355eaf.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721932055; x=1722536855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z/2PtP/Wu28SeaJjqb+df+8XZmzJnlZ190tyvSx0lSA=;
 b=fzUSdEQMTevDtc3MojTp1RMIf0xk65piRlcyj4Bqthf7GFhTVw/C+YRmiHHaVYBPgX
 MQsHZ8fYTVqpi9Gj8IO6DklK7RSXN0+u6t4Zr60TRbx9IZt6x6wb8v6echykqrPHK8lk
 Qiu8yOrWjEZx+/znuuCKsZAYy76xIJyRyGRyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721932055; x=1722536855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/2PtP/Wu28SeaJjqb+df+8XZmzJnlZ190tyvSx0lSA=;
 b=JoZPpLHxVCAHjgrNa6AQM0mRgwyRb9rYjS7DaeLY3UthETbtq2o8uH+OVaPRfRC0YR
 57gSOAgyJPldGLsh3k/N1lq32Ey7KEt6QWYJrWrtOtmYF/w9q+qwLW7F6+d1dzO+o16m
 2+CEd37Hfmj0z8DmqbTlMBRu1NaD9bum9gOLO6uQZt57rTKiaLx++SZxwpSLZ8kAt7ln
 pv+fPvu2Qzlhdn6SRWUTsttt0a1zFtqCzQB7w9v8igPmOu2c3glY2bY/yuM6JjmCKitU
 oH5gcM3z4m5aTwZFlhxrK43sluVvm7Ua4inTDUadM8wDcsE4ZBgWpXp3g4P0tUfbhkxu
 4t+Q==
X-Gm-Message-State: AOJu0YyAJTz+A4zYW2YprH48X+krzhv42YMNkI/QKNUIN5d5ztvMQKAW
 J0DPWYeLheD2lK+OReNymyfhv3oARpThRrSwkx00utgH8+QVqJn3USNoZ0q+YkQ=
X-Google-Smtp-Source: AGHT+IGZ+sDfqeYOc22NWyf5tQeY5fWdIvwytcWKXADraY+eFqgKOl+mP4AnO+BfAXi8T/VWFY4rJQ==
X-Received: by 2002:a05:6820:1a07:b0:5c6:7519:9b58 with SMTP id
 006d021491bc7-5d5ada9482bmr4400780eaf.4.1721932055267; 
 Thu, 25 Jul 2024 11:27:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b367747dsm200670eaf.29.2024.07.25.11.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 11:27:34 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:27:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v5 06/20] net: eth-uclass: add function eth_start_udev()
Message-ID: <20240725182732.GC989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <c012639090f4a45f004768b8e7840e3e81867ca1.1721910373.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aC/3L3787C3TK1cB"
Content-Disposition: inline
In-Reply-To: <c012639090f4a45f004768b8e7840e3e81867ca1.1721910373.git.jerome.forissier@linaro.org>
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


--aC/3L3787C3TK1cB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:57:27PM +0200, Jerome Forissier wrote:

> Add a function to start a given etwork device, and update eth_init()

Typo, "network".

> to use it.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

And this is where most of the tiny and acceptable growth comes from in
the legacy network case.

Reviewed-by: Tom Rini <trini@konsulko.com>

But, does the lwIP side end up calling this too then, and so the need to
split this out and not have it be static?

--=20
Tom

--aC/3L3787C3TK1cB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaimRQACgkQFHw5/5Y0
tyyG4Qv/XqHosU6htTbZ2374dZ6wdmxdqDoIIijbDXotzcpYi1VSHnhlTrJKO0gj
x+lvQDMK2C6xy3BrU6XuY/NCnE2gTaspUz1yO6ojQQeyFoR5d+ojCsKAaPC6u2jq
odCCLPUJ1cMevzW13Q87BGC1OOfoV5Fbp2i698exQ3+yEGBImT8KL1h47xXrRN21
QuEQl94wJSBCMMiA2exSirP+JrQSpeOfUFvuwLIzCGDqHe9fAtQTXfwlPdo6v+/Q
vDlUA8nw81BJuB32GV31SmXR9wqvnGsbLhWMlARpBYWJrZLirodsLyGeUQX5Zjtt
bCYGGvMFaFLU4pGEj4RMuplSZDIKe1R1kqCOsMvszNAb7wQuruBcDNFj6yVVx4rp
b1A8MyG4lDYCk0BgxwEbbHa68DjxyYHEV5ixlE+XhauggWvYry+NGPMy5NJt9DRT
K0A62uBJvsZWvrGefLNqY+3TEW3yUyZLZk2r+O0pL6fDVlYgEGk6RbXvgeeqW1zT
FwvkEeZ3
=TvXh
-----END PGP SIGNATURE-----

--aC/3L3787C3TK1cB--
