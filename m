Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9E5C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 14:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22E88283E;
	Fri,  9 May 2025 16:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CGtAUKUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EB782905; Fri,  9 May 2025 16:22:42 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A32482162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 36260A4C2AA;
 Fri,  9 May 2025 14:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853A5C4CEE4;
 Fri,  9 May 2025 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746800558;
 bh=he0Ux7IFEJobquxahNB4/eDtwDUplgSXbO/6CgWjG3U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CGtAUKUWW2rjfvK+d1KUve8xEs4BuN5UuzW7b4oC+mwdzTzIIEmPvQxf/C416LCyt
 ZM5R0r47IXDZXc37sM+MQjqtBOT1w/xsGoOuxQ1QcYUtG6ljcQMmV+PG+p1ycO6J9v
 /m2Cz2acR7PVPPhWZix7UVgl8Y4MFSA9mmDM17UE2C56DRpjTP6kB9Wd8GD2Xi221w
 WDLGgJU2nIOHe+pr+yDRbHFp7Vv+uPcyJTgQS9feJVGo2YgKcfgllTX/ssErKKQbxt
 w6S3mgid0HvXQal6qK41uMQje8Ao1LeEVtMNqWn2spJWOHvUSsSh43VclfJJQiW4UR
 JYJuXghWdvCdA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: george chan <gchan9527@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/5] boot/image-android: Workaround kernel/ramdisk
 invalid addr
In-Reply-To: <CADgMGSuhEK6xdrhnGEDnx-dtoNSneMABEr3-26a4u0s4eXgvYw@mail.gmail.com>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
 <20250505-android-boot-v2-1-92dcb5bf59c8@gmail.com>
 <87zffoamlv.fsf@kernel.org>
 <CADgMGSuhEK6xdrhnGEDnx-dtoNSneMABEr3-26a4u0s4eXgvYw@mail.gmail.com>
Date: Fri, 09 May 2025 16:22:36 +0200
Message-ID: <87zffln9sj.fsf@kernel.org>
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

Hi George,

On jeu., mai 08, 2025 at 12:22, george chan <gchan9527@gmail.com> wrote:

> Hi Mattijs,
>
> Thx for feedback.
>
> =E5=9C=A8 2025=E5=B9=B45=E6=9C=887=E6=97=A5=E9=80=B1=E4=B8=89 15:47=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=9A
>
>> Hi George,
>>
>> Thank you for the patch.
>> I really prefer this solution to the one proposed in v1.
>>
>> I have tested this on Khadas VIM3 board (using
>> khadas-vim3_android_defconfig)
>>
>> I have a couple of small remarks below.
>>
>> On lun., mai 05, 2025 at 17:17, George Chan via B4 Relay <
>> devnull+gchan9527.gmail.com@kernel.org> wrote:
>>
>> > From: George Chan <gchan9527@gmail.com>
>> >
>> > Some androidboot image have invalid kernel/ramdisk load addr,
>> > force to ignore those value and use loadaddr instead.
>>
>> Can we please elaborate a bit more in the commit message?
>> We have not explained/justified why repacking a boot image with proper
>> kernel ramdisk/load addr is not possible.
>>
>> Is the following an acceptable justification for you?
>> """
>> Since it's not always possible to change the load addr by repacking
>> the boot.img (due to AVB signature mismatch/<or_another_justification>),
>> we need a way to use kernel_addr_r and ramdisk_addr_r.
>> """
>>
>> Feel free to reformulate the above.
>>
>
> Thx. let me sum up as below 2 reasons.
>
> 1. there is a concern on exposing the whole memory to image loading is
> dangerous
>
> 2. Since it's not always possible to change the load addr by repacking
> the boot.img (mainly due to AVB signature mismatch),
> we need a way to use kernel_addr_r and ramdisk_addr_r.

That's good summary. Please include it in the commit message for v3.

>
>
>> >
>> > Suggested-by: Casey Connolly <casey.connolly@linaro.org>
>> > Signed-off-by: George Chan <gchan9527@gmail.com>
>> > ---
>> >  boot/Kconfig         | 6 ++++++
>> >  boot/image-android.c | 9 ++++++---
>> >  2 files changed, 12 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/boot/Kconfig b/boot/Kconfig
>> > index fb37d912bc9..4bdac384181 100644
>> > --- a/boot/Kconfig
>> > +++ b/boot/Kconfig
>> > @@ -11,6 +11,12 @@ config ANDROID_BOOT_IMAGE
>> >         This enables support for booting images which use the Android
>> >         image format header.
>> >
>> > +config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>> > +     bool "Android Boot Image ignore addr"
>> > +     default n
>> > +     help
>> > +       This ignore kernel/ramdisk load addr specified in androidboot
>> header.
>>
>> Please add a bit more context here, checkpatch.pl reports issues:
>> $ ./scripts/checkpatch.pl --u-boot --git master..HEAD
>>
>> WARNING: please write a paragraph that describes the config symbol fully
>> #27: FILE: boot/Kconfig:14:
>> +config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>>
>
> same as above.
>
>>
>> > +
>> >  config TIMESTAMP
>> >       bool "Show image date and time when displaying image information"
>> >       default y if CMD_DATE
>> > diff --git a/boot/image-android.c b/boot/image-android.c
>> > index 1746b018900..7b8eb6a4f64 100644
>> > --- a/boot/image-android.c
>> > +++ b/boot/image-android.c
>> > @@ -268,7 +268,8 @@ static ulong android_image_get_kernel_addr(struct
>> andr_image_data *img_data,
>> >        *
>> >        * Otherwise, we will return the actual value set by the user.
>> >        */
>> > -     if (img_data->kernel_addr  =3D=3D ANDROID_IMAGE_DEFAULT_KERNEL_A=
DDR) {
>> > +     if (img_data->kernel_addr  =3D=3D ANDROID_IMAGE_DEFAULT_KERNEL_A=
DDR ||
>> > +             IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
>>
>> Please fix indentation, should be:
>>
>> +       if (img_data->kernel_addr  =3D=3D ANDROID_IMAGE_DEFAULT_KERNEL_A=
DDR ||
>> +           IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
>>
>> (checkpatch.pl reports this)
>>
>
> ack.
>
>
>> >               if (comp =3D=3D IH_COMP_NONE)
>> >                       return img_data->kernel_ptr;
>> >               return env_get_ulong("kernel_addr_r", 16, 0);
>> > @@ -464,7 +465,8 @@ int android_image_get_ramdisk(const void *hdr, con=
st
>> void *vendor_boot_img,
>> >        */
>> >       if (img_data.header_version > 2) {
>> >               /* Ramdisk can't be used in-place, copy it to
>> ramdisk_addr_r */
>> > -             if (img_data.ramdisk_addr =3D=3D
>> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
>> > +             if (img_data.ramdisk_addr =3D=3D
>> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
>> > +
>>  (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {
>>
>> Same here. Also, can we please drop the leading parenthesis (IS_ENABLED(
>> -> IS_ENABLED( to be consistent with the previous code change?
>>
>
> ack.
>
>
>> >                       ramdisk_ptr =3D env_get_ulong("ramdisk_addr_r", =
16,
>> 0);
>> >                       if (!ramdisk_ptr) {
>> >                               printf("Invalid ramdisk_addr_r to copy
>> ramdisk into\n");
>> > @@ -488,7 +490,8 @@ int android_image_get_ramdisk(const void *hdr, con=
st
>> void *vendor_boot_img,
>> >       } else {
>> >               /* Ramdisk can be used in-place, use current ptr */
>> >               if (img_data.ramdisk_addr =3D=3D 0 ||
>> > -                 img_data.ramdisk_addr =3D=3D
>> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
>> > +                 img_data.ramdisk_addr =3D=3D
>> ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
>> > +
>>  (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR))) {
>>
>> Same here. Also, can we please drop the leading parenthesis (IS_ENABLED(
>> -> IS_ENABLED( to be consistent with the previous code change?
>>
>
> ack.
>
> l planed to release v3 later around end of next week and contain only pat=
ch
> #1 #2 and #5 to ease maintainer processing. please feel free to comment on
> any idea, i will include into next version.
>
> regards,
> George
>
>>
