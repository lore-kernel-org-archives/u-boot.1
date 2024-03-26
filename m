Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFBDC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 16:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D3487EFA;
	Tue, 26 Mar 2024 17:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUHBDcN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16A187F04; Tue, 26 Mar 2024 17:11:29 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2738287E47
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 17:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0d82c529fso13869315ad.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711469485; x=1712074285; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMNPjXVMa1iy9hkJuKZJI1CdcQFWEhuH/EpFWAL9WvQ=;
 b=hUHBDcN2kPHAjQpH7NPHxWPd8c0cHPy7sOciB2SpGC/H+PjtgeZZJAXOvqgChqO7Zm
 OUY6fzhVAvytkwzmlRy9Je6ElmBtAsl/lmYvXXOEhA1IlKH+0FirEiDGznwqWZHPzzjK
 PWsetzNKoHYobITyZnH71evNJk0SWubYACFNjQgruzraCnn8kM2wl3FUDFR3tTsHV3hH
 /BUl2MUxCmDjAja8k6cdxydzvzDQ6TZrQV8bmhr6lJg9qukWBHwVPGV91POFGvNNzjhT
 kndwqYCmvD4f1S9qOljPoYeupSbsy4J16dPEfDlGQzgwtcdkwQpvWQqlQj1GcxuFr9t1
 nmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711469485; x=1712074285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMNPjXVMa1iy9hkJuKZJI1CdcQFWEhuH/EpFWAL9WvQ=;
 b=hrRDsMG/cgoEVtPBZ0glpKSl+SePxvBYwTY8KB8hc4cC5qE/Z9YoEMFR3wR79ajCDI
 xAplVQjHzBWJeN8wKYPGmxGWgt/2s29I8GoMRWIcLiFkONP6+uvDk2a6a1yGRJyMQoge
 9eUNJjywkWnPNxqDaQrtlRJefm+IXh4OYAGNQuiJFIPptZpssR8368xeydh4ZWb7sW5U
 SGZM2XTU28LlnKV3gzaZjo+lrtR3xk4nEH0M6zBh/UCdVpd8iLLbPfC6aF8fie7LRWVI
 DNgQfq/1CVuZVNhqdi+Azj+OKHG81vR9qGQsbNe0tsHOMG9/Yho1L1swuPfbKnRt4g5L
 OzSw==
X-Gm-Message-State: AOJu0YxgA63NrG0MMNyrQjobTUQqCqL2b0sLUBGAlTuz6X5MyFj6u+KY
 bj2Cb3UutxGxUm+0no2SvZkcWITmPWw42vC4OKWpebj1wpON7auxaARVRelGEE6cuNwfje+VFvn
 Ma/gRZTQ/X0IX3dW3yREFI9Sq1UE=
X-Google-Smtp-Source: AGHT+IEq7lREYF3mbdciWMFvn9kpgUM1YDD5IEYKxd01yA3WyRI+hyY9NbgOEvJqq0fNsrjd2EGLAdRt2drnd1ycZaQ=
X-Received: by 2002:a17:902:720b:b0:1e0:984b:89c with SMTP id
 ba11-20020a170902720b00b001e0984b089cmr159455plb.34.1711469485551; Tue, 26
 Mar 2024 09:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
 <CAOMZO5BUibOAqqdtJtjrGwgciJ984ayUu0nPVdLkR_YLOh9bHQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BUibOAqqdtJtjrGwgciJ984ayUu0nPVdLkR_YLOh9bHQ@mail.gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 26 Mar 2024 17:11:14 +0100
Message-ID: <CAH9NwWdfcOM-q-EBVeZBs7-PRkr87M+pn-dYTzMW5bW7KRTo8g@mail.gmail.com>
Subject: Re: mx6cuboxi: failes to detect model
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, jonas@kwiboo.se,
 josua@solid-run.com, 
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
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

Hi Fabio

>
> On Tue, Mar 26, 2024 at 12:17=E2=80=AFPM Christian Gmeiner
> <christian.gmeiner@gmail.com> wrote:
> >
> > I am seeing model detection problems with the current git master.
> >
> > U-Boot 2024.04-rc5 (Mar 26 2024 - 15:59:22 +0100)
> >
> > CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
> > CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
> > Reset cause: POR
> > Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> > gpio@20a4000: set_dir_flags: error: gpio GPIO3_8 not reserved
> > gpio@20a4000: get_value: error: gpio GPIO3_8 not reserved
> > gpio@20a8000: set_dir_flags: error: gpio GPIO4_4 not reserved
> > gpio@20a8000: get_value: error: gpio GPIO4_4 not reserved
> > gpio@20b0000: set_dir_flags: error: gpio GPIO6_9 not reserved
> > gpio@20b0000: get_value: error: gpio GPIO6_9 not reserved
> > Board: MX6 HummingBoard
>
> Unfortunately, my mx6cuboxi no longer works, so I can't test it myself.
>
> I am adding Baruch on Cc. Hopefully, Baruch or Josua can take a look.
>

Thanks.

> The 'not reserved' errors may be caused by the lack of gpio_request().
>
> Do the changes below help?
>
> --- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
> +++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
> @@ -336,18 +336,21 @@ static enum board_type board_type(void)
>          * HB             1     1    x
>          */
>
> +       gpio_request(IMX_GPIO_NR(2, 8), "val3");
>         gpio_direction_input(IMX_GPIO_NR(2, 8));
>         val3 =3D gpio_get_value(IMX_GPIO_NR(2, 8));
>
>         if (val3 =3D=3D 0)
>                 return HUMMINGBOARD2;
>
> +       gpio_request(IMX_GPIO_NR(3, 4), "val2");
>         gpio_direction_input(IMX_GPIO_NR(3, 4));
>         val2 =3D gpio_get_value(IMX_GPIO_NR(3, 4));
>
>         if (val2 =3D=3D 0)
>                 return HUMMINGBOARD;
>
> +       gpio_request(IMX_GPIO_NR(4, 9), "val1");
>         gpio_direction_input(IMX_GPIO_NR(4, 9));
>         val1 =3D gpio_get_value(IMX_GPIO_NR(4, 9));
>

It got better but the model is (still) wrong:

U-Boot 2024.04-rc5-dirty (Mar 26 2024 - 17:03:41 +0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 20C
Reset cause: POR
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
Board: MX6 HummingBoard2
DRAM:  2 GiB
Core:  82 devices, 17 uclasses, devicetree: fit
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default enviro=
nment



With the revert of 9e644284ab812f2db23f6185af77c0e771b0be73 I get:

U-Boot 2024.04-rc5-00002-g3512482aeb (Mar 26 2024 - 17:06:01 +0100)

CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
CPU:   Extended Commercial temperature grade (-20C to 105C) at 25C
Reset cause: POR
Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
Board: MX6 Cubox-i
DRAM:  2 GiB
Core:  82 devices, 17 uclasses, devicetree: fit
...

git show 9e644284ab812f2db23f6185af77c0e771b0be73
    dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation

    Nodes with bootph-pre-sram/ram props are bound in multiple phases:
    1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
    2. At U-Boot proper pre-relocation phase
    3. At U-Boot proper normal phase

    However the binding and U-Boot Driver Model documentation indicate that
    only nodes marked with bootph-all or bootph-some-ram should be bound in
    the U-Boot proper pre-relocation phase.

    Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
    with a pre-reloc status only after U-Boot proper pre-relocation phase.
    Also update the ofnode_pre_reloc documentation to closer reflect the
    binding and driver model documentation.

    This changes behavior of what nodes are bound in the U-Boot proper
    pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
    to restore prior behavior.

    Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
    Reviewed-by: Simon Glass <sjg@chromium.org>


--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
