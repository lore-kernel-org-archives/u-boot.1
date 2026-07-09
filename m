Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C1FC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A4984BC8;
	Thu,  9 Jul 2026 15:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ttPCzQEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340F484BD1; Thu,  9 Jul 2026 15:41:50 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BFE84AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 15:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-489f3611e0cso1198860b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783604506; x=1784209306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9C7g6E6esB8Z80y6uv4PtxPYXI9I6mjKvvKp0TDFmq0=;
 b=ttPCzQExJTnHpYO0bEpXYza9Y8MRjoPXQrdPRRylVJoCxe/yv8neMF95CJwVTGzgkp
 OL1Tt5Gfa8gJ3dovSQ4SfD92NDb6mhPHlqHEXqvHgAhtMikhOakYMgPCgkz854yWFUqa
 AN8r1J6fHwr/ndYr5SdRzon+W73+fk9HBIpAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604506; x=1784209306;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9C7g6E6esB8Z80y6uv4PtxPYXI9I6mjKvvKp0TDFmq0=;
 b=V4J24ZkYYOke5MvLS8mjkMdkn6070kWIo0XpWlgx0rjkAbbK66tvFgEe1DrVkWIfzV
 d2L5876biZ/yojfZoxjHEzqEV9qNSneNlb7iEES+6eXTkk+LbjEqX/4AshBYQOkLAZQf
 sLY0PszcAHMutZBO0OAwGyBffMfbLtjfYR3opT2Q4jnMHXSz6kYVHglA1xK5Y3O1SyQO
 C36HLa621JGTIbcmQdznGjuXEl+MKTDa8ZR2Uxsi5BmE8NHkISUMwQiQnBg+XNEOdTPe
 e9lIYZuLeJB3xLZj2tfbwCyd45fiM+RL98XWjLys5Ct4m7Ybfa6GhKHlJwegwnNk8zY0
 ifXw==
X-Gm-Message-State: AOJu0YzvstthB0fQGydsdHX0SIO5zpgEbxJaq66QO2S+rr2w0T29kjD+
 VIuaAmcdbqNmbjElGA4PLUCXYMn9Fn6b5NLtQEtAkduOCMTPxsd1zDyGsyeZzonSGPcKiRLojEf
 O7rEYqSU=
X-Gm-Gg: AfdE7cncwj3MiaxBAWpkXDCtvcNeJ2hHshitWSIo6HIC7nJViT+NN8ZKz3e7KW7eqp/
 kb71bAqDbAu29biZGIEKmOyWC3o9jdXGpWfYiMh8o5R+2rntmRaz2gd7TWyc+X5r3Q9ifmFf9rc
 /ArDPL3fZgb/qq8QFMW6vICJSuZrYL0IUt6HvmmXc1AlGR7QiAm4NyFE0SUPzXn74JzIyY6BPcu
 tIwKQU+eDdMLWlkcY2RwIhdKaVs0ExNm/AnzjpX+igwfz++SSB+R7SdWz7/3LfjwDpWkmEZ7oXC
 xMAii1yKf/T5gFYVBr9qCmjUMoFIit77ZuL+40iVeuCyLnle6ryBldY6HRvXqXMOY89XTVlCFSK
 rH0WL2knjBdoViiD7Mr3jpzy2YimtD6KGrMsLQ0hcL+eMOM70CTF6w4ztwHUioX/GfiWm5Ki7/O
 /4vpo2EHA38wx9EjT/22fokMgRNUx3lBOW6/nDmnnBKgV0UBofx0mHDCIU2b6sypYFqvRyF/VVq
 12zcsb7+bZGUqbudxNtDwsDZuzot3L5+D8CAA==
X-Received: by 2002:a05:6808:307d:b0:4a3:fb6c:a3d0 with SMTP id
 5614622812f47-4a3fb6cddbemr664400b6e.9.1783604506196; 
 Thu, 09 Jul 2026 06:41:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1afbf92b1sm3523696b6e.10.2026.07.09.06.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:41:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:41:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 06/11] Kconfig: Add missing depends on xPL to xPL_ symbols
Message-ID: <20260709134143.GW749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-7-jonas@kwiboo.se>
 <20260709015241.GQ749385@bill-the-cat>
 <1f7d7469-692a-428b-b85d-f1a1df5b4a14@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aLOhN2iOTuWk2UXK"
Content-Disposition: inline
In-Reply-To: <1f7d7469-692a-428b-b85d-f1a1df5b4a14@kwiboo.se>
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


--aLOhN2iOTuWk2UXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 08:41:16AM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 7/9/2026 3:52 AM, Tom Rini wrote:
> > On Wed, Jul 08, 2026 at 10:05:32PM +0000, Jonas Karlman wrote:
> >=20
> >> xPL_<name> symbols should typically depend on the associated xPL symbo=
l.
> >>
> >> Add missing depends on xPL to xPL_<name> symbols to avoid the xPL_<nam=
e>
> >> symbols being available when the associated xPL symbol is disabled.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>  common/Kconfig | 2 ++
> >>  lib/Kconfig    | 7 ++++++-
> >>  2 files changed, 8 insertions(+), 1 deletion(-)
> >=20
> > Did this go through CI? I ask because with SPL/TPL, we have the problem
> > of PowerPC being special from the rest of the world with these symbols
> > and I want to be sure everything still is building, before I do a
> > before/after size check on the series (and probably keep the binaries,
> > so I can checksum before/after and make sure they're the same).
> >=20
>=20
> The CI has been run [1] on a branch that contains these changes and the
> pending Rockchip TPL cleanup/consistency series, not standalone.
>=20
> Compared to the patches that was sent there is a small diff with && xPL
> being dropped in the final series sent to ML:
>=20
>  config xPL_SERIAL_PRESENT
>         bool "Provide a serial driver in xPL"
> -       depends on xPL_DM_SERIAL && xPL
> +       depends on xPL_DM_SERIAL
>         default y
>         help
>           In very space-constrained devices even the full UART driver is =
too
>=20
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/pipelines/=
30636

OK, thanks.

--=20
Tom

--aLOhN2iOTuWk2UXK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak+lEwAKCRAr4qD1Cr/k
CjMEAP9TilLJZi4lXV6l8eRMzbCjdanSROHQDnNBBq2gji5GqAD6AxTX5pzJWMrs
ahh1uCfSJ1wskzi2vfi1HPJDqgnDKA8=
=l/re
-----END PGP SIGNATURE-----

--aLOhN2iOTuWk2UXK--
