Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4132C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F46782A1C;
	Fri, 18 Apr 2025 15:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KyReY7If";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40BD2831F5; Fri, 18 Apr 2025 15:50:20 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6A0810EA
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-60602272211so168049eaf.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744984217; x=1745589017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AXVCTTSNuSUA0P9aR/S2Ex6os4S8bdPp8GNyltSIV7Y=;
 b=KyReY7IfLJOstOv9s8c20R2EtFnwT2DnqpaYZXeX0jnaClSkWp/cPWLRGYQKHkIsFV
 B8Tz3DHaWe7OwX8pJe32nrADu8/m7SDRuZSi3IitUffSDZL0mLQukRGv+0j7sa5u4Fcu
 M5zz0/Ttnl9xOjoTRdYTbnCHT09FluHHdu0Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744984217; x=1745589017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXVCTTSNuSUA0P9aR/S2Ex6os4S8bdPp8GNyltSIV7Y=;
 b=skvYX4gpjrJBZG+1TGQtJUYUtRm9Nw/1awVVk3zxRdKbg1CW1piioGpTgDvBESD5Bq
 Ev4tROyGOLjkm1fvtJBwXg27JYWqN15+IpD7xTrXuhlG3w9S30RjVuce1ZivHfKgtXGB
 Gln8mZQe6o7hEPN5xSPLqCVehzlfwY31YJwGWebTosKZhQIle6YceNqFrs4+VbtmdxWf
 VgMpCQNvQCY1m9gSMk7cwLhIx88Vwm4xnB+5g0EVuv2C9igmII4HPeuQEyV9LwTyvkhl
 aRa+n3xEhgQS5NEAYA93lnNId4acHd1gvfm8qmosY84WEgjPB1dOif1SzQmIuwORrOqP
 E6xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6g60RSsAy46+fZpEkhtCn4YjmNPR0gv5/S6n59l8JC5RRhQakXeAP8v9fCZBljd/YRjWvPTk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0sVPPLy7wPC06pqIo1/i8mQvnY1VaeqZOr4Lld938/yf/+0J2
 cX19PFZ7lcMrz8ePopjsrdAIJuPr4JXE2lTg+PrI6KFWAxFpDcKKHIaPNe666sA=
X-Gm-Gg: ASbGncvlWKaf6d+ilSN5NdsurFxyqwZK/5U6oRAB4wSbIfuA1untzqn1Z88ANaZx6yf
 MVjFhZ5g0R/N01kp6LRw0zP0Kz5eIKVZZrJC6DEeu2TJgW19yRIeeQ6yJVNbBipKspJrGHUaIjD
 U4aK1JDBjNhdZfOwPDIKShPPAcE6WwuE0EpJHDQscytsUK3xVrMqckmt2f8dK/37ftRXc8d8iXD
 1MZevkMnIW++2kSPunPyqD0sgFYL1aH07qlH7iOr1rna4pZKap06E1eS9W+58cJgkdC7kgtIt0l
 PaQydHMoO1TiXdShsyj5S/E1OYUW72MaXtkYCtMmdZkGmBj0SnoHLTjtAkcKLy5bKwtntZ/9NaC
 YwA==
X-Google-Smtp-Source: AGHT+IG4+LlLXUwUAlTk/CXpdyHE8yX6gNYA4qhL+FFiZjFIG2EEmgDj8/LzPiRYSBENBne0LTgz/A==
X-Received: by 2002:a05:6820:4b0d:b0:601:d224:5213 with SMTP id
 006d021491bc7-606004d3dcdmr1456019eaf.1.1744984216942; 
 Fri, 18 Apr 2025 06:50:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff5fd242sm378570eaf.21.2025.04.18.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 06:50:16 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:50:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 3/3] doc/buildman: describe using fragments
Message-ID: <20250418135014.GN5495@bill-the-cat>
References: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
 <20250418043137.537340-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J+sqev+sPIGlnQH8"
Content-Disposition: inline
In-Reply-To: <20250418043137.537340-4-heinrich.schuchardt@canonical.com>
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


--J+sqev+sPIGlnQH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 06:31:37AM +0200, Heinrich Schuchardt wrote:

> Describe the new --fragments parameter
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--J+sqev+sPIGlnQH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCWJYACgkQFHw5/5Y0
tywGbQv/RmeHQXbqAUjLzQOZ/B9vRMYD86SJlK1bovf6vf4HX7y+DYXj3fTn6w/M
4nlg0nyeKAHtX09iZTQ2vivBGnFLOqerOAIyC84yECAb1vx0eqB7P7WtbDJiXTpn
Q1gBvgNsSh2tvgWAWYSuhfnGz/HMQc2YHPFZNwzwLEVNl2GrbuWw/EF4wx0IZEwZ
euTwVCNK/zwRud+Tk9TrqqOTiPVztPA12XFOTHCP5x2MYwwuNlsZl2Lxd4rjOlj5
In1gV9HjleGbaEX+i2nRprxWjuXgDJwc/O+z5y3F++d0k4hAZ0Ek3JHrjzGinI1k
FEzpJDsIkl8GCYT0dIrc/bHDrWY3GWP8mqWXW+3cmuGuwTzWPzvNYQMJJyTUsOhM
+RZc64vSuCN655evMAxcaGCsUifXzDn7xAN4BfnOQkbMKen8o9XVOICRNDJ3R2RO
Ti62XHX0ERIdHoJqUCiMbkR01b+NrAWUUUObp1ifydXlcoSHcCOFzKURvXKHE9JN
jg34ImqQ
=YDRF
-----END PGP SIGNATURE-----

--J+sqev+sPIGlnQH8--
