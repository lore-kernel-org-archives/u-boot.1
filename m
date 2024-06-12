Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC11C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45DB88876;
	Wed, 12 Jun 2024 18:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+H+QEG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDAB8886C; Wed, 12 Jun 2024 18:02:52 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5940088846
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-254aec5a084so1995693fac.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208169; x=1718812969; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rVG+fTYUvVfnzkJwIq836DQLzwzf7UnDmLKk0iRW0Lw=;
 b=U+H+QEG87CZmGW2X83zj9GBlX5HUOARlYh3rec2NlvkT3q+evhYgy7eteUW3tLL7dp
 AXzbxtkDvveuI11duSnDE9+Wbq1lGbVSnKe+rX9OJ6HM9lEHMp2drRvMnA0Q5C24plDB
 EWR6LagI9Du5gI96hWzSneHBvZjHL3I2ZOSgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208169; x=1718812969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVG+fTYUvVfnzkJwIq836DQLzwzf7UnDmLKk0iRW0Lw=;
 b=V+PDna1N9IGa+gsVNrfhyZSz6813EL18hkyMUV4inM02IkUb7Qjamt9nC56YtUA4TX
 AGjFo7RF3uLDpJDygdXTTPt9TQ8MSkHMd/ZZG1uN35xJd8ska+Ekob4I9hXjQhamwCql
 iUmh4BrMju5HWp2+7FCITWw/lOyElxnZVVy7xD9I/OrT3VA8HufeMNi8Bgk82sIXC2VC
 kh/ZxnTR27zMz5gkruTonrp52/DoUIuXk3PW4v5zbZS2DISTJrqDVzA2f8XyfXeaAS8D
 oxZ1ufAjlUfDq9x/F6kyFdeX9LJxVbFQR+xHIuuVTO6/yD4tfOYYeZCt4uFltRlaDEB4
 4I2Q==
X-Gm-Message-State: AOJu0YwbI3YTS6PBmOoDDnuZqhudISwL7SQyRr/WZBfQHhGAIDoxsnJp
 0OlKK0ADEyHiJPRXEzs/nSzubFqjUnavdRCWpeDy0aXw6Aj7nsdMSgeBfo0+k1qndmlh3q/5uQb
 8UsY=
X-Google-Smtp-Source: AGHT+IER1IYV580XEqU3J37gnntOfBa7c/kqmxlBIt8LiPtiJDvU1GFRGjGcuEeiCNUXPC4xNjb0Aw==
X-Received: by 2002:a05:6870:35d5:b0:23c:bc3a:6ccb with SMTP id
 586e51a60fabf-25514bf8a8emr2272580fac.19.1718208168906; 
 Wed, 12 Jun 2024 09:02:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fa18c04fc4sm307377a34.44.2024.06.12.09.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:02:48 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks PATCH 4/4] qemu-loongarch64: New board
Message-ID: <20240612160246.GY68077@bill-the-cat>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-5-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/kZOojXWWh6ofZrK"
Content-Disposition: inline
In-Reply-To: <20240611210025.798978-5-jiaxun.yang@flygoat.com>
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


--/kZOojXWWh6ofZrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:00:25PM +0100, Jiaxun Yang wrote:

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--/kZOojXWWh6ofZrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxqYACgkQFHw5/5Y0
tyw74Qv8D1EDSLrD/e1cp7I8bnQf6TVpasmWkZql6ytEAs7g9yVEwdKKB6RVuqX0
IOX53wTnAknLZgbB5SN19Oazusy1IrCz/epqMlF+pgrP+h8TySBI7146KZZ6O7Ld
4bAHNOPHRwkV2a9ddYTYV3Npoxc87vtB0ZGF+d/7HpOyNkwb+LMMlEBu7f97ofow
grwOaqfpBH8Iz8oEkMQb4t6gDvl8SIuuHQ/a8/Du5bUui6HmV7ZilKQl+AwF+6q4
HFDK0QB0B6tAJfS5klnyY49P5owmsFS7t4TCFcMinv1ZtmkEKok4IhTSiOfcGNDH
ki9qtNRpfx1ZbRLTPRh4ejnrFRSdFvtEElaVW0PiFWQhDcjMFV1e0n8apsmLkX6t
I2IOayxA9hKK/g2IrHGF16dl+AwTbKKxMrlsIDIKfKjN0CbcLxVZD72BsqxFn7V2
UKa6+r7QgR0SCmcKSf6d+4oI5YVqKbCsIKP1fepQdvu5MxRvvpq/phZtIPctAp/t
g9BFNmME
=Ya7l
-----END PGP SIGNATURE-----

--/kZOojXWWh6ofZrK--
