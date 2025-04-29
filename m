Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86062C369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 04:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07D182114;
	Tue, 29 Apr 2025 06:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iY7c0Lfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0E081FDE; Tue, 29 Apr 2025 06:04:37 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4370D81E0F
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-54af20849bbso6346197e87.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745899473; x=1746504273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ISEd3IWKlIK+cy13wuGKFr8kcaP16r6Mc7uT5OkhWOo=;
 b=iY7c0LfhMybRSUTcK+gA+sUVEvBl6GKKaIaCVaCB7T8WnYgXSi7QZgnizbcfmN/hnX
 9/Vqc+4OUAp2Owj1lnEpOJl7k7vcM95kQq8em8NyJ/uY+g/g2+aetzjUY/R38or6/ny/
 2oI5eKGk0rzCVoxUnDjqZEK6Ot34/DPtDKm9+RJesKlJ0k5DS2MhnV1D40swK1anmMPn
 pKHRBVcjrcVkJGGK5pCwjx08iRAx7g6N3DZlACL9C2+QqZOdtNA39R2I3eDMyYxmTyiS
 cZYWF/DcqOENcQVdL5EQKt9WGRi1ySjClf9crkL0vIIn5ZEHTZPZSJJpI+etyqosYDtu
 QNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745899473; x=1746504273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISEd3IWKlIK+cy13wuGKFr8kcaP16r6Mc7uT5OkhWOo=;
 b=PuPHeFXiAmhDi21/KPZTif29fuQQRSakJVMPyMTnAumNVOdufGJKhddn3dmcjZrjVD
 H/lerM/WV8FMeqc8ADcc5J2EjPMSCtYG0FQ3Lk+haztlJjmApfN3/rA/HFwjDIPje9AY
 FGU+lHvQMuR30Tv3E3Vp4TzXALPOUOK78Or9mmZdmh3ZgBqB8oUsBuFGZ9E6Hno8+ECO
 iMfbKEcA3L7aS9KyoMZdX8jZFKVRk1isVSmpEfHxrPI9H78hGFnb1Vn78p/8j+kRAD0i
 W2JHbRR1D9drwole1yuf1V+asubxHdRtAGDah332B68hHS1lJJQGYND/1RPGZjCPLukq
 pN7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP0aTwVSZwos4kCAMxIZ54sVuyTA42HhRJEAG72lvzb6etr4aFXGj1UAN5Zx9G/nmsaeq5Kg4=@lists.denx.de
X-Gm-Message-State: AOJu0YzfP13sbHPgqaws3eGB7Toqxto35uPy8shn5AOHGy/1m+mFiR57
 8wPajN46GaLOPfgrQzAzrtdGBS1wuo16eKXEKE1Fp87HGRSlJxMhPYIWan+JVmcsQqmxHeKY9Hi
 Segqs+2PqZh1bbf+Gtc1T7lOPtkw=
X-Gm-Gg: ASbGncuci/SWzOIiBtxMzC3egK74zklV0SJKRz82sRJPy4/dZQ+7lmQX3C5rcaF9WrM
 kbgPOK9YC8A1FcYSdmjSLDFzcuMbriW1J8+yB8veUhYddiqHgyK38576ghEtxSspy/nuwyjkATw
 Yj3bLnAw/9DoqzuAVSkLF6jZ4=
X-Google-Smtp-Source: AGHT+IEt5lw6Gom9u97r1yrll0VAErrOrR+4H57scsfRnMz3lFz4Lnd4Q6eqdJtxKY7uDIwNuaXPBceNq5YNmcdAyLg=
X-Received: by 2002:a05:6512:ba5:b0:54c:a49:d3ec with SMTP id
 2adb3069b0e04-54e8ffb7fd0mr2645038e87.1.1745899473081; Mon, 28 Apr 2025
 21:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
 <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org>
In-Reply-To: <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org>
From: george chan <gchan9527@gmail.com>
Date: Tue, 29 Apr 2025 12:04:20 +0800
X-Gm-Features: ATxdqUEofSbxvNBij3pWAx-VuZHIrxcTabRQHLuDJr92HVMZSXFozK05tw4Eibw
Message-ID: <CADgMGSss9tk=M89Hi-WNyBCvRYVvT3f-nfpqQg9DR789m24MDA@mail.gmail.com>
Subject: Re: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Tue, 29 Apr 2025 06:26:35 +0200
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

Hi Casey,

Thx for reply. Sorry for a bit long message for explain the problem.

=E5=9C=A8 2025=E5=B9=B44=E6=9C=8828=E6=97=A5=E9=80=B1=E4=B8=80 21:53=EF=BC=
=8CCasey Connolly <casey.connolly@linaro.org> =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi George,
>
> Thanks a lot for the series, it's super exciting to see support for
> booting Android on top of U-Boot :D
>
> On 4/27/25 13:25, George Chan via B4 Relay wrote:
> > This is a series of patches to enable chainloading LineageOS on qcom SO=
C.
> >
> > First patch is to workaround kernel/ramdisk invalid addr by identify
> > its physical memory address out-of-range. Since qcom SOC usually have
> > 0x80000000 as start/base/real memory address but androidboot img
> > specified to around 0x0. If other vendor bootloader behave similar then
> > this patch can also workaround it as well.
>
> I'm curious to know what values are there, tbh I think U-Boot should


I don't know either. I figured it out a failure memcpy kernel to addr 0,
and failure at right after first 16k succes. Since kernel is relocatable so
I ignored it. I know you are dealing with memory mapping on xbl and chain
loading case with some kind of smem value. Good job!


> entirely ignore the values in the boot image but I guess that could
> break some other platforms.


I agreed your below suggested alternative approach apply can ease for
maintaining, and less concern. I am willing to help draft a patch worked as
your mentioned approach.

Maybe it is more optimistic than what you see here. Below are some reasons
might be worth to rethink.

(1) This is specific to bootm dealing androidboot img only.
(2)A similar approach applied to check specific kernel address already.
(3)The proposed logic is to cater extra case that is never works.
(4)unless there is a need for soc that mmap() high (physical) memory addr
to low (nonexistent) addr, aka 0, and use low address as kernel data.
Sounds like hyperizer iommu work. Looks redundance.
(5)if checking gd->base_mem is not safe then we can add extra checking for
gd null. The logic only affect valid gd and base_mem value. Either null or
0 won't have any side effect.

So it less likely breaks. In the end, if apply your suggested approach,
then mine and existing one are redundance and could be removed for clean
up. I am not sure what happened and concluded for existing code but the
code exists. Maybe some senior contributor knows more about it.

Removing code would be a big behavioral change require broader
acknowledgement. Or just leave existing logic and apply only your suggested
approach anyway. Both are fine for me. I prefer to wait for some feedback
before new revision roll.


> How about adding a config option CONFIG_ANDROID_BOOTIMG_IGNORE_ADDRS and
> just ORing it in all the places that have checks like
> "img_data->kernel_addr =3D=3D 0". Then you can enable this for
> mach-snapdragon by selecting it in the ARCH_SNAPDRAGON config definition.
>

As stated as above.

>
> > Second patch is enable bootmeth-android to have chance for extra mem
> block.
> > Usually the fastboot mem block, to hold androidboot img, and loadaddr f=
or
> > unzipped kernel. If other SOC have extra mem block available but
> > fastboot block, we can add extra logic to take care of it.
>
> There is a small hack in mach-snapdragon that we put kernel_addr_r and
> loadaddr at the same address to avoid using up too much memory on
> devices that only have 1GB which explains this crash because we try to
> decompress the kernel to the same address it got loaded too.
>

Reasonable.

I think we can get away with giving loadaddr its own allocation of 64M
> or so, maybe 96. This would make your second patch redundant (and feels
> like the right fix to me)
>

I don't know how memory constrain affected, and have virtually no knowledge
on memory arrangement. So I can't comment on this.

There is a third way. Add one more env_var like androidboot_addr_r and
pointed to same as fastboot_addr_r then use it in bootmeth-android if this
new env exists. If var not exists, fallback to existing logic. That balance
with minimal logic change and readability.


> >
> > Third patch is optional to enable snapdragon board to have extra cmdlin=
e
> > found from original bootloader that is required for LineageOS boot init=
.
> > An alternate method is to put the append string into a dummy device-tre=
e
> > file, as /chosen/bootarg ofnode porperty, that also contain msm-id. The=
n
> > encapsulate as androidboot img and let u-boot as kernel binary. Below i=
s
> > an example for Xiaomi Miatoll device.
>
> I assume you're chainloading U-Boot on this device? If so, isn't it
> enough to just copy the boot args that ABL gives us and maybe tweak a few=
?
>

Yes, I am doing chain loading u-boot. And yes, patch 3 is doing exactly you
mentioned.

I mentioned here is 2nd approach that I feels cleaner for chain loading
case. I really have no idea on how prev_blob and target_blob works all the
way fdt handling (difference of replace xbl and chain loading). If
non-chain-loading case there have no prev_blob, then 1st approach is
preferable.


> I'd also rather keep this constrained, maybe an android specific board
> callback to set boot args (if there isn't one already) and have the FDT
> fixup code be alongside some other generic FDT fixup stuff. I'd rather
> not have this stuff in board specific code.
>

Reasonably. I can't figure out the difference board specific fixup and
android specific fixup. My limited knowledge is fdt_support.c have weak
board_fdt_chosen_bootargs func to board.c as my 1st approach do as patch 3.
I wonder if you are talking about adding one more fdt-support.c weak func
like board_fdt_chosen_bootargs_android. And leave board_fdt_chosen_bootargs
empty for further use case on purpose. I also curious if you are targeting
to make it generic enough for mach-* and/or enhanced API with full fdt for
fixup because the existing one is incapable. And this is reasonable too.

I wanna to express some though about additional fixups here. As you knows
those androidboot param are half baked and soc/machine/device/os dependent.
So it can't be one-sized-fit-all. Currently we have some approaches to put
it in.

(1) In upstream dts, block the merge.
(2) In a dummy dts, might not work for xbl case.
(3) In board.c/Kconfig compile-time config. Not flexible. Can't do it with
constrained way unless a string parser is needed (I wrote one similar thing
but found useless
https://github.com/99degree/u-boot/commit/3240054aa85f4cb70daa8671150bf4a9c=
a885a61
)

Since all added Androidboot param are android specific, my approach is very
simple. Let the android init to get rid of it.

Here is how to do so. Android Init treat Androidboot.* param as ro.boot.*
and set-once-read-only and first-come-first-serve so any taylor-made param
we put in the head will mandate the value even the same appears in the
tail. In other words, params in tail are failsafe as result. This behavior
is good enough to make an approach to balance flexible and function. We can
have wanted param in chainloaded Androidboot (boot.) img dtb, and 'default'
param live in board specific fixup logic. Since env_bootargs have param
from Android boot img and board can do fixup by append android specific
param to end of env_bootargs. Then we do not need to have constrained param
(to append env_bootargs, my own understanding) unless overflow bootargs
length. Well, this is the core idea of my impl in patch 3. Also patch 3
have Kconfig string to override SOC specific fixup so param value can set
by config file.

One more thing worth mentioning, I made boot.img repacked with dtb from
/sys/firmware/fdt and do u-boot chain load because of well known dtbo
issue. Maybe u-boot support dtbo partition but I have not tried. I cant
assumed people get used to familiar with android param so a dummy way is do
less-is-more. It is easy to repack boot.img with new fdt (by tool like e.g.
magisk) but not easy to figure which param to append bootargs is needed.
Even duplicated param as result.


> I hope this makes sense, feel free to ask for clarifications on anything.
>

Yes your suggestions are valuable


> Thanks and kind regards,
>

kind regards,
George


> >
> > /dts-v1/;
> >
> > / {
> >          qcom,msm-id =3D <443 0x0>;
> >          qcom,board-id =3D <0 0>,
> >                       <0x10022 1>,
> >                       <0x20022 1>,
> >                       <0x30022 1>,
> >                       <0x40022 1>,
> >                       <0x50022 1>;
> >
> >          #address-cells =3D <2>;
> >          #size-cells =3D <2>;
> >
> >          memory {
> >                  ddr_device_type =3D <0x07>;
> >                  /* We expect the bootloader to fill in the size */
> >                  reg =3D <0 0 0 0>;
> >          };
> >
> >       chosen {
> >               bootargs =3D "";
> >       };
> > };
> >
> > Signed-off-by: George Chan <gchan9527@gmail.com>
> > ---
> > George Chan (3):
> >        boot/image-android.c: Workaround androidboot kernel/ramdisk addr
> >        boot/bootmeth-android.c: Reuse fastboot memory block for unzip
> kernel
> >        mach-snapdragon: Add support to append string to kernel cmdline
> >
> >   arch/arm/mach-snapdragon/Kconfig | 11 +++++
> >   arch/arm/mach-snapdragon/board.c | 97
> ++++++++++++++++++++++++++++++++++++++++
> >   boot/bootmeth_android.c          | 12 +++++
> >   boot/image-android.c             | 10 +++++
> >   4 files changed, 130 insertions(+)
> > ---
> > base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
> > change-id: 20250427-android-boot-ecbb768cda72
> >
> > Best regards,
> --
> Casey (she/they)
>
>
