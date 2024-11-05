Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C62D1CA2A
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 05:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3185588E7B;
	Tue,  5 Nov 2024 06:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UxGE8jpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E0788F4E; Tue,  5 Nov 2024 06:38:58 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F82D88D45
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 06:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-28854674160so2002540fac.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 21:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730785135; x=1731389935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vZhmX/SrhmnhAqkdYfaCHBd1uQ8+aCcWjBeFJxJ8UXs=;
 b=UxGE8jpiEI3Qa3rqZGOv9F905UYtXPkDE6C0F11U2Pu4wRNps6CMYKMG9zoea4vEcA
 WhG1iZ9hakvO+LUmUKWFYZy/uvSDSaN72oNDZM4cTarB3KGvvY7FsGWS9JVUK2GqX2NQ
 5F5h6BPh3IddvNr+6YcDmO2/gz0cyrplnBEf5jC2jAWfiCJcXLNi0LgExd4CdRL4iYhc
 MDM4UVNOqJSQmpnUu+ZFb6lhqa+PbMkhmW+CnmawQ24OMI7RhxIIqVD3cfW2FJe7F6np
 DBpJd9vcGmo+N2ENp6l/EycocmzMbnS5z2lYbcT6BLZCa2m58HDIiEoZfXZHWCZ0BzR0
 Z1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730785135; x=1731389935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZhmX/SrhmnhAqkdYfaCHBd1uQ8+aCcWjBeFJxJ8UXs=;
 b=iYAKNV0QMCL7GUJ8PWvjJyPO7prxxPfnwt+EGDd2KVst1Fp3R9/DOO6rxaF9ygAEG0
 vFoQTD2eLhdB0qkD/fg4mnr1LTypS/qRAJzJAwoz4Au1lm6Jr58Uag9PLFf3O54LBl7g
 F1FyseHNEzaze+TXNM0vb7VXnLjNH8nd64rbkv6b5cAneLqXC6s5RWBe4hJ3931no3b+
 +D8BbjlED15tu6Zo9iUJV84Q1YF9og2opr88oyVL7rT2oED7oRbiTxB9GvShIoo1j33V
 mX3P/ZOWVLt2MJ2YjUa+3NIcV671dGne1tIAhJ7HsAqsmpsH0CSSP/Y1xDO12j1hBFtf
 nqbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUtbWHw61C4+BHL/OxL3EJpZqAU7XpKFQu41zvF85Ko2qzFl7YkfNK41m3qpf1WBqJXTSXccM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8lBD/8cfafAS6YfwVqDWBHyPn2poSohywHOLQZ/QfJtB+2erQ
 0NZxfYm3ZU0Ch1yMfSo+w+OHnOqbUNSeYWsbFVacjh2hjJgLGxKV6Kfm5JXz53ed4LjN6P+S1/M
 xy4mLTl/N+14z1Pvb3wzQN7Rd3ZEh2A==
X-Google-Smtp-Source: AGHT+IEuVWYmX9LEumcJeuZTlJGf7AFAPFXyjQoCm/gfS97lMYHWDejTGfqB//3/wARW7y2CPao3lzCCm/3zUfmFatI=
X-Received: by 2002:a05:6870:3920:b0:277:fd73:8f82 with SMTP id
 586e51a60fabf-294846ab92cmr13927362fac.45.1730785134987; Mon, 04 Nov 2024
 21:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20241030204627.31757-1-semen.protsenko@linaro.org>
In-Reply-To: <20241030204627.31757-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 5 Nov 2024 14:38:43 +0900
Message-ID: <CALrBrZ3ODz1tOrEuJwEsu+GofKCbnGYBVXz17R=NQhhs5Q8giA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: e850-96: Remove TRNG node from appended dts
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,


2024=EB=85=84 10=EC=9B=94 31=EC=9D=BC (=EB=AA=A9) 05:46, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Commit 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into
> dts/upstream") updates the upstream dts for E850-96 board, bringing
> upstream TRNG node. There is no need to keep TRNG node in appended dts
> anymore, so remove it.
>
> Tested on E850-96 board by running 'rng' command in U-Boot shell.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  arch/arm/dts/exynos850-e850-96-u-boot.dtsi | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> index 3aa5d8bb10d0..6d7148f7264a 100644
> --- a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> +++ b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
> @@ -3,17 +3,6 @@
>   * Copyright (c) 2023 Linaro Ltd.
>   */
>
> -&soc {
> -       /* TODO: Remove this node once it appears in upstream dts */
> -       trng: rng@12081400 {
> -               compatible =3D "samsung,exynos850-trng";
> -               reg =3D <0x12081400 0x100>;
> -               clocks =3D <&cmu_core CLK_GOUT_SSS_ACLK>,
> -                        <&cmu_core CLK_GOUT_SSS_PCLK>;
> -               clock-names =3D "secss", "pclk";
> -       };
> -};
> -
>  &pmu_system_controller {
>         bootph-all;
>         samsung,uart-debug-1;
> --
> 2.39.5
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
