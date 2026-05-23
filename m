Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FA6CD5BB8
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 00:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DA88490B;
	Sat, 23 May 2026 02:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hmBW71Pa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDB984910; Sat, 23 May 2026 02:41:58 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1292848D8
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso9994350a12.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779496915; cv=none;
 d=google.com; s=arc-20240605;
 b=D/0CZpbdfHxE/xKVTQYK6l0zEqkaLpsEU1Bbnzi1+CMWWHYMY3qSjbLrJEBSxqVK3F
 3TU+pCnLEig7GEvADAGeKg+95ZMSwQIlYrQIbWOps51PUmUiGhkDGNpi3fPcv4gsH+72
 UeoJDgEionoj/vHkS0L+JxmFMnEPSR3qJgmyYM0ZSSf3R8p7A8OTjOzF3O73WOwspwhn
 9Z5bAMJDRMWagF3Qp2dzv2Ah6UHkZsqk/y8tj+6WqE4Sl++bxR1lDLq27z62z1xsX4Ul
 ttOn0pGiJp+N8QepnLYC0A4G+KmGzJqnwM6XfGP5GmERPYgCnLxAoGqOcR8KIdtojY5Z
 dSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dI4fa3eVWdBwJILM2dEZVxiielEn/hCKPEtfV/Rl7lw=;
 fh=ksQqmowkkarc3zcrsZt9IUF3LDcRTEMb98ggMhbcpuA=;
 b=IKHjyZZc8xmEaTUsIwYD8fy5ul2FJEeVh4kthgMEIhFMIPpIjUc65rd41clujihz7e
 OQrTXgwS9vTdRVFi/mQzPs+sx5fy+q5My3pv4FmsHpuqVtK5xg8JG0hZqDv5HuKY8cBP
 P/U7MavuCUWnWR2qwINJIGJEe6gSMQb8gMysN6G7+4VCx5T673XKCyC3ZzU2yo/+Vmvr
 yp7XkRijtDQ6r2E9DBeRa7pxYOr3dJA96jNyr4LACZtSsA3HoBdN1BHIVvxybO5OYNYK
 UtgJ+DN+Wr7zJQZfGOrnxwDQyYhrdvH2glCDNStcWUveNhhriYD72K9LhQAqYp+nzNzF
 XMCw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779496915; x=1780101715; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dI4fa3eVWdBwJILM2dEZVxiielEn/hCKPEtfV/Rl7lw=;
 b=hmBW71PaADFfVXV67MZlGht3ex04B0y6Lkk38bxVuUaMwxsc/K/A/6XuABvp1IP7wd
 Ltmg1ILazJQyDQ8WGTYc07SSmzlhitHi7Mf67tyE11iaBZJcKiHcTQQpcIDYgUbd09nb
 wLVe4LmA+tkZUJv0Z2HXH8JDruhlWCegS0VnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779496915; x=1780101715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dI4fa3eVWdBwJILM2dEZVxiielEn/hCKPEtfV/Rl7lw=;
 b=rSkpLCUXtwOXa+bHz6Ru3/9ul38NsP49VRA8hEsaBucI/LhBZP9t52CuGh7RJ4lkD2
 WctSaOJER8cJBxCN9FHDqv9+TcDiNcT9nSWpf/t/qy+AOn0aQqqhZ75cFlukgBlNwwzR
 MjsRZL2cVMnfGtWllNOl3aNDUMBps8v25OGH4wVRRcR34WmdZiHq2k31hu5L3TJI654D
 GwDF9Ms3YkssYz/URxGdL2avgpcMe6hv7h5RNd2PQQELuNeGh/pIVpN4kXW18ZPXCmzl
 JIX/P2m2S5IGOZYR0iXxUHBqMewzCnoy2idReEDCy8oG0IDv5vYMjKw8v5SGrrcf0oQK
 iy4A==
X-Gm-Message-State: AOJu0Yxxal7LHNJTc1xh9fmNiS8RgQ8uPjquxi/Jv7z7e3XN9zXnPrTQ
 noaRRV+pOMybk3fxCVFCKARS4huiH0KnMEZ1uBQlXYVNX66P5Bf1FlyuOkW9hDcncq5AJ2EQAfg
 YSblV7Z9jdQqX8SGPakqnzK8CArZQJ8ac3G+xeHJpt45ruLmdLlYmzg==
X-Gm-Gg: Acq92OG1Zf6hSi0JpaWBzTt8Q1ofTBT+GpGhELCyTKY4GVMGyoVndG6TwJxshgRbz1u
 untvMxIgss6tBo9jWfItQ9eAoJ+7IlJXIum0rEzVsbnmK2MZ48pwFA55FfSKbxVNA0EUvihzFcy
 spkZPP2Xs0F3/qZont+V2tONf+yLBGxmBhq6nxi1xE/OUxVo4dm8X9ai5i2ETgESd9FmEieCcnN
 wEN/NU9+AF4t14MMaq3KcnrzqkhVIWor6pkXDnLpfF9PSIwAAUEFl8rPwCixLtsppbutZRnRFmB
 JfOo9X0v9A3K9DWg
X-Received: by 2002:a17:907:c706:b0:bd2:633a:c8bb with SMTP id
 a640c23a62f3a-bdd263c9447mr362306066b.22.1779496915092; Fri, 22 May 2026
 17:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
In-Reply-To: <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 May 2026 18:41:43 -0600
X-Gm-Features: AVHnY4KTG5t5_aqSKA1AHAHs3Y_qzb66t581qQE9w0Ex4iydkmW8Yko67Q8SZr8
Message-ID: <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
Subject: Re: Friendlyelec NanoPi M5
To: Alexey Charkov <alchark@flipper.net>
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

Hi Alexey,

On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Simon,
>
> On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> > mainline. I found the note about needing a workaround so have tried
> > kwiboo/rk3576 at
> >
> > https://github.com/Kwiboo/u-boot-rockchip.git
> >
> > I am building like this:
> >
> > $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MH=
z_v1.09.bin
> > BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> > nanopi-m5-rk3576
>
> FWIW, upstream TF-A master branch works well as BL31 on RK3576, though
> it's most probably unrelated to the issue you're seeing

OK, thanks.

>
> > Image 'simple-bin' is missing optional external blobs but is still
> > functional: tee-os
> >
> > /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> >    See the documentation for your board. You may need to build Open Por=
table
> >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to=
/tee.bin
> >
> > Image 'simple-bin-spi' is missing optional external blobs but is still
> > functional: tee-os
> >
> > /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
> >    See the documentation for your board. You may need to build Open Por=
table
> >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to=
/tee.bin
> >
> > $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/sda see=
k=3D64
> > 18579+0 records in
> > 18579+0 records out
> > 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
> >
> > I get no serial output at all booting from SD card. Is there a special
> > trick I am missing? I have confirmed that the Alpine Linux image works
> > OK.
>
> Dumb question: did you flip the switch on the back side of the board
> from FSPI1 to UFS/SD?

Yes it is set to UFS/SC.
>
> If yes, then having no serial output at all most likely means the
> boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
> trainer unconditionally spits out some logs on the debug UART during
> early init.
>
> The SD card might also be finicky, so if you happen to have an SPI
> flash equipped board then you can flash U-boot there instead via
> Maskrom. Just remove all other storage, connect a USB A-A cable to the
> top USB 3.0 port, and power it up while holding the maskrom button.

I am not sure how to power the board other than through the
>
> Then:
> rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
> # note the zero below, because u-boot-rockchip-spi.bin already has a
> 64-sector offset baked in, unlike u-boot-rockchip.bin:
> rockusb write-file 0 u-boot-rockchip-spi.bin
> rockusb reset-device

With this I was able to get it to SPL:

DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
In
ch0 ttot6
ch1 ttot6
ch0 ttot7
LPDDR5, 2736MHz
channel[0] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D=
1536MB
ch1 ttot7
channel[1] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 Size=3D=
1536MB
Manufacturer ID:0xff
CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
DQ roc:
p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,

DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
DQS roc: p2, n0, p1, n0

CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
DQ roc:
p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,

DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
DQS roc: p2, n0, p2, n0

stride=3D0x3, ddr_config=3D0x2
hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
change to F1: 534MHz
ch0 ttot6
ch1 ttot6
change to F2: 1320MHz
ch0 ttot8
ch1 ttot8
change to F3: 1968MHz
ch0 ttot6
ch1 ttot6
change to F0: 2736MHz
ch0 ttot7
ch1 ttot7
out

U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -0600)
Trying to boot from MMC1
Card did not respond to voltage select! : -110
spl: mmc init failed with error: -95
Error: -95
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###


It seems to boot from SPI but then try to switch to MMC?

I also found that if I 'dd if=3D/tmp/image of=3D/dev/sda count=3D2000' from
the good Alpine image, it ends up in the U-Boot I built (although of
course I have not built the earlier parts).

>
> Loader binary can be assembled from rkbin blobs, or alternatively
> taken from e.g. here:
> https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb599642064ee7c=
23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc3691b50=
22abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.100.bin
>
> rockusb tool: cargo install rockusb --example rockusb --features=3Dnusb

Thanks very much for taking the time to help with this!

Regards,
Simon
