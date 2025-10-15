Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749A8CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 19:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6DB48357F;
	Wed, 15 Oct 2025 21:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WhctuYOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC129835C6; Wed, 15 Oct 2025 21:09:24 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0FF833F6
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 21:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-35acca93e00so4034083fac.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760555361; x=1761160161; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l98/UNpUSldHCy3s2KXiYqurF45Z5B+fQZ41A2v1aY4=;
 b=WhctuYOobeEBE2+tko+gK1pcSTsSWWvlL21wHwkTwsklx62YU6i5HfpEc5IoakQl14
 qCDdJCm+y+mKfaKDJSpx89RokeA6pTsiunuiAfaoVjAzWljERvIwNh/6R4CPsr24lzVn
 VWCA5osg+Yjsdbo8rypOQrBNiysjJlDCD7Vkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555361; x=1761160161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l98/UNpUSldHCy3s2KXiYqurF45Z5B+fQZ41A2v1aY4=;
 b=rDqT+3J5uEfanPZxYOMVvNNjlfqcxMgQuJ3GiWYyJUyY1QPoo/TOPKiPtWSfRR9dT+
 X7W6S/vCayARxYmpJVm4Agfpk6G1Dj2ct5yAtL9cV5d5czr3YJMv2qNEbaTr4Pn+Wnxe
 4fzaBfbPZJQMkUBO1aezkxKnefql0boywqvpQthF1gSxM0zgaip1csb963rHCxskJ58I
 MdBMydj68E0e/OZXkMkbX0A5O8Zfb8hXgDB4IC6YfTNs65lXY0kL8Z7VNWK2f6MwvkJb
 aBA8yT2ZAuWZnr4tdFv6oxZ13kZbeK/pcJgLGXea8b6lEqy5U6TNYRXv62m8nhU8Mos+
 rI1Q==
X-Gm-Message-State: AOJu0Yz2uDvyamc6JvhOmEBW/PXPag3bNy27bG9S/OMSJfvuf4P4XGHr
 0d6sHy8g6wFZj9qyxNakG8G3lVMFRn37ZS/fjzf4UkfaAh2o9x25mTRomzsQvQ/euqc=
X-Gm-Gg: ASbGncthS4muicugn8Nvcxk0A5LLX3OpbX9smj2D2h1TUNzNKJlfUbU1X5F5Sibp1ap
 cmpvFd2wJszBJwGlFg6h1r+6xqfV4Zar84DSrFByCVysr8nVXhZLqAHfWfk7YVB4p9f+yb7Vuh1
 J5dvvBySaKJdXfGd+HkzJStvdS3DgRtH6T/td0UjVXLvYV5L1W7hIwWsmujjZGt+XaU7SJIT6pZ
 bKOAr6R3nPxp8X4DSDIyAJjHUdb8p604XNqUfLRbm23HD923GX4vsC1SeyAqCord/6gj99wBya8
 trlLOtNCWRpctCHqwjJsEVI36+FWRRgZ3JxGOnVparVstlUS8C+YVXeyOho85HBlQ1/HUm9u/OF
 Jn2lNMj5+xROBAWhyTxDxr5VwlHhZoQZJhVKtOSgpAInwG5Q6N79EU2oMxVGhYslRyrKZHdvf6i
 IZXt4K
X-Google-Smtp-Source: AGHT+IEKpjdqVZspTulM1z0z0F44GhNLBNw2ArcPoFPJRU80XhXdAJjz8Zvl90UXdBqlslWVVypeBA==
X-Received: by 2002:a05:6870:6122:b0:35b:11fe:3d1b with SMTP id
 586e51a60fabf-3c0f6bf49e1mr13123144fac.18.1760555361358; 
 Wed, 15 Oct 2025 12:09:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm5700384fac.25.2025.10.15.12.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 12:09:20 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:09:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v4 00/11] boot: Support priority for global bootmeths
Message-ID: <20251015190918.GT6113@bill-the-cat>
References: <20251015154423.908468-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a6k1/qqlUty1HLhq"
Content-Disposition: inline
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
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


--a6k1/qqlUty1HLhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 04:44:03PM +0100, Simon Glass wrote:

> At present global bootmeths always run first, before all other
> bootmeths. Optimisations in the code take advantage of this, putting
> them at the end, so they can be used once and then forgotten.
>=20
> In some cases it is useful to run global bootmeths later in the boot.
> For example, the EFI-bootmgr bootmeth may itself scan devices and the
> network, so running it first can hold up the boot significantly for
> boards not actually relying on EFI-bootmgr to boot.
>=20
> This series introduces a new field in global bootmeths which indicates
> the priority, using the same scheme as is used with bootdev hunters.
> Thus it is possible to insert the EFI-bootmgr bootmeth just before the
> hunter for network bootdevs is invoked.
>=20
> Despite the simplicity of the concept and the relatively small series,
> this is a fairly significant enhancement. It is also quite tricky to
> implement, largely due to the way the original code was written, with
> global bootmeths being a small, size-optimised add-on to the original
> bootstd implementation.
>=20
> For now we only allow each global bootmeth to run at most once, but this
> implementation is written in a way that we could relax that if needed.
> Then the bootmeth itself could decide whether to run at any particular
> point in the bootflow iteration.
>=20
> Size growth is about 390 bytes on Thumb2 (e.g. firefly-rk3288) if
> CONFIG_BOOTMETH_GLOBAL is enabled, which it normally is. With that
> disabled (which saves about 4K on the same platform), there is no
> growth.
>=20
> Changes in v4:
> - Reword the commit message as Tom suggested
> - Drop call to bootflow_show()
> - Rebase on top of -master

Aside from my comment on the first patch, the big thing is if this
addresses the problems Andre reported or not. This is likely the right
step forward regardless, but might not be everything needed.

--=20
Tom

--a6k1/qqlUty1HLhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/xXQAKCRAr4qD1Cr/k
Cu5DAP9LnrMAVKapL+kDUoI/ajAWKw1MsTtzF1shLY7jn+B6OAD/VBfByx/6zze1
H4WXMF3za+Q1ATVE+mVO9/SxGamkTAI=
=evYn
-----END PGP SIGNATURE-----

--a6k1/qqlUty1HLhq--
