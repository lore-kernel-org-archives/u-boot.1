Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D37CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75362845AB;
	Fri, 28 Nov 2025 15:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CL9fk8Zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C26845B3; Fri, 28 Nov 2025 15:46:45 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6A2845A9
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-640e9f5951aso4129543a12.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764341202; x=1764946002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7TkFweHk8HJUWiR7JA5/2AIJvZX4OkZIrn+gz5a+TM=;
 b=CL9fk8ZbGoHqPq7p0Eosszw6h6eVyTaP90qrII9cIIM/VAvnKU7J3K+rU+U+A7faHw
 g8O2sXULyP5IjuYoIHXoGUZol6NKPw+m442Hj6ojnLD7EAc0dJEZMtGn6vAKH2tbWCfX
 qul2U0297V9QwHoe+T6xhpVjiAWwREsdq6mFxt+ah8sbmEuWfjU9HfHeHJs4Ve+plJ/w
 lV8ZkfyXwbPQgt5urt38QMqFWne7L/MsALnch88fOuG8dS2a/zXHNBe2AE26JdZqfMt+
 C9CM+YpMeImJ1KEMb7tMIppu0rwPebwFZvVsEUBs7083bs+dznS7m6RcIZMWmYBLWwNH
 rlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764341202; x=1764946002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7TkFweHk8HJUWiR7JA5/2AIJvZX4OkZIrn+gz5a+TM=;
 b=bPod4WYgS4Pk8I0SsK+T8QZ0FXD0UTw2nPZOolatXZYc7DIeTUzAi3xUbmW9AoW9/0
 M3RV0qdE8NDc4JmvWpA1EAres8YkJGx0VrHNZA/AyLMSC7ABBx7w8bgey9UYRbiSbS2Y
 AOGllVGpy05J1FPT9HaLK92WCGLzZaEysHFlOR+zviPdctYnFwhyr8sJgeIlRrVHshUY
 RnIIhR1IjcyePvUMuKBCH8aFoQTvhiFAFu46rKvlMSUfoVKP+fl4PjgbMZVX/DzWntHA
 SZOv7ZU0ddZOsMQJRk0CDECc7d8NPNrXSmx/tU+klt7IaOOl21lO9LtkDzzYLOM32fpz
 ubBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSAJd/daX62dMIZ4uNN5fH5i2hAb0DwKHDdktxcmtoe1XrJCS+rP60ucctoQvZtmvCmlADjI=@lists.denx.de
X-Gm-Message-State: AOJu0YzPoVlb+FjzwfCkA9CnXyRBtBCGEuN5jk6KktMgQvTlrPASrKLr
 A5OhbRaACgdPwOMM62iVyfXzaLJ09YNSJcbn7Jq7u897h29FHJWUFOOeKe6eGscHvL9IV2IJVMS
 EdTShDfvdqDqW5gA7eKGszp04Mpp1m4s=
X-Gm-Gg: ASbGnct6zYgrrHyGcbJeoypNe7TMpZ8XdsSouEu+FyiMRVRoPPsNsDCJfCm5+26W1IT
 VErnY6vZQVLbU9aTGZXbeHOBYEGaSBl4+eCLo1D1oO1Ps7iJE891QX6IwNouS77mqv6qgLKlScr
 21cpWNjoptNB3Jcb2eIteyc1SPs8OQm/qM3Tk4I1QdcGimGRDMllZ75gC+PUlx0Ij0vge1Fx8Yh
 a/tSorgJAeIbqXhxnOVVYVXojh/vOcGybDPc/eDLsyDoogrdTj8fh1URX98zDju2Z6ntw==
X-Google-Smtp-Source: AGHT+IEcqRIlNBOWw9ur5XLzpp5lCDMxRnqHTeg+VEyxLbV6PRoqcuWCqKRkcXE+o+Pxawb4lJ/PwlZhlmRbEp+H7d0=
X-Received: by 2002:a05:6402:2109:b0:641:270:2c8a with SMTP id
 4fb4d7f45d1cf-645550d6130mr29523124a12.14.1764341202089; Fri, 28 Nov 2025
 06:46:42 -0800 (PST)
MIME-Version: 1.0
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <3a22faec-320c-4ffa-976c-2c0d8207d267@cherry.de>
In-Reply-To: <3a22faec-320c-4ffa-976c-2c0d8207d267@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 28 Nov 2025 20:16:25 +0530
X-Gm-Features: AWmQ_bk8HWrIkNEuuZcKwPwjAXtCOLBiFIvBzRgOI1Ik-POq2d2s383xpkFp_QQ
Message-ID: <CANAwSgTWKJ1qGoOepnZMVDpauwhzXrigH4UxxCwkkmKLXiS-Qw@mail.gmail.com>
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Fri, 28 Nov 2025 at 15:41, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 11/28/25 6:50 AM, Anand Moon wrote:
> > Hi Heinrich,
> >
> >>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
> >>>
> >>> But I am booting from SPI flash, so I cannot stop this board in the
> >>> U-Boot prompt.
> >>>
> >>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
> >>> in the user space to spi flash? using dd coammnd
> >>>
> >>>   From the schematics, it has W25Q64FWZPIG
> >>>
> >>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
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
> > Could you provide the SPI details for this board so I can map it in driver code
> > and from userspace and then attempt to erase or reflash the image?
> >
> > on my board
> > [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> > [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff
>
> I believe this just means that you have improperly set up the SPI
> controller, pinconf or whatnot and that it returns always the same thing?
>
> > [    1.285967] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
> >
> >> Set the jumper as shown in the picture to boot from SD-card.
> >> Once booted remove the jumper to erase or update the SPI flash from U-Boot.
> >>
> > This board does not return to the U-Boot prompt.
>
> If you write U-Boot (u-boot-rockchip.bin) at the proper address (block
> 64, or 32KiB if you prefer) on an SD card, insert that into the board's
> SD card slot and make sure the SPI flash cannot be accessed and then
> power the board, then you should be able to boot into the U-Boot on the
> SD card. The process documented by Radxa to render the SPI flash
> non-operational seems to be grounding the SPI clock pin via the headers.
> Once you've booted into U-boot on the SD card, don't forget to remove
> the "short-circuit" contraption otherwise you won't be able to access
> the SPI flash.
>
I have already tried these things, and I have checked  the pinctls
and configured correctly.

With the SPI boot, it will scan for all the bootable devices
like SD card or eMMC or NVMe, and it will boot from these modules.
But in my case, the SPI boot is fine, but without returning the U-Boot prompt
it's not responding to the keyboard keys.

I have checked the U-Boot source for Winbond flash ID
and tried to configure the missing w25q64 ID, but it's not getting
detected in userspace.

> > So I cannot debug this further.
> >
>
> I would really recommend getting familiar with this process as if you
> flash a broken U-Boot on a non-removable storage medium and you don't
> know how to make the board NOT boot from it you'll have a bricked device.

Since it boots to the userspace, my best option is to erase the flash.
>
> Cheers,
> Quentin
Thanks
-Anand
