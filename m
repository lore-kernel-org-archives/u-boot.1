Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FE2D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD84283C29;
	Mon,  1 Dec 2025 18:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LkyRvZpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B431B8006D; Mon,  1 Dec 2025 18:09:51 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A4D83C29
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so7815216a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764608989; x=1765213789; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9wYFs0q3JxF/bOnYDa4IQCdl79iH0yJQGUrHUEMM+U=;
 b=LkyRvZpm394hQwHgYIp1FTSwUodLpmYOBcmSP++POvWHPHJ0CCHiVWCpESCwJ+WXPE
 +p7JVBxODu11km8vKS2w4NPfKJHjYwNlNy8TAPYP3Rim6H8b40JAUP/+4EqJ8NmTLDb6
 H8NiBNVJ9TZkgRf0jwVyzVwJH8COyBInGMR8R+OoMPkJClZ8Nvps2GAE1/lOEwpTvOLZ
 a2swp4thUN8u8u0B4xArlxdA6OaItLgzY2ckzJo6PF12yx0fV4Vb95hd2Eiy0bSAeeOq
 hGGsWDKN5AkVzg7dR7OEYNbZVRiy//b6G8Zvtb7Y43Is9kxpGHFSEwuhJTnHIMTvMhqa
 rz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608989; x=1765213789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B9wYFs0q3JxF/bOnYDa4IQCdl79iH0yJQGUrHUEMM+U=;
 b=ShypmyU9sX+FsONdfXeZ0ddlA3LafiFB6z6rq/6HGFOgk5i9GqD+AMGbZMTQCIoA6a
 nARBupVUkmDfEeAqNR1bm/26RyZ/b3pzNhcwXYVIb6sEgvh0nYP4ySdPuMBNF4v1d8gH
 Kw9bFD9G9f4XPftdqUYa17/F9W5WZ586ppkk61OlJOx3sKRjQ3XCnuDJRJC566Cgpsbi
 P3SPl5phghGne0y4zAHh0hRIxYv8wh5qU69MPGlPcDObVJ1rXQi7nwGopoXiNwZjVl90
 hlFCyQcZh8vYZOw3KeSMt5WP2hPKho5f3vLPz3uQG48I9URNURApwYOktcKWEAXPcTXH
 ABaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU55zW3M5/p/yaVcp1DRbhXVT/1Bca3kN3GztPbSSXvi06Ltm9h/3drh5Yb+5Mz78DOiE8UsAc=@lists.denx.de
X-Gm-Message-State: AOJu0YwY7/R0kqvmHITTCdJ9y19LlSUTpvKkfBb3espRwm4M0aBJts77
 nzR0tC0ItH1padOUJ6AQArwP1qbR0H16MbUbLsY2mvUUzTMhtguIus0/HR0p5mTTDqNkndSu6y7
 1LPB/Z9Yg1xOgDREPJ9sPgJREyFHNNVk=
X-Gm-Gg: ASbGncsf1RCDRxlIerb1oqx/uz/cld6o0oDQR4ltg4HJ1GHQZUDXy9ry9pGqcthI8g7
 stl/dKay6gRDMFEYC7/h1wNpaOTTo+uFzwFmDRai+PPapL63dRo6WeFtAD0CA1RE1nvtB9lPVUc
 zY2FZKjdTk9FdE+h/Se+eOtL1ZTR8BL6o4K0FncqcChyp2dJDEjcg63aj5bRm0n/ArWE02RHLKz
 4bgC1zU4hZ7GQNdYN3QDr11osVmgwwfW9O20ZcUgTL9lqNqOcdGoI9p3X0kch5CBWv/bw==
X-Google-Smtp-Source: AGHT+IEUHJ5f9TnSelktYTX8afDwcWYwxURQP9EZNfYQ9TH+QuBY1k8A9bJnVJfvzrZZxbs37sDvnUgh18Sur6B9pEI=
X-Received: by 2002:a05:6402:1442:b0:640:ae02:d7cc with SMTP id
 4fb4d7f45d1cf-64555b858f3mr40468538a12.3.1764608988879; Mon, 01 Dec 2025
 09:09:48 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
 <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
 <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
 <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
 <99ACD06BACB0AD72+efbd4b3a-db5a-4a83-97c5-c1df635385ff@radxa.com>
 <CANAwSgSc1AgkXUkEWHqKgWbOa4djL051mLh4J23m+mkVopRQdQ@mail.gmail.com>
 <a9a4deea-4f53-4103-97f9-32d96177c6e1@cherry.de>
In-Reply-To: <a9a4deea-4f53-4103-97f9-32d96177c6e1@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 1 Dec 2025 22:39:31 +0530
X-Gm-Features: AWmQ_blycBVa3dOsz6NU5TAsZCwtfHCza7jbcae0EFpLEz9nwFxT8OCVaDphnOw
Message-ID: <CANAwSgR0cX8nkUMx6ubHjsLgrV95MMHeqMaUqGGgXgUhd77VBA@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>
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

Hi Quentin/ FUKAUMI,

On Mon, 1 Dec 2025 at 16:12, Quentin Schulz <quentin.schulz@cherry.de> wrot=
e:
> > U-Boot TPL 2025.10-1 (Oct 31 2025 - 11:12:15)
> > lpddr4_set_rate: change freq to 400MHz 0, 1
> > Channel 0: LPDDR4, 400MHz
> > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Si=
ze=3D2048MB
> > Channel 1: LPDDR4, 400MHz
> > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Si=
ze=3D2048MB
> > 256B stride
> > lpddr4_set_rate: change freq to 800MHz 1, 0
> > Trying to boot from BOOTROM
> > Returning to boot ROM...
> >
> > U-Boot SPL 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
> > Trying to boot from MMC1
>
> I believe this means you booted from eMMC. (MMC2 should be SD card as
> far as I remember)
>
> When you boot from SPI flash, you should see "Trying to boot from SPI"
> first, if it fails then it'll try to boot from eMMC and then SD card.
> This is due to
>
> u-boot,spl-boot-order =3D "same-as-spl", &sdhci, &sdmmc;
>
> in arch/arm/dts/rk3399-u-boot.dtsi + SPL_SPI* symbols in your .config.
>
> > ## Checking hash(es) for config config-1 ... OK
> > ## Checking hash(es) for Image atf-1 ... sha256+ OK
> > ## Checking hash(es) for Image u-boot ... sha256+ OK
> > ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> > ## Checking hash(es) for Image atf-2 ... sha256+ OK
> > ## Checking hash(es) for Image atf-3 ... sha256+ OK
> > ## Checking hash(es) for Image atf-4 ... sha256+ OK
> > load_simple_fit: Skip load 'atf-5': image size is 0!
> >
> >
> > U-Boot 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
> >
> > SoC: Rockchip rk3399
> > Reset cause: POR
> > Model: Radxa ROCK Pi 4A
> > DRAM:  4 GiB (total 3.9 GiB)
> > PMIC:  RK808
> >
> > You see, I could not control the UART with the key pressed.
>
> Because you don't have the audio-supply patch for this U-Boot maybe? Or
> you didn't actually flash your newly compiled U-Boot on the device this
> U-Boot loads from.
>
My board=E2=80=99s SPI flash is running an outdated firmware that lacks the
auto-supply patch.
which results in the UART console being locked

Thank you for your support and guidance. I understand that this
process is tedious
and challenging to resolve. I will continue debugging the kernel to
enable erasing
the SPI flash.

I have a working development board available for testing and development.
regardless of the SPI flash status.

Please allow me some time to debug this issue.
If I find a solution, I will share the details.

> Cheers,
> Quentin

Thanks
-Anand
