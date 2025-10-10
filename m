Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D778CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB4E83F69;
	Fri, 10 Oct 2025 13:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zRoqyPPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E36E683FB0; Fri, 10 Oct 2025 13:07:06 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D381083F59
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63bcfcb800aso2137246d50.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760094424; x=1760699224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CEvirJXDI1KNHPjLUhKKEmh1ZDY45tOiYbF52Fo/79Q=;
 b=zRoqyPPuHhqjTJ3tieGV7MpTCuPF70rllQqzFCcEjYj+UwXCgXQZB+cmPYXVodndce
 EVgNGCa1Vjv0Pc2Ga+2LkDxNQHogMB6aScSOXznesuQXwmQ+3/6RkEdZAPasQFvpKP8Z
 gMV6C8V8UfzUp3EXRbG+a1X9HMzt4ww4X47ehfJpUDdEcqXYODu201dnkUf7H9z6uit3
 G+ejnmFhxSolrk88dRXeOIDcF3ixNM+xQRNqNB0eVrphAb8ZHn0tOyoEGK2kPLN36tRY
 oXP1XAl1SvMOki0nUvvGtWCS7d9O+R6yD4JZADlFvlHltTIcCP5cVgxyZry1gfEQtPar
 f5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094424; x=1760699224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEvirJXDI1KNHPjLUhKKEmh1ZDY45tOiYbF52Fo/79Q=;
 b=fz2DvZIuUeOGX2eLH1+M7WjDHxIvGRA1bBZ/juBI1S3Wi1NHRxq32W2xe5rd5yxTC6
 5+d2aistUE/jgWPUpCYC+CN+XAhRw1d70Q4ijmFU01WFLd0kIRLyr6mQxhdua9frzkE/
 e1o5dZGqb4q1UDLdZvETrANwKoYharEu+6k638PMTyTKX+51RQTtuCgCKMaWeEwGbFvB
 OMEZjziq1fg/+91yNVXsR/9LOon12jn/eEvSsQXhyHKs20GyTfhnD9/IiMFMX7krBMHR
 u0EgPneAXelIaCXyO4K+AlPVDmzBBMqePZO2et7KPE3+XeOSjmjr/FbaDgj4EKNltNZ1
 C5fQ==
X-Gm-Message-State: AOJu0YwCLbxPh+mhLNlgTtpZrL04S6WdzkhB87yaWz8SIBkWFyGweqRe
 7MO4FWZEq5tKP+elDw8YoGXVlDePxJzcf+penY+5Jhol3edFsESSGHoMw4N7kEdfgiDqiNFC0s5
 acSfpWvbmbgxh2kLvnWSDKg1u/dYgAN/7M7S9/WRy8g==
X-Gm-Gg: ASbGncutP6Go3MuEeBOPwetiAgCYbi9CdKAOloXW4Kx7AOg7ocPDH9BvQFe4DQLI5lJ
 YdNdyjNTylRdpxUfWfdF6Zo+tbjARejCqiRF5rqWQBN87iOr56bhLHesWaSBEZzzSXcZyG3kPhk
 GDqvPWTfP6g+8bjl20nVXrKMhEsFEtbdY+BzlD0Ll2pyYN8z3BqHKE85qo+0aT5+5ZIbWIqtkdQ
 SWbDqwzpHnhXNXcLW+4to6S/0cSHjpC2I6fIWzjolQcQBp/7P6ZJL4sJaE35bGnQkUKTi5IGimt
 QrWOudovdUbhQRxblZL7
X-Google-Smtp-Source: AGHT+IEUiRrCCaSUz9vUDympXXevMrG66wCwXctBc7eKC/RQhoisF53hxSPzvZce8rWtBIIOIO3HQxG1fmgvYEZSlzI=
X-Received: by 2002:a05:690e:1587:10b0:63c:e90c:a6dc with SMTP id
 956f58d0204a3-63ce90caca1mr2741952d50.8.1760094423640; Fri, 10 Oct 2025
 04:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
 <20251009-detect_disk_image_type-v8-1-a8b50a3b4acf@linaro.org>
In-Reply-To: <20251009-detect_disk_image_type-v8-1-a8b50a3b4acf@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Oct 2025 14:06:27 +0300
X-Gm-Features: AS18NWDoS_VWLYs8kXMBwly1x6THzyelt0kT1SUxWNZUyzrtLXBckG8EZkV73u8
Message-ID: <CAC_iWjJ-=C9VdBZsqnxKOf2K8UNSrhJhDgU6XuOSf4bsFrpyaQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] part: Export part_driver_lookup_type for external
 use
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 9 Oct 2025 at 16:18, Javier Tia <javier.tia@linaro.org> wrote:
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  disk/part.c    | 18 +-----------------
>  include/part.h | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..be2b45d5a29 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -47,23 +47,7 @@ static struct part_driver *part_driver_get_type(int part_type)
>         return NULL;
>  }
>
> -/**
> - * part_driver_lookup_type() - Look up the partition driver for a blk device
> - *
> - * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each parition driver
> - * against the blk device to see if there is a valid partition table acceptable
> - * to that driver.
> - *
> - * If @desc->part_type is already set, it just returns the driver for that
> - * type, without testing if the driver can find a valid partition on the
> - * descriptor.
> - *
> - * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
> - *
> - * @dev_desc: Device descriptor
> - * Return: Driver found, or NULL if none
> - */
> -static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>  {
>         struct part_driver *drv =
>                 ll_entry_start(struct part_driver, part_driver);
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..6caaa6526aa 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
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
> @@ -737,6 +755,9 @@ static inline struct part_driver *part_driver_get_first(void)
>  static inline bool part_get_bootable(struct blk_desc *desc)
>  { return false; }
>
> +static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> +{ return NULL; }
> +
>  #endif /* CONFIG_PARTITIONS */
>
>  #endif /* _PART_H */
>
> --
> 2.51.0
>
