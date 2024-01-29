Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83192C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F75287D65;
	Mon, 29 Jan 2024 18:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BXBMIPvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514BA87C13; Mon, 29 Jan 2024 18:55:24 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF9487D65
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-602ab446cd8so30272787b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550921; x=1707155721; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E1GX8ykImF6nzzlM7vTMLstIrOzLqpx1nZC9BVlqaUg=;
 b=BXBMIPvEgNxbGwREYVP9Rb0cokV+CfqiscLW2ZwOi7yZ1uMgNogGVR3+kJxo6mqAkr
 kTS5zyyitlFmj2QO+ueC9JF1tgpsk5MxOwyP1k8K5ZeRskUHLCWv2DIgKSfXMl7KtMXD
 rJU8utnmY5iNjKqzm0RJkUGHjgMoK+o9RCXrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550921; x=1707155721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1GX8ykImF6nzzlM7vTMLstIrOzLqpx1nZC9BVlqaUg=;
 b=JezdDRw826dVkBFB5m6XPJQkw/Cmh5K+yWSEPRmSwqNd41vPVnPztDBDW3G4UATCU4
 W5ye0KieCxqqL2zWJurVx/JS82VKsWbJTlvnZheCFAH25HYnWuDLOlmS5257WTU+hZhE
 O/tIF/wH082N394Pb991Ek7ZyfIsxnYFvG/k+/z33B+lqNlG2NCwqpXefWD52jvaXFX/
 Y91K76nhVAoGM7mZegdgAUw1Z7KRIa4FwMK3XEVzYFVcIHopb4AuWlJD6R7WBF0QTdeG
 0YDfqCAcQD+gkzA4wbVgpYf51vl5I09eke+EIgKcX/waV86qal/gLjWE0qSA0iwzAlJi
 XJEA==
X-Gm-Message-State: AOJu0YyBKoQtucx3j+NUlPjRYsjW8bpt6z4E6+KczrrxfR+GvETicsyP
 H8aOZLgaeiOuS14O3BPXesHuOlywBwcf2ruRjhc6AVM4ck8d/4dWugCKxjlfe9A=
X-Google-Smtp-Source: AGHT+IF6RMW0JYgEPf/m8oX/j+0yrDyZ8AAwxQA2RJWJoqaIBbxGL8w5/T3cI2k6GVl4iuPAdkt2DQ==
X-Received: by 2002:a81:e80a:0:b0:5ff:4c50:1010 with SMTP id
 a10-20020a81e80a000000b005ff4c501010mr3998827ywm.35.1706550921013; 
 Mon, 29 Jan 2024 09:55:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d142-20020a0ddb94000000b005e7d8d6e446sm2632517ywe.93.2024.01.29.09.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:20 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: zynqmp_rpu: Add test for loading RPU apps
Message-ID: <20240129175518.GG1152441@bill-the-cat>
References: <b71639dcb9a59d45e23248aa3ae6de2492a7909d.1705571560.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qy0ek1KxM9f+4nea"
Content-Disposition: inline
In-Reply-To: <b71639dcb9a59d45e23248aa3ae6de2492a7909d.1705571560.git.love.kumar@amd.com>
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


--qy0ek1KxM9f+4nea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:06:41AM +0530, Love Kumar wrote:

> Add testcases for loading RPU applications in split and lockstep mode
> including the negative one for AMD's ZynqMP SoC.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--qy0ek1KxM9f+4nea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35oYACgkQFHw5/5Y0
tyzIzQv/XhKn+IyIG4ES58m3C/LFB9qJRyKH37QcFDKr7lrV5odCpzMKsYeRav9l
bk3iaBQMhrvywJWAYVB73iSE4RxgPYj2og/cs0nSb7chGHK4GU/95gaC6C9pUx6N
dwCjNRcq0mYLaUH8pfTJ54qPkQzaTHX4MMoJOPrZKXLdbQCB526eOgmHrmOotHaw
nE9nkWTo02uQWZ0LOsg0fpUh9ZrssU2UuuYJ69PH6IOIZmHFATYMlw/DdKSb5k0C
xVhuK33kdQSyqUXpEhYMsKePwgHiB50lttHlIn8uRhTHC3jyqknnMIdNXOyqimxv
QXylba1n4yWb7teP4wNOIXWRrlVJwUj10zxmJZurq6TqcPisV+RqlZNQjIAwGY6T
cKJI0gp/m9xL/bO8RLIRVgF+2u5IJypB0dMsVLXkS5QD+IpHKTkPnn9cHtU8EUyS
kzr8qtBKmoR+6eYab3pLjpmO6v2W8BdPFI/al2Wi1tDG16SveqwGRD9vZvwUWhA8
UaKKVqRj
=Bd3z
-----END PGP SIGNATURE-----

--qy0ek1KxM9f+4nea--
