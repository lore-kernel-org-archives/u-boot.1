Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D89C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA87C87D66;
	Thu,  7 Mar 2024 18:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h4ffRjUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B0B87D80; Thu,  7 Mar 2024 18:51:02 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A339876A4
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e73f04309so57071f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709833859; x=1710438659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2V9YfEcN6gV7PfiR2Zryuiq4Zodfvt1iIGpn0Se0VCc=;
 b=h4ffRjUj0MPQJQRsq7oSdARHSr9WJcjgXyExHKSIwmmIs8a+B7ngZnKUBA1e2QLehM
 JxByBjpRSwztdeTOqpEz3VL1i2aXyHENq7M/Zh2UbhRFQLhgJgAC6gtQV/rQ1NSS7Hgn
 YbFvsIOOg9MKEoC09+Ukc6hAsgax/P+N7AL09nClckVAFNgKYJvc6EaQMbpO2LXSf8FD
 bI8J3i3E89YZrZLUqBmT16WEXkYkuHPImb4owe/yD9bppZuomkaZe5cH4N2Iox/zAC8V
 R0FRFomxPOZYAHZRuNUQe9x6CWGaQmTB+ImFMkqGKtGWxyyfU5Vg18ZIjEbfXheqE50/
 kYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709833859; x=1710438659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2V9YfEcN6gV7PfiR2Zryuiq4Zodfvt1iIGpn0Se0VCc=;
 b=Yk0D31JQo3vtffSoxoIpuxRv/ZFpO3gJCmuzHy3ljh/3N54XP9HaI0QeCAAHwGuyGS
 JrERrF8VhSWzz4N1pwzbkr7PhXXsWIf0cjbQvM5p1CFMoTyeJ16OG02wHlizd4OZSnCZ
 UvyQl6qty2lQNyhCFqS4cKSPxymqXxzDSx7A+UwCq6iaHQdJyW56T2iyr8aof272WnbG
 5puoLhZjSeivMKhCtl5KU52PBrPWOCHLg2H7/l2mHx8m/Sv497pcnHN4YjFzHl/XuS83
 Abt7WajRsH0fXDD08Y7Y+D7JexqtRZyhms8JDmsLxlUpAhkjOBXiIO8m3iyoE05p23Zp
 rLZg==
X-Gm-Message-State: AOJu0YzjlkeHf3Y0q1IMNS2uRshlDBJxdKGE3Wv8pBxuq7/iRUxVn1+b
 ktEKBqe2X6Bhw87EacAGWy+jATJpVTkJJC9+y7ZM2dfPdIxbLLXcX01CBwwEboGqRluXr4VNq01
 tZ+vWa0uZiEJA1x0PVE5YAWfzi6A=
X-Google-Smtp-Source: AGHT+IF18qT1UPTevOdzGw4yrqtMmYDrNHvdSJgwRRWKKp+hGYrSgvzcEPDmt7N+/KzysAPbFgzaV3hfXd4NlJM5Zgw=
X-Received: by 2002:a05:6000:1050:b0:33d:9d49:754d with SMTP id
 c16-20020a056000105000b0033d9d49754dmr1862223wrx.4.1709833858692; Thu, 07 Mar
 2024 09:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240307161711.3177729-3-colin.mcallister@garmin.com>
In-Reply-To: <20240307161711.3177729-3-colin.mcallister@garmin.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 7 Mar 2024 18:50:47 +0100
Message-ID: <CAByghJYFi0Af5YcqZ2iKyMpU6Jmdn1gScaK=GT0Zfw3-89Y+ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

Hello Colin,

+CC Mattijs, Sam

On Thu, Mar 7, 2024 at 5:19=E2=80=AFPM Colin McAllister <colin.mcallister@g=
armin.com>
wrote:

> Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
> not actually enable the #if protected code in android_ab.c. This is
> because "CONFIG_" should have been prepended to the config macro, or the
> macros defined in kconfig.h could have been used.
>
> Each use of AB_BACKUP_OFFSET is now wrapped within CONFIG_VAL().
>
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  boot/android_ab.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 9a3d15ec60..a80040749d 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -191,7 +191,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>         int slot, i, ret;
>         bool store_needed =3D false;
>         char slot_suffix[4];
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>         struct bootloader_control *backup_abc =3D NULL;
>  #endif
>
> @@ -205,9 +205,9 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>                 return ret;
>         }
>
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>         ret =3D ab_control_create_from_disk(dev_desc, part_info, &backup_=
abc,
> -                                         ANDROID_AB_BACKUP_OFFSET);
> +
>  CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET));
>         if (ret < 0) {
>                 free(abc);
>                 return ret;
> @@ -218,7 +218,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>         if (abc->crc32_le !=3D crc32_le) {
>                 log_err("ANDROID: Invalid CRC-32 (expected %.8x, found
> %.8x),",
>                         crc32_le, abc->crc32_le);
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>                 crc32_le =3D ab_control_compute_crc(backup_abc);
>                 if (backup_abc->crc32_le !=3D crc32_le) {
>                         log_err("ANDROID: Invalid backup CRC-32 ");
> @@ -230,13 +230,13 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t
> disk_partition *part_info,
>
>                         ret =3D ab_control_default(abc);
>                         if (ret < 0) {
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>                                 free(backup_abc);
>  #endif
>                                 free(abc);
>                                 return -ENODATA;
>                         }
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>                 } else {
>                         /*
>                          * Backup is valid. Copy it to the primary
> @@ -249,7 +249,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>
>         if (abc->magic !=3D BOOT_CTRL_MAGIC) {
>                 log_err("ANDROID: Unknown A/B metadata: %.8x\n",
> abc->magic);
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>                 free(backup_abc);
>  #endif
>                 free(abc);
> @@ -259,7 +259,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>         if (abc->version > BOOT_CTRL_VERSION) {
>                 log_err("ANDROID: Unsupported A/B metadata version:
> %.8x\n",
>                         abc->version);
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>                 free(backup_abc);
>  #endif
>                 free(abc);
> @@ -338,7 +338,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct
> disk_partition *part_info,
>                 abc->crc32_le =3D ab_control_compute_crc(abc);
>                 ret =3D ab_control_store(dev_desc, part_info, abc, 0);
>                 if (ret < 0) {
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>                         free(backup_abc);
>  #endif
>                         free(abc);
> @@ -346,14 +346,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struc=
t
> disk_partition *part_info,
>                 }
>         }
>
> -#if ANDROID_AB_BACKUP_OFFSET
> +#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
>         /*
>          * If the backup doesn't match the primary, write the primary
>          * to the backup offset
>          */
>         if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
>                 ret =3D ab_control_store(dev_desc, part_info, abc,
> -                                      ANDROID_AB_BACKUP_OFFSET);
> +
> CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET));
>                 if (ret < 0) {
>                         free(backup_abc);
>                         free(abc);
>

Thanks for the patch. The only suggestion: I see no reason in wrapping it i=
n
preprocessor conditionals (in this particular case), better to use C
conditionals instead (with CONFIG_VAL macro) as explained in [1].

-
> 2.43.2
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole
> use of the intended recipient(s) and contain information that may be Garm=
in
> confidential and/or Garmin legally privileged. If you have received this
> email in error, please notify the sender by reply email and delete the
> message. Any disclosure, copying, distribution or use of this communicati=
on
> (including attachments) by someone other than the intended recipient is
> prohibited. Thank you.
>

[1]
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditiona=
l-compilation
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
