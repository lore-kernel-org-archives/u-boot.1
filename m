Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126A2FC72BE
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 11:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC8083FC6;
	Sun, 22 Mar 2026 12:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MaMSGa9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A4F83FDC; Sun, 22 Mar 2026 12:03:53 +0100 (CET)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8549483FA7
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 12:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-12a80c36350so432214c88.1
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 04:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774177430; cv=none;
 d=google.com; s=arc-20240605;
 b=fTcin3OnanCQpFMDOZCvKvGaru5gsDL0YL4CjitlEe23ZAkBbrSlBPE+2oLBf7csEJ
 4IizdihH25wSI0qBdosEMRIETG2Fk+7i24ZEgPC5GTnOjUuISfIHM7ay2wHVk0qb7Kvc
 XAYZO7Zt0iqnSkluBO8tEg1y+l9MPpiLEUrzEPk6lwg8gP+ALc2nNPsBtYYSGDoAjC15
 2zlKQRUwF5+8e5DKggCKAY0EkKPbhSfchGGfRZqQ8BgF/9oZW2RnFogORXGVQGdvJ6vZ
 kZKZZYwFfevjBqnzwettXfU9U2Fo2/CsbCuGoWNPtlMn9EGCOoxVdaAqqerAv710RN6c
 1JOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=seVmSUOATdzRVQOI6GR2eAnYkWJG3bCULR6psE3ot0A=;
 fh=xB9JIAryxjwldGJ3NBJ4qnAb38ct+d9xEuHultImQco=;
 b=CEjJvRmbFj92uB/RD5UWLE8HJG+yiMJf1YaXMzI5BNQA6muiJLCMIHiXxlmiGnvpgH
 mMkMrP6WW4krpMbdcvpBO4Wwi7TTZKWaD3qu7TrIuDZ3WNrboLAor0+AnXuShK/A4JG4
 vEDjsTkW2LCULaa6xxOKD3tFAJkurFsKj6OuZky++zqAOUTXXJg/EOuUdoBFTP3qAgtT
 rFPhMJ+rtYX0kA9NwDIoyMOj92PqG1ngq+dRYuBwtduqbqmK8V6n/MgBgA8A2thX20g9
 XnAHZcauGpUYU+MOlMRtDsmyhNeN+5q2BNF/1uZCoyuiYAtftDh37EN5DqP+wYWIkwQs
 uZnw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774177430; x=1774782230; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seVmSUOATdzRVQOI6GR2eAnYkWJG3bCULR6psE3ot0A=;
 b=MaMSGa9xI48qvxO+qsvAUG4rhojoW1wanw+nCtghofaXy3ErmfbdK3M9ygDFTZEVD3
 tcFpjBpodL/jaxkA4YlKZYz86tsTK2dr3KW4jSbI4Bc8yDWiv/CLyqvwPSwe8NuaLgaw
 gJszAmo+Qh+ugSUoxEnO5s2QJBZgpMzcsBsa65q9RuKwMxCbTyh5fMyzT0yPH/zHKITo
 GN7ruYGtzTYqdFzuiQOrlzt6V2eS2zudsEHDazKBwBAayxL3utd4Rlujm+/Im4DAv/De
 Rr3CnJpaNaXKfjfHij/jay1nGGAgqdWS8zEV8nbDjbHbY3rZQ2SdVJanOipw+UzDH0iu
 vdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774177430; x=1774782230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=seVmSUOATdzRVQOI6GR2eAnYkWJG3bCULR6psE3ot0A=;
 b=JUptmQuDHaeDJE/ybfqkvj0uY+y2zY8559LbzwIWT8nQyf72y9A1tLqClHUhBYAl+7
 aphlaV0er9CTsUyYlNzGods6Vz9YgqntKh9/vkk5Ws04Bo4LPvCcO7Mr8HQUggewAZpe
 lNH9qp7OQ/NdJKcdzo5pQYt8ocpVFNS4QV757yVHM6jFZp9R2MOdCLyBqFfuJxVi8NHX
 75byhnUHpAYIHAICgzc9mZfoZPDQCiJu9DE+vtE1COZkPU/w0qT7be+wfvmU2heecQwT
 oPh7QtNM/r7rRMqgmmn9FOvAgJtRCM7rHijss697By9H1Lmqu+05DpSA5x0MIly01O6a
 xdaA==
X-Gm-Message-State: AOJu0YwzPkz/Eq2mFHCxrpZbIK2YW7n7vCVNCts+XLKF6INdhMc6Yzfe
 MCOm4S7xsYTcPn6eIRrJxO/pjXQpry1eaIFpXzyh12kSU9J6CGJSugpfpKkFVAnE/f+yw6C/etL
 tc/M6RqrxjsLotkL1qwULh8Q+s73+a29Xend+K28=
X-Gm-Gg: ATEYQzwgNfd0q0TbYs0xvMOkVj1m5q41WXVDp1Nh1Kg+oR7P6KgdAduVL1OvchqcQiO
 /eaD1/7YaQPecb1H4rD05mtU8M66k9M1KvgUlPoWXTaolcEoPuJSK+mkrI82938pRBn5IZiIvZB
 5iX88unML1xUl6dTTnRNx/Rj/vDwF2AzSQ5/1L27ejucL82icxH6PPL3XLH7faENCYWgWUuQPwx
 Sjd8ZsB6tfVY8KhWDZnswjliAFREfYnKLCiS/48EQNnUY5uuVOOk43k2GF8e3xBXplwFJpW2ypf
 4Ltz
X-Received: by 2002:a05:7022:48:b0:12a:7165:7408 with SMTP id
 a92af1059eb24-12a726755d9mr4498865c88.18.1774177429746; Sun, 22 Mar 2026
 04:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
 <CAFLszTjDnEoTP1fHdounqov_SYSDdr-Zpt7L_+-c9qb=c0F8JQ@mail.gmail.com>
 <CAJs94EYuFQJvdTjWZX1qWg9e7Qz_X_G7Bz017nucN1HtU1Mrcw@mail.gmail.com>
 <CAFLszTj7g-pYE6+Fw7=Vip-1dw0QK7+1tgjuUzNK_J1Yi4mW+g@mail.gmail.com>
In-Reply-To: <CAFLszTj7g-pYE6+Fw7=Vip-1dw0QK7+1tgjuUzNK_J1Yi4mW+g@mail.gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sun, 22 Mar 2026 14:03:38 +0300
X-Gm-Features: AaiRm52nsXB4Uw1-n7h3tmOLqGsls8CiQCwNGv_IP7fgS57GINDQ9L1CKd3HF5g
Message-ID: <CAJs94EZk3avSo=Oxdr4yqXCHDApvwUhR1VcUFf4GJ=Pq=O8CZA@mail.gmail.com>
Subject: Re: Need help with FDT overlay
To: Simon Glass <sjg@chromium.org>
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

=D1=81=D0=B1, 21 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 22:21, Sim=
on Glass <sjg@chromium.org>:
>
> Hi Matwey,
>
> On Sat, 21 Mar 2026 at 11:20, Matwey V. Kornilov
> <matwey.kornilov@gmail.com> wrote:
> >
> > I compile dtbo as the following;
> >
> > cpp -x assembler-with-cpp -I /home/matwey/lab/linux/include
> > overlay.dtso overlay.i
> > dtc -@ -O dtb -o overlay.dtbo overlay.i
> >
> > Decompiled overlay.dtbo looks like this:
> >
> > /dts-v1/;
> >
> > / {
> >
> >     fragment@0 {
> >         target =3D <0xffffffff>;
> >
> >         __overlay__ {
> >             status =3D "okay";
> >         };
> >     };
> >
> >     fragment@1 {
> >         target =3D <0xffffffff>;
> >
> >         __overlay__ {
> >             status =3D "okay";
> >         };
> >     };
> >
> >     fragment@2 {
> >         target-path =3D "/";
> >
> >         __overlay__ {
> >
> >             i2c-gpio {
> >                 compatible =3D "i2c-gpio";
> >                 sda-gpios =3D <0xffffffff 0x08 0x00 0x06>;
> >                 scl-gpios =3D <0xffffffff 0x08 0x0f 0x06>;
> >                 i2c-gpio,delay-us =3D <0x02>;
> >                 #address-cells =3D <0x01>;
> >                 #size-cells =3D <0x00>;
> >                 status =3D "okay";
> >                 phandle =3D <0x01>;
> >             };
> >         };
> >     };
> >
> >     __symbols__ {
> >         i2c_gpio =3D "/fragment@2/__overlay__/i2c-gpio";
> >     };
> >
> >     __fixups__ {
> >         i2c0 =3D "/fragment@0:target:0";
> >         i2c1 =3D "/fragment@1:target:0";
> >         pio =3D "/fragment@2/__overlay__/i2c-gpio:sda-gpios:0",
> > "/fragment@2/__overlay__/i2c-gpio:scl-gpios:0";
> >     };
> > };
> >
> >
> > I am not sure about the size. How do I check it correctly? Now, I just =
do
> >
> > fdt resize 16384
> >
> > =D1=81=D0=B1, 21 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 18:02,=
 Simon Glass <sjg@chromium.org>:
> > >
> > > Hi Matwey,
> > >
> > > On Sat, 21 Mar 2026 at 06:55, Matwey V. Kornilov
> > > <matwey.kornilov@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I am running U-boot 2026.01 with orangepi_zero2w config and I am
> > > > trying to apply my hand-written dtbo via fdt apply.
> > > > The issue is that the fdi apply command just hangs forever for me. =
The
> > > > issue only appears when I try to append a new node to the root. How
> > > > could I find what is going wrong here?
> > > >
> > > > The overlay source is the following:
> > > >
> > > > /dts-v1/;
> > > > /plugin/;
> > > >
> > > > #include <dt-bindings/i2c/i2c.h>
> > > > #include <dt-bindings/gpio/gpio.h>
> > > >
> > > >
> > > > &i2c0 {
> > > >     status =3D "okay";
> > > > };
> > > >
> > > > &i2c1 {
> > > >     status =3D "okay";
> > > > };
> > > >
> > > > &{/} {
> > > >     i2c_gpio: i2c-gpio {
> > > >         compatible =3D "i2c-gpio";
> > > >         sda-gpios =3D <&pio 8 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>=
; // PI0  (29)
> > > >         scl-gpios =3D <&pio 8 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)=
>; // PI15 (31)
> > > >         i2c-gpio,delay-us =3D <2>;        /* ~100 kHz */
> > > >         #address-cells =3D <1>;
> > > >         #size-cells =3D <0>;
> > > >         status =3D "okay";
> > > >     };
> > > > };
> > > >
> > >
> > > Can you provide thte dtc command you are using to build this? Is ther=
e
> > > enough spare space in the dtb? I'm not sure what would cause it to
> > > hang.
> > >
> > > Regards,
> > > Simon
>
> It might help to have the console log too. I can't see any way this
> can hang unless the addreses are wrong and something important is
> overwritten.
>
> Try this to see the address:
>
> fdt header
>
> Compare to 'meminfo' so you can tell that there is nothing important
> above the fdt. Also where do you load the overlay?
>

Hi,

I guess I found my mistake. I've been trying to apply the overlay to
${fdtcontroladdr}. It has been working while I updated only existing
nodes.

Now, I do the following:

cp.b ${fdtcontroladdr} ${fdt_addr_r} 0x8000
fdt addr ${fdt_addr_r}
fdt resize 10000
fdt apply ${fdtoverlay_addr_r}

I am not sure if there is a better way


> BTW U-Boot uses hex, so it should be 'fdt resize 4000'

Then doc/usage/fdt_overlays.rst should be improved because now it says
'fdt resize 8192'.

>
> Regards,
> Simon



--=20
With best regards,
Matwey V. Kornilov
