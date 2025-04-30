Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03A8C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 12:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 860B682B7F;
	Wed, 30 Apr 2025 14:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QzFVfJR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F4282B45; Wed, 30 Apr 2025 14:03:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CAE82153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746014587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80SPIOkxMpI1E0S/H6ROoM3HWNqd5Wmg6EEagJmHnY4=;
 b=QzFVfJR63MGqUmHgmVi+BBnnDTlJdsCQZR51mqPwAFbbyibCkyFQAylkgs7XUEdiOtKiGv
 Lrh19w/GJUAsK+trX1ZNfPCYLtmQI1bo/vqfZ3rXdicZwqnyT+qHAIh2GGuIPMympoUX2+
 40KHALUTDumLCsnMf9mjqNcc2/x4a9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-TxWHnkTNO-S31A2sZ0Atew-1; Wed, 30 Apr 2025 08:03:06 -0400
X-MC-Unique: TxWHnkTNO-S31A2sZ0Atew-1
X-Mimecast-MFC-AGG-ID: TxWHnkTNO-S31A2sZ0Atew_1746014585
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3978ef9a284so2382093f8f.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 05:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746014585; x=1746619385;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FgjHmcc5b1UF/ZgUHB+OyzRPU/V5thX9VPaSfQ3OX0=;
 b=E4XE+jv1mSr7H8TydFLigABa64rqJbr59mpTqfaygc1409Vm98+MPg9eVjzIHFexHI
 TFUE4iQ7f+630BG0H1YxfJ6LhTw39y4mrheVcprxiJNWT+sISEalSbFCMmjhBNJUvGHt
 wfTIqSYw8+PSTnYJnTdQjLrTaR7vcrmqdQn3vRyEcXhzVubR+3/uL3eo4vrHo5HuAl6D
 4V8nZKYf+zHUtmp3FnG5vXti78R19NawYMnmqx49hZCA58Q4jNHTXfrnDiC8MsOX0kuB
 l3jvs2TcggGcMFPszRYHdXIdK51q9CpVS1uy7xPrODOg1yfOWRciBzDiRtdQrsVK2H68
 cnGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrEs6eytkE5bjBeGXgoCcboTM0r5zpNacZXaPqvaxpWgwZngrsboQhwVNUx2kYdXrWPPDPqKw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7CudkmfqtA3vX8wWicRfRSug8v8ng06pOA7YdZ9B9tstSu0fK
 swQbi03zpGr2DWaeM1kJ2aJLan8oTI1DBieNKPxQWPzK3tQtwkyxOtG0xPoxl8BkFbs4E6M6n/t
 edvgw1dei+vqN52M7oN79XCYfmv+R/wns8cMQsHqjU7MeWbKz3d0=
X-Gm-Gg: ASbGncuU5iP0sdNIuBwFvsTTaUXuf593HbSLT0LcjBWL8D5T4cJE3HTCfVxb2q67afc
 4835AdfhMsak9DjjfCJkDuvVWdUVDWFS1iwBMRKiTwje1qXJYHceN7ZOehT+tck/uaRnIhJs8re
 pDm3PPbOxKKuOK3XsB/jsHhJGZ5MiBu6u+H0WTdL78+lBd6EAb+puG2x0oAHMk0+HrGAx9VutYd
 ALuUC3AH3N2GPocudq+0f0xkFtC/8uBODwSWteuosrj3Mljl2z+MCFzfuwXZIOLf+0Qywo+hZcS
 4BG1wqnUCE1tB8Kgp64=
X-Received: by 2002:a05:6000:2284:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-3a08ff50af2mr2071533f8f.40.1746014584339; 
 Wed, 30 Apr 2025 05:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5vig1TRMt6hoHhj+gnEtw7Z7H1yMxvCuM0kxuaA1iGADODfIDZWxjqpYfY+KUqB07v2aZAw==
X-Received: by 2002:a05:6000:2284:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-3a08ff50af2mr2071432f8f.40.1746014583530; 
 Wed, 30 Apr 2025 05:03:03 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d52bsm17305486f8f.90.2025.04.30.05.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 05:03:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@redhat.com>
To: george chan <gchan9527@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
In-Reply-To: <CADgMGSt5gRFymqX3mtpiAx77b3a_cH0_2kR+8-Y5SwT25XpeQg@mail.gmail.com>
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
 <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org>
 <87v7qnwesw.fsf@kernel.org>
 <CADgMGSt5gRFymqX3mtpiAx77b3a_cH0_2kR+8-Y5SwT25XpeQg@mail.gmail.com>
Date: Wed, 30 Apr 2025 14:03:02 +0200
Message-ID: <87v7qlrh55.fsf@kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GnMBnnEVM1SiWiaR9nZ-XG5rxwB7CqZwS5-o95Ngpu4_1746014585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 30 Apr 2025 14:19:14 +0200
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

Hi George,

On mer., avril 30, 2025 at 11:58, george chan <gchan9527@gmail.com> wrote:

> Hi Mattijs,
> CC: Casey,
>
> Thx for your reply.
>
>
> =E5=9C=A8 2025=E5=B9=B44=E6=9C=8829=E6=97=A5=E9=80=B1=E4=BA=8C 16:30=EF=
=BC=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>> Hi George,
>>
>> Thank you for contributing.
>>
>> On lun., avril 28, 2025 at 15:53, Casey Connolly <
>> casey.connolly@linaro.org> wrote:
>>
>> > Hi George,
>> >
>> > Thanks a lot for the series, it's super exciting to see support for
>> > booting Android on top of U-Boot :D
>> >
>> > On 4/27/25 13:25, George Chan via B4 Relay wrote:
>> >> This is a series of patches to enable chainloading LineageOS on qcom
>> SOC.
>> >>
>> >> First patch is to workaround kernel/ramdisk invalid addr by identify
>> >> its physical memory address out-of-range. Since qcom SOC usually have
>> >> 0x80000000 as start/base/real memory address but androidboot img
>> >> specified to around 0x0. If other vendor bootloader behave similar th=
en
>> >> this patch can also workaround it as well.
>> >
>> > I'm curious to know what values are there, tbh I think U-Boot should
>> > entirely ignore the values in the boot image but I guess that could
>> > break some other platforms.
>>
>> Yes, some platforms actually use the values from the boot.img.
>> We had some breakage on Khadas VIM3 in this area. See:
>>
>> https://lore.kernel.org/all/20241003-android-fix-boot-v2-v1-1-13e8e44af4=
b7@baylibre.com/
>>
>> The above thread also mentions how to repack a boot.img, where we can
>> specify a different ramdisk address.
>>
>> It's a bit unclear to me why it's impractical to repack the boot.img and
>> specify the appropriate address. Could you elaborate ?
>
>
> It is hard to ask less experience people to modify the boot img....I do
> prefer no mod is the best. Why get life so complicated, my friend?

Sorry, In my opinion this is not a valid argument. Why is patching the
bootloader more complicated than repacking the boot.img ?

Can you maybe illustrate with a detailed example?

The offsets can also be configured via the Android build system directly
by modifying BOARD_MKBOOTIMG_ARGS, see:
https://cs.android.com/android/platform/superproject/main/+/main:device/aml=
ogic/yukawa/BoardConfig.mk;l=3D114?q=3DBOARD_MKBOOTIMG_ARGS&start=3D1
https://cs.android.com/android/platform/superproject/main/+/main:device/lin=
aro/dragonboard/linaro_swr/BoardConfig.mk;l=3D17?q=3DBOARD_MKBOOTIMG_ARGS&s=
tart=3D21

>
>
>> >
>> > How about adding a config option CONFIG_ANDROID_BOOTIMG_IGNORE_ADDRS a=
nd
>> > just ORing it in all the places that have checks like
>> > "img_data->kernel_addr =3D=3D 0". Then you can enable this for
>> > mach-snapdragon by selecting it in the ARCH_SNAPDRAGON config definiti=
on.
>>
>> If we need to add this in U-Boot, I'd prefer this option as suggested by
>> Casey.
>>
>
> No problem. If this approach have wider audience and also benefit other
> soc/device, I am glad to know. Lets wait for user of below code and see i=
f
> any willingness to migrate.
>
> https://github.com/u-boot/u-boot/blob/d75998b476de439a05b2f7ec95d426410bc=
aae18/boot/image-android.c#L271
>
> And
>
> https://github.com/u-boot/u-boot/blob/d75998b476de439a05b2f7ec95d426410bc=
aae18/boot/image-android.c#L281
>
>
>> >
>> >>
>> >> Second patch is enable bootmeth-android to have chance for extra mem
>> block.
>> >> Usually the fastboot mem block, to hold androidboot img, and loadaddr
>> for
>> >> unzipped kernel. If other SOC have extra mem block available but
>> >> fastboot block, we can add extra logic to take care of it.
>> >
>> > There is a small hack in mach-snapdragon that we put kernel_addr_r and
>> > loadaddr at the same address to avoid using up too much memory on
>> > devices that only have 1GB which explains this crash because we try to
>> > decompress the kernel to the same address it got loaded too.
>> >
>> > I think we can get away with giving loadaddr its own allocation of 64M
>> > or so, maybe 96. This would make your second patch redundant (and feel=
s
>> > like the right fix to me)
>>
>> I was not aware of this hack, but I agree with Casey.
>>
>
> Hmm... I have no idea/experience about it. Casey will you follow this iss=
ue
> with a proper patch?
>
>
>> >
>> >>
>> >> Third patch is optional to enable snapdragon board to have extra cmdl=
ine
>> >> found from original bootloader that is required for LineageOS boot in=
it.
>> >> An alternate method is to put the append string into a dummy device-t=
ree
>> >> file, as /chosen/bootarg ofnode porperty, that also contain msm-id. T=
hen
>> >> encapsulate as androidboot img and let u-boot as kernel binary. Below=
 is
>> >> an example for Xiaomi Miatoll device.
>> >
>> > I assume you're chainloading U-Boot on this device? If so, isn't it
>> > enough to just copy the boot args that ABL gives us and maybe tweak a
>> few?
>> >
>> > I'd also rather keep this constrained, maybe an android specific board
>> > callback to set boot args (if there isn't one already) and have the FD=
T
>> > fixup code be alongside some other generic FDT fixup stuff. I'd rather
>> > not have this stuff in board specific code.
>>
>> I also agree with Casey here. Looking at patch: "[PATCH 3/3]
>> mach-snapdragon: Add support to append string to kernel cmdline", the
>> android bootmethod already takes care of some androidboot.* arguments.
>> See:
>>
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/boot/bootmeth_android=
.c?ref_type=3Dheads#L504
>>
>> For androidboot.verifiedbootstate=3Dorange, this is done via
>> avb_append_commandline_arg() when AVB is enabled in U-Boot.
>>
>
> Reasonable. My plan is remove all default params. I still not decided to
> let kconfig do it or leave it as a new env var. And put that post-pending
> logic into fdt-support.c
>
> Thx again,
> George
>
>
>> >
>> > I hope this makes sense, feel free to ask for clarifications on anythi=
ng.
>> >
>> > Thanks and kind regards,
>> >
>> >>
>> >> /dts-v1/;
>> >>
>> >> / {
>> >>          qcom,msm-id =3D <443 0x0>;
>> >>          qcom,board-id =3D <0 0>,
>> >>                      <0x10022 1>,
>> >>                      <0x20022 1>,
>> >>                      <0x30022 1>,
>> >>                      <0x40022 1>,
>> >>                      <0x50022 1>;
>> >>
>> >>          #address-cells =3D <2>;
>> >>          #size-cells =3D <2>;
>> >>
>> >>          memory {
>> >>                  ddr_device_type =3D <0x07>;
>> >>                  /* We expect the bootloader to fill in the size */
>> >>                  reg =3D <0 0 0 0>;
>> >>          };
>> >>
>> >>      chosen {
>> >>              bootargs =3D "";
>> >>      };
>> >> };
>> >>
>> >> Signed-off-by: George Chan <gchan9527@gmail.com>
>> >> ---
>> >> George Chan (3):
>> >>        boot/image-android.c: Workaround androidboot kernel/ramdisk ad=
dr
>> >>        boot/bootmeth-android.c: Reuse fastboot memory block for unzip
>> kernel
>> >>        mach-snapdragon: Add support to append string to kernel cmdlin=
e
>> >>
>> >>   arch/arm/mach-snapdragon/Kconfig | 11 +++++
>> >>   arch/arm/mach-snapdragon/board.c | 97
>> ++++++++++++++++++++++++++++++++++++++++
>> >>   boot/bootmeth_android.c          | 12 +++++
>> >>   boot/image-android.c             | 10 +++++
>> >>   4 files changed, 130 insertions(+)
>> >> ---
>> >> base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
>> >> change-id: 20250427-android-boot-ecbb768cda72
>> >>
>> >> Best regards,
>> > --
>> > Casey (she/they)
>>

