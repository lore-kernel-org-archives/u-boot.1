Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5771C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E580182AD2;
	Thu,  8 May 2025 14:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AlUtg4aT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E718211F; Thu,  8 May 2025 06:23:12 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3CF82935
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 06:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3106217268dso4620761fa.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 21:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746678188; x=1747282988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sczE/dJka+edeRjI+4bNv/UYSpdUhCRf37/3+yZCMwI=;
 b=AlUtg4aTgShpBto3uxAyC8dJWqAA7RIjQCHwZcVMAXiBAJ/A4n3qK4WwZU82ztjG3x
 U1HK3YQ+q/r10VrzsbfukIy+BzHehd6RYemlL6KFwpYUcqdAbvIp83E9gMU42kgOjhqA
 7zvurvgthtBi8gZ8FG/Nqyd0vjy2EEeIcNHtvjrEgJFI/C9lPAmoozpOsyN+U6WY/0Zx
 rNXUOlx117X1nMYYFVu2VbG2sUGzzXU18Q6inO+95LSMCrHPThELZZVBoBzfQSoiaW+7
 NpbttZVjL84dq9v05w0v+kvqF9Cu6tvq7d1BJlegw00yMUVIqIZx0TzA1hP6wT3xNsR4
 4S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746678188; x=1747282988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sczE/dJka+edeRjI+4bNv/UYSpdUhCRf37/3+yZCMwI=;
 b=X3iL4ihAo5wh4NryaBG2Bjx/rC6G77RjEX9g1FdjTTyL3/58oVDsY9leVVE+l4HDdv
 ty7zPhVRBRlpZ/cJmH1BQL21Ir5++d0fqYQcWjhA6qzlPx4dsAoB1p4yZ4uOwMJ7Lgp3
 4Z/40rw92PPfR14v1ci0csAR1V7RuK7acFKUqjj2ob/Axw5SYRnl5Ym9tQC9bYQBAXI/
 uGs7DMpvQge4/HcPg9DTBY9dc08HRX+Pfd+wyZgL35DoILCLZiWm0HZ8JfqYNhusxBrE
 fu08PrEskjepA05V5xu96trf1SyVtHcan8R5TnYOv9gnw2lCC+Ok0zB3DyqzzP768C6p
 olmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaKemZxwu0hEhmritY5mVA80I7kpZY79M6PN0P3XEHAQkW6JiWyQdjpByb7eVf3eWzIzKgL88=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5pO15siW/OFrJKuq+v4LKJT+vVRKesOCDJLgTYCbVacvFKAb8
 jO0dfVLHlKraJfMx2z5FKhQE0RsDHOubnrSvpPI2s2x8UrIHi7zjpWTSEin+HWI0jS/4WRkZ6dP
 orw4W+T6s29ehqiUHN5xPTojenXE=
X-Gm-Gg: ASbGncsNk9yz8+IxRks6+CWoMIkfm9JJdP7H8+4Pd7V2t1a1Mil36op93WiIvES/xbG
 T5HyvZZIn1Oo0U6Nbusi3XOBXMNcJugx4o7/Q2hdjruA1rbQWmbRvlwuPfrza3LYYwA+T3lxcvz
 n/bVOcn66liXULdpBiWOYHSg==
X-Google-Smtp-Source: AGHT+IGtmPOCw9Zzx9CfJ5GfzdL+ICYOY3o+9xXxgLur5oMy2Sql8tnsl7nytYj+2NvwtHzip0BhTsyhvT8e+2MZ3DQ=
X-Received: by 2002:a2e:bc21:0:b0:30d:62a6:4431 with SMTP id
 38308e7fff4ca-326b880432fmr5703931fa.9.1746678187683; Wed, 07 May 2025
 21:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
 <20250505-android-boot-v2-1-92dcb5bf59c8@gmail.com>
 <87zffoamlv.fsf@kernel.org>
In-Reply-To: <87zffoamlv.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Thu, 8 May 2025 12:22:54 +0800
X-Gm-Features: ATxdqUEYnjUSFcbapI9Uok7yQCLAVHhsU5ywK8piUbDOgiE7yIQIadc3B8_wME4
Message-ID: <CADgMGSuhEK6xdrhnGEDnx-dtoNSneMABEr3-26a4u0s4eXgvYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] boot/image-android: Workaround kernel/ramdisk
 invalid addr
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailman-Approved-At: Thu, 08 May 2025 14:50:08 +0200
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

Hi Mattijs,

Thx for feedback.

=E5=9C=A8 2025=E5=B9=B45=E6=9C=887=E6=97=A5=E9=80=B1=E4=B8=89 15:47=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi George,
>
> Thank you for the patch.
> I really prefer this solution to the one proposed in v1.
>
> I have tested this on Khadas VIM3 board (using
> khadas-vim3_android_defconfig)
>
> I have a couple of small remarks below.
>
> On lun., mai 05, 2025 at 17:17, George Chan via B4 Relay <
> devnull+gchan9527.gmail.com@kernel.org> wrote:
>
> > From: George Chan <gchan9527@gmail.com>
> >
> > Some androidboot image have invalid kernel/ramdisk load addr,
> > force to ignore those value and use loadaddr instead.
>
> Can we please elaborate a bit more in the commit message?
> We have not explained/justified why repacking a boot image with proper
> kernel ramdisk/load addr is not possible.
>
> Is the following an acceptable justification for you?
> """
> Since it's not always possible to change the load addr by repacking
> the boot.img (due to AVB signature mismatch/<or_another_justification>),
> we need a way to use kernel_addr_r and ramdisk_addr_r.
> """
>
> Feel free to reformulate the above.
>

Thx. let me sum up as below 2 reasons.

1. there is a concern on exposing the whole memory to image loading is
dangerous

2. Since it's not always possible to change the load addr by repacking
the boot.img (mainly due to AVB signature mismatch),
we need a way to use kernel_addr_r and ramdisk_addr_r.


> >
> > Suggested-by: Casey Connolly <casey.connolly@linaro.org>
> > Signed-off-by: George Chan <gchan9527@gmail.com>
> > ---
> >  boot/Kconfig         | 6 ++++++
> >  boot/image-android.c | 9 ++++++---
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index fb37d912bc9..4bdac384181 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -11,6 +11,12 @@ config ANDROID_BOOT_IMAGE
> >         This enables support for booting images which use the Android
> >         image format header.
> >
> > +config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> > +     bool "Android Boot Image ignore addr"
> > +     default n
> > +     help
> > +       This ignore kernel/ramdisk load addr specified in androidboot
> header.
>
> Please add a bit more context here, checkpatch.pl reports issues:
> $ ./scripts/checkpatch.pl --u-boot --git master..HEAD
>
> WARNING: please write a paragraph that describes the config symbol fully
> #27: FILE: boot/Kconfig:14:
> +config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>

same as above.

>
> > +
> >  config TIMESTAMP
> >       bool "Show image date and time when displaying image information"
> >       default y if CMD_DATE
> > diff --git a/boot/image-android.c b/boot/image-android.c
> > index 1746b018900..7b8eb6a4f64 100644
> > --- a/boot/image-android.c
> > +++ b/boot/image-android.c
> > @@ -268,7 +268,8 @@ static ulong android_image_get_kernel_addr(struct
> andr_image_data *img_data,
> >        *
> >        * Otherwise, we will return the actual value set by the user.
> >        */
> > -     if (img_data->kernel_addr  =3D=3D ANDROID_IMAGE_DEFAULT_KERNEL_AD=
DR) {
> > +     if (img_data->kernel_addr  =3D=3D ANDROID_IMAGE_DEFAULT_KERNEL_AD=
DR ||
> > +             IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
>
> Please fix indentation, should be:
>
> +       if (img_data->kernel_addr  =3D=3D ANDROID_IMAGE_DEFAULT_KERNEL_AD=
DR ||
> +           IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
>
> (checkpatch.pl reports this)
>

ack.


> >               if (comp =3D=3D IH_COMP_NONE)
> >                       return img_data->kernel_ptr;
> >               return env_get_ulong("kernel_addr_r", 16, 0);
> > @@ -464,7 +465,8 @@ int android_image_get_ramdisk(const void *hdr, cons=
t
> void *vendor_boot_img,
> >        */
> >       if (img_data.header_version > 2) {
> >               /* Ramdisk can't be used in-place, copy it to
> ramdisk_addr_r */
> > -             if (img_data.ramdisk_addr =3D=3D
> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> > +             if (img_data.ramdisk_addr =3D=3D
> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
> > +
>  (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {
>
> Same here. Also, can we please drop the leading parenthesis (IS_ENABLED(
> -> IS_ENABLED( to be consistent with the previous code change?
>

ack.


> >                       ramdisk_ptr =3D env_get_ulong("ramdisk_addr_r", 1=
6,
> 0);
> >                       if (!ramdisk_ptr) {
> >                               printf("Invalid ramdisk_addr_r to copy
> ramdisk into\n");
> > @@ -488,7 +490,8 @@ int android_image_get_ramdisk(const void *hdr, cons=
t
> void *vendor_boot_img,
> >       } else {
> >               /* Ramdisk can be used in-place, use current ptr */
> >               if (img_data.ramdisk_addr =3D=3D 0 ||
> > -                 img_data.ramdisk_addr =3D=3D
> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> > +                 img_data.ramdisk_addr =3D=3D
> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
> > +
>  (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {
>
> Same here. Also, can we please drop the leading parenthesis (IS_ENABLED(
> -> IS_ENABLED( to be consistent with the previous code change?
>

ack.

l planed to release v3 later around end of next week and contain only patch
#1 #2 and #5 to ease maintainer processing. please feel free to comment on
any idea, i will include into next version.

regards,
George

>
