Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D432DCFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 07:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1A88334F;
	Sat, 29 Nov 2025 08:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5eqkF9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CB583642; Sat, 29 Nov 2025 08:25:53 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 624B18307F
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 08:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64149f78c0dso3864015a12.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 23:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764401151; x=1765005951; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whZG+Pxid5+29EC7i7CPvWs1CnUwAsQCb7AvELkptjE=;
 b=H5eqkF9DYg9kSUIdPJtEHqr0yj31t0NDbjjBFU99rljLFcUda4TKmLkksPhIjsM9nb
 EPa7SrJUr1yIiFK05lQMIGwCAPC1hNYwAFP7y7TTkzgoCfZ2NbXN0Rol2181itnKdlC3
 Ki6qRo/fyafySnzps8uM4+y7/4onWu/SCtSDIQojGXjmzAqr9sVwQEz+iRnsVPW0I1ci
 ejKgPsr9ReqSn+1PRdrN/8hPNCHWmIUKBtblM0ULWu36hTHVG3wUES6zoixbT3opYlX8
 psaEpqumOZ1/p0kOyP+J/bmcUGs6M1238ZXhVBPHn5EfqGqZksKpyJDxJJTygB42OJNr
 ynzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764401151; x=1765005951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=whZG+Pxid5+29EC7i7CPvWs1CnUwAsQCb7AvELkptjE=;
 b=onVEuFe38puLl09uM7jwNvGT9K84xBqW5jWsRg24yw4Dbqy0PGDPUFUwIgkcIosCEa
 GbXYyxSeZfrWK6PysJKVj7NGyR+VATV+Z1i0aNA1570nxEoy0rIjcsB0EpouecURhY2j
 itkuh//BWxCYmXRMCT+BGEApaWTUZ1MHRO0t5uj9LDiY2fkrpgy3boWeFPgpVQBrXiim
 zMf771a76QgoAYpd0m6yo6KuMd/877lZQIBsnV5k1TyHXcyjNuuaGxRQwXNaYpHeDBGm
 UIDp3r7nikEL+jmgp/1HTnKK9j4zydklU2fFTF10JLyGng0lF2DCNH2DmmmLEqilA+KG
 86OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTe+TPpwC0hu0SU6kIp2iBy74M7WNM1rPHTe/slDxFGEF6NOPeqw2sZqsZYe7KyQ4UfRvz1FI=@lists.denx.de
X-Gm-Message-State: AOJu0YxHGHMGi8gcxSlm1abBeUVXTfzaZEQgQRwhgZ11bSbgxd9k79Gf
 9SJNXpR0DV1MxNiLZw5hLpwGf+4osU0YjlLYT8OK/kBCsCz35kvliXg4O5kz+MCukmGU54C9jEn
 M7ACIz3asoL7Ru3w1l3XrVTjrNYThKx0=
X-Gm-Gg: ASbGncsvYFSJZuzF/X4Qx3Celb/32vMW1hSoVcVBOiohNIdsYYl9V6eG11mp4GkTi2i
 Vw4EQjN3Uh4At/QDyW5HNldpUKTTeoMjluPjIbcy1ooNStpshoaEbf3HkD1ct76iIWOXM2/JhU6
 eDcPK2/lKgH5PU3xF19oKY7S/sndkgmbplquM0SGxDORcSUdoQvrSAxfhEjrBvR7abfMDYjzVTD
 nJtPH8i3w/VZGZGIsTSdl2yPsaEkpXvycXG+oVbOzADBx2ojx9TTgBGcZ3JXsFkdxMoZg==
X-Google-Smtp-Source: AGHT+IGL4sCvCwVMcL6UPjz/+hs3oH47MfwJOhKOrRAkVdP14QSKVc9ml1abyHAclGjk+Rc6ZJ1fVcQnajpZgNvE6WY=
X-Received: by 2002:a05:6402:518a:b0:640:b7f1:1cc8 with SMTP id
 4fb4d7f45d1cf-64555cd8e27mr28207603a12.18.1764401150488; Fri, 28 Nov 2025
 23:25:50 -0800 (PST)
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
In-Reply-To: <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 29 Nov 2025 12:55:33 +0530
X-Gm-Features: AWmQ_bmfTFCnUcRmp098wbVyaZW7Zv5iGwU9EF9bHIljXMCoY_7nhAwA8dGaf8o
Message-ID: <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi FUKAUMI,

On Sat, 29 Nov 2025 at 10:09, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> Hi Anand,
>
> On 11/28/25 14:50, Anand Moon wrote:
> > Hi Heinrich,
> >
> >>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
> >>>
> >>> But I am booting from SPI flash, so I cannot stop this board in the
> >>> U-Boot prompt.
> >>>
> >>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin=
 image
> >>> in the user space to spi flash? using dd coammnd
> >>>
> >>>   From the schematics, it has W25Q64FWZPIG
> >>>
> >>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_2018=
1112.pdf
> >>>
> >>> I have tried to enable SPI flash, but it is not getting detected on
> >>> the board in userspace.
> >>
> >>
> >> https://wiki2.radxa.com/Rockpi4/dev/usb-install
> >> has some guidance how to avoid booting from SPI NOR flash.
> >>
> > Thanks for your tip.
> >
> > I've attempted this method, but it hasn't worked for me.
> > Could you provide the SPI details for this board so I can map it in dri=
ver code
> > and from userspace and then attempt to erase or reflash the image?
> >
> > on my board
> > [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> > [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff=
 ff ff
>
> Are you using dts with "audio-supply =3D <&vcc_3v0>;"? It should fix SPI =
too.
>
Thanks for your tip.

I have applied the patch from FUKAUMI, and now my console output has
started working

> 1. Make u-boot-rockchip.bin with "audio-supply =3D <&vcc_3v0>;"
> 2. Write it to microSD card
> 3. Insert it
> 4. Kill SPI flash
> 5. Boot U-Boot from SD card
> 6. Revert 4.
> 7. Try "sf probe" "sf erase"
>
Yes, I have tried these steps (4 Kill SPI flash) ->
I have shortened the SPI1_CLK and GNG in the GPIO header
But this board first boots from SPI flash, I don't know the reason.

I noticed your patch references the W25Q128.
Did you get this device detection in userspace?

This output is from your patch.
=3D> led blue:status off
=3D> sf probe
SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total 16 M=
iB
=3D> led blue:status on
=3D> sf probe
jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
Failed to initialize SPI flash at 1:0 (error -2)

Could this explain why I=E2=80=99m unable to detect the device from userspa=
ce?

> Best regards,
>
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
>
Thanks
-Anand
