Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17C910F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C92283F98;
	Wed,  8 Apr 2026 18:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K5MYxdCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D378404A; Wed,  8 Apr 2026 18:25:49 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5AA83D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40427db1300so45387fac.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775665546; x=1776270346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VOoXZIXOQcSvo/+J31NlUJwR6BC2YOowxK64dTpZUfk=;
 b=K5MYxdCjl2aOPFi32yeP9LTUABjRfnxedSCuBEWB/POoapsBBSrumPceAS2QWFD8Vx
 VWwGPmgbcHZhH8tscLVEVzn07zs4i4immW3MjJRC9lgcqp68RXdYZRLo+7BymzJlZ/xO
 oZSC85HlQAGmltl8/Mg7wMYcFrjzhXnEaRILU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665546; x=1776270346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOoXZIXOQcSvo/+J31NlUJwR6BC2YOowxK64dTpZUfk=;
 b=qZCJtgtfbTIvB6n5eUekFNlI0IlLluJO/r0QVK89c/6W4Q+andkZB0huxsppq9sYl+
 q7pGoficp0Dk020kyn90Ftsbqz/yjAsjqNKj/vLGubdrX7DcHiGHQZkOrEgmKYvx0ev3
 IzcuKVNquhwbKwpNEG/wsVJp12uwovkdLdx9f2zRHYR93bhDQPANEiJFzVNnyxS+UeKo
 WcoJh5EdyWAl8ZWP21ltyhQzZhXoDxxg9AttHOkAxw8+t78qD1CNkkjKsNjnfEBHh44t
 XWt6ZTWlaSNaSf4sIdWNuCiIS9yOP1cmDY4w9KOtpCmOSktZblWbSC+6oCISpoM5oTx3
 LaJg==
X-Gm-Message-State: AOJu0YzSKE6hrAU0Cg9SFAHv82l+MTJLgzlWaIOl+dvoEHlUhMN69uGQ
 y90iwtriw+HAPIXqTrqpOA+sg3E8z3UCZevxtzrOLNmWaiiQJNWDwD1Wb3khaFbdLas=
X-Gm-Gg: AeBDietaWHvxPhvSc+3OOuA6hBQorSKdmLguicWPQ8yMD2D/Sos38C1K4aYf9WdiO4E
 tGM2MW6nHsqwDGt9PwdLPSAtLHvKZ+wmuqdfL8lKQLPapbMEII4pjJcZMXC3AGHLo6Eg5V1I110
 aOFEpFgsweZTAE5TaMSDU7FPrp833TIsajQspqvmv2p+pjzTpxkimRqlemaKLpbLTKo+yvGHv4i
 IrKQtzQXDwP9+XrPAwzE3DdA5tYkCm9LrvLmOP6fEJySlgPF6OCJcjK5K8CBoEh5eml+WecdQgY
 lcA8sgCJlv+SvV0nFr2fN9RsUwIDP9ceB/1IDAi/5GpCXzCqa9EW1glwM55G72sc6LJDMe/PYpa
 xGB4y6qtQL05zUv4n5OTvDE+Xhf6wiGdfjQTaJcf4iYndY+WCbwffcIgkrgLPnpaLG9afl+eovS
 0jL03+BPx4RzV6pcLUNbY40O82I9wD6RGLzOXzZ73UuC+J/YJmtxSAMEq3OXGZxcUSyZ5Uo4nFJ
 MvMn3Msh8h1pmMQ0RKxgho5VGGcBOIrNOcODw3Ua0s4j9LU
X-Received: by 2002:a05:6870:ef17:b0:417:5ca8:8155 with SMTP id
 586e51a60fabf-42310131c73mr13082507fac.24.1775665545769; 
 Wed, 08 Apr 2026 09:25:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4230fb42ec7sm13913625fac.0.2026.04.08.09.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:25:45 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:25:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 01/13] boot: Split out the first part of fit_image_load()
Message-ID: <20260408162543.GD41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oAeP8b53fQc/C9L3"
Content-Disposition: inline
In-Reply-To: <20260325165431.1027591-2-sjg@chromium.org>
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


--oAeP8b53fQc/C9L3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:54:10AM -0600, Simon Glass wrote:

> This function is over 250 lines long. Split out the image-selection
> part into a new select_image() function which handles format checking,
> configuration selection and image-node lookup.
>=20
> Take care to only call fit_get_name() when a valid node is found, since
> libfdt does not handle negative offsets gracefully.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Function length isn't a problem in and of itself, especially when we
aren't pulling out some 4 or 5 level deep nested logic to improve
readability.

--=20
Tom

--oAeP8b53fQc/C9L3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaBgwAKCRAr4qD1Cr/k
CiEEAPwPJK0hgcM82EbX9D1wBvHBGVJOOMXTnEFMy9ILpn0qbAD5AeXclnqfclV0
dHIaDcmZDYR40KTYZ6tC+HAv4fydTQA=
=pKnS
-----END PGP SIGNATURE-----

--oAeP8b53fQc/C9L3--
