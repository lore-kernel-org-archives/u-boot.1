Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F88E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87541801CF;
	Tue, 17 Dec 2024 12:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EnHz4QbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97FF1801FB; Tue, 17 Dec 2024 12:56:30 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503ED801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f145e5cd83so43747087b3.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 03:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734436587; x=1735041387; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TraR6aBzox6lLB/FwU42apW0jDlUh6d3BJr0xCPB1Y=;
 b=EnHz4QbXyS9cXc6OkuXBCBLyfdcONgcoUM9Sf7QHL+gZw0NM84GC/BDecZmTXpgAgj
 FWOscR2LvYqj5nVlZem2jw9T3Pm83IS5TeqUw1vixXYC56ij/3PbmRq9Aa70dBmDHd4u
 jMjnJoa5EVRdZnrue20icEtUon1yiTWbaUXKEFxpKQ4AbFtPsuWXZC+E5B52Xzj+PX6v
 SermPyxYQSIk6xZY3vhh8PMovB0XfSC+Knf/H6RFG5RM+BW6osAuclbgKXzifH+8Jkgt
 TEB9nNjRMiHkLkrDveq88JIA9BsFAB3ZnAzQzkEfJ8NWpmpZgEPuBmHkxw5oH3TmRkkB
 iXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734436587; x=1735041387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TraR6aBzox6lLB/FwU42apW0jDlUh6d3BJr0xCPB1Y=;
 b=a0HmPXR22HFofbG5/iCfFOw/we+ewMIi7ACHxHiJh02MFao7zqsIExfLZ75z5hMnyD
 5bwV+1VMJQ3MqpQKMqquzdSzoFvunOhoTiTjByiSKuYBIiloE9azxDbm4qZgu+Wck2UH
 nFm+RkONSNqw6aQGXM5kjEOquy95TozBsRnREyRo5D1jddxrt5Bg63Tt+WzQuV3zKPay
 Nyc6wAHXDgiRsRqBF1H+mIhW0jsqprrxK4PcyovOTDMfsILpOjZ0T2C4IB/M8QwuL3hS
 4UE599UxcQnEniXo5LsyFNnCbBB9aQEGnqUaHKNCCURcbyjkmvUcNgwD7nwVeYs8nFeT
 YPkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXbGdfm/fBZjcRDxFg/1+4c/HWULA8ur5eJpw7UCsNSkQ9kHCE5QsmXZwRpuDiS/cWqr4AnAw=@lists.denx.de
X-Gm-Message-State: AOJu0YxY80P1eWP+IVZeFTLgLFRHBnidAf0zWEcBdfVuADtdd2/mGBd5
 D8joY6srQBQDEifT7cdFDPXI/xk62y9QY5uSIidth3K6oZcuk+AgheK71j5rRB0iK+Y0qfMNdIw
 4x2EuS1eHtpQOi18xhv/MxY3HV5FxsWeYR4rVCQ==
X-Gm-Gg: ASbGnctRbSt/0X6sV8RntBjHPUdKeJOnc6NrDYbQEr1HGMnZYuTIURoKWSOHrFA3SIT
 0ImnzwmfkFQJaIX3EqsVe7zqG9gnISWPk7Aztbg==
X-Google-Smtp-Source: AGHT+IH7AmarYVIKLySDzRaJBq5piU7fFlirdX5+T45kJMDLegR3CZNGT83cicu3WEzB5x6WTdhGODr3wPuKfBu/fR0=
X-Received: by 2002:a05:690c:6212:b0:6ef:5119:6f28 with SMTP id
 00721157ae682-6f279ade9d1mr137848557b3.8.1734436587042; Tue, 17 Dec 2024
 03:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
 <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
 <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
 <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
In-Reply-To: <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Dec 2024 13:55:51 +0200
Message-ID: <CAC_iWjJWA5nUP_cPkKnziK9s=dd6Zv40eOueyi7biERoO-UrkA@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 u-boot@lists.denx.de
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

Joao, there's 3 places that
'ERROR: Out of memory'. Since I don't have access to the board, can
you change the prints a bit and figure out where it comes from? I
assume it's from efi_console.c. Can we verify it?

Thanks
/Ilias

On Tue, 17 Dec 2024 at 13:18, Jo=C3=A3o Paulo Gon=C3=A7alves
<jpaulo.silvagoncalves@gmail.com> wrote:
>
> >
> > Okay. Please try changing the value of ram_top to 0x1_0000_0000
> > instead of 0xFFFF_FFFF. That should work.
> >
>
> Changing ram_top to 0x1_0000_0000 worked:
>
> U-Boot SPL 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
> DDR configured as dual rank
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x4802d400, size 1116
> Need continue download 1024
> NOTICE:  BL31: v2.6(release):lf_v2.6-g3c1583ba0a
> NOTICE:  BL31: Built : 11:00:38, Nov 21 2022
>
>
> U-Boot 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
>
> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 54C
> Reset cause: POR
> DRAM:  Ram top: 100000000
> 8 GiB
> Core:  183 devices, 31 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... Reading from MMC(2)... OK
> In:    serial@30880000
> Out:   serial@30880000
> Err:   serial@30880000
> Model: Toradex 0070 Verdin iMX8M Plus Quad 8GB WB IT V1.1A
> Serial#: 15207893
> Carrier: Toradex Dahlia V1.1C, Serial# 11060859
> SEC0:  RNG instantiated
> Setting variant to wifi
> Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
> Hit any key to stop autoboot:  0
> MMC: no card present
> switch to partitions #0, OK
> mmc2(part 0) is current device
> Scanning mmc 2:1...
> Found U-Boot script /boot.scr
> 5974 bytes read in 1 ms (5.7 MiB/s)
> ## Executing script at 50280000
> Loading DeviceTree: imx8mp-verdin-wifi-dev.dtb
> ...
> Starting kernel ...
>
> The change is shown in the patch below, but I am unsure if this is the
> correct solution. Should ram_top be the last valid address or the upper
> bound?
>
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.=
c
> index 9588b8b28bf2..e01774ebc8a4 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t tota=
l_size)
>          * space below the 4G address boundary (which is 3GiB big),
>          * even when the effective available memory is bigger.
>          */
> -       top_addr =3D clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xfffff=
fff);
> +       top_addr =3D clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0x10000=
0000);
>
>         /*
>          * rom_pointer[0] stores the TEE memory start address.
>
> Best Regards,
> Jo=C3=A3o Paulo Gon=C3=A7alves
