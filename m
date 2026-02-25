Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BD6FD3764
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3079483FD6;
	Wed, 25 Feb 2026 15:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OGiP/PA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF3983F60; Wed, 25 Feb 2026 15:36:01 +0100 (CET)
Received: from mail-oi1-x233.google.com (unknown [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F238384010
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463f00cda04so4180119b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772030004; x=1772634804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pGDb86MGZ4+xgJoAIjStrR3atv5DY5TiXvkrL3FvjHs=;
 b=OGiP/PA+n84iaF16zkZbNvRZNvabkAcjjMKbs/NJEVL72/cPAkO0x9w3KamsfTr3bR
 iBcAZaKDiLA3uzT7k2gEK2TVrNZdt6nVMRAUdnJZRHuPfgJqc/KBalgN81PHVe08YGBl
 Emzi1+yERM2mup+2UYi+k5042hW9d7oZxn/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030004; x=1772634804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGDb86MGZ4+xgJoAIjStrR3atv5DY5TiXvkrL3FvjHs=;
 b=iNGZ851koyY8ztgUUByOpmB6GY3+sJJ/w5v6Bjf/WU6OqKIaj1nQeGqGvKC+XR99bd
 E0tRJk7d2H2h3e7UX3UUlkcZbmNHkrg9yozb1G2FvtK/lkux1Hc0DsBBDWJR5wM6kBUq
 cUB3ThYtVRP29uPrc0Sq//QCEXu+tqQ/lsnXb3AliBIFdQhVkILtHp5z8ZauQFScBdqU
 cciJAYKzcCjsQwuRfZAjYNGztgjHsS259T0WlO0yGfiFT8gTJlgRngU5BogC5ZKOPVTb
 V1gZt7Bz60kH0oqW6QRIBHURBVGWOw34h69tkwTF9Nx26hpxaWRi43BfuQxQt0hqV0XV
 IjHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJrbFhcDuOYmcQkpJxR2f/m7c3Lg0O7vhZMd7RPfPjAKFBVkoW+SpXegz9TYT+vmr/LEV8PY=@lists.denx.de
X-Gm-Message-State: AOJu0YxaP+rsbVlJ80npm7/fSPQMlHdbaGE+kAuThHM3LX11ERo2mQJw
 OXQmPBD9uyf9G9blKWvspMgu/+ksslI/5lwfjRZKKcGjqBf4p0+tK0VIrtnpBnIXofE=
X-Gm-Gg: ATEYQzx1OGGPEKzI9LKKyFlvlHcuF8FuxsZEGjY2gVVdEsjEAIBeZz8mpDPqdpaTvfn
 NIRUZ1eRhqc0gyC39BsAWvy5V/UAZ9ZPQSB8HxtPrLRBqn77UWFz2q0MjDpMrMqUjGy9CIl3ihA
 lIdewYDsBQHDeH+w5zYQkezDZbNxjaB4g+VKzKj4dSHPZWrN72F3H4PGP7R/5EX+3+iI+rUM9g/
 gznXf+ux7H2/jrUUZTHSwTmi3EVvVv9Tln+ye51lyr+TqctfzrZ3ElKLnB1digqvicMVIh+1kh1
 pR6e26UgDBkdS38XslJ5oowXPMnTK5JdGyRtLCx4ZbwzJFbaRXDd/LaAKPdWRpWC1vGdpocIlBY
 Ko42GocIdfBlWdUh8JoDJ/qWRsw/j9fTmKL6tRCfpX1XQi/aqxKo43zcg2PBTyLHaXgf0NaLt7x
 bq5img7BmKXZSFUAdIZ1exGEXZnaG0R8VWjvFnlp7RpqOuQC8UAK2Nv7mnQSZz2h7lV8SJSZp0J
 lD5fdlsI1edmKKdr4HJwKYt3u1+J+MNHj1ezHDxfak3X4j/A5M2tqYdNG/adQ==
X-Received: by 2002:a05:6808:1b1e:b0:463:b5dc:11ea with SMTP id
 5614622812f47-464461796e2mr9302368b6e.5.1772030004617; 
 Wed, 25 Feb 2026 06:33:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1ae488sm9029863b6e.14.2026.02.25.06.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:33:23 -0800 (PST)
Date: Wed, 25 Feb 2026 08:33:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] sandbox: symbol CONFIG_DM_SOUND does not exist
Message-ID: <20260225143321.GC1593142@bill-the-cat>
References: <20260225094233.44047-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fV9w/cEvIGSCWhKm"
Content-Disposition: inline
In-Reply-To: <20260225094233.44047-1-heinrich.schuchardt@canonical.com>
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


--fV9w/cEvIGSCWhKm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 10:42:33AM +0100, Heinrich Schuchardt wrote:

> The correct configuration symbol is CONFIG_SOUND.
> But without CONFIG_SOUND_SANDBOX there will be no output.
>=20
> Imply both CONFIG_SOUND and CONFIG_SOUND_SANDBOX on the sandbox.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4af0da2485f..f59fd80d0e2 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -250,7 +250,8 @@ config SANDBOX
>  	# Re-enable this when fully implemented
>  	# imply VIRTIO_BLK
>  	imply VIRTIO_NET
> -	imply DM_SOUND
> +	imply SOUND
> +	imply SOUND_SANDBOX
>  	imply PCI_SANDBOX_EP
>  	imply PCH
>  	imply PHYLIB

We should just s/DM_SOUND/SOUND/ in here, and fixup
drivers/sound/Kconfig's SOUND_SANDBOX entry in another (drop depends on
SOUND, add default y since it depends on SANDBOX already).

And thanks for going and fixing up a bunch of the odd symbols we have (I
ran the script you want to import, there are *a*lot*) !

--=20
Tom

--fV9w/cEvIGSCWhKm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8IMQAKCRAr4qD1Cr/k
CvXoAQCCvdb4z45GLKlS6rpFTJ3EMTXF5LhobmOoXcPWxv3FtgD6An3x0bWdENYM
dpspi8SrBKb0EIqHavIFpMQN1b054gk=
=WgJP
-----END PGP SIGNATURE-----

--fV9w/cEvIGSCWhKm--
