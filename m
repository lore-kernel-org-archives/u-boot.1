Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD70C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7607C8770F;
	Mon,  5 Feb 2024 10:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMcqCE+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 358C287480; Mon,  5 Feb 2024 10:18:37 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D826287760
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so5389423a12.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707124714; x=1707729514; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/eX61//zweX5u5IBWa88niJ47mK6J56rUfRd5NVwhc=;
 b=TMcqCE+8qzFBv5FHZmbAeZtnUzkqq9qryc7st8K+JcPMuYYIXniB2RlWY3vFVp2Dbh
 pg0Q6PamXp2s8fQxR5cPsMhhB9DiJypdxoJnE3dyx8paIKiSc4YNrkGL/aWeEDpH7QXq
 3RPB55oV10fsDYUcySDyYDpSLY06ps1hRpGZXAbxzdli9fMt/GWUVUWo060o/UDwmXn/
 O/46B40xFCOXptU/rrXewxbJSOi+rOa8UYYobg20oH8jvyoxw5+8dap9rqO0qiocydV/
 j3l0gZgnUCOwBH6Pev94A1xYIwj06VuNwGgpWezUhFx37sWjTXqTBvmMIYovCmhXZzx8
 erUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707124714; x=1707729514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/eX61//zweX5u5IBWa88niJ47mK6J56rUfRd5NVwhc=;
 b=tT+mDy8cYOa5PJP073ILxg7mFmQnE5FVhf1UdKWbq78GQHo6U/TsUUXepBI+d+O9M2
 xMGyZe8tGipB7CFtgRAnRl5dRM+PgYmEVwciNxmfYVyTN+0HwQe+fpb48HleledIxqtT
 bz/jTCPlfVLXqQ3PzlCjZ+yzUMGCd7xLwDeZd5Usksdq8+M1FlmrwBMXjYHEIGPOji/R
 zRDMdaUUXCWtygJvvpmAU+5hhk+8Sdk5bGM351xGVdxEJOVK6eVJCmnxc6bl8pTGcTCn
 VzyG9F9oGJeBNsw029/Igld12mdVN3RMfBAO3ySC/7BD7di/Z8qosBHuS/Z1vKMLLG30
 trjw==
X-Gm-Message-State: AOJu0Ywvy/isw0xRlwyd6Scx3xzWWmtBkMyIakTV8Ky3uPNfB9ShhJTH
 NBwZAjJGjN2n5rHz8r2mhcxgCSGsLsN2Efi0Twh+Fa3IwlRHo6wgok2M+rFuH+A8wIN8lseIb6N
 pwn7ZwlOvzmEHNYodUdCAIGKuu9Pwki1ptB9P20DU
X-Google-Smtp-Source: AGHT+IHID/ZRwlHE8a2T0R2DBKEpree6f24nc98RFcvE72shKVw3B9hBE5zSXUrY7PsMO520nlNpzUk0NkM2X2pwdNY=
X-Received: by 2002:a05:6402:1219:b0:55e:f8bd:6246 with SMTP id
 c25-20020a056402121900b0055ef8bd6246mr3805303edw.18.1707124713010; Mon, 05
 Feb 2024 01:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
In-Reply-To: <20240204205312.2342868-2-jonas@kwiboo.se>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 5 Feb 2024 17:18:21 +0800
Message-ID: <CAHk0HotEwamc+=ZgDdm6XhAYDBn8uvbs2GG2GfcWemtXq4hiLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>, 
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
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

On Mon, Feb 5, 2024 at 4:53=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Testing has shown that writing to eMMC using DDR52 mode does not seem to
> work on RK356x and RK3588 boards.
>
> A simple test of writing a single block to e.g. sector 0x4000 fails:
>
>   # Rescan using DDR52 mode
>   =3D> mmc rescan 4
>
>   # Write a single block to sector 0x4000 fails with ERROR
>   =3D> mmc write 20000000 4000 1
>
> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>
> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in affected
> board u-boot.dtsi files.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

BR,
Weizhao

> ---
> Changes in v2:
> - Update commit message
>
> Link to v1: https://patchwork.ozlabs.org/patch/1891695/
> ---
>  arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>  arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>  arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>  arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>  arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>  arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>  12 files changed, 12 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk=
3566-quartz64-a-u-boot.dtsi
> index 11976fd3a6e0..930d660868bb 100644
> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> @@ -8,7 +8,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };
> diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk=
3566-quartz64-b-u-boot.dtsi
> index 8de9d1535efb..c235b4357f7d 100644
> --- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> @@ -4,7 +4,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/=
rk3566-radxa-cm3-io-u-boot.dtsi
> index 158f652cb3b1..e0e501deccfe 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> @@ -7,5 +7,4 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>  };
> diff --git a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi b/arch/arm/dts/rk35=
66-soquartz-u-boot.dtsi
> index f65f4067f3e9..5e46a2422d60 100644
> --- a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> @@ -4,7 +4,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };
> diff --git a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi b/arch/arm/dts/rk=
3568-lubancat-2-u-boot.dtsi
> index a44ac35bdacd..1597473017ed 100644
> --- a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> @@ -8,7 +8,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs400-1_8v;
>         mmc-hs400-enhanced-strobe;
>         pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk=
3568-nanopi-r5s-u-boot.dtsi
> index 62f572c4cf9f..64c43374c042 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -14,7 +14,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>         mmc-hs400-1_8v;
>         mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3=
568-odroid-m1-u-boot.dtsi
> index ecba91aa30f5..1fc71faa9e07 100644
> --- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> @@ -8,7 +8,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>         mmc-hs400-1_8v;
>         mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3=
568-radxa-e25-u-boot.dtsi
> index caf524443079..74755a44eaee 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -16,7 +16,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>         mmc-hs400-1_8v;
>         mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk356=
8-rock-3a-u-boot.dtsi
> index 46ebb77283f1..5b823fcca5fb 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -20,7 +20,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>         mmc-hs400-1_8v;
>         mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk358=
8-rock-5b-u-boot.dtsi
> index e99e60185ebe..9ee9dd051e32 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -31,7 +31,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>  };
>
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk=
3588-turing-rk1-u-boot.dtsi
> index 471508a9ed74..ca2a684f3541 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -8,7 +8,6 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>  };
>
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk35=
88s-rock-5a-u-boot.dtsi
> index 9a6a353088df..efba0c359ba5 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -7,6 +7,5 @@
>
>  &sdhci {
>         cap-mmc-highspeed;
> -       mmc-ddr-1_8v;
>         mmc-hs200-1_8v;
>  };
> --
> 2.43.0
>
