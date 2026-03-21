Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C6109448A
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 17:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A725384008;
	Sat, 21 Mar 2026 18:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVLWXkJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B11784010; Sat, 21 Mar 2026 18:20:52 +0100 (CET)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C1A83FED
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 18:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12732e6a123so2772404c88.1
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 10:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774113649; cv=none;
 d=google.com; s=arc-20240605;
 b=WgvX9qu+YoSNQ21wfYGKx3hfyJrmTeCuuWEHnyGmEhlbdHH+Iff/YVD6cnW8UVjHKC
 qlLNK9Gad1B2McIROyraebYDLxaD+r9gV7qI70k+VpaenR9yYDuV3szZNhI2UgO6d0+a
 KDjWk/mr3n/8nHyTd4i/kcimJNqGmCDnB3YSLU5r9lNr/GtCESYMM33EBgcmiRPhvYjt
 BRP162UwA0lak0YQ7Bxenc7GHjsvUBo4E8H0J7subseUtHFYwVmHd0M1qZWoSCrdT5GG
 llagCQnCWBoVRjgNLPW3nrATO2YyDlCOs79WhGspGBS7o2NdbfXA5EnjrHqB/bEBAiV/
 MTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=00jFX9hnRgESRotSoajJcHq4zTU2Vqo/wj5f2uo9zLo=;
 fh=xB9JIAryxjwldGJ3NBJ4qnAb38ct+d9xEuHultImQco=;
 b=YoXuOdAL7WOD9sifBptyucd8r75fyVyPeaQBVChO2cOF8WmJ1EdCv4Z+/tk4sYTrza
 kCC50nVssxMCjB4mJUnzcdN14hgVqGrdX4RiGbmyxdr3ZC02NLSQc/kRdwz/jd3Lfoew
 ZvSgX9KXgc/lrSo0HNT9ikrVg6wTA6dWkyPZiQBJmSkDA87lVEZJXWNgGvCxcqn3y/zr
 fRPk2xjqNaXld8jxo6j6q3ityHU7guxgTZNDlNjeZbEt5kUEb7jnaz4UY7nMpVqqMxFp
 j7v554KM/Ia6YMmvqCVktnTp8P+ZEiWvWzL87bZ6Y6aLTw9qAkqJ3w+rYAPmoO6JBJgF
 L3BA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774113649; x=1774718449; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00jFX9hnRgESRotSoajJcHq4zTU2Vqo/wj5f2uo9zLo=;
 b=WVLWXkJ3YO9Liz68pk1RwFjCxaENsLuKTF06KduRPRGBC63cHTVn5ZU6qCLbkARZ0+
 tQ9W6TBqzS4w9aZztfRG9Ef/KUu2B4xJc8oj5oWW3ZDhsOF3vkwXnZxBodVZjC/2fARO
 +4sijpA3jVrYPqVOAhSZRIaT9N619lnmxPNJIF6RD961j6b64UnjRHd9Tft00t/awXP1
 vqp868h0G+mLsM5ZW6eqE/vspaIr2ULC5URag3VpMSraOngqPpBiAvXr/NNS/jOWuf8u
 PL3xAy+Olp4KoC1A6Yv1Hl7IuR6LVht7xSSMTq37jx96fAHFsGxHD7LSLTkzgyjLLN9/
 nDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774113649; x=1774718449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00jFX9hnRgESRotSoajJcHq4zTU2Vqo/wj5f2uo9zLo=;
 b=Kl4x8dPg7IuERgPSzSC81J0ydiMe706yQum3zvxJvX+9cxTzvZkDbM1UTfxitgpEXD
 imLZvwqn6QwOB/mRddRufkX8xDRbJ3jiN50LpyQU1biTNRFT3WXvB3+4SZW+5DSSlkoL
 aTM8VkFod6l0157ymahyx4/WwuxkJFRWsAvXLDx9uyb1jN344w/icJXjnwn1w4YrJ/dU
 r482nTJLLbQgCMNoc43ULxaYJC+e7/vsVR72AYJBkVSD3pONdPxayZ4LR+TYF9Gx8yGo
 7W4K/bQZkapG6ekkwKbpFYmJGY7u1Qdu5IPJgV5iJL28CqUZYUvi9VCoO/8ZUOtjKhUU
 DX7Q==
X-Gm-Message-State: AOJu0YyU42AGYVXcp31sz0SOoflhbIjagr6Dytx7d6une5CXJFqjnRw/
 7MlGdF35TzOS0j/K2qXixbWq+Mj/Tb2HhOikg85qif2EskcP5x3oFY0Vgu8vGfPrz6pl+1VEDB5
 Rti73h66QLiVdCJQn3DvtCyHRcE/pXp0=
X-Gm-Gg: ATEYQzxizpwh2+gvyMfvNsFf6oYRpSHDhU/1vE2W5SU+JKMfxwW6Egcdfjr5XV29HEB
 EVLmVE88YV3Az+YCoNFF+NpgpR3wZIBxVGnkaGuDkEheVGjz91wuP8X5F0CtHjl1bEd2vxhcBBI
 mkN4hkZSFtZCL+xAbC6NoUT8bOWb1zPXAnsssJGGcW1dfh3C0fNGbfETaSVdMgQOumIEa10Rdty
 Sbmw4f9S3bNs/n/IDQRhKpxcJ9pc7qWvrY2XR8Lx1fQYoXRK+BPjMM7SUoVcf7L3319Bi/qLJBy
 Z2Ec
X-Received: by 2002:a05:7022:327:b0:12a:7181:2f1c with SMTP id
 a92af1059eb24-12a72682797mr3055289c88.17.1774113648572; Sat, 21 Mar 2026
 10:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
 <CAFLszTjDnEoTP1fHdounqov_SYSDdr-Zpt7L_+-c9qb=c0F8JQ@mail.gmail.com>
In-Reply-To: <CAFLszTjDnEoTP1fHdounqov_SYSDdr-Zpt7L_+-c9qb=c0F8JQ@mail.gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sat, 21 Mar 2026 20:20:37 +0300
X-Gm-Features: AaiRm5168zaer9onD-_-KnHTvZrQjKzmTpjUkg2JVgD3dwN70kXgpQTrk5UZ5Xw
Message-ID: <CAJs94EYuFQJvdTjWZX1qWg9e7Qz_X_G7Bz017nucN1HtU1Mrcw@mail.gmail.com>
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

I compile dtbo as the following;

cpp -x assembler-with-cpp -I /home/matwey/lab/linux/include
overlay.dtso overlay.i
dtc -@ -O dtb -o overlay.dtbo overlay.i

Decompiled overlay.dtbo looks like this:

/dts-v1/;

/ {

    fragment@0 {
        target =3D <0xffffffff>;

        __overlay__ {
            status =3D "okay";
        };
    };

    fragment@1 {
        target =3D <0xffffffff>;

        __overlay__ {
            status =3D "okay";
        };
    };

    fragment@2 {
        target-path =3D "/";

        __overlay__ {

            i2c-gpio {
                compatible =3D "i2c-gpio";
                sda-gpios =3D <0xffffffff 0x08 0x00 0x06>;
                scl-gpios =3D <0xffffffff 0x08 0x0f 0x06>;
                i2c-gpio,delay-us =3D <0x02>;
                #address-cells =3D <0x01>;
                #size-cells =3D <0x00>;
                status =3D "okay";
                phandle =3D <0x01>;
            };
        };
    };

    __symbols__ {
        i2c_gpio =3D "/fragment@2/__overlay__/i2c-gpio";
    };

    __fixups__ {
        i2c0 =3D "/fragment@0:target:0";
        i2c1 =3D "/fragment@1:target:0";
        pio =3D "/fragment@2/__overlay__/i2c-gpio:sda-gpios:0",
"/fragment@2/__overlay__/i2c-gpio:scl-gpios:0";
    };
};


I am not sure about the size. How do I check it correctly? Now, I just do

fdt resize 16384

=D1=81=D0=B1, 21 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 18:02, Sim=
on Glass <sjg@chromium.org>:
>
> Hi Matwey,
>
> On Sat, 21 Mar 2026 at 06:55, Matwey V. Kornilov
> <matwey.kornilov@gmail.com> wrote:
> >
> > Hello,
> >
> > I am running U-boot 2026.01 with orangepi_zero2w config and I am
> > trying to apply my hand-written dtbo via fdt apply.
> > The issue is that the fdi apply command just hangs forever for me. The
> > issue only appears when I try to append a new node to the root. How
> > could I find what is going wrong here?
> >
> > The overlay source is the following:
> >
> > /dts-v1/;
> > /plugin/;
> >
> > #include <dt-bindings/i2c/i2c.h>
> > #include <dt-bindings/gpio/gpio.h>
> >
> >
> > &i2c0 {
> >     status =3D "okay";
> > };
> >
> > &i2c1 {
> >     status =3D "okay";
> > };
> >
> > &{/} {
> >     i2c_gpio: i2c-gpio {
> >         compatible =3D "i2c-gpio";
> >         sda-gpios =3D <&pio 8 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; //=
 PI0  (29)
> >         scl-gpios =3D <&pio 8 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /=
/ PI15 (31)
> >         i2c-gpio,delay-us =3D <2>;        /* ~100 kHz */
> >         #address-cells =3D <1>;
> >         #size-cells =3D <0>;
> >         status =3D "okay";
> >     };
> > };
> >
>
> Can you provide thte dtc command you are using to build this? Is there
> enough spare space in the dtb? I'm not sure what would cause it to
> hang.
>
> Regards,
> Simon



--=20
With best regards,
Matwey V. Kornilov
