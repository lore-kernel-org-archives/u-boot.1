Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B9CC021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3596B80F9E;
	Tue, 25 Feb 2025 17:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PhVhuagd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7260E80F88; Tue, 25 Feb 2025 17:41:29 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD4880977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-86b0013770fso887010241.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740501685; x=1741106485; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=61kpLXJQXmkqMo5E3kGgGCVvXoQV05sk++R8KpapMe8=;
 b=PhVhuagd6G9Pw2N8C8w5j0aOo9hZftkBypOy5x4MTvQkHbog3cnwokAsgNtmWbCm+y
 KsZCP5C8L70QOucnWomHNsaSFUOsY4tn6IqZOP39WC/a0oKy54bzmR62/H2MwH09eDsR
 Uc8AZYVUge1QFwBF/9DDU79gJx5N9BQjvaCYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501685; x=1741106485;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=61kpLXJQXmkqMo5E3kGgGCVvXoQV05sk++R8KpapMe8=;
 b=Q/hCKYUvMTlmVUnRElZROqJKQLVXi0Qlw8Ov8K6H7oatbCnPI7qL3rV8OLere7aXSy
 fAUPnA6vuNYDr2Oh4AnQ/sePvhvLwmsW7tHoxg5SNrZpEe+1vijCSxvaJ7Q0GtsePXsm
 t4klesQ++hsHd8EFrsUXTFGxpQzlwDZNvqkmTfmsxOC1aOea2OdIFSTMSoe6ovE+p8Vt
 Wg71hiA6/W4FUuEyhCuYfqdvCjdHtKLD5CGDMF8QNKmYUPbTifTsteqCd4a9vJFnSruS
 zpzShYuIuD74NHQ566YLM54YTxq3wV9kCttkSwXZORi32++OcZLXMvhQQajDhIQwzSXA
 L5vA==
X-Gm-Message-State: AOJu0Yy09zlDQSm2qMJ+YD0QOj6xUlEZk+1TCok2nbqF2tf+yPucqsmD
 0yMvBWeupl/83XqTY/tO1KHzQhXDWVV7BSC2xpe7PE010VoA4f8ms5/Ytu3X4qKlBcFYH64Tdpl
 W
X-Gm-Gg: ASbGncth7/BSa6bEa1IPE1pye5fxJ/AWNXVS9jgTJvEka+A5CoQWHPwTcTabhRiteEa
 aET2rFN37L3nZo8gqi2TaHQrlXDkJxNQSpdkhO1g+u/ZgbqVGtEGTgK05n+A3USKizuTOy6yLw1
 Kr197mfi46GnrKPbMODY0CnJAUXggsHuUVI90bDiw8suJLDiurvA/E+7iGpCSqKc30SiRWoOl16
 MorjG5Pqq2MR8/utHLzHkJB69Sx1xDEbhZWIDGlNsiHLub0xTYGt3U3Ix4CNRus+3MLztiXtpG/
 eQvn921IvkOU61ckwKNHT67g
X-Google-Smtp-Source: AGHT+IHXY09rJX3aBbZqFWQ00ElxTE+kpiaY9KtCbXuk3FJFiMXB3vwZQ7Ef3RWCfs/OYwkuXbmZCA==
X-Received: by 2002:a05:6102:2b96:b0:4bb:4c52:6730 with SMTP id
 ada2fe7eead31-4bfc27ed544mr10183981137.12.1740501685581; 
 Tue, 25 Feb 2025 08:41:25 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-86b1ed4bbdcsm386219241.9.2025.02.25.08.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:41:24 -0800 (PST)
Date: Tue, 25 Feb 2025 10:41:21 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.04-rc3 released
Message-ID: <20250225164121.GP1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IY2OwTEfdUjMqp9Q"
Content-Disposition: inline
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


--IY2OwTEfdUjMqp9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Well, oops. I tagged and pushed things, and wrote this all out
yesterday. And forgot to hit send. My fault. So it's the day after the
release, and I tagged it all yesterday but here's the email for
v2025.04-rc3. The -next branch has been open for two weeks now and I'll
merge this in there shortly.

Continuing on with what I started after the -rc1 release, we had a call
today and the link was
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280N2=
tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhY=
mQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83de4=
da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
February 25th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

One more thing to call out here is that as I've stated in other threads,
I've been looking in to seeing how we could get modern project
governance setup and some umbrella organization to handle financial
matters, etc. To that end, I've been talking with the Software Freedom
Conservancy (https://sfconservancy.org/) and they'll be on the call not
tomorrow (too short notice) but on the 11th of March. And yes, I do need
to make some other emails about this, and will sometime soon.

In terms of a changelog,=20
git log --merges v2025.04-rc2..v2025.04-rc3
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks and the final
release will be 07 April 2025.

Thanks all!

--=20
Tom

--IY2OwTEfdUjMqp9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme98q0ACgkQFHw5/5Y0
tyxoMwv/eMfPTsv3WsSdmQ8XevcjsNUZZdfZQKQi6i0bWsFulfkZhb7wP0WIRgUf
j49XVdLTIRyOZ5NR6pZYCFLaF0jJMVqeweJ3dI6uzQoncejvfERpawNLqLORy3hT
0HB/wRjJKGhFqHtH2QKsG4V6v+bTuAENW5zOUFkwvwOfU2yQARMaYRqFeNDfsjVq
/L+ukwyT43j/McjDYO7GP51VPTlo3u9Fls5dCMoMxG1x9b42HQYB51fq24V7dyfl
MgFwXSxf1i2a+9sfiekJsX5DRIizrro0Ak5AvYZvoBzKK+SWXheY0UotlWRKW5xq
sahKro+ddRVu097KX09xEdAaQ6lIEJHTjAYn6PvUpoB1fdDHoND/aQiYiSis/MmE
8eKyR42/18wAlbZ0yUrpC8LKh8l6+CJ0DbJiWC9d6U40OZklHo3Vldn5RDsKIE15
zE7UBtqBatACloZAeYw27rFnL08UDwkAoYCliVuAP892OywBFNsXmqpeBt1/REx+
by9xXl5V
=ldEH
-----END PGP SIGNATURE-----

--IY2OwTEfdUjMqp9Q--
