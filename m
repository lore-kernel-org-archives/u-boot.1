Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82D1CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 20:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF66583AEC;
	Fri, 15 Aug 2025 22:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="noxHbLFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF7483AFD; Fri, 15 Aug 2025 22:17:24 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58C083AEA
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 22:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3e57008acd8so20192665ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755289040; x=1755893840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WBfZal2AaOFOsNC69qDc8iBvHWAS2dzAlW9VTQtfS74=;
 b=noxHbLFgR6Qh77GwgcvYvrq7gG9GUurwRj+wLdAQP8BhudZE5PXFhU8YivB+bZn3HK
 fWhe3XEtc5tYjHF75NN7aHuWd7dFeC3J0oKY0ADb3XXnwmy0gADy97EmXQaP4tjwMTjx
 dUEn2amPY7/NGFiT6xXPnxsXjuBxDKClGrgzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755289040; x=1755893840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBfZal2AaOFOsNC69qDc8iBvHWAS2dzAlW9VTQtfS74=;
 b=WqsQaqrYeYC32HRkL4Uxb9jR5L6pnAB+mSoMXQUZOU6LHq+EzhVRxX0vFKgyUUpmvt
 qts8cH2czfnskNvwnGtA4fXS5+2ZhcxtQ0co+vkukFaEnSW9ADc/KTsmh6oLC63d/YkH
 +Ye7TLQne2QqK9eL4d8JJX2Wv781Pw7mmHNf/0q/cF+xX3ukNZC1xCkyHHBJQRS1oH8Q
 IYfzLStviNWAgvkwkqrG3gYjMeziKKeNf47pxwQdylNUbKGjzeLNctcSEwl+SywbL7qT
 bUyYL209UxWdIQ7mPeuv5pCI725yhqLW8ChrFOvIGE+bz0uEfeIKn/AsYeYPEq7Q8Yfh
 wbrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT5ZDen4+2814q1i6KnEgSVqvsvhBGCSLFKVPph/0HMY4NMkO1bctUluDm7k0P4vQfZgP1hTw=@lists.denx.de
X-Gm-Message-State: AOJu0YwtwrNoIBR9I+xK30+/kP2pFZFbYCU66UcPbBWrN4WNMKKQfgI0
 9Tq/+jUYrZJp0A0o5c0OxmgxTblfrgwufBGd7gCf9vdxzrp2n34P34oqzxpHuXrYqr9fBzlq/f+
 dTU/1IQs=
X-Gm-Gg: ASbGncuQ7m38vBG80/pMrhl3yrnxRoQEgnsX6NYpLIFWbBM5uIsSoB06rmDBDR7nK8k
 VFeJJDhghFe6zKn59ODMzT4HvcNZA/86o/MW4g6nm+cdEkRwSDqZI9hCs41OMEXpxW6m8db5HCN
 Iv75ChKVo160kd0jH4M40ZyembnPN3vCz7xf5/FtYIYNQpG7t4lUakv8SLVlCSX/IkKBorCyU29
 FJogJaJ2Kh0+SgQAsB3TMRCmkWXLlVLuIIyo9JMj5XCxsJlWDdVJkiWkuF+9bRCry70OHQSvoAT
 LTN+Zb5+Xdf+0HdqDdluDl7u2YaXt4yZHT5j7gjBWheLRxRpLeeDo5LEMBOP3XEcwYBC3hse+jF
 wucZ8us3ofKkA1NHTj2ncWCo93ypYMF6O7y/5ADI7v4DKHqwhMWU0fR7C
X-Google-Smtp-Source: AGHT+IEmf9dbBm1CDh9GV7NlheXENL0MtPBVZcVeLfcOZvggaAeW37zyqk53GrRraTPJL62yV+wV6w==
X-Received: by 2002:a05:6e02:148b:b0:3e5:4351:ad0a with SMTP id
 e9e14a558f8ab-3e57e8504a8mr57907555ab.7.1755289040467; 
 Fri, 15 Aug 2025 13:17:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50c947b3666sm604287173.24.2025.08.15.13.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 13:17:19 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:17:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] pci: apple: i needs to be initialised and used
Message-ID: <20250815201717.GA66660@bill-the-cat>
References: <20250806-pcie_apple-v1-1-1a99f83d3cc5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DGp0oT23FzNYgH/S"
Content-Disposition: inline
In-Reply-To: <20250806-pcie_apple-v1-1-1a99f83d3cc5@linaro.org>
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


--DGp0oT23FzNYgH/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 12:30:00PM +0100, Andrew Goodbody wrote:
> In apple_pcie_probe the variable 'i' is declared and then its value
> printed on an error but 'i' is not initialised nor is it made use of.
> Add an initial value for 'i' and have it incremented in the for loop.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/pci/pcie_apple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
> index 6a8e715d4b6..216b6512af1 100644
> --- a/drivers/pci/pcie_apple.c
> +++ b/drivers/pci/pcie_apple.c
> @@ -335,7 +335,7 @@ static int apple_pcie_probe(struct udevice *dev)
>  	struct apple_pcie_priv *pcie =3D dev_get_priv(dev);
>  	fdt_addr_t addr;
>  	ofnode of_port;
> -	int i, ret;
> +	int i =3D 0, ret;
> =20
>  	pcie->hw =3D (struct reg_info *)dev_get_driver_data(dev);
> =20
> @@ -353,7 +353,7 @@ static int apple_pcie_probe(struct udevice *dev)
>  	INIT_LIST_HEAD(&pcie->ports);
> =20
>  	for (of_port =3D ofnode_first_subnode(dev_ofnode(dev));
> -	     ofnode_valid(of_port);
> +	     ofnode_valid(of_port), i++;
>  	     of_port =3D ofnode_next_subnode(of_port)) {
>  		if (!ofnode_is_enabled(of_port))
>  			continue;

I don't think this is right because with this applied:
            apple_m1       : all -1425 rodata -101 text -1324
               u-boot: add: 0/-3, grow: 0/-1 bytes: 0/-1324 (-1324)
                 function                                   old     new   d=
elta
                 gpio_request_by_name_nodev                  12       -    =
 -12
                 devfdt_get_addr_name                        80       -    =
 -80
                 _gpio_request_by_name_nodev                156       -    =
-156
                 apple_pcie_probe                          1204     128   -=
1076

So the probe becomes an almost nothing func (that I assume returns
early) and we can discard some other functions.

--=20
Tom

--DGp0oT23FzNYgH/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ+VyQAKCRAr4qD1Cr/k
CvZNAP42Vf58kpS57bulzMp4h2qrWWysLX217mNxRqTvc9Hv3AEA63XFosOsJder
r6q1LbBVxjR2QYCYzkAgZJhW9p5c/gY=
=Atwg
-----END PGP SIGNATURE-----

--DGp0oT23FzNYgH/S--
