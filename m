Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0673109448F
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 19:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E70684006;
	Sat, 21 Mar 2026 20:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gddjsrdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F9584011; Sat, 21 Mar 2026 20:21:01 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3856F83F9B
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 20:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso377757666b.3
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 12:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774120859; cv=none;
 d=google.com; s=arc-20240605;
 b=D3+79VLJKE4aQ730HCxi8vO08XRN20iZ/Zark7FUa1J5AKcp9FTdeqEJGs5t6kOIBn
 ptxASUiiRl5CXyuiRWCfpgVAZ4An9KcHLGBiuXraFZvCiwcB4xnusV/IuQNxhUUJpfcK
 M7Xhc9P82oD7MY7rIOwx1KrL7xJaiw3eX73vxEJDgNhw/jbYLlsLwTUTxUxnmpZSwRh6
 Fat7bcXZGF0fGaQSyvozTuBNmUQAxs4mgMewxR2MG5rdHjm7ympsNgV8isoQmqCx4zwx
 8ODK0FF6Azxnf88hujBhVoGqWL/2z+VEAJ2qcB4nyPe2w2shwoCYEyMLDr2/yA/oTKcA
 9PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c9ePjbsGQYI6sBXIkNIc0+vhDGYqccbz4TZ05v4Iydw=;
 fh=ToXak3o3FxKjeN9zN6KF+Y7XD0fq/gRTAn22wDFBJO0=;
 b=jh9zfQ8DrkW7SkTXP6FJzJ8sT5SWQnSXda02zDqpHDsw/S+qJ++lrnYBjaVA3C5LYn
 upDmWgb6wUgYjaCViyaCeDypOpRvjuBRizQ8i6QnLO7nHvK284lSUGo5dcJw/oW7b2VF
 dcacIWsfKGX0MTBnCUV6qOzt29n2rhseydoWKjnh38+sh4JTPDK0jJUMZGF6j0by362k
 f0ZhOyIB8d6Qs484h6SrQlE3UzBHLw/ZFKGHT06bK+mmypd355gRTFcXbLrfRXW9SB44
 HdDc6xQQNL1JHXPiTFh0euamz2tgHSt1azpDJFyuXwx+sMKC91NOilAFH05un46bgS+7
 VEjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774120859; x=1774725659; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9ePjbsGQYI6sBXIkNIc0+vhDGYqccbz4TZ05v4Iydw=;
 b=Gddjsrdr036lwn0pUf65kF0DAaUXs5iN22xmdYoCqU5yQoAw7RT+Wnjz/VV76RsTm2
 apyUf7XoiJMlukyeXK06vDn80LCO0wReBUt1sC1kSwddZ/kKFF/aVu2rrYOsf72KS9MC
 BCkbaktBm05a+TfzJyxISeNkYXqJCqGWUEM68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774120859; x=1774725659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9ePjbsGQYI6sBXIkNIc0+vhDGYqccbz4TZ05v4Iydw=;
 b=cxnSzTG76/w/YDPdypoTvntxHjQ3Q2GHSMFDdUGvAfcAjw3N4RGJLUl7CpRRfIipm7
 symj2tzgliF7UZoLx1Qc/1buXFYKBwkfdfousFURrEl0OFXNSyra0Aznh9rtYX9tOpvK
 a/SE2TGs5cFCO5mtfFml/MehkQBFvGoMj6NR1t/ptdcETDBkXn2A2Rh72WvaoQlxhYiG
 i5MQlAgZ1LIesbymQdfBiW+yO9pfVcYajgQz7Km7KlKaBRPkpvq5v45jd22EW77kegUl
 v+nL8UHkBsUFuAW47VtsQ7+jufDzY+9dZArEBsx+awNYU9mS5v6z0XbC10UVJu0ogojO
 Ev2A==
X-Gm-Message-State: AOJu0YwPvyOLkoeilD2dEbfEQIPHwuhm7GkM6FQeygIFVRiLv3yJjrIx
 5hLpYMN5cUAlDgVP6sl2tIwjRj09D39aCrA3T+YxtiqHf6WwZsC4CgH4Jr1flpOzRJd5Tg9jjVa
 xxeTg3maAmtdptgEWBueH+07SZ3zK9dTf/ldxOfua/i2bFML/eBOla6Ws
X-Gm-Gg: ATEYQzzGHh1uSjDMVS+txv3AlSNtHQl2oNISLTeW15ektRdsHblrYW21JazjkpHyuJ9
 Q1UDKNT4TSUJZ1jQHN+4ASJzhRZKj8afr35MsQX4o+3V+Q3VbO8dAPEmk1lCUSDNvbyUuVx2pTm
 7vZ7dIeydP/4T6EaZd5Q23mmpW4BMPUeY4Mauc9/cPAisJZzHUGHm4QeE+OrTh5iWWyU6AHNKJI
 58oT4f1wKietFD1E0pw8fhZMjiVe+NN7+y2HpjDNab/HQ8Qe5rWvgBuSgGcZD2sosHdCmzWkrE9
 Z6lhzbo=
X-Received: by 2002:a17:907:c706:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b982f1ec96fmr515247466b.15.1774120858558; Sat, 21 Mar 2026
 12:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
 <CAFLszTjDnEoTP1fHdounqov_SYSDdr-Zpt7L_+-c9qb=c0F8JQ@mail.gmail.com>
 <CAJs94EYuFQJvdTjWZX1qWg9e7Qz_X_G7Bz017nucN1HtU1Mrcw@mail.gmail.com>
In-Reply-To: <CAJs94EYuFQJvdTjWZX1qWg9e7Qz_X_G7Bz017nucN1HtU1Mrcw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Mar 2026 13:20:47 -0600
X-Gm-Features: AaiRm51SfODNqAAKnpmw5vzoVnOKkcfMPWrmoB6xOJCELKPkvCqNXjabMWuMRoo
Message-ID: <CAFLszTj7g-pYE6+Fw7=Vip-1dw0QK7+1tgjuUzNK_J1Yi4mW+g@mail.gmail.com>
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

On Sat, 21 Mar 2026 at 11:20, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> I compile dtbo as the following;
>
> cpp -x assembler-with-cpp -I /home/matwey/lab/linux/include
> overlay.dtso overlay.i
> dtc -@ -O dtb -o overlay.dtbo overlay.i
>
> Decompiled overlay.dtbo looks like this:
>
> /dts-v1/;
>
> / {
>
>     fragment@0 {
>         target =3D <0xffffffff>;
>
>         __overlay__ {
>             status =3D "okay";
>         };
>     };
>
>     fragment@1 {
>         target =3D <0xffffffff>;
>
>         __overlay__ {
>             status =3D "okay";
>         };
>     };
>
>     fragment@2 {
>         target-path =3D "/";
>
>         __overlay__ {
>
>             i2c-gpio {
>                 compatible =3D "i2c-gpio";
>                 sda-gpios =3D <0xffffffff 0x08 0x00 0x06>;
>                 scl-gpios =3D <0xffffffff 0x08 0x0f 0x06>;
>                 i2c-gpio,delay-us =3D <0x02>;
>                 #address-cells =3D <0x01>;
>                 #size-cells =3D <0x00>;
>                 status =3D "okay";
>                 phandle =3D <0x01>;
>             };
>         };
>     };
>
>     __symbols__ {
>         i2c_gpio =3D "/fragment@2/__overlay__/i2c-gpio";
>     };
>
>     __fixups__ {
>         i2c0 =3D "/fragment@0:target:0";
>         i2c1 =3D "/fragment@1:target:0";
>         pio =3D "/fragment@2/__overlay__/i2c-gpio:sda-gpios:0",
> "/fragment@2/__overlay__/i2c-gpio:scl-gpios:0";
>     };
> };
>
>
> I am not sure about the size. How do I check it correctly? Now, I just do
>
> fdt resize 16384
>
> =D1=81=D0=B1, 21 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 18:02, S=
imon Glass <sjg@chromium.org>:
> >
> > Hi Matwey,
> >
> > On Sat, 21 Mar 2026 at 06:55, Matwey V. Kornilov
> > <matwey.kornilov@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > I am running U-boot 2026.01 with orangepi_zero2w config and I am
> > > trying to apply my hand-written dtbo via fdt apply.
> > > The issue is that the fdi apply command just hangs forever for me. Th=
e
> > > issue only appears when I try to append a new node to the root. How
> > > could I find what is going wrong here?
> > >
> > > The overlay source is the following:
> > >
> > > /dts-v1/;
> > > /plugin/;
> > >
> > > #include <dt-bindings/i2c/i2c.h>
> > > #include <dt-bindings/gpio/gpio.h>
> > >
> > >
> > > &i2c0 {
> > >     status =3D "okay";
> > > };
> > >
> > > &i2c1 {
> > >     status =3D "okay";
> > > };
> > >
> > > &{/} {
> > >     i2c_gpio: i2c-gpio {
> > >         compatible =3D "i2c-gpio";
> > >         sda-gpios =3D <&pio 8 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; =
// PI0  (29)
> > >         scl-gpios =3D <&pio 8 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;=
 // PI15 (31)
> > >         i2c-gpio,delay-us =3D <2>;        /* ~100 kHz */
> > >         #address-cells =3D <1>;
> > >         #size-cells =3D <0>;
> > >         status =3D "okay";
> > >     };
> > > };
> > >
> >
> > Can you provide thte dtc command you are using to build this? Is there
> > enough spare space in the dtb? I'm not sure what would cause it to
> > hang.
> >
> > Regards,
> > Simon

It might help to have the console log too. I can't see any way this
can hang unless the addreses are wrong and something important is
overwritten.

Try this to see the address:

fdt header

Compare to 'meminfo' so you can tell that there is nothing important
above the fdt. Also where do you load the overlay?

BTW U-Boot uses hex, so it should be 'fdt resize 4000'

Regards,
Simon
