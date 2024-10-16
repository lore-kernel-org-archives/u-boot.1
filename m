Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95331D2A53E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329C488DC7;
	Wed, 16 Oct 2024 20:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cbd+AW7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33DC88BBE; Wed, 16 Oct 2024 20:45:47 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258F488DF8
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbc28f8e1bso1138116d6.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729104344; x=1729709144; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6rc1m6ElAmg4dQah5i0ODgz7+j/NzKSANFKajw7fpbs=;
 b=cbd+AW7NYniaPpXYsq9DVNjHx8wIocwu7LAZUZhNspJ0eH+6GPjFEuWitSCKI+YzVc
 NE33jcogIByTW/QsqupMQrDXf8hdTbTdLNVYRtgr4ay/W+HOFyov18ybkvLSFT3eXOLX
 W5nwb2pc2a5I1sjMz5Coh2WWOhq77EMezlFuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729104344; x=1729709144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rc1m6ElAmg4dQah5i0ODgz7+j/NzKSANFKajw7fpbs=;
 b=Oz8kpIXo4kTvkeqQWAjCYFAXPmCktqeDaPGVmkU5U/A5reuAdE50dLzBlEqwqmZPIw
 4YW8/CmIy3sS1qZPzkcs8Ycl31ebP+mlWRedn1sbqhmFRoRSRG4cfzwVM+FN78ta/3uy
 aP2WFyiWPlIDiy7t68R6W2AdUyHCEd4BCFIbkOeAnmVAtTgj4Pz11H/ceogV6q4oTm+Y
 e2P7eO/6RTLtZoQfN/oirnCUivibSviwFWMQgOWDZAf8QNFAGcnPGsrhvjzLR/Ua8UQF
 lOod2A7VoCr0zxuQVngy4WzNFqMR++ZWS8xMFOgV4cY57uZ24W9UPynxxGfRKZHzkrsU
 3Nkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZyK22X2UhSgVzivDt7TcyRqZLuHwuZRLN+qADpcZ/JnUEflCMadyeeDGHeJgA55+CYKVicgg=@lists.denx.de
X-Gm-Message-State: AOJu0YwHOFeC/6H/lME3m6dbh1iykJK4Nv/qJkzqzRznl4X7fVBN8OjN
 uQr9oB57388DDaPVTMj7ldA3Gd0mv2buC7wAjMS4IyJeItgQFhgxWskxbKEhqag=
X-Google-Smtp-Source: AGHT+IF4ghJLAmrKbkWGmtoJTBC89JdVktNjlTqylOptWBV7meVyJwkw6jQabD3CEY8DjlJXkwcwCQ==
X-Received: by 2002:a05:6214:4589:b0:6cb:ef7e:9bc4 with SMTP id
 6a1803df08f44-6cc2b9224d1mr77438916d6.34.1729104343968; 
 Wed, 16 Oct 2024 11:45:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290f999sm20812626d6.10.2024.10.16.11.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:45:42 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:45:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Simon Glass <sjg@chromium.org>, "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Gilles Talis <gilles.talis@nxp.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241016184539.GF4959@bill-the-cat>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
 <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
 <PAXPR04MB845979AC895A90D969E5F216887A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7rKUP1bedmq7wTnc"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845979AC895A90D969E5F216887A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--7rKUP1bedmq7wTnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:16:14AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device
> > tree
> >=20
> > > Why isn't this padding and alignment with the BSS being taken care
> > of
> > > in either the linker script or the binman dts?
>=20
> Sorry, I am not sure what you mean.

I mean, why are things placed in this position to start with? Why is the
device tree not already in a place where we aren't smashing it at run
time? Is this a problem of the alignment / placement of items in a blob?
A runtime placement problem? What?

--=20
Tom

--7rKUP1bedmq7wTnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQCc8ACgkQFHw5/5Y0
tyxdCQv9GdaTBdMpm0KrNZXZKhTQT/yCMTBJh4GJkX/vAI8S8DLAjPrD8CSL9Tnj
4QRcj1Xbf9Vs95NSwpvoFcEa+gxOGOQmocWJS0JGrvJfEtW3hvhrWnaPuT1jUTVa
+5VoXmrRS4dMd7//6HaMmSrD0aooqRcsYGGJRiT6cZ4BjlwYMzQKQDywv/h6qOfT
xablE3SaDkH9Er0TiqTZpHvCavwUck8ghLX9mh7sxT9dRwgkOIsthC9ucs6hbDjw
U7cyzsZ3S/UqeFtP/sWz31FuaNEh8/LaFQdPOXS1nEOTCq9NoQfXG1fiSwlFPgde
okrbH+ZJ/BA+yBP899GfWKsKYs9oW7Tz4aJHWyOQFN6ChKA7Sq9ay0kwfz4i867Q
S0nVc8O67WVUzrRTerSTuBotHYqMVwD7bVYiVyuMHARUVt99sqNj/9/XehTKlR7a
8MmI+KYUvVcnctCm5IEIP05fn6BAx5kEmBj1m/PgEfLAesvZIn76nTl4Hqkjkl3c
gfikOMAC
=qGBj
-----END PGP SIGNATURE-----

--7rKUP1bedmq7wTnc--
