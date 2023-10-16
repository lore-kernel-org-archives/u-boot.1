Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2010BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98114868C1;
	Mon, 16 Oct 2023 23:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pYYnyGHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9DF868C1; Mon, 16 Oct 2023 23:31:39 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331818669F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a822f96aedso42816437b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491891; x=1698096691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N/gAf/EABho+QTfFripeOBlDO7xxuYzMfx/GcCZgmJE=;
 b=pYYnyGHJf++O1AAwmvgOHVa7U8LcYcPaF7L5pA4l8XqXiqPmc4jI02TAw2t2Hg/X+G
 AOIri1dTUBsJrtI+vinOJh7F2YRru+D0JNOGiDdJ3OTgWFDVths5O03hMIuB4lfq8TpE
 shxgBDxN8ejRHu/8cHWRV+Ud8Z1YbYAkIa+kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491891; x=1698096691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/gAf/EABho+QTfFripeOBlDO7xxuYzMfx/GcCZgmJE=;
 b=nB/QToK+WFEbqWPute+9ZXWUv4enVSNiJscfqgCGN8M7y8sFbsvpaQfMUhiXwnClNr
 vcdbCwYXorL7UB4A94qGTRp8jvkc2/Z9fkQuRpuojz+Coek2K1EA0ukQZP06nxVo1PdI
 lxPL/LZon/YmzmjsHzXIZ0Vvj+dni5kWXz554VNzh0hK6eQF1Dp3nMcSPxHOO5r9BX8Q
 kn8Pu+pJBtCpa6O3F0wlfqfkCQ64LyiiaQRAXzBkq+PzYDfBbss0JB9oYKX/4EFKo+bb
 jW/vEtD4KeAdEP9uHoeZjXL02AB+jXjlbVBqzvaz1OHFjYwhVHy9BwClXS7TabhsdfWh
 w+Kg==
X-Gm-Message-State: AOJu0Yw0lFy3Jj6Yw0RYxPsHKXbK3FBqW94DBUUjtte9OkPKQ2hnUC9V
 hMmUm3ajDd8u5Q6RywqpXSxa+A==
X-Google-Smtp-Source: AGHT+IHBWBz9G66m+zFcBe9wXEqYolCoHi34ES48TOsxVax3oxsyhb50xLxHCpOfL1G79OYqDht54g==
X-Received: by 2002:a0d:df49:0:b0:58c:b8b4:2785 with SMTP id
 i70-20020a0ddf49000000b0058cb8b42785mr389942ywe.45.1697491890896; 
 Mon, 16 Oct 2023 14:31:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 o187-20020a8173c4000000b0057085b18cddsm33263ywc.54.2023.10.16.14.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:31:30 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231015
Message-ID: <20231016213128.GG3119521@bill-the-cat>
References: <555f51df-c50f-4118-bf74-3619965cd828@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cobQBDgyRxa45vyR"
Content-Disposition: inline
In-Reply-To: <555f51df-c50f-4118-bf74-3619965cd828@linaro.org>
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


--cobQBDgyRxa45vyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 08:48:06AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A set of changes mostly concerning Amlogic A1 & S4 SoCs for USB, Secure M=
onitor
> and RNG bringup.
>=20
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18138
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 997bef3c6d22d12c7fd092fb831bf94d114c9f=
6f:
>=20
>   Merge branch '2023-10-11-port-gen_compile_commands_py' (2023-10-11 13:2=
5:01 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231015
>=20
> for you to fetch changes up to 7cd53e0d5203f8e25bb69d2e675769888fcbc754:
>=20
>   arch: meson: use secure monitor driver (2023-10-15 12:23:48 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--cobQBDgyRxa45vyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq60ACgkQFHw5/5Y0
tyw9KQv/b/u9f+J3xK5NxblPBD5ZM8y4r8TWs5FMVgVMMTwkE3YiuKcH/IWsm9DZ
WUUlMUxxPp2HpcMYzLZu6JA0Ga/rixasNBGrV3wv16Kx9ixriP5IZu1+RApzjCns
2Yn5BUfmbnIgBCMadpNsEYGQQqT4ANgq04GlOvXcY3iTg6FiMvVZRsg+5u9Blzfx
lVHVjzEtcA+FlJWmC/AcvcR+fG6KEgjJw85yG9qCySxFeL/rssODPf4X8oHdaZ7l
eejLA7OFiMvvRp8x8ebvXuS/EpnU16baqZhJ7sQFqLVS9QaFg3DzH5rTxeUpAPjI
vq+7ZN6ul7fHsE60M9SKThDRxIJ05eKIdrIp1HfV0ZPTrbl3lRDymT8BqXLyCqAu
Yt/cfYzcn/C5UU6L/MaTI1GyHL20JfnD7cDPrUkVpP96kbL1z4x7zxMG3GNc2nkQ
CwL6veRyer9W8+/7F3HGneFarYLcQUvE0osa+SuI+hT2uNe5okjPwl2gl2lsDW48
PTQYoL6s
=V8y4
-----END PGP SIGNATURE-----

--cobQBDgyRxa45vyR--
