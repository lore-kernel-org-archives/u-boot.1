Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AEFC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF198826E;
	Mon, 10 Jun 2024 18:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XB3StSxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E9D8860A; Mon, 10 Jun 2024 18:09:09 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7CB8812B
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3579ef2d436so231186f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718035745; x=1718640545; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYot05XeZ8weVx8pqeAtre1xFODqkBm1n6YOn7i1AIk=;
 b=XB3StSxUmuaX5XVe0b7wnsNvQeaDRwTnyJvyp8BgdKbDYbqBgi420anfyT3yPVEvoQ
 FRdnuuYLXpF6L8luZfOcdbX38wZnbro0KwYCrqRJF2PbeVfCOcsKcHzKpVPujb//xRNG
 Txjx5pSqrDEw4+DpeefL5j1y+WaCtu1RPpy0R6Sq161Cg4eqFKvHEMQMiADAEHd62Jgi
 RQAknGQgtkcdDtgBlfvCVsV++UjEZsbUhda4R19IxMP28bHvCyaczd3otYUW0Sa6dc6i
 wjGogjOhu1v9jth7jzcPAVqCnP/tmiiig9E4UxWq04D+KyBSPp38AusiW+7ab25zINMa
 nxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718035745; x=1718640545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYot05XeZ8weVx8pqeAtre1xFODqkBm1n6YOn7i1AIk=;
 b=juHiCmii0z11ZYQEVknto3AOUfW0kUn3qSwPuTlPs73jlGcb1/W+la1oVDbmeVB90e
 aYG9UnlBNsNz4Qxv0tN0b79LOUfVjW8mCzJlkAINbtYlSF2dwyC9/VWt2SMxyfZVP7+0
 Zzh8kjYluwBEUVj2XaRYrE8PF4pi1Oao9y1ICIiNoxPl4GdyUBSPENDWRFIXIURq8CZL
 vnxIRxwbsH/qlo6ftb3uYBv3fboPjypmPaqxTcOYmxq7N0bLnyzEzAbyMp00hk9iMKGo
 4SijV92YPsm999ZYxe2en68bwKiBXyjomO3ntP+BKIK6EvrFJCaQRgMmnQSFi+wdnOUw
 vr0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZVaUFiRDaysQYg2rpQlyAdlcf/a58x2ELx9Hr26YTA/4hV/Nxq8nsHfAYx6LeIEx8STc+WSC8gF5c0k74ZdYmclKLSA==
X-Gm-Message-State: AOJu0YyZzdU46Pb/68+0VZF+zzZgcdirwYi3rGjMV3XR6zwhN3T6qV1N
 LO9z7GZfjXCedKSkG9trPZwK/BRP+FE86v8fLgOtZ4LA8rQjATpKZC5JMTtldjxD2Bd794Dp6Jh
 n8qs2qZl9EclV5fMB1Om1btvTUeA=
X-Google-Smtp-Source: AGHT+IFJOPDdJZfps3c50TKEbIlqQyb3JMSweOCtcYy72HRiN6mP4pol6aIm8Et1ubY0q1/so2dZD/3xzLWlVCG2ffA=
X-Received: by 2002:a05:6000:2a1:b0:35f:2287:7b97 with SMTP id
 ffacd0b85a97d-35f22877d54mr2718904f8f.4.1718035744987; Mon, 10 Jun 2024
 09:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
 <20240519191856.2582174-4-r.stratiienko@gmail.com>
In-Reply-To: <20240519191856.2582174-4-r.stratiienko@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 18:08:54 +0200
Message-ID: <CAByghJZUmUsVmG_Yb1UVks_puBW=VQ4mjGcFMWBKJmV2p-Vx0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] abootimg: Implement smart image load feature
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: mkorpershoek@baylibre.com, dsimic@manjaro.org, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, eajames@linux.ibm.com, 
 marek.vasut+renesas@mailbox.org, paulerwan.rio@gmail.com, 
 u-boot@lists.denx.de
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

On Sun, May 19, 2024 at 9:19=E2=80=AFPM Roman Stratiienko
<r.stratiienko@gmail.com> wrote:
>
> Load only part of the boot partition that contains valuable
> information, thus improving the boot time.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  boot/image-android.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/abootimg.c       | 40 ++++++++++++++++++++++---
>  include/image.h      | 12 ++++++++
>  3 files changed, 118 insertions(+), 4 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index da8003f370..d00a896a40 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -204,6 +204,76 @@ bool android_image_get_data(const void *boot_hdr, co=
nst void *vendor_boot_hdr,
>         return true;
>  }
>
> +/**
> + * android_image_get_valuable_size() - get the size of the android image
> + *
> + * This function checks if the image is Android boot image and returns t=
he
> + * valuable size of the image.
> + *
> + * @hdr_addr: Boot image header address (boot or vendor_boot)
> + *
> + * @return size of the image on success, 0 on failure
> + */
> +size_t android_image_get_valuable_size(const void *hdr_addr)
> +{
> +       int version, size;
> +
> +       if (is_android_boot_image_header(hdr_addr)) {
> +               const struct andr_boot_img_hdr_v0 *hdr =3D hdr_addr;
> +
> +               version =3D ((struct andr_boot_img_hdr_v0 *)hdr_addr)->he=
ader_version;
> +               if (version > 2) {
> +                       const struct andr_boot_img_hdr_v3 *hdr =3D hdr_ad=
dr;
> +
> +                       size =3D ALIGN(hdr->header_size, ANDR_GKI_PAGE_SI=
ZE);
> +                       size +=3D ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_S=
IZE);
> +                       size +=3D ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_=
SIZE);
> +
> +                       if (version > 3)
> +                               size +=3D ALIGN(hdr->signature_size, ANDR=
_GKI_PAGE_SIZE);
> +
> +                       return size;
> +               }
> +
> +               size =3D hdr->page_size;
> +               size +=3D ALIGN(hdr->kernel_size, hdr->page_size);
> +               size +=3D ALIGN(hdr->ramdisk_size, hdr->page_size);
> +               size +=3D ALIGN(hdr->second_size, hdr->page_size);
> +
> +               if (version > 0)
> +                       size +=3D ALIGN(hdr->recovery_dtbo_size, hdr->pag=
e_size);
> +
> +               if (version > 1)
> +                       size +=3D ALIGN(hdr->dtb_size, hdr->page_size);
> +
> +               return size;
> +       }
> +
> +       if (is_android_vendor_boot_image_header(hdr_addr)) {
> +               const struct andr_vnd_boot_img_hdr *hdr =3D hdr_addr;
> +
> +               version =3D ((struct andr_vnd_boot_img_hdr *)hdr_addr)->h=
eader_version;
> +               if (version < 3) {
> +                       printf("Vendor boot image header version %d is no=
t supported\n", version);
> +
> +                       return 0;
> +               }
> +
> +               size =3D ALIGN(hdr->header_size, hdr->page_size);
> +               size +=3D ALIGN(hdr->vendor_ramdisk_size, hdr->page_size)=
;
> +               size +=3D ALIGN(hdr->dtb_size, hdr->page_size);
> +
> +               if (version > 3) {
> +                       size +=3D ALIGN(hdr->vendor_ramdisk_table_size, h=
dr->page_size);
> +                       size +=3D ALIGN(hdr->bootconfig_size, hdr->page_s=
ize);
> +               }
> +
> +               return size;
> +       }
> +
> +       return 0;
Can we split this function on two, for example:
android_boot_image_get_valuable_size()
android_vendor_image_get_valuable_size(),

Then check image type in abootimg_smart_load() and call proper function
accordingly?
> +}
> +
>  static ulong android_image_get_kernel_addr(struct andr_image_data *img_d=
ata)
>  {
>         /*
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index 808c9c4941..fe7c5c5e2c 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -182,6 +182,35 @@ static int abootimg_get_dtb(int argc, char *const ar=
gv[])
>         return CMD_RET_USAGE;
>  }
>
> +static int abootimg_smart_load(struct blk_desc *desc, struct disk_partit=
ion *info, void *addr)
> +{
> +       int ret, size;
> +
> +       ret =3D blk_dread(desc, info->start, 4096 / info->blksz, addr);
> +       if (ret < 0) {
> +               printf("Error: Failed to read partition\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       size =3D android_image_get_valuable_size(addr);
> +       if (size =3D=3D 0)
> +               return 0;
> +
> +       ret =3D blk_dread(desc, info->start, DIV_ROUND_UP(size, info->blk=
sz), addr);
> +       if (ret < 0) {
> +               printf("Error: Failed to read partition\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       memset(addr + size, 0, info->size * info->blksz - size);
> +
> +       printf("Loaded Android boot image using smart load (%d/%d MB)\n",
> +              (int)DIV_ROUND_UP(size, 1024 * 1024),
> +              (int)DIV_ROUND_UP(info->size * info->blksz, 1024 * 1024));
> +
> +       return size;
> +}
> +
>  static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
>                             char *const argv[])
>  {
> @@ -299,10 +328,13 @@ static int do_abootimg_load(struct cmd_tbl *cmdtp, =
int flag, int argc,
>                 return CMD_RET_FAILURE;
>         }
>
> -       ret =3D blk_dread(desc, info.start, info.size, addr);
> -       if (ret < 0) {
> -               printf("Error: Failed to read partition %s\n", buf);
> -               goto fail;
> +       ret =3D abootimg_smart_load(desc, &info, addr);
> +       if (ret <=3D 0) {
> +               ret =3D blk_dread(desc, info.start, info.size, addr);
> +               if (ret < 0) {
> +                       printf("Error: Failed to read partition %s\n", bu=
f);
> +                       goto fail;
> +               }
>         }
>
>         sprintf(buf, "abootimg_%s_ptr", argv[3]);
> diff --git a/include/image.h b/include/image.h
> index c5b288f62b..7d8ff40c3f 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1826,6 +1826,18 @@ struct andr_image_data;
>  bool android_image_get_data(const void *boot_hdr, const void *vendor_boo=
t_hdr,
>                             struct andr_image_data *data);
>
> +/**
> + * android_image_get_valuable_size() - get the size of the android image
> + *
> + * This function checks if the image is Android boot image and returns t=
he
> + * valuable size of the image.
> + *
> + * @hdr_addr: Boot image header address (boot or vendor_boot)
> + *
> + * @return size of the image on success, 0 on failure
> + */
> +size_t android_image_get_valuable_size(const void *hdr_addr);
> +
>  struct andr_boot_img_hdr_v0;
>
>  /**
> --
> 2.40.1
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
