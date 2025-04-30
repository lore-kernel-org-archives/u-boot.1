Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E294C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 05:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4876C8283E;
	Wed, 30 Apr 2025 07:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7lE3ld/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D10C82ACF; Wed, 30 Apr 2025 05:58:26 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C6E18283E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 05:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3105ef2a071so67660971fa.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745985503; x=1746590303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XxaCHjUO3GNosUAVJs0bk/0+7nWjA0ydj6GwsVfBDqY=;
 b=E7lE3ld/E6/rbajXXuz1MxUKrfaQ1VxTNJmDkgYNvBarrsxbdYAR7d41BbqmwJblt7
 1XDAEZIgBUWMNEiPpbVtg/DJLIhzkyC3bEgOiL92BxaxH0yqOtoQms3zio71rzFaaeQ/
 rnTGPTvnOfIOMIDV7Abwfb0AXa5XaTc7/nS0hYOKqKbpz+Xy7P2tTneArEQaS6YsQESj
 keXpO3ejVrxbsW97r2XKFRBMB7cWDvzHCpR1XuZaPdz7hKKbm4SizbsKvYCQ4FcoAgAI
 2Lyc8iOvCFNg0JUbT80S+5ZPRYznZF43TYanHM0Y5I/capIgBmBSgNFLb+rAcwqlJa34
 hEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745985503; x=1746590303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxaCHjUO3GNosUAVJs0bk/0+7nWjA0ydj6GwsVfBDqY=;
 b=HcgGoBVHY/anbCZArBlLWQLSDDz+JxofI0FrE7k9nbWWYzdhpqSeB4+j0h/wHJa8Wv
 zY/VBzg8WjG70VZn+MI6Bbh/bZSxWwx3V/w6Os5I7ERa6pIQuh/M/ktPALaMpbD0NPi5
 gEIbQD3r8Z6Wat34BH8KrLN+x74KtR5YTx5R5zcAmm73QgeAxgzdmIG/Sk8oU4Qeq4lZ
 nIjtRJAC/nx8ucjfrFk3JXkSochp53olX+kYbwuxsQ4XEYjjEEab9kz0IIZf1IqU1RKp
 w3tDJPQLwoqJWccatoribbpz0DPV/F1BDJgE6/tHkpF5wbMKlYhQgju4yLKJy4IND0Af
 0FEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXUVULyFyNSzVDTudBavQzdP3ppPsIScP9IEimDxxCtmsR4ttUOBUB9phJcmCdyx7l7rBST5U=@lists.denx.de
X-Gm-Message-State: AOJu0YzCg+qJSOkTwNxZ04jeE2E/9lHSn+wcHJkWvXN/p6sJ+m6zqsQL
 t7P4hPHw+oQ7pl0FKflgGv4Srf0N/9ou3xqM6Ac8SwmfWkM/FPIGsT5Jhfc0zGgnnpJGz7Wspba
 Ys1EdDH+02SoZWC22PTx3oDJKR5c=
X-Gm-Gg: ASbGnctfeuZkJ4vq7Ac0ZlWtPRKKWICr8pkvuYSSUY1JS0kwc3ZauMIU2h3+zKDEBMJ
 1MZiwBXgddkRGYwxKzX6Ftz4o1fDvYyesn3BlnPqAGaNSFtuZKZx9rHvtxSjWzndK0PwyvjPAn9
 EsRkpmPNdSjVOdxHqaOADHaLA=
X-Google-Smtp-Source: AGHT+IH3u8N0QElhkd+K2YNnnEz/X1BGN9qDmAC+HUt53KV2FF3gdQZcqGCO7WzVzOukhCdNmF5mT9b2CcNj5VB7JuU=
X-Received: by 2002:a05:651c:544:b0:300:5c57:526b with SMTP id
 38308e7fff4ca-31ea2daa17dmr2383131fa.11.1745985502488; Tue, 29 Apr 2025
 20:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
 <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org> <87v7qnwesw.fsf@kernel.org>
In-Reply-To: <87v7qnwesw.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Wed, 30 Apr 2025 11:58:09 +0800
X-Gm-Features: ATxdqUEkbwWMhG7CZiMd-qD33AFqN5JWn_pRvjVb-aVH56_YLdf5bRv3-Pe114o
Message-ID: <CADgMGSt5gRFymqX3mtpiAx77b3a_cH0_2kR+8-Y5SwT25XpeQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Wed, 30 Apr 2025 07:06:21 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Mattijs,
CC: Casey,

Thx for your reply.


=E5=9C=A8 2025=E5=B9=B44=E6=9C=8829=E6=97=A5=E9=80=B1=E4=BA=8C 16:30=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi George,
>
> Thank you for contributing.
>
> On lun., avril 28, 2025 at 15:53, Casey Connolly <
> casey.connolly@linaro.org> wrote:
>
> > Hi George,
> >
> > Thanks a lot for the series, it's super exciting to see support for
> > booting Android on top of U-Boot :D
> >
> > On 4/27/25 13:25, George Chan via B4 Relay wrote:
> >> This is a series of patches to enable chainloading LineageOS on qcom
> SOC.
> >>
> >> First patch is to workaround kernel/ramdisk invalid addr by identify
> >> its physical memory address out-of-range. Since qcom SOC usually have
> >> 0x80000000 as start/base/real memory address but androidboot img
> >> specified to around 0x0. If other vendor bootloader behave similar the=
n
> >> this patch can also workaround it as well.
> >
> > I'm curious to know what values are there, tbh I think U-Boot should
> > entirely ignore the values in the boot image but I guess that could
> > break some other platforms.
>
> Yes, some platforms actually use the values from the boot.img.
> We had some breakage on Khadas VIM3 in this area. See:
>
> https://lore.kernel.org/all/20241003-android-fix-boot-v2-v1-1-13e8e44af4b=
7@baylibre.com/
>
> The above thread also mentions how to repack a boot.img, where we can
> specify a different ramdisk address.
>
> It's a bit unclear to me why it's impractical to repack the boot.img and
> specify the appropriate address. Could you elaborate ?


It is hard to ask less experience people to modify the boot img....I do
prefer no mod is the best. Why get life so complicated, my friend?


> >
> > How about adding a config option CONFIG_ANDROID_BOOTIMG_IGNORE_ADDRS an=
d
> > just ORing it in all the places that have checks like
> > "img_data->kernel_addr =3D=3D 0". Then you can enable this for
> > mach-snapdragon by selecting it in the ARCH_SNAPDRAGON config definitio=
n.
>
> If we need to add this in U-Boot, I'd prefer this option as suggested by
> Casey.
>

No problem. If this approach have wider audience and also benefit other
soc/device, I am glad to know. Lets wait for user of below code and see if
any willingness to migrate.

https://github.com/u-boot/u-boot/blob/d75998b476de439a05b2f7ec95d426410bcaa=
e18/boot/image-android.c#L271

And

https://github.com/u-boot/u-boot/blob/d75998b476de439a05b2f7ec95d426410bcaa=
e18/boot/image-android.c#L281


> >
> >>
> >> Second patch is enable bootmeth-android to have chance for extra mem
> block.
> >> Usually the fastboot mem block, to hold androidboot img, and loadaddr
> for
> >> unzipped kernel. If other SOC have extra mem block available but
> >> fastboot block, we can add extra logic to take care of it.
> >
> > There is a small hack in mach-snapdragon that we put kernel_addr_r and
> > loadaddr at the same address to avoid using up too much memory on
> > devices that only have 1GB which explains this crash because we try to
> > decompress the kernel to the same address it got loaded too.
> >
> > I think we can get away with giving loadaddr its own allocation of 64M
> > or so, maybe 96. This would make your second patch redundant (and feels
> > like the right fix to me)
>
> I was not aware of this hack, but I agree with Casey.
>

Hmm... I have no idea/experience about it. Casey will you follow this issue
with a proper patch?


> >
> >>
> >> Third patch is optional to enable snapdragon board to have extra cmdli=
ne
> >> found from original bootloader that is required for LineageOS boot ini=
t.
> >> An alternate method is to put the append string into a dummy device-tr=
ee
> >> file, as /chosen/bootarg ofnode porperty, that also contain msm-id. Th=
en
> >> encapsulate as androidboot img and let u-boot as kernel binary. Below =
is
> >> an example for Xiaomi Miatoll device.
> >
> > I assume you're chainloading U-Boot on this device? If so, isn't it
> > enough to just copy the boot args that ABL gives us and maybe tweak a
> few?
> >
> > I'd also rather keep this constrained, maybe an android specific board
> > callback to set boot args (if there isn't one already) and have the FDT
> > fixup code be alongside some other generic FDT fixup stuff. I'd rather
> > not have this stuff in board specific code.
>
> I also agree with Casey here. Looking at patch: "[PATCH 3/3]
> mach-snapdragon: Add support to append string to kernel cmdline", the
> android bootmethod already takes care of some androidboot.* arguments.
> See:
>
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/boot/bootmeth_android.=
c?ref_type=3Dheads#L504
>
> For androidboot.verifiedbootstate=3Dorange, this is done via
> avb_append_commandline_arg() when AVB is enabled in U-Boot.
>

Reasonable. My plan is remove all default params. I still not decided to
let kconfig do it or leave it as a new env var. And put that post-pending
logic into fdt-support.c

Thx again,
George


> >
> > I hope this makes sense, feel free to ask for clarifications on anythin=
g.
> >
> > Thanks and kind regards,
> >
> >>
> >> /dts-v1/;
> >>
> >> / {
> >>          qcom,msm-id =3D <443 0x0>;
> >>          qcom,board-id =3D <0 0>,
> >>                      <0x10022 1>,
> >>                      <0x20022 1>,
> >>                      <0x30022 1>,
> >>                      <0x40022 1>,
> >>                      <0x50022 1>;
> >>
> >>          #address-cells =3D <2>;
> >>          #size-cells =3D <2>;
> >>
> >>          memory {
> >>                  ddr_device_type =3D <0x07>;
> >>                  /* We expect the bootloader to fill in the size */
> >>                  reg =3D <0 0 0 0>;
> >>          };
> >>
> >>      chosen {
> >>              bootargs =3D "";
> >>      };
> >> };
> >>
> >> Signed-off-by: George Chan <gchan9527@gmail.com>
> >> ---
> >> George Chan (3):
> >>        boot/image-android.c: Workaround androidboot kernel/ramdisk add=
r
> >>        boot/bootmeth-android.c: Reuse fastboot memory block for unzip
> kernel
> >>        mach-snapdragon: Add support to append string to kernel cmdline
> >>
> >>   arch/arm/mach-snapdragon/Kconfig | 11 +++++
> >>   arch/arm/mach-snapdragon/board.c | 97
> ++++++++++++++++++++++++++++++++++++++++
> >>   boot/bootmeth_android.c          | 12 +++++
> >>   boot/image-android.c             | 10 +++++
> >>   4 files changed, 130 insertions(+)
> >> ---
> >> base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
> >> change-id: 20250427-android-boot-ecbb768cda72
> >>
> >> Best regards,
> > --
> > Casey (she/they)
>
