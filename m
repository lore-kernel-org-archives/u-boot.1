Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB85C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 19:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682E687FF8;
	Tue, 20 Feb 2024 20:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Wjcf0k9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F271287FF7; Tue, 20 Feb 2024 20:09:06 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0FA87FED
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 20:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512be87a0f3so2293057e87.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1708456138; x=1709060938; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAG+dtshcF+CrFt6eTKcCXk2ycXAy8qxNdsAtjglN0Y=;
 b=Wjcf0k9FCUnZqXIY4QQ+G0YeFIOuLtdVBhHJLugSarczaNm8hzD0JhLXiPX6LyAw1c
 HdAjaXI7G+GRmDQNM3H/rg9reqRHDHTKleIDPTPhrfdY7tpgODtLDVsFYdfNWWDubTaP
 xg9EWg/iXfJssgN0kHUvCD+YASXUOKpUY6ha3gCN4FtUHGI21JkAsl9LTZWa3ZtQ5nFq
 4o2NKtIXr+ZvaMNCzk3GZNkHIPRwfD2QjBO9b42dO7sR2S/9ZWI8igBKrlKii1rnGHVC
 Pb0byBQFbWl3REorOI74dE4v010wzs4K3Xv8DyJDHy9pBCI+VlbceG6Ri8BmFl2bs6wk
 XK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708456138; x=1709060938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAG+dtshcF+CrFt6eTKcCXk2ycXAy8qxNdsAtjglN0Y=;
 b=V6jXDYTmh3b3kjM93dcmtZH0Xq6Ffy2dM55/ZRC2Eu+lLl//TBjGG2b/rQu5AD1ZGj
 xyjPMrDq3H7yRVa9ilwAe0XOTfIVT5SfLuU/xMx0RaaPhW2+NG3zIXPTiucqU+FgnqIb
 hXXk2TcSYq45au65bKR7oX4KfjnQvIXecbOW1ULwdFTt49/r4COoNhYxUl6Uds7sH4ak
 LgAANK3X4fdU1i1D0ydfcCb3qFs+uLnHdHCrH5iiOAxHGQ1SJpG50cjBhER1xfpz6PE2
 xRFURPJTOeNZjqLxxZ+SIVJVG8fmZdlonzN3l1l4RMgVoOB+E89L2v/5008wnmTsbULQ
 zIfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxhwENIgTHmepINEdcpFoEPG58XR+jKlSmJReA7cmc2jP7kQr80iaE2pDpBKfoqiRk3KTEJGuly1X/kIAEhCzhwL2STQ==
X-Gm-Message-State: AOJu0YzHOd3GOAVaskbvLpjHvIlZ0/NgiT2sRC5W39PitGRKYdcWMAYA
 vAGD4a0nDvWxyHRJM8FEvXH0E6AmAGmk5OOrZNsxGWsxDzXziUs5ZwcOpb31p8WgysnWa6C9iHc
 CP7oDDGv7raW2iQBhaEXbb/yUfEdATmCQKAn87g==
X-Google-Smtp-Source: AGHT+IGSoVg1Qj+0Fq+68QqkRuN3Lrg5/0nbB2csjGRoKC14z22qut/Xg11UGUWy1kWoQ954lmVmv3nOanguKvNGsSs=
X-Received: by 2002:a05:6512:b9f:b0:512:acce:3df0 with SMTP id
 b31-20020a0565120b9f00b00512acce3df0mr6142623lfv.8.1708456138142; Tue, 20 Feb
 2024 11:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20240219101559.364553-1-igor.opaniuk@gmail.com>
 <CAPLW+4kB0mJ-dFAkd6s8Lu6rQzSjd7LmBcZJy-YLApO5suUAJA@mail.gmail.com>
In-Reply-To: <CAPLW+4kB0mJ-dFAkd6s8Lu6rQzSjd7LmBcZJy-YLApO5suUAJA@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Tue, 20 Feb 2024 20:08:46 +0100
Message-ID: <CAL6CDMHJkgLeAqWtzcXG_XpWwG=ctHzrnHJVshnKaHfKuMs5tw@mail.gmail.com>
Subject: Re: [PATCH v1] include: android_bootloader_message.h: sync with AOSP
 upstream
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Eugeniu Rosca <erosca@de.adit-jv.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alex Deymo <deymo@google.com>
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

Hi Sam,

On Tue, Feb 20, 2024 at 7:29=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Mon, Feb 19, 2024 at 4:16=E2=80=AFAM Igor Opaniuk <igor.opaniuk@gmail.=
com> wrote:
> >
> > This takes the latest changes from AOSP from [1][2] (as this
> > header was split on two) with minimal changes (this could lead
> > to warnings reported by checkpatch).
>
> Do we want to maybe follow that and also carry two different headers
> in U-Boot? Or it doesn't make much sense? I'm thinking in terms of
> future portability mostly: how easy it's to update this header right
> now, and how easy it's going to be further. I didn't form any opinion
> on that, hence asking.
The problem is licensing. android_bootloader_message.h was
re-licensed by Alex Deymo from Google under BSD-3-Clause,
which is GPLv2 compatible. I'm not sure it's legally correct to pull
boot_control_definition.h from AOSP licensed under Apache as a
separate file.

>
> Another thing: are you sure that changing only the header won't break
> anything in U-Boot .c files that use this header?

I've tested both ab_select and avb verify in QEMU. Or do you mean
something else additionally should be tested?

>
> >
> > Some local changes have been applied:
>
> Is it possible to split this work into two patches:
>   1. Bring the original changes only
>   2. Apply all necessary changes for U-Boot
>
> Or does it break the build, etc? Again, thinking in terms of
> portability easiness, and not sure which approach is better -- just
> asking basically.
Yeah, that's the problem, as splitting this on two commits
will lead to the first one reporting warnings/notes.

>
> > 1. Enable static_assert() for defined structures to be sure
> > that all of them have correct sizes.
> > 2. Adjuste types in bootloader_control structure with bitfields
>
> Adjuste -> adjust
Will fix, thanks!
>
> > (uint8_t -> uint16_t). It seems that gcc just doesn't like bitfields
>
> I wonder if all those extra changes can be upstreamed back to AOSP?
> Ideally we'd want to just copy those headers over from AOSP to U-Boot
> with no changes, would make the porting work easier. What are your
> thoughts on that?
Technically we can, I was planning to do that.

>
> > that cross the width of the type. Changing the type doesn't change
> > the layout though.
> > This addresses this gcc note:
> > In file included from boot/android_ab.c:7:
> > include/android_bootloader_message.h:230:1: note: offset of packed bit-=
field =E2=80=98merge_status=E2=80=99 has changed in GCC 4.4
> >   230 | } __attribute__((packed));
> >
> > [1] https://android.googlesource.com/platform/bootable/recovery/+/main/=
bootloader_message/include/bootloader_message/bootloader_message.h
> > [2] https://android.googlesource.com/platform/hardware/interfaces/+/mai=
n/boot/1.1/default/boot_control/include/private/boot_control_definition.h
> >
> > CC: Alex Deymo <deymo@google.com>
> > CC: Sam Protsenko <semen.protsenko@linaro.org>
> > CC: Eugeniu Rosca <erosca@de.adit-jv.com>
> > CC: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> > ---
> >
> >  include/android_bootloader_message.h | 104 +++++++++++++++++++++++----
> >  1 file changed, 92 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/android_bootloader_message.h b/include/android_boo=
tloader_message.h
> > index 286d7ab0f31..75198fc9dc2 100644
> > --- a/include/android_bootloader_message.h
> > +++ b/include/android_bootloader_message.h
> > @@ -21,17 +21,22 @@
> >   * stddef.h
> >   */
> >  #include <compiler.h>
> > +#include <linux/build_bug.h>
> >  #endif
> >
> >  // Spaces used by misc partition are as below:
> >  // 0   - 2K     For bootloader_message
> >  // 2K  - 16K    Used by Vendor's bootloader (the 2K - 4K range may be =
optionally used
> >  //              as bootloader_message_ab struct)
> > -// 16K - 64K    Used by uncrypt and recovery to store wipe_package for=
 A/B devices
> > +// 16K - 32K    Used by uncrypt and recovery to store wipe_package for=
 A/B devices
> > +// 32K - 64K    System space, used for miscellanious AOSP features. Se=
e below.
> >  // Note that these offsets are admitted by bootloader,recovery and unc=
rypt, so they
> >  // are not configurable without changing all of them.
> >  static const size_t BOOTLOADER_MESSAGE_OFFSET_IN_MISC =3D 0;
> > +static const size_t VENDOR_SPACE_OFFSET_IN_MISC =3D 2 * 1024;
> >  static const size_t WIPE_PACKAGE_OFFSET_IN_MISC =3D 16 * 1024;
> > +static const size_t SYSTEM_SPACE_OFFSET_IN_MISC =3D 32 * 1024;
> > +static const size_t SYSTEM_SPACE_SIZE_IN_MISC =3D 32 * 1024;
> >
> >  /* Bootloader Message (2-KiB)
> >   *
> > @@ -81,24 +86,67 @@ struct bootloader_message {
> >      char reserved[1184];
> >  };
> >
> > +// Holds Virtual A/B merge status information. Current version is 1. N=
ew fields
> > +// must be added to the end.
> > +struct misc_virtual_ab_message {
> > +  uint8_t version;
> > +  uint32_t magic;
> > +  uint8_t merge_status;  // IBootControl 1.1, MergeStatus enum.
> > +  uint8_t source_slot;   // Slot number when merge_status was written.
> > +  uint8_t reserved[57];
> > +} __attribute__((packed));
> > +
> > +struct misc_memtag_message {
> > +  uint8_t version;
> > +  uint32_t magic; // magic string for treble compat
> > +  uint32_t memtag_mode;
> > +  uint8_t reserved[55];
> > +} __attribute__((packed));
> > +
> > +struct misc_kcmdline_message {
> > +  uint8_t version;
> > +  uint32_t magic;
> > +  uint64_t kcmdline_flags;
> > +  uint8_t reserved[51];
> > +} __attribute__((packed));
> > +
> > +#define MISC_VIRTUAL_AB_MESSAGE_VERSION 2
> > +#define MISC_VIRTUAL_AB_MAGIC_HEADER 0x56740AB0
> > +
> > +#define MISC_MEMTAG_MESSAGE_VERSION 1
> > +#define MISC_MEMTAG_MAGIC_HEADER 0x5afefe5a
> > +#define MISC_MEMTAG_MODE_MEMTAG 0x1
> > +#define MISC_MEMTAG_MODE_MEMTAG_ONCE 0x2
> > +#define MISC_MEMTAG_MODE_MEMTAG_KERNEL 0x4
> > +#define MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE 0x8
> > +#define MISC_MEMTAG_MODE_MEMTAG_OFF 0x10
> > +// This is set when the state was overridden forcibly. This does not n=
eed to be
> > +// interpreted by the bootloader but is only for bookkeeping purposes =
so
> > +// userspace knows what to do when the override is undone.
> > +// See system/extras/mtectrl in AOSP for more information.
> > +#define MISC_MEMTAG_MODE_FORCED 0x20
> > +
> > +#define MISC_KCMDLINE_MESSAGE_VERSION 1
> > +#define MISC_KCMDLINE_MAGIC_HEADER 0x6ab5110c
> > +#define MISC_KCMDLINE_BINDER_RUST 0x1
> >  /**
> >   * We must be cautious when changing the bootloader_message struct siz=
e,
> >   * because A/B-specific fields may end up with different offsets.
> >   */
> > -#ifndef __UBOOT__
> > +
> >  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
> >  static_assert(sizeof(struct bootloader_message) =3D=3D 2048,
> >                "struct bootloader_message size changes, which may break=
 A/B devices");
> >  #endif
> > -#endif /* __UBOOT__ */
> >
> >  /**
> >   * The A/B-specific bootloader message structure (4-KiB).
> >   *
> >   * We separate A/B boot control metadata from the regular bootloader
> >   * message struct and keep it here. Everything that's A/B-specific
> > - * stays after struct bootloader_message, which should be managed by
> > - * the A/B-bootloader or boot control HAL.
> > + * stays after struct bootloader_message, which belongs to the vendor
> > + * space of /misc partition. Also, the A/B-specific contents should be
> > + * managed by the A/B-bootloader or boot control HAL.
> >   *
> >   * The slot_suffix field is used for A/B implementations where the
> >   * bootloader does not set the androidboot.ro.boot.slot_suffix kernel
> > @@ -124,12 +172,10 @@ struct bootloader_message_ab {
> >   * Be cautious about the struct size change, in case we put anything p=
ost
> >   * bootloader_message_ab struct (b/29159185).
> >   */
> > -#ifndef __UBOOT__
> >  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
> >  static_assert(sizeof(struct bootloader_message_ab) =3D=3D 4096,
> >                "struct bootloader_message_ab size changes");
> >  #endif
> > -#endif /* __UBOOT__ */
> >
> >  #define BOOT_CTRL_MAGIC   0x42414342 /* Bootloader Control AB */
> >  #define BOOT_CTRL_VERSION 1
> > @@ -165,11 +211,13 @@ struct bootloader_control {
> >      // Version of struct being used (see BOOT_CTRL_VERSION).
> >      uint8_t version;
> >      // Number of slots being managed.
> > -    uint8_t nb_slot : 3;
> > +    uint16_t nb_slot : 3;
> >      // Number of times left attempting to boot recovery.
> > -    uint8_t recovery_tries_remaining : 3;
> > +    uint16_t recovery_tries_remaining : 3;
> > +    // Status of any pending snapshot merge of dynamic partitions.
> > +    uint16_t merge_status : 3;
> >      // Ensure 4-bytes alignment for slot_info field.
> > -    uint8_t reserved0[2];
> > +    uint8_t reserved0[1];
> >      // Per-slot information.  Up to 4 slots.
> >      struct slot_metadata slot_info[4];
> >      // Reserved for further use.
> > @@ -179,25 +227,46 @@ struct bootloader_control {
> >      uint32_t crc32_le;
> >  } __attribute__((packed));
> >
> > -#ifndef __UBOOT__
> >  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
> >  static_assert(sizeof(struct bootloader_control) =3D=3D
> >                sizeof(((struct bootloader_message_ab *)0)->slot_suffix)=
,
> >                "struct bootloader_control has wrong size");
> > +static_assert(sizeof(struct misc_virtual_ab_message) =3D=3D 64,
> > +              "struct misc_virtual_ab_message has wrong size");
> > +static_assert(sizeof(struct misc_memtag_message) =3D=3D 64,
> > +              "struct misc_memtag_message has wrong size");
> > +static_assert(sizeof(struct misc_kcmdline_message) =3D=3D 64,
> > +              "struct misc_kcmdline_message has wrong size");
> >  #endif
> > -#endif /* __UBOOT__ */
> >
> >  #ifndef __UBOOT__
> > +
> > +// This struct is not meant to be used directly, rather, it is to make
> > +// computation of offsets easier. New fields must be added to the end.
> > +struct misc_system_space_layout {
> > +  misc_virtual_ab_message virtual_ab_message;
> > +  misc_memtag_message memtag_message;
> > +  misc_kcmdline_message kcmdline_message;
> > +} __attribute__((packed));
> > +
> >  #ifdef __cplusplus
> >
> >  #include <string>
> >  #include <vector>
> >
> > +// Gets the block device name of /misc partition.
> > +std::string get_misc_blk_device(std::string* err);
> > +
> >  // Return the block device name for the bootloader message partition a=
nd waits
> >  // for the device for up to 10 seconds. In case of error returns the e=
mpty
> >  // string.
> >  std::string get_bootloader_message_blk_device(std::string* err);
> >
> > +// Writes |size| bytes of data from buffer |p| to |misc_blk_device| at=
 |offset|. If the write fails,
> > +// sets the error message in |err|.
> > +bool write_misc_partition(const void* p, size_t size, const std::strin=
g& misc_blk_device,
> > +                          size_t offset, std::string* err);
> > +
> >  // Read bootloader message into boot. Error message will be set in err=
.
> >  bool read_bootloader_message(bootloader_message* boot, std::string* er=
r);
> >
> > @@ -242,6 +311,17 @@ bool read_wipe_package(std::string* package_data, =
size_t size, std::string* err)
> >  // Write the wipe package into BCB (to offset WIPE_PACKAGE_OFFSET_IN_M=
ISC).
> >  bool write_wipe_package(const std::string& package_data, std::string* =
err);
> >
> > +// Read or write the Virtual A/B message from system space in /misc.
> > +bool ReadMiscVirtualAbMessage(misc_virtual_ab_message* message, std::s=
tring* err);
> > +bool WriteMiscVirtualAbMessage(const misc_virtual_ab_message& message,=
 std::string* err);
> > +
> > +// Read or write the memtag message from system space in /misc.
> > +bool ReadMiscMemtagMessage(misc_memtag_message* message, std::string* =
err);
> > +bool WriteMiscMemtagMessage(const misc_memtag_message& message, std::s=
tring* err);
> > +
> > +// Read or write the kcmdline message from system space in /misc.
> > +bool ReadMiscKcmdlineMessage(misc_kcmdline_message* message, std::stri=
ng* err);
> > +bool WriteMiscKcmdlineMessage(const misc_kcmdline_message& message, st=
d::string* err);
>
> AFAIU, these new prototypes brought by this patch don't have actual
> implementation yet. Does it affect the build somehow, e.g. maybe
> causing some build warnings? Or is the build log clean?

They are all wrapped with #ifndef __UBOOT__.


>
> >  #else
> >
> >  #include <stdbool.h>
> > --
> > 2.34.1
> >
Thanks for your comments!


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
