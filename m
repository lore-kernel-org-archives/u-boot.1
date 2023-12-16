Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2B3C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 16:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65B6876E5;
	Sat, 16 Dec 2023 17:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/xR65hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F54876F6; Sat, 16 Dec 2023 17:04:29 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E4F876E8
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 17:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-77f2f492a43so117517285a.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702742666; x=1703347466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v4KONUyVYX9dh2grDxtHLpussHTGb9IC9MQXLaftAi0=;
 b=D/xR65hcVe68E1djXhgKgojcT9tYKRFN+v9JBX0dWStOEKjS+DpN8typA3HD/ayq4G
 rNwNGTK4gF9Ni+A1lkLJoSN5ZPxeQNs9WpQJmOWfmF9cdoUqy3eHrqlWS1hSIk1KAcMK
 1jASYw4pjXOBX4QYMF/rKMiFHxWje8kMC6HKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702742666; x=1703347466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4KONUyVYX9dh2grDxtHLpussHTGb9IC9MQXLaftAi0=;
 b=iaLpRv1Q2H2t3waMF6n9E7l0q4QfHzAn/dJseap4QOt3BVvoZRTERACpPJJWrDmYlG
 YqKnepeB5z9rbC1qWHI2lI33KHXQBJJFj7aP6baA45gks3d3uvDqIYecWvh53bVf+GOv
 UcL1MZgKkyDwfCyPUa34WIFo9gDWDQ2etdjIruV2gZicjlaXrfa9oZxI7N0VMRmcAEMA
 SQqlpADSp4q/RKUDeVP1jN3oegOZEfweNXxO9r86QLPtqqNlfzJZUbMhvg0weon4VxcN
 LjeGKNI3wi8ngw9ZZdQC+5LvhoeV4d53E2/NUHcf+lzbgXmPJTXhxcGoArThKlSm27AN
 tw7A==
X-Gm-Message-State: AOJu0YxRUYHGg1pE8BNJDLkbcwoN4FdbZFfwx8XO/IecpS1YZdp0n2nn
 mRquk4UAJ+f3b7eNwzPLEUDKeg==
X-Google-Smtp-Source: AGHT+IFw3ASD3HE1H7Jr2HQhbj/MmLi2W3v6Sr6m1u7iOC1ZUa/dPvWCd1alaUwF5w6Myo8nssIcjw==
X-Received: by 2002:a05:620a:268b:b0:77f:61d0:94cf with SMTP id
 c11-20020a05620a268b00b0077f61d094cfmr16703812qkp.55.1702742665768; 
 Sat, 16 Dec 2023 08:04:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 de26-20020a05620a371a00b0077f0a79ee55sm6828221qkb.133.2023.12.16.08.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 08:04:25 -0800 (PST)
Date: Sat, 16 Dec 2023 11:04:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alex Kiernan <alex.kiernan@gmail.com>
Subject: Re: [PATCH v3 08/16] fastboot: Remove dependencies on CMDLINE
Message-ID: <20231216160423.GQ2513409@bill-the-cat>
References: <20231216131650.2242749-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nigylt5tilYn9yJN"
Content-Disposition: inline
In-Reply-To: <20231216131650.2242749-8-sjg@chromium.org>
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


--Nigylt5tilYn9yJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 06:16:38AM -0700, Simon Glass wrote:

> It is possible to boot a kernel without CMDLINE being enabled. Update
> the implementation to handle this, and drop the condition from the
> FASTBOOT config.
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Nigylt5tilYn9yJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV9yocACgkQFHw5/5Y0
tyyRPwwAnwGhNPNPhWwGITv6O7chy0ZhgCkahEczIrvEeVYS4BT38Yhqx+oIj3qf
nvWlxAnyivnsf2JB+h2YSSXznm9O8W6RHWjjvcb81LQY5K3ejjLoOaYU9KhN18O9
oUJPF8F1En/yvYM1XdZLSKjZCFZaYl0fw9Kik2xOGcOPqZLKBeU2eOqRKG9STMY2
vIVTcFZ+RrJbj83oWn0/iD8Dvs9Xqd9crk/O5NGAr/7+1vz7v/CadXy+eYp71OBr
rc0hqmknTXh0u8k9HeEgb0xn8kgXTa3JKCLa4p7MnA9n3EyB7QmSSZ6QvTun0PkJ
BLucMUxoDxdoWS/rKgPHUyx7GrWf5Mf8wQYD+i/u22L7WlHRacv1rhjQX12MX9+l
rCUPjewjLa1K4R0VSCMCDCA7DQYli/nzOgJAVapjPFijG4sWU2UTkT3nmHTHJglc
JSdNW8iCHY4qk6ddwruVveoxJiyQVcxmWLKAHIsycZzgehnTInuz41LYXsruLXVG
6/0hf2Be
=HWb4
-----END PGP SIGNATURE-----

--Nigylt5tilYn9yJN--
