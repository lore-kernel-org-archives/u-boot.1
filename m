Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03981CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854A084874;
	Thu, 18 Jun 2026 15:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eVghNMAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513A8849C5; Thu, 18 Jun 2026 15:27:30 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B31847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68c76fb8009so1396428a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789247; cv=none;
 d=google.com; s=arc-20240605;
 b=AGbihzXaj6t+JYQTt8zgrfp1kTLNOVuze5STra20TQmwZ7AB+MwET8AiYAlJJgW3zT
 mS33nZhamJuKSOrbYwcTdaSKF15crz73uvF+K4ZxrRSAuGvudS6KjSjxAR0dEHmtG70C
 Vmq2JuaCgCuGZTncUZ4pPS0aV4R5bJizwF9T99KMiSOg3QkJlClnCWC+VSjijgHeo4YQ
 ENe14SmA4fScdrIezIgbbXEkmtzwIF7WKxoxZQ3L4f9tZOaBf+zMuDEw/IiWQaDUVtNQ
 JjKPenysPNYMUGGnZ8GhCa0IgRchwbraD5XQ5h4LIrv8YQcfxFLYndB/0kQGbG+hzuFI
 37lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ajIzpSbqxnrjL/GGSYnfEln/j8IaVu9MYXVNh1Bhw94=;
 fh=OUGFd7PWUT2gmhAlPmqnQ7MUP0yehtutT8rJTR29GIc=;
 b=QhI1QCFiGF2ih27iDmS3y/wYLJwxXCfr5RZ5wG/EALJfd4/GejqvchhI2qN/i/KEyR
 YitddqlFZ2h3No3pwVN2nQF97ptGA79GyV0n7oEsJCVySx6d9DZ0B3uOTPfjHUdn/on4
 CVNAJhK14EC9VBNMyb1XGlX0O+XWweBwbmmm+5xq4wCkZpiz9ztHnIiNva5qXv1I/owP
 ffZ5ioLYTcqht6AvFkUQWSSMEudZNRu6JKsydujChfjmjCSEWCNXehSBP3rlvfcon3Ii
 Dj0DZx2R1lle2+8026Lt3N0gGnB0jgQcYTT1QhDH8bbsccGJyj0yVdzAuSg1t1sTxbBZ
 Xv+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781789247; x=1782394047; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajIzpSbqxnrjL/GGSYnfEln/j8IaVu9MYXVNh1Bhw94=;
 b=eVghNMAvl0jEn0RetHDFvkmsgWb1zZVG2k1wIBs8gu9hnwzVtOVfer0O05aNdIFxAf
 +69D3hphBzTdUY+JB4Var1a7S485JFaV/wgl8XGpsgFN/Gd4CBwUG1twEGbL+/WU8scD
 S0Ail6/9q/Hi6AImnB31/3tRp/qm1ks2M7xCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789247; x=1782394047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ajIzpSbqxnrjL/GGSYnfEln/j8IaVu9MYXVNh1Bhw94=;
 b=Yrzk5khMlTUAtkHQQpV9OmwOBt/VBfbMAibdqyYghXtchitIME9ui6nZ4qnCqoeW6X
 Gi0Gdhbo4xg9ucLLccTHUxjfOr9cE2b5OatC4YqwYgAVBfdlQtGqReCrfu+9AFQkxZXT
 tAMTSre10tFbdm7YZVmJd3+MZ9UFeOoLPG1doWvJYYGDccI54o069Isd4s37sNjfTp+n
 LQw0lKECHHInLbe62mRTx5g4qDZRKvwGO4imFJGRLrZRiLv3o35XUioYGWc9WqUzBMEZ
 UsTvZtB+u/fpQZ5EEsCbbNDgsFSpsJdI28H9ad4uCI728x1GVTuGHukfHHCWHlKAIEpn
 EnAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9huVML3yVANUsUvKSyOWSoNiXgFYyDrsTgQjbqKWH+it9T5fZqiaQgq5ciam5EALEpNRmgitU=@lists.denx.de
X-Gm-Message-State: AOJu0YzPe0eeW+E+8Sh2LhbxOHGMN0LxtG43QybDyANrQP8UOrwnPgnI
 GZmGfLnpFQw9Uzooogi88arZo2YacOKREK0zWDbSIYc+Ukxf7lwCgFD5sHFHfGT4mitgiX6Lzv3
 LCWnvFpjd5rG42ImatnvSONeNLmAt8oiNcr1LBRqy
X-Gm-Gg: AfdE7cl3TkEemDGctc6uAT+cMoyq2tCeAJ3QPoL7aUvb2Q9hPhZXJeWe5uIcmns03A1
 7/ve71U3As19zqF0u+oVyLm3IaVCV4O6wkq8ovtwmGoR8jMFStFOHb3XPVu7nxoBa1IfIgXifvV
 r9Xgk8Y/PyzxHBvuTChvManv2pu/wigneVf1yc3BcbxOJTw0iJFYc2O21wFaWiezu6eljX+KNSP
 nTU51reiPzU1lrncT2q0Zsd8h2+C3+XzZVpWU5r6MziLVLdhwq5KOBySkOJ5qqppbyOZYHAQxcg
 G+MuHshZ
X-Received: by 2002:a05:6402:42ce:b0:68a:f2ac:4675 with SMTP id
 4fb4d7f45d1cf-6954757fd22mr5071306a12.7.1781789247167; Thu, 18 Jun 2026
 06:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
 <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
 <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
 <CAFLszTh+OvAH9Zz3dbfj8cu8AQ1trAvMc56oWPLrCi9MR93NxQ@mail.gmail.com>
 <CAKTNdwFeWNAs=qmiFoshYtEzv09XDQuHGkLg=AqmbEQmPGJ=pw@mail.gmail.com>
 <be1f46e8-34a8-4739-8418-013403fcdcfa@kwiboo.se>
 <CAKTNdwELLEVK9FUtr6PwNkaOOvDjvE=XKmrofuVqYoyvOXj_GQ@mail.gmail.com>
 <b4aa958b-7172-4a2e-9d9e-c7b0f30f0db8@kwiboo.se>
In-Reply-To: <b4aa958b-7172-4a2e-9d9e-c7b0f30f0db8@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:27:12 +0100
X-Gm-Features: AVVi8CcDScGKDCqXVTv7sG0FgUL4qcXQFYkkkzvzdU0rqDfdIQkiGjwP0kGsOfM
Message-ID: <CAFLszTghgeuAgCZr0t4bXr-Z4GTm0xJ8kO3Ygt=2VfWeLBFb-w@mail.gmail.com>
Subject: Re: Friendlyelec NanoPi M5
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Alexey Charkov <alchark@flipper.net>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Jonas,

On Mon, 8 Jun 2026 at 15:45, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Alexey,
>
> On 6/8/2026 3:56 PM, Alexey Charkov wrote:
> > On Mon, Jun 1, 2026 at 3:45=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> =
wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 6/1/2026 11:52 AM, Alexey Charkov wrote:
> >>> On Sun, May 31, 2026 at 10:26=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On Mon, 25 May 2026 at 01:57, Alexey Charkov <alchark@flipper.net> w=
rote:
> >>>>>
> >>>>> On Sat, May 23, 2026 at 4:41=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> >>>>>>
> >>>>>> Hi Alexey,
> >>>>>>
> >>>>>> On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net>=
 wrote:
> >>>>>>>
> >>>>>>> Hi Simon,
> >>>>>>>
> >>>>>>> On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium=
.org> wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> >>>>>>>> mainline. I found the note about needing a workaround so have tr=
ied
> >>>>>>>> kwiboo/rk3576 at
> >>>>>>>>
> >>>>>>>> https://github.com/Kwiboo/u-boot-rockchip.git
> >>>>>>>>
> >>>>>>>> I am building like this:
> >>>>>>>>
> >>>>>>>> $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5=
_2736MHz_v1.09.bin
> >>>>>>>> BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> >>>>>>>> nanopi-m5-rk3576
> >>>>>>>
> >>>>>>> FWIW, upstream TF-A master branch works well as BL31 on RK3576, t=
hough
> >>>>>>> it's most probably unrelated to the issue you're seeing
> >>>>>>
> >>>>>> OK, thanks.
> >>>>>>
> >>>>>>>
> >>>>>>>> Image 'simple-bin' is missing optional external blobs but is sti=
ll
> >>>>>>>> functional: tee-os
> >>>>>>>>
> >>>>>>>> /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> >>>>>>>>    See the documentation for your board. You may need to build O=
pen Portable
> >>>>>>>>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/=
path/to/tee.bin
> >>>>>>>>
> >>>>>>>> Image 'simple-bin-spi' is missing optional external blobs but is=
 still
> >>>>>>>> functional: tee-os
> >>>>>>>>
> >>>>>>>> /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
> >>>>>>>>    See the documentation for your board. You may need to build O=
pen Portable
> >>>>>>>>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/=
path/to/tee.bin
> >>>>>>>>
> >>>>>>>> $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/=
sda seek=3D64
> >>>>>>>> 18579+0 records in
> >>>>>>>> 18579+0 records out
> >>>>>>>> 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
> >>>>>>>>
> >>>>>>>> I get no serial output at all booting from SD card. Is there a s=
pecial
> >>>>>>>> trick I am missing? I have confirmed that the Alpine Linux image=
 works
> >>>>>>>> OK.
> >>>>>>>
> >>>>>>> Dumb question: did you flip the switch on the back side of the bo=
ard
> >>>>>>> from FSPI1 to UFS/SD?
> >>>>>>
> >>>>>> Yes it is set to UFS/SC.
> >>>>>>>
> >>>>>>> If yes, then having no serial output at all most likely means the
> >>>>>>> boost.bin trick from Jonas' WIP patch didn't apply, because the D=
DR
> >>>>>>> trainer unconditionally spits out some logs on the debug UART dur=
ing
> >>>>>>> early init.
> >>>>>>>
> >>>>>>> The SD card might also be finicky, so if you happen to have an SP=
I
> >>>>>>> flash equipped board then you can flash U-boot there instead via
> >>>>>>> Maskrom. Just remove all other storage, connect a USB A-A cable t=
o the
> >>>>>>> top USB 3.0 port, and power it up while holding the maskrom butto=
n.
> >>>>>>
> >>>>>> I am not sure how to power the board other than through the
> >>>>>>>
> >>>>>>> Then:
> >>>>>>> rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
> >>>>>>> # note the zero below, because u-boot-rockchip-spi.bin already ha=
s a
> >>>>>>> 64-sector offset baked in, unlike u-boot-rockchip.bin:
> >>>>>>> rockusb write-file 0 u-boot-rockchip-spi.bin
> >>>>>>> rockusb reset-device
> >>>>>>
> >>>>>> With this I was able to get it to SPL:
> >>>>>>
> >>>>>> DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
> >>>>>> In
> >>>>>> ch0 ttot6
> >>>>>> ch1 ttot6
> >>>>>> ch0 ttot7
> >>>>>> LPDDR5, 2736MHz
> >>>>>> channel[0] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D1=
6 Size=3D1536MB
> >>>>>> ch1 ttot7
> >>>>>> channel[1] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D1=
6 Size=3D1536MB
> >>>>>> Manufacturer ID:0xff
> >>>>>> CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
> >>>>>> DQ roc:
> >>>>>> p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
> >>>>>> p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,
> >>>>>>
> >>>>>> DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
> >>>>>> DQS roc: p2, n0, p1, n0
> >>>>>>
> >>>>>> CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
> >>>>>> DQ roc:
> >>>>>> p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
> >>>>>> p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,
> >>>>>>
> >>>>>> DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
> >>>>>> DQS roc: p2, n0, p2, n0
> >>>>>>
> >>>>>> stride=3D0x3, ddr_config=3D0x2
> >>>>>> hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
> >>>>>> change to F1: 534MHz
> >>>>>> ch0 ttot6
> >>>>>> ch1 ttot6
> >>>>>> change to F2: 1320MHz
> >>>>>> ch0 ttot8
> >>>>>> ch1 ttot8
> >>>>>> change to F3: 1968MHz
> >>>>>> ch0 ttot6
> >>>>>> ch1 ttot6
> >>>>>> change to F0: 2736MHz
> >>>>>> ch0 ttot7
> >>>>>> ch1 ttot7
> >>>>>> out
> >>>>>>
> >>>>>> U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -06=
00)
> >>>>>> Trying to boot from MMC1
> >>>>>> Card did not respond to voltage select! : -110
> >>>>>> spl: mmc init failed with error: -95
> >>>>>> Error: -95
> >>>>>> SPL: Unsupported Boot Device!
> >>>>>> SPL: failed to boot from all boot devices
> >>>>>> ### ERROR ### Please RESET the board ###
> >>>>>>
> >>>>>>
> >>>>>> It seems to boot from SPI but then try to switch to MMC?
> >>>>>
> >>>>> Sifting through my local tree I also noticed I've got the following
> >>>>> patch to set the pin config for SPI flash on NanoPi M5:
> >>>>>
> >>>>> https://github.com/flipperdevices/u-boot/commit/ffb0d6c9b4893d6a8c2=
fe51efc3dd5914857615e
> >>>>>
> >>>>> Would you mind giving it a try?
> >>>>>
> >>>>> The node itself and its properties are already in the upstream DTS,=
 so
> >>>>> it _shouldn't_ really be required, but maybe the bootph-* markers
> >>>>> didn't propagate for me as-is and I didn't have the willpower to
> >>>>> investigate further :)
> >>>>>
> >>>>>> I also found that if I 'dd if=3D/tmp/image of=3D/dev/sda count=3D2=
000' from
> >>>>>> the good Alpine image, it ends up in the U-Boot I built (although =
of
> >>>>>> course I have not built the earlier parts).
> >>>>>
> >>>>> Another way to get it to boot without relying on a particular stora=
ge
> >>>>> configuration or the prebuilt image is to load an upstream binary
> >>>>> directly to RAM over Maskrom:
> >>>>>
> >>>>> export BL31=3D[...] ROCKCHIP_TPL=3D[...]
> >>>>> make nanopi-m5-rk3576_defconfig rockchip-ramboot.config
> >>>>> make -j$(nproc)
> >>>>> rockusb download-sram u-boot-rockchip-usb471.bin
> >>>>> rockusb download-ddr u-boot-rockchip-usb472.bin
> >>>>>
> >>>>> SPI boot is supposed to work fine though. Did you use the
> >>>>> u-boot-rockchip-spi.bin or u-boot-rockchip.bin image?
> >>>>>
> >>>>>>> Loader binary can be assembled from rkbin blobs, or alternatively
> >>>>>>> taken from e.g. here:
> >>>>>>> https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb59964=
2064ee7c23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Df=
c3691b5022abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13=
.100.bin
> >>>>>>>
> >>>>>>> rockusb tool: cargo install rockusb --example rockusb --features=
=3Dnusb
> >>>>>>
> >>>>>> Thanks very much for taking the time to help with this!
> >>>>>
> >>>>> Always welcome!
> >>>>
> >>>> It was booting from UFS, but since U-Boot SPL didn't have it enabled=
,
> >>>> it didn't complete.
> >>>
> >>> Indeed, the boot-from-UFS series [1] is still pending Kever's
> >>> attention for the Rockchip-specific part. Neil merged the common UFS
> >>> bits a while ago, and I'm using it all the time on several RK3576
> >>> boards.
> >>>
> >>> [1] https://lore.kernel.org/u-boot/20260311-rk3576-ufs-v6-0-c7c353739=
242@flipper.net/
> >>>
> >>>> So I've erased that and am using your method of booting over USB - B=
TW
> >>>> it is very slow, doesn't seem to use bulk mode.
> >>>
> >>> I think there was some peculiarity about the boot ROM taking a while
> >>> to verify the checksum of the usb472 image, rather than the USB
> >>> transfer itself taking long. It might need further investigation.
> >>
> >> The very very slow boot time using ramboot on rk3576, around 10 min vs
> >> 30 seconds, is due to changes done in commit c6bba31dbdd4 ("rockchip:
> >> spl-boot-order: Defer probe of boot device").
> >>
> >> The delay of probe done in that commit correctly result in clk driver
> >> not being probed in SPL when running ramboot, and because no clk drive=
r
> >> is probed, cores run at very slow rates until OS change core rates :-)
> >>
> >> My ci branch contains a commit to fix this, and other, I just need to
> >> find some free time before it reaches the list, see commit "WIP:
> >> rockchip: clk: init clocks in spl for rk3576" at [2].
> >
> > Hi Jonas, it does indeed look like painfully slow clocks, but
> > cherry-picking this patch alone doesn't seem to turn the tide for me.
> > It still takes about 6 minutes from the moment `rockusb download-ddr`
> > completes until there is any SPL output on the console.
> >
> > Is there any other change I need to apply for it to take effect?
>
> 6 minutes sounds very long and strange, is there some issue with rockusb?
>
> I did a quick test in my labgrid using close to v2026.07-rc3 + that
> patch and loading usb471.bin + usb472.bin takes around 2.1 seconds, and
> around 13-15 seconds from DDR init until SPL banner is printed.
>
>   INFO         StepLogger:   =E2=86=92 RKUSBMaskromDriver.load(filename=
=3DNone)
>   INFO    SSHConnection(h:    Created new SSH connection to noble
>   INFO    ManagedFile(loc:    Synchronizing /srv/u-boot/rk3576-sige5/u-bo=
ot-rockchip-usb471.bin to noble
>   INFO    ManagedFile(loc:    Synchronizing /srv/u-boot/rk3576-sige5/u-bo=
ot-rockchip-usb472.bin to noble
>   INFO         StepLogger:   =E2=86=90 RKUSBMaskromDriver.load() [2.134s]

Yes, this matches what I see.

>
> No real change there, what took long before that commit was starting
> Linux, kernel boot could take around 5-10 minutes, now just 15-30
> seconds, if I trust dmesg timestamps.
>
> I use labgrid PR1721 [3] to ramboot into my boards, when working on that
> I noticed that use of pre-calculated crc tables helped loading speed a
> lot, maybe rockusb is at fault or help slow things down for you?
>
> My test run above was on a ArmSoM Sige5 board.
>
> [3] https://github.com/labgrid-project/labgrid/pull/1721
>
> Regards,
> Jonas
>
> >
> >> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits=
/ci
> >
> > Thanks a lot,
> > Alexey
>

Regards,
Simon
