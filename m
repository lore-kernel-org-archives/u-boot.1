Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52420C5ACC1
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B39383CF5;
	Fri, 20 Feb 2026 17:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qgj1R39U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759CE83D0F; Fri, 20 Feb 2026 17:11:46 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1AE83A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f015a3259so765771b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771603903; x=1772208703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EK/mB2TvKSLGHsU9eB/BnzPsn5mmnmgl8umrpcYqlts=;
 b=qgj1R39UPo2Fo3T/CDJ6Fw0XUphrS6QaLmHjT1crprZu3usBN9dTTiAhLvjgm8OdA2
 cB9htgmAkfkEsKnxXEUuXS+OTNtquGm9PGHiDOJP/AnQBq9/J6q6WCPpgXHSX5knIy5K
 AY0t3W+x++WEOZmpmfbHVKVxgOJC5/ZiHKbEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771603903; x=1772208703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK/mB2TvKSLGHsU9eB/BnzPsn5mmnmgl8umrpcYqlts=;
 b=g0GRPg8e0107QXmbDAo5v9WeVpRhlaqhfIZGPOSryRKSxplVrN5aeOYWfNL8vm4xcE
 0uOyAKpH66HDnEJKS1qoxQMA/QsOm98Oljh7uAZPro3JvMDFk4itnjXGWMaf6hIFUXI3
 OmRI4AB6FfBVHPwsXyRp5lEP8qFQWp/LEEX9h8b/q07IvU3qhPNaqv5WwPE+sw8lICK7
 hsuojJr+YHCwmqZJe+nuZ0/CiGW0EL/JylWoYnhFDa8uifCw7IBtgZzLgFp2CDDcFo2S
 Uczr+JKD3Aj5LTdpl2MkguENn3hx732jCWmXj2oWec95eFdO5SAEfRRq7CwQpmT1DDDo
 cT3g==
X-Gm-Message-State: AOJu0Yynbv9w8pBJfH497WTP7z6ZjTr3384p/gaFYG8SYLS9oNKC84/l
 fedxQN0cgvU3qtiR9JKl/ZskHffE3MCcwz+QmkUzx+TJz6GATge0SV+N/KpwPcLz5Bs=
X-Gm-Gg: AZuq6aJr9X5WeUtaayAOujEobbtmpUO4shOhLgZJT1Xei8czwuht296/kBP36SbYskp
 xDB4ULP35sJl2hBPri6RYwJSdurmcDsWplNHcUFBk7DuhEWtksCLSPwe1my+xcAg1jDKjVPe3sI
 mHjUi9LQKh3cx23MHUSu6GBZw0Lj2/NET5IlIE1kuC/4dRMBgMHVMCRK8cwDmk434UuSlAPKCUB
 JnpLLXAqj41EJjFCR3yZWVQwk1xvPEeaEI2paBnRglL/Xau9MKRqCoBPG+ckrbQjvajzWLjK7Ey
 ho0xtgLv2smk664tZjsilnlfaXbVWJybPLKNknKkVs2O0rD++rHKczoNcUTrYIQxhIESUFzmHHz
 cRIpksJTC604PkeixL+84JTe6W7fvSWAX/PeM1CHwAEZ/2V0mgUpaGlZdx8xNk95xNdKCx1UDYJ
 P6J6DF+8YztgJAfyhJkLQlM0W7EsUYlVouuCihFRJgbyAFCfrGukDfrP9Yd+stib/kRlQ6+vhkz
 dNdd46cAeCJlKmc0eO1ofYh5M3QebjX9xZ/MpFwPLNB3fQ5JQE4iGzYeABg2Q==
X-Received: by 2002:a05:6808:c1e8:b0:462:dc57:f8a4 with SMTP id
 5614622812f47-464462e6643mr216993b6e.29.1771603902861; 
 Fri, 20 Feb 2026 08:11:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-463f520d128sm9530661b6e.1.2026.02.20.08.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:11:41 -0800 (PST)
Date: Fri, 20 Feb 2026 10:11:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260220161139.GV3233182@bill-the-cat>
References: <20260116194323.GP3416603@bill-the-cat>
 <80dd375b-e905-46c5-b43d-dd4c87e71c98@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u+H9KMV/MdTxt9yi"
Content-Disposition: inline
In-Reply-To: <80dd375b-e905-46c5-b43d-dd4c87e71c98@baylibre.com>
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


--u+H9KMV/MdTxt9yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 12:05:40PM +0100, Guillaume La Roque wrote:
> Hi Tom,
>=20
>=20
> sorry for delay, i check defects please see my comments inline

Thanks for the details, I've updated the dashboard with them.

--=20
Tom

--u+H9KMV/MdTxt9yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZiHuAAKCRAr4qD1Cr/k
ChwnAPwLqQEaI58Vw99bDX6loFTCj+WB3i3f8FE2kv1/s92uogEAjS/bdKWuuKfX
If9LbzXRzrKHzN4eT+TLUuR5cH2PFQ8=
=KGt1
-----END PGP SIGNATURE-----

--u+H9KMV/MdTxt9yi--
