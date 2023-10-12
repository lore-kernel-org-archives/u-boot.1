Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BECCDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E5086C79;
	Thu, 12 Oct 2023 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OQhOyEIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A014786DEE; Thu, 12 Oct 2023 23:04:04 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B2286D41
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7b91faf40so17598907b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144620; x=1697749420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hzRZaw3yW0KqaFzjCToDLLv++22Be5POMDLzAZw9+wM=;
 b=OQhOyEIheZcgAVZHM00wn44erFyaqti4duAwPCPksu8oP4/19Bz0IuvcKumj2SN1Gg
 6I5ugOm2pxHSj6P9Rt9Hdm2F67yZU7Tw5MQnN5l5iBVmwgBtkwlGNmNaG2TK82ADoRTW
 rAiKYyWXr0zDhZ8fZMPZUDIOH8OZYJrZS9mPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144620; x=1697749420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzRZaw3yW0KqaFzjCToDLLv++22Be5POMDLzAZw9+wM=;
 b=JTNFVBMg/M2T0FaO52Avnn9ttCJ2ZfbmBz8yeRN7xzWuKw/2/yFei8MN7UzZqib95m
 ynB8NQhNC7tMOeIQAViBGZiYphtD6VAmw0wT5VBNDh1c1ud6bMXaulpuZyilz4puq6kQ
 TQMRnMb7s43qxaMSIWIVrR5Su/kslZOuOYuHdyRqayXJBw47kSK9KtQ16jmTL6DNY1/1
 qr+L14AqLW2OVH4f8akpQ8MwDMZCtqk9P4xD/yHW0Xh7xPVVz0NsYAkioEV3zW+ww9J7
 pEB4+hByAZjHJ7Uq6A7+1qUdYhnBK3xv53AXCo8H6p/BuWPKfcduHBIibJTDHPkW7/Dw
 lRcg==
X-Gm-Message-State: AOJu0YyYFjWpCmOFP+mtX5l5izMkg1n3U3yhNr5B5/w5EdswtbHx6QNA
 bp02HIzraN2pHTpWFkkuqVRGOQ==
X-Google-Smtp-Source: AGHT+IE/oNPi+/4M14Gy8OfSejy/P9Hc2ht1/Js8hlUBUEqnIk3zOEeOtjmR47NoN3++NdHJ5MvM0A==
X-Received: by 2002:a0d:e284:0:b0:5a7:baae:329f with SMTP id
 l126-20020a0de284000000b005a7baae329fmr10088225ywe.15.1697144619936; 
 Thu, 12 Oct 2023 14:03:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a814804000000b0058427045833sm216040ywa.133.2023.10.12.14.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:03:39 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, seanga2@gmail.com, u-boot@lists.denx.de,
 lukma@denx.de, bb@ti.com, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v4] clk: ti: clk-k3: Notify AVS driver upon setting clock
 rate
Message-ID: <20231012210337.GU3119521@bill-the-cat>
References: <20230921170038.3213991-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iZp+M2OHktA8/n14"
Content-Disposition: inline
In-Reply-To: <20230921170038.3213991-1-u-kumar1@ti.com>
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


--iZp+M2OHktA8/n14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 10:30:38PM +0530, Udit Kumar wrote:

> AVS is enabled at R5 SPL stage, on few platforms like J721E
> and J7200 clk-k3 is used instead if clk-sci driver.
>=20
> Add support in clk-k3 driver as well to notify AVS driver
> on setting clock rate so that voltage is changed accordingly.
>=20
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--iZp+M2OHktA8/n14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXykACgkQFHw5/5Y0
tyzGfAwAsY/P5SdY5d46JAeDzJIBuqmCGP5CC7dvHfeLimA/zXhuOO1ko3HwMVV4
paGMFA8yWGtIQ94UdqW1SWv5/ADQN8jNF3KwrOtZxxQ87kyHERBQESDWu/AvcS9F
JQbUWFkS4kOdSdGDcGw02OR2yXqQyWbGjZEqXY3qQJwD4a7ftgKpDYI5Yi+w/x7Q
2ZHVG4KnvsPm/PYMmI6LhVTKcW9HLp1pcI/s+HFZf5A/SslVjXK4HksOYeNOw9hP
iH4KFbM2+OIiO0dH6+CxZ1IFHqB1j1wIMPMvDzxWnOBV6O4mkHghKxafphZYuJfQ
ZZqiPQ/D+fsTCLe1rV3C2HnICxH4Tm4KKAlzbsf1Vtoqy+9V19dnlPezGKyW1Xvp
Q+kAA/drpaHFu3gJsNCR012e1m8t7eu0OlsH6K/rG6oFNLIwvE/xGlBHkhw4r+CN
gHpt4IAVWxq8BnVlm9Ll3OUhsWGsCSjuuYOTSUIfAIU7Pf3KUHcKVQAwnSACBZL/
fluDoSS6
=LeDV
-----END PGP SIGNATURE-----

--iZp+M2OHktA8/n14--
