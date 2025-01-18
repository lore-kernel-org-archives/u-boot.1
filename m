Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EF7C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53331803CB;
	Sat, 18 Jan 2025 17:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nj6OyEY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18E48063E; Sat, 18 Jan 2025 17:29:51 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A961D80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 17:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so256181485a.0
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737217788; x=1737822588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y251YPenY7DKDVO//15GNCjXMxGiz1b+ToEvdH9L70k=;
 b=nj6OyEY/FIx028KJ3W07K2uc3oTQ7Mxz1Ln7edoDw10oQZx6QZ6T8foZYug4ebw6pP
 usVCI6AnKJTl91rulO8V8ndhlNjUxFRpPLfqSbu8iOY3zz/0l7vQphAnnLGV/UJy8E2Y
 rw7h+Khtv63frYsxQtfCpfqX4j8/x+9MYxNsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737217788; x=1737822588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y251YPenY7DKDVO//15GNCjXMxGiz1b+ToEvdH9L70k=;
 b=tbjIFTYIEdlQA3DKugz+dAKzGz4RHMKxKIlDBi5lnC1Ubkc0vnbuy79/stOnWUGUTI
 d+bwqnGtbzjV/2L7ZViNREJn4/58bShmFe3xodz29hk+IJXw8/NjF+spmvLaveP+O6BR
 xbycdZZMZ2vsqdoZFfBzCuRVTZU0mJSmOhzRLC4/GHFhiy4P9oZptRJnQfzzUzB/99c5
 rBoJHp5x/8I1wEqaMNNwef35/U7Uogr8kQ0Q4KYzBTEWchFy/WtiDjqz6YikbwVjReLc
 Ogfv0hi3Vk20TIMDVwEmPbOwPTeYJXWHrdO0JmWgfLdYI1nybpx2iQmSPK+eHQ2L3GNx
 E49Q==
X-Gm-Message-State: AOJu0YwUijx30PtD1kX1BgSUBgM1W9GTLDvSdiTRENZWmtGt2I0wVFqF
 dGiT9quQx2wthcBK5PcZh4qHIS8Q38cv67Ok6iTq2I9JtXs7UIkseLWsm0wj+ug=
X-Gm-Gg: ASbGncvLAG+6ldg4oYtA8aYriwgo5IPw3MSd6MjW8zm7Jd8BaqfzhZYbI44g3vrCXaD
 T1VEqAxvmbkKr4tzoCl+OYDk9P5acBK+j+Tat3Hpd1U5uMBgCHyYBzolVD28pLbG072S5oB+3Vt
 HeDF3d8jCkYfRvuxcz7dUwTl/6+Qc+8DBYQu9iNOmLn1bxdlZWR+LzxbUdP+q++nI/QP8Y6Mq5V
 hg7hnDDcqQNuLiVV8BqIUTUrjIFRE6ECRj1p4nJ/22/CffXuRa2i8/zKdKlPOB/SDM=
X-Google-Smtp-Source: AGHT+IG09V4Fg5PdWjXhlYuTzkwnTWdSk9H/ASDzgRihAZuBceZGLD/b3MWJI7cExdw2CTiiTyRr4A==
X-Received: by 2002:a05:6214:1d22:b0:6d8:876e:ef41 with SMTP id
 6a1803df08f44-6e1b21872bamr112888636d6.21.1737217788533; 
 Sat, 18 Jan 2025 08:29:48 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afce395csm23394386d6.98.2025.01.18.08.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:29:47 -0800 (PST)
Date: Sat, 18 Jan 2025 10:29:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v1] led: add function naming option from linux
Message-ID: <20250118162943.GX3476@bill-the-cat>
References: <20250118132234.72046-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kvOYLmWwfsV7ZAZg"
Content-Disposition: inline
In-Reply-To: <20250118132234.72046-1-hs@denx.de>
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


--kvOYLmWwfsV7ZAZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 02:22:34PM +0100, Heiko Schocher wrote:

> in linux we have the option to create the name of a led
> optionally through the following properties:
>=20
> - function
> - color
> - function-enumerator
>=20
> This patch adds support for parsing this properties if there
> is no label property.
>=20
> To be as close as possible to linux import the following files
> from it:
>=20
> include/dt-bindings/leds/common.h

We get this, and the binding, for free from dts/upstream now. Please
rebase / rework to make use of that. Thanks!

--=20
Tom

--kvOYLmWwfsV7ZAZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeL1vMACgkQFHw5/5Y0
tyz/Wwv/YCeoFqrtqE54pi9Lkemn5ikTgdkdEjw5NPt5fcj3JrUherf5CzO6z8/I
wFH8oLfl2SMUd2azfvey6rlemsp7I56obzizl6rRlzinR4m+MaKEtPgwymuRuZXv
fe2cqWOEUjPFij5AK+pDY9GxTZeOeLeQoQfQLacFAiOL442PAYBgmOHFrpRR24AU
UyHvdXSnNMWUb91j8d0OuVuVlCeyCra9tDghWLbRHCint1L1kUuewOhpyJBE9LFL
Dt0ftXW8rGM1zutFOFoR5et2b4QyD0OPabcB5GopZqiu3BLDUVqbLpw5AWremg43
c7uUZauKPvinL8kLylFD8ronvhZPet0YObwE+I7H1dJDxOhIciv4JqRy9teTnVq9
qeeP92+NoUk7nI4mzF/VrfzRg7vAnvna4uSKaDSEIyGiUvN8qkpOGWB/FnUdpyHg
dUDV3/8nndvwO02JJ53ni53VRvV6h791BDm/scE/4S/KqnYTaoHP0tbJYksTdoeI
mIAo3emK
=TnFz
-----END PGP SIGNATURE-----

--kvOYLmWwfsV7ZAZg--
