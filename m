Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EC0CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 18:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB7384841;
	Sat, 13 Jun 2026 20:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GNYaWthQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60E5801A9; Sat, 13 Jun 2026 20:04:19 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2298484A
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 20:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-440dcd6406aso1448625fac.1
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781373856; x=1781978656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8H2AcWVlWrUSs2i3P9elGS962esHio4XDOLwvb+3SEk=;
 b=GNYaWthQXbSwSLuJy+XksUwCNZ2XO0Br6b0KR+CfIxlVdhQKvfD4MzjI+ElhM6zLqN
 JgcxwBknHFWOZVtjSuh8x9WZE9z0UH5+HH/4+MdAXoyioMs5vAnRvGZ92aLSdW0wA0O4
 clqeKW8D+1wfxiTXqCnup5ejpnOWaFopSNARc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373856; x=1781978656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8H2AcWVlWrUSs2i3P9elGS962esHio4XDOLwvb+3SEk=;
 b=po8mx8HFjKQDM2I675QunFX8/FYvNrWQKruYH3s+4HGSxMIO3mukT8z2jvG57MuEHr
 liIi7nQs7Xir9gSjsIv7LcvHk8tUrnS6vjpaUSACFq8kMXuAnntCmZhcEdx08Bz1fOAY
 vP4rS+J1pdHfcfD6RyV8dQMRDRpieWIcSqk3IxmOQa6yq7sOAvCJV7KhLpnKUOqXvfto
 lP1t3HgCWqwvAlr17MnqXuDoXhJGqeFfLEfw2txrBWixZlI1wj7VHQvPD8ahio/fxUrE
 Wd9DA5lz6DryW81PxI0SaMZ77+UGm+z6OjlCX+//b5BDgynEF8jkG/PHDi+V7LixD4ix
 fJlg==
X-Gm-Message-State: AOJu0YzmPrRbFU5mteVF9KS3fRHJ2bFSAfOBjJazTLudKcsnzGb2xwlV
 wbiHWq/ecUh9DvhSi3x2S6dJ6yW8mte6b7wgf7j/87zLmpalUpsVFFuY+AJZXipIAPA=
X-Gm-Gg: Acq92OFNYg0dHuEA1D6DRs5BHIfjSa+A/o5kMoNFXDVb3BtEvIYx9yLdh9g+kWx4O0c
 JEoJVIubnoPygi8p/SlhLe3+5dL17zNX2SW9AegWw3FeALAwmYEopDO0o/vAx+0baeamFy1/hL8
 2pQoo82eiGDBWrSl9m0LyMfMFQgM5i22hiwW8aJu7Dp+NdUIwruP9X3S+KFxF8hDtiVcoDpzNxX
 gGzoRI4Ep+QXjE0ZXGNzjjRr5rTqs9IF61S40aYj/CnlYIoOo+4NPzvRXRUiXUeqmy35Ctg+9s/
 yIvwcpGn60mrCgNYToWYD0lp8HUQhsM48PgrxVaKyPRLBFNxAgwm6GaRikSjXlf4g/PiT3a241/
 LyuHm/x0L6j0ZY9NLB0Cd/MsIrHUmrNqy6mbAz1P1sk3umq9Pd2vZwKih2meZQDkycyAH0mnFG9
 KstQ/q941Allcte9C9xkggs9Z+uXk4t7jkLnJQUu0I8UbjGX2LJQlMqYIcAZI4O252KFxLtFFEx
 CZLjn8rdRSPCdKl0+Nr/aM+lQFmLv+UFo1jhNmrpVmBp2kf
X-Received: by 2002:a05:6820:220c:b0:69e:6c56:9ae7 with SMTP id
 006d021491bc7-69eec92dd93mr2568398eaf.31.1781373856319; 
 Sat, 13 Jun 2026 11:04:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426b30ee99sm4830429fac.15.2026.06.13.11.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 11:04:15 -0700 (PDT)
Date: Sat, 13 Jun 2026 12:04:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, sjg@chromium.org, vr@binarly.io
Subject: Re: [PATCH v4] image-fit: Limit recursion depth in fdt_check_no_at()
Message-ID: <20260613180414.GU382693@bill-the-cat>
References: <20260527112602.18818-1-anton@binarly.io>
 <20260602183130.66591-1-anton@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LeIR5wVG0pCUR76F"
Content-Disposition: inline
In-Reply-To: <20260602183130.66591-1-anton@binarly.io>
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


--LeIR5wVG0pCUR76F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 07:31:30PM +0100, Anton Ivanov wrote:

> fdt_check_no_at() recurses into every subnode without a depth
> limit. A deeply nested FIT image can exhaust the stack and crash
> U-Boot during signature verification of an untrusted FIT.
>=20
> Add a depth check using FDT_MAX_DEPTH to bound the recursion.
>=20
> Signed-off-by: Anton Ivanov <anton@binarly.io>

Applied to u-boot/next, thanks!

--=20
Tom

--LeIR5wVG0pCUR76F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCai2bnQAKCRAr4qD1Cr/k
CnSrAP4+N44YiJUejrdoh3KTao0gKPd8OK8p5x1P2RQLd1w0wwEA0ppc3jodd3qB
UP7pufsFwUyWwP1mvtLyGZ0dAsu5jgU=
=yLK+
-----END PGP SIGNATURE-----

--LeIR5wVG0pCUR76F--
