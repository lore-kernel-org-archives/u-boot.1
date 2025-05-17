Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290E8C3ABDD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F31808AF;
	Sat, 17 May 2025 22:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FxwP+oKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4782A81FEE; Sat, 17 May 2025 22:46:44 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B92C8004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so45461715ad.0
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747514800; x=1748119600;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twEiyM6exA3Vn6FR/mYio3ErbEFOJtjk0VgmDlTE5Gg=;
 b=FxwP+oKEbR6lTcrk7GKtjchBtFzspTrz2KWsB3wKi/aiVMl4jaTlHUd0s8vBL3aMEf
 2KspGhj/OAQ/z+JhoPFDsqLMeS/tniYyHuOZ68GY95UywWXl3p10CvYQnXdY/fMGHdHP
 XUqpuvFVzNPdkrO8MBdG3CVMkkx50K8+UXtaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747514800; x=1748119600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twEiyM6exA3Vn6FR/mYio3ErbEFOJtjk0VgmDlTE5Gg=;
 b=BnoLynU6guOe9Xevr7Ir8QFAXOes8BLAvNUi7u18zfd4RgZJr2Uyd+ja9iCFpsT/wU
 MrxH8VGl4J/LBGz4c0gmhrP/HVUEe5K+Yckg3C/8qBZu61eQVFVBToXG4uDrxvhoHepo
 eO2lH4yVhC1mjQ+0ulADKBqQMDrYDVVPlQrzkAylDzwdrLr0jrm9Jv7ghjAwbGVuuLXE
 hGVn+U/ZIcCe9de/Mm6f1R+DDQG1wifbuhUnxu3GLG8+6rksd0VN8fAMJhwbtu0ecoo7
 qbZpiAnoNlXGCzLZS9A0C8pRD9dupe7Ir7zFtRr7yHBNGp4OBlNWWlkPleBDQmWK6+Zb
 xDiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNw5EiwbugDGOXB+1PdpKrUk4BQuNeraADiYKj/gRG1xUf5fYWrzvG/YErhtBmBneZpKgG/ko=@lists.denx.de
X-Gm-Message-State: AOJu0YzTW5H50AHdi3qts/WqVXDln5bsBVU7UC3OjN4TaT/koqCrHZrA
 Zv2qDbambys2lYyy6WDmcuWzPQDxHpaEC9TjqsHBCJNTJEaQnQK9LZcdkDW//y7K9MpM66kV6WO
 OIuhENMP2WjmLDf2WiYNA7Te5qnxVx3D2K+Lc/Iw9PQ==
X-Gm-Gg: ASbGncvdRf2t/35reI02u/2KW3ztuB8xiz5VDvC6SVn/arQps2PuEi/Y/JET9fGk4sJ
 zs8h0KKRs4DWgSVs0jUHuRL9hF9jyVT4lmVaqXLQ+nof0uIKQbQx2kWaGDVhnlzbKyCyK2uNOWJ
 enOucj3rErg8oYWEI66PGqatizckOAiQ==
X-Google-Smtp-Source: AGHT+IGIPW60hgz2ebGhh0y4NyoCiBDuYRV5bE8Mv+uHu/XzMeexnRAD3P6ibxLHY4bVrVVkBpVhxO2kKacQIe87Yz8=
X-Received: by 2002:a17:903:110f:b0:221:1497:7b08 with SMTP id
 d9443c01a7336-231b39d5c45mr175318855ad.23.1747514800484; Sat, 17 May 2025
 13:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
 <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
 <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
 <CAOf5uw=cb2jQK1f-avqRvYxukYb-Sy-jWDvqEyM+nRLTnXcAwQ@mail.gmail.com>
In-Reply-To: <CAOf5uw=cb2jQK1f-avqRvYxukYb-Sy-jWDvqEyM+nRLTnXcAwQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 17 May 2025 22:46:29 +0200
X-Gm-Features: AX0GCFu7O2ieBgLSmnC7PjYjpncarBkb-voY0JVvQ25uKg2eN2Kf6Wg5MdV2K9Y
Message-ID: <CAOf5uw=099igk1=dEXH6dbUDMSH+bVo67mek_P=+G3Sw-f4B3A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Fabio Estevam <festevam@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

On Sat, May 17, 2025 at 10:44=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Sat, May 17, 2025 at 10:28=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > On Sat, May 17, 2025 at 5:15=E2=80=AFPM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >
> > > Can you please point me to an example of a tested board?
> >
> > I have just tested the top-of-tree U-Boot on an imx8mn evk board:
> >
> > U-Boot SPL 2025.07-rc2-00018-g126a88d49bca (May 17 2025 - 17:21:14 -030=
0)
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > SEC0:  RNG instantiated
> > Normal Boot
> > Trying to boot from BOOTROM
> > Boot Stage: Primary boot
> > image offset 0x8000, pagesize 0x200, ivt offset 0x0
> > NOTICE:  Do not release JR0 to NS as it can be used by HAB
> > NOTICE:  BL31: v2.12.0(release):v2.12.0
> > NOTICE:  BL31: Built : 17:16:49, May 17 2025
> >
>
> I was on master except this commit
>
> commit 128d997a8772cc174f38d529d8b25f90b3aa8ad8
> Author: Jonas Karlman <jonas@kwiboo.se>
> Date:   Sat May 10 15:32:01 2025 +0000
>
>     clk: Fix clk_set_parent() regression
>
>     The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
>     while reparenting") add a call to clk_enable() for the parent clock.
>
>     For clock drivers that do not implement the enable() ops, like most
>     Rockchip clock drivers, this now cause the set_parent() ops to never
>     be called when CLK_CCF=3Dn (default for Rockchip).
>
>

BTW is really needed now?

git grep init_uart_clk board/freescale/imx8mn_evk/
board/freescale/imx8mn_evk/spl.c:       init_uart_clk(1);


Michael

> I can not try today but if you can, is this the commit that could break m=
y boot?
>
> Michael
> >
> > U-Boot 2025.07-rc2-00018-g126a88d49bca (May 17 2025 - 17:21:14 -0300)
> >
> > CPU:   NXP i.MX8MNano Quad Rev1.0 A53 at 1200 MHz
> > CPU:   Consumer temperature grade (0C to 95C) at 32C
> > Model: NXP i.MX8MNano DDR4 EVK board
> > DRAM:  2 GiB
> > Core:  180 devices, 23 uclasses, devicetree: separate
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> > Loading Environment from MMC... Reading from MMC(1)... OK
> > In:    serial@30890000
> > Out:   serial@30890000
> > Err:   serial@30890000
> > SEC0:  RNG instantiated
> > Net:   eth0: ethernet@30be0000
> > Hit any key to stop autoboot:  0
> > u-boot=3D>
> >
> > Make sure you are using the most recent U-Boot. We had some imx8m
> > clock drive hickups after 2025.04.
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
