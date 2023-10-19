Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D2CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 03:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 452B887148;
	Thu, 19 Oct 2023 05:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HDHivTBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748908714D; Thu, 19 Oct 2023 05:22:06 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418D787145
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 05:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso5612955a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697685722; x=1698290522; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h6M5J4dhM2bPsEhZM/QBoIUFqEO/zn3D+knTkj4Less=;
 b=HDHivTBIM+4bXhOM5YEtdewjepnF04bHlNBVgbBiE4gvO2NMXEq7Cfv2NVTmIhq/x6
 6z02jzq5S5audfeoKWvh1HaZzz+6bn/EpHXcsyD/YVyee8/bipw0rB+nJIyX2KvBNWFT
 pAoROxqzCqvBfBFAjLBrHU2V4QknmlHG3Ld6HuZUjBgUplpWr9ZdNSkuj74PCpurIPxR
 3tGSavbyGZwb99b05ofi7cuk19mBgVOTf2KPR9X8nC7W+0aDUCEAblOJdg5+eEMM79Us
 t7X4BCQQEegltQoeW4O5KgBlnAS8w51gcUEgkJVHqj1VcNBrEElkECuAOfNCrQP0yoRc
 zE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697685722; x=1698290522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h6M5J4dhM2bPsEhZM/QBoIUFqEO/zn3D+knTkj4Less=;
 b=PyF8XQu+hxAQg8rSNw1VuLnrPqNMzTP3ZKLLeR3JYe2h3G7vmEWqTpcRXEK/u32gLw
 BF0P6zfQXOMQcQd+8ES/8HzL3bk+/arHNKhkecgXmJwTSmyhNfRjWcFX+mqOs4VNuCnz
 LU7SmH062RNNJ+0kkkAQa6/w8hfGGb6nmgq1cnGEYKaJt05bWCDuXe3Jm3Lui341qgMk
 YkIxrUS3UwjTLBTE4hTy9sAxxMcLClMw+RCBrWzpzKPbiXpIThCevHVvu2gmoSL8aycP
 60ncAitY+Lc8u7bELxuLrwP97bn65vlwSkdXnytUGDgF+iAcOWzULZGAamFWjSrSd6E1
 +wFw==
X-Gm-Message-State: AOJu0Yzp2m4bzaAOzZ61QHg6fyqumVMP1cjAC75Gb9YpAg9PwSiZoFia
 FZtDolNWx2hmSrKJ5rj2ZGcI/QcKoVQJ+jMIhB2evg==
X-Google-Smtp-Source: AGHT+IGqJaL+90/WVzeU2VAN3ZKQEuUkJmTVbMJFUL5A2ob6IhQz0BXZ+ezpbMW3zLiO1M+QS1v2eMc3y4EpVf56i4s=
X-Received: by 2002:a05:6a20:8f1e:b0:169:cd02:65e9 with SMTP id
 b30-20020a056a208f1e00b00169cd0265e9mr1104494pzk.33.1697685721922; Wed, 18
 Oct 2023 20:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-7-masahisa.kojima@linaro.org>
 <13131882-9007-4322-ad4a-5c8b505a5328@gmx.de>
In-Reply-To: <13131882-9007-4322-ad4a-5c8b505a5328@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 19 Oct 2023 12:21:50 +0900
Message-ID: <CADQ0-X8iRRiBTNBkLT-SaMpmDmGbJOQ6=a14F3MBzqhg9xtjkA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] efi_loader: add CDROM short-form device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 18 Oct 2023 at 19:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/16/23 08:45, Masahisa Kojima wrote:
> > UEFI specification does not mandate to support the short-form
> > of the CDROM media device path.
> > Fedora installation ISO image is identified as CDROM media
> > device path, supporting short-form CDROM media device path is
> > required to automatically add the boot option having default
> > file of Fedora installation image.
>
> How is the CDROM media path created?

Fedora installation media only has a ISO 9660 filesystem without
MBR/GPT partition table.
U-Boot disk driver classifies it as PART_TYPE_ISO, then EFI-subsystem
creates a CDROM media path for it.

> Why would the image not be found if the path is not shortened?

We discussed in the separate patch that we drop the patch#4(automatically
create the boot option with default application file path appended),
so this patch is also dropped.

> What is Fedora specific here?

Fedora installation media has ISO 9660 filesystem only.
Other disto such as Debian has a MBR partition table, U-Boot creates
HardDisk device path for these medias.

> What does EDK II do?

EDK II does the same for Fedora install image, CDROM media path is created.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_device_path.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > index ed7214f3a3..ac673ab117 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -110,7 +110,8 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
> >       while (dp) {
> >               if (EFI_DP_TYPE(dp, MESSAGING_DEVICE, MSG_USB_WWI) ||
> >                   EFI_DP_TYPE(dp, MEDIA_DEVICE, HARD_DRIVE_PATH) ||
> > -                 EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH))
> > +                 EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH) ||
> > +                 EFI_DP_TYPE(dp, MEDIA_DEVICE, CDROM_PATH))
> >                       return dp;
> >
> >               dp = efi_dp_next(dp);
>
