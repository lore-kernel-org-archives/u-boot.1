Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E3C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E67882EF;
	Mon, 27 May 2024 14:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="g3FDGLlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDF5881E7; Mon, 27 May 2024 09:51:36 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1DA88221
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 09:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anand@edgeble.ai
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e96f298fbdso18607951fa.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1716796293; x=1717401093;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l6GbLcV5yGEx3oTjoFTZBI4RSumz8I7dsHqwwgPBoag=;
 b=g3FDGLlI1F1Buax5kUKdqyhsFfnyi6G9/aE1JQRw7Gkhb1Kefk3h2Tj1dLkzwo72u3
 KHxw4sfIMopHttrgrkj/bda7kODSy2miMpgdQORxL7iz+16bWazl/kPia9A+i8Lq/F5V
 kwchlWYkQyHcGkBrrBz2oVLARx4gjwM8toKSoBXOlYERbWLX5oj3ScjJBw7zeG9hh45Q
 /U/AowuX/DzNMBECb7XYZtwP6rMQJkCe9+dBVVHskuq6NGmy21wHzZ0YOnvi8DFbmjPW
 pkufx/ea46Tdh+q0RRaJio1pw7r5YP/6nWJc2m+4UgBNK8tz8be7YRZh556I37OTK05k
 VoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716796293; x=1717401093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l6GbLcV5yGEx3oTjoFTZBI4RSumz8I7dsHqwwgPBoag=;
 b=SC/23TIy6pmPwl+sJYjLFx3dA/53N3OgSIuWRGxcP1hKU0hmlZrqQmJ3e8/NTzOcLI
 0FNf5tzx3tx7AMYn3v8Jbo1D1FUBhLSF7Za/Aq6f0oOpLkMyqCNMh/SRbp7Nl7fXsieF
 qoPD6DVroEVKOfjS+yCSTwnUUuuxGHjaJ6QUtJ74DXi+I8oNoeet8jzeH2BChF1v22AF
 KInR5P34DYOcpUextl/W94XvbZk+byRWecIwqd+P0bMZ+VOjt9k/cdoVre2Fu+92PaNl
 Zf1+luqdke/g9ttzRdfg/3ZOk2azVTvq5htYWpZRQKkCgOJJ6nNxcrXrSkuDVJv9ZkJk
 mkPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhgoDAJoapTqqZTB5b89SMbPtCLhfKQGzruOcTh7cXb8yOVv4LTFucBQEGJGir28N9rwaj8azIhFNvSPSKT0hBsScTHw==
X-Gm-Message-State: AOJu0YzGIKU6KWeRP5iB2/7nyv2lzDRboUQAbDUm2tJoGwoexXnp/baM
 05dLIDaOGOaomKaOIHCfQX6AKQS7PZrH81I/Ho6mhsB9eikISWkrBWBMg5AOQl8gHv26vfGwlBD
 8DoNt/cd/ptrp7UkYN2zdgWcAIz1lXCA5ScEEtg==
X-Google-Smtp-Source: AGHT+IHCM/ZCxXC6vQdKszgWb8pRt0blSfE6ftqnmB/8ZR+R7teqYA0bsDrQ6rmpMmO06w9RP7lDJVVtm7etbj+d6ZQ=
X-Received: by 2002:a19:6912:0:b0:51d:998e:e0c1 with SMTP id
 2adb3069b0e04-5296410ad52mr5897188e87.13.1716796293540; Mon, 27 May 2024
 00:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240527063915.6205-1-jagan@edgeble.ai>
In-Reply-To: <20240527063915.6205-1-jagan@edgeble.ai>
From: Anand Moon <anand@edgeble.ai>
Date: Mon, 27 May 2024 13:21:24 +0530
Message-ID: <CACF1qnfPgq-QV22HwdQ42c+g8aMiGqtj=Y4bjqa8c2HgpUb60g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix spl-boot-order for
 edgeble-ncm6b
To: Jagan Teki <jagan@edgeble.ai>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 27 May 2024 14:47:49 +0200
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

Hi Jagan,

On Mon, 27 May 2024 at 12:09, Jagan Teki <jagan@edgeble.ai> wrote:
>
> Edgeble NCM6B SoM has built-in eMMC so make sdhci has first boot
> priority.
>
> Fix it for NCM6A, NCM6B SoM.
>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Reviewed-by: Anand Moon <anand@edgeble.ai>



> ---
>  arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi |  6 +-----
>  arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi | 11 ++++++-----
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> index dd0058262b..88f3f7eee2 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> @@ -6,12 +6,8 @@
>  #include "rk3588-u-boot.dtsi"
>
>  / {
> -       aliases {
> -               mmc0 = &sdmmc;
> -       };
> -
>         chosen {
> -               u-boot,spl-boot-order = &sdmmc;
> +               u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>         };
>  };
>
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> index a45b3f5e86..289578803e 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> @@ -6,11 +6,12 @@
>  #include "rk3588j-u-boot.dtsi"
>
>  / {
> -       aliases {
> -               mmc0 = &sdmmc;
> -       };
> -
>         chosen {
> -               u-boot,spl-boot-order = &sdmmc;
> +               u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>         };
>  };
> +
> +&sdmmc {
> +       bus-width = <4>;
> +       status = "okay";
> +};
> --
> 2.34.1
>
