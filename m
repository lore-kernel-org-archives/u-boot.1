Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3D1C71155
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 15:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4923286E6A;
	Fri, 18 Aug 2023 17:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YENSEgMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CD586E6E; Fri, 18 Aug 2023 17:10:50 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B0886DC3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 17:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fpidev23@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58dfdb0dfd6so631477b3.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692371445; x=1692976245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dGbLXC3cvg7B/mR8FpDnWDq3ZySxvyAxBt4SqENoxiw=;
 b=YENSEgMfSzeJhfsXKaU20PDulhS1a2Weatr3nQa/TxfeW9ALwZcfUm4NNKQ9M1LZUX
 Rd3z5GEpHn9xbVb9vA9x8Qa/9TVBmeu8KoOUgNrGiq7jiU8ZqWnk8gB0UyRSXj9m6iQJ
 JoH2fJvn6Nzll8pTUjLOCLnxXJmyGnMfGQE7N0UmG2sNq13ZkFY70R58nfXTMeX1K/Bp
 /rjTwDIlgVVKarEs1TJnCR19okqumzYQiso3RQ0tPVq2Q5KijFFfMaakEFaok5GGrXjn
 VD6mgxiF3LjvMWU/J8cL/eqXYLyCCcAclNSsXrK/5dPcPhhgRJeeFuw8tL3dPVLoJnFK
 mzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692371445; x=1692976245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dGbLXC3cvg7B/mR8FpDnWDq3ZySxvyAxBt4SqENoxiw=;
 b=Gvt8Yd4N4jQXCWIQnbCj6BK+ok1WYU9tgAQ1n+qRldpkNtFkU+IVaUgQHWKkIo+lZv
 kXRQJiL4vYsrPt+pRReC5xv0sgcuTcHAk/uXN405TC0g9cf/kKAAls9P5FLpdVI3WyPo
 qtdskiMzY9j6Ng+W9K1YT243/bIETsIyz+2+s3hd1HyhLoC8AbDKmeN6XqJhTacEe362
 v0Dsfmk8XeyhsxD34ql8Qm44xHCbSpJSanMMdLltPlryyIxn7IQMPAFB/5FTP3Sv56SM
 e6KBW4xJ/E26GywcOSmC0vy/btKvgUqN9WikFgAGR9K/MzJ1qGm8Gqskp42huyZMFEpf
 nzLw==
X-Gm-Message-State: AOJu0YxBIE04OqPifiLDc1vjIaJfgTZzd8UF5nPZK5mZyAUpzRn75b13
 TqDuK1FGjcrV3vWxkyDfmjMRKExMCuPnSMSjnes=
X-Google-Smtp-Source: AGHT+IFsG9TFUu7wyN97akxc0lI071i4GNT7Ij+y4sdBNQiKd41hMXqW37/4Pok1UlV/2q1A92ewKFZbOuG2y+QUbrs=
X-Received: by 2002:a81:8402:0:b0:589:7c72:13be with SMTP id
 u2-20020a818402000000b005897c7213bemr1895290ywf.4.1692371445557; Fri, 18 Aug
 2023 08:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2g9JMptku2ZMmWeYxvYeV_MXkFDknL3rTXueVJz3otYhE5hQ@mail.gmail.com>
 <CAPnjgZ1xraxjR56Peyqj8HL-HEg7pZ9EkrW2=NG+6vYG+qVfow@mail.gmail.com>
 <CAM2g9JN9J_i5G9ctaRrimGhSepLEoQ=c4c2VJAua+HzMkB25tA@mail.gmail.com>
 <CAPnjgZ2pcam0wMFnd43pRDwcDb3NEtckbgV6T_6CshPy4B2TdA@mail.gmail.com>
 <CAM2g9JM4M9HtNz5rXu57J0KNjz_BTmG_XmoSy+4EiHmW-J25qg@mail.gmail.com>
 <CAPnjgZ2-CfyNkHJwaL4uPyBnRTofgfXhtix2uLpr+a=t912xkA@mail.gmail.com>
 <CAM2g9JNW+rtE+zh=DFH39rg46MMc7Ct=On=0ZbObK3RdqdC94g@mail.gmail.com>
 <CAPnjgZ0xWN4V-_rPDFaq2M9EXrxPmrvE+uySqkUSwvMPySGhSg@mail.gmail.com>
 <CAM2g9JMfAGdC7t9AYUtupB=BxxkQyhaiNdtO4VnWV3=0V_cw4Q@mail.gmail.com>
 <CAPnjgZ2Mya9u3Knz_tydR=Gyuc1PT52kF=SosDwNpJ8iAT9JWA@mail.gmail.com>
 <CAM2g9JNPL1YXxBx5cqO23JyzRV7viHQ1FxROYKR-RijfeRVseA@mail.gmail.com>
 <CAPnjgZ2ArCugg8HemnWmn-D6=gYO-j4Tq8O4rWzZHrVke3aLDw@mail.gmail.com>
 <CAM2g9JMG2sUSGYuxU-_PjuydMvUxFeE1B7tUFft2MkU80X=LoA@mail.gmail.com>
In-Reply-To: <CAM2g9JMG2sUSGYuxU-_PjuydMvUxFeE1B7tUFft2MkU80X=LoA@mail.gmail.com>
From: Freddie <fpidev23@gmail.com>
Date: Fri, 18 Aug 2023 16:10:34 +0100
Message-ID: <CAM2g9JMffDt1uDMZ5u0jr-tLZWCrK-sP7LTimmkDA8xxGY1e1g@mail.gmail.com>
Subject: Re: FIT Image not working in U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Aug 17, 2023 at 4:55=E2=80=AFPM Freddie <fpidev23@gmail.com> wrote:

>
>
> On Thu, 17 Aug 2023 at 16:51, Simon Glass <sjg@chromium.org> wrote:
>
>> Hi Freddie,
>>
>> On Thu, 17 Aug 2023 at 09:02, Freddie <fpidev23@gmail.com> wrote:
>> >
>> >
>> >
>> > On Thu, Aug 17, 2023 at 3:13=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
>> >>
>> >> Hi Freddie,
>> >>
>> >> On Thu, 17 Aug 2023 at 07:57, Freddie <fpidev23@gmail.com> wrote:
>> >> >
>> >> >
>> >> >
>> >> > On Thu, Aug 17, 2023 at 2:45=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg>
>> wrote:
>> >> >>
>> >> >> Hi Freddie,
>> >> >>
>> >> >> On Thu, 17 Aug 2023 at 07:39, Freddie <fpidev23@gmail.com> wrote:
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> > On Thu, Aug 17, 2023 at 2:19=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org>
>> wrote:
>> >> >> >>
>> >> >> >> Hi Freddie,
>> >> >> >>
>> >> >> >> On Thu, 17 Aug 2023 at 07:02, Freddie <fpidev23@gmail.com>
>> wrote:
>> >> >> >> >
>> >> >> >> > Hi Simon,
>> >> >> >> >
>> >> >> >> > I'm quite new to this so sorry for asking so many questions
>> but where do I run the 'dump_image -l' command and which code should I l=
ook
>> into adding print statements to?
>> >> >> >>
>> >> >> >> One thing is to add your reply at the bottom, not the top.
>> >> >> >>
>> >> >> >> Actually it is 'dumpimage -l file.fit' to list the contents of
>> your
>> >> >> >> fit file called 'file.fit'.  The program is built in the tools/
>> >> >> >> directory or your build, or you can
>> >> >> >>
>> >> >> >> I mean if you are completely stumped, go to where the error is
>> >> >> >> generated and add lots of debugging around it. This is
>> >> >> >> boot_get_kernel() which is in v2021.10 is in common/bootm.c - s=
o
>> just
>> >> >> >> add lots of printf() stuff there, rebuild and run on the board
>> and see
>> >> >> >> if you can figure out what is wrong. From my side I am really n=
ot
>> >> >> >> sure.
>> >> >> >>
>> >> >> >> Feel free to share the FIT through a link if you like.
>> >> >> >>
>> >> >> >> Also, you could try using a simple FIT without the signature
>> part.
>> >> >> >>
>> >> >> >> >
>> >> >> >> > I have also just looked into my .config file and this is the
>> contents:
>> >> >> >> >
>> >> >> >> > #
>> >> >> >> > # Automatically generated file; DO NOT EDIT.
>> >> >> >> > # U-Boot 2021.10 Configuration
>> >> >> >> > #
>> >> >> >> >
>> >> >> >> [..]
>> >> >> >>
>> >> >> >> > #
>> >> >> >> > # Boot images
>> >> >> >> > #
>> >> >> >> > # CONFIG_ANDROID_BOOT_IMAGE is not set
>> >> >> >> > CONFIG_FIT=3Dy
>> >> >> >> > CONFIG_FIT_EXTERNAL_OFFSET=3D0x0
>> >> >> >> > CONFIG_FIT_FULL_CHECK=3Dy
>> >> >> >> > CONFIG_FIT_SIGNATURE=3Dy
>> >> >> >> > CONFIG_FIT_SIGNATURE_MAX_SIZE=3D0x10000000
>> >> >> >> > # CONFIG_FIT_RSASSA_PSS is not set
>> >> >> >> > # CONFIG_FIT_CIPHER is not set
>> >> >> >> > # CONFIG_FIT_VERBOSE is not set
>> >> >> >> > # CONFIG_FIT_BEST_MATCH is not set
>> >> >> >> > CONFIG_FIT_PRINT=3Dy
>> >> >> >> > # CONFIG_LEGACY_IMAGE_FORMAT is not set
>> >> >> >> > CONFIG_SUPPORT_RAW_INITRD=3Dy
>> >> >> >> > CONFIG_OF_BOARD_SETUP=3Dy
>> >> >> >> > # CONFIG_OF_SYSTEM_SETUP is not set
>> >> >> >> > # CONFIG_OF_STDOUT_VIA_ALIAS is not set
>> >> >> >> > CONFIG_SYS_EXTRA_OPTIONS=3D""
>> >> >> >> > CONFIG_HAVE_SYS_TEXT_BASE=3Dy
>> >> >> >> > CONFIG_ARCH_FIXUP_FDT_MEMORY=3Dy
>> >> >> >> > # CONFIG_CHROMEOS is not set
>> >> >> >> > # CONFIG_CHROMEOS_VBOOT is not set
>> >> >> >> >
>> >> >> >> [..]
>> >> >> >>
>> >> >> >> This has CONFIG_FIT and CONFIG_LEGACY_IMAGE_FORMAT is disabled
>> (since
>> >> >> >> you have signature verification on).
>> >> >> >>
>> >> >> >> Regards,
>> >> >> >> Simon
>> >> >> >
>> >> >> >
>> >> >> > Hi Simon,
>> >> >> >
>> >> >> > Thank you for your advice, I'll make sure to reply at the bottom
>> of the message from now on.
>> >> >> >
>> >> >> > I've run the dumpimage command and this was my output:
>> >> >> > root@freddie-pi-dev:/home/fit# ../optee/u-boot/tools/dumpimage
>> -l image.fit
>> >> >> > FIT description: RPi FIT Image
>> >> >> > Created:         Thu Aug  3 15:47:15 2023
>> >> >> >  Image 0 (kernel-1)
>> >> >> >   Description:  default kernel
>> >> >> >   Created:      Thu Aug  3 15:47:15 2023
>> >> >> >   Type:         Kernel Image
>> >> >> >   Compression:  uncompressed
>> >> >> >   Data Size:    20869632 Bytes =3D 20380.50 KiB =3D 19.90 MiB
>> >> >> >   Architecture: AArch64
>> >> >> >   OS:           Linux
>> >> >> >   Load Address: 0x12000000
>> >> >> >   Entry Point:  0x12000000
>> >> >> >   Hash algo:    sha1
>> >> >> >   Hash value:   08d43ed37129fa26e0f5f9d303a211b708c66783
>> >> >> >  Image 1 (tee-1)
>> >> >> >   Description:  atf
>> >> >> >   Created:      Thu Aug  3 15:47:15 2023
>> >> >> >   Type:         Standalone Program
>> >> >> >   Compression:  uncompressed
>> >> >> >   Data Size:    1257464 Bytes =3D 1227.99 KiB =3D 1.20 MiB
>> >> >> >   Architecture: AArch64
>> >> >> >   Load Address: 0x08400000
>> >> >> >   Entry Point:  0x08400000
>> >> >> >   Hash algo:    sha1
>> >> >> >   Hash value:   4907d9c33098b2767cd6bc4bc9836f2f913464c7
>> >> >> >  Image 2 (fdt-1)
>> >> >> >   Description:  device tree
>> >> >> >   Created:      Thu Aug  3 15:47:15 2023
>> >> >> >   Type:         Flat Device Tree
>> >> >> >   Compression:  uncompressed
>> >> >> >   Data Size:    32501 Bytes =3D 31.74 KiB =3D 0.03 MiB
>> >> >> >   Architecture: AArch64
>> >> >> >   Load Address: 0x01000000
>> >> >> >   Hash algo:    sha1
>> >> >> >   Hash value:   1b5bb266752cb247d89245c63bd041acfa34c7c0
>> >> >> >  Default Configuration: 'config-1'
>> >> >> >  Configuration 0 (config-1)
>> >> >> >   Description:  default configuration
>> >> >> >   Kernel:       kernel-1
>> >> >> >   FDT:          fdt-1
>> >> >> >   Loadables:    tee-1
>> >> >> >   Sign algo:    sha1,rsa2048:dev
>> >> >> >   Sign value:
>>  22cd61395ae659917626ef88ebf82429d6d592a7975cf48eb1e301f81c8f2a9ae60e203=
e283b8800971b72cd1b6bf93fb4f5f54d9bc4fb0f49ae0e48115ff087d8638f8080fdc9f72f=
bfdd2228d60dba33849a75dba6958a134eefb9441b43f6f8319b7885c052c7993a7c791fe0a=
cc577a629b04630060f02e24e82f9e5c8851c0df3d63da45ee5daeeabe198b990c2b8cbe248=
34763df299d8ed5a25cb90818caa23676e764d4d6e91e852451c1dae8a2946b9741e637b755=
6b6ebf27fa9e0ad5252909d13da67179b40f5097cc29c4ac1539c0fb89b567e8ee2d56ef927=
07d2a9d82a090d35c66cf23e8e66e5c8da5e197ec4a0dd771ef4a3246f6f499850
>> >> >> >   Timestamp:    Thu Aug  3 15:47:15 2023
>> >> >> >
>> >> >>
>> >> >> That looks fine
>> >> >>
>> >> >> >
>> >> >> > I have tried to use an unsigned FIT before, but I also ran into
>> the same error. In this case, do I simply disable the signature parts of
>> the config, enable the legacy image format option and make the new image
>> without any of the signing or are there other changes as well?
>> >> >>
>> >> >> Well no point in trying it then...you can normally just omit the
>> signing step.
>> >> >>
>> >> >> >
>> >> >> > Where would be an appropriate place to upload my FIT file to in
>> order to share a link?
>> >> >> >
>> >> >>
>> >> >> Google drive? Anything that allows public links.
>> >> >>
>> >> >> At this point, I think debugging it is the only option, as I
>> mentioned
>> >> >> earlier. I don't know what rpi doesn't enable FIT by default, but
>> >> >> perhaps there is some reason.
>> >> >>
>> >> >> Regards,
>> >> >> Simon
>> >> >
>> >> >
>> >> >
>> >> > Hi Simon,
>> >> >
>> >> > I have uploaded my FIT file to google drive:
>> >> >
>> https://drive.google.com/file/d/1Q4GMcrT8tzCCznPe1X_5JA3LLFarW6iO/view?u=
sp=3Ddrive_link
>> >> >
>> >> > I will now try and do some debugging, thank you very much for your
>> help.
>> >>
>> >> Your image works fine on my rpi_3 with v2021.10 and CONFIG_FIT but I
>> >> am using the 32-bit build. I am not sure of the magic needed to make
>> >> it boot 64-bit.
>> >>
>> >> I notice that your build date is two weeks ago...are you sure you are
>> >> putting the new U-Boot on the board?
>> >>
>> >> Regards,
>> >> Simon
>> >
>> >
>> > Hi Simon,
>> >
>> > Thank you very much for testing the file, I shall try and use the 32
>> bit version of U-Boot on my pi and see if this works. How would I go abo=
ut
>> switching to the 32-bit version?
>>
>> I wouldn't worry about that for now as I can't imagine it will help.
>>
>> >
>> > I think I might have accidentally sent an older FIT file from my
>> computer, but I have created the images the same way every time and they
>> are identical so this shouldn't be an issue. Is this what you mean about=
 it
>> being 2 weeks ago?
>>
>> Well, try building U-Boot again, and boot it, to make sure that you
>> have the correct version (i.e. the build tag shows today).
>>
>> Regards,
>> Simon
>>
> Hi Simon,
>
> Unfortunately, I am out of office now, but I will try this when I=E2=80=
=99m in
> again tomorrow.
>
> Thank you once again for your help
>
> Regards,
> Freddie
>

Hi Simon,

I have built U-Boot on its own, completely separate from the OPTEE
instructions and have then overwritten the OPTEE files with this.

This has worked completely and so my next step is to ensure it is
reproducible.

I will make sure to post my findings on this to the appropriate forums as
I=E2=80=99m sure this will be of use to the community.

I=E2=80=99d like to once again thank you for your help, I really appreciate=
 it.

Many thanks,
Freddie

>
