Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8406D1BDF2
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5085C88785;
	Mon,  4 Nov 2024 22:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kAV56zek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C70E888DC7; Mon,  4 Nov 2024 22:18:14 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A82AC8852D
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbcd8ce5f9so36798116d6.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730755091; x=1731359891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XYBu1uySsCE+JRKUYkZUKxIa3uCMBKIwhoiIN8xCnMg=;
 b=kAV56zeklZttTRb0HyOm03yhdCDopZG4pazBQYWNvwl/JV4NxLZhdL4isXqU6M6gG9
 AMILkk0Fdo7zCg7jfMgBRYxg7/EXqpPnM/BFKQLprZJYxcqJjYvACF1UYJBgwmyqikyK
 x8/iupxE/6p0pnrRlDcTp1JeOIv4GAtdXzzAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755091; x=1731359891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYBu1uySsCE+JRKUYkZUKxIa3uCMBKIwhoiIN8xCnMg=;
 b=Qn169hxL+z0/u7RG6cEnWbRL/gW/ZR6hv39sEsDbM/PVe+wSzvp5ECu8yW7KC5dnAB
 OhMIb2yxhEBCQJ5K+tUo55rSbHQ7QBZLmfpbnZJbTLKyuOvKnxpXdwSI+vY/qjggI0i4
 oOWNCnRlEXSB85xA6xyXvGNisAHSKw+n7Az/3D6c/le/rxT+MppcAFHjRQ01c/wSvRSH
 9OqROw0PKKLWp/PWE4xChvb552X7zuBne+fPmwtw7mSXXtiCEfJydajK+Jg9PsUeYMIB
 FSecqlQP+HI0EDiEb29cZF5fjkwt9LD8t2Cw4yoL9H36qbi6Mf7S7lgryUldIHq0o4+F
 mYWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgNNIWwpxS8vNewsej19HUes8pcn4tgBf3IsdepyPouoXgP9QDOil3smMGVZPd1+/pwTVr+tw=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ0ow9xbTWGsQbAtHfZ6tPSwMHlltqZWP6Nw4mibEQ5gwcEVIY
 Y2NAwaCjIPPK5W+rchFak7HMsUKCIUoWtDQEGwgwcm2aVYqq14oqK1r6DqcwfNo=
X-Google-Smtp-Source: AGHT+IESZE1HauvyKkkHQHzVJ2RuY5wTHFoR0jpKeiKjKN2IH7HufTjAdZEfdViSzPjiiR9KYhfoyg==
X-Received: by 2002:a05:6214:5890:b0:6cb:4b65:950f with SMTP id
 6a1803df08f44-6d35c1aee05mr170425066d6.50.1730755091422; 
 Mon, 04 Nov 2024 13:18:11 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fc66d2sm52469506d6.32.2024.11.04.13.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:18:10 -0800 (PST)
Date: Mon, 4 Nov 2024 15:18:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/9] docker: Drop grub for arm64
Message-ID: <20241104211808.GW3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-6-sjg@chromium.org>
 <E8B9AD50-9DAF-43CF-B512-165DB961CDCB@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OPVD6jHvYd+wdCrY"
Content-Disposition: inline
In-Reply-To: <E8B9AD50-9DAF-43CF-B512-165DB961CDCB@gmx.de>
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


--OPVD6jHvYd+wdCrY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 10:04:39PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 4. November 2024 14:39:49 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >This doesn't build on arm64 at present, so drop it for now. We only
> >expect to run sandbox tests, so perhaps it isn't needed.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > tools/docker/Dockerfile | 7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >
> >diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> >index c4c3dc5a901..60106a82801 100644
> >--- a/tools/docker/Dockerfile
> >+++ b/tools/docker/Dockerfile
> >@@ -134,7 +134,9 @@ RUN if [ "$TARGETPLATFORM" =3D "linux/arm64" ]; then=
 \
> > RUN chmod +r /boot/vmlinu*
> >=20
> > # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
> >-RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
> >+# This fails on arm64
> >+RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
> >+	git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
> > 	cd /tmp/grub && \
> > 	git checkout grub-2.06 && \
>=20
> Upstream GRUB builds for arm64 and riscv64.
>=20
> Please, retry with grub-2.12.

Well, lets do that upgrade separately.

--=20
Tom

--OPVD6jHvYd+wdCrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpOgwACgkQFHw5/5Y0
tyzznQv+JZR6ldb4bymQ12D0HutjIS1eWmmkOtvk6dBsZKTfwJ8J+xw0GQGH+wO2
JlfuKtv3SkzpD3VIMdETYOGy1fqgfnrQWvP8OHu6By/rY5UG8CsepS9BPbOqm3kj
u3qzqp/7WHCjBdxQO1XH+4l0Tz9CQHoSam6yvZOHoIXzYRytWHuXiGNn+aDKzZaZ
PphROnMw4FEPVKvNGpoUIZCpgpQdHIRgOUBNSUTh/Nm33mDJaiR0+6hFKs0JxvFo
7JrI/3AShOs1WMBEu3JIp5eFhMaaca707JMV1s0EhRRy7ESyPF+ZuYVZ+7fUC+Ub
gBLjm8WPNxvdvpmDnteDxZ/NI55GdAxTIQqTJsIJ3N6gCFGWM2xM6uMF1YPM7xTV
Xo4diO5J01ubR2flRKOqjSMYcA1c/9OJRN2+s0cHRd8kZ01RzlMcIirFvtDOQx34
Agn6j0nXmPqtE0Ae1KW2eXsB+7t/MAqxaFs+Vuk9TznoerUxAK2VbNaNv8uACEHq
+KOvi+9W
=r8XG
-----END PGP SIGNATURE-----

--OPVD6jHvYd+wdCrY--
