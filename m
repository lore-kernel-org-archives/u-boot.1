Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C3ACD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D4A84995;
	Thu,  4 Jun 2026 18:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ALpSN2vF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9022D849A4; Thu,  4 Jun 2026 18:06:01 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EE1848D8
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69e4adf9ea5so487330eaf.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780589158; x=1781193958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rNwP+DqGTjrGQ9LzoMY0q7USSRW1/zXfKs1W/eCyY70=;
 b=ALpSN2vFFXTkJmuxzaAPnpYg/6iVdG8q4zShrE2EvjMlt2vV2F+IdzFyuaIiqOy+zz
 ma3gdLl3mbMQX+liVYPP7RWGFn+rZhnd7777lvPoYDRp0YLEzxw+18t3VRcGAV5YrQL/
 o+dzIzU0BER6CCatUOYD2VMVIGU2na5KaayCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589158; x=1781193958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNwP+DqGTjrGQ9LzoMY0q7USSRW1/zXfKs1W/eCyY70=;
 b=WoT3aW77IJNG1SiU2ZgNTaIHFVgLN1JTqhEc6xxJLP+yM3OpjhSGzYNHVEQSsL/YrZ
 4K44triYYRfImMhseMfEB5unuF35ADOBTCD9AXaETumR2txLWcN19n+Dcq4Of8qPgfUt
 xvutx169w6uErnSBlTturWY/U8F698+dldluDaYd1CXMjHeQGSbY1tylFuWtF2OpvLZq
 VZc32oqSrLgimSz2QcfORM5zjzUncPnzUseTwCCwfllYNL/ElA12V344jmDd5ShU0sUY
 QKNIVGeu4ggb1TlR8G5Q66sm/GuAVV+/HPJSAlHTj/8MuGmLE/Xgo689G8qlG3+oAVre
 ucsw==
X-Gm-Message-State: AOJu0Yxjw3JwfZ3XnFi3amJ5t08OVzI2uew4z8P/Td4gWy4CwD+0EC2l
 Ts+UO3rsxBMTnjueury520A/25asyTyN2FUW7liZeCedbCnrG2xpk+7v2Tm0z21e+Yg=
X-Gm-Gg: Acq92OF3M3kcdFPPEr0mGDOkAb7UntCQ+SXDaBJaaJufg5ti4B8jdBAbP9rRWyDvB6u
 9ooZiqDKRElD4N8wWzOTZIyYJbQJuhQAujXkWxD+lJq4C2SE+KSL/I6/Mc7b/3HnJ7pnbK8i86Q
 LeJ1/UNxrOhl6aPGxOAYrQ8aZDGsONhxkYs2NMcMloZ0dOHMJqx0wpJ3EP7zsYslSdFcyzhSU7Q
 zSXImYMD/3F8xGKwhLAfOQcUrWTnkl8K+yBgX9G+E/F9Zno7ET0vhWdKyBp7GYBUCBK65XNN5NB
 jrtOK46cfjduzoRmzzmgjdQivAo++hfRLVawD5eO3SU8AOUpOJfaLI0xxx9ttodMtWow6gGCEhf
 O+oGOPwTR/LsvsN0OpTwvtRK6TbLU+INmD5x7EOBDnmV+hcBLxRsmIokNv75fDss31tQTXgJlyf
 6b7uRjbbEj79zU95iteiJLHGbVOq126Nbo9uQLl6wSqIQ1+0i3kaw82b/k4dy2ilVmNZvYkntfx
 2tj+uqO4ZpS1a0MVwLkQEpmb2GMXAWNkKG3LSWzWsZuGC4p6g29TVb+ORZpM/5O/hB1y1C+
X-Received: by 2002:a4a:de88:0:b0:69d:8f9b:f2ef with SMTP id
 006d021491bc7-69e4807dc9cmr3728199eaf.29.1780589158244; 
 Thu, 04 Jun 2026 09:05:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e4620b0casm3703316eaf.3.2026.06.04.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:05:57 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:05:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 1/7] pxe_utils: fix W=1 kernel-doc warnings
Message-ID: <20260604160555.GS627328@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n8lJEZ4TIP/BG9FB"
Content-Disposition: inline
In-Reply-To: <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
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


--n8lJEZ4TIP/BG9FB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 07:31:06PM +0400, Alexey Charkov wrote:

> Add the missing parameter and enum value descriptions reported by
> scripts/kernel-doc when building with W=3D1:
>=20
>   - get_relfile():           document @type
>   - get_pxelinux_path():     document @pxefile_addr_r
>   - enum lex_state:          document L_NORMAL, L_KEYWORD, L_SLITERAL
>   - get_token():             document @t and @state
>=20
> No functional change.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--n8lJEZ4TIP/BG9FB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiGiYgAKCRAr4qD1Cr/k
Cka3AP0RwP6ICRR6hDQt0wexRZ1AS4mYEiCKC+sSTLV1Qd4IfgEAmGSPQXTWDmBj
IaXmiIq32CKlwFS2QffljaUJxI80sgU=
=aVgx
-----END PGP SIGNATURE-----

--n8lJEZ4TIP/BG9FB--
