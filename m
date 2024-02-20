Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332E2C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D7D87FEC;
	Tue, 20 Feb 2024 19:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pHiOB9e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACACF87FED; Tue, 20 Feb 2024 19:29:30 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9EF87FE7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dcd7c526cc0so6157192276.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708453764; x=1709058564; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98WiXc81phEkqAmDtGk5TwynerWB4QheCAwGnKCmc7c=;
 b=pHiOB9e60UEWpcqdHORd7Oa4JlFYTU2mYuTh+/JLhAHCimp/jOLR3Vx0Hv9+IxiPTZ
 8LEzSRXNmiNBUhRKWbeo3K+vT1II1sGBKuSx2TGh7IA8kCS3e9Ns52F8eDKyOfhhC5NG
 bqRrljxxHb3xEPfZkthlDN6NyBuI8VIowD7p4LMFia8ZI9MR4GPUIXl56tzJ9edyXLSG
 KiJoWQWYhzgMgnZVeGoqoy2rmsDwnwq3x2B5JcyMMSRuD0T+vsWdYGk7I826puB5zWJ4
 Nf2gJ28sUaCDES7QeeNF8Ck7/+H0Rcscd23vBt5n+wvjGseYvW8PeC1TN+sD/AgiQUHn
 0WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708453764; x=1709058564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98WiXc81phEkqAmDtGk5TwynerWB4QheCAwGnKCmc7c=;
 b=Lq8GPeehdMzemdzwNeFVszzpi6XsMQ5pi8BnjF2ruSJiewZs1dgf9ZhrmiGMZnN8xq
 ttovEtNojCvqzA6/EiS/x0IzkB1Ulaiej2OWU/7NjauCpvKX655pBvzdXAmLLp9MvciR
 aV68c9kD2KsrBOjK1ds895lVFl/HToCGlZ3pn5JFt4Nuyyp2rEN+qmd20y+1uO4KoSjz
 kI8Bs8fOZ+CVhqJ0d9GV3IuRoGI9JpaejD+e3mvvR089o6ITaGjhKHpnJICOVa9O7Kdw
 2EnQrUZ6cgjCJYayt3wVHmR60H+zsBrEXHTR2SrPN0T+jkwxAkzgqi1OwpLXxHRA6q5F
 xYgg==
X-Gm-Message-State: AOJu0YzNoLNj31wzXGO7hQhMCsYly9FU/yznGQhcR2ZKIL/dqeQfn/tv
 pZcau2o6ktX13RvStAtIGGycekB/Rc0x+otpilh/tuDfTyWRDnjyCI+kmycsM7q9G+CE6tADGIs
 MvKxVai9NLtH8y9vFcfFFoEmPYFjnSkj1PqhRZ2xZ0eDXp2okr7g=
X-Google-Smtp-Source: AGHT+IGRY/fFMtCoai1/o881Bz0mEDqhjG0e+iXqZobEs8jZJg1SjFyIEp8WgU4nkoNMcIZ/IpJG7tTAxsLenf7WRHM=
X-Received: by 2002:a25:98c3:0:b0:dcc:693e:b396 with SMTP id
 m3-20020a2598c3000000b00dcc693eb396mr13837976ybo.2.1708453763017; Tue, 20 Feb
 2024 10:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20240219101559.364553-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240219101559.364553-1-igor.opaniuk@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 20 Feb 2024 12:29:12 -0600
Message-ID: <CAPLW+4kB0mJ-dFAkd6s8Lu6rQzSjd7LmBcZJy-YLApO5suUAJA@mail.gmail.com>
Subject: Re: [PATCH v1] include: android_bootloader_message.h: sync with AOSP
 upstream
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alex Deymo <deymo@google.com>
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

On Mon, Feb 19, 2024 at 4:16=E2=80=AFAM Igor Opaniuk <igor.opaniuk@gmail.co=
m> wrote:
>
> This takes the latest changes from AOSP from [1][2] (as this
> header was split on two) with minimal changes (this could lead
> to warnings reported by checkpatch).

Do we want to maybe follow that and also carry two different headers
in U-Boot? Or it doesn't make much sense? I'm thinking in terms of
future portability mostly: how easy it's to update this header right
now, and how easy it's going to be further. I didn't form any opinion
on that, hence asking.

Another thing: are you sure that changing only the header won't break
anything in U-Boot .c files that use this header?

>
> Some local changes have been applied:

Is it possible to split this work into two patches:
  1. Bring the original changes only
  2. Apply all necessary changes for U-Boot

Or does it break the build, etc? Again, thinking in terms of
portability easiness, and not sure which approach is better -- just
asking basically.

> 1. Enable static_assert() for defined structures to be sure
> that all of them have correct sizes.
> 2. Adjuste types in bootloader_control structure with bitfields

Adjuste -> adjust

> (uint8_t -> uint16_t). It seems that gcc just doesn't like bitfields

I wonder if all those extra changes can be upstreamed back to AOSP?
Ideally we'd want to just copy those headers over from AOSP to U-Boot
with no changes, would make the porting work easier. What are your
thoughts on that?

> that cross the width of the type. Changing the type doesn't change
> the layout though.
> This addresses this gcc note:
> In file included from boot/android_ab.c:7:
> include/android_bootloader_message.h:230:1: note: offset of packed bit-fi=
eld =E2=80=98merge_status=E2=80=99 has changed in GCC 4.4
>   230 | } __attribute__((packed));
>
> [1] https://android.googlesource.com/platform/bootable/recovery/+/main/bo=
otloader_message/include/bootloader_message/bootloader_message.h
> [2] https://android.googlesource.com/platform/hardware/interfaces/+/main/=
boot/1.1/default/boot_control/include/private/boot_control_definition.h
>
> CC: Alex Deymo <deymo@google.com>
> CC: Sam Protsenko <semen.protsenko@linaro.org>
> CC: Eugeniu Rosca <erosca@de.adit-jv.com>
> CC: Simon Glass <sjg@chromium.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  include/android_bootloader_message.h | 104 +++++++++++++++++++++++----
>  1 file changed, 92 insertions(+), 12 deletions(-)
>
> diff --git a/include/android_bootloader_message.h b/include/android_bootl=
oader_message.h
> index 286d7ab0f31..75198fc9dc2 100644
> --- a/include/android_bootloader_message.h
> +++ b/include/android_bootloader_message.h
> @@ -21,17 +21,22 @@
>   * stddef.h
>   */
>  #include <compiler.h>
> +#include <linux/build_bug.h>
>  #endif
>
>  // Spaces used by misc partition are as below:
>  // 0   - 2K     For bootloader_message
>  // 2K  - 16K    Used by Vendor's bootloader (the 2K - 4K range may be op=
tionally used
>  //              as bootloader_message_ab struct)
> -// 16K - 64K    Used by uncrypt and recovery to store wipe_package for A=
/B devices
> +// 16K - 32K    Used by uncrypt and recovery to store wipe_package for A=
/B devices
> +// 32K - 64K    System space, used for miscellanious AOSP features. See =
below.
>  // Note that these offsets are admitted by bootloader,recovery and uncry=
pt, so they
>  // are not configurable without changing all of them.
>  static const size_t BOOTLOADER_MESSAGE_OFFSET_IN_MISC =3D 0;
> +static const size_t VENDOR_SPACE_OFFSET_IN_MISC =3D 2 * 1024;
>  static const size_t WIPE_PACKAGE_OFFSET_IN_MISC =3D 16 * 1024;
> +static const size_t SYSTEM_SPACE_OFFSET_IN_MISC =3D 32 * 1024;
> +static const size_t SYSTEM_SPACE_SIZE_IN_MISC =3D 32 * 1024;
>
>  /* Bootloader Message (2-KiB)
>   *
> @@ -81,24 +86,67 @@ struct bootloader_message {
>      char reserved[1184];
>  };
>
> +// Holds Virtual A/B merge status information. Current version is 1. New=
 fields
> +// must be added to the end.
> +struct misc_virtual_ab_message {
> +  uint8_t version;
> +  uint32_t magic;
> +  uint8_t merge_status;  // IBootControl 1.1, MergeStatus enum.
> +  uint8_t source_slot;   // Slot number when merge_status was written.
> +  uint8_t reserved[57];
> +} __attribute__((packed));
> +
> +struct misc_memtag_message {
> +  uint8_t version;
> +  uint32_t magic; // magic string for treble compat
> +  uint32_t memtag_mode;
> +  uint8_t reserved[55];
> +} __attribute__((packed));
> +
> +struct misc_kcmdline_message {
> +  uint8_t version;
> +  uint32_t magic;
> +  uint64_t kcmdline_flags;
> +  uint8_t reserved[51];
> +} __attribute__((packed));
> +
> +#define MISC_VIRTUAL_AB_MESSAGE_VERSION 2
> +#define MISC_VIRTUAL_AB_MAGIC_HEADER 0x56740AB0
> +
> +#define MISC_MEMTAG_MESSAGE_VERSION 1
> +#define MISC_MEMTAG_MAGIC_HEADER 0x5afefe5a
> +#define MISC_MEMTAG_MODE_MEMTAG 0x1
> +#define MISC_MEMTAG_MODE_MEMTAG_ONCE 0x2
> +#define MISC_MEMTAG_MODE_MEMTAG_KERNEL 0x4
> +#define MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE 0x8
> +#define MISC_MEMTAG_MODE_MEMTAG_OFF 0x10
> +// This is set when the state was overridden forcibly. This does not nee=
d to be
> +// interpreted by the bootloader but is only for bookkeeping purposes so
> +// userspace knows what to do when the override is undone.
> +// See system/extras/mtectrl in AOSP for more information.
> +#define MISC_MEMTAG_MODE_FORCED 0x20
> +
> +#define MISC_KCMDLINE_MESSAGE_VERSION 1
> +#define MISC_KCMDLINE_MAGIC_HEADER 0x6ab5110c
> +#define MISC_KCMDLINE_BINDER_RUST 0x1
>  /**
>   * We must be cautious when changing the bootloader_message struct size,
>   * because A/B-specific fields may end up with different offsets.
>   */
> -#ifndef __UBOOT__
> +
>  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
>  static_assert(sizeof(struct bootloader_message) =3D=3D 2048,
>                "struct bootloader_message size changes, which may break A=
/B devices");
>  #endif
> -#endif /* __UBOOT__ */
>
>  /**
>   * The A/B-specific bootloader message structure (4-KiB).
>   *
>   * We separate A/B boot control metadata from the regular bootloader
>   * message struct and keep it here. Everything that's A/B-specific
> - * stays after struct bootloader_message, which should be managed by
> - * the A/B-bootloader or boot control HAL.
> + * stays after struct bootloader_message, which belongs to the vendor
> + * space of /misc partition. Also, the A/B-specific contents should be
> + * managed by the A/B-bootloader or boot control HAL.
>   *
>   * The slot_suffix field is used for A/B implementations where the
>   * bootloader does not set the androidboot.ro.boot.slot_suffix kernel
> @@ -124,12 +172,10 @@ struct bootloader_message_ab {
>   * Be cautious about the struct size change, in case we put anything pos=
t
>   * bootloader_message_ab struct (b/29159185).
>   */
> -#ifndef __UBOOT__
>  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
>  static_assert(sizeof(struct bootloader_message_ab) =3D=3D 4096,
>                "struct bootloader_message_ab size changes");
>  #endif
> -#endif /* __UBOOT__ */
>
>  #define BOOT_CTRL_MAGIC   0x42414342 /* Bootloader Control AB */
>  #define BOOT_CTRL_VERSION 1
> @@ -165,11 +211,13 @@ struct bootloader_control {
>      // Version of struct being used (see BOOT_CTRL_VERSION).
>      uint8_t version;
>      // Number of slots being managed.
> -    uint8_t nb_slot : 3;
> +    uint16_t nb_slot : 3;
>      // Number of times left attempting to boot recovery.
> -    uint8_t recovery_tries_remaining : 3;
> +    uint16_t recovery_tries_remaining : 3;
> +    // Status of any pending snapshot merge of dynamic partitions.
> +    uint16_t merge_status : 3;
>      // Ensure 4-bytes alignment for slot_info field.
> -    uint8_t reserved0[2];
> +    uint8_t reserved0[1];
>      // Per-slot information.  Up to 4 slots.
>      struct slot_metadata slot_info[4];
>      // Reserved for further use.
> @@ -179,25 +227,46 @@ struct bootloader_control {
>      uint32_t crc32_le;
>  } __attribute__((packed));
>
> -#ifndef __UBOOT__
>  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
>  static_assert(sizeof(struct bootloader_control) =3D=3D
>                sizeof(((struct bootloader_message_ab *)0)->slot_suffix),
>                "struct bootloader_control has wrong size");
> +static_assert(sizeof(struct misc_virtual_ab_message) =3D=3D 64,
> +              "struct misc_virtual_ab_message has wrong size");
> +static_assert(sizeof(struct misc_memtag_message) =3D=3D 64,
> +              "struct misc_memtag_message has wrong size");
> +static_assert(sizeof(struct misc_kcmdline_message) =3D=3D 64,
> +              "struct misc_kcmdline_message has wrong size");
>  #endif
> -#endif /* __UBOOT__ */
>
>  #ifndef __UBOOT__
> +
> +// This struct is not meant to be used directly, rather, it is to make
> +// computation of offsets easier. New fields must be added to the end.
> +struct misc_system_space_layout {
> +  misc_virtual_ab_message virtual_ab_message;
> +  misc_memtag_message memtag_message;
> +  misc_kcmdline_message kcmdline_message;
> +} __attribute__((packed));
> +
>  #ifdef __cplusplus
>
>  #include <string>
>  #include <vector>
>
> +// Gets the block device name of /misc partition.
> +std::string get_misc_blk_device(std::string* err);
> +
>  // Return the block device name for the bootloader message partition and=
 waits
>  // for the device for up to 10 seconds. In case of error returns the emp=
ty
>  // string.
>  std::string get_bootloader_message_blk_device(std::string* err);
>
> +// Writes |size| bytes of data from buffer |p| to |misc_blk_device| at |=
offset|. If the write fails,
> +// sets the error message in |err|.
> +bool write_misc_partition(const void* p, size_t size, const std::string&=
 misc_blk_device,
> +                          size_t offset, std::string* err);
> +
>  // Read bootloader message into boot. Error message will be set in err.
>  bool read_bootloader_message(bootloader_message* boot, std::string* err)=
;
>
> @@ -242,6 +311,17 @@ bool read_wipe_package(std::string* package_data, si=
ze_t size, std::string* err)
>  // Write the wipe package into BCB (to offset WIPE_PACKAGE_OFFSET_IN_MIS=
C).
>  bool write_wipe_package(const std::string& package_data, std::string* er=
r);
>
> +// Read or write the Virtual A/B message from system space in /misc.
> +bool ReadMiscVirtualAbMessage(misc_virtual_ab_message* message, std::str=
ing* err);
> +bool WriteMiscVirtualAbMessage(const misc_virtual_ab_message& message, s=
td::string* err);
> +
> +// Read or write the memtag message from system space in /misc.
> +bool ReadMiscMemtagMessage(misc_memtag_message* message, std::string* er=
r);
> +bool WriteMiscMemtagMessage(const misc_memtag_message& message, std::str=
ing* err);
> +
> +// Read or write the kcmdline message from system space in /misc.
> +bool ReadMiscKcmdlineMessage(misc_kcmdline_message* message, std::string=
* err);
> +bool WriteMiscKcmdlineMessage(const misc_kcmdline_message& message, std:=
:string* err);

AFAIU, these new prototypes brought by this patch don't have actual
implementation yet. Does it affect the build somehow, e.g. maybe
causing some build warnings? Or is the build log clean?

>  #else
>
>  #include <stdbool.h>
> --
> 2.34.1
>
