Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F40DC83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 02:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 003A186B22;
	Sat, 26 Aug 2023 04:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="awXqiQGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E293386AE8; Sat, 26 Aug 2023 04:04:47 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D6886A7D
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 04:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so2059413a12.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693015484; x=1693620284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a98KiWpMXPLUv/bZBD89tTet3wjkpMFmi/NJ6JP+R8Y=;
 b=awXqiQGkwojIuC6hro1R1eTQxGn6cinGayC7AJhTxkT00b9e5g4AxFemJ2349njUlC
 BG3dMm+QanvZODfJTxR4TrmhmjRpKa2fbXZ0z/fG3oNMF2CvW1IimAIOdz8G1putcaSF
 bJ4n7TSDxTnZQoZpjNPyyMtPZ09i4F2xD7kZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693015484; x=1693620284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a98KiWpMXPLUv/bZBD89tTet3wjkpMFmi/NJ6JP+R8Y=;
 b=RZ+M9rOCf2x1QtgdWfxYkp3Kg5qSqK+jwMEfuOHYSKconOnVRmOz3T1mHcIMuYIdxQ
 I4V0eQ3SdGTkTroxpxeFpflmWaXA7v4ut4XCnrGVJE5KhbRP4ZwFSwizJ2DwDT3Vn1q5
 0kxlTvQ6C7YeNF08ixF2apeEjIBIi4DZewvu8uC9lB645lPIaPPUw0VtMkcvoF6W5zMS
 Q5OcQLdHAiH9YMtGod8TgwXZRKWWppE2I7wCAQ55cV4bVFhlyTFq8ebbInzRfXHlmmMf
 T3i1miK8+JVSgXycgD+2ntReNi7992mB0Rv7NQWGicYEwbx7P2DPIxuDQoErOhyvjfRv
 F20w==
X-Gm-Message-State: AOJu0YxVfHtMQtOcrdLUN/b5sOdFwpkYQkU5rG0VeoX20k3iMr7qRKmk
 SE/JUlRgxBc/LXuB0jVYS1sIND8yhKru4yOcdFw6uQ==
X-Google-Smtp-Source: AGHT+IFNnaedUbFg3lMIuWud6SHpKQi9LSXOlLGXVHZSzbsTXZoSCMnx29IcKyG2yMESIj3/P7tibuuuedp6iElmvmU=
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id
 u22-20020aa7d996000000b00522d6f4c0ebmr13230226eds.40.1693015484262; Fri, 25
 Aug 2023 19:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
 <20230826015343.167612-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230826015343.167612-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 20:04:31 -0600
Message-ID: <CAPnjgZ1h5Mz=f8mjZk806bfa3RKyTetp+YGiNS-mH-fKSGNLYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmd: fix gpt enumerate
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Joshua Watt <jpewhacker@gmail.com>
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

On Fri, 25 Aug 2023 at 19:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Do not assume that partitions are numbered continuously starting at 1.
>
> Only a single partition table type can exist on a block device. If we found
> a GPT partition table, we must not re-enumerate with the MBR partition
> driver which would find the protective partition.

Does it really? My understand is that it sets desc->part_type and it
stays like that from then on?

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/gpt.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index d0e165d539..99ca0a6163 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -691,12 +691,13 @@ static int gpt_enumerate(struct blk_desc *desc)
>                 int ret;
>                 int i;
>
> +               if (part_drv->test(desc))
> +                       continue;
> +
>                 for (i = 1; i < part_drv->max_entries; i++) {
>                         ret = part_drv->get_info(desc, i, &pinfo);
> -                       if (ret) {
> -                               /* no more entries in table */
> -                               break;
> -                       }
> +                       if (ret)
> +                               continue;
>
>                         ptr = &part_list[str_len];
>                         tmp_len = strlen((const char *)pinfo.name);
> @@ -711,9 +712,10 @@ static int gpt_enumerate(struct blk_desc *desc)
>                         /* One byte for space(" ") delimiter */
>                         ptr[tmp_len] = ' ';
>                 }
> +               if (*part_list)
> +                       part_list[strlen(part_list) - 1] = 0;
> +               break;
>         }
> -       if (*part_list)
> -               part_list[strlen(part_list) - 1] = 0;
>         debug("setenv gpt_partition_list %s\n", part_list);
>
>         return env_set("gpt_partition_list", part_list);
> --
> 2.40.1
>
