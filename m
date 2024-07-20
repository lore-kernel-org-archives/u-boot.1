Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88624C3DA5D
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 00:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE04886DB;
	Sat, 20 Jul 2024 02:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BW9TMCN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02DD88718; Sat, 20 Jul 2024 02:07:03 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7720884BE
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 02:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52e9b9fb3dcso2326482e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721434021; x=1722038821; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqqoebHtGhhGg1HhP7CWYNtlgq1mekBeuabSQJy0zHY=;
 b=BW9TMCN2CPS18H2YdptI3TjR38dg+n9bwnp1/Sb9+zwMVfP01uCOqCbLqXnTbqNx7h
 znifCU5nB450wOnB9xa+b7utmPWHaR/ZL1AC6r5TfyYSiHX9Xk+NeeMPOJ3+5dzQuA3F
 mx7y89sqjRmaoc6j6nZyhguUFi9oj4QJfWSS0d/AqPLZwEG4IbmSEMvMy9zYpffSJDH4
 a6Kguwl4eCCetImejUdFQYwFMDM2DjYrmVN7jehn0ASsBzRBMgLRg6qkMVKUcwP6axwx
 8DHBt3fGOrrO51Y+Q8qoiIu6KxdJCgvscDca2/paI4In2c324coKUlrYx/uXgA+BeaSX
 EXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721434021; x=1722038821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqqoebHtGhhGg1HhP7CWYNtlgq1mekBeuabSQJy0zHY=;
 b=KCOoAGH+pviysGKixYsS3cpGd7e0zyMSJXmjZ4N8AZMxRtA6guUSJmx4npOo721NCS
 mssCN71+fL80abjPZrg3Jt8121mRBDkI05xmBup3dAa7WqTcmg48HOR90YD+UZ6HgipT
 EwU4t3ZKmNLd4cbwjXtHdEqsrWCTzqHGk2nbJkZbCmaL9FPXKc7pK+BI67awsjKfbBZJ
 9jhRQRuEegvRpGyz3Si6dKo0yCZzlEAQ8h9hEqg7X/RTcX1gNSR9k3dOR6mXtcb8ibOl
 EP68Jtydd3CHnEzrmfKG2mnBf0X+mtc02mh4uKMXnXXBIokwpy1GpWl3daDHW0fd73Lv
 KEDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX99IarxZVmtIr/Abas2LO6hbPNUgYson7jkRlkyEC8RCn6bLwl3qsRYO6IgR8sGmmq4BdLkms+vIa9SHfpBBA++lwLWg==
X-Gm-Message-State: AOJu0YxwQBcTnidgFAyP5emGTOk1b9YSJ2qEnq2kbIun2IfYoGH5OFYu
 OM6lkU3mMN72qY5GR/3p2mvAEEBVf3DoAJfsbwlAAXfxfLBeNLApB0YytC9kEgsi+wdCM3bML+o
 D4aZW2ILuzpwvtyrvijRnRSt4FK1AlrRD
X-Google-Smtp-Source: AGHT+IGJ3350QFu4t4Br79TczSFzyzAnL/kPDjnSa/umbvgprRPQ1vmvQhMYKkbjMuRu8XSH+CtgpmEKtLUgDWfCI7g=
X-Received: by 2002:ac2:4c4f:0:b0:52c:cd4f:b95b with SMTP id
 2adb3069b0e04-52ee53b060emr5193132e87.22.1721434020532; Fri, 19 Jul 2024
 17:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240719231158.50416-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240719231158.50416-1-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 19 Jul 2024 17:06:49 -0700
Message-ID: <CANV2PTPOesJWcbYhVeiQWonccy3rWdQmN5qfuJtFN+JpnYNzbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] board: fix compatible property Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, Hal Feng <hal.feng@starfivetech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de
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

On Fri, Jul 19, 2024 at 4:12=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For the Milk-V Mars CM (lite) we have only been copying sizeof(void *)
> bytes to the compatible property instead of the whole string list.

This const char array must be so that we may get an accurate data
length with sizeof() but it highlights there are helper functions for
get of fdt stringlist and not for set of fdt stringlist.

>
> Fixes: de3229599d4f ("board: add support for Milk-V Mars CM")
> Reported-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/starfive/visionfive2/spl.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index b794b73b6bd..f55c6b5d34c 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -170,23 +170,32 @@ void spl_fdt_fixup_mars_cm(void *fdt)
>  {
>         const char *compat;
>         const char *model;
> +       int compat_size;
>
>         spl_fdt_fixup_mars(fdt);
>
>         if (!get_mmc_size_from_eeprom()) {
>                 int offset;
> +               static const char
> +               compat_cm_lite[] =3D "milkv,mars-cm-lite\0starfive,jh7110=
";
>
>                 model =3D "Milk-V Mars CM Lite";
> -               compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
> +               compat =3D compat_cm_lite;
> +               compat_size =3D sizeof(compat_cm_lite);
>
>                 offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/m=
mc0-pins-rest");
>                 /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NON=
E) */
>                 fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
>         } else {
> +               static const char
> +               compat_cm[] =3D "milkv,mars-cm\0starfive,jh7110";
> +
>                 model =3D "Milk-V Mars CM";
> -               compat =3D "milkv,mars-cm\0starfive,jh7110";
> +               compat =3D compat_cm;
> +               compat_size =3D sizeof(compat_cm);
>         }
> -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat,=
 sizeof(compat));
> +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
> +                   "compatible", compat, compat_size);
>         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model=
);
>  }
>
> --
> 2.45.2
>

-E
