Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10CFC282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 14:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629FE8056A;
	Fri,  7 Mar 2025 15:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IjhlaWeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2EE808A2; Fri,  7 Mar 2025 15:24:42 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD00E803CC
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 15:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6f6ca9a3425so19242497b3.2
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741357479; x=1741962279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FgpPye8D+vehVUCqOvajQS1LQUcL9mPv2YQKYW3yuYI=;
 b=IjhlaWeJ9PW/ILt1v6u7HOjqvOpEtnFm2tu4XqqJ4V+6JrmVL7Fjwdcde8M11k4sEZ
 Cj4XRFCDfPa5zU6MRFMA5lvXca7EEiiaCSGXtAdA0Wn7Ca3P/kGNRb9pr1GEaHosVxZT
 pE7/5n4v/uwto9zsFsms3am2VVw0eaXHTp1ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741357479; x=1741962279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgpPye8D+vehVUCqOvajQS1LQUcL9mPv2YQKYW3yuYI=;
 b=PZigQLjLtnLX4RxPaeHItVDI3aiuHi5zHI3aZF8CPTxEZgrSzhqJQPf+eVSTQSlBSK
 Rful/GisR1xxj6QDD7MUe1GA4742WuJa5VVKr0NERuSkGQ41k8Gy0KIo9GT65P3q5BqK
 gW8RuGlnmKoA8BQX0J+Sm0XFqC211PEDwW3zKH/OE4sQvNbl00utQxvlEravSKlgoQyY
 6hnebJu33BGriJ/uL6FNT+oYIizYIaQFkX0vQvWj/9V6EmOMUgYaQw//QADAGFP6xIvo
 gX/C7MBJxNymxQ8m1/1eGJCrA7zaKP/2QapNMBBIfSmk5qtbyYb2PKALJIWx2/GVa8xP
 TWQg==
X-Gm-Message-State: AOJu0YztZ38OyQ9QGFTbCWRa3KOiofEzozAq6kzsOfcOtm7pbWhpZBNi
 S7XXUriSnK94kWpx3UAshv+ZTFuHlP6j76tDolHgw7rYh4Q4zkQW6sb7S3gE7dI=
X-Gm-Gg: ASbGncsgwLQ30K+fIF31UD4sV0Ab1pisLKBUewEwFWHJBOI5KVeVnc88tjiknU1ozpP
 66+YDxpI7QRDnGrrwv2G5Pr6ar5t6f5iPUGpdAWOFIzvG6F56AmwrSDGTJVwslQ+qob1y0g4dmN
 Z+RM6fhMm/INFIJUJhbGHozNpI4VPOdG6dxOBHEE+mxdyH29F9WwCt1J/+6zBotySYp/LofbCmN
 /xnxl8x8SpPKYVIWnaOMw7qNak8G7AXgTl5xI3QOTJW4YyUEy7f+fITOyUgos15pecxxteSXvNi
 dQhySLrHOl6AOPIMoWDpSsbK+XGoUL8USBqS/KLe5ZYlGw==
X-Google-Smtp-Source: AGHT+IGCmJDV6B1qU7rx3iOh8BY/TM6IK03oNag80ALUTzdDDnKbflF3ycDDt1wjHngVajiP5a/d4Q==
X-Received: by 2002:a05:690c:6906:b0:6f9:3dd2:7941 with SMTP id
 00721157ae682-6febf3ff1c8mr41011767b3.38.1741357479666; 
 Fri, 07 Mar 2025 06:24:39 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a8aca5sm7375797b3.62.2025.03.07.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:24:39 -0800 (PST)
Date: Fri, 7 Mar 2025 08:24:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 46/47] RFC: test/py: Deal with timeouts
Message-ID: <20250307142436.GM2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-47-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fJdbIOyACAMVg492"
Content-Disposition: inline
In-Reply-To: <20250306160428.3041057-47-sjg@chromium.org>
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


--fJdbIOyACAMVg492
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:04:13AM -0700, Simon Glass wrote:

> The distro test takes a little longer to shut down and restart, so
> add more time to this operation.

In the test, make use of u_boot_console.temporary_timeout(val) ?

> Disable the sleep command for now, as it seems to be unreliable on
> QEMU with '-cpu host'.

Update the sjg lab stanza to also make use of TEST_PY_TEST_SPEC I think.

--=20
Tom

--fJdbIOyACAMVg492
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLAaQACgkQFHw5/5Y0
tyxrcgv/Tc03iYBROXV4oO4oOtlKXe0hosWy96RBqRRlsnyTqpGTU3bCxjzRhEQs
IVwbOUJ5BSSmL2Pwpf+JpIHAyH2Z1DqIwU3DGZXDLD3aYaNsCtEhc20g4PpImc5u
JfgVpWVeJzAatP05A9I1T1SVUEdz1Wi3wCf6ewLJxBklCvUyPqzNiAHEgt6mKumT
USb24P2UzEufCfihft5D4Jr6NDFFP8UJW+Yfi158HA7NDYomxwiaOpu5MbAu9Pd6
XsrWIN2UGw0uMBnJgAaDPZJxLrkbX6k3MNqTUuEZm0lKjzQmgwp5xPYs6p2TpyCW
kCyHd+xzLd1A0iU1IkFXuGTlEy1JSdXFipmDXxU4sg9iXb1vu+PhR9dj7Nv6cikk
FZ6dqxEpEMYLACj1k5iQ9cmQU4+vStDr5PT53APbbNTbMMfOpAs82dAYeZHHSnha
5YbIEB2ECqmSnhFktA++Jq0ptkZnkiSBuEs1sj1t0zqgvqzRTJtNo6oDMDEHrIfE
JUWvkzmD
=5bI6
-----END PGP SIGNATURE-----

--fJdbIOyACAMVg492--
