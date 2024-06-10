Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC1EC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6DCC885EB;
	Mon, 10 Jun 2024 18:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2aJ2jml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5FF5885EE; Mon, 10 Jun 2024 18:03:38 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74393885E1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3579ef2d436so230859f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718035416; x=1718640216; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XOK8OoOsWmRLSZrYKMkd9v6zlWb8CGhINR0m26gmXw=;
 b=D2aJ2jmlP+h0qYTdCL8xcASzZRCAuZ5xFJUykc8lvwmHP2g3xSypk5wlMxG/pnZSf0
 UtjFSXSPe8brNFm3d0mzB+1gw7iJzDdMSEcx63HnpPILMBOq8wz9HoR1VyBt7ACn60YN
 qwYjyExy2MZJVXgOyxgk3HRUdPjG5xfslhxvqVdIgDJ8kXWrcRzgII5sXTml0uZNLf5G
 0ne7XGy667+9knbfIR46P/AafW8eyXVSlxhgQ5R4zR1QY9et2U0tl8a+FoSh+SZ9ybBA
 MytzQGDuVdcbk6bvFkRv0znkymkVIMQxprNOwNTMtLm1SGJw/OMxZMHAFdPRo2xF7JcU
 NBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718035416; x=1718640216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XOK8OoOsWmRLSZrYKMkd9v6zlWb8CGhINR0m26gmXw=;
 b=vEbUpy3xGh9ebb+nkkfV0ZQQL8JXpYePcDsXaj+bUDwVQMDgE3abf0vZ6/Kf0yi/2a
 Wzuf2DnqzZXGClcK++kh7w8C8eiqMAwp3/kCOpNwZEde8vptkZNP8P016TIGF19hqo4a
 K9E3FOPU25Dxkh1oV6N/rvge/tBxyWtX/N4pQ+ZUa7XZTa/NmK/eekQUMQiqCJAIL97F
 WWox0V+r4gBu6N0HRhOaKk06IxlJvqcNlhBMVfKSpfLP9E0l3FC+KYZiipqM1NcY7haa
 7FIP7vBP/jN64kUA3G6YbJND5bqbRsSrZYCRbTGwU3ssRb79H1MAydiVARjq6AF1/omo
 Hmkw==
X-Gm-Message-State: AOJu0Yx4euzMe1MWC9JXjHUDBk0DmK471SWbxnlnpOOdWvuy5mffEz1j
 9HuZuyjAXA5EDSw4Q2NsLeM2ev6uDLcm7VEpcKxBlglcXP/0ILr7S3KG0UPtxIrjnoq7Vi0IPEf
 VS/mdhJIaBKczyUsHUyQrtdsENNA=
X-Google-Smtp-Source: AGHT+IGrf8SMo/Cn9bvZs22CZb+IYX38pPr7ytEjkUTgUCJ+lw7aAAYDOkDD+VHCzjrgp1NqltYXALgErf4fS7xezdU=
X-Received: by 2002:a5d:5887:0:b0:35f:247e:fbb6 with SMTP id
 ffacd0b85a97d-35f247efe9cmr1999990f8f.2.1718035415683; Mon, 10 Jun 2024
 09:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240519130951.2558467-1-r.stratiienko@gmail.com>
In-Reply-To: <20240519130951.2558467-1-r.stratiienko@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 18:03:24 +0200
Message-ID: <CAByghJYetoFk-6xqM14Qpz-xJZ-1BGhme1caRNLOtKbnF07Qxg@mail.gmail.com>
Subject: Re: [PATCH] android: Fix ramdisk loading for bootimage v3+
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, souajih@baylibre.com
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

Hi Roman,

On Sun, May 19, 2024 at 3:09=E2=80=AFPM Roman Stratiienko
<r.stratiienko@gmail.com> wrote:
>
> The boot_ramdisk and vendor_ramdisk must be both concatenated together.
> Without this change, Android root is missing some of the necessary tools
> to complete virtual AB OTA.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  boot/image-android.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 04f2a8015e..499eae9bcd 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -64,7 +64,6 @@ static void android_boot_image_v3_v4_parse_hdr(const st=
ruct andr_boot_img_hdr_v3
>
>         data->kcmdline =3D hdr->cmdline;
>         data->header_version =3D hdr->header_version;
> -       data->ramdisk_ptr =3D env_get_ulong("ramdisk_addr_r", 16, 0);
>
>         /*
>          * The header takes a full page, the remaining components are ali=
gned
> @@ -75,6 +74,7 @@ static void android_boot_image_v3_v4_parse_hdr(const st=
ruct andr_boot_img_hdr_v3
>         data->kernel_ptr =3D end;
>         data->kernel_size =3D hdr->kernel_size;
>         end +=3D ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_SIZE);
> +       data->ramdisk_ptr =3D end;
>         data->ramdisk_size =3D hdr->ramdisk_size;
>         data->boot_ramdisk_size =3D hdr->ramdisk_size;
>         end +=3D ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_SIZE);
> @@ -462,25 +462,24 @@ int android_image_get_ramdisk(const void *hdr, cons=
t void *vendor_boot_img,
>                 return -1;
>         }
>         if (img_data.header_version > 2) {
> -               ramdisk_ptr =3D img_data.ramdisk_ptr;
> +               ramdisk_ptr =3D img_data.ramdisk_addr;
>                 memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ram=
disk_ptr,
>                        img_data.vendor_ramdisk_size);
> -               memcpy((void *)(ramdisk_ptr + img_data.vendor_ramdisk_siz=
e),
> -                      (void *)img_data.ramdisk_ptr,
> +               ramdisk_ptr +=3D img_data.vendor_ramdisk_size;
> +               memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_pt=
r,
>                        img_data.boot_ramdisk_size);
> +               ramdisk_ptr +=3D img_data.boot_ramdisk_size;
>                 if (img_data.bootconfig_size) {
>                         memcpy((void *)
> -                              (ramdisk_ptr + img_data.vendor_ramdisk_siz=
e +
> -                              img_data.boot_ramdisk_size),
> -                              (void *)img_data.bootconfig_addr,
> +                              (ramdisk_ptr), (void *)img_data.bootconfig=
_addr,
>                                img_data.bootconfig_size);
>                 }
>         }
>
>         printf("RAM disk load addr 0x%08lx size %u KiB\n",
> -              img_data.ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, =
1024));
> +              img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size,=
 1024));
>
> -       *rd_data =3D img_data.ramdisk_ptr;
> +       *rd_data =3D img_data.ramdisk_addr;
>
>         *rd_len =3D img_data.ramdisk_size;
>         return 0;
> --
> 2.40.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
