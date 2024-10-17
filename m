Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA322D3C52A
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 17:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A6E889094;
	Thu, 17 Oct 2024 19:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ptfqGNMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906EC88FA4; Thu, 17 Oct 2024 19:54:57 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA9388E32
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 19:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b12a02596aso78547685a.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729187693; x=1729792493; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x+BUWHAmWo3KSazOw7VvU71OiPZ997eDFy5aFYUkOEU=;
 b=ptfqGNMOGu2TfwcrEQN3MvVxZ8qJL7P9o96WTe7liEjPDhfwLAvtcMfcrRSwrVrdv2
 T1ZVhCuTN2E0LzXgkeJkyyoEHqf0k77jS3yYCIu0NNpEmWActDXX/nfd2NdjgZE3oVdd
 CKHmscuQQloZdbyGlHm7OmZXAoZq2O+iynhFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187693; x=1729792493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+BUWHAmWo3KSazOw7VvU71OiPZ997eDFy5aFYUkOEU=;
 b=o84MCplREKAfm21keST4eS0l222sOsrK9sEj0qGcLrpvGtyIrife9poj5AuNuiBWFu
 WKpRp3P4pKdYPSwCz1f/fZpa5tEbcAONICAZN32pU8fesnoYPVGAXQTz18o5/tJ5gByz
 IYTLCZ8r4Df1HiZUkxRBwAv0VcobcV4kQBaABkxX44YVbd1ZFQbohZcCG0DZQFeNj/9Z
 V5gUGZZZZ8c9xLzJL0pw0wujG4PjBNCenKpYhQ/9sfvfnNQrDze0dmfu1yIDoQcRaCwQ
 qD4FQP/VukBDczXzUbIBM8g/ciJ/r/EgHrQ0eoz0PGsYY+YpZmXeKJmSPJEtudp3IF/o
 zfqw==
X-Gm-Message-State: AOJu0Yy7aInRiFqq7JGEfHAHP7NqMelE+lIWUaTZeVS2qD25j/kP1vHD
 bRO95nvTmh7CdcdK9OhnC2Qtov6l2pgwvAoQC2psLU6wbpl0RrwRKkz/xFyyZ1M=
X-Google-Smtp-Source: AGHT+IFWB3ZAcJaYAKUFBDjHy6yAbYBpigT9pVYxIQNjfZqVyXys8GokNBcurh9QIzxAPl0Nz/0ETg==
X-Received: by 2002:a05:620a:24d4:b0:7b1:49cf:6460 with SMTP id
 af79cd13be357-7b149cf6771mr873580485a.59.1729187692691; 
 Thu, 17 Oct 2024 10:54:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136170615sm317313785a.49.2024.10.17.10.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 10:54:51 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:54:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, reidt@ti.com, m-chawdhry@ti.com,
 nm@ti.com
Subject: Re: [PATCH 6/6] DONOTMERGE: For testing only
Message-ID: <20241017175448.GO4959@bill-the-cat>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-7-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mwIh9tWHn3yZfSlo"
Content-Disposition: inline
In-Reply-To: <20241017062911.2241167-7-a-limaye@ti.com>
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


--mwIh9tWHn3yZfSlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:59:13AM +0530, Aniket Limaye wrote:

> From: Reid Tonking <reidt@ti.com>
>=20
> This just provides some useful print outs and the proper config to
> test the functionality. For J7200 boards that do not have efuse
> burned in, the hardcoded 760000 is needed in the vd_data, since
> it would be populated otherwise
>=20
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>

I can usually remember to use "b4 shazam -P ..." to omit these patches,
but it's generally best to not include them and either mark the whole
series as RFC instead if anyone else is likely to use them, thanks.

--=20
Tom

--mwIh9tWHn3yZfSlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRT2gACgkQFHw5/5Y0
tyyU5gv/bY58NSLR0mRhRNoSIu76Tvzt5yrtFIJ52ZJLNcItF+YcbowR8lmEWC4V
e7am2KDCBpkrFoMXvnRCMQBTTm6RQY7ZgHlXry1C8MsGfa5Xy+Co0QpMKCY7h2Zw
3l9aNFArVYhh+wVJ73mWKfnm2aSTtJSlvMbkxbwV4C6ImRBlYNLA5pOUMa+Oa2z1
bN2+96sllM3jPa8lMVxSxq2085s/Atc18q3XK+ri6NaMVKMtwsWJGER6wxAgxGHq
XnWXRUucxYBExLa2M7wFOqTXg3GuC1xM1SqwXKsqVXpKASgxEcwe1T1/L1vhxvPt
xeSEXgYy3vfhSE6BUpv6chR6USE798i6oBfH9V/4nANEO95RQkJ6P3NU513jO98N
48XDUB9vxi/e73nwdDeOHSrHhd5IR0ZCdsrZypZ0Y9d6AXPh0X+dqnXyMNwdF7CK
AVi/DWcHI5A+Z7GIsimUZ83E8UNmjawHoBhIkq//UZQR0RmliFV8JDVS/ke+nmQr
ECgIGLjr
=fWB8
-----END PGP SIGNATURE-----

--mwIh9tWHn3yZfSlo--
