Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95969FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 16:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE85184663;
	Mon,  4 May 2026 18:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HYNuxQJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBF484374; Mon,  4 May 2026 18:06:51 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE92280F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 18:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4233e152457so3289943fac.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777910808; x=1778515608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fFMbWu5jUCT6FuLd53u3ELU3xRU22oRsnGR17ht1hYE=;
 b=HYNuxQJQVK6vq60NNuQ/qa/1Dm5DkVTZVs/CBC2PZdhcj2YNfCfeB6kmKsXnT4thym
 aDZ0wO0I4hhzaNU8KM5EMb891TALD7pUgzd0r0eo+zkwmDuAMUsqXRPqOPWCfs90ekRE
 q3i53HDP97G2cmNyauuaW3h7TyV0/rAhy6zjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777910808; x=1778515608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFMbWu5jUCT6FuLd53u3ELU3xRU22oRsnGR17ht1hYE=;
 b=SyEf+tRr4exAZGbxxJevexWserSe5HEd5q1Zk3JC3Oowow/WFmynYmF7cccnmTMSci
 1HCmGbgMBpjJaWnKJoCwXtX0Xp6hBhYgPZRvqgHNLzCkMpxZcyZRXaDQI0OSU8Z4zt6Z
 SILvEEAbmKMVh5lbTMe5bpotsvzwp0Qr87D5zx3mebfBJnbpE6/V31skdGKPq0KqMr7I
 zh0dJgDJMkhoZ9IbfiDDxTN5PpbGfqrGFptmd4fQndYqEg6nZGZ1H4QJlOcEMdFvpdBL
 BSd2LSd8+kOqmvzYn7lkhubvdxRpyAnS0lnu+AYXR1NXJ91b+gSFkOMXdwwWyK07exDe
 B6hw==
X-Gm-Message-State: AOJu0YxBOu4tkJeeyKYvZ0f0pb8OBYXqtGeugGhu3aukWhZnzW3ybeAG
 91Rk7IF8wNeOkwcxOJzIeWdIS49F7s2HpNcj+yy7eW97VFTJdN8XE8O0o5mqtm+yvAIHRdIpVWL
 3MA7qG321rtPS
X-Gm-Gg: AeBDiet/zFFpEokVmIy3/T3grSTWtD1IxwG22V7rOTQ4G9ADRtpODQLWTw8ItlRzBSw
 Xqu3pRVQIzAmQHYFKFz0PqL72bczJycBvks5x2v5s9AhymUGYezGMxPqjs3qnC+qCr6CcELjiYU
 Q7F9cDDwZ7Pf2DfeYdhEN0RLEZHxijCg6D2Wf7qLrTyRKfkjQrAKQWcrbK1PE0tkm3jWn9NVxUA
 NRm9wNtUwi8LbKdUEWstcLr693I28NXPqJpkHL6i4U9I+lsjyy69/fb9r8ogJ2w2y9oxEGpbf3K
 5i+py7MDuAsTWq3nx++h2TVjIuGBddcuStSADSf8FLjJC0jFGVAPvsp+CF8Mi3U1mCLdYUt0/xt
 +9BS6INM1TOG1TLvHmjHiWQAg9eW3ZdAN6MupdZyjROn2hWdUeekrP1+UytZ11RZnVtjBsLyTyK
 hCILpQH62o+VCJmh+Mi1TySLed1eACe+Ydi/RnG0AZBanXkmtV1hgczE0iLG2oAvPEwDRJ9kQUG
 igHOs2wPh9FpmKZbuIe4hjSKo5YBn+pzk/9YRd5NqlOpG7bduLbl9qZRaasWQ==
X-Received: by 2002:a05:6808:1983:b0:460:f435:2a70 with SMTP id
 5614622812f47-47c8933833bmr6077725b6e.47.1777910808344; 
 Mon, 04 May 2026 09:06:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454dd93fcsm11459462fac.18.2026.05.04.09.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 09:06:47 -0700 (PDT)
Date: Mon, 4 May 2026 10:06:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
Message-ID: <20260504160645.GF1614990@bill-the-cat>
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fhkq2INjq6f1xFqR"
Content-Disposition: inline
In-Reply-To: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
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


--Fhkq2INjq6f1xFqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 06:16:58AM -0600, Simon Glass wrote:
> Hi,
>=20
> As you know, I maintain several tools which are part of the U-Boot tree.
>=20
> Tom has previously suggested that it would be better to move patman
> out of the U-Boot tree, e.g. to its own Github project. It is a
> general tool which can be used with Linux and other
> mailing-list/patchwork-based projects. I have never been keen on
> taking on the extra effort required, but I've recently added more
> features and am wondering whether now might be a good time to do this.
>=20
> Buildman is quite obviously designed specifically for U-Boot. I have
> made some improvements recently (a large code refactor and distributed
> builds). I would like to push those changes to mainline. Do people
> think it should be in a separate tree somewhere?
>=20
> Binman was written with U-Boot in mind but supports other projects
> (such as Zephyr). It is generic enough that it could be separated. The
> impact would be harder code review.
>=20
> We also have smaller things like qconfig (which I have substantially
> rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
>=20
> What do people think? Of all of these, patman would be the easiest to
> move, with the least impact on existing workflows.

Given that as a project we've been encouraging people to switch to using
"b4" as it's now widely used and covers many of the problems patman was
designed to solve, I think that's an easy one to say that you should
move to your own personal hosting somewhere and it be untied from the
project. The rest of the tools are something we as a community can
figure out how to address once some of our general infrastructure issues
are unblocked and moving forward.

--=20
Tom

--Fhkq2INjq6f1xFqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafjEEQAKCRAr4qD1Cr/k
CoIWAP9c7PBJ5zHlEHLPa/UeB5Wpo/kozHfnELSjLRrbItLuRgD9Feb+9tQhRjk4
pJCs7GHHgmqDy9vM9AfRwUsbNap04wA=
=sNK4
-----END PGP SIGNATURE-----

--Fhkq2INjq6f1xFqR--
