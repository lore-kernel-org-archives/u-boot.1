Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B72FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 00:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68812877B3;
	Tue, 12 Dec 2023 01:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EslralnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FD2877A9; Tue, 12 Dec 2023 01:35:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA9D877BB
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 01:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a1f33c13ff2so434773366b.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702341334; x=1702946134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+/vsa3e2VAOoaqoS2s9JzZ1WzFbsWkisT8EBUBktAzw=;
 b=EslralnPXdXJPouf2xGUW+i7Gtb44NNqDuUgcCK0+Z35RUgF9FP37kU8MnwNkfaheQ
 LZGW2oU+8H64HAI3dEERTRn4fIPE2DIH0o+L2Q2ztfdbZ7GbYisF+tnHZSf5BdVAvSdH
 x4SBQL6yNDB3AUi+sLx9U1eK+/4nq5Lq2Doh4FzFyqeE6+TYn5tnh01eduyibJMnguun
 hzPWoteCv38qBnvHvbX6iPSao/XBerVWtkTbe0qBBo3c9S0OSkiY0tsGg1M9lRbq70iJ
 yr22XbhKfKNrzZ2klm6RTyj62bFA+R0omfAUu/ZXlly/EB/DtxF56dOYC3nbvcITTos5
 Lauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702341334; x=1702946134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/vsa3e2VAOoaqoS2s9JzZ1WzFbsWkisT8EBUBktAzw=;
 b=SBOPvqiaqcYWayYD/YyP/Ftsfek9ZhSZT5zN6Vs60M1JBRjH1Y+KoGFnwoR1C4M+cE
 ScV565ds6aJgbi2MixBesz1PnJayV0RvnNXiBSwDF5PkK5d9YdV9lZis9IsZUzBUBFqL
 qbulA6Fbn70P7roBgmSfUSdeHG3QcAlXtCcMsnbTWk0MKqb9o8ZiTs9Z9vTcoPXTx2q5
 Smrw2cVagHbg/Ry7ag2Ul90WH8Ppi0xiqoykJWd7h/s/LDw/5kwgx7QS1lN0TjjG2XmX
 RcA4tYq3b/UsYcpymLoEZgbuNATt7kLAXLE5QCDEDt/YvpsVLYj5SYJvvru7uHAb3cdn
 npQw==
X-Gm-Message-State: AOJu0Yx70nwtDrsjSNdN+vvNzjbE4DiI2yk27AYSZyYxuMx6PIc0TBTR
 stX5hV2/UTI8bBBe740tIRfQ4TO2fBr1zs8qfAOwzltkInc=
X-Google-Smtp-Source: AGHT+IGbZKKe1m4TL9zWonRiduO3TKuKv70s90cvgfS5mO7Gf6sg4x6r/Ec404uQ4j/rbEd+8yrBNlW2L4XnOeY0iKY=
X-Received: by 2002:a17:906:6d06:b0:9b2:d554:da0e with SMTP id
 m6-20020a1709066d0600b009b2d554da0emr2941368ejr.69.1702341333484; Mon, 11 Dec
 2023 16:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com> <877clq6odx.fsf@redhat.com>
In-Reply-To: <877clq6odx.fsf@redhat.com>
From: Gilles Talis <gilles.talis@gmail.com>
Date: Mon, 11 Dec 2023 20:35:22 -0400
Message-ID: <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
To: Milan Zamazal <mzamazal@redhat.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, uboot-imx@nxp.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Milan,

Le jeu. 7 d=C3=A9c. 2023 =C3=A0 11:09, Milan Zamazal <mzamazal@redhat.com> =
a =C3=A9crit :

> Peng Fan <peng.fan@oss.nxp.com> writes:
>
> > On 5/24/2023 3:21 AM, Gilles Talis wrote:
> >> Add support for the Polyhex Debix Model A SBC board.
> >> It is an industrial grade single board computer based on
> >> NXP's i.MX 8M Plus.
> >> Currently supported interfaces are:
> >> - Serial console
> >> - Micro SD
> >> - eQOS and FEC Ethernet
> >> imx8mp-debix-model-a.dts is taken from Linux 6.3.
> >> Signed-off-by: Gilles Talis<gilles.talis@gmail.com>
> >
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> Do you know why the patch has been left (as far as I can see) without
> further action?
>
I don't know. I assume the maintainer is very busy or has missed it. I was
planning to do a resend in the next few weeks.


>
> BTW, I applied it to current master, compiled approximately following
> https://docs.u-boot.org/en/latest/board/nxp/imx8mp_evk.html and tried to
> use it on Debix Model A.  U-Boot starts but cannot find the partition
> table on the SD card:
>
>   U-Boot SPL 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00
> +0000)
>   Normal Boot
>   WDT:   Started watchdog@30280000 with servicing every 1000ms (60s
> timeout)
>   Trying to boot from BOOTROM
>   Boot Stage: Primary boot
>   image offset 0x8000, pagesize 0x200, ivt offset 0x0
>   NOTICE:  BL31: v2.2(release):rel_imx_5.4.70_2.3.6-0-g15e8ff164-dirty
>   NOTICE:  BL31: Built : 00:00:00, Jan  1 1980
>
>
>   U-Boot 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00 +000=
0)
>
>   CPU:   Freescale i.MX8MP[8] rev1.1 at 1200 MHz
>   Reset cause: POR
>   Model: Polyhex Debix Model A i.MX8MPlus board
>   DRAM:  2 GiB
>   Core:  83 devices, 22 uclasses, devicetree: separate
>   WDT:   Started watchdog@30280000 with servicing every 1000ms (60s
> timeout)
>   MMC:   FSL_SDHC: 1, FSL_SDHC: 2
>   Loading Environment from MMC... *** Warning - bad CRC, using default
> environment
>
>   In:    serial@30890000
>   Out:   serial@30890000
>   Err:   serial@30890000
>   Net:   eth1: ethernet@30bf0000 [PRIME]
>   Hit any key to stop autoboot:  2 <0x08><0x08><0x08> 1 <0x08><0x08><0x08=
>
> 0
>   switch to partitions #0, OK
>   mmc1 is current device
>   Scanning mmc 1:1...
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   <0x1b>7<0x1b>[r<0x1b>[999;999H<0x1b>[6n<0x1b>8Card did not respond to
> voltage select! : -110
>   No EFI system partition
>   No EFI system partition
>   Failed to persist EFI variables
>   Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios
>   BootOrder not defined
>   EFI boot manager: Cannot load any image
>   ,** No partition table - mmc 1 **
>   Couldn't find partition mmc 1:1
>   Card did not respond to voltage select! : -110
>   u-boot=3D>
>
> When I use an old U-Boot blob provided by Debix, it boots fine from the
> same SD card.  The SD card contains a Fedora aarch64 image with a msdos
> partition table.
>
> Do you know what could be wrong?
>
Interesting. I don't have a clue yet,. but let me give it a try and come
back to you. Where can I download the Fedora aarch64 image you mentioned
above?


>
> Regards,
> Milan
>
> Thanks!
Gilles.
