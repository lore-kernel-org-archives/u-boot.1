Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF76AC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0336F87F10;
	Mon,  4 Mar 2024 16:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LOiUWQta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF80986FCE; Mon,  4 Mar 2024 16:26:57 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE55587FFE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c19dd9ade5so2814805b6e.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566013; x=1710170813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RqYZ0KtkdW1b/5V8YFLgHdaqoqBj4DpWDiShcBJQf5I=;
 b=LOiUWQtazv27U3Rrg/EM3/dhzFwAaf3UUVDZghg301H8jTDWICPuDhsOS5qOguH045
 bl9wmaZPAVxf7EbU4kTTvcc60yjoGfrDQyHwNKPHPr092rsv83LidUrHvWo48Zhu4a6c
 5GJ/u9V4yi0rFEQMXWM+BPIFri45nqIaeea+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566013; x=1710170813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqYZ0KtkdW1b/5V8YFLgHdaqoqBj4DpWDiShcBJQf5I=;
 b=JW8WF1I1y3a8o6ufEeQKCVJsS0uhUHXOX8sUnvZJu2yQOrKqTZkjFqiCdthG6GclTM
 75py/GG6clF7psSwZaNQVrl411zu6Welpu4oWKSXM8l/2yv5TSltLcGS/Z9eJe0sx6wP
 8QPi6OtXNpzZHr7Yzum43SCU4JGxsrMF9MCGUHjwxG2ozXQWbblIC7FtktgdTI6As0Ms
 k/q6V+ety65muiOjRD7GUUvH8wDAiUouTQtacpQ72G6vXjwMyEpxIuibcry6XnfMqttl
 wMNw2+OS4NRpCHNd+n5v3P8nTnrkyxbiHkqurKucupaOyLgVp6X6yvjZVDQ3iqndKeCY
 ZRtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9IEIVe/pQDMhNIoYsP3ns6mXVqeP7+6MSAios90XOz73JBoenlIsZUPJaE1aY0m2roiRaAy+pqKLmqCsfv64QxgLiIg==
X-Gm-Message-State: AOJu0Yw0pUwAZZpG9kiR5hLbCMwV7MzZkj51JNoIaQwY0v/gxM/ybrXu
 3eXHCP2+K6JQ8zk7WiqqXiR/a1FIjxplUJAxE6Y+VbCB+rXYD6nx/+q58gMs2L8=
X-Google-Smtp-Source: AGHT+IGT3vQeBgITfOS5ZAoE9AMcPzld5mDrTtGNxQClmLdjCizika2+ZVdKduD14YPndumnW3v/eA==
X-Received: by 2002:a05:6808:1412:b0:3c1:cb2a:b77 with SMTP id
 w18-20020a056808141200b003c1cb2a0b77mr10160915oiv.4.1709566013358; 
 Mon, 04 Mar 2024 07:26:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 e5-20020a05622a110500b0042ef7ad5b4dsm404941qty.53.2024.03.04.07.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:52 -0800 (PST)
Date: Mon, 4 Mar 2024 10:26:50 -0500
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: anastasiia_lukianenko@epam.com, oleksandr_andrushchenko@epam.com,
 u-boot@lists.denx.de, elven.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] xen: xenguest_arm64: map all VIRTIO MMIO region
Message-ID: <20240304152650.GL1523872@bill-the-cat>
References: <20240126102938.12613-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DCZvXhDs76yrl6Qo"
Content-Disposition: inline
In-Reply-To: <20240126102938.12613-1-peng.fan@oss.nxp.com>
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


--DCZvXhDs76yrl6Qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 06:29:38PM +0800, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> When run `virtio scan` on i.MX95, there is abort when accessing virtio
> mmio region. The issue is the mmio region is not mapped. So let's map
> all virtio mmio regions.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot/next, thanks!

--=20
Tom

--DCZvXhDs76yrl6Qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6DoACgkQFHw5/5Y0
tywCagv+Nel4oJL5HjY9dgGCZQ5/BxWYlrUFz9uZQyAAaBUckWsyAl0Af0l9wbed
RVRzlvafURc7Qrit2I3K2S70JWQDgtHFceWHcqNOCiTercmiXN3Cuu+Y27sHgjQ3
fYp6ss2aAwPkD4VbntyzVws7NUxowGVbDZeCrbBPuauC9EM/nzLzn3HyfQPZi8Tk
YyEXBPL04QkUuh4wv4LOPeBm3h+Fio/gbfc0wp/LXckO5JEAMoJnAzOA0Q2palEj
yEdHSmxX04FII7xckvSvoda5XL4Agz5CjeSAmYyekz9FfMzv4olakDUdywHZILrG
mYv4Rb7CTHdJjW0SRFHE/H+N0BR8m8/HAX+RLs7swWkQ65FQ1SpLEr6T6D33dsUt
b7x8uCqSW+9JdhusYIdyR2Ll3WhROED5H+V/3YAfzdDHgzkzYknSTRhZH6cqvNJJ
ZdL2fYHUVLZmdZwQDtPP8GKgsOWyCMnvlbI+7drpDOOSHQK4JD3CNt0Ca4nouFP2
gbUYB42L
=Aa0E
-----END PGP SIGNATURE-----

--DCZvXhDs76yrl6Qo--
