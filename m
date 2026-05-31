Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D27CD6E56
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 18:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACBC38039B;
	Sun, 31 May 2026 20:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L0p2w3gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60488838D7; Sun, 31 May 2026 20:26:04 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663F680077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 20:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso11946308a12.0
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 11:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780251961; cv=none;
 d=google.com; s=arc-20240605;
 b=YHnEf7DfJPz0AAJml4elotux/qpbecMWSk+706htmVn3QRmtdBFJ1Rf6N0XL9JpcV5
 T7COpouh8nTFtKknIEJQL3n/XYP9kx8r7QB7DnVPXrxci3M48KQfBd8QOa4MNtkjZK0X
 yCA2cyFGelBIMM2AiAUUsnnnLysHHybUxCfGMts6vJ0/vpxFu572aTmjeO98YP8i38TO
 TjdrcVApwR5Lj8KxMtvE9Lz0AI0bMV+vp9kyWoUjZsE8mYGvYfHfbuSmcwzVPzj0gWu+
 wqRifYMlnNzOP1xj9kvogUbg+gz0Jx7lLiPkuvJmSrbGXiOAcrH0oqrAnQz+lGopBO/o
 4gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9d1mb9C1NE6ha5nAzlKNCyjOsKFHngABQHyU+RHUqKI=;
 fh=ksQqmowkkarc3zcrsZt9IUF3LDcRTEMb98ggMhbcpuA=;
 b=YpkOk6Bfwb7vbbgAADHxwp6W+u6xZylshr+Vc7zt+7W7ou2rR4CDNHs2CdABC+Bn7L
 s2uFYcp8wYoobM+CxK983Zzh0ehmIwRD2vzCU/j75pVzArda33eGcA8SVPRKvc/4J9on
 qJYNJ+M+OIc5R/wP4ImT6OCvwiig3cSO/NK9MnNZNcrzkplfyMmiKaJzvBJPaAsqwak5
 WrnKXcCB0nyuX2DD/wxA8mqki3oxJFNMshXWN1U7kl7nGwp4VLW2Z72ibbJ61DABYt5f
 qin0PU22UQtsQ/ZZPOFw7J9XlgCYRwPTlFhKhUCX+VOlfdQfvk/QIagShLTcqcWCvKh4
 ugHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780251961; x=1780856761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d1mb9C1NE6ha5nAzlKNCyjOsKFHngABQHyU+RHUqKI=;
 b=L0p2w3gp6j6hBtcQ+4qPZS+GjtDMOWecTnHscC2arICJHAlwD0FYb5pDJnh4CoWhqJ
 mcYDOz7XscPoYc6ce/AJP12xlILdKrS8EKFsIX3X7TX5vFxhAXcL/CCaAxT/Z17giAB7
 cICk6o7ektP8ujt3sOaLl660QN62mJ0m4O240=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780251961; x=1780856761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9d1mb9C1NE6ha5nAzlKNCyjOsKFHngABQHyU+RHUqKI=;
 b=iXALjfXpapl2wplWO3hcQuVPAES7458chkZR4qMau7EqSpXONXG3nfrzLDYzG60SOZ
 1OBhtrv6L7HckZxaS2FFY8pV6cf5Hp3WSWAhfq5XNvdB9apFUH0nSegx3R/LgJ5/+7cc
 R6RvcS6WyGgrfh2DXs19p0BKfK1ZzYvbMFgussllo13z1Gk+LI1/Wq+4DgujH8naHSFb
 RwArAz8I0nXR4chdUiCKgANVRlpYD5FfPKyddsHrly6iDyq2qXuYG+jqNQu+oMTvWuV/
 bvqP952apnJXvqSDS1UCwsn3xlVd5g2n1D/slA+nE8+qR07FCsmTnNNyFZJK09sl+uKz
 0gqg==
X-Gm-Message-State: AOJu0YyhlKyA1jvlsnPWGeVyEk33LEbw9Gi5awNQR9La0HfSHmpSjkGK
 75KhophxHiHqJK6gYirU77E2nKuzJYJEtNaiTVVe5RchbSfXHNdCa3XyOQjlHjAtmDMohz0UcD5
 ZJdGGOXM37MCumYn6IpJo/w6bTtRsbLyIxfkXBhKK
X-Gm-Gg: Acq92OEWct5EZxdb0nb6EcZsCeJJpa9Y/PNPVNpqKwEKahpL/UAuvF8jWr3sE69cWQE
 Puo+Zvwb8lMQGLSTIz7hcOEdKtxvDGnMy0TH29txUUYf8Htto1MypNuAJc6VxGdwndNZ+yWj2E7
 429706MVQngeSfUYHDhs7ru85uNJRKmIWp/yMrfwuWt8ygfxYdW225X6vmk+oIlmGpvfIgT6lQm
 oiVA9NxfzbaqMtVCxol3X5NbhRFO/0HnViatzxjbsBvQ2bwa5cvwsPGk9BF0hl/9l/H+SbJhilR
 GnOGjDR8UVAsCmmr//BhIsR5LsU=
X-Received: by 2002:a17:907:c16:b0:beb:f357:7755 with SMTP id
 a640c23a62f3a-bebf3579814mr184758866b.12.1780251960585; Sun, 31 May 2026
 11:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
 <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
 <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
In-Reply-To: <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 May 2026 12:25:49 -0600
X-Gm-Features: AVHnY4L8696E3i7l3KcPuKX9wgF0j74a-a90gdDUyU4EqVnoXyqiB2km9fJABuU
Message-ID: <CAFLszTh+OvAH9Zz3dbfj8cu8AQ1trAvMc56oWPLrCi9MR93NxQ@mail.gmail.com>
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

On Mon, 25 May 2026 at 01:57, Alexey Charkov <alchark@flipper.net> wrote:
>
> On Sat, May 23, 2026 at 4:41=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Alexey,
> >
> > On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net> wrot=
e:
> > >
> > > Hi Simon,
> > >
> > > On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> > > > mainline. I found the note about needing a workaround so have tried
> > > > kwiboo/rk3576 at
> > > >
> > > > https://github.com/Kwiboo/u-boot-rockchip.git
> > > >
> > > > I am building like this:
> > > >
> > > > $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_27=
36MHz_v1.09.bin
> > > > BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> > > > nanopi-m5-rk3576
> > >
> > > FWIW, upstream TF-A master branch works well as BL31 on RK3576, thoug=
h
> > > it's most probably unrelated to the issue you're seeing
> >
> > OK, thanks.
> >
> > >
> > > > Image 'simple-bin' is missing optional external blobs but is still
> > > > functional: tee-os
> > > >
> > > > /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> > > >    See the documentation for your board. You may need to build Open=
 Portable
> > > >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/pat=
h/to/tee.bin
> > > >
> > > > Image 'simple-bin-spi' is missing optional external blobs but is st=
ill
> > > > functional: tee-os
> > > >
> > > > /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
> > > >    See the documentation for your board. You may need to build Open=
 Portable
> > > >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/pat=
h/to/tee.bin
> > > >
> > > > $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/sda=
 seek=3D64
> > > > 18579+0 records in
> > > > 18579+0 records out
> > > > 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
> > > >
> > > > I get no serial output at all booting from SD card. Is there a spec=
ial
> > > > trick I am missing? I have confirmed that the Alpine Linux image wo=
rks
> > > > OK.
> > >
> > > Dumb question: did you flip the switch on the back side of the board
> > > from FSPI1 to UFS/SD?
> >
> > Yes it is set to UFS/SC.
> > >
> > > If yes, then having no serial output at all most likely means the
> > > boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
> > > trainer unconditionally spits out some logs on the debug UART during
> > > early init.
> > >
> > > The SD card might also be finicky, so if you happen to have an SPI
> > > flash equipped board then you can flash U-boot there instead via
> > > Maskrom. Just remove all other storage, connect a USB A-A cable to th=
e
> > > top USB 3.0 port, and power it up while holding the maskrom button.
> >
> > I am not sure how to power the board other than through the
> > >
> > > Then:
> > > rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
> > > # note the zero below, because u-boot-rockchip-spi.bin already has a
> > > 64-sector offset baked in, unlike u-boot-rockchip.bin:
> > > rockusb write-file 0 u-boot-rockchip-spi.bin
> > > rockusb reset-device
> >
> > With this I was able to get it to SPL:
> >
> > DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
> > In
> > ch0 ttot6
> > ch1 ttot6
> > ch0 ttot7
> > LPDDR5, 2736MHz
> > channel[0] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 Siz=
e=3D1536MB
> > ch1 ttot7
> > channel[1] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 Siz=
e=3D1536MB
> > Manufacturer ID:0xff
> > CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
> > DQ roc:
> > p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
> > p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,
> >
> > DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
> > DQS roc: p2, n0, p1, n0
> >
> > CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
> > DQ roc:
> > p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
> > p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,
> >
> > DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
> > DQS roc: p2, n0, p2, n0
> >
> > stride=3D0x3, ddr_config=3D0x2
> > hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
> > change to F1: 534MHz
> > ch0 ttot6
> > ch1 ttot6
> > change to F2: 1320MHz
> > ch0 ttot8
> > ch1 ttot8
> > change to F3: 1968MHz
> > ch0 ttot6
> > ch1 ttot6
> > change to F0: 2736MHz
> > ch0 ttot7
> > ch1 ttot7
> > out
> >
> > U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -0600)
> > Trying to boot from MMC1
> > Card did not respond to voltage select! : -110
> > spl: mmc init failed with error: -95
> > Error: -95
> > SPL: Unsupported Boot Device!
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >
> >
> > It seems to boot from SPI but then try to switch to MMC?
>
> Sifting through my local tree I also noticed I've got the following
> patch to set the pin config for SPI flash on NanoPi M5:
>
> https://github.com/flipperdevices/u-boot/commit/ffb0d6c9b4893d6a8c2fe51ef=
c3dd5914857615e
>
> Would you mind giving it a try?
>
> The node itself and its properties are already in the upstream DTS, so
> it _shouldn't_ really be required, but maybe the bootph-* markers
> didn't propagate for me as-is and I didn't have the willpower to
> investigate further :)
>
> > I also found that if I 'dd if=3D/tmp/image of=3D/dev/sda count=3D2000' =
from
> > the good Alpine image, it ends up in the U-Boot I built (although of
> > course I have not built the earlier parts).
>
> Another way to get it to boot without relying on a particular storage
> configuration or the prebuilt image is to load an upstream binary
> directly to RAM over Maskrom:
>
> export BL31=3D[...] ROCKCHIP_TPL=3D[...]
> make nanopi-m5-rk3576_defconfig rockchip-ramboot.config
> make -j$(nproc)
> rockusb download-sram u-boot-rockchip-usb471.bin
> rockusb download-ddr u-boot-rockchip-usb472.bin
>
> SPI boot is supposed to work fine though. Did you use the
> u-boot-rockchip-spi.bin or u-boot-rockchip.bin image?
>
> > > Loader binary can be assembled from rkbin blobs, or alternatively
> > > taken from e.g. here:
> > > https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb599642064=
ee7c23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc369=
1b5022abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.100=
.bin
> > >
> > > rockusb tool: cargo install rockusb --example rockusb --features=3Dnu=
sb
> >
> > Thanks very much for taking the time to help with this!
>
> Always welcome!

It was booting from UFS, but since U-Boot SPL didn't have it enabled,
it didn't complete.

So I've erased that and am using your method of booting over USB - BTW
it is very slow, doesn't seem to use bulk mode.

The board is now working in my lab!

Thanks again.

Regards,
Simon
