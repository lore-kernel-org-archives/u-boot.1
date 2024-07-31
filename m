Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C10C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBDA88A21;
	Wed, 31 Jul 2024 16:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U0kXM1hh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D8088A2F; Wed, 31 Jul 2024 16:39:06 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E592588A21
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70930f8eabbso2322824a34.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436741; x=1723041541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOPDbqgvenwxYxWpcxlW3PvwLCksahPOMkYVjT23J28=;
 b=U0kXM1hh2lMk8xgwtQeTFg+BbV0cVyIzANLn5QbtPuyKaPf5Jj9p5WZ9smm6vxQPDt
 e4lAWvGmDsG3VAzHEs6EVxwAli/GA2P6OGVh04dRppa1AmYg+iu9Ptq1b77rgK4N595O
 3A77zsq02gXMBK8d2PDlAupbXSn4tKL1ghz58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436741; x=1723041541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOPDbqgvenwxYxWpcxlW3PvwLCksahPOMkYVjT23J28=;
 b=traZkncmo/1eiIuDIEXGxoW2FN0dg2CklpROPsDNm1dMsOrt66768F3Z1CJKV2qCDr
 9x4EpvvrmvjN8XB+0+0pW6HOyPfG4eDNEmvTEwIfDDH3XzkFB10lAcsd5/lm/T1EFPtw
 SIGb5S0ndlpa+3CoW+RC1syUXZ0s9OyvVGHdPXVsMLBni10DiqgUcg/a92jNpmDKgemD
 A9iAwcASNcouCETWWtyQK4/Y8EGAd2xhzCqWECaCEDMQlQacxEFAZHL6hgn1O+FCpitu
 LBqQuIasjWw4mLcm1x9tcCEN9U12UvYYG8h806l/F2ZX54uL3o/y6SCxPlQ2ZRPEevKq
 8nRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfW/t9O4G2Vk4t8cvUG744FCn4RhfjBnqCrt4mPCT9I86Kgqe9w3aqkYhaglnaY7a/fcnngeMGbbPqAUF5EqP7N/BOJw==
X-Gm-Message-State: AOJu0YwVIpLsCJ05IUiu7rYa0rW45R+e/7aZC+c0Y/o+0xKnwOMbBK/X
 F56EXs+LrPmlvcx6h34oV3Vp6rDpFX9CopHLmCZ+/eTaqYRx9V76IeLAPlPLQfhkIWOQ+VVV4yv
 /nl8IGl40ggN/t/MWRXDoNWVTAASJpP0jRDui
X-Google-Smtp-Source: AGHT+IHbN39+QkXuWfXW4CrErEcaKBVer8ShJolTTCsHEByXh4o9AVbKyZ9I7ybBrbt3XQdWfmNe9P+uKA1cGPd7kGY=
X-Received: by 2002:a05:6358:590d:b0:1af:1bcd:a37a with SMTP id
 e5c5f4694b2df-1af1bcdeacdmr596905255d.22.1722436741547; Wed, 31 Jul 2024
 07:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240729213657.2550935-1-mwalle@kernel.org>
 <875xsnqn3q.fsf@baylibre.com>
In-Reply-To: <875xsnqn3q.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:50 -0600
Message-ID: <CAFLszTip3uwZLy=jL+-BKwD74Wk8j6So_N9TW_P16gpBvLKQRQ@mail.gmail.com>
Subject: Re: [PATCH v2] boot: android: fix booting without a ramdisk
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 30 Jul 2024 at 02:51, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Michael,
>
> Thank you for the patch.
>
> On lun., juil. 29, 2024 at 23:36, Michael Walle <mwalle@kernel.org> wrote:
>
> > android_image_get_ramdisk() will return an error if there is no ramdisk.
> > Using the android image without a ramdisk worked until commit
> > 1ce8e10f3b4b ("image: Fix up ANDROID_BOOT_IMAGE ramdisk code") because
> > the return code wasn't checked until then. Return -ENOENT in case
> > there is no ramdisk and translate that into -ENOPKG in the calling
> > code, which will then indicate "no ramdisk" to its caller
> > (boot_get_ramdisk()).
> >
> > This way, we can get rid of the "*rd_data = *rd_len = 0;" in the error
> > path, too.
> >
> > With this, I'm able to boot a linux kernel using fastboot again:
> >
> >   fastboot --base 0x41000000 --header-version 2 --dtb /path/to/dtb \
> >   --cmdline "root=/dev/mmcblk0p1 rootwait" boot path/to/Image
> >
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Simon Glass <sjg@chromium.org>

But see below

>
> > ---
> >  boot/image-android.c | 7 +++----
> >  boot/image-board.c   | 4 +++-
> >  include/image.h      | 2 +-
> >  3 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/boot/image-android.c b/boot/image-android.c
> > index 09c7a44e058..774565fd1fe 100644
> > --- a/boot/image-android.c
> > +++ b/boot/image-android.c
> > @@ -393,10 +393,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
> >       if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
> >               return -EINVAL;
> >
> > -     if (!img_data.ramdisk_size) {
> > -             *rd_data = *rd_len = 0;
> > -             return -1;
> > -     }
> > +     if (!img_data.ramdisk_size)
> > +             return -ENOENT;
> > +
> >       if (img_data.header_version > 2) {
> >               ramdisk_ptr = img_data.ramdisk_addr;
> >               memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
> > diff --git a/boot/image-board.c b/boot/image-board.c
> > index f2124013046..eca1b1d2bff 100644
> > --- a/boot/image-board.c
> > +++ b/boot/image-board.c
> > @@ -427,7 +427,9 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
> >                               unmap_sysmem(ptr);
> >                       }
> >
> > -                     if (ret)
> > +                     if (ret == -ENOENT)
> > +                             return -ENOPKG;

We normally use -ENOENT for this sort of thing.

> > +                     else if (ret)
> >                               return ret;
> >                       done = true;
> >               }
> > diff --git a/include/image.h b/include/image.h
> > index dd4042d1bd9..2ab17075287 100644
> > --- a/include/image.h
> > +++ b/include/image.h
> > @@ -1858,7 +1858,7 @@ int android_image_get_kernel(const void *hdr,
> >   * @vendor_boot_img : Pointer to vendor boot image header
> >   * @rd_data: Pointer to a ulong variable, will hold ramdisk address
> >   * @rd_len:  Pointer to a ulong variable, will hold ramdisk length
> > - * Return: 0 if succeeded, -1 if ramdisk size is 0
> > + * Return: 0 if OK, -ENOPKG if no ramdisk, -EINVAL if invalid image
> >   */
> >  int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
> >                             ulong *rd_data, ulong *rd_len);
> > --
> > 2.39.2

Regards,
Simon
