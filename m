Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC025C54E4A
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 23:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481AB8785A;
	Fri,  8 Mar 2024 00:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sfIMYINd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB28187B77; Fri,  8 Mar 2024 00:08:33 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31075877AF
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 00:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcbd1d4904dso1494960276.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 15:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709852910; x=1710457710; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgheNGk2S2+CylqVXBBhMo4D8qecXdrw8OusuRwcSA0=;
 b=sfIMYINdhpEx6PO5P531XYIebrwCetsw6DbYut5bpSz4vERm0GR06LCflx+KzRVUQZ
 OTeEu8mNOl+WdQbUcRgojykNFnrXvNEfyM3MsB6c/BuqLgpML3KX2GilD3YFWPWCpk/D
 wqBqiOeaZ5FAte/mY/NpKo26EvQ/eT7rMaV7gv+Ym9iFqVIDUCA+DUulHJZt0LShZeLr
 86II0gVaMNAEzaTj7TwVvmkPVBT1XclcpwiVY8Kxkowp1A8hwJW9fh66VypeAGF6P+TQ
 KNQYtYLUVypMvVsavvr2PfyyXkdsNxvK5o16sE8HyNOKHfXDiaGvrtfYJokzLRmLfMor
 xBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709852910; x=1710457710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgheNGk2S2+CylqVXBBhMo4D8qecXdrw8OusuRwcSA0=;
 b=UUg3sEb6QRotEVzvPCzwb2hklm5ePVzosb/0M2SAaUn6OxEEnX7XteKCxhgdklSFBe
 GqPKvVkacH0CYP2lFhO+2m5Bw3gJlDkNo2XfcBmjljHZBy3X6x3Q6yujxXzuZx5JDVwa
 2422QzygExKqs+2cVnpWJ4HaqN4soWlcIUNwwf4qxgI/arUrNafjLPCM82pnRSvnA+ko
 2psbzOV8hHtNdHaEqpjtZMRPmc+zYxgi5wdXaXeTzVKdTk+dbgzZMsx8SF7ASxRWriRv
 ZWAOZ9nf0pvOb2J9PP7y+ioT8Zp5JcXuy2IiZ0fl2LrsXC5BoKIsPfbQW8yZmfX2aHUN
 WJZw==
X-Gm-Message-State: AOJu0Yx26wJBARPW69wVKGgmnjE+vdytmE8WaFFfieB4k6n1XUglpnyh
 oA0sn2RdoPCiPSKBSzKLRKJH/Sk25TumhapvYaEwNtUY2M3lTl3legc632C+229PK3D7noV1iNS
 ITccZM3sg3hFKrDelkZ/vFCsyomIeU8tPXhO76w==
X-Google-Smtp-Source: AGHT+IHnNm801zXkif2m/EfCdAxq8FuS6tx20zYIQKGPilZ1e4JE6mCIvmMMVnbqD3Kzgx8Y0ErDjZalFQWQAzjdr5I=
X-Received: by 2002:a25:bb85:0:b0:dc6:de64:f74 with SMTP id
 y5-20020a25bb85000000b00dc6de640f74mr16406139ybg.9.1709852909801; Thu, 07 Mar
 2024 15:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-3-colin.mcallister@garmin.com>
In-Reply-To: <20240307221030.3685767-3-colin.mcallister@garmin.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 7 Mar 2024 17:08:18 -0600
Message-ID: <CAPLW+4ns-_QqUJYZbTiT_SgTYL4caj4fkMBwX69Od9A8_077uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org
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

On Thu, Mar 7, 2024 at 4:11=E2=80=AFPM Colin McAllister
<colin.mcallister@garmin.com> wrote:
>
> Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
> not actually enable the #if protected code in android_ab.c. This is
> because "CONFIG_" should have been prepended to the config macro, or the
> macros defined in kconfig.h could have been used.
>

I think this change deserves "Fixes:" tag. Also, please keep a
changelog under "---" stanza for each patch in the series starting
with v2, otherwise it's hard for reviewers to track the changes
between different versions.

> The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
> longer be conditionally compiled by preprocessor conditionals and
> instead use C conditionals. This better aligns with the Linux kernel
> style guide.
>
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 52 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 9a3d15ec60..f547aa64e4 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t disk_partition *part_info,
>                    bool dec_tries)
>  {
>         struct bootloader_control *abc =3D NULL;
> +       struct bootloader_control *backup_abc =3D NULL;
>         u32 crc32_le;
>         int slot, i, ret;
>         bool store_needed =3D false;
> +       bool valid_backup =3D false;
>         char slot_suffix[4];
> -#if ANDROID_AB_BACKUP_OFFSET
> -       struct bootloader_control *backup_abc =3D NULL;
> -#endif
>
>         ret =3D ab_control_create_from_disk(dev_desc, part_info, &abc, 0)=
;
>         if (ret < 0) {
> @@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t disk_partition *part_info,
>                 return ret;
>         }
>
> -#if ANDROID_AB_BACKUP_OFFSET
> -       ret =3D ab_control_create_from_disk(dev_desc, part_info, &backup_=
abc,
> -                                         ANDROID_AB_BACKUP_OFFSET);
> -       if (ret < 0) {
> -               free(abc);
> -               return ret;
> +       if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> +               ret =3D ab_control_create_from_disk(dev_desc, part_info, =
&backup_abc,
> +                                                 CONFIG_ANDROID_AB_BACKU=
P_OFFSET);
> +               if (ret < 0) {
> +                       free(abc);
> +                       return ret;
> +               }
>         }
> -#endif
>
>         crc32_le =3D ab_control_compute_crc(abc);
>         if (abc->crc32_le !=3D crc32_le) {
>                 log_err("ANDROID: Invalid CRC-32 (expected %.8x, found %.=
8x),",
>                         crc32_le, abc->crc32_le);
> -#if ANDROID_AB_BACKUP_OFFSET
> -               crc32_le =3D ab_control_compute_crc(backup_abc);
> -               if (backup_abc->crc32_le !=3D crc32_le) {
> -                       log_err("ANDROID: Invalid backup CRC-32 ");
> -                       log_err("expected %.8x, found %.8x),",
> -                               crc32_le, backup_abc->crc32_le);
> -#endif
> -
> -                       log_err("re-initializing A/B metadata.\n");
> +               if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {

Did you test what happens if this config option is not defined at all?
Maybe it'd be better to use CONFIG_IS_ENABLED() instead, here and in
other cases like this?

> +                       crc32_le =3D ab_control_compute_crc(backup_abc);
> +                       if (backup_abc->crc32_le !=3D crc32_le) {
> +                               log_err(" ANDROID: Invalid backup CRC-32 =
");
> +                               log_err("(expected %.8x, found %.8x),",
> +                                       crc32_le, backup_abc->crc32_le);
> +                       } else {
> +                               valid_backup =3D true;
> +                               log_info(" copying A/B metadata from back=
up.\n");
> +                               memcpy(abc, backup_abc, sizeof(*abc));
> +                       }
> +               }
>
> +               if (!valid_backup) {
> +                       log_err(" re-initializing A/B metadata.\n");
>                         ret =3D ab_control_default(abc);
>                         if (ret < 0) {
> -#if ANDROID_AB_BACKUP_OFFSET
> -                               free(backup_abc);
> -#endif
> +                               if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +                                       free(backup_abc);
>                                 free(abc);
>                                 return -ENODATA;
>                         }
> -#if ANDROID_AB_BACKUP_OFFSET
> -               } else {
> -                       /*
> -                        * Backup is valid. Copy it to the primary
> -                        */
> -                       memcpy(abc, backup_abc, sizeof(*abc));
>                 }
> -#endif
>                 store_needed =3D true;
>         }
>
>         if (abc->magic !=3D BOOT_CTRL_MAGIC) {
>                 log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->mag=
ic);
> -#if ANDROID_AB_BACKUP_OFFSET
> -               free(backup_abc);
> -#endif
> +               if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +                       free(backup_abc);
>                 free(abc);
>                 return -ENODATA;
>         }
> @@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
>         if (abc->version > BOOT_CTRL_VERSION) {
>                 log_err("ANDROID: Unsupported A/B metadata version: %.8x\=
n",
>                         abc->version);
> -#if ANDROID_AB_BACKUP_OFFSET
> -               free(backup_abc);
> -#endif
> +               if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +                       free(backup_abc);
>                 free(abc);
>                 return -ENODATA;
>         }
> @@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t disk_partition *part_info,
>                 abc->crc32_le =3D ab_control_compute_crc(abc);
>                 ret =3D ab_control_store(dev_desc, part_info, abc, 0);
>                 if (ret < 0) {
> -#if ANDROID_AB_BACKUP_OFFSET
> -                       free(backup_abc);
> -#endif
> +                       if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
> +                               free(backup_abc);
>                         free(abc);
>                         return ret;
>                 }
>         }
>
> -#if ANDROID_AB_BACKUP_OFFSET
> -       /*
> -        * If the backup doesn't match the primary, write the primary
> -        * to the backup offset
> -        */
> -       if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> -               ret =3D ab_control_store(dev_desc, part_info, abc,
> -                                      ANDROID_AB_BACKUP_OFFSET);
> -               if (ret < 0) {
> -                       free(backup_abc);
> -                       free(abc);
> -                       return ret;
> +       if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
> +               /*
> +               * If the backup doesn't match the primary, write the prim=
ary
> +               * to the backup offset
> +               */
> +               if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
> +                       ret =3D ab_control_store(dev_desc, part_info, abc=
,
> +                                              CONFIG_ANDROID_AB_BACKUP_O=
FFSET);
> +                       if (ret < 0) {
> +                               free(backup_abc);
> +                               free(abc);
> +                               return ret;
> +                       }
>                 }
> +               free(backup_abc);
>         }
> -       free(backup_abc);
> -#endif
>
>         free(abc);
>
> --
> 2.43.2
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.
