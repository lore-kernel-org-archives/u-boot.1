Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E100CAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 06:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27CFE836B2;
	Thu, 25 Sep 2025 08:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U85QGDAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A435F836B8; Thu, 25 Sep 2025 08:21:33 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E698D835CB
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 08:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-ea856357c38so449253276.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758781290; x=1759386090; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B2i38U/x/oQjgYhkNjwFcWg0yJJI86Z4DohF0zTGvQw=;
 b=U85QGDAEGdwJL9UEzpRW5L4nfXOJ7pH0mp0CmjcsUpWw0PFJW47jDEUQKWQf6uPHMI
 iTcDwmZoOr5EjXgWfw+XwchgFU00YsPWDh8AtwCkGvsV0zmiijnGK2xn0srCQ/i1hJE2
 IiOy0HpQyfYrBalSBjdPYp1CDQ3mDfnmMLgICA3EIy/c46fV3yASvzUoLzVL5H2tVq8Y
 2a5L/sdEctgHalwFS09mz2GjdnQ6hzierFa4+4vdZBdwejzc59IfzrQibLKlwRiqkR5I
 kZFGqBIFapzPDHSw6xrtTwajkvFLC0JCpQ/Wf8GVorNK/8qZ6dhSsTcaKSG4wQju+yoF
 /E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758781290; x=1759386090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2i38U/x/oQjgYhkNjwFcWg0yJJI86Z4DohF0zTGvQw=;
 b=rHQPrKZzC+fWYyinaNIY+0pi7F6qLQEi4FO6hVOLYsACQLGkNHkzIX2LBjBOH1VbFk
 wGHYjpTVJEGZ9WpHobfYb1wlo/socA98+aJQNgmASQOWX7dW4K5mBVSPwDsiDH1cluQd
 kNT3tolvRcGaJi6iZ0UIJ+YFMjpt4SQocVZ3iyhBYTqJxud/eQJQJlQJYDJi95Z5tfeV
 KraD71NSMphLwR7ktLEoMWAGcFuLQKFYzTMHWBOQ6DPqNKHTboc5umdEY8MboC1m18BT
 ERLPej17pzjoMZe7Uj2h9M7K0ApRJOtFzLJr0Tq6JaWiA0LOJ/GPsY6qJ9mu1rwPmItK
 eQOA==
X-Gm-Message-State: AOJu0YxE+RAmO7sLYxC1ihmP3S9xx0pZCH769wTKj58NnC/h048ikzi5
 f2n0kWtXXM1OxJLw6C1/UIEDyTTaPVIsrHZXDo3cemvFTQLvRcTsINtQcNI19Rt3Wp3A20hnGRv
 +kKV1u1GsSlR+uJUZfyw1DrlQxwPteAjY4s/e7KQYYg==
X-Gm-Gg: ASbGnctlqu7hp9BHDyzAuJHYYzMrMzNL1EPEvXo4OBJv8Is2x6CMXkDqLS704CgTwOL
 MwvsaBYK8HwqoeuJqSrixgezMokcHaGG6b+nw+KUiGKI9/8nAzPfOuZYlUhor5gEXilazmUarzD
 WIDoqbIPeR4T1pnB74pAtoipL1AQqjHwSf4L+go3g41BG6v6BTBykkL7xblXpbe9y166lr0ogyN
 vY+N8Q=
X-Google-Smtp-Source: AGHT+IHopT15xyfi8hUYUxOAlbk9gv+f2vZ06DG/HQAKN6Q0NgL9qb4Mm85lVF0TwF5oWVH+iqkLJUDHYvzFb+oRmRE=
X-Received: by 2002:a05:6902:f89:b0:eaf:141:a68b with SMTP id
 3f1490d57ef6-eb37fc2fa3emr1981409276.19.1758781289743; Wed, 24 Sep 2025
 23:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250924233120.454116-1-javier.tia@linaro.org>
 <20250924233120.454116-2-javier.tia@linaro.org>
In-Reply-To: <20250924233120.454116-2-javier.tia@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Sep 2025 09:20:53 +0300
X-Gm-Features: AS18NWCXG6z3hgCSRreAgS6uw92jDDI3NVHYvvBd0RE-hyB5fBSgQM39sj3q1u0
Message-ID: <CAC_iWjKBzrJJj1fzeAkBeV2ZrOO1fT+9QUHrVdkb0FFD+seafg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] part: Export part_driver_lookup_type for external
 use
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Javier,

On Thu, 25 Sept 2025 at 02:31, Javier Tia <javier.tia@linaro.org> wrote:
>
> Make part_driver_lookup_type non-static so it can be used outside
> part.c. This allows external callers to determine the appropriate
> partition driver for a block device, enabling more flexible handling of
> partition types.
>
> Add a prototype and kernel-doc comment in part.h to document the
> function contract. Provide a stub inline implementation returning NULL
> when partition support is disabled, ensuring build consistency across
> configurations.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  disk/part.c    |  2 +-
>  include/part.h | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..f0c6866e210 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int part_type)
>   * @dev_desc: Device descriptor
>   * Return: Driver found, or NULL if none
>   */
> -static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>  {
>         struct part_driver *drv =
>                 ll_entry_start(struct part_driver, part_driver);
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..52fd3d534e0 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -471,6 +471,9 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>  #define part_get_info_ptr(x)   x
>  #endif
>
> +static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> +{ return NULL; }

This won't compile. You need to define it in the #else of #if
CONFIG_IS_ENABLED(PARTITIONS)

Cheers
/Ilias
> +
>  /**
>   * struct part_driver - partition driver
>   */
> @@ -727,6 +730,24 @@ int part_get_type_by_name(const char *name);
>   */
>  int part_get_bootable(struct blk_desc *desc);
>
> +/**
> + * part_driver_lookup_type() - Look up the partition driver for a blk device
> + *
> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partition driver
> + * against the blk device to see if there is a valid partition table acceptable
> + * to that driver.
> + *
> + * If @desc->part_type is already set, it just returns the driver for that
> + * type, without testing if the driver can find a valid partition on the
> + * descriptor.
> + *
> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
> + *
> + * @desc: Device descriptor
> + * Return: Driver found, or NULL if none
> + */
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
> +
>  #else
>  static inline int part_driver_get_count(void)
>  { return 0; }
> --
> 2.51.0
>
