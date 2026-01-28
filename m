Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B09D3F076
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE4683F4C;
	Wed, 28 Jan 2026 15:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E03EF9h4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA3183FB5; Wed, 28 Jan 2026 15:51:24 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEC983F2E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-662f30d3f1fso480435eaf.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769611881; x=1770216681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KmWe75/jJmvqXnBHahYvebQF/7YywX6MYo2QMMgW4Zg=;
 b=E03EF9h48vuljqB2zR/vV5RmGWtB+cy+WgnwORvDl4KwRHJKDhS1iDU3sh3GPtLjpp
 eptLaXRPp0qg3tzGEgZE6w9ebDcGOi17pASnibioHx8M1UWKVAk5L3AxgGPsQHjrzcB8
 S50NsO/bhdJc3aZd9a9tdkvMNfthXJNqFG6TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769611881; x=1770216681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmWe75/jJmvqXnBHahYvebQF/7YywX6MYo2QMMgW4Zg=;
 b=Z1OaJuWoRHMz0xmBIDnLXreLYBQ2BQFEy9/jH3GVX0uuP24gi1G2KRlgQiJICvm83b
 52VEDqL/d07GIvEKhlkPS515SgJ897rsZCw9JuAx1lmtw0VrsXgg9jrO0n2i7UzR/oJ5
 /6cOuOpvt7z4cSVmUSfwI0V39ieG6wfa7xEeJjWo3lokKUbVM9veYPKglXq1R1GTDDEa
 P6r9F9Ulbyihp+VIfuQnCb5dqJRI96QwD148PMCfwuEWRxhxYPnS+bT/F87uVOzd5Osf
 dhxME2/1Xl90YgcOYFBrPW7X9wdpGAb/aUGJ43CslFv5x7bnyn1F8AqjVIgQjVCtCYVI
 MjbQ==
X-Gm-Message-State: AOJu0YwuP4hzrBpiCmt1vbvqzhpUcXxNL5VVlwN4LWxG9HoYygN4dQSd
 t2LgwwEaTcQHCrw+Tdby5gXz6YDOv81/YhCFfSXP76wi53mSSReEhO4bnVrVONpziks=
X-Gm-Gg: AZuq6aJa3wqGf5k98TYPvoh5xxkf5JwfWChZw7OcxGZhh82kL7ivqKPzmvM68901F9y
 f1FvWrjOoq7OU4w5DVUq+o4Y2uhh1lg8Jauuge15CfcZ+ifgSxAOoHcUGFUmUa1WIKU7oOTTlms
 TDSlafVG25A0ZGqAGe7MUa+P0+3IqpTIRNKrLsBH5NES3OCNDbaMw6fw0Pyj9mRZoe3E5zxXigO
 F4MOdg7PCNv1aEScHbl49QVEJGYCQOTV2L3xigTao+jOn9vVhx8PIWH5UySL2y0aaMKeqrIggug
 WiQDTpvt81IB5dYEHAYs/hZmITjDPEYACxF5uKiUF7fziXkVB3Q/bIG+Z/gnMJS7mc8p7F/VTVj
 RKIsPL3i52uL+yTXdTAwq7FMCj/HYx1etL/EMzf91YoyGYt+tlJLNa8T4XJadzeeYRANMJ4f5T8
 lmDxmGuR4WjtCsQuOmQT1WE78UHQVAcMS4hexyEVtjgXuqzoR2Hpjfd/yyM4qMf/X3DZRf6ANdS
 BOLXMCkaAl8HESNQQjUEOJDzL1FGrL/mcheWDE=
X-Received: by 2002:a05:6820:1785:b0:662:89e0:2308 with SMTP id
 006d021491bc7-662f203a67amr2929014eaf.8.1769611881367; 
 Wed, 28 Jan 2026 06:51:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f99447b5sm1486446eaf.2.2026.01.28.06.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:51:20 -0800 (PST)
Date: Wed, 28 Jan 2026 08:51:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260128145118.GJ3416603@bill-the-cat>
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sA2wWPoI8CLsNeSW"
Content-Disposition: inline
In-Reply-To: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
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


--sA2wWPoI8CLsNeSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:

> Hi Tom,
>=20
> The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> All Cyclone V boards are unable to boot, not sure this patch is the fix?

Yes, those commits were unintentional and have been reverted.

--=20
Tom

--sA2wWPoI8CLsNeSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXoiWwAKCRAr4qD1Cr/k
CohFAQD3YsIqcF6n3Z1TBvJt0SmvNsEyQRJV3TUHoyVZMCa1MQEAnuwntIvk0oRV
7Jh+aFdOR4CpJB2b4gHLYNpbl8bjzwo=
=st4q
-----END PGP SIGNATURE-----

--sA2wWPoI8CLsNeSW--
