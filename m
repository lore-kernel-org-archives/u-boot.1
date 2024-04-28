Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB72C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 04:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288DA88258;
	Sun, 28 Apr 2024 06:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bKOOvg8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2088825D; Sun, 28 Apr 2024 06:13:36 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DAB8824C
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 06:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4dcfba0cf35so1011243e0c.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 21:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714277613; x=1714882413; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plDnggDvQ9HI8Uy9/gJ8SwNiIMeS9qIndAM5in/URqQ=;
 b=bKOOvg8lCT4j6muYx/31IB38Pzn9rSF005wSfZJ6izxOdtQHayvvmwMl8j14L/jgLG
 ww4NqtjBvgMW/Yd2cRMUe5S0g0VedF6OGMlxJ7aSWGE9q2QDro3dcyUgYGRQbfTeoxGx
 thR7awQY21bZzopjILzB0l4jX7YCgJMjYM2yIEUalJGIFnqTMZ0GtBHKSJgVDSLSPybS
 r4Vc7CKPpWTg0l2nGlhV/4KG3/g1CV8B5tXK8+KAvRRQHVAxSY3zi8syJHjgY0dk2Jge
 3UD3YBi569qLocFtW6a++FF/Tcji8vFsHlhbaKMNeWNnU4a5zZpeMCKDe/Ak8gtJsBam
 1X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714277613; x=1714882413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plDnggDvQ9HI8Uy9/gJ8SwNiIMeS9qIndAM5in/URqQ=;
 b=sHRHkdjdnB94LsWsJ5kn3uM9Q0DwMOZP+z6BnX6K4Vd0dDqHDVaD8UmkZbpT9K9dne
 fJXtFrVHoP4RuGBYndu3YSFai/ojKXmAAW+SkjdnixJxFoG6eMdSvvLCgoHuSQWY3Zel
 dR0f4HOS6jyiM9z6GeExgLlD/7+2u7wkidIOLR9nQ7pjugBiV0e5PDNeWPkykrOhOQLA
 jAtNvDN+MsTq02rNnUidqRNNGPTZYRHwynbLPzRZzEcDZYgpEAd2FWs3FD8P97Rijp88
 09/talfTneDgCuKv8DGVTudTY65h7y+0nnpZqPFaap/UZHENxYbjRsKPt1H3gXpyzgEs
 CGaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvFLwFCqdZZKru1kPBqt3o3yqaLlnhOygRNfPQONe30O+LgmNC7IvPqN7XfECAcRW2tfDD7/ba2e1xngj3UTRoIu8t1g==
X-Gm-Message-State: AOJu0Yyz2SiRCPxJoQbrJpWMOsI3yrW72/iBYQsRfqMTSlysRgoVeT9W
 OH6kespMLBkt0fU2KN6oUm9dT6r5OTjIPHINJFQZxepOUYY3rRslCRFpdgGHCLfLr8C4vg2TLMc
 CYQDE+UqIFDmI/swQs3pmPRQnX08=
X-Google-Smtp-Source: AGHT+IEktYgY2/4+5VW9Sjc0iJYDU3JFlKbxOX4bew69dBTN46s4XTGXnLoaAulZ+9Ng5s5cY/y3WIwydsi5lw9o7dM=
X-Received: by 2002:a05:6122:459d:b0:4c8:e834:6cf2 with SMTP id
 de29-20020a056122459d00b004c8e8346cf2mr7055389vkb.3.1714277612352; Sat, 27
 Apr 2024 21:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-5-heinrich.schuchardt@canonical.com>
 <CANV2PTMG-eKjkDyumyvj-oqt+vNtyOW_Am650X5m88P6P1Qf5A@mail.gmail.com>
 <1a2f27c2-9006-478b-a4cd-59dfec854143@canonical.com>
In-Reply-To: <1a2f27c2-9006-478b-a4cd-59dfec854143@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 27 Apr 2024 21:13:20 -0700
Message-ID: <CANV2PTNUwFag1jqOT=CRgnUBSYrVFEf=XgKhnvGZVmSyer2sXA@mail.gmail.com>
Subject: Re: [RFC 04/14] cmd: eficonfig: add support for setting fdt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Shantur Rathore <i@shantur.com>,
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
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

On Sat, Apr 27, 2024 at 2:25=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/27/24 19:21, E Shattow wrote:
> > On Fri, Apr 26, 2024 at 7:25=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> We already support creating a load option where the device-path
> >> field contains the concatenation of the binary device-path and
> >> optionally the device path of the initrd which we expose via the
> >> EFI_LOAD_FILE2_PROTOCOL.
> >>
> >> Allow to append another device-path pointing to the device-tree
> >> identified by the device-tree GUID.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   cmd/eficonfig.c | 68 +++++++++++++++++++++++++++++++++++++++++++++--=
--
> >>   1 file changed, 63 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> >> index 1c57e66040b..d314051ee58 100644
> >> --- a/cmd/eficonfig.c
> >> +++ b/cmd/eficonfig.c
> >> @@ -62,6 +62,7 @@ struct eficonfig_filepath_info {
> >>   struct eficonfig_boot_option {
> >>          struct eficonfig_select_file_info file_info;
> >>          struct eficonfig_select_file_info initrd_info;
> >> +       struct eficonfig_select_file_info fdt_info;
> >>          unsigned int boot_index;
> >>          u16 *description;
> >>          u16 *optional_data;
> >> @@ -1308,6 +1309,10 @@ static efi_status_t eficonfig_show_boot_option(=
struct eficonfig_boot_option *bo,
> >>          if (ret !=3D EFI_SUCCESS)
> >>                  goto out;
> >>
> >> +       ret =3D prepare_file_selection_entry(efi_menu, "Fdt File: ", &=
bo->fdt_info);
> >> +       if (ret !=3D EFI_SUCCESS)
> >> +               goto out;
> >> +
> >>          ret =3D create_boot_option_entry(efi_menu, "Optional Data: ",=
 bo->optional_data,
> >>                                         eficonfig_boot_add_optional_da=
ta, bo);
> >>          if (ret !=3D EFI_SUCCESS)
> >> @@ -1394,21 +1399,39 @@ static efi_status_t eficonfig_edit_boot_option=
(u16 *varname, struct eficonfig_bo
> >>          struct efi_device_path *final_dp =3D NULL;
> >>          struct efi_device_path *device_dp =3D NULL;
> >>          struct efi_device_path *initrd_dp =3D NULL;
> >> +       struct efi_device_path *fdt_dp =3D NULL;
> >>          struct efi_device_path *initrd_device_dp =3D NULL;
> >> +       struct efi_device_path *fdt_device_dp =3D NULL;
> >>
> >> -       const struct efi_initrd_dp id_dp =3D {
> >> +       const struct efi_initrd_dp initrd_prefix =3D {
> >>                  .vendor =3D {
> >>                          {
> >>                          DEVICE_PATH_TYPE_MEDIA_DEVICE,
> >>                          DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> >> -                       sizeof(id_dp.vendor),
> >> +                       sizeof(initrd_prefix.vendor),
> >>                          },
> >>                          EFI_INITRD_MEDIA_GUID,
> >>                  },
> >>                  .end =3D {
> >>                          DEVICE_PATH_TYPE_END,
> >>                          DEVICE_PATH_SUB_TYPE_END,
> >> -                       sizeof(id_dp.end),
> >> +                       sizeof(initrd_prefix.end),
> >> +               }
> >> +       };
> >> +
> >> +       const struct efi_initrd_dp fdt_prefix =3D {
> >> +               .vendor =3D {
> >> +                       {
> >> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
> >> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> >> +                       sizeof(fdt_prefix.vendor),
> >> +                       },
> >> +                       EFI_FDT_GUID,
> >> +               },
> >> +               .end =3D {
> >> +                       DEVICE_PATH_TYPE_END,
> >> +                       DEVICE_PATH_SUB_TYPE_END,
> >> +                       sizeof(initrd_prefix.end),
> >>                  }
> >>          };
> >>
> >> @@ -1424,6 +1447,12 @@ static efi_status_t eficonfig_edit_boot_option(=
u16 *varname, struct eficonfig_bo
> >>                  goto out;
> >>          }
> >>
> >> +       bo->fdt_info.current_path =3D calloc(1, EFICONFIG_FILE_PATH_BU=
F_SIZE);
> >> +       if (!bo->fdt_info.current_path) {
> >> +               ret =3D  EFI_OUT_OF_RESOURCES;
> >> +               goto out;
> >> +       }
> >> +
> >>          bo->description =3D calloc(1, EFICONFIG_DESCRIPTION_MAX * siz=
eof(u16));
> >>          if (!bo->description) {
> >>                  ret =3D  EFI_OUT_OF_RESOURCES;
> >> @@ -1456,13 +1485,20 @@ static efi_status_t eficonfig_edit_boot_option=
(u16 *varname, struct eficonfig_bo
> >>                  if (lo.file_path)
> >>                          fill_file_info(lo.file_path, &bo->file_info, =
device_dp);
> >>
> >> -               /* Initrd file path(optional) is placed at second inst=
ance. */
> >> +               /* Initrd file path (optional) is placed at second ins=
tance. */
> >>                  initrd_dp =3D efi_dp_from_lo(&lo, &efi_lf2_initrd_gui=
d);
> >>                  if (initrd_dp) {
> >>                          fill_file_info(initrd_dp, &bo->initrd_info, i=
nitrd_device_dp);
> >>                          efi_free_pool(initrd_dp);
> >>                  }
> >>
> >> +               /* Fdt file path (optional) is placed as third instanc=
e. */
> >> +               fdt_dp =3D efi_dp_from_lo(&lo, &efi_guid_fdt);
> >> +               if (fdt_dp) {
> >> +                       fill_file_info(fdt_dp, &bo->fdt_info, fdt_devi=
ce_dp);
> >> +                       efi_free_pool(fdt_dp);
> >> +               }
> >> +
> >>                  if (size > 0)
> >>                          memcpy(bo->optional_data, lo.optional_data, s=
ize);
> >>          }
> >> @@ -1484,11 +1520,23 @@ static efi_status_t eficonfig_edit_boot_option=
(u16 *varname, struct eficonfig_bo
> >>                          ret =3D EFI_OUT_OF_RESOURCES;
> >>                          goto out;
> >>                  }
> >> -               initrd_dp =3D efi_dp_concat((const struct efi_device_p=
ath *)&id_dp,
> >> +               initrd_dp =3D efi_dp_concat((const struct efi_device_p=
ath *)&initrd_prefix,
> >>                                            dp);
> >>                  efi_free_pool(dp);
> >>          }
> >>
> >> +       if (bo->fdt_info.dp_volume) {
> >> +               dp =3D eficonfig_create_device_path(bo->fdt_info.dp_vo=
lume,
> >> +                                                 bo->fdt_info.current=
_path);
> >> +               if (!dp) {
> >> +                       ret =3D EFI_OUT_OF_RESOURCES;
> >> +                       goto out;
> >> +               }
> >> +               fdt_dp =3D efi_dp_concat((const struct efi_device_path=
 *)&fdt_prefix,
> >> +                                      dp);
> >> +               efi_free_pool(dp);
> >> +       }
> >> +
> >>          dp =3D eficonfig_create_device_path(bo->file_info.dp_volume, =
bo->file_info.current_path);
> >>          if (!dp) {
> >>                  ret =3D EFI_OUT_OF_RESOURCES;
> >> @@ -1505,6 +1553,13 @@ static efi_status_t eficonfig_edit_boot_option(=
u16 *varname, struct eficonfig_bo
> >>                          goto out;
> >>                  }
> >>          }
> >> +       if (fdt_dp) {
> >> +               final_dp =3D efi_dp_merge(final_dp, &final_dp_size, fd=
t_dp);
> >> +               if (!final_dp) {
> >> +                       ret =3D EFI_OUT_OF_RESOURCES;
> >> +                       goto out;
> >> +               }
> >> +       }
> >>
> >>          if (utf16_utf8_strlen(bo->optional_data)) {
> >>                  len =3D utf16_utf8_strlen(bo->optional_data) + 1;
> >> @@ -1522,9 +1577,12 @@ out:
> >>          free(bo->description);
> >>          free(bo->file_info.current_path);
> >>          free(bo->initrd_info.current_path);
> >> +       free(bo->fdt_info.current_path);
> >>          efi_free_pool(device_dp);
> >>          efi_free_pool(initrd_device_dp);
> >>          efi_free_pool(initrd_dp);
> >> +       efi_free_pool(fdt_device_dp);
> >> +       efi_free_pool(fdt_dp);
> >>          efi_free_pool(final_dp);
> >>
> >>          return ret;
> >> --
> >> 2.43.0
> >>
> >
> > Would it make sense to skip showing the user partitions that are not
> > valid (or why does the Linux Swap partition not show here but the
> > Linux partition with ext4 does? Neither is valid for selecting Fdt
> > File ?) and/or extend eficonfig for user-entered data? For example if
> > I was very sure I wanted U-Boot to search a location but I just didn't
> > have the SD Card that configuration is meant for currently inserted, I
> > must use efidebug to configure this?
>
> The eficonfig command shows the partitions with a file-system that
> U-Boot supports. What problems do you see in being able to specify that
> a device-tree file shall be loaded from an ext4 file-system?

If selections other than EFI System Partition may be valid for File,
Initrd File, and Fdt File here then it would be useful yes. As tested
there are no files or directories are displayed in eficonfig when
trying this Linux ext4 partition. Not any issue with this patch, then.

>
> >
> > It was always confusing how Edit action hides from view an automatic
> > (global?) boot option i.e. 'mmc 0' that is configurable from Change
> > Boot Order. I guess that there would have just been File
> > EFI\BOOT\BOOTRISCV64.EFI to show and that is not interesting enough
> > information for the added complexity of a save-disabled Edit entry.
> > However now or in future there will be useful information to display
> > so this should become viewable as a save-disabled entry from Edit
> > (rename? View/Edit) action, where it is convenient to see File
> > constant EFI\BOOT\BOOTRISCV64.EFI and also the detected values that
>
> This file name is not stored in the Boot#### variable. It would be
> confusing to show a file name here.

Okay, outside of the scope of this patch then. Moving that to its own
discussion. Thanks.

>
> > will be used i.e. from parsing U-Boot variable $fdtfile. I do not mean
> > that this should be a method for editing U-Boot environment variables,
> > only that it would be useful to know for example when
> > $fdtfile=3Dvendor/boardname.dtb that the U-Boot EFI code heuristic has
> > decided that this currently resolves to mmc
> > 0:1/dtb\vendor\boardname.dtb value. If the automatic values are not
> > what the user wants then they may create a new boot entry or leave the
> > context of eficonfig to update something that affects the detection
> > logic such as U-Boot env variables, and perhaps again enter eficonfig
> > to confirm that the heuristic is now doing what they would like.
>
> The eficonfig command is used to edit the EFI variables Boot#### and
> BootOrder. This is the content shown by the command.
>
> With patch 14 a logic is implemented to read a device-tree file supplied
> on the boot partition.
>
> Which file will be loaded is not known when the boot option is edited as
> multiple directories are scanned and the value of $fdtfile may be
> changed by the user before invoking the bootmgr. Scanning which such
> file exists while running the editor would unnecessarily complicate the
> code.
>

Ack.

> For sure the fall-back logic should be documented.
>
> Best regards
>
> Heinrich
>
> > Without any visibility of this global boot option from the Edit
> > action, it is not known to need to edit the boot order after adding a
> > boot entry where before there was apparently none. Some of that could
> > be addressed with documentation but the best result would be it being
> > obvious through use. It's not really obvious now that something named
> > 'mmc 0' only appearing in the Boot Order action of eficonfig what
> > filename it requires or if it is going to use an Initrd and/or Fdt.
> >
> > Aside these more broad usability concerns there was success in adding
> > a boot item with Fdt setting and changing the order that it be
> > preferred entry.
> >
> > Tested-by: E Shattow <lucent@gmail.com>
>
