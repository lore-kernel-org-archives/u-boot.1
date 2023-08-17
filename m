Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DC6C2FC2D
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F1386B55;
	Thu, 17 Aug 2023 15:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D31V+Wfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECE186B58; Thu, 17 Aug 2023 15:45:02 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1505186B4D
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58c6b6b4953so21326617b3.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279899; x=1692884699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58JnLbginDhTiA+Eh0YljyJO6SDvElN0LWnG7R0T3hE=;
 b=D31V+WflhtiVCgwMG2QjVllLo7VhGjJglp72JbL7fSvdRYrt/695s8DSKWw0HpgMcC
 a1EwNlXGP4CQE5Z4YHWWzvUWRN2gnU1NYyzcXyTkE8WebI8knEqmBco2HhwmAjhmNUH9
 0WQSGw3WwQxwBPcq1ksDA4k1mjPuXqIXQF3VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279899; x=1692884699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58JnLbginDhTiA+Eh0YljyJO6SDvElN0LWnG7R0T3hE=;
 b=bqg8TgjrCqUtkq8XrzqnbqpE5ZH0WL5iUB2dsxSWP6JJbBQ3E4hfd0VDq/0mt75f6V
 p61xpuqq7lz2YlvG9i0CssEHnke5sE8TLURfyHIjdu9rPEatfaOTGlfhsD5hpYI8P4vW
 LrYH7jDl8Vp72Yd+yvpn2/mPPvoaaXXQ3jK4137Zs+C09APvnh3OE+wW5ysL2cRWQqwx
 DAulSaG2wNif3guK6SvPaVjYl5VCChwSn3qnkI9sYTs77H9GR7NCYsS8iObeJ/i39eSn
 qnkXU8E2SKiwreq6JBf2RweZWT46hBJBUh8jkJ5lVhZZHxtuiZZ6IEq/L4NKdOPNDvO0
 dArw==
X-Gm-Message-State: AOJu0Yz4FzwG5rEs7GD36Jn5nFv6Trfvt70ypUWDBoSkR3EK/mZT24Fr
 iVdfeZOzGokvt57Ql+xDCfYsF+Oi3i8Yy9D89xy1gw==
X-Google-Smtp-Source: AGHT+IEVBwYQ0m2M5k7scz8E+L1D1eWygSvlvqQ0UhWWBE6X+fQfVuGx//eW1ZEuxCcRr5/4CUuvuO1TMX6+2QcgxmE=
X-Received: by 2002:a25:69c8:0:b0:c4c:bff1:2f87 with SMTP id
 e191-20020a2569c8000000b00c4cbff12f87mr5234254ybc.15.1692279898536; Thu, 17
 Aug 2023 06:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2g9JMptku2ZMmWeYxvYeV_MXkFDknL3rTXueVJz3otYhE5hQ@mail.gmail.com>
 <CAPnjgZ1xraxjR56Peyqj8HL-HEg7pZ9EkrW2=NG+6vYG+qVfow@mail.gmail.com>
 <CAM2g9JN9J_i5G9ctaRrimGhSepLEoQ=c4c2VJAua+HzMkB25tA@mail.gmail.com>
 <CAPnjgZ2pcam0wMFnd43pRDwcDb3NEtckbgV6T_6CshPy4B2TdA@mail.gmail.com>
 <CAM2g9JM4M9HtNz5rXu57J0KNjz_BTmG_XmoSy+4EiHmW-J25qg@mail.gmail.com>
 <CAPnjgZ2-CfyNkHJwaL4uPyBnRTofgfXhtix2uLpr+a=t912xkA@mail.gmail.com>
 <CAM2g9JNW+rtE+zh=DFH39rg46MMc7Ct=On=0ZbObK3RdqdC94g@mail.gmail.com>
In-Reply-To: <CAM2g9JNW+rtE+zh=DFH39rg46MMc7Ct=On=0ZbObK3RdqdC94g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:44:45 -0600
Message-ID: <CAPnjgZ0xWN4V-_rPDFaq2M9EXrxPmrvE+uySqkUSwvMPySGhSg@mail.gmail.com>
Subject: Re: FIT Image not working in U-Boot
To: Freddie <fpidev23@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Freddie,

On Thu, 17 Aug 2023 at 07:39, Freddie <fpidev23@gmail.com> wrote:
>
>
>
> On Thu, Aug 17, 2023 at 2:19=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
>>
>> Hi Freddie,
>>
>> On Thu, 17 Aug 2023 at 07:02, Freddie <fpidev23@gmail.com> wrote:
>> >
>> > Hi Simon,
>> >
>> > I'm quite new to this so sorry for asking so many questions but where =
do I run the 'dump_image -l' command and which code should I look into addi=
ng print statements to?
>>
>> One thing is to add your reply at the bottom, not the top.
>>
>> Actually it is 'dumpimage -l file.fit' to list the contents of your
>> fit file called 'file.fit'.  The program is built in the tools/
>> directory or your build, or you can
>>
>> I mean if you are completely stumped, go to where the error is
>> generated and add lots of debugging around it. This is
>> boot_get_kernel() which is in v2021.10 is in common/bootm.c - so just
>> add lots of printf() stuff there, rebuild and run on the board and see
>> if you can figure out what is wrong. From my side I am really not
>> sure.
>>
>> Feel free to share the FIT through a link if you like.
>>
>> Also, you could try using a simple FIT without the signature part.
>>
>> >
>> > I have also just looked into my .config file and this is the contents:
>> >
>> > #
>> > # Automatically generated file; DO NOT EDIT.
>> > # U-Boot 2021.10 Configuration
>> > #
>> >
>> [..]
>>
>> > #
>> > # Boot images
>> > #
>> > # CONFIG_ANDROID_BOOT_IMAGE is not set
>> > CONFIG_FIT=3Dy
>> > CONFIG_FIT_EXTERNAL_OFFSET=3D0x0
>> > CONFIG_FIT_FULL_CHECK=3Dy
>> > CONFIG_FIT_SIGNATURE=3Dy
>> > CONFIG_FIT_SIGNATURE_MAX_SIZE=3D0x10000000
>> > # CONFIG_FIT_RSASSA_PSS is not set
>> > # CONFIG_FIT_CIPHER is not set
>> > # CONFIG_FIT_VERBOSE is not set
>> > # CONFIG_FIT_BEST_MATCH is not set
>> > CONFIG_FIT_PRINT=3Dy
>> > # CONFIG_LEGACY_IMAGE_FORMAT is not set
>> > CONFIG_SUPPORT_RAW_INITRD=3Dy
>> > CONFIG_OF_BOARD_SETUP=3Dy
>> > # CONFIG_OF_SYSTEM_SETUP is not set
>> > # CONFIG_OF_STDOUT_VIA_ALIAS is not set
>> > CONFIG_SYS_EXTRA_OPTIONS=3D""
>> > CONFIG_HAVE_SYS_TEXT_BASE=3Dy
>> > CONFIG_ARCH_FIXUP_FDT_MEMORY=3Dy
>> > # CONFIG_CHROMEOS is not set
>> > # CONFIG_CHROMEOS_VBOOT is not set
>> >
>> [..]
>>
>> This has CONFIG_FIT and CONFIG_LEGACY_IMAGE_FORMAT is disabled (since
>> you have signature verification on).
>>
>> Regards,
>> Simon
>
>
> Hi Simon,
>
> Thank you for your advice, I'll make sure to reply at the bottom of the m=
essage from now on.
>
> I've run the dumpimage command and this was my output:
> root@freddie-pi-dev:/home/fit# ../optee/u-boot/tools/dumpimage -l image.f=
it
> FIT description: RPi FIT Image
> Created:         Thu Aug  3 15:47:15 2023
>  Image 0 (kernel-1)
>   Description:  default kernel
>   Created:      Thu Aug  3 15:47:15 2023
>   Type:         Kernel Image
>   Compression:  uncompressed
>   Data Size:    20869632 Bytes =3D 20380.50 KiB =3D 19.90 MiB
>   Architecture: AArch64
>   OS:           Linux
>   Load Address: 0x12000000
>   Entry Point:  0x12000000
>   Hash algo:    sha1
>   Hash value:   08d43ed37129fa26e0f5f9d303a211b708c66783
>  Image 1 (tee-1)
>   Description:  atf
>   Created:      Thu Aug  3 15:47:15 2023
>   Type:         Standalone Program
>   Compression:  uncompressed
>   Data Size:    1257464 Bytes =3D 1227.99 KiB =3D 1.20 MiB
>   Architecture: AArch64
>   Load Address: 0x08400000
>   Entry Point:  0x08400000
>   Hash algo:    sha1
>   Hash value:   4907d9c33098b2767cd6bc4bc9836f2f913464c7
>  Image 2 (fdt-1)
>   Description:  device tree
>   Created:      Thu Aug  3 15:47:15 2023
>   Type:         Flat Device Tree
>   Compression:  uncompressed
>   Data Size:    32501 Bytes =3D 31.74 KiB =3D 0.03 MiB
>   Architecture: AArch64
>   Load Address: 0x01000000
>   Hash algo:    sha1
>   Hash value:   1b5bb266752cb247d89245c63bd041acfa34c7c0
>  Default Configuration: 'config-1'
>  Configuration 0 (config-1)
>   Description:  default configuration
>   Kernel:       kernel-1
>   FDT:          fdt-1
>   Loadables:    tee-1
>   Sign algo:    sha1,rsa2048:dev
>   Sign value:   22cd61395ae659917626ef88ebf82429d6d592a7975cf48eb1e301f81=
c8f2a9ae60e203e283b8800971b72cd1b6bf93fb4f5f54d9bc4fb0f49ae0e48115ff087d863=
8f8080fdc9f72fbfdd2228d60dba33849a75dba6958a134eefb9441b43f6f8319b7885c052c=
7993a7c791fe0acc577a629b04630060f02e24e82f9e5c8851c0df3d63da45ee5daeeabe198=
b990c2b8cbe24834763df299d8ed5a25cb90818caa23676e764d4d6e91e852451c1dae8a294=
6b9741e637b7556b6ebf27fa9e0ad5252909d13da67179b40f5097cc29c4ac1539c0fb89b56=
7e8ee2d56ef92707d2a9d82a090d35c66cf23e8e66e5c8da5e197ec4a0dd771ef4a3246f6f4=
99850
>   Timestamp:    Thu Aug  3 15:47:15 2023
>

That looks fine

>
> I have tried to use an unsigned FIT before, but I also ran into the same =
error. In this case, do I simply disable the signature parts of the config,=
 enable the legacy image format option and make the new image without any o=
f the signing or are there other changes as well?

Well no point in trying it then...you can normally just omit the signing st=
ep.

>
> Where would be an appropriate place to upload my FIT file to in order to =
share a link?
>

Google drive? Anything that allows public links.

At this point, I think debugging it is the only option, as I mentioned
earlier. I don't know what rpi doesn't enable FIT by default, but
perhaps there is some reason.

Regards,
Simon
