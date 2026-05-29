Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A585CD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 14:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2753844CF;
	Fri, 29 May 2026 16:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uWqok571";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45C184671; Fri, 29 May 2026 16:19:51 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E68880087
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 16:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de431da8fbso11370264a34.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780064388; x=1780669188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3QIfyeBy/lEffEqkLqvXIqJBOoWxfoj+V5rlfkxAo3E=;
 b=uWqok5717XTroph/+oOBXLR/CcWF/r8MiFcrhOv73wiKk8rk7i5HMMYP0iY/LH73TX
 1dauFiIGgbNTjjPJeadPG+aqQqLbvUYh/k8P/6WcnU3m0biMCxj1+Cm7BSJv0yF6C0zk
 NNvSroEs/mzAMTOxPkou0x9yMRGGvOl1k3dBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064388; x=1780669188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QIfyeBy/lEffEqkLqvXIqJBOoWxfoj+V5rlfkxAo3E=;
 b=kSRfVl6Evs6tP6hhtvuUZXvkiHLbUXZjd3rDU14DqXvu/wWCfAi+ky3Fd4uXUCrFHY
 V3AKYM+hQBNUk9DzssN2/u+sps/XQ1F4NKnGL2rM8duZ7GS0/yDVKG+IlSLNz7ubjjG1
 Pagn0+2iaDbZCegcj3MYJhMjR1HCyckrwYYlFSW/uc/+eDEjzorZaMElFhhPk/QBVW4Y
 5rrWSZN/xFcervrtZA4XX1dwMd6N8iWtuGn//ttaH3zHw3H9mwX7ZrpCnfBvByYuVnQG
 S7ICctZWGkCjBhjrf6WSMa5sZ8TscIiTIZqGDXGdqKy9ly7fQ9mjO9EqFIGA6BreOlsr
 5jSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/95FVu0AHgwuUr7n4xfr1uCcB+0mSaFXmcwCGfA2QwNmQwT7kII7H5PzWx4k1PlpZHoHyyAIE=@lists.denx.de
X-Gm-Message-State: AOJu0YzQURt6wxATykBlQJQkuhlhZnwroqzoOV+fuR0K6X/wlqQTu4hT
 dnaqQhZHjxcYGXUI9qx8xqlJ4ZQWHQsbyB0UgDYJlIb5Ylvn0qDhwoVkGdHnARFiAPk=
X-Gm-Gg: Acq92OEIKluggSV92LNed63lA7PmfKvKWMOpOX4AG51DXrkY4CKvF18Tc+E+IbwcBQ9
 mOyBT4RkIPs+JlNQLyQoh6ui7qPMNNSjmrDbfNKr9NFqlaN8bTthlt+fxIX6r+wzJ5XUrBN7CFf
 xpxLoDWaELWITbQCc/Cjc/G1gdW8UXXwL9D27B9pCfVwqfA3TvuCc5tIDFcl4FbgzOV4SaMfptm
 DZVOx0Upjdb5TjlTBoxbbilIxAmpOEuJglI1uhkjmQ7CF8yKKDtYh4YJId2cl8wqJnZ6BCErer1
 wvi1jtHEbK+08Y/mfWWxfwhoL+k3+ZzbgaXxK//2IxF6/MLKIgiAPX2xutkDhgIH8hya52m8FE5
 WIDs7UtebI4jBlGYRpmtGlGdOs7hWsdPxuSDnzx4+zX+ubIF/NidccAFrfnyPA+MddpUgFZeQ8S
 c6ip96OJTYqqsyPzmJZxMmhBUGvGeVT+EXKK5u3a4GkmyynUdanXl+b0k8gk8pY8KxR/LmVx3OY
 pR6xCfBOL54GclAxABk65pK1g6AmatrK5nbYyEOQ8vNXk0JqaJKEgAU
X-Received: by 2002:a05:6830:641a:b0:7dc:e2fc:53f5 with SMTP id
 46e09a7af769-7e6a1d6ae84mr15796a34.9.1780064388269; 
 Fri, 29 May 2026 07:19:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d17b1asm1488181a34.17.2026.05.29.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:19:47 -0700 (PDT)
Date: Fri, 29 May 2026 08:19:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 1/1] usb: fix typos in include/usbdescriptors.h
Message-ID: <20260529141945.GH93986@bill-the-cat>
References: <20260529134909.301076-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GOgsZ0yvVLAZ19hL"
Content-Disposition: inline
In-Reply-To: <20260529134909.301076-1-heinrich.schuchardt@canonical.com>
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


--GOgsZ0yvVLAZ19hL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 03:49:09PM +0200, Heinrich Schuchardt wrote:

> The include for USB descriptors has some typos. Correct these:
>=20
> %s/heirarchy/hierarchy/
> %s/usb/USB/
> %s/configuratin/configuration/
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Add an introductory sentence to the commit message.
> ---
>  include/usbdescriptors.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This file is only used by include/usbdevices.h which in turn isn't used
anywhere. We should just delete both, thanks.

--=20
Tom

--GOgsZ0yvVLAZ19hL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahmgfgAKCRAr4qD1Cr/k
Cg3fAP9TghvukTbKexCXWW1ksO35naUSWf4PTcJqULnBVhTAXAEAw2WW6PzssAmP
oNaWTrnFgln7xZtaOJh6bRnP6wYR2QQ=
=EX//
-----END PGP SIGNATURE-----

--GOgsZ0yvVLAZ19hL--
