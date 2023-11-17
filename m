Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298BDC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F28874F9;
	Fri, 17 Nov 2023 14:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C27iYd7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C9F874F9; Fri, 17 Nov 2023 14:42:18 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C29187509
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-777745f1541so122777885a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228532; x=1700833332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XfyDHB+N3owUK8W8VFcS2jYrYFuPnpyV0JdX32dFYyo=;
 b=C27iYd7XIeXg+ZXA0WZ+8SdtbIc81nDBJVXYcapRu/JaFSE2Ad/VGrRbF0oYJlmXlb
 x7Z0xgf4Zvfz/DS52uP6MdrBWQnvZfzKXtcNjUoICbppCG1RWvGvv5jxoiBqyFJiFq4f
 PXDGMlN+1badTGxsd0hD8dAaycnpoJiIHFJ+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228532; x=1700833332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfyDHB+N3owUK8W8VFcS2jYrYFuPnpyV0JdX32dFYyo=;
 b=EpvyWCXZfXg4m3q+mFXFYj3Pw304K0RPlmU28G0DTLzKd8kSScAMTVEITJKeKq8lN+
 z2sm4RnN85JZEW1BlyYRbFpJaMM4EzzZrAolZx9sthHhVNvbiFlPi6hPBSpJOIDl8P9e
 8blJef0+GR3ooeyn89GF2zDEjzAQs89qZJDQMEm5ZbDBi1XLj+wC3Zj98Z50bjKFzNR/
 T45jQGmOyLtDtH2Vc6AlYd2qD3/S2cdqtB9kBZ6VNVXgqMgQrmUNX7NSWmOoOXQUjtsL
 QFVDGBk6MpQxDNot3z8vFXgkIdIBEqKoMQP3odpewqZSbSE4ek4tD49MRdJ++q3mgezb
 Ek0g==
X-Gm-Message-State: AOJu0YxF957KpMeXEHnPzakJcUbU25x+ADwSX6+hbmofZOGZMqdVna6P
 //ON7vYCsUUPde0B/3S5uuseuQ==
X-Google-Smtp-Source: AGHT+IH3we5nSR15aJk11C4O0myLBh51z8mPGsa1uHDGjh7m7AAuYM6gdc+opITGTPIEHbQZ1FjU8Q==
X-Received: by 2002:a05:620a:1790:b0:765:aac3:7667 with SMTP id
 ay16-20020a05620a179000b00765aac37667mr15256405qkb.0.1700228531895; 
 Fri, 17 Nov 2023 05:42:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 rg3-20020a05620a8ec300b0077a02b8b504sm604954qkn.52.2023.11.17.05.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:11 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, prusovigor@gmail.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Subject: Re: [PATCH 2/3] spi: meson_spifc_a1: Use define for time interval
Message-ID: <20231117134209.GV170968@bill-the-cat>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109200943.2.I02c5c81c1a5a06b51600672691f448909af473ea@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hIp5xUKnkyOWtXuj"
Content-Disposition: inline
In-Reply-To: <20231109200943.2.I02c5c81c1a5a06b51600672691f448909af473ea@changeid>
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


--hIp5xUKnkyOWtXuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 08:10:03PM +0300, Igor Prusov wrote:

> Use USEC_PER_MSEC define for timeout to sync code with Linux version.
>=20
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>

Applied to u-boot/next, thanks!

--=20
Tom

--hIp5xUKnkyOWtXuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbbEACgkQFHw5/5Y0
tyyfSgwAr1PEdp40UgE0vOg+plgq1LIGvOAJh09pJCVy+hlRSjc5imzI1ORcBcoY
apB44dexXv1Y+iB9FhOiV0ya6+aGigjG34+35rRXSR4ZtqTCycEinVXiFsl2Bnst
FgyYVB3mntfcOS1Nwq0pg64g/R7SpVihfbVo5UskF2on4+zaKZOW6ifud1Gh8rJ9
qEk3c3YAB/ckhSRXY1QpcH6S5yOiS91lMrTfK6JazInnLP1j9JyyNHPjkdiSgO4V
ednHzwQz+rtJqPzFC8YEr36gv7EnUvjvuCjwow6L7nJIu6FTRMEcDJkBlETBdkHf
6934Oa/mRvpD5RNj8OP2OlcmBic4rJV++oclDFZDY8Gy6NiC8rbHJVFDfJCNDFgw
DvnZPXCsaO7kVNWynATTCbN+Pl50ewdrKclud1SNKIXtgSlrx74X9N5FO8xYQBTk
3hfz/LWHrR+6MhBd3hy/1Z5qymmbN9aBEgqj6Ey1SyM3prqZ6XRV2tIVP7/m+65s
+mV++4YS
=rmHF
-----END PGP SIGNATURE-----

--hIp5xUKnkyOWtXuj--
