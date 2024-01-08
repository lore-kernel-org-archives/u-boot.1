Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9105BC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 15:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B5B87AAD;
	Mon,  8 Jan 2024 16:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VcBuZ1bA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE68387A9A; Mon,  8 Jan 2024 16:38:30 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7810887AB5
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 16:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4298b23abffso7879681cf.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704728307; x=1705333107; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGCApyS4hQVSDLAMzD+tyvGvvvbZDOiXugKeinuW8JE=;
 b=VcBuZ1bAeRFzATtNsqQrAALI4lfycVrKZYCzDj4J/3sQpUTuYYQ7TnerAGMJjrFx/n
 J4U1roDzTAzlTRBghLGPPUBKMQiqVdP26ppoL/FZIS7HwTRHUMeMjSUze34gWjD4p1d4
 F/Km86lif6ivLh/Z6BQ4ToclibTLYxzEzPXhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728307; x=1705333107;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGCApyS4hQVSDLAMzD+tyvGvvvbZDOiXugKeinuW8JE=;
 b=FkuAzgVT9KuVfhNFDpeItKYjjJxZ04cfhvDdMzUsGGXWA11YyZyW6jlVkEPvSnqmyF
 gwN4sQWrCdJUDQMYnr+GXabc8+pRvHahKlXYy+C1GV7MLb4nA7OSNYrzOGyAHMYXPdCG
 xX5eIDrqMoxjRMo+aeVmbnR5nIWdQr/ov6HGKGsGxpNUCK1TAwcMiJwHTVPBFs7Euo4h
 S4csrl7J+xEJ/J2XcRf7Pe7ksva4HFrzAUMLpVt1vIYPi8ONo+Px+/sJKa7GDg5HulC8
 u+BIyR6aApDzgVV2bg7ApHY0NCvtgXeeixoN6ny9N/MX81St96C5Zv6tudaCXWOQ0F2A
 2m6g==
X-Gm-Message-State: AOJu0YzI7tJQHmYHbB18YqzfDP5PhFhhWb9MpAjps/yHutEXufwUkSoj
 C61yQOR7Jhsw/ORYTBCNpO2I1UNUgS9FhGjOEysazkGSc04=
X-Google-Smtp-Source: AGHT+IG/3cq3EfZ5cq5qpGqTE5odPdtMXvR23jPxEYWdsy2D0oiTQNxRLCfsvO+dPDlGk8hw1wP5Yg==
X-Received: by 2002:ac8:5c11:0:b0:429:9e25:1d48 with SMTP id
 i17-20020ac85c11000000b004299e251d48mr486626qti.20.1704728307059; 
 Mon, 08 Jan 2024 07:38:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 en7-20020a05622a540700b00427fcfa42fbsm3593532qtb.70.2024.01.08.07.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:38:26 -0800 (PST)
Date: Mon, 8 Jan 2024 10:38:24 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01 released
Message-ID: <20240108153824.GF1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iaeRmz8QGBdcV85P"
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


--iaeRmz8QGBdcV85P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here's v2024.01.  Once again I want to thank
everyone that's contributed to this release, not just in terms of code,
but documentation, testing and otherwise ensuring things go as smoothly
as they can.

In terms of a changelog,=20
git log --merges v2024.01-rc6..v2024.01
contains what I've pulled since the last RC or:
git log --merges v2023.10..v2024.01
for changes since the last full release.  As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

The merge window is formally open again, and I'll be merging in next
shortly. v2024.04 is scheduled for Tuesday, April 2nd, 2024 as I refuse
to release something on  April Fools day, and the merge window will
close and -rc1 will be released on the 29th of January, and then the
next window will open with -rc2, two weeks later.

Thanks all!

--=20
Tom

--iaeRmz8QGBdcV85P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcFvAACgkQFHw5/5Y0
tyx53gwAnBJhljuyBZ9Lu+p9kTesNZrecjt5VIB9Pxdr+8URLbSAQ8ybOPupz//o
PKA0L4lGDWdP8Lmu3EfkcryFBlnQP09BqbWd79etP+Qr+TYPCMBOBHXwLN9uqyLo
3vwnVf/wMYtnVulGwws4tOCkUCooLu3RUk8PoQbaddgODm6veR5X1yqhOWPX5yMs
SqVj3Y0GLW0SFwG/AtOtQUzp6VC0TwUOfHSCl7IFUEEUhWMYZ7pr+5Xqz9IQ7w/J
fvZoH8DpFRkkqs+s5Bl9XlzJ+AW4H9dI0qU1EYKAqMkrse+ZXuC/Yo6i4nNTp0hI
vQ7c+Oau4tHXknQP/8j2J8imOdNcUofLTtT6svHN4VXCUU6kFyXzmLcoCxLpEa5T
76qyfTJ/X6i3DJRJTIuuiAyyUXTHteHFxh8loPvsTKVIdIygv+O1JjbtrAfg0Pq9
IWu1ubhPf2OXrYYz7ojK9wN7slwblbpHDOgzYy6dyvJDYgF7LZXttnSGaI13yH84
Ijipv3kv
=xZ8Y
-----END PGP SIGNATURE-----

--iaeRmz8QGBdcV85P--
