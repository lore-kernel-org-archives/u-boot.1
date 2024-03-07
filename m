Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D58BC54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 09:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9C387E3F;
	Thu,  7 Mar 2024 10:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DyOq8S5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC3687C0A; Thu,  7 Mar 2024 10:29:46 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6551D87FC2
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 10:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d28051376eso9234621fa.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709803776; x=1710408576;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xqLfE5wBKM9HrvaKeDu7hSbGHyP/SkNUV97iE9RWV4o=;
 b=DyOq8S5nKa5wpu6qFd67vy+b0pfGXWKiRccmegcHEOsjEJFM/idN6ISzbgY/+eB/xt
 ic3t+vBEgydzxnddms87poZm9irKQ475nKkeBGza0zf5/VAzWIxYUghZEoYV16tBl8JL
 zPSWLGc07f8KLn2nAdd1dwMyCMwwJke5nnbqGjlH7A1lKop+KJkvIH6zc7A33V8+E1pS
 ojrjMMal8dFPB1uCqmrj1rhRNAIWfS2QssGhdnhlMcm2vCzev7/d8H8sZ1LF2OaIgIy8
 8XrQaHAdhc1/cD9wuuTxTHAfWQkGZH4kjclMCv16cW0zZw2ifSNHUi/Ur9gJA/YbnINe
 ldqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803776; x=1710408576;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqLfE5wBKM9HrvaKeDu7hSbGHyP/SkNUV97iE9RWV4o=;
 b=GVXdSnIUaBbzM2jJryMtOtgMKbQXT3jSQFGIdnUO2vTwI4+mOGfQJe+h7NkuWJgMqU
 sAy3n2gMjGKebB7uOURZeeNel0bzNfYf1hAwYexnY4bu5ldZC+TAHAX4MIaaF49SSV0W
 kW6DYUeQ+PWCr9adPMCNOZ3ENZvk6Az7xAict9WT3aSX41FPZ7Zx3Or6MtNasAX7t5Ds
 A0+Wi6DwhNyszxy1RrrHM89Ob75GImjP+yDr6yUA4BTKq4NNxr5YksPZhaDR9Dm15QTa
 1Hbz6hzI0pU0CUjAzePU8IxZ/UXEjsdgJt7Sbc98g444YrNwqCbDl5LShc3wdpY+/0ys
 k+UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcKZux3nkCB2KHFsXyVgAv3stUd5Ou6ciyjriDXpKNPUPIOdPG54HzuCZ/vbTBDGgPY4dI47Qok7cxkdTfW1yRC5AoEg==
X-Gm-Message-State: AOJu0Yxq6RptKpae60AHLNlECFRLxzzWlF2kj39AKnRxwJzErddUWKHl
 Gz2m3qimUgl+K0DRqkEG0RojwKWQe0bxUUb7qPTWHdaWTPhVyJutzfem/XaaF2g=
X-Google-Smtp-Source: AGHT+IENHwYManlWv29w+fNLptiWamVphV4FHIK4j0eqBp79W4KxhPprfuxUQDuE8tOIJkH+BPkvHQ==
X-Received: by 2002:a2e:7c17:0:b0:2d4:825:41af with SMTP id
 x23-20020a2e7c17000000b002d4082541afmr997331ljc.37.1709803776362; 
 Thu, 07 Mar 2024 01:29:36 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 cr11-20020a05600004eb00b0033dd2c3131fsm19535285wrb.65.2024.03.07.01.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 01:29:35 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Tom Rini <trini@konsulko.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass
 <sjg@chromium.org>, Alex Deymo <deymo@google.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v1] include: android_bootloader_message.h: sync with
 AOSP upstream
In-Reply-To: <20240219101559.364553-1-igor.opaniuk@gmail.com>
References: <20240219101559.364553-1-igor.opaniuk@gmail.com>
Date: Thu, 07 Mar 2024 10:29:34 +0100
Message-ID: <87ttliwfsx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

Thank you for the patch.

On lun., f=C3=A9vr. 19, 2024 at 11:15, Igor Opaniuk <igor.opaniuk@gmail.com=
> wrote:

> This takes the latest changes from AOSP from [1][2] (as this
> header was split on two) with minimal changes (this could lead
> to warnings reported by checkpatch).
>
> Some local changes have been applied:
> 1. Enable static_assert() for defined structures to be sure
> that all of them have correct sizes.
> 2. Adjuste types in bootloader_control structure with bitfields
> (uint8_t -> uint16_t). It seems that gcc just doesn't like bitfields
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

nitpick: Can you please put in the commit message the sha-1 from when this =
was synced?

Looking at platform/bootable/recovery, I can see that there are some new
structures introduced (misc_control_message) in
commit 5a4a41ee2e4b ("misctrl: read message, incl 16kb flag")

To do the review, I used:
* //bootable/recovery: a4aec2f2ceac ("Add kcmdline bootloader message")
* //hardware/interfaces: c4b2f5b564e3 ("Merge "Merge Android 14 QPR2 to AOS=
P main" into main")

>
> CC: Alex Deymo <deymo@google.com>
> CC: Sam Protsenko <semen.protsenko@linaro.org>
> CC: Eugeniu Rosca <erosca@de.adit-jv.com>
> CC: Simon Glass <sjg@chromium.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Tested on Khadas VIM3 that I could reboot into fastbootd (recovery)
and into fastboot(u-boot) from Android using:
$ adb reboot fastboot
$ adb reboot bootloader

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

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
>=20=20
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
>=20=20
>  /* Bootloader Message (2-KiB)
>   *
> @@ -81,24 +86,67 @@ struct bootloader_message {
>      char reserved[1184];
>  };
>=20=20
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
>=20=20
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
>   * Be cautious about the struct size change, in case we put anything post
>   * bootloader_message_ab struct (b/29159185).
>   */
> -#ifndef __UBOOT__
>  #if (__STDC_VERSION__ >=3D 201112L) || defined(__cplusplus)
>  static_assert(sizeof(struct bootloader_message_ab) =3D=3D 4096,
>                "struct bootloader_message_ab size changes");
>  #endif
> -#endif /* __UBOOT__ */
>=20=20
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
>=20=20
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
>=20=20
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
>=20=20
>  #include <string>
>  #include <vector>
>=20=20
> +// Gets the block device name of /misc partition.
> +std::string get_misc_blk_device(std::string* err);
> +
>  // Return the block device name for the bootloader message partition and=
 waits
>  // for the device for up to 10 seconds. In case of error returns the emp=
ty
>  // string.
>  std::string get_bootloader_message_blk_device(std::string* err);
>=20=20
> +// Writes |size| bytes of data from buffer |p| to |misc_blk_device| at |=
offset|. If the write fails,
> +// sets the error message in |err|.
> +bool write_misc_partition(const void* p, size_t size, const std::string&=
 misc_blk_device,
> +                          size_t offset, std::string* err);
> +
>  // Read bootloader message into boot. Error message will be set in err.
>  bool read_bootloader_message(bootloader_message* boot, std::string* err);
>=20=20
> @@ -242,6 +311,17 @@ bool read_wipe_package(std::string* package_data, si=
ze_t size, std::string* err)
>  // Write the wipe package into BCB (to offset WIPE_PACKAGE_OFFSET_IN_MIS=
C).
>  bool write_wipe_package(const std::string& package_data, std::string* er=
r);
>=20=20
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
>  #else
>=20=20
>  #include <stdbool.h>
> --=20
> 2.34.1
