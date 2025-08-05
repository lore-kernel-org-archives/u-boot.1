Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A752C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC33833D7;
	Tue,  5 Aug 2025 09:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nrQkcJtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3878380F; Tue,  5 Aug 2025 09:48:27 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E37833D1
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71b6703ba32so42709337b3.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754380103; x=1754984903; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V3tWpm5bBseSrlPIouj0MFBqZ4Kx0n+/xzzaCHG6lhk=;
 b=nrQkcJtU3h4/HAW4a01QVeLzLIXDjXK6LzFJMSCQYpndJSA7KwaKcZjHtOLPxx5KR8
 JDONzAY2G47IrIHEb0/kcJ+rLLNOt9dGA/HzqfOqFY+U3y6lyfOLIzAqZF5wXraFc6Ql
 Sl6I7iDVGihyF3Fu/BmJ4NmTk5OJKwu7TzQYoXEGJnLeKgt+n3xSBHri5kAhlhK/g8CA
 KqS11oit/99gb2hMU/7R51UCjSP3cYpedo620SM2RTe5u/6ACHmvfnjhwn9V17Z+KLpz
 tspiDyf+GieSZvsxT/mk0pk3L7kwjSDc0dDcohMVJBoK/+mzwn5Jyi+rQt4BQRK0WtLj
 1nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754380103; x=1754984903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3tWpm5bBseSrlPIouj0MFBqZ4Kx0n+/xzzaCHG6lhk=;
 b=BTXGJ4tyeXsTge4xjQgmmjzOC5FCe9PidqwsgWHYzN3+YoJrx+fhtvdZ77ChQ/iKSN
 L0/GPxKTpZGpq8w6CZ4M1f3qcxYe1eloK7RsqpeVCDSBTyah5oefe4oP/NB/a8OgND3Q
 WbfCO84oZ/POM/W/lkSCUg9B73TshrlRQaI4lTaeYVcghmVxwSNEXlsWWM7K1BL503KY
 SbAzDMz6G9slhgm6+mvVf1cilyYCWV5Fg2Ov6z909CGB2R7DbhGjxsPmmptjViSSfFqw
 FVsZxrsqd58N5HE0ZUmtzNZm923rLXkSYQn24XUOfuiiE4FO9e/bE7q4RsYeSADOvkNm
 yN8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcHeOSKJmOmEjU5Cqx1fl325zt680emMscb0Xy5Cdcx7ysIIvxp6cONDaOtA3C214PF4/N2JI=@lists.denx.de
X-Gm-Message-State: AOJu0YzV8cROKg5SCwRyJQoP6UEorXRx9ldqf6luUGRG4p34gU0xU43H
 bJIGPhNtCSTj0GEAlBtbVwg8/BVPnr4DcTLJGyL/N9fYTUZaMTLg3lqZVLaMvmrjeB21xtci8XC
 QR5rhCQWm6nVbNkyzYk4YAZM65i3phovkPyccxlnT7w==
X-Gm-Gg: ASbGncvvKptNzjOzY6An0MFRPaX+hK0FXwhP91Y7md9yxhu+IX5ebQaLwOLvAeYRosI
 DK2tvP9xRd8xLCajbITFzLlNGLyOqQAnA4vpeoPNlTNyG9aaBmiS12zmwteHoaU4kFWfk727wpD
 rSBcw8aamZWtwkU50Eruq2WfgwXf8RcP76c/EFyv9rmEGv4Te6FHadK0Qh/Tc7uqZ/y1QifPW1a
 rKlarIuOPQvk6MJHF8=
X-Google-Smtp-Source: AGHT+IG1kTwN2sFaReoFM4f8fortq4p+iDCAyxCVTxNNVV5QfOtKX3Tq7a+MWngHR4lM89ZDHS/URoF84g1PfCzLSxI=
X-Received: by 2002:a05:690c:6d82:b0:71a:4517:75a6 with SMTP id
 00721157ae682-71b7f593a1emr161820367b3.24.1754380103280; Tue, 05 Aug 2025
 00:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Aug 2025 10:47:47 +0300
X-Gm-Features: Ac12FXwcF9IplD_0NTvmJM4r4gphsev0YSqdVMYWvVYj9KYO4f3TW1AkCvOFL5Q
Message-ID: <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com, 
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com, 
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Balaji

On Thu, 24 Jul 2025 at 12:00, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> - Refactor find_handle() to improve device path comparison logic.
> - Original logic only compared paths when len_current <= len.
> - This fails when searching for ESP inside a larger boot device.
> - ESP partition path is longer than boot device path by design.
> - New logic allows matching when dp is a prefix of dp_current.
> - Without this change, it was not able to find ESP and capsule
>   update fails to start.
>
> - Also update efi_fs_from_path() to use system partition GUID.
> - Above ensures ESP's EFI handle is returned which contains
>   file system protocol.
> - Without this change, it was returning a wrong EFI handle
>   that was not ESP handle.

I am not sure this is a bug. The EFI spec says that in order to
trigger a capsule update you need to have an active boot option
pointing to the same ESP the capsule is installed.
Is your boot0000 automatically generated? If so it doesnt point to the
ESP and the capsule update doesn't trigger correctly. Does it work if
you manually add a boot option pointing to the ESP?

Thanks
/Ilias
>
> - These changes improves reliability for capsule updates.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  lib/efi_loader/efi_device_path.c | 62 ++++++++++++++++++++++----------
>  lib/efi_loader/efi_disk.c        |  2 +-
>  2 files changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index b3fb20b2501..3716165e963 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -107,54 +107,80 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>   * @rem:       pointer to receive remaining device path
>   * Return:     matching handle
>   */
> +
>  static efi_handle_t find_handle(struct efi_device_path *dp,
>                                 const efi_guid_t *guid, bool short_path,
>                                 struct efi_device_path **rem)
>  {
>         efi_handle_t handle, best_handle = NULL;
> -       efi_uintn_t len, best_len = 0;
> +       efi_uintn_t len, len_current, best_len = 0;
> +       efi_status_t ret;
> +       struct efi_device_path *dp_current;
> +       struct efi_handler *handler;
>
>         len = efi_dp_instance_size(dp);
>
>         list_for_each_entry(handle, &efi_obj_list, link) {
> -               struct efi_handler *handler;
> -               struct efi_device_path *dp_current;
> -               efi_uintn_t len_current;
> -               efi_status_t ret;
> -
>                 if (guid) {
>                         ret = efi_search_protocol(handle, guid, &handler);
>                         if (ret != EFI_SUCCESS)
>                                 continue;
>                 }
> -               ret = efi_search_protocol(handle, &efi_guid_device_path,
> -                                         &handler);
> +
> +               ret = efi_search_protocol(handle, &efi_guid_device_path, &handler);
>                 if (ret != EFI_SUCCESS)
>                         continue;
> +
>                 dp_current = handler->protocol_interface;
>                 if (short_path) {
>                         dp_current = efi_dp_shorten(dp_current);
>                         if (!dp_current)
>                                 continue;
>                 }
> +
>                 len_current = efi_dp_instance_size(dp_current);
> +
>                 if (rem) {
> -                       if (len_current > len)
> +                       /* If current path is shorter than or equal to input path */
> +                       if (len_current <= len) {
> +                               if (memcmp(dp_current, dp, len_current))
> +                                       continue;
> +                               if (!rem)
> +                                       return handle;
> +                               if (len_current > best_len) {
> +                                       best_len = len_current;
> +                                       best_handle = handle;
> +                                       *rem = (void *)((u8 *)dp + len_current);
> +                               }
> +                       }
> +                       /* If current path is greater than input path */
> +                       else if (len_current > len) {
> +                               if (memcmp(dp, dp_current, len))
> +                                       continue;
> +                               if (len > best_len) {
> +                                       best_len = len;
> +                                       best_handle = handle;
> +                                       *rem = (struct efi_device_path *)((u8 *)dp_current + len);
> +                               }
> +                       } else {
>                                 continue;
> +                       }
>                 } else {
> -                       if (len_current != len)
> +                       if (len_current == len) {
> +                               if (memcmp(dp_current, dp, len_current))
> +                                       continue;
> +                       }
> +                       /* If current path is greater than input path */
> +                       else if (len_current > len) {
> +                               if (memcmp(dp, dp_current, len))
> +                                       continue;
> +                       } else {
>                                 continue;
> -               }
> -               if (memcmp(dp_current, dp, len_current))
> -                       continue;
> -               if (!rem)
> +                       }
>                         return handle;
> -               if (len_current > best_len) {
> -                       best_len = len_current;
> -                       best_handle = handle;
> -                       *rem = (void*)((u8 *)dp + len_current);
>                 }
>         }
> +
>         return best_handle;
>  }
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606..49f8b5935f4 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
>         efi_free_pool(file_path);
>
>         /* Get the EFI object for the partition */
> -       efiobj = efi_dp_find_obj(device_path, NULL, NULL);
> +       efiobj = efi_dp_find_obj(device_path, &efi_system_partition_guid, NULL);
>         efi_free_pool(device_path);
>         if (!efiobj)
>                 return NULL;
> --
> 2.34.1
>
