Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F326C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 14:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD5578081A;
	Mon, 24 Feb 2025 15:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyFbhwIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E5580EC0; Mon, 24 Feb 2025 15:38:13 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33FA1805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so9189628a91.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740407890; x=1741012690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqDrapJKy6eC2pB1NQppXWnFVZk2Ktw4yfxl4FK5OVw=;
 b=EyFbhwIeZ+JwaFPxiKcEuygoDmw7ID8/OvtOB7h6aAgHENDlm09M1YQEcZlf+c5DL8
 2ZEmbAKSIIz1Nkpc8tOi88/aXq80qrV6TbLpgdiFVklH9QFUxcf0ZymkrsL8CnbBvWrN
 z+kSBA8UM0zxqiaKzPF8ZMNHKsshgODD0Y2iaArbUQwFElbmCLf0koq/Qn+Sb+eg9Bli
 ykzDDoR3gHCcuprTPxW960SlzBEng0uiEXFmtevmEePFM1y4+31MT5P5ag0TCst/q30G
 YYYUSDJdSROQ39RUtmQCA1iaikiEcfvwRJXeZ7pFaaY0yAtiTic4gXQn2KvlppVlTH37
 Ix1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740407890; x=1741012690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqDrapJKy6eC2pB1NQppXWnFVZk2Ktw4yfxl4FK5OVw=;
 b=m3/RLH1d9ZOtz5d/5cENnemn+B/aJ0Vr5EvqXVs7gKwX28Ja73DL9llCayoaOQoCWw
 5A+g7hRQBX3vjymWiiRUYDtxdNZK3/+hk5veJoDEa5pICEi2gdYz9iv4pdnfzbL4wScD
 diM2WO3/1vZHKJn/we7cKeoor//0iVQDsu209BhsJkRU5w6lyznSkwmPi1GU8SNriSPJ
 KdwsBlcBB5zTQm9KyOSKcJh5UdjAvGC7r/6kMtEL3LX0Z4dc465Z/ZK2DqUMgJ6nngV/
 IrCY3HQ9AO0q136PpERULBdDNG+TQBwyckKc+eatRTGgcY/wbaK9WzkG5xOAxzp5R7Lt
 pPZA==
X-Gm-Message-State: AOJu0YxNDlrU/mi97HAY+MzFBzjYyf/asnkykjFyyld/nsx7DR+W7GUf
 zUdE9qU48If2hwrWe25tETGrmxsF/Xp9/o8BE0XuuiKZtbhuFNTRl11LdhFO6fCFPG6TgQg9Asg
 p63VJkkt6mkruKqBQCj0EvJ3TU8WkVg/cuhU=
X-Gm-Gg: ASbGncv3QtZ21CQPzobxwKKkaF+UACJxGBVazVwsBKYHIR35XHEQaSo+Ra+1hDvKtWB
 cpCK0aPFJsyhRNKllAieirevxkdIckdlrPubopSmZLOE56ufiusFfnGAhe9IdlfPkQ5Skf/1ly0
 Rar3VdvrmNSR6ey+IIkFD4LkNEbcR/qRTlCwUCAA==
X-Google-Smtp-Source: AGHT+IHVZhWJMokR/KTBjgCymGaQ++LBoEgEPM/Mt+R25c11Rz7/fS9guP4YwBKs3pplNwiJ/IMd32buOERHgruwMDI=
X-Received: by 2002:a17:90b:2e4f:b0:2fc:b40:339a with SMTP id
 98e67ed59e1d1-2fce78a95d5mr24347159a91.10.1740407889499; Mon, 24 Feb 2025
 06:38:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJs94EYBX3iNiOcSPXtrxA_brQACwjcTSJ6BjhqJdOdBNGxG+Q@mail.gmail.com>
 <19488fdc-2666-4407-b49b-d25085c98453@cherry.de>
In-Reply-To: <19488fdc-2666-4407-b49b-d25085c98453@cherry.de>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Mon, 24 Feb 2025 17:37:58 +0300
X-Gm-Features: AWEUYZkpfe45TtPpxgKj-iCBhw8Xk-aotdemdj069X4HCJhokCAvZdKlhB0Kfz8
Message-ID: <CAJs94EbjwrFgh5Rb5addpdj19hfi2SPeDpDgGJYavNA_0GpCrg@mail.gmail.com>
Subject: Re: Need help with booting from SPI Flash
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

=D0=BF=D0=BD, 24 =D1=84=D0=B5=D0=B2=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 13:5=
4, Quentin Schulz <quentin.schulz@cherry.de>:
>
> Hi Matwey,
>
> On 2/24/25 10:57 AM, Matwey V. Kornilov wrote:
> > Hi,
> >
> > I have an Allwinner based board with manually soldered 16MB SPI Flash.
> > I am trying to place u-boot into the flash and need some help so far.
> > I have already updated the board DTS file and checked that the Linux
> > kernel provides me with a /dev/mtd0 device which is writable and
> > readable.
> >
> > I enable the following config options additionally to the board configu=
ration:
> > CONFIG_SPL_SPI_FLASH_SUPPORT,
> > CONFIG_SPL_SPI,
> > CONFIG_SPL_MTD_SUPPORT,
> > CONFIG_SPL_SPI_FLASH_MTD,
> > CONFIG_SPL_SPI_LOAD.
>
> Make sure the driver for the SPI controller on your SoC also is enabled
> in SPL.
>
> > I am not sure that I chose every relevant option.
> >
> > However, I see the following message from the bootloader:
> >
> > U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 12:43:35=
 +0300)
> > mxstatus=3D0xc0408000 mhcr=3D0x0000010b mcor=3D0x00000003 mhint=3D0x000=
04000
> > Trying to boot from SPI
> > Invalid bus 0 (err=3D-19)
> > SPI probe failed.
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >
> > Are there any obvious things I missed? How could I debug this?
> >
>
> Can you check your SPL DTB has the SPI bus and flash node?
>
> dtc -I dtb -O dts spl/u-boot-spl.dtb
>
> If not, you're missing a <your-board>-u-boot.dtsi in arch/arm/dts/ where
> the SPI bus (and most of what it is needed to enable the controller,
> power, clock, pinmux, ...) and the flash node has the appropriate
> bootph- property. I believe it should be bootph-pre-ram for SPL,
> according to scripts/Makefile.lib (fdtgrep_props).

Thanks. This indeed helped me, while no success yet:

U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 17:31:47 +03=
00)
mxstatus=3D0xc0408000 mhcr=3D0x0000010b mcor=3D0x00000003 mhint=3D0x0000400=
0
Trying to boot from SPI
fdt_fixup_memory_banks: FDT_ERR_BADMAGIC
Failed to update DTB
resetting ...
reset not supported yet
### ERROR ### Please RESET the board ###

>
> Cheers,
> Quentin



--=20
With best regards,
Matwey V. Kornilov
