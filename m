Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62074CD5BCB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 07:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855608405A;
	Mon, 25 May 2026 09:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="BTjXpI/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E8DD844CF; Mon, 25 May 2026 09:57:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC0AA8404D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 09:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so1085253466b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 00:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779695841; cv=none;
 d=google.com; s=arc-20240605;
 b=UNxhEMuHeaX8s29HQWOOp4MwBrlZEpcj6XMjtElNCHFF5RLB+u3ZYrfmjFjDRDmMVv
 u5RSiWJl9uD93lTLqWO6xqpkKgIKS+8/j0RScwoDlso+72dwnriNDwORzCHGesSvKQwF
 hxMI5G3S4a7NVOXTsTJcNhc7+ZqEp4mIHz57pMOJniTPVnBvjwE32SSmMy6ztYHTzpkY
 O8hB2FTnlevL7bZpv/UpyAKy9UGGW972qzuu3NRzls1dmeb8Q1wsO85pOJ4q55VcHOqb
 47X+SJeGKxuuAuI4KqXtMxICPwd5VqluOL4SKDWe2Df9v1j73BOkkGZbNVqqbuT+MOQf
 IdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AicIq+X9o3dk170w3ZM2ed7Lwv18DGUKXgCchQIpDXQ=;
 fh=0/gvq/+QaS3VrydjSvrrwUZQBls0jUtJOwnAzRn6Od4=;
 b=lNdoyhYXyGONjsqAeODA1ii/GjH/EgwiQYdRKgfhRpdCn2CHSuH3CqSCs6ihatTGF8
 xtzCbxEwzRAMWqC+wrSg8LqhGAR7Va0Eqzh2GDSVXvx9fVmClqqgzk1URAqjlAd/3YDJ
 2gRMHCGYx1n7+v8UIneQiropQ5NvvdIvcu+KJuHAv9w7rRF5KGNP/TfGrwZMvHEl3AIs
 WX+ez7FmWYhqNyMfNkJNCDOL0kbvxLgPhp4eKiUlfll4OrUborOE78lxF5UEITa/QZd0
 GRcCUpCMiMDmCxbgFHaxjXaRiSC9ENIyWDV0c6fhD1uQkBPunSNWNMeF2pEP3bTvzAKr
 YPRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1779695841; x=1780300641; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AicIq+X9o3dk170w3ZM2ed7Lwv18DGUKXgCchQIpDXQ=;
 b=BTjXpI/x70OT3YqO/Rui6HFJmiLlDz6HqZHzGNJavb8Q6esBb61V/TgdsnbHaIQUO7
 STl4IQt3z4YbrZG/ssWTB06/gR4m/35GUqldOkknCtwdYyKar7h/oa4aIVCNFqEQl+yv
 rAurDpympLCy824/f+qzRUhdLBO9EaOBOYVm0xAIIW9y0N9QXRUfuYjd9MrgN+s/0/+k
 vktd/CRaZSBahDqu87PuTf+rL0nPNdinDACELgCWfRtjJrzmrZYmxfiN5xt+6+DotlW8
 aIHqoHswZ50G/GOBislfUE5nK3f140Swar/tqkcC/3/9en4kOsy7dFSEoXLvPxF3y1cb
 6XaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779695841; x=1780300641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AicIq+X9o3dk170w3ZM2ed7Lwv18DGUKXgCchQIpDXQ=;
 b=Wd1zV0OnrCTG4Rq1yS+6J6VPrqnToGukBcLov3a2wguHMvqC7WylFrf08XFt4UxeFm
 zxzku/I6mtF665m5Knsq4/xMDaF9mBuR9CasB1JhqHbZupNhXiPPsf17KzEvy7/XS/jI
 eYMGUHNjjZPrfcrnqKDBY70j5s5vB+1f9n6BB1q5UNCt21DIVmnVM/Ph2jo/CFoH8xcc
 oMR4Kt+ufTDYpfOXFItJ+S3xXoAIcI9NcLXyOVskDB+H7v0z6a6bHzRLVqTkR6Q8kKPQ
 dTYwCEWpxKEIJvZx0rl+cyaAFqCHZ7bPto1cJc+Qy8oOofZGGQd55T3wXVFr042zsdHs
 jrwQ==
X-Gm-Message-State: AOJu0YyufAE+LXuO6170u8t5ixmkWYWnQH3SvdbNdigpTkqC5/TaC3NZ
 vyT2aY3VKzBCnVoaeZfhRwbSfkalmSp1XSLR0EpzdHTiDQ8Z2q0ZE1Fq8OjfrHubKzxacyT4Zv2
 qR8Bky0+NEJ3ufdZA63U4NcmIj4a3Mh5EhUYZXvCspt1T32MmQ5cFkAmP0WXi
X-Gm-Gg: Acq92OHP1y1IJT9AJiR+fBddZ2FQY5cq9EObn2U0WBHBcsiFPJ61bkrPYQrIOuIrEsk
 XvKDcFQ95CeS62TBBgKQa5Yq5SyYGl9457ZfIyl/ddBjCfOAptsAE784IbyAiH3+bqOeY8prsA6
 M1jyv3Z+cwoE2Rpl+jFcnEO8v8pwpoD3yzMCctMcD61rsnaZob7+4+VU/p/+58wSWwppfO+XRQ6
 OWae46p0luQ94z+YUMnzT6vhYdrzS9R9Pi0UhRdR6euCQqIPvdlXMeLan3wPAlPKx3VLbK8tTgY
 EY65/DHWfKrPuyEXaFb8qslExU1rzLmG+G3E5RumCEc3YvUD7Yk=
X-Received: by 2002:a17:907:3e03:b0:bd8:6ac6:d722 with SMTP id
 a640c23a62f3a-bdd25cecef9mr741589266b.24.1779695841058; Mon, 25 May 2026
 00:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
 <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
In-Reply-To: <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 25 May 2026 11:57:15 +0400
X-Gm-Features: AVHnY4IV16F0SyifIACNvkN6mPZD3j9wILSk89QPVsC6u49sL0sJh58-BHpMMRs
Message-ID: <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
Subject: Re: Friendlyelec NanoPi M5
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Sat, May 23, 2026 at 4:41=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Alexey,
>
> On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net> wrote:
> >
> > Hi Simon,
> >
> > On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi,
> > >
> > > I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> > > mainline. I found the note about needing a workaround so have tried
> > > kwiboo/rk3576 at
> > >
> > > https://github.com/Kwiboo/u-boot-rockchip.git
> > >
> > > I am building like this:
> > >
> > > $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736=
MHz_v1.09.bin
> > > BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> > > nanopi-m5-rk3576
> >
> > FWIW, upstream TF-A master branch works well as BL31 on RK3576, though
> > it's most probably unrelated to the issue you're seeing
>
> OK, thanks.
>
> >
> > > Image 'simple-bin' is missing optional external blobs but is still
> > > functional: tee-os
> > >
> > > /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> > >    See the documentation for your board. You may need to build Open P=
ortable
> > >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/=
to/tee.bin
> > >
> > > Image 'simple-bin-spi' is missing optional external blobs but is stil=
l
> > > functional: tee-os
> > >
> > > /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
> > >    See the documentation for your board. You may need to build Open P=
ortable
> > >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/=
to/tee.bin
> > >
> > > $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/sda s=
eek=3D64
> > > 18579+0 records in
> > > 18579+0 records out
> > > 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
> > >
> > > I get no serial output at all booting from SD card. Is there a specia=
l
> > > trick I am missing? I have confirmed that the Alpine Linux image work=
s
> > > OK.
> >
> > Dumb question: did you flip the switch on the back side of the board
> > from FSPI1 to UFS/SD?
>
> Yes it is set to UFS/SC.
> >
> > If yes, then having no serial output at all most likely means the
> > boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
> > trainer unconditionally spits out some logs on the debug UART during
> > early init.
> >
> > The SD card might also be finicky, so if you happen to have an SPI
> > flash equipped board then you can flash U-boot there instead via
> > Maskrom. Just remove all other storage, connect a USB A-A cable to the
> > top USB 3.0 port, and power it up while holding the maskrom button.
>
> I am not sure how to power the board other than through the
> >
> > Then:
> > rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
> > # note the zero below, because u-boot-rockchip-spi.bin already has a
> > 64-sector offset baked in, unlike u-boot-rockchip.bin:
> > rockusb write-file 0 u-boot-rockchip-spi.bin
> > rockusb reset-device
>
> With this I was able to get it to SPL:
>
> DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
> In
> ch0 ttot6
> ch1 ttot6
> ch0 ttot7
> LPDDR5, 2736MHz
> channel[0] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=
=3D1536MB
> ch1 ttot7
> channel[1] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=
=3D1536MB
> Manufacturer ID:0xff
> CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
> DQ roc:
> p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
> p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,
>
> DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
> DQS roc: p2, n0, p1, n0
>
> CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
> DQ roc:
> p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
> p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,
>
> DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
> DQS roc: p2, n0, p2, n0
>
> stride=3D0x3, ddr_config=3D0x2
> hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
> change to F1: 534MHz
> ch0 ttot6
> ch1 ttot6
> change to F2: 1320MHz
> ch0 ttot8
> ch1 ttot8
> change to F3: 1968MHz
> ch0 ttot6
> ch1 ttot6
> change to F0: 2736MHz
> ch0 ttot7
> ch1 ttot7
> out
>
> U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -0600)
> Trying to boot from MMC1
> Card did not respond to voltage select! : -110
> spl: mmc init failed with error: -95
> Error: -95
> SPL: Unsupported Boot Device!
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
>
>
> It seems to boot from SPI but then try to switch to MMC?

Sifting through my local tree I also noticed I've got the following
patch to set the pin config for SPI flash on NanoPi M5:

https://github.com/flipperdevices/u-boot/commit/ffb0d6c9b4893d6a8c2fe51efc3=
dd5914857615e

Would you mind giving it a try?

The node itself and its properties are already in the upstream DTS, so
it _shouldn't_ really be required, but maybe the bootph-* markers
didn't propagate for me as-is and I didn't have the willpower to
investigate further :)

> I also found that if I 'dd if=3D/tmp/image of=3D/dev/sda count=3D2000' fr=
om
> the good Alpine image, it ends up in the U-Boot I built (although of
> course I have not built the earlier parts).

Another way to get it to boot without relying on a particular storage
configuration or the prebuilt image is to load an upstream binary
directly to RAM over Maskrom:

export BL31=3D[...] ROCKCHIP_TPL=3D[...]
make nanopi-m5-rk3576_defconfig rockchip-ramboot.config
make -j$(nproc)
rockusb download-sram u-boot-rockchip-usb471.bin
rockusb download-ddr u-boot-rockchip-usb472.bin

SPI boot is supposed to work fine though. Did you use the
u-boot-rockchip-spi.bin or u-boot-rockchip.bin image?

> > Loader binary can be assembled from rkbin blobs, or alternatively
> > taken from e.g. here:
> > https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb599642064ee=
7c23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc3691b=
5022abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.100.b=
in
> >
> > rockusb tool: cargo install rockusb --example rockusb --features=3Dnusb
>
> Thanks very much for taking the time to help with this!

Always welcome!

Best regards,
Alexey
