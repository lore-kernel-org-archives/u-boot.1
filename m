Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988D1C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798B1871E4;
	Sat,  4 Nov 2023 20:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DG/BUuzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218FE8715B; Sat,  4 Nov 2023 20:45:28 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAA487163
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso853857266b.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127122; x=1699731922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=supDsRVH3jDMJ/A5dgVFk0q3HYj1sXmxBj1jRg+tixM=;
 b=DG/BUuzlxENCFgPPp/fPsXJ50T4EbjmBgU76FZTSjMM2+46MNuY3SdFjkqLkY6v95R
 XqTQBDy4rdSLMKTlNqAX8U0pjnqassWyiSijzy3O2gRgL0YwM1Skl/Q3e2RTYUgDUvbH
 Exb7lUUQLuVHtp4j8uw8nOAr34HWYsjm9b7Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127122; x=1699731922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=supDsRVH3jDMJ/A5dgVFk0q3HYj1sXmxBj1jRg+tixM=;
 b=AGnLMPaUUDy3kmCVNCUzGaCgcfYtTQCjONUb1k9YM1O6qmEEfulv0+YffPOUa8RjDv
 wK4AYAOcQGBtxbia9GrJEK/WYG2kMunhtJ7F3Oyp2b3pOH25l3FCgm79SD7XTBHmgW4R
 0bjrOUuMg4/z4A3XbPD84tsVhTwlCXZBoViYGE0gZtyAXU4mr5+kitQN+60qIVWVBXNJ
 4QyV1ZCuLvfTfIYq5cRITR74Pd/P8FLj7gzqLJNP8bC1Mb4ios2iQlhm38E0bJ3eFLit
 aMRjDaer1nNAXjuMN5n6kXQj+rPafiAs68pVcuJGdoTe5gWazbHTXeCSB4JejGlFtK94
 US8A==
X-Gm-Message-State: AOJu0YzzOzSbjKc4QPdgF4Tbkb11MM4ROcted3C5IGBkpM/fqWhCm7Ky
 7PK7EiOokGk4k0ndR/nYDASAFNSobZb9XEJuYHmFDGsXgSeDoZmiktQ=
X-Google-Smtp-Source: AGHT+IE+FhmicSDGYsshiO1xkNLPc6QV+zwuzrWlC7Hcs1JpJMHC4Y4Lt1Vzte4XbclvUQUVCR8Za/zAEQRyM8WHdhc=
X-Received: by 2002:a17:906:2249:b0:9de:6d57:c005 with SMTP id
 9-20020a170906224900b009de6d57c005mr1851014ejr.9.1699127121696; Sat, 04 Nov
 2023 12:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231104184716.13743-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231104184716.13743-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:45:10 +0000
Message-ID: <CAPnjgZ3st2CHJeSVkZGL-N7fDQqebK9VD0vodsXaz+Er96sB1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: fix misleading messages
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
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

On Sat, 4 Nov 2023 at 18:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When no RNG device exists for a driver referenced via U_BOOT_DRVINFO() we
> get messages like:
>
>     No match for driver 'arm-rndr'
>     Some drivers were not found
>
> This is misleading as it is not the driver that was not found, it is the
> device that is not found. Correct the messages.
>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/core/lists.c | 2 +-
>  drivers/core/root.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index 8034a8f48d..e39d3acc97 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -97,7 +97,7 @@ static int bind_drivers_pass(struct udevice *parent, bool pre_reloc_only)
>                         if (CONFIG_IS_ENABLED(OF_PLATDATA))
>                                 drt->dev = dev;
>                 } else if (ret != -EPERM) {
> -                       dm_warn("No match for driver '%s'\n", entry->name);
> +                       dm_warn("No device for driver '%s'\n", entry->name);

This should be "No match for driver_info"

It is not a device

>                         if (!result || ret != -ENOENT)
>                                 result = ret;
>                 }
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index d4ae652bcf..29c918eb73 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -167,7 +167,7 @@ int dm_scan_plat(bool pre_reloc_only)
>
>         ret = lists_bind_drivers(DM_ROOT_NON_CONST, pre_reloc_only);
>         if (ret == -ENOENT) {
> -               dm_warn("Some drivers were not found\n");
> +               dm_warn("Some devices were not found\n");

Some driver_infos were not found

They are not devices

>                 ret = 0;
>         }
>
> --
> 2.40.1
>

Also please add a Fixes tag, I think for this:

20e442ab2df dm: Rename U_BOOT_DEVICE() to U_BOOT_DRVINFO()

Regards,
Simon
