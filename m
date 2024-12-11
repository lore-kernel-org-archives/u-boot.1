Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96B5E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9CA801DD;
	Wed, 11 Dec 2024 23:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TCfHWCco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94335801E7; Wed, 11 Dec 2024 23:50:03 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53588801DA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46772a0f85bso26700591cf.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733957400; x=1734562200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gn1A/glXZEsrB6Yj7Tv/gKfDuB5UkLpzwTUUXu8Os+w=;
 b=TCfHWCcoH+essRQzotV+UP/zCAyGq7ChjG3u28PYXXnI4XZb+vFy3qYpYZW6CbS3AS
 qryvPTR0HTIEe3msP6wLuwON+WsIvofSBEqyfaWYEEgCd4tL2SaJUoZsTfDqSTmzfkh2
 1fL/VbDlV6HzeKfBrIxo9J8rwtQgmRsR8xpYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733957400; x=1734562200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn1A/glXZEsrB6Yj7Tv/gKfDuB5UkLpzwTUUXu8Os+w=;
 b=HarELzGz21RNizKtztniaDphlRnGXEa3O6XZ1m1S7nzd4Y4Fb6ErnIcK963DoVpdKQ
 AtbtGKb4kxW8HDHunvq31Yua097lMta8LGlswCwpKXHaJjpv6IzoSyIvo4wqC/OMOA2Q
 PsCoBpTX8OJBd40ZU/8Ztpm5V7Ewqto1/JYHLvRH/5bmTVQ74sNEJwazYwa4fOfnhyxb
 7NkfoGdcaX8hbHJrdweulEUge4sp5kFw3L8zD8JvcPCuZZN8tb8S7IvAq7+pEKiLQPWx
 +mZiG1LnqAsrB5NX5zc+stwF0nmIw1bP3BhNdHB396eTAh2vidWFiwJ+5Rx6dxWgNrRu
 BN0Q==
X-Gm-Message-State: AOJu0YyCrDuhG882xiFzXjEccNYHqtUqUpgCjxpvOA/lF25Q6Mrhd7Hu
 jpEWXjHgkkI++IYQdomCJ6osBjThPwkMb1XdsZMUHRgKfN0yKEMdBdnDirSDHfU=
X-Gm-Gg: ASbGncvpfaHRXQvIAIdGiYZCjqZJTgp3kAv1JFZs+QqDhs9ubhSgTgxePOpZ5nUyJD3
 hxmY2H0ZrtxcmS1A0c0ocNcjuzpG5vWdsMKqrjRvQmUmod2BkY/2/IPHVI2Y5O3vxLdZEedKDwP
 Nhkdn4p3y46lnohwdt6c9kxlR9RVJi3SEBbCf8EMXVB7yjDQIAMtFUkEATQEAQcdn2DFONI7rA3
 l51p/UdNA3L8SzDPcjfP3wPoMHk7XxBq2YhMoemiJ6f+NSQE/Tn9vTQ
X-Google-Smtp-Source: AGHT+IE4gMxnsUbI+88rl906l/50epvXNTXiayXfV7MqneDibXAtRhYWgZVorq6UXQ67rlHU7RU1vQ==
X-Received: by 2002:a05:622a:4c8f:b0:467:7557:5fbb with SMTP id
 d75a77b69052e-467961ca2b5mr24482161cf.27.1733957400178; 
 Wed, 11 Dec 2024 14:50:00 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46787bec063sm14352191cf.50.2024.12.11.14.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:49:59 -0800 (PST)
Date: Wed, 11 Dec 2024 16:49:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v2 0/7] efi: Start to chip away at the EFI workaround
Message-ID: <20241211224955.GJ2457179@bill-the-cat>
References: <20241211223822.2446254-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R/st5e7nc+ZzOEN6"
Content-Disposition: inline
In-Reply-To: <20241211223822.2446254-1-sjg@chromium.org>
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


--R/st5e7nc+ZzOEN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 03:38:15PM -0700, Simon Glass wrote:

> At present there is a function, efi_set_bootdev(), which is used in
> various places to tell the EFI loader which device a file came from.
>=20
> With bootstd, this information is available in the bootflow.
>=20
> This little series provides a way for bootstd to provide the bootflow to
> the EFI loader, so that it is able to select the correct paths.
>=20
> For now only the EFI bootmeth is updated.

Hi Simon,

I think as a general rule it would help everyone if you had no more than
one outstanding series per subsystem per week. This is 30 efi_loader
patches in 24 hours and that's _a_lot_. One could easily argue that's
too much. Thanks.

--=20
Tom

--R/st5e7nc+ZzOEN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdaFxMACgkQFHw5/5Y0
tyzmIQv/ccPGR2HtyxNk8yjfrw8QIwfhE24kUJlWiBk3Ovt0vf94XftEu0xcak0i
tbNjXAOrUns3bjkR7UGahSS0OvpNJDQwdg0jERqqc2GWrDmyWwfqHWsBNPrQ1Eva
wJ+GIyHkcTxzHa8tONDpHyd9Gt+KB+R8+mTn8HmplRXwtjrr33DheLFL0kSL3LBr
02QZm6SC2IkbYkadXPwRK0d+d7oAlqNqz0BwWhwM6XeiWbWB154Rn6AxZVKyWEpO
DGOapW7rEUYuS9H8B3KK2XP94RqAwGGsuFMB5ZRudVgk0SOSwEJXUhmyxe8iyUGD
uNI6F7xX3c3xtQXQPUOfurYFSkEdcRVkUOP2Jw8cHuJaO+9WlQyS2tjVfo1ckzN+
HfQDWlgcOVBxbjbpe/+hqHBuXzOJFpkGg/ST0laQ68BhflcbaX6JINopxlDE2JrV
kvuKxTbI6jBvG6sk0rbajVHnGnfE5TaGTsPfM0He4rzkHUC4zgaMBN0EXz7lMz+k
4/XyLR5s
=/ABv
-----END PGP SIGNATURE-----

--R/st5e7nc+ZzOEN6--
