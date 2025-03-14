Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BFAC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF65381E60;
	Fri, 14 Mar 2025 17:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rCOBRZz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D9681E81; Fri, 14 Mar 2025 17:21:26 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFEE80ECC
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c24ae82de4so257917985a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741969282; x=1742574082; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=45b7eEUblOO94HUPa+ZmLBV9Gqxd35JYBW70MrwC08o=;
 b=rCOBRZz1xX3oOwVXL/3iO6KQC822mkVTAoiO0Of3dMnmO5T9VDMOnobI6AuBZDB/Xf
 ca0jE0gFrZTNFAIRt+KQkXtPvkT9Gkmg9lOB1pDrfPyUAYkfeHN2h/r9lzhfypXkjQ5q
 RzYIxdsC3IvRe5ySobkqLcdUruNWBKynGEgC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741969282; x=1742574082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45b7eEUblOO94HUPa+ZmLBV9Gqxd35JYBW70MrwC08o=;
 b=bAK+zagO/1zw3bGILdu1fqWgOgDGcZi8Rdeoc0vYL1dk2/AeA6gptcmUjNifjLLuZy
 fsiSudIi4wf11T5m5jW/PBH0rI317mTGGmxeKxqNfMoPMqk9pO7Mnb4Pb+nPjliVewyV
 8kDCYoe1nTv3y5niJL5DJQ4utpKDdxJSs3agi/zdLaHLXy31DZNsjtt7Ryuh7BW0y5Eg
 Oo96xSrSfMxC8qe/86Vwg6chy1WEPsGje7PCHm+n2E2pGCJLgJvGMNlC5R+O6glq4u1l
 X9VKnCvlCxBN3pwYvfK1puANDCSYx+j/HBod5dshUev5jzOTYG6noQdCTqtGRhFGmM6b
 P9TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf7tC5cFiHvWBctJ8oeMuaD56c8Rifc7U2YNZMct4hqQUtV9uoB/N9KMVEelLRY16gudtc3VM=@lists.denx.de
X-Gm-Message-State: AOJu0YyhxVE+ekVhOnIpquRi85U1YIL4t6Ud5JMUBpZc/LOMlOD2sOEo
 yCnokvqCOI0iyn0dLg2NZJNfPPKEG7nBXgdS5XRsd4zYY2WbRIdHUO3zIYdwsvE=
X-Gm-Gg: ASbGncttntoAMY7+SQ1LgYiOkDrs6Q0Y4Cd13WkpcOYjJ3zMQnoAjmLTUrucE3U/onP
 Poo+1zMI0rI7jvqqXnBl3DjiihOV3cxHB5oZecK1DDEPS5o5y8BQRaRXhxUVNq2UXttoWyFFGvf
 caDAAGj2Zzw4ycdUQsbP3lHFWK8vEnOiLLI+3FomB0pB+z7qfePkipFtOShhuCDHNKo2MotiQ2N
 EIiRICdZKfJpgme0z2R5ThUSTHFe0aJxgw6QfArJmtuQTsVdzVJXzcR6I6gEjoDhQUNbLqs9EPY
 Jxu2NlO9E/amTcCs0TfyjyJLnaorCcuKktnUAR6Q/Nb3cA==
X-Google-Smtp-Source: AGHT+IEQzk8sJ8V3MU2jCT0fBU9YFJXi3c7JCgCsR9aYFNi5PmG6JhfOUFqF2cvL7nDUrLrHsRfqGg==
X-Received: by 2002:a05:620a:248f:b0:7c5:6ba5:dd65 with SMTP id
 af79cd13be357-7c57c91a16amr462185385a.55.1741969282065; 
 Fri, 14 Mar 2025 09:21:22 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c714cbsm274738885a.30.2025.03.14.09.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:21:21 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:21:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>,
 Anton Bambura <jenneron@protonmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] video: edid: guard standard timings EDID
 expansion behind kconfig
Message-ID: <20250314162118.GU2640854@bill-the-cat>
References: <20250314064720.5767-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Looju1Bi0ZZKtnlS"
Content-Disposition: inline
In-Reply-To: <20250314064720.5767-1-clamor95@gmail.com>
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


--Looju1Bi0ZZKtnlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 08:47:19AM +0200, Svyatoslav Ryhel wrote:

> Since EDID only indicates supported standard timings, a large table with
> detailed timing information is necessary, consuming significant space. To
> mitigate this, the table is made configurable via kconfig, allowing it to
> be excluded when not needed.
>=20
> Svyatoslav Ryhel (1):
>   video: edid: guard standard timings EDID expansion behind kconfig
>=20
>  common/edid.c         | 6 ++++++
>  drivers/video/Kconfig | 6 ++++++
>  2 files changed, 12 insertions(+)

To be clear, when the flag is not enabled do we have something similar
to the old behavior, at least in the correctly functions case?

--=20
Tom

--Looju1Bi0ZZKtnlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUV34ACgkQFHw5/5Y0
tyxP4AwApvc9Y3U0MdPeLEas59VxeZwfUy4JYIVjhwm6Hpzm09HB5Tc5DFftGOXz
82OkX5ahtLTRRnhlmGr5NposBCPwF+3hDYZzxPD0I0hLeYGlT8cDgT8IOvq78pdw
lvAh3H2+DSthABm04MMwgbfajdu8z8Ho6CJNrmL3T51EkybDAPwilauOr6hmYQgs
gPeemv4x/bvCNJHosL7VpQcflf3F+GfqBl1ea0UdcH9RsWuJPNKN1rK1hUfzIVt5
x/QG7bwJVRUVbT8X9bBQ9vnksYvF6lvceoIbX4IW3bqM3a7iYJGqyyALZGvjnLNf
+OtD0moeKfghkAIJJgEy7h0GBat7v/Mgil6hENOaFB8wUn+WFfGdhNRYuESajCNd
KPUr936gn0P41jUEY+t3KJCum4suXeGwwI6bGaz2EduJqvOQ83lam0vN45zVHQE3
e/VxBkDGMegdulJyt7cjSNWofamZ3ktTBtYY2tCu8+E0p6X2yURpgt5pZ3HfLs9w
OlMQVYXV
=yNT4
-----END PGP SIGNATURE-----

--Looju1Bi0ZZKtnlS--
