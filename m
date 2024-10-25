Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C47D0C61B
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E417288B9E;
	Fri, 25 Oct 2024 16:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="chxeqrCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4AF88F92; Fri, 25 Oct 2024 16:54:25 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE93987F7D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb587d0436so22604991fa.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729868050; x=1730472850; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mr0QzMGLZ8z5F3wcnUR9EClVE4MYxyHBStwMmRBfKM=;
 b=chxeqrCccK/yNf5JZIkQjdcXOX0MBkR10mwTGkK19FYa1VuSgA0ia/JWzMcDhk0Bnl
 QPNC56G8KJ22SFFSVp7ZadpxFz7d59HxAA3NHq1g/6SDvuugK5E39D5RoZx0SQwXFKD1
 aZJ5k3w2yBZE++pm2fqRXuvO8z/uwR4ZWtD/4yN7WsK+TRUYUQJRh7klUYyG6GFtCxV8
 eOyCXuJKvfh0ukLlLl0oikOttY3rrTXbaAmvUa5YeDqEJFvFc20QpztTJQhz0OHkZXBp
 VTNhTbKAcpZlnwzOaCiZzDaWBHD3UxUMxYtVKMyKiJr7nK65jTsz/XkcDFdVPIEPl3vH
 +szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729868050; x=1730472850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mr0QzMGLZ8z5F3wcnUR9EClVE4MYxyHBStwMmRBfKM=;
 b=CDYh4tI9geIbN0AKREZCqIF9HAMJgcRoeFAtvxXL8Ml648RwsXXXHr9C/y86QgcrJK
 MFx5kUJ0wydvI6UdIs179c2kiO6DkIUsJTNSoPb+FdIaxYFe09Cmj5sZEErtsUL5+DBH
 DN4NU2ldNuwTgYZHmgjl0TqZi/delDaEdM8eBP0DZ4BanGWJLLfg0t94b/6T4QWHC601
 ldE2ZaGOBI6PCd569fj29e0+HudL+Eufa62R7/nFS2xy9NCr6SjGkbs9ei7sP1wJygve
 u0IfbBVLqcHx9GV4HLaVwMnPOZy4BlD5rka3QOc0702TAy4yHr6wCYXzlResmxLgAvKS
 u5xA==
X-Gm-Message-State: AOJu0Yx5k5NVVYnnH9Wt6nUbmfJh1xafdn7F2FL6uALsUuLNDQLDq9wr
 qItoHAT9dtgb7wpbJAdZgpn+tsKNnoM/lL28qj3QQJrD/hZ+4tbigLVZlO+4Mz9GAyrj6rNKMCH
 6t0x7iU9pwGj8TocoSxMf57zrkkc=
X-Google-Smtp-Source: AGHT+IHeLmSQhoP9Jyj6PlBKvr/53PlIgd3THa7IHikas7H3bdPRnqEk/YLzLw+NiBlOfg1vOE/cc8z0a96T9ITFFzM=
X-Received: by 2002:a2e:8095:0:b0:2f7:a759:72a7 with SMTP id
 38308e7fff4ca-2fc9d35af8dmr46417401fa.22.1729868049925; Fri, 25 Oct 2024
 07:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
 <20241025020228.1686306-2-Mr.Bossman075@gmail.com>
In-Reply-To: <20241025020228.1686306-2-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 11:53:58 -0300
Message-ID: <CAOMZO5Ct3jxfKamJxoVdchOhh=XiKinVWk0kY3MVL641VAjJbw@mail.gmail.com>
Subject: Re: [PATCH 2/4] imx: imxrt1050-evk: Fix missing clocks for mmc
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>
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

Hi Jesse,

On Thu, Oct 24, 2024 at 11:02=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
>
> Two of the clocks required by the usdhc1 controller are missing from the
> clock controller node. A recent change enables all the clocks in the
> esdhc node, which fails as they are not defined in the clock controller.
>
> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk=
 API")
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imxrt1050.dtsi     | 2 +-
>  drivers/clk/imx/clk-imxrt1050.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/imxrt1050.dtsi b/arch/arm/dts/imxrt1050.dtsi
> index 03e6a858a7b..a25eae9bd38 100644
> --- a/arch/arm/dts/imxrt1050.dtsi
> +++ b/arch/arm/dts/imxrt1050.dtsi
> @@ -87,7 +87,7 @@
>                         reg =3D <0x402c0000 0x4000>;
>                         interrupts =3D <110>;
>                         clocks =3D <&clks IMXRT1050_CLK_IPG_PDOF>,
> -                               <&clks IMXRT1050_CLK_OSC>,
> +                               <&clks IMXRT1050_CLK_AHB_PODF>,

I applied the whole series, but please consider fixing the kernel
devicetree and converting it to OF_UPSTREAM.

Thanks


>                                 <&clks IMXRT1050_CLK_USDHC1>;
>                         clock-names =3D "ipg", "ahb", "per";
>                         bus-width =3D <4>;
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1=
050.c
> index 788e0650a92..2c029ec5a6e 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -144,6 +144,9 @@ static int imxrt1050_clk_probe(struct udevice *dev)
>         clk_dm(IMXRT1050_CLK_AHB_PODF,
>                imx_clk_divider("ahb_podf", "periph_sel",
>                                base + 0x14, 10, 3));
> +       clk_dm(IMXRT1050_CLK_IPG_PDOF,
> +              imx_clk_divider("ipg_podf", "ahb_podf",
> +                              base + 0x14, 8, 2));
>         clk_dm(IMXRT1050_CLK_USDHC1_PODF,
>                imx_clk_divider("usdhc1_podf", "usdhc1_sel",
>                                base + 0x24, 11, 3));
> --
> 2.45.2
>
