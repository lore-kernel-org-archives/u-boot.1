Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D579E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B6A8021D;
	Thu, 19 Dec 2024 16:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AiTHmoYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1F88021D; Thu, 19 Dec 2024 16:07:20 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6C18021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so165330166b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620838; x=1735225638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=827JXMyDIr0oQ2arh+OA9tXQKUS7722myEjunarIXeQ=;
 b=AiTHmoYKBBe0FPWp4kDl/WLp0IpSRKHRNFfo9RcL1Y1Ck+UlWqhr7yrLXceCokmyHT
 HmkJte4ad4uNvPf63TZ4VofHL4nRQXM6i7pAuK+H6lNyxEkCjG1bhq4F+z1TgcEyqO3M
 M22BIkjPJMbyo9fnoUWeGUPeZDLQFC8IZFCkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620838; x=1735225638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=827JXMyDIr0oQ2arh+OA9tXQKUS7722myEjunarIXeQ=;
 b=Jsdacu3avd6PWtomwoRb/9T1rdCs446YlKDhIzCthM6CPSMcRaEeUHor8CZZaNyE6v
 YPwjd4+Uen+B+voTWqe0zrdUi+Re97bj110Kp9LxPNcz1CQTBZWTMFhF3NEdVMiUBa+R
 zey+ugjHVlXIbdROlxnMN6/3akj0pHfxjv1CvcN547eSoe8/VCF3dRMs6TNYh3juUGY3
 NSPxOsa66sMh6L3XLmO3nXm1k64a/l5+09z2HsCi6zWBUSgtxkS6sqwZ//QGm2ZP04DC
 Yhtsoe6YP2/L9Y8UJnCl0onSHNaYdzlT+ZTuoMZny3/aHiveyMaZpywSlPJGrcUbgld0
 +6hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlwqvufGrGEiOFbKrJOzNgzobmYKYsvtADRrnJIUYBTlrhhxz0wDSQhwp7LBsvsS2gS8eYjn8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0JBbFGYbGqPJMMb38SLLM/EhFXHH4g+uZs4ci9m+SvlmT+I9n
 T0xWt43B5UAvW2Rzpcn5cgiVwPwEMXLJAIT3VntS6iTEAnGD1qvwILyss32HCvRGHle8mgpsayc
 FPAWzg/lwe8unrPzvMAHz+37qGBbVlm7XW/2a
X-Gm-Gg: ASbGncs7vq3/LtjL+/CfbzGaFRh8JV3TEfZLOOGymjq7cON5xk3snxKQoNUqBf+0JxF
 j//Bck/ah49+PmPigUatDEemEx4VV9pIyw0FqcAI=
X-Google-Smtp-Source: AGHT+IH0pTcCgX7eSS2VwDrjCuXvyf14IFcIh/l2S9YsxIovfDj7jtT7jn1gBGG1O63EK6wqQuM9cL6Q0jjvc5zT+LM=
X-Received: by 2002:a17:906:30d2:b0:aa6:33cf:b389 with SMTP id
 a640c23a62f3a-aabf47a7ff3mr601682066b.34.1734620836759; Thu, 19 Dec 2024
 07:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20241211004640.3778457-1-sjg@chromium.org>
 <0a1b7c12-a8d7-46c2-9c00-4914d3286bc4@gmx.de>
In-Reply-To: <0a1b7c12-a8d7-46c2-9c00-4914d3286bc4@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:07:04 -0700
Message-ID: <CAFLszTg+L_qNXfwpkQjHoVn6u6Lhgr+5egS444DVqOLzdxSksg@mail.gmail.com>
Subject: Re: [PATCH] RFC: efi: Attempt to support automatically running SCT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Wed, 18 Dec 2024 at 05:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11.12.24 01:46, Simon Glass wrote:
> > This is a feeble attempt to update the qemu script to run a selection of
> > UEFI tests. It copies a .seq file into the disk so it can be read by
> > SCT.
> >
> > It doesn't seem to work and I am not sure why. I am posting it in case
> > someone else has ideas or wants to pic it up.
> >
> > Once Ilias' CI solution is in place, I can perhaps come back to this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   scripts/build-qemu.sh | 56 +++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 46 insertions(+), 10 deletions(-)
> >
> > diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
> > index 0ff53593cf9..f9ee0072573 100755
> > --- a/scripts/build-qemu.sh
> > +++ b/scripts/build-qemu.sh
> > @@ -21,20 +21,28 @@ usage() {
> >       fi
> >       echo "Usage: $0 -aBkrsw"
> >       echo
> > -     echo "   -a   - Select architecture (arm, x86)"
> > -     echo "   -B   - Don't build; assume a build exists"
> > -     echo "   -k   - Use kvm (kernel-based Virtual Machine)"
> > -     echo "   -o   - Run Operating System ('ubuntu' only for now)"
> > -     echo "   -r   - Run QEMU with the image"
> > -     echo "   -R   - Select OS release (e.g. 24.04)"
> > -     echo "   -s   - Use serial only (no display)"
> > -     echo "   -w   - Use word version (32-bit)" ) >&2
> > +     echo "   -a <arch> - Select architecture (arm, x86)"
>
> How about qemu-riscv64_smode_defconfig for RISC-V?
>
> > +     echo "   -B        - Don't build; assume a build exists"
> > +     echo "   -e        - Run UEFI Self-Certification Test (SCT)"
> > +     echo "   -k        - Use kvm (kernel-based Virtual Machine)"
> > +     echo "   -o <name> - Run Operating System ('ubuntu' only for now)"
> > +     echo "   -r        - Run QEMU with the image"
> > +     echo "   -R <os>   - Select OS release (e.g. 24.04)"
> > +     echo "   -s        - Use serial only (no display)"
> > +     echo "   -S <seq>  - Select SCT sequence-file"
> > +     echo "   -w        - Use word version (32-bit)" ) >&2
>
>
> A typical definition of word size is:
>
> Word "size" refers to the amount of data a CPU's internal data registers
> can hold and process at one time.
>
> I.e. a word on a 64-bit architecture has 64 bit.
>
> %s/Use word version (32-bit)/Use 32-bit architecture/
>
> Wouldn't it be the best to get rid of this parameter and just use
> parameter -a with values
>
> - arm
> - arm64
> - riscv64
> - loongson64
> - x86
> - x86_64

Yes, that might be better. My intent was to try to default to 64-bit,
since that is what we normally want, but it isn't a very good flag.
The efi script has the same thing.

On the other hand, it is annoying to say '64' when that is almost
always what we mean. Perhaps a --32 flag?

>
> >       exit 1
> >   }
> >
> >   # Directory tree for OS images
> >   imagedir=${imagedir-/vid/software/linux}
> >
> > +# Directory for UEFI Self-Certification Test (SCT)
> > +sctdir=${sctdir-/vid/software/devel/uefi/sct}
> > +
> > +# Mount point for use when writing to disk images
> > +mnt=${mnt-/mnt}
> > +
> >   # architecture (arm or x86)
> >   arch=arm
> >
> > @@ -65,7 +73,7 @@ kvm=
> >   # We avoid in-tree build because it gets confusing trying different builds
> >   ubdir=${ubdir-/tmp/b}
> >
> > -while getopts "a:Bko:rR:sw" opt; do
> > +while getopts "a:Beko:rR:sS:w" opt; do
> >       case "${opt}" in
> >       a)
> >               arch=$OPTARG
> > @@ -73,6 +81,17 @@ while getopts "a:Bko:rR:sw" opt; do
> >       B)
> >               build=
> >               ;;
> > +     e)
> > +             extra+=" -m 4G -smp 4"
> > +             extra+=" -display none"
> > +             extra+=" -device virtio-gpu-pci"
> > +             extra+=" -device qemu-xhci"
> > +             extra+=" -device usb-kbd"
> > +             extra+=" -drive file=${sctdir}/sct.img,format=raw,if=none,id=vda"
> > +             extra+=" -device virtio-blk-device,drive=vda,bootindex=1"
> > +             extra+=" -device virtio-net-device,netdev=net0"
> > +             extra+=" -netdev user,id=net0"
> > +             ;;
> >       k)
> >               kvm="-enable-kvm"
> >               ;;
> > @@ -91,6 +110,9 @@ while getopts "a:Bko:rR:sw" opt; do
> >       s)
> >               serial=1
> >               ;;
> > +     S)
> > +             seq=$OPTARG
> > +             ;;
> >       w)
> >               bitness=32
> >               ;;
> > @@ -105,6 +127,19 @@ build_u_boot() {
> >       buildman -w -o $DIR --board $BOARD -I || exit $?
> >   }
> >
> > +# Write the SCT test-sequence file into the SCT image
> > +update_sct_seq() {
> > +     if [[ -z "${seq}" ]]; then
> > +             return
> > +     fi
> > +     LOOP=$(sudo losetup --show -f -P "${sctdir}/sct.img")
> > +     PART="${LOOP}p1"
> > +     sudo mount -o loop ${PART} ${mnt} -o uid=$(id -u),gid=$(id -g)
> > +     cp "${seq}" "${mnt}/."
>
> This will not work. The sequence file must be in Sequence directory of
> the installed SCT and you must specify the filename when invoking the SCT.
>
> To avoid instance dependent file names you may copy the user provided
> sequence file always to the same location mnt/SCT/Sequence/uboot.seq.

OK, thanks, I'll take another look. It would be nice to get this
working, although I believe Ilias will have a patch for CI before
long.

Regards,
Simon
