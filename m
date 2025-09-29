Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D2ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B49E83071;
	Mon, 29 Sep 2025 15:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t9FuzbMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3042B83189; Mon, 29 Sep 2025 15:58:55 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1095682A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 15:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-36e4d00ebfdso1221822fac.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759154332; x=1759759132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lAC0BFbQ0M4yNTSS2zpfn7if9OO58greH33YJIiujPY=;
 b=t9FuzbMWeWITNG+CC/wrNW2IzzwGuIhmow7EDVbuRw9syO6C+RBhdvRg9sj5WEt9od
 Ys/A2uLrQ9KXYvLlklxL+Dv06ZF2Hwgx0OGU4PAwQJVybNtyG06RAOIj7nRDkGdxh0Td
 e5lIYESzKna+1xFB4RNDW9iWMeIVBwG7h3fWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759154332; x=1759759132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAC0BFbQ0M4yNTSS2zpfn7if9OO58greH33YJIiujPY=;
 b=ASDzoRG9uxvOkLmYIeZkVu41u9qLKkF7mNFePAjXfpM+TOk4A2j7iPTdncBfPzjrxC
 VP+u7qOuINf/B1K4jZZ0wXB2MZVhtZMFO+SD278w5fizkV66z4mZOYEm/IQBDvHjHODu
 QHmzwQtC7b/OhDf/XF1l5vmm0jJtep1noj1sDrQKCQG/gD7uCcHdwMO+Ksi4RnpATEAT
 nNQIHkxXC1WG9zVL50J8M932Eyd4Y/REUDNt96E4wz+9FfbjNdPYBgqTPi5oEc0UXPrR
 GgPkAZhfBlIb5UdXqefds3rpay2ppJ6X+7jy0soLEvq7hb2Pu2l8RGgpyq3VNSU2hTQl
 66WA==
X-Gm-Message-State: AOJu0YxZ3cFNz5gwD4QW1XmoGkI4obh6y7pl9AILkKJ/8aLa68FwVpN/
 nkSp+gosbBwWRwKqV8gQxVueTJyyEhPKbFq+jUmhtgenX6yzl/zt9Q/L60QjYgxtxg8=
X-Gm-Gg: ASbGnctxSzSDr+AePY/HHMj+jMNSkq/LC6SNBY14x48AyNAaQg/ROWYABVla0IG/zMc
 NpK2Lt9H05qVVnSdEHM93CRosmCNmIXDbw5/TLpj8KFdXH+oGq4PMXRI5yUC0/O+nd6JcpnZkxN
 /bDCU1irdSJnsxRPkCUH9WWrVMjudDGRSrIHNEhcOghI+Ot5rAmXcSNPlIOSHcVrP0iNfFg5ngi
 zFXWFKZYqD3hh4uFAd2yr3U54VkMqZtyzgeOvln+6kr2Z6owNLScakntRza4QzqCgUJVNfTtoiH
 sZab4FOJirxbXoWDBS56hv/f63ct6gq61vmMZQQge5H3va4WNdwLB48xnvh1I2fTaxZwOWs6QOi
 EOKWKdhlMpgB1SL0e50Xbi4fIdXTooDYmTb2sZ3MrxoRI8Hx1rtCYGD0tVDWgmJw563C2kdBlQ7
 ApNg==
X-Google-Smtp-Source: AGHT+IH3YiicE431q3XY1t5412lmwRmlt1ID3Mg8h9F92A29foCcsN9xBgvh4pxTOI2/CijoMy/oJQ==
X-Received: by 2002:a05:6871:487:b0:321:2c50:30cb with SMTP id
 586e51a60fabf-35ebfac6d20mr7637905fac.12.1759154331643; 
 Mon, 29 Sep 2025 06:58:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a3d46f3fsm3690024fac.9.2025.09.29.06.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 06:58:50 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:58:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] include: completion.h: Convert the rest of the dummy
 functions to macros
Message-ID: <20250929135848.GA6093@bill-the-cat>
References: <20250926153128.3680800-1-trini@konsulko.com>
 <20250929024524.GC4184@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BD3imzdBQqijARNB"
Content-Disposition: inline
In-Reply-To: <20250929024524.GC4184@nxa18884-linux.ap.freescale.net>
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


--BD3imzdBQqijARNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:45:24AM +0800, Peng Fan wrote:
> Hi Tom,
>=20
> On Fri, Sep 26, 2025 at 09:31:28AM -0600, Tom Rini wrote:
> >While we declare some of our dummy functions as "inline" we do not also
> >declare them as "static" and so it is possible for the compiler to
> >decide to make these as global functions instead. This can lead to link
> >time failures in some cases, such as "allyesconfig". As these are just
> >dummy functions, convert them to a macro instead.
> >
>=20
> Sorry for my ignorance, why we not follow Linux Kernel to use "static inl=
ine"?

I don't have a strong preference. Doing these as simple macros matches
the rest of our dummy functions here.

--=20
Tom

--BD3imzdBQqijARNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqQlQAKCRAr4qD1Cr/k
CkptAQDQ2y8Bs2DW3Hb2M0zQPUimydEYDjLlApcS4DFf7oLYFwD9EOkUxMyXM+Ao
OcRaKq3NORvxYuIM1J3V1RJAlLWtBAY=
=jltR
-----END PGP SIGNATURE-----

--BD3imzdBQqijARNB--
