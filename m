Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70256CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 09:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951D28484C;
	Mon,  1 Jun 2026 11:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="C87MoA3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E84584852; Mon,  1 Jun 2026 11:52:23 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D9F84837
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bdf8add254dso902889866b.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780307540; cv=none;
 d=google.com; s=arc-20240605;
 b=Clyb5CteIxgn+DqpcJfXqaxUUbd5qJa+Vy6GTi579aav9SRiKLuspwS/MoZ+HR5kpu
 rfeEnXSecAfwATWGJYTgmMaVq/dzhuZZInIfzlrCY2ROMjJ7YrJCzeRbvpmxGA5As592
 FFKl6qL6spOOEaK6dNc04TEuaDGW23oUfs2L/g/4NQGiB/gKuPHZ10cewnS/q3IK0trJ
 0yBYnaK8P2or2I2FN197E8SzyBIgB1q0O4Wi6w1FnVjzZ30fRtMxgABFhuFmEGrzIKJ4
 6HvZjgixXYNJ2Ww6rm/eDRmUzDxnyj1M96CDQG4E2WJsHzGQl51xxO1E3JJfW93gbErF
 WP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GWNMBVb6LTCsRPH6Mx73O+tgscYcqkEEYHiscX6F/c4=;
 fh=0/gvq/+QaS3VrydjSvrrwUZQBls0jUtJOwnAzRn6Od4=;
 b=fHVZM0cpSyaShzzYuZfPKpCZeIFMVWklt/97cGimSBeTs4X26j2xrOOh0t8pEQXEtK
 wbQILuqZCNI3pgd0cHyL5ZH4H95KIFEduy+iH0qw7xRSNEajSv91XCUUh6jutDQqw7JL
 yRAWa596IGk+20kceaiZphyZefwpG+VqU8s0AHBNOMTXkzS4nSLipNXP65l/tcDPxIM9
 nDykqxOHfnGwejZiaURDOaDsEMt03AnRivFqdzPpgqign+ULSslQwHbfb4+0bOkl/9Xf
 Zu6ffUOmfxBUAJiQ003qZHKx6dvvjV+eAT3SE+XOv6xwwshnWPByQIHLCx5lOoLt1u9f
 fbUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780307540; x=1780912340; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWNMBVb6LTCsRPH6Mx73O+tgscYcqkEEYHiscX6F/c4=;
 b=C87MoA3ZAsx5ynQh0qwAlEYpJlNGluJBL7IJymST4a63KkSwhFcEqa8oQOw5QkZ2AX
 Hv36QAJHHBisas8Bwy2ElagbN+zFsElVi73RKxmZkLZL1SS5x9WmrbH7hoGd/CFGgDgo
 v5TIRbuylUp4HgvfVjDkAiKkG6+cNHjCCMt7o6b/oOvxH9d6Y6JuS55yVsMbY8BoxQwQ
 Mr+KWimV7ZvBl2zqh6rT0GxblKWD42p13oDy0fKDIiJrliY7OmVLVOToEE8Dd2VXdSiB
 x2tXEbsS9w/+i81OsPg3pr+2zrOC/qsi8gIismP+mPL/26OAbLVBaKTLnyAgucM110Sg
 EJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780307540; x=1780912340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GWNMBVb6LTCsRPH6Mx73O+tgscYcqkEEYHiscX6F/c4=;
 b=HuYee/kiZn/RqxYoK97CRh3sW94Y8A7BgQzTJBxQii2PozERjtMhp3HMBWWw9Gqe3o
 UnSHC2gCEb3w5qH0su2d/HOLR+ly9tDznVgtcyJY7/1Jvk89VPM2GouIpD/FFSBqBtch
 FACeutrIjvKD07A20+KHAo7ko0UMqKYquw45cflGlXAPpe2k4AievhrmNgP4bn2NyeWQ
 4WXii2Gl2jqYaZ0DRXej/KlQEL6dcaNkfvkL6HhvW4vgzIeflGzfflDqcTNXxIAShrU9
 gxZyuMndbXGRN0zDm3UQlGTZsBQ1X2zXLA77JdkfJR/wIhUYRKFj1I8BaW1mL7w8xp9G
 BB3Q==
X-Gm-Message-State: AOJu0YyWIMim/NQEknmZ1TDt/n/1xgGQAMXy0Onjmug1GE/LoijZYpEi
 JP+48gR0sbFWxFbJnR8/K6W0cYDnFcaB8VCR+bfDWT/Y1HEWR26wmSl+RUwQnxB3pfkq4LLwFPa
 xQ5l/Y7yi8xbmjZmcglrn9F3UsuBWeuURYNs2SL8bnxjzfqfEsTtCb0p5cA==
X-Gm-Gg: Acq92OFTxuAV1fU8zCyrD58lf3CSdyyo+DPNrlcgSF3PfC4s25DJcnM6lB63H4tRm1a
 F1faCew+vUDbUdrwBSextFsNvzLYlJr2kVPftO4Sazrsulw+4fvx15YDbCpL63SiF7gZ93v7SYl
 0ohuCgqWwQK9+EA83tH1/CryqF1+TzdmIi6WQ8jFKkNlHm3gm7iufJZ5a1uh7KUHmMmsHZrrp4s
 7KoE2TYN8XzEMnXE1Poh36t045Sdz8+tIth6RCH6Af8fGXV7YTOIaDIezLEEPIiOwhDfDNSS0mA
 oY/H8ZOCU9rwzoktoiKW1jZcM7rO2Z3cOjkkz7fNTGCbmUXVuWMghpLwFCK5bg==
X-Received: by 2002:a17:907:9484:b0:bee:215e:546e with SMTP id
 a640c23a62f3a-bee215eac1amr103870166b.1.1780307539887; Mon, 01 Jun 2026
 02:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
 <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
 <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
 <CAFLszTh+OvAH9Zz3dbfj8cu8AQ1trAvMc56oWPLrCi9MR93NxQ@mail.gmail.com>
In-Reply-To: <CAFLszTh+OvAH9Zz3dbfj8cu8AQ1trAvMc56oWPLrCi9MR93NxQ@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 1 Jun 2026 13:52:12 +0400
X-Gm-Features: AVHnY4KSducRnX4av0AkI99QenEWNiJXVz2R4UzsVf4PhLg_VsRN-fLNGK6Fg6M
Message-ID: <CAKTNdwFeWNAs=qmiFoshYtEzv09XDQuHGkLg=AqmbEQmPGJ=pw@mail.gmail.com>
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

On Sun, May 31, 2026 at 10:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Alexey,
>
> On Mon, 25 May 2026 at 01:57, Alexey Charkov <alchark@flipper.net> wrote:
> >
> > On Sat, May 23, 2026 at 4:41=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Alexey,
> > >
> > > On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net> wr=
ote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> > > > > mainline. I found the note about needing a workaround so have tri=
ed
> > > > > kwiboo/rk3576 at
> > > > >
> > > > > https://github.com/Kwiboo/u-boot-rockchip.git
> > > > >
> > > > > I am building like this:
> > > > >
> > > > > $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_=
2736MHz_v1.09.bin
> > > > > BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> > > > > nanopi-m5-rk3576
> > > >
> > > > FWIW, upstream TF-A master branch works well as BL31 on RK3576, tho=
ugh
> > > > it's most probably unrelated to the issue you're seeing
> > >
> > > OK, thanks.
> > >
> > > >
> > > > > Image 'simple-bin' is missing optional external blobs but is stil=
l
> > > > > functional: tee-os
> > > > >
> > > > > /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> > > > >    See the documentation for your board. You may need to build Op=
en Portable
> > > > >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/p=
ath/to/tee.bin
> > > > >
> > > > > Image 'simple-bin-spi' is missing optional external blobs but is =
still
> > > > > functional: tee-os
> > > > >
> > > > > /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
> > > > >    See the documentation for your board. You may need to build Op=
en Portable
> > > > >    Trusted Execution Environment (OP-TEE) and build with TEE=3D/p=
ath/to/tee.bin
> > > > >
> > > > > $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/s=
da seek=3D64
> > > > > 18579+0 records in
> > > > > 18579+0 records out
> > > > > 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
> > > > >
> > > > > I get no serial output at all booting from SD card. Is there a sp=
ecial
> > > > > trick I am missing? I have confirmed that the Alpine Linux image =
works
> > > > > OK.
> > > >
> > > > Dumb question: did you flip the switch on the back side of the boar=
d
> > > > from FSPI1 to UFS/SD?
> > >
> > > Yes it is set to UFS/SC.
> > > >
> > > > If yes, then having no serial output at all most likely means the
> > > > boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
> > > > trainer unconditionally spits out some logs on the debug UART durin=
g
> > > > early init.
> > > >
> > > > The SD card might also be finicky, so if you happen to have an SPI
> > > > flash equipped board then you can flash U-boot there instead via
> > > > Maskrom. Just remove all other storage, connect a USB A-A cable to =
the
> > > > top USB 3.0 port, and power it up while holding the maskrom button.
> > >
> > > I am not sure how to power the board other than through the
> > > >
> > > > Then:
> > > > rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
> > > > # note the zero below, because u-boot-rockchip-spi.bin already has =
a
> > > > 64-sector offset baked in, unlike u-boot-rockchip.bin:
> > > > rockusb write-file 0 u-boot-rockchip-spi.bin
> > > > rockusb reset-device
> > >
> > > With this I was able to get it to SPL:
> > >
> > > DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
> > > In
> > > ch0 ttot6
> > > ch1 ttot6
> > > ch0 ttot7
> > > LPDDR5, 2736MHz
> > > channel[0] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 S=
ize=3D1536MB
> > > ch1 ttot7
> > > channel[1] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 S=
ize=3D1536MB
> > > Manufacturer ID:0xff
> > > CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
> > > DQ roc:
> > > p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
> > > p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,
> > >
> > > DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
> > > DQS roc: p2, n0, p1, n0
> > >
> > > CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
> > > DQ roc:
> > > p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
> > > p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,
> > >
> > > DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
> > > DQS roc: p2, n0, p2, n0
> > >
> > > stride=3D0x3, ddr_config=3D0x2
> > > hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
> > > change to F1: 534MHz
> > > ch0 ttot6
> > > ch1 ttot6
> > > change to F2: 1320MHz
> > > ch0 ttot8
> > > ch1 ttot8
> > > change to F3: 1968MHz
> > > ch0 ttot6
> > > ch1 ttot6
> > > change to F0: 2736MHz
> > > ch0 ttot7
> > > ch1 ttot7
> > > out
> > >
> > > U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -0600)
> > > Trying to boot from MMC1
> > > Card did not respond to voltage select! : -110
> > > spl: mmc init failed with error: -95
> > > Error: -95
> > > SPL: Unsupported Boot Device!
> > > SPL: failed to boot from all boot devices
> > > ### ERROR ### Please RESET the board ###
> > >
> > >
> > > It seems to boot from SPI but then try to switch to MMC?
> >
> > Sifting through my local tree I also noticed I've got the following
> > patch to set the pin config for SPI flash on NanoPi M5:
> >
> > https://github.com/flipperdevices/u-boot/commit/ffb0d6c9b4893d6a8c2fe51=
efc3dd5914857615e
> >
> > Would you mind giving it a try?
> >
> > The node itself and its properties are already in the upstream DTS, so
> > it _shouldn't_ really be required, but maybe the bootph-* markers
> > didn't propagate for me as-is and I didn't have the willpower to
> > investigate further :)
> >
> > > I also found that if I 'dd if=3D/tmp/image of=3D/dev/sda count=3D2000=
' from
> > > the good Alpine image, it ends up in the U-Boot I built (although of
> > > course I have not built the earlier parts).
> >
> > Another way to get it to boot without relying on a particular storage
> > configuration or the prebuilt image is to load an upstream binary
> > directly to RAM over Maskrom:
> >
> > export BL31=3D[...] ROCKCHIP_TPL=3D[...]
> > make nanopi-m5-rk3576_defconfig rockchip-ramboot.config
> > make -j$(nproc)
> > rockusb download-sram u-boot-rockchip-usb471.bin
> > rockusb download-ddr u-boot-rockchip-usb472.bin
> >
> > SPI boot is supposed to work fine though. Did you use the
> > u-boot-rockchip-spi.bin or u-boot-rockchip.bin image?
> >
> > > > Loader binary can be assembled from rkbin blobs, or alternatively
> > > > taken from e.g. here:
> > > > https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb5996420=
64ee7c23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc3=
691b5022abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.1=
00.bin
> > > >
> > > > rockusb tool: cargo install rockusb --example rockusb --features=3D=
nusb
> > >
> > > Thanks very much for taking the time to help with this!
> >
> > Always welcome!
>
> It was booting from UFS, but since U-Boot SPL didn't have it enabled,
> it didn't complete.

Indeed, the boot-from-UFS series [1] is still pending Kever's
attention for the Rockchip-specific part. Neil merged the common UFS
bits a while ago, and I'm using it all the time on several RK3576
boards.

[1] https://lore.kernel.org/u-boot/20260311-rk3576-ufs-v6-0-c7c353739242@fl=
ipper.net/

> So I've erased that and am using your method of booting over USB - BTW
> it is very slow, doesn't seem to use bulk mode.

I think there was some peculiarity about the boot ROM taking a while
to verify the checksum of the usb472 image, rather than the USB
transfer itself taking long. It might need further investigation.

> The board is now working in my lab!
>
> Thanks again.

Sounds great! Happy to help.

Best regards,
Alexey
