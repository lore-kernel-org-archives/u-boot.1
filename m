Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A87C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D4D82F00;
	Tue, 29 Jul 2025 18:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="oFPYJV1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8CC82B20; Tue, 29 Jul 2025 18:16:23 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F618304F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73e82d2ea1dso3444450a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1753805780; x=1754410580; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DquNu0RWH1dxZoKN0esKM8YoXNa8fZQpZpuKq3SeEAc=;
 b=oFPYJV1iNt5iVaF8jgwOJvR2B6vx/xjEhniOi1GCYCjAJGsTq2ctU8JCpVNhzQGP/V
 c6Y7+v44Lgl411JBJ5dJ0KKK22jn+Lasl8Cl9rqf8HcTfseNpFqmLswOdXarKNek7k3E
 LkDyE6jzxtXd/VmuO1erLDZ/Wf0U3bWQ82HD2Al1j8NHP9yjgkyfXBfZYwGd26y00P/Q
 zqgflUnnjkCsaNnQwzUMkq4PL3AtrlKG9VQdi5h4ankw5LydmIw0FS62+YDfqLuiiQav
 yZQ8pDCTqU68R2LyKUiJ4z+1o48gWosLXJuGLHh8F5/cC/55Hh4FwUgh1oZnbaEBa4W4
 T6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805780; x=1754410580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DquNu0RWH1dxZoKN0esKM8YoXNa8fZQpZpuKq3SeEAc=;
 b=EDdT+I1ur08R7qFXLENigrceMfZ7UamUD0hJoZ58zeWAIpm8ScVFYTRjOW8yKNjbxT
 1p7XfD0sGJdForU619ecVFclX8xCEiiUj2JKl1DkSuRWWerdQrtxCf7jRQ68+nFI+vEz
 xo2rPBw96LN9DBJXCYAgYgn9q1UVcBKsHIR+OkJ01wav+nnf0trZopqBUAn6i1XgbuSr
 sqfoW8i41ijpjMIO8josEymBg+7G9eNltHGVJHcMse4ocRGBPO0MhaE3CCzXQ+XYIWro
 a9lzUAeDuDrJ9IYgokp4nxPch0Nw4qOHyuqAk66Jeq5zGeabxDmvxbCMRUI1QwD2qSJe
 2XJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9CpuFOr8SBi39ZKfP4iZCELPrCWRgm3gFolDjcfuCstBngKqI9LyyRdrTxDAjSq6xz15/iog=@lists.denx.de
X-Gm-Message-State: AOJu0YyZJGLsC8Grm/G3VAytYiNsPy6i/pCHFvcpn37Ek1z5VmSvqXlR
 1j+9kk0xITVQtjpNEq4UD1hMWMRM/slfpw8HatQX3OIPlzh83UOJyCoK9wJptcgLqOSN54iN//T
 q0LyG0gwGO/785wvPWA31MZOk39sNMP/XN1Dzpp8Atg==
X-Gm-Gg: ASbGncuio9felnh4UTDt0ZOu4Tksut5/kEPAtz2+aQwAXeGpjvmUq4IRDKjLoh+ZyIO
 9ueoUhNGVj4E3xs210CZiJNNE24CkheeTwjsX5Z43wnoJg4AXJIgRfUx7fHTzzjFFuRo1QrXKhJ
 HJcW4BSanhN6cE5m6mIo7rOyGoRy264NSki5YitdI3LAa+BMjCmijP/AzQpeqO4HOD0e03qhUvw
 puT+8c=
X-Google-Smtp-Source: AGHT+IEUbg6y8XqOb85pM5tmtNckyHQaMPuj3Hl1yCQwAc++Nm2nyyXPQbHkcbMqBiC3oSeq3VQCJitz0gCMPOEHv8c=
X-Received: by 2002:a05:6808:2018:b0:426:25b6:5868 with SMTP id
 5614622812f47-4319bff2093mr172489b6e.32.1753805780380; Tue, 29 Jul 2025
 09:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-4-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-4-759619b47b1f@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 29 Jul 2025 09:16:09 -0700
X-Gm-Features: Ac12FXzEHk99Mm7poAPo6-WKRw1HUI_XchsMJeYKZ3ggJawTNJ_w3Dt7QwN-iAI
Message-ID: <CAJ+vNU20LLZn5uq7xFdwgQHymMc4hSqwBBh3XQh1ukYYWkQp-g@mail.gmail.com>
Subject: Re: [PATCH 4/6] imx95: Remove ROM info USB instance workaround for B0
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>,
 Adrian Alonso <adrian.alonso@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
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

On Tue, Jul 29, 2025 at 4:20=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> There was a bug in ROM on A0 for USB instance: USB1 is 3, USB2 is 4.
> So u-boot had a workaround to match with it.
> Since the issue is fixed on B0, so need a additional change.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/scmi/soc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/s=
cmi/soc.c
> index 13f13ca7d10..b21b18110b1 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -719,8 +719,6 @@ enum boot_device get_boot_device(void)
>                 break;
>         case BT_DEV_TYPE_USB:
>                 boot_dev =3D boot_instance + USB_BOOT;
> -               if (IS_ENABLED(CONFIG_IMX95))
> -                       boot_dev -=3D 3; //iMX95 usb instance start at 3
>                 break;
>         default:
>                 break;
>
> --
> 2.43.0
>

Hi Alice,

NAK. Please do not drop support for A0 (or send B0 EVK's to every user
who has an A0 EVK) or you will not be able to get any testing from
anyone in the community.

Best Regards,

Tim
