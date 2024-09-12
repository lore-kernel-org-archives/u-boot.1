Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD7AEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F325C88DE9;
	Thu, 12 Sep 2024 03:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lQz0qFjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F7988DD0; Thu, 12 Sep 2024 03:00:32 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0F688DF0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso269659b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102825; x=1726707625; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZN0RAxW1eQP0AgN15SycdnF3Zl4aaG0hWlMZRHiPAE=;
 b=lQz0qFjgnjsscMPuCjeejRUenLMR01YHjX4zaIw/TBfNggxnDJXxv4yejvrHhSKfog
 Xqu9714SNBVG9+R861TUoMtfK8yr8SEzbUvD0fubbYK+2B14A+ORivGgKfaVxKJSFtKV
 zWbMWIlV0Zc1a2nsBJGEqVZ0wokr+ywtozwXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102825; x=1726707625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZN0RAxW1eQP0AgN15SycdnF3Zl4aaG0hWlMZRHiPAE=;
 b=E/TzC25rdpIthYr5ByoSKWslYckej3T+lTuyRc8FgqYLLaIZ5D4cDQR1LMoBIMX7qS
 /3eCyZo/dmdVmTEZ3xNdZ7Y1vQInFhpVXHMCG6CkwFtYwC6iUhxoJ5haGDt02L1qxdw9
 rIVatxvYgefqmv1UPhmogfYIuvMbY639oOFwkl6C1DRGssWcBb1UWsr/dsJsufNg3H8q
 lueav1Oa1bz4SDqbwVK2aOlOdzkg+XDwkHlJxadAWBvvd9I1ZbT40hSZC8GndP6IE63U
 5C/jUTeATlC36TCBFIlzSr58m8saaikz1bhICrRZQwu7ws8GTnMFDHp2WDL6JowZRJc0
 JxbQ==
X-Gm-Message-State: AOJu0YzauI0XG40pppEeEzEMkbTq8tO1TS4OPfR/OTo8DYPFE+yQseXS
 h8SJvBbR9KrI8p3Kg2UOyz/wa059xXQEIdT6Pw7HKGl6s1IJ8sgDIsJS1zB6B4EqIUW60osDESp
 Oq6X2mhjiJ7aL8pJaQw6XQ7ZNufJ1SmuTrp/i
X-Google-Smtp-Source: AGHT+IGLSVPWiN9WaQH2w8gUm4VZ/I3Ny2mv7cILWV25L+lUoagmdgyNJWjsj1+sOUlho6h0nAsOAPYRPdyNpXzrJuI=
X-Received: by 2002:a05:6a00:4b53:b0:717:8d5d:94d6 with SMTP id
 d2e1a72fcca58-71926087dcfmr1793401b3a.12.1726102825402; Wed, 11 Sep 2024
 18:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <6193d95a9c0f3ae319a900b46d6212f7ab16aba4.1726041851.git.michal.simek@amd.com>
In-Reply-To: <6193d95a9c0f3ae319a900b46d6212f7ab16aba4.1726041851.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:01 -0600
Message-ID: <CAFLszTh3ew6fiZF3pyaV+6Pz+3BAy-LrLfnQizF=U0C--_DVZA@mail.gmail.com>
Subject: Re: [PATCH] xilinx: zynqmp: Add bootmenu support
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Michal,

On Wed, 11 Sept 2024 at 02:04, Michal Simek <michal.simek@amd.com> wrote:
>
> From: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
>
> Popup the bootmenu for 5 sec with default boot options to CC on AMD CCs a=
nd
> default to SOM on others.
> Users can anytime disable the bootmenu by setting the variable
> enable_bootmenu=3D0 in zynqmp_kria.env or setup it up at run time and sav=
e
> variables to NV memory.
>
> The patch is also fixing issue created by commit 4c7363068651 ("cmd:
> setexpr: fix no matching string in gsub return empty value") which has
> changed return value from setexpr command (Before this commit when
> matching string wasn't found command return 1 that's why was possible to
> use with if).
>
> Signed-off-by: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  board/xilinx/zynqmp/zynqmp_kria.env | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Can this use standard boot? For example 'bootflow scan -lb mmc' ?

>
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zy=
nqmp_kria.env
> index 49ef3e7d7532..d0e431ebb46f 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -49,9 +49,19 @@ usb_boot_devices=3D'usb0 usb1 usb2 usb3 usb4'
>  som_cc_boot=3Dif test ${card1_name} =3D SCK-KV-G; then setenv boot_targe=
ts mmc1 ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; elif test =
${card1_name} =3D SCK-KR-G; then setenv boot_targets ${usb_boot_devices} px=
e dhcp jtag && run distro_bootcmd; else test ${card1_name} =3D SCK-KD-G; se=
tenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; =
fi;"
>  som_mmc_boot=3Dsetenv boot_targets mmc0 && run distro_bootcmd
>
> +# To disable bootmenu set enable_bootmenu=3D0
> +enable_bootmenu=3D1
> +check_cc_for_default_boot=3Dif test ${card1_name} =3D SCK-KV-G || test $=
{card1_name} =3D SCK-KR-G || test ${card1_name} =3D SCK-KD-G; then setenv b=
ootmenu_default 1; else setenv bootmenu_default 0; fi
> +som_bootmenu=3Dif test ${enable_bootmenu} =3D 1; then run check_cc_for_d=
efault_boot; bootmenu; else run som_mmc_boot; fi
> +
>  k26_starter=3DSMK-K26-XCL2G
>  k24_starter=3DSMK-K24-XCL2G
> -bootcmd=3Dsetenv model $board_name && if setexpr model gsub .*$k24_start=
er* $k24_starter || setexpr model gsub .*$k26_starter* $k26_starter; then r=
un som_cc_boot; else run som_mmc_boot; run som_cc_boot; fi
> +bootcmd=3Dsetenv model $board_name; setexpr model gsub ".*${k24_starter}=
.*" starter; setexpr model gsub ".*${k26_starter}.*" starter; if test ${mod=
el} =3D "starter"; then run som_cc_boot; else run som_bootmenu; fi
> +
> +# Boot menu
> +bootmenu_0=3DeMMC Boot=3Drun som_mmc_boot
> +bootmenu_1=3DSD Boot=3Drun som_cc_boot

Would bootstd find these automatically?

> +bootmenu_delay=3D5
>
>  usb_hub_init=3Dmw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
>
> --
> 2.43.0
>

Regards,
Simon
