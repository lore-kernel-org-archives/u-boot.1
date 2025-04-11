Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8364C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 11:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09ABC83FC8;
	Fri, 11 Apr 2025 13:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bM0UUdQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8720583FC9; Fri, 11 Apr 2025 13:57:19 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A6483FC0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 13:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ff1e375a47so18296307b3.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744372635; x=1744977435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BLhThnWb/CXT+H9sesuVAxTK+RGxUlf/M6Bz0a+4iMw=;
 b=bM0UUdQVfVg5RWmTPpgFZX1bMPbihdnuZ+qp0LhkZHqGskItEZSQPQIM+2ChsOTv0r
 qpNhg9A+O+WjG+FZNwMk0PaIoD/kYNvXr3X6F6mbDVPkQApjG5pBIQSPvB3XtdyV7Mj6
 MnDm6DbiUTkIijtWN//CPbFf+yjaU8b3Lt2n8xv/1qBfh3bcwtmFsxXyZIZeND+zSsVg
 iiMfWIte1HMpdh5AHGyRj1Tg9Tww0x/rPMzjIhUvta8liA2GKJjUapPGsjp115F70iCX
 mP1A6GMiIqAHiCk0rqnG1iDzThUIzUdccKuk+f6mrwsb8kLT3m6ob+v2PpGkk8RhteJZ
 mZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744372635; x=1744977435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLhThnWb/CXT+H9sesuVAxTK+RGxUlf/M6Bz0a+4iMw=;
 b=pODs3k2tQ89G1yMBDb1EiDkPDddRRAa5NFQU5yMnL+ADP3JkowjSeAD8b0Y578Ux2b
 bCIJq9/9FC3RFEds/bRFBiId9CpnWL+p+K45M8wpGjxu+tpjBw8aQt75A1txgSMaAm8c
 tF9Y7y6r8NiwnXi3FLKxmX0w023bcmKbIqQtYSFEevnvH4ntWWOrTCROXiaVZPp8KdQe
 4ucFhLORk1fkp+Ng8yaa4Dvb3YEL9bmVTcVw5x7fFQe6WErMMJJ4RTt9XonKGeQbrd6M
 KTomyi4MgbxBRqwuJsE5pTQVAkG7m4Ukjm9YIE2hkbWO7QAxo8eDVPZzcVVLzYEhqilQ
 MKrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf0X+frUzwCoQJ1iHJMoXRXwGYK0OF6++b0drUVe60ipd6t1Bu0U5B4KyibgE+MbQkuFjxE3w=@lists.denx.de
X-Gm-Message-State: AOJu0YxEDW6fGV9Azn+E8jB05KrHJQzOFke/paR8Q8f7MsVlgVfUDefR
 9iiytV//nCN83WUzFSdwkULVc3dqsqhO7VZUlD2NlN3/g2nZuOtj8cOrHgxPCz3++HpxghfsJSD
 7rLN/2ultUN7brt7MrCK9FE+Jgp1XKtXTDl1LFQ==
X-Gm-Gg: ASbGncuoEGQ+Mqa8AO+ivsVpOSaOom5Q7uFXbSpVlktjzkSrY9NhhXRwJBT16V16SdM
 vqfIS+5zcNUEg+1JSBOg9bpu3A9pThF9kfWJZ9kXHkS0B8dtKWpas/jtUv6q/wRxtAfdkMdR167
 waEGyGR4DGJ0K1/ZGCfhmIlKD2UEc996FqWQ==
X-Google-Smtp-Source: AGHT+IG1zYOliU9hAzbq1pfT4uosfyP/wzXt0J3gwUryVLHvSpYOcJzcb/Eo2leGP/h+aeo9oa095Q3zUgMA4CN+pcs=
X-Received: by 2002:a05:690c:67c4:b0:6f9:7fe6:9d48 with SMTP id
 00721157ae682-705599a6529mr37889067b3.7.1744372635169; Fri, 11 Apr 2025
 04:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
 <20250408-topic-gpt-cache-v2-1-de76e47debb7@linaro.org>
In-Reply-To: <20250408-topic-gpt-cache-v2-1-de76e47debb7@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 14:56:39 +0300
X-Gm-Features: ATxdqUEgICaASH3lZuTZq6H2XscaR_XqE1n58MXTxp9pHIsQS7EzHKigRmEqz04
Message-ID: <CAC_iWjJPSa5xNeNsYbZfdr=3BJ1dGdGq++hqO1=dG3mkFxa9Ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] part: add part_get_info_cached() API
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Neil,

On Tue, 8 Apr 2025 at 12:13, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Introduce a new part_get_info_cached() API that's used to
> get the part_info of a blk_desc allowing to use an eventual
> partition scanning cache to avoid rescanning the entire disk
> partition scheme for each partition number.
>
> The part_get_info_cached_free() is also added to hint the
> partition code to flush any cached data from this disk.
>
> The equivalent ops are added that directly maps to those
> added functions.
>
> This API is designed to be used as a direct replacement of
> part_get_info() in codes scanning all partitions for a same
> disk, like in blk-uclass. With this, a lot of unnecessary
> computation is saved, leading to a faster boot time when
> partitions are scanned, especially with storage medias
> with potentially multiple large hardware partitions like
> UFS, NVMe or eMMC.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  disk/part.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++-----------
>  include/part.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 11 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 303178161c083ec6e1b767b4f06ac5773576ca60..1d09c0511c75d457c81cab040c3f5caa924ee945 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -335,8 +335,8 @@ void part_print(struct blk_desc *desc)
>                 drv->print(desc);
>  }
>
> -int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
> -                         struct disk_partition *info)
> +static int _part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
> +                                 struct disk_partition *info, bool cached)
>  {
>         struct part_driver *drv;
>
> @@ -356,24 +356,57 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>                               desc->part_type);
>                         return -EPROTONOSUPPORT;
>                 }
> -               if (!drv->get_info) {
> -                       PRINTF("## Driver %s does not have the get_info() method\n",
> -                              drv->name);
> -                       return -ENOSYS;
> -               }
> -               if (drv->get_info(desc, part, info) == 0) {
> -                       PRINTF("## Valid %s partition found ##\n", drv->name);
> -                       return 0;
> +               if (cached && drv->get_info_cached) {
> +                       if (drv->get_info_cached(desc, part, info) == 0) {
> +                               PRINTF("## Valid %s partition found ##\n", drv->name);
> +                               return 0;
> +                       }
> +               } else {
> +                       if (!drv->get_info) {
> +                               PRINTF("## Driver %s does not have the get_info() method\n",
> +                                      drv->name);
> +                               return -ENOSYS;
> +                       }
> +                       if (drv->get_info(desc, part, info) == 0) {
> +                               PRINTF("## Valid %s partition found ##\n", drv->name);
> +                               return 0;
> +                       }
>                 }

That's fine but since you'll send a v3 with a cleanup on top mind also
switching the logic around on this?

if (!blk_enabled())
    return -ENOENT; etc

This will make it a bit more readable

>         }
>
>         return -ENOENT;
>  }
>
> +int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
> +                         struct disk_partition *info)
> +{
> +       return _part_get_info_by_type(desc, part, part_type, info, false);
> +}
> +
> +int part_get_info_cached(struct blk_desc *desc, int part,
> +                        struct disk_partition *info)
> +{
> +       return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, true);
> +}
> +
>  int part_get_info(struct blk_desc *desc, int part,
>                   struct disk_partition *info)
>  {
> -       return part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info);
> +       return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, false);
> +}
> +
> +void part_get_info_cached_free(struct blk_desc *desc)
> +{
> +       struct part_driver *drv;
> +
> +       if (blk_enabled()) {

Same here
if (!blk_enabled())
    return;
etc

[...]

Other than that LGTM

Cheers
/Ilias
