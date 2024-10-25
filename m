Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FAD10399
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67C788F68;
	Fri, 25 Oct 2024 17:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XSqVuRJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B4388FBA; Fri, 25 Oct 2024 17:26:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BF688BEF
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 220745C06B1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 15:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DF9C4CEE3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729869968;
 bh=6ia13AsyjmX8Lwrwd6wTi0X6BN+p3YatrNjQUOaQp8w=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=XSqVuRJ3i1TlNm7Ij1PXyq1CjG9tAh1a+Y9+TQNnwpMltIjHl7NnTnaC8t3CM0IWt
 aBUKfToSuanvADqA+9NcAqkxJGhnSPuUkToRkeoSh9TXswcl4kD7uLhB7yB1LLjfUU
 8eQ2XEZ+Q54Zhmrl6KQgLEJaRMpKglMJgTtA54W4G4MAgqM/AiMaKc046tsniRzFmy
 NhvTciXvxZl84qrso7h8FRhAG5FK5oFvuvwyilCSTCq2Zf4qWiOZVDYxJqEUcQjrl0
 55o46Et7gwTEI/yG7UBflVwQ+xSSIBkoTbSMSG+IUoVBi6/sIoXIyOHkLSYd3esHAf
 kx9icxHCw1irw==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2fb5743074bso17295601fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 08:26:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWB4P0Svl6+1+pHeFKY0oQaHYaXqx9DU1oTt2Lu5sLpw74XwaJzk1phlzX8EOn8RFghP4+9AqY=@lists.denx.de
X-Gm-Message-State: AOJu0YyynqSqjeU5vrfZPPb7E6wDV1mMcHNUF/FBu+lV+WtPrfluCTJs
 8ZZXSuUB9GSjquhOxX53heHcuws9sXgOjtseWWghFtZt8aCflDlz1NWxXUoXRdRWUJ/oC+UrY3Y
 YRqhg3HrSSEpTgmOQCaho6swTUhg=
X-Google-Smtp-Source: AGHT+IEo867Ec7Lnd6oshSArzmdEOrjJayECiM82fgnDFcpIVX6vVBB/OWT/04hspcNO1LQEAhBr5g20bUF87HTE9qA=
X-Received: by 2002:a05:651c:1549:b0:2fb:579a:fff with SMTP id
 38308e7fff4ca-2fca8358419mr22365441fa.8.1729869966346; Fri, 25 Oct 2024
 08:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241006222148.16456-1-andre.przywara@arm.com>
In-Reply-To: <20241006222148.16456-1-andre.przywara@arm.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 25 Oct 2024 23:25:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67VOR_v50P2ds2-JYXGwfV0onQRGoa_st5nU0De51-zaw@mail.gmail.com>
Message-ID: <CAGb2v67VOR_v50P2ds2-JYXGwfV0onQRGoa_st5nU0De51-zaw@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi: a80: Fix reset description
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Oct 7, 2024 at 6:22=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> Clock gates and reset lines share a common structure in the sunxi clock
> driver descriptions, but use different flags to tell them apart.
>
> The description of the Allwinner A80 MMC clock reset lines was
> erroneously using the "GATE" macro, which made the reset driver ignore
> that entry, complaining with:
> sunxi_set_reset: (RST-reset:#0) unhandled
>
> Change that to the correct "RESET" macro, to make the reset driver
> happy.
>
> Fixes e0c7ce7e52b7 ("sunxi: clk: A80: add MMC clock support")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/clk/sunxi/clk_a80.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/sunxi/clk_a80.c b/drivers/clk/sunxi/clk_a80.c
> index e26d42a5e71..4e37fa39986 100644
> --- a/drivers/clk/sunxi/clk_a80.c
> +++ b/drivers/clk/sunxi/clk_a80.c
> @@ -77,10 +77,10 @@ static const struct ccu_clk_gate a80_mmc_gates[] =3D =
{
>  };
>
>  static const struct ccu_reset a80_mmc_resets[] =3D {
> -       [0]                     =3D GATE(0x0, BIT(18)),
> -       [1]                     =3D GATE(0x4, BIT(18)),
> -       [2]                     =3D GATE(0x8, BIT(18)),
> -       [3]                     =3D GATE(0xc, BIT(18)),
> +       [0]                     =3D RESET(0x0, BIT(18)),
> +       [1]                     =3D RESET(0x4, BIT(18)),
> +       [2]                     =3D RESET(0x8, BIT(18)),
> +       [3]                     =3D RESET(0xc, BIT(18)),
>  };
>
>  static const struct ccu_clk_gate a80_usb_gates[] =3D {
> --
> 2.46.2
>
