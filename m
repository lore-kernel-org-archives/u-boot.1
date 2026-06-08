Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0589CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A83847B0;
	Mon,  8 Jun 2026 15:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ea1hK495";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8026C84825; Mon,  8 Jun 2026 15:56:21 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02CEC846B1
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-beeba001887so563178366b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926978; cv=none;
 d=google.com; s=arc-20240605;
 b=SZLuO/Y7VR9NJ5f9LLAmMdzLH2sYN7IS97mcBH6RaOvcaGswHAgJBng7UbCW81akO2
 CWiOQrm9HNPkLQiNMhvCG7Pe71fIFOWIIwjwZi0wxj+1VVmO1JHnt+DrIl1iWgLEo/Hf
 v5mMV/STJL9kllcTcL/iVw4b0W5y7++146uvBNbyxXBeTIdAQIcwCuUL5BHP14DsPS9X
 dydgdj4A2qOQDo0qPLc77WOCljHyc0WJIOWbdWyj+gSbdR60oHaiaL7UAPUqpqYdHKv+
 If3A3NTRTZTPCG/VVE8jv0JkAR2GtBRGa3lav8QC0cnWjoRD35oSeUcAMGzUZKhKIRhT
 XmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FcMsoldFinVwxzXpxQrQJ1PuY1STEHez7mpLMfxCFBc=;
 fh=xn1CPiqNWx7dwQQlMyi16m3Qi67TwZVIyf5rVmQ+dis=;
 b=K7SPbjBiUl5G/9x22SshEyPy3fUekRTj29Szi9tEHRTTOZiHIi+MCtD0AeD+h6rLut
 L3XbcZc6+laVqnRykItTTeLre+Zl4T+YL+0zfuqPuFone7AnGvIpDZ1v6X7sqaiekooU
 dto/E7SizlavlxY/Pq8XZIO4ngyflv8IelYIFax95169fkWCJezPselkoxBYkOwW1qpI
 YXGlOPLYnj7qTxIFQRbAmd+DVCq3QJpW/8KVo9H3uOrF4hKchWBpKNDarGIDUAIznn1q
 zqxEn/NOo/ADWu4kHFRYkcR+J7YS1HXmQFYxXuOGzAVyHEvdwLU/u1tV7es1vEme8Jsb
 Ssdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780926978; x=1781531778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcMsoldFinVwxzXpxQrQJ1PuY1STEHez7mpLMfxCFBc=;
 b=ea1hK495N5SFgNpNAGg+1W8TTIJPcBCFiM43t7GS9E/DiN8RDH7JPnihkkZln3P/nt
 Mb2NSwkt5ivBiJrC71nZbbYuGjfanBCkiNaoecTzGpg2e4ims9RvQiwsUMbVfXKMe8AG
 La2hFQH4vUNs/aNEicIC6q1LNwjcz8NP4u6StiLscFzpWHra9EVdLlHaTfSexpQItDFZ
 bpJnvANNDP6rrFtXlyvyjYtDiN2BmmDJIvk9fHvni2vkfrQLo2TG70uQ9AgS/Fz5ZqBr
 +hM/3+Rzxv57flx+8nuARaiw8AoKSuhSyHHKLQYWm65ayCdOIbn1Vth3TMqLfs7AqHte
 TnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926978; x=1781531778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcMsoldFinVwxzXpxQrQJ1PuY1STEHez7mpLMfxCFBc=;
 b=ODoDHbs3PntXomtBh/AB5U5KKmUqIAYdp9G5318UCRtxZtwlukOaQPc8b+vUfoOojc
 W25u5CwJMyaVWoldEauJ1sz6S46B+qSTbnHnArllg355o7qNDb/+PCCDPuag5gkT526J
 AbTai62KaH4UA2MY6+60a83KMAr6JDVjk9WLJOLhaVfnzsOU+Mm+r7iVLQnLDJ6241qB
 7xPZ7H2Xe7jOUaze7xfIj+jduBKZYHhqeETGxKXPuXTMx22A+hdB7VSmJoOWAPv/e7yB
 xoCJsnJT4yWrpHcG3HmI6K87lOYgNNe2S+LC1EBReKA5ym1IyHyq6rA1EgqscEJCVYfN
 UNoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cMG+HJMHFP8ZEMScU7P45xSQTLg+zN3y7pslFaxD69e/NcHmJx5XRD1RBIehxhqt5fj2adbE=@lists.denx.de
X-Gm-Message-State: AOJu0YyKu8yMu1y6GH9ikdJ2puTpCALvHByLJtMDZ3AW8dF/4KnnFYAg
 8ZqXc1PKetpRTDIZfT1Li0yHsEKF39gnUzWu+y18zd7lYM6EgdF+lyngGFsbi3sOD138yEKeZmt
 Fn88z9tL3N7T2OJl92qrhl8wR4H4phq6XoRAET8BN7A==
X-Gm-Gg: Acq92OFvVMwJbphke9JQ8K8/kFGRLodeIkNHiRvRbTTK/ngvRhgJGdjkG+RYkiDR5PA
 DlUAWnbqFiRgthKsrWcZWV+/3G8WDv0ics+rwgbrChc5AgdYylYqaoW9i8UgmE5uTomcKpsj833
 qkqAXjQ2iyYy7BY8psShRVWeucDY6uYpnzXj2NUywqhso/AIqDwFWfiCa8PoPrTBmWmBMLilF3O
 pqWAqnNMHc4nByNr9Tr8CC2G03K4wm0wz5IMbnVN/jJtFh86wPeUJ78OJmBev0agEl4U/3ONuhM
 T6DWRb1JAz27Ni2NE48L4LpR+fUieB6yFNw6Z78gv4tCilJmrzE=
X-Received: by 2002:a17:907:c0d:b0:bec:4906:44d6 with SMTP id
 a640c23a62f3a-bf371a5538cmr814232066b.11.1780926977972; Mon, 08 Jun 2026
 06:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
 <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
 <CAFLszTh0wrXfZUT1hVWehFyC+k9O+ghmfQdzoFuhUuBvZ80x0g@mail.gmail.com>
 <CAKTNdwH6Gi4s2DVKrxFBAhwENdFq=N+RG+bRXLzthETXiSVj9g@mail.gmail.com>
 <CAFLszTh+OvAH9Zz3dbfj8cu8AQ1trAvMc56oWPLrCi9MR93NxQ@mail.gmail.com>
 <CAKTNdwFeWNAs=qmiFoshYtEzv09XDQuHGkLg=AqmbEQmPGJ=pw@mail.gmail.com>
 <be1f46e8-34a8-4739-8418-013403fcdcfa@kwiboo.se>
In-Reply-To: <be1f46e8-34a8-4739-8418-013403fcdcfa@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 8 Jun 2026 17:56:06 +0400
X-Gm-Features: AVVi8CfcXvK4-VsFmdLU2cqs0fzNCimPkx22SEG_KeKeO53hb7dEWB4MqarmcAw
Message-ID: <CAKTNdwELLEVK9FUtr6PwNkaOOvDjvE=XKmrofuVqYoyvOXj_GQ@mail.gmail.com>
Subject: Re: Friendlyelec NanoPi M5
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Mon, Jun 1, 2026 at 3:45=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Hi Alexey,
>
> On 6/1/2026 11:52 AM, Alexey Charkov wrote:
> > On Sun, May 31, 2026 at 10:26=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> >>
> >> Hi Alexey,
> >>
> >> On Mon, 25 May 2026 at 01:57, Alexey Charkov <alchark@flipper.net> wro=
te:
> >>>
> >>> On Sat, May 23, 2026 at 4:41=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On Fri, 22 May 2026 at 00:24, Alexey Charkov <alchark@flipper.net> w=
rote:
> >>>>>
> >>>>> Hi Simon,
> >>>>>
> >>>>> On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> >>>>>> mainline. I found the note about needing a workaround so have trie=
d
> >>>>>> kwiboo/rk3576 at
> >>>>>>
> >>>>>> https://github.com/Kwiboo/u-boot-rockchip.git
> >>>>>>
> >>>>>> I am building like this:
> >>>>>>
> >>>>>> $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2=
736MHz_v1.09.bin
> >>>>>> BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> >>>>>> nanopi-m5-rk3576
> >>>>>
> >>>>> FWIW, upstream TF-A master branch works well as BL31 on RK3576, tho=
ugh
> >>>>> it's most probably unrelated to the issue you're seeing
> >>>>
> >>>> OK, thanks.
> >>>>
> >>>>>
> >>>>>> Image 'simple-bin' is missing optional external blobs but is still
> >>>>>> functional: tee-os
> >>>>>>
> >>>>>> /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
> >>>>>>    See the documentation for your board. You may need to build Ope=
n Portable
> >>>>>>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/pa=
th/to/tee.bin
> >>>>>>
> >>>>>> Image 'simple-bin-spi' is missing optional external blobs but is s=
till
> >>>>>> functional: tee-os
> >>>>>>
> >>>>>> /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
> >>>>>>    See the documentation for your board. You may need to build Ope=
n Portable
> >>>>>>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/pa=
th/to/tee.bin
> >>>>>>
> >>>>>> $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/sd=
a seek=3D64
> >>>>>> 18579+0 records in
> >>>>>> 18579+0 records out
> >>>>>> 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
> >>>>>>
> >>>>>> I get no serial output at all booting from SD card. Is there a spe=
cial
> >>>>>> trick I am missing? I have confirmed that the Alpine Linux image w=
orks
> >>>>>> OK.
> >>>>>
> >>>>> Dumb question: did you flip the switch on the back side of the boar=
d
> >>>>> from FSPI1 to UFS/SD?
> >>>>
> >>>> Yes it is set to UFS/SC.
> >>>>>
> >>>>> If yes, then having no serial output at all most likely means the
> >>>>> boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
> >>>>> trainer unconditionally spits out some logs on the debug UART durin=
g
> >>>>> early init.
> >>>>>
> >>>>> The SD card might also be finicky, so if you happen to have an SPI
> >>>>> flash equipped board then you can flash U-boot there instead via
> >>>>> Maskrom. Just remove all other storage, connect a USB A-A cable to =
the
> >>>>> top USB 3.0 port, and power it up while holding the maskrom button.
> >>>>
> >>>> I am not sure how to power the board other than through the
> >>>>>
> >>>>> Then:
> >>>>> rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
> >>>>> # note the zero below, because u-boot-rockchip-spi.bin already has =
a
> >>>>> 64-sector offset baked in, unlike u-boot-rockchip.bin:
> >>>>> rockusb write-file 0 u-boot-rockchip-spi.bin
> >>>>> rockusb reset-device
> >>>>
> >>>> With this I was able to get it to SPL:
> >>>>
> >>>> DDR 2f85f4b2d4 cym 24/11/07-19:07:28,fwver: v1.09
> >>>> In
> >>>> ch0 ttot6
> >>>> ch1 ttot6
> >>>> ch0 ttot7
> >>>> LPDDR5, 2736MHz
> >>>> channel[0] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 =
Size=3D1536MB
> >>>> ch1 ttot7
> >>>> channel[1] BW=3D16 Col=3D10 Bk=3D16 CS0 Row=3D16 CS=3D1 Die BW=3D16 =
Size=3D1536MB
> >>>> Manufacturer ID:0xff
> >>>> CH0 RX Vref:24.1%, RX DQS Vref:29.6%, TX Vref:19.0%,0.0%
> >>>> DQ roc:
> >>>> p4 n2, p6 n7, p5 n0, p1 n0, p0 n0, p0 n4, p3 n0, p7 n0, p3 n0,
> >>>> p4 n2, p5 n0, p2 n2, p0 n2, p7 n0, p2 n0, p6 n0, p7 n0, p6 n4,
> >>>>
> >>>> DQ rds:l0 l0 h1 l0 l0 l0 l0 l0, l0 l0 h1 l0 l0 l0 l0 l0
> >>>> DQS roc: p2, n0, p1, n0
> >>>>
> >>>> CH1 RX Vref:25.7%, RX DQS Vref:29.2%, TX Vref:20.0%,0.0%
> >>>> DQ roc:
> >>>> p2 n0, p7 n0, p2 n0, p1 n0, p2 n0, p0 n1, p3 n0, p5 n0, p7 n0,
> >>>> p6 n0, p3 n2, p3 n0, p2 n0, p2 n0, p6 n0, p0 n0, p0 n2, p0 n0,
> >>>>
> >>>> DQ rds:l0 h2 l0 l0 l0 l0 l0 h1, l0 l0 l0 l0 h1 l0 h1 l0
> >>>> DQS roc: p2, n0, p2, n0
> >>>>
> >>>> stride=3D0x3, ddr_config=3D0x2
> >>>> hash bank_mask0-3 0x0 0x2100 0x44200 0x88400, rank_mask0 0x0
> >>>> change to F1: 534MHz
> >>>> ch0 ttot6
> >>>> ch1 ttot6
> >>>> change to F2: 1320MHz
> >>>> ch0 ttot8
> >>>> ch1 ttot8
> >>>> change to F3: 1968MHz
> >>>> ch0 ttot6
> >>>> ch1 ttot6
> >>>> change to F0: 2736MHz
> >>>> ch0 ttot7
> >>>> ch1 ttot7
> >>>> out
> >>>>
> >>>> U-Boot SPL 2026.01-00014-gf6f1066339a5 (May 22 2026 - 18:32:58 -0600=
)
> >>>> Trying to boot from MMC1
> >>>> Card did not respond to voltage select! : -110
> >>>> spl: mmc init failed with error: -95
> >>>> Error: -95
> >>>> SPL: Unsupported Boot Device!
> >>>> SPL: failed to boot from all boot devices
> >>>> ### ERROR ### Please RESET the board ###
> >>>>
> >>>>
> >>>> It seems to boot from SPI but then try to switch to MMC?
> >>>
> >>> Sifting through my local tree I also noticed I've got the following
> >>> patch to set the pin config for SPI flash on NanoPi M5:
> >>>
> >>> https://github.com/flipperdevices/u-boot/commit/ffb0d6c9b4893d6a8c2fe=
51efc3dd5914857615e
> >>>
> >>> Would you mind giving it a try?
> >>>
> >>> The node itself and its properties are already in the upstream DTS, s=
o
> >>> it _shouldn't_ really be required, but maybe the bootph-* markers
> >>> didn't propagate for me as-is and I didn't have the willpower to
> >>> investigate further :)
> >>>
> >>>> I also found that if I 'dd if=3D/tmp/image of=3D/dev/sda count=3D200=
0' from
> >>>> the good Alpine image, it ends up in the U-Boot I built (although of
> >>>> course I have not built the earlier parts).
> >>>
> >>> Another way to get it to boot without relying on a particular storage
> >>> configuration or the prebuilt image is to load an upstream binary
> >>> directly to RAM over Maskrom:
> >>>
> >>> export BL31=3D[...] ROCKCHIP_TPL=3D[...]
> >>> make nanopi-m5-rk3576_defconfig rockchip-ramboot.config
> >>> make -j$(nproc)
> >>> rockusb download-sram u-boot-rockchip-usb471.bin
> >>> rockusb download-ddr u-boot-rockchip-usb472.bin
> >>>
> >>> SPI boot is supposed to work fine though. Did you use the
> >>> u-boot-rockchip-spi.bin or u-boot-rockchip.bin image?
> >>>
> >>>>> Loader binary can be assembled from rkbin blobs, or alternatively
> >>>>> taken from e.g. here:
> >>>>> https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb5996420=
64ee7c23f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc3=
691b5022abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.1=
00.bin
> >>>>>
> >>>>> rockusb tool: cargo install rockusb --example rockusb --features=3D=
nusb
> >>>>
> >>>> Thanks very much for taking the time to help with this!
> >>>
> >>> Always welcome!
> >>
> >> It was booting from UFS, but since U-Boot SPL didn't have it enabled,
> >> it didn't complete.
> >
> > Indeed, the boot-from-UFS series [1] is still pending Kever's
> > attention for the Rockchip-specific part. Neil merged the common UFS
> > bits a while ago, and I'm using it all the time on several RK3576
> > boards.
> >
> > [1] https://lore.kernel.org/u-boot/20260311-rk3576-ufs-v6-0-c7c35373924=
2@flipper.net/
> >
> >> So I've erased that and am using your method of booting over USB - BTW
> >> it is very slow, doesn't seem to use bulk mode.
> >
> > I think there was some peculiarity about the boot ROM taking a while
> > to verify the checksum of the usb472 image, rather than the USB
> > transfer itself taking long. It might need further investigation.
>
> The very very slow boot time using ramboot on rk3576, around 10 min vs
> 30 seconds, is due to changes done in commit c6bba31dbdd4 ("rockchip:
> spl-boot-order: Defer probe of boot device").
>
> The delay of probe done in that commit correctly result in clk driver
> not being probed in SPL when running ramboot, and because no clk driver
> is probed, cores run at very slow rates until OS change core rates :-)
>
> My ci branch contains a commit to fix this, and other, I just need to
> find some free time before it reaches the list, see commit "WIP:
> rockchip: clk: init clocks in spl for rk3576" at [2].

Hi Jonas, it does indeed look like painfully slow clocks, but
cherry-picking this patch alone doesn't seem to turn the tide for me.
It still takes about 6 minutes from the moment `rockusb download-ddr`
completes until there is any SPL output on the console.

Is there any other change I need to apply for it to take effect?

> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ci

Thanks a lot,
Alexey
