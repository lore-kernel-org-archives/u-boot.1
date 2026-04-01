Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A9E1112240
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C26839DF;
	Thu,  2 Apr 2026 01:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtWDWZF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BCE83CE3; Thu,  2 Apr 2026 01:45:13 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A874480517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso45982166b.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087111; cv=none;
 d=google.com; s=arc-20240605;
 b=gLcpO8T6wgnzNoUZyRf6yoP04fbasn10fgDShsrmC/c/OU19yeIMlGlbV6nFbXr7Tq
 uMMQ6ftZtbEtGnx+NvW4AD7zK2E51x2rlk40Aoua5m0h2KvWa2bKZRlrc7Z9bGBNJBED
 NSBGuiwSgXyefwWiKZZDZuxRjYJY5MSFhvyx5xo+juhgazLRA5VBFDoiXUzhAMdR7W3J
 aNwCwfwmvzuRPfFBsn0oPJcA5IntIYzs/o6gPNobM1RJ3Ttc5ub6eSPom95GU5e8otjq
 j6qucBDTFx5n4JyG0ltm6EVODd+b7JLloqBBy8L+3F69rb6Eab+x3co85UlNYrN9sKlY
 HULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x7BKXqGss+b/3B3qnPXPt1sG+pGuFdXFfZIBbzdGvRM=;
 fh=ToXak3o3FxKjeN9zN6KF+Y7XD0fq/gRTAn22wDFBJO0=;
 b=jHyLOCbjgZZ4+XGauHL6YFG++Z9gpB4qSzr+IC4rxWApQovszF3FrgEuhmnK8WxFNZ
 EK3kUG71M3q5Cy61d6R9dOQDDdqKaLoxTyhk8qcrP0mxz43oYiw8+Ywl611G51Bt7hAe
 oBsxan5TU/EiQH5+iityuRod3rfOw2kqHJM0vLTdXgC1BocGDJm2OkvRtmtQsBCKau3/
 cC7Uuv1wYUh1seIIp7a5YsCQG7K4NO5tjRk1CnfpM7fLgsUtxSXERUvMU57ZGtc07Wnw
 Nfq6wPqWKL5ZwWthw2wewd8LTvK3TIidQPW/gndfWutugtEZrMK0HWKLIa6+t+wpom0n
 dkIg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775087111; x=1775691911; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7BKXqGss+b/3B3qnPXPt1sG+pGuFdXFfZIBbzdGvRM=;
 b=TtWDWZF3BEnYdAog/bniD9nDnGCAhgEUJI0XI6qT7zLWVNfvpRjLxLSnQ6V8Y60ZrJ
 HS/TLTRLdCVoW7V7MKG9A8r5llRYt1DoJK+yotnsLCVfAICoIwIAljnWb6XC1aveHr3B
 tSg1pOpwWfZ9Chr97VIHQNoBcuA3PBtIjyCWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775087111; x=1775691911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7BKXqGss+b/3B3qnPXPt1sG+pGuFdXFfZIBbzdGvRM=;
 b=jKijsiWHgCLxtSxLhhcHqBN9pYsglAeAFtL3FmgAhDGUvoxFHBk+f3x1d0ud2N1uDE
 ZX+aYawUN5amq0XJR51viYpfkbk1b6/KSMC9/FNWJc7rqRz+k6XBG67jSS8G2+V6ARpQ
 Veo7xSh96NGzPg5B9TRi98Uc9Ni9GQCTgC4+nsupX8e+SQdTCF7UgrN8FCfwR+KoB62E
 REDfcmqRe4+BtEIjvJsQ7HtKyE3NpOit12CJsN4DYa4qYPVMT6hkMeefX6tAB5YRENTV
 JXVmV3g565Tx/65KoFDTWMljIgCWPjVU3j1tuUN2wH/nl0TGKdQI0JUjgvDAYU3Tz/fH
 0lLQ==
X-Gm-Message-State: AOJu0YzwcsHQt+TKjsolFuCvuhPWhVvcBqRvbLevWUXlnbKPxvpR1Qp9
 X/+E0GGJMsdZ+XF1vBz3xrLXfvKrnD1TT0rkafr7/dETpscvTyrQPXFsm8HJfhuuHaubAuSMh37
 crV8jHTcavXfJs26CfgDkuXWB6n9aB97LyrHRkEoG
X-Gm-Gg: ATEYQzzsJ8QgoWfaZNqy4mDGSvtQ+krBOw/4kIA0YXdwN4WwEF6UvUemH9Ad6tIpzf2
 6ZWUoLOOzIdJFoNP/S0rOYzhqYI2Foesm4sjy+0n2UVs5T74SeZTKt3cqJinuS8sKjomM32I2e0
 6vODBQxuveYQWfgbwxhZjHjO8G13+LwdfIQ9iPFiHa8ytcGCpiVCvi7umehcUNmycqYdb2yUDXA
 GiIwGoVGTM9G3CPLahg00hbwrYSsnG13MFK5jXNNavpqNEWa+Ys+3FHRUBe67lRVsZt2rnp4jz8
 PRxtew==
X-Received: by 2002:a17:906:3b4b:b0:b98:6177:2eff with SMTP id
 a640c23a62f3a-b9c13b608a6mr307773766b.41.1775087110886; Wed, 01 Apr 2026
 16:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
 <CAFLszTjDnEoTP1fHdounqov_SYSDdr-Zpt7L_+-c9qb=c0F8JQ@mail.gmail.com>
 <CAJs94EYuFQJvdTjWZX1qWg9e7Qz_X_G7Bz017nucN1HtU1Mrcw@mail.gmail.com>
 <CAFLszTj7g-pYE6+Fw7=Vip-1dw0QK7+1tgjuUzNK_J1Yi4mW+g@mail.gmail.com>
 <CAJs94EZk3avSo=Oxdr4yqXCHDApvwUhR1VcUFf4GJ=Pq=O8CZA@mail.gmail.com>
In-Reply-To: <CAJs94EZk3avSo=Oxdr4yqXCHDApvwUhR1VcUFf4GJ=Pq=O8CZA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:44:57 -0400
X-Gm-Features: AQROBzBP1dJ_mgrsGb0xQ-4p8gs8hWiXwIDkRPvZX8FMtzOrqUQlx7UgKs_SXQU
Message-ID: <CAFLszTgR=jt+P5NciLw80PaCseZZw=XMT-Ha+NHQFNXxfMfndg@mail.gmail.com>
Subject: Re: Need help with FDT overlay
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Matwey,

On Sun, 22 Mar 2026 at 07:03, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> =D1=81=D0=B1, 21 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 22:21, S=
imon Glass <sjg@chromium.org>:
> >
> > Hi Matwey,
> >
> > On Sat, 21 Mar 2026 at 11:20, Matwey V. Kornilov
> > <matwey.kornilov@gmail.com> wrote:
> > >
> > > I compile dtbo as the following;
> > >
> > > cpp -x assembler-with-cpp -I /home/matwey/lab/linux/include
> > > overlay.dtso overlay.i
> > > dtc -@ -O dtb -o overlay.dtbo overlay.i
> > >
> > > Decompiled overlay.dtbo looks like this:
> > >
> > > /dts-v1/;
> > >
> > > / {
> > >
> > >     fragment@0 {
> > >         target =3D <0xffffffff>;
> > >
> > >         __overlay__ {
> > >             status =3D "okay";
> > >         };
> > >     };
> > >
> > >     fragment@1 {
> > >         target =3D <0xffffffff>;
> > >
> > >         __overlay__ {
> > >             status =3D "okay";
> > >         };
> > >     };
> > >
> > >     fragment@2 {
> > >         target-path =3D "/";
> > >
> > >         __overlay__ {
> > >
> > >             i2c-gpio {
> > >                 compatible =3D "i2c-gpio";
> > >                 sda-gpios =3D <0xffffffff 0x08 0x00 0x06>;
> > >                 scl-gpios =3D <0xffffffff 0x08 0x0f 0x06>;
> > >                 i2c-gpio,delay-us =3D <0x02>;
> > >                 #address-cells =3D <0x01>;
> > >                 #size-cells =3D <0x00>;
> > >                 status =3D "okay";
> > >                 phandle =3D <0x01>;
> > >             };
> > >         };
> > >     };
> > >
> > >     __symbols__ {
> > >         i2c_gpio =3D "/fragment@2/__overlay__/i2c-gpio";
> > >     };
> > >
> > >     __fixups__ {
> > >         i2c0 =3D "/fragment@0:target:0";
> > >         i2c1 =3D "/fragment@1:target:0";
> > >         pio =3D "/fragment@2/__overlay__/i2c-gpio:sda-gpios:0",
> > > "/fragment@2/__overlay__/i2c-gpio:scl-gpios:0";
> > >     };
> > > };
> > >
> > >
> > > I am not sure about the size. How do I check it correctly? Now, I jus=
t do
> > >
> > > fdt resize 16384
> > >
> > > =D1=81=D0=B1, 21 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 18:0=
2, Simon Glass <sjg@chromium.org>:
> > > >
> > > > Hi Matwey,
> > > >
> > > > On Sat, 21 Mar 2026 at 06:55, Matwey V. Kornilov
> > > > <matwey.kornilov@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I am running U-boot 2026.01 with orangepi_zero2w config and I am
> > > > > trying to apply my hand-written dtbo via fdt apply.
> > > > > The issue is that the fdi apply command just hangs forever for me=
. The
> > > > > issue only appears when I try to append a new node to the root. H=
ow
> > > > > could I find what is going wrong here?
> > > > >
> > > > > The overlay source is the following:
> > > > >
> > > > > /dts-v1/;
> > > > > /plugin/;
> > > > >
> > > > > #include <dt-bindings/i2c/i2c.h>
> > > > > #include <dt-bindings/gpio/gpio.h>
> > > > >
> > > > >
> > > > > &i2c0 {
> > > > >     status =3D "okay";
> > > > > };
> > > > >
> > > > > &i2c1 {
> > > > >     status =3D "okay";
> > > > > };
> > > > >
> > > > > &{/} {
> > > > >     i2c_gpio: i2c-gpio {
> > > > >         compatible =3D "i2c-gpio";
> > > > >         sda-gpios =3D <&pio 8 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN=
)>; // PI0  (29)
> > > > >         scl-gpios =3D <&pio 8 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAI=
N)>; // PI15 (31)
> > > > >         i2c-gpio,delay-us =3D <2>;        /* ~100 kHz */
> > > > >         #address-cells =3D <1>;
> > > > >         #size-cells =3D <0>;
> > > > >         status =3D "okay";
> > > > >     };
> > > > > };
> > > > >
> > > >
> > > > Can you provide thte dtc command you are using to build this? Is th=
ere
> > > > enough spare space in the dtb? I'm not sure what would cause it to
> > > > hang.
> > > >
> > > > Regards,
> > > > Simon
> >
> > It might help to have the console log too. I can't see any way this
> > can hang unless the addreses are wrong and something important is
> > overwritten.
> >
> > Try this to see the address:
> >
> > fdt header
> >
> > Compare to 'meminfo' so you can tell that there is nothing important
> > above the fdt. Also where do you load the overlay?
> >
>
> Hi,
>
> I guess I found my mistake. I've been trying to apply the overlay to
> ${fdtcontroladdr}. It has been working while I updated only existing
> nodes.

OK good!

>
> Now, I do the following:
>
> cp.b ${fdtcontroladdr} ${fdt_addr_r} 0x8000
> fdt addr ${fdt_addr_r}
> fdt resize 10000
> fdt apply ${fdtoverlay_addr_r}
>
> I am not sure if there is a better way

Seems OK.

>
>
> > BTW U-Boot uses hex, so it should be 'fdt resize 4000'
>
> Then doc/usage/fdt_overlays.rst should be improved because now it says
> 'fdt resize 8192'.

Yes, please send a patch!

Regards,
Simon
