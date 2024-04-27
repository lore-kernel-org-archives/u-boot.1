Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED0C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 17:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBE388283;
	Sat, 27 Apr 2024 19:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiCyoyaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5833F882BC; Sat, 27 Apr 2024 19:22:02 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DFF8825A
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 19:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-479f50bcd7bso874105137.3
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714238518; x=1714843318; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zwyzmveWEv3tXyeuHFZr5aaqBIMul/fWq7oDZfMf4U=;
 b=UiCyoyaFKLk+0bud4DzAxEY9wZybzZRH16XoIjClqMEy9KTpvoJx0o0eHeSTgoFTEC
 iQ3ymzwW3X6/OVvkqRfTsyDuJoFPMzWY39IuiXDaG4J1qG5AlzAVlc7C82BfbsnGxD1G
 kPq6daPJmcxY4oe0sR9P13dMc0W/EDfP4inckIa/Og0LZ76zA4dqd1vH8E+oTdkzdM0B
 NvwHCRth0lFuTBzLV8N5QgDE7J1538cVbfBMakBFSyVFSldIiD3nBISJ2qEbVYPQwFIB
 bk7VKp+X090d+K3a+hP28jHVn9w8k5EEZb0vOvMmqMWsp8J5j7utOJHI8fj7cOsQM/IH
 r1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714238518; x=1714843318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zwyzmveWEv3tXyeuHFZr5aaqBIMul/fWq7oDZfMf4U=;
 b=GlzhUlA3re68Rfg9g1EcOeYPxH27vxpac40Fo3vyT61/QOMzi0UBXACqK2/IRfsfRq
 E73cgYF8vdmVcQCDoyuvYSC5B3Wu99y6tWV0FVzVSPjn9AdrveftmqC+7u4NyAryDBmL
 bm0rpEe6kg49XVgCA1ua1TOLhC2Le93+iqyla1snYEg5AqZheGBx0aKOXhjcbayUyVNK
 bTzOEMPmvJLP2z4x7ktD6WOSa97ygNPmu6klTsgj1qRDYwP8MqjogNzm6eLoKjnEOFiK
 G088xkMFYHa5qoksD26qu0MRJhG150wZliNMPhi/tKjyaywEpHmVKZfFwkagJ7lbQ24K
 dfAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVThjgNE3DZ9QeZS++J9ynHjHFXM7696/HICKFYCq4XDVUr3SZ74Dni4/P3v2pMNsI0NzV+HX8MQkQ2jRTXtdF4CGPPMA==
X-Gm-Message-State: AOJu0YwT/6VOh37akJbZMpI77lWPk/WZxR3RLGwmFFaJSIWmSfpDxg4s
 lk9dV8XKOR2A6a3yEIF0YCt0HhsGpxg65cv0ekoAFypLnSS6FpC5jNXTa7YcdZoo2MX6Wo18Mts
 jVekCNRVWPvxUWaJBNfZVIdc3rFA=
X-Google-Smtp-Source: AGHT+IGNTdc7fvud4wyxQpe+jizZqGi/xOi0Xsk23LNPY3ONQN48IpTjo9u4PWmzQKUCyRp4C2parhRzyg0FbBhVTRg=
X-Received: by 2002:a05:6102:3f01:b0:47c:fe3:4f50 with SMTP id
 k1-20020a0561023f0100b0047c0fe34f50mr4760270vsv.22.1714238517903; Sat, 27 Apr
 2024 10:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426141321.232236-5-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 27 Apr 2024 10:21:46 -0700
Message-ID: <CANV2PTMG-eKjkDyumyvj-oqt+vNtyOW_Am650X5m88P6P1Qf5A@mail.gmail.com>
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

On Fri, Apr 26, 2024 at 7:25=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We already support creating a load option where the device-path
> field contains the concatenation of the binary device-path and
> optionally the device path of the initrd which we expose via the
> EFI_LOAD_FILE2_PROTOCOL.
>
> Allow to append another device-path pointing to the device-tree
> identified by the device-tree GUID.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/eficonfig.c | 68 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 1c57e66040b..d314051ee58 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -62,6 +62,7 @@ struct eficonfig_filepath_info {
>  struct eficonfig_boot_option {
>         struct eficonfig_select_file_info file_info;
>         struct eficonfig_select_file_info initrd_info;
> +       struct eficonfig_select_file_info fdt_info;
>         unsigned int boot_index;
>         u16 *description;
>         u16 *optional_data;
> @@ -1308,6 +1309,10 @@ static efi_status_t eficonfig_show_boot_option(str=
uct eficonfig_boot_option *bo,
>         if (ret !=3D EFI_SUCCESS)
>                 goto out;
>
> +       ret =3D prepare_file_selection_entry(efi_menu, "Fdt File: ", &bo-=
>fdt_info);
> +       if (ret !=3D EFI_SUCCESS)
> +               goto out;
> +
>         ret =3D create_boot_option_entry(efi_menu, "Optional Data: ", bo-=
>optional_data,
>                                        eficonfig_boot_add_optional_data, =
bo);
>         if (ret !=3D EFI_SUCCESS)
> @@ -1394,21 +1399,39 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>         struct efi_device_path *final_dp =3D NULL;
>         struct efi_device_path *device_dp =3D NULL;
>         struct efi_device_path *initrd_dp =3D NULL;
> +       struct efi_device_path *fdt_dp =3D NULL;
>         struct efi_device_path *initrd_device_dp =3D NULL;
> +       struct efi_device_path *fdt_device_dp =3D NULL;
>
> -       const struct efi_initrd_dp id_dp =3D {
> +       const struct efi_initrd_dp initrd_prefix =3D {
>                 .vendor =3D {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
>                         DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> -                       sizeof(id_dp.vendor),
> +                       sizeof(initrd_prefix.vendor),
>                         },
>                         EFI_INITRD_MEDIA_GUID,
>                 },
>                 .end =3D {
>                         DEVICE_PATH_TYPE_END,
>                         DEVICE_PATH_SUB_TYPE_END,
> -                       sizeof(id_dp.end),
> +                       sizeof(initrd_prefix.end),
> +               }
> +       };
> +
> +       const struct efi_initrd_dp fdt_prefix =3D {
> +               .vendor =3D {
> +                       {
> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> +                       sizeof(fdt_prefix.vendor),
> +                       },
> +                       EFI_FDT_GUID,
> +               },
> +               .end =3D {
> +                       DEVICE_PATH_TYPE_END,
> +                       DEVICE_PATH_SUB_TYPE_END,
> +                       sizeof(initrd_prefix.end),
>                 }
>         };
>
> @@ -1424,6 +1447,12 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>                 goto out;
>         }
>
> +       bo->fdt_info.current_path =3D calloc(1, EFICONFIG_FILE_PATH_BUF_S=
IZE);
> +       if (!bo->fdt_info.current_path) {
> +               ret =3D  EFI_OUT_OF_RESOURCES;
> +               goto out;
> +       }
> +
>         bo->description =3D calloc(1, EFICONFIG_DESCRIPTION_MAX * sizeof(=
u16));
>         if (!bo->description) {
>                 ret =3D  EFI_OUT_OF_RESOURCES;
> @@ -1456,13 +1485,20 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>                 if (lo.file_path)
>                         fill_file_info(lo.file_path, &bo->file_info, devi=
ce_dp);
>
> -               /* Initrd file path(optional) is placed at second instanc=
e. */
> +               /* Initrd file path (optional) is placed at second instan=
ce. */
>                 initrd_dp =3D efi_dp_from_lo(&lo, &efi_lf2_initrd_guid);
>                 if (initrd_dp) {
>                         fill_file_info(initrd_dp, &bo->initrd_info, initr=
d_device_dp);
>                         efi_free_pool(initrd_dp);
>                 }
>
> +               /* Fdt file path (optional) is placed as third instance. =
*/
> +               fdt_dp =3D efi_dp_from_lo(&lo, &efi_guid_fdt);
> +               if (fdt_dp) {
> +                       fill_file_info(fdt_dp, &bo->fdt_info, fdt_device_=
dp);
> +                       efi_free_pool(fdt_dp);
> +               }
> +
>                 if (size > 0)
>                         memcpy(bo->optional_data, lo.optional_data, size)=
;
>         }
> @@ -1484,11 +1520,23 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
>                         ret =3D EFI_OUT_OF_RESOURCES;
>                         goto out;
>                 }
> -               initrd_dp =3D efi_dp_concat((const struct efi_device_path=
 *)&id_dp,
> +               initrd_dp =3D efi_dp_concat((const struct efi_device_path=
 *)&initrd_prefix,
>                                           dp);
>                 efi_free_pool(dp);
>         }
>
> +       if (bo->fdt_info.dp_volume) {
> +               dp =3D eficonfig_create_device_path(bo->fdt_info.dp_volum=
e,
> +                                                 bo->fdt_info.current_pa=
th);
> +               if (!dp) {
> +                       ret =3D EFI_OUT_OF_RESOURCES;
> +                       goto out;
> +               }
> +               fdt_dp =3D efi_dp_concat((const struct efi_device_path *)=
&fdt_prefix,
> +                                      dp);
> +               efi_free_pool(dp);
> +       }
> +
>         dp =3D eficonfig_create_device_path(bo->file_info.dp_volume, bo->=
file_info.current_path);
>         if (!dp) {
>                 ret =3D EFI_OUT_OF_RESOURCES;
> @@ -1505,6 +1553,13 @@ static efi_status_t eficonfig_edit_boot_option(u16=
 *varname, struct eficonfig_bo
>                         goto out;
>                 }
>         }
> +       if (fdt_dp) {
> +               final_dp =3D efi_dp_merge(final_dp, &final_dp_size, fdt_d=
p);
> +               if (!final_dp) {
> +                       ret =3D EFI_OUT_OF_RESOURCES;
> +                       goto out;
> +               }
> +       }
>
>         if (utf16_utf8_strlen(bo->optional_data)) {
>                 len =3D utf16_utf8_strlen(bo->optional_data) + 1;
> @@ -1522,9 +1577,12 @@ out:
>         free(bo->description);
>         free(bo->file_info.current_path);
>         free(bo->initrd_info.current_path);
> +       free(bo->fdt_info.current_path);
>         efi_free_pool(device_dp);
>         efi_free_pool(initrd_device_dp);
>         efi_free_pool(initrd_dp);
> +       efi_free_pool(fdt_device_dp);
> +       efi_free_pool(fdt_dp);
>         efi_free_pool(final_dp);
>
>         return ret;
> --
> 2.43.0
>

Would it make sense to skip showing the user partitions that are not
valid (or why does the Linux Swap partition not show here but the
Linux partition with ext4 does? Neither is valid for selecting Fdt
File ?) and/or extend eficonfig for user-entered data? For example if
I was very sure I wanted U-Boot to search a location but I just didn't
have the SD Card that configuration is meant for currently inserted, I
must use efidebug to configure this?

It was always confusing how Edit action hides from view an automatic
(global?) boot option i.e. 'mmc 0' that is configurable from Change
Boot Order. I guess that there would have just been File
EFI\BOOT\BOOTRISCV64.EFI to show and that is not interesting enough
information for the added complexity of a save-disabled Edit entry.
However now or in future there will be useful information to display
so this should become viewable as a save-disabled entry from Edit
(rename? View/Edit) action, where it is convenient to see File
constant EFI\BOOT\BOOTRISCV64.EFI and also the detected values that
will be used i.e. from parsing U-Boot variable $fdtfile. I do not mean
that this should be a method for editing U-Boot environment variables,
only that it would be useful to know for example when
$fdtfile=3Dvendor/boardname.dtb that the U-Boot EFI code heuristic has
decided that this currently resolves to mmc
0:1/dtb\vendor\boardname.dtb value. If the automatic values are not
what the user wants then they may create a new boot entry or leave the
context of eficonfig to update something that affects the detection
logic such as U-Boot env variables, and perhaps again enter eficonfig
to confirm that the heuristic is now doing what they would like.
Without any visibility of this global boot option from the Edit
action, it is not known to need to edit the boot order after adding a
boot entry where before there was apparently none. Some of that could
be addressed with documentation but the best result would be it being
obvious through use. It's not really obvious now that something named
'mmc 0' only appearing in the Boot Order action of eficonfig what
filename it requires or if it is going to use an Initrd and/or Fdt.

Aside these more broad usability concerns there was success in adding
a boot item with Fdt setting and changing the order that it be
preferred entry.

Tested-by: E Shattow <lucent@gmail.com>
