Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8DC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 18:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9021B829E2;
	Fri, 25 Apr 2025 20:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7YeLJxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E9A829F6; Fri, 25 Apr 2025 20:04:28 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE19682977
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 20:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so2835802b3a.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745604264; x=1746209064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oc1/J/KO8xTfpdWw20/iUQzfBsl7Lsf8p2+OuiFWRfs=;
 b=f7YeLJxXTZv+7GyWP6izdpe750KbqsiN0+C8PvNcUO/7AOfC1L0pflMGlQZTLHlwZO
 LXsl8bP01YO/YdxSo85KiGxeLTuM2GFJrpORbPmcLYNpiTzLoL6yTvqERMshP30GKRjl
 FTpTdvIjNEe/q0wetBg3D/blMBPGCdeo3nalTMiM6vF+Tr+8uJ+DJexUIABC+gdx6QZR
 D00UsOmPAqweBAmS1J+MxmpowMFsaCPTfFr5hCzc2c1LuaakYt9BoajU77a3a9gNDYqQ
 dP3jYJ4MvCwldFQMfTql6JQvDxdA5ypDKugR/zExncF1Vb4DL0i+Il6GN78pxeK0yREY
 5OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745604264; x=1746209064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oc1/J/KO8xTfpdWw20/iUQzfBsl7Lsf8p2+OuiFWRfs=;
 b=LmpNeGFSzvSUOCTMDK1bS6bFpjh1LQIEdZN0uAloLb64IelLnNR2YDdDpuzgxwxwYj
 qVDA+z+OFeLhjhSbCAXi4pKhKDOX5J26x2m7Hcth6QtZhPEYDEpoeo/z/rDMXiIAZt83
 r+YWJxLr2tiMbTgVa5MxZAnLYkyEG69mw7OWNYpsqEj0e8Pa2P/aRnZvBUuHc71crztP
 n9N6QnNXV6Yx2emFejQgJ+oQYtC/wHfGu8vNI+UlQk0e81Re80f5Ehy1Hj6BWWbzBPzQ
 St1Ym4zcL4tlB0jWcvFlAmT2k5JNjCNq82ssKD1LWRXdRVqW+CT80O7rkWUbM9a8lVci
 UVXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpsJprJGZYOd6N1SV5dgZ+UP81LHoLTFkv52ccg2AMFaM79McLuDvTw0hOXoFm0mhA9JGBxms=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+q205hvz53C9DXLPzTL3Fxr2H/2ZcCIX3n5UaPl4Lmib+zHO7
 msAcVD0YuC8FPLz547mLIvtZ9WzWQ3ihhaEje08TKw9+FpHtN4hqqqJs2ZKKNlZGEeYoVtar0+t
 TFDldcDHhtf+PelLNQkoCFFitRoE=
X-Gm-Gg: ASbGncvYvp+kac7RcZrz4NPaQwLIKC2p6W1fRYoQxh57FkriuGF4w2rf5A/iacFaQ5K
 V2bTaxS4YpaX+llSryHZ4Je8vlxVSpAqXbxKQOXuEDKm4G+tYhaBNo+gt/jgFiGtXkJ6RNk2J5j
 /7jvB7soRay7vakWyAGX65vA==
X-Google-Smtp-Source: AGHT+IG/Ts7iErb7l4229RtHAlLtctuQ/iTuN4xnpxpGNYEYYmCaHzWF5uNjoXqxNyOxaa+4lw/h0hWjvSniTcdX73U=
X-Received: by 2002:a05:6a00:1702:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-73fd6fde815mr3850042b3a.9.1745604264245; Fri, 25 Apr 2025
 11:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250425173901.1965597-1-festevam@gmail.com>
In-Reply-To: <20250425173901.1965597-1-festevam@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 25 Apr 2025 13:04:12 -0500
X-Gm-Features: ATxdqUEltcKpUf2_s1Fz8LEVXAfsp64nTVqILHvmvK0wsnzmfk7aXSTywcw597o
Message-ID: <CAHCN7xJocM_qgco9feSDaTT42LQw+FP4y3a=_X6H8ZLnvVFHvQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Make osc_32k available in SPL
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, trini@konsulko.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 25, 2025 at 12:39=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Since commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> SPL takes a long time to load U-Boot proper on an imx8mm-evk board.
>
> The reason for the long delay is because the osc_32k clock is not availab=
le
> in the SPL phase.
>
> Fix this problem by passing the 'bootph-all' and 'bootph-pre-ram'
> properties to make the osc_32k clock available in SPL.
>
> This also aligns with imx8mn and imx8mp-u-boot.dtsi files.

I agree that this is the right thing to do.

>
Reviewed-by:  Adam Ford <aford173@gmail.com>

> Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Sent a standalone patch that makes osc_32k available in SPL. (Marek)
>
>  arch/arm/dts/imx8mm-u-boot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index abb3aa5b6354..59453dc36d31 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -240,6 +240,11 @@
>         bootph-pre-ram;
>  };
>
> +&osc_32k {
> +       bootph-all;
> +       bootph-pre-ram;
> +};
> +
>  #ifdef CONFIG_FSL_CAAM
>  &sec_jr0 {
>         bootph-pre-ram;
> --
> 2.34.1
>
