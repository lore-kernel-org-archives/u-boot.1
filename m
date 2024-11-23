Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784BBE6ADD9
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0213B893DF;
	Sat, 23 Nov 2024 03:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aisKGXrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E0B893DF; Sat, 23 Nov 2024 03:43:07 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF79C898A2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b1457ba751so171165785a.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329784; x=1732934584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LFDKLDEcRLy4BuaQ7gJuKTriyKujTpfdvD6ZRwdvGB4=;
 b=aisKGXrncrpL8SQN986ftjOWnJ15sMrnn7QsaNp7xgKeGdMFmy4+nxjIT8SS/zWh6h
 soFwF3R3M6uNUl68u2R9gMMrMp3ZcGNpxPIhFJWXhokUauUyO6oJ1VSMzZ/vKUpE7fz7
 Afgl7P/mhcHOS/LBGiKYo92ui/m/8Na+V7po8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329784; x=1732934584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFDKLDEcRLy4BuaQ7gJuKTriyKujTpfdvD6ZRwdvGB4=;
 b=bjT/GiE/gBqpWkQyJ2RxsY88tBr+w2LylGK76Cu3Jzl1m0kvnOPck442NcfbvpDYQV
 pgnvjUQn02rRJEfLUivI+X+Q2607I8StzatX5uRBMwNfiydn5UbhnuVZeMbodl8U4eZY
 UzcJb87TdWQd59Qp5+9ihfD8Tl3xum+WzohfrEyxWVlPKmKYyN/N0x7ic1T4z872XrS1
 7eZz2sTn9EuZ6ct6TxJ1SgUYU7pngdJq63qY98HH90N6cYCz1T1QT4h3jbogzQylv5+J
 sNqga7BZqHtaqUEyOO+czqx+ZwTHg8KZM95DXSC/SK4kv1rsOAgK+X1PS9c8+9aRy/jG
 Uzmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAcZe7QDKswXGYj9LzM6Ujl94ki+nw6JNsiDMqhBcLU17lAkSgvxDd3M0sZaH+9YUS5j7xpDM=@lists.denx.de
X-Gm-Message-State: AOJu0YzHrlRsu4l7jEL5fn5R1ikP49zOloqlF8gi8j8rBAhc9uSi+Dt8
 IiDeZCD++YpA1r+2vN8yR5+YcYEMneMOyaQMB4wwbx9fiH/yxNzwztn9dK+U8QRXfjg1n98na9X
 Y
X-Gm-Gg: ASbGncsRMMpPozE6MbZ9R+cK8jUzj8qr4E5ZlOSQWIWefZYxPTdCz993vduhfY1BHTY
 718vyJUQWFwSO/l3CAdR4ZvrW80cAaBu0n9AzRmTVxkJRMn8mxtWYwPT97lLifFoL4N+s8sw2kJ
 5uX1QrlPhhUE9kBQxhc91KAqIsMG+/J5/H+5N8LZiG326IHCVA8BJDQ1A6MYybI9dXqNWz7+hKm
 XjB42PtmKHmFptvz+dFKs7sSuiF3T+kao7meabqa1JdC4kR1A==
X-Google-Smtp-Source: AGHT+IGfmsSfVzJUJVM7kpthKRUBz8pXxeC/HpwkJK53i4IeDWaWVi/26BERxAAoIjb0OvnUPBcVcg==
X-Received: by 2002:a05:620a:bc6:b0:7b1:462f:46f7 with SMTP id
 af79cd13be357-7b514539249mr825955785a.30.1732329784636; 
 Fri, 22 Nov 2024 18:43:04 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b513fcc51fsm146632285a.65.2024.11.22.18.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:43:03 -0800 (PST)
Date: Fri, 22 Nov 2024 20:43:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] test: boot: Set DM|SCAN_FDT flags for
 bootmeth_{cros,android}
Message-ID: <20241123024300.GY3600562@bill-the-cat>
References: <20241122-bootstd-test-fix-multiple-bind-v2-1-b7643b59402c@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mUBl5TMBpIAhYDPN"
Content-Disposition: inline
In-Reply-To: <20241122-bootstd-test-fix-multiple-bind-v2-1-b7643b59402c@baylibre.com>
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


--mUBl5TMBpIAhYDPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 03:11:34PM +0100, Mattijs Korpershoek wrote:

> We make fewer calls to dm_test_restore() since
> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests=
()")
>=20
> Because of this some valid test combinations are now broken:
>=20
> $ ./test/py/test.py --bd sandbox --build -k test_ut
> $ ./test/py/test.py --bd sandbox --build -k "bootflow_android or bootflow=
_cros"
>=20
> Shows:
>=20
>   Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4 =
      ',
>   got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2      =
 '
>=20
> Here prep_mmc_bootdev() is called twice and it will bind bootmeth_cros tw=
ice.
>=20
> Since bootmeth_cros is bound twice, 'bootflow scan' will find 2x the
> expected bootflows.
>=20
> Before
> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests=
()")
> this did not happen because a cleanup was called each time.
>=20
> Add UTF_DM and UTF_SCAN_FDT flags to both tests to make sure that the
> bootmeths are unbound after the test finishes.
>=20
> Fixes: fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests=
()")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/master, thanks!

--=20
Tom

--mUBl5TMBpIAhYDPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQTQACgkQFHw5/5Y0
tywKGAv/YzfiQIy2FyG7ns3Da4zlSbLkP2/6vshvtqjv19bN0NQlwJBP9Me/i5v9
c98uYXT71HcrnOcql/sPxTJ16cxYJ2zW1fkRsqnLPRzedSTMTZFffg8nNHEnMn9/
U3DMrsDtvsTjLYDXYxYy3Z8MKAEwISIH3Zgifk9J+WZNdUIfTMWU7a+49/OWA5oy
G1dfLvNwOWM/izIBabOMZx09zdbX7+1fPp4SzrSIt+6jEwDssWLEo116Zn8pw+Zp
H3M5x2qa2+PeT+cKEwPVI3bVT5W5Rs3LBN3mJhJ8QckzcjeX4cihXQuwejTAhOaW
e1GgjTecjxKqOJLUXFtxR4bgkZLlh6jZiQXe1IYJlpTODUIJvhI/4k5DhvNr1Pu/
kyFN+kP8/jLP+KuLYQ1fv7YJ08oyC1myJoB+Fs8kDq0Wsek1ZBA9239OVDWGuaF0
WIaygCMkfrM5Ra+BOQLYU+6PswxAFMqhJveFAITejZftRYFYCusptvnl6ndym8Lr
EbJtiA4b
=R+iA
-----END PGP SIGNATURE-----

--mUBl5TMBpIAhYDPN--
