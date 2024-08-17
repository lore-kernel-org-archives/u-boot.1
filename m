Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD63DC52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 16:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A906B888A7;
	Sat, 17 Aug 2024 17:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HoriVza5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334EA88C82; Sat, 17 Aug 2024 17:58:43 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8B8886F9
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so1784093eaf.0
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910318; x=1724515118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WIVygIY1zU8cGgQi6cs4SFWI29sJwXB0t8kWFCLijqc=;
 b=HoriVza56dQ1RFeiLaT0BrooMqkDXkly/3pBAqF0jWY862aFijUk4+t0aeeB/gotyc
 PjJb7eGz6c3eC9JQE345fT9gmW/smpyk1NMTaOKcnswjl0UeVVLSqDsVXvVpRdZTiW6I
 r7Al8Jz94pFG2seFHznHp+N5+jizIZeRyh6bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910318; x=1724515118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WIVygIY1zU8cGgQi6cs4SFWI29sJwXB0t8kWFCLijqc=;
 b=HDYj75KcR0dVe7yuDU7cuTEMgbyEix+r+nVhhDox3/9UmMo0IeWzkBqthkhmN9DoQX
 0elsQbF4WyoJ/rYAZTnQSOPGuLXM5yrHERELGxG8Uj5OUy/nJmwPxL9FeV944jv8axi6
 K2LHz6EbRL740KP/0QpeAcpThyro+UIWasFuA/5iITeGBnGY3EFfz2gcbJKxAkBklykn
 GR85QHS7yU3/37NsZT/PR0S/+PzqdFkEEmdaox9IkfJ+esLFVSDyU6bGyh44nPys+fib
 oTF1pAZsNqd5pN3SJJvfflUJO6yjXoV0r5PgKw1FIlMkolc4gNz8s0APvO5mPgibCpS4
 c5YQ==
X-Gm-Message-State: AOJu0Yx2jG8JHcwr+ZxBew26L8UNeVMdToUGUL8/Dz1wWdoEKzSLweJK
 y2Cox6/3/OvHGSl8A0Wle3VMNs2hEqQ+tgtRIuKhV9XmL/n3cO1iXlk2g6COGxygajPXUu0WBkF
 PRw2xloAtOZ2iCpAsXWY9koaxjs0aluqNIxSb
X-Google-Smtp-Source: AGHT+IEDvUZhl9N8PstFxSEOnWqy81tWd0g+MU0M0SYsvbENNQEu5e1lCeuqzhzQXKfpQ5FC9cQvtjH1de+uUyakaXI=
X-Received: by 2002:a05:6358:3411:b0:1aa:b9f2:a0cf with SMTP id
 e5c5f4694b2df-1b3931c34a9mr827585455d.17.1723910318663; Sat, 17 Aug 2024
 08:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240816073332.279025-1-mailinglist1@johanneskirchmair.de>
In-Reply-To: <20240816073332.279025-1-mailinglist1@johanneskirchmair.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:28 -0600
Message-ID: <CAFLszTgx3NrH8-6XF4NKhfCcYxn-nWY3f6GNL_ORbzD5zGaswA@mail.gmail.com>
Subject: Re: [PATCH] spl: fix error handling of spl_fit_read
To: mailinglist1@johanneskirchmair.de, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, 
 Johannes Kirchmair <johannes.kirchmair@skidata.com>
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

+Sean Anderson too, for this

Hi,

On Fri, 16 Aug 2024 at 07:36, <mailinglist1@johanneskirchmair.de> wrote:
>
> From: Johannes Kirchmair <johannes.kirchmair@skidata.com>
>
> Returning negative values from spl_fit_read leads to u-boot crashing.
> The return value of spl_fit_read is compared with an unsigned value.
> Returning negative values leads to the check not detecting the error.
> Not detecting the error leads to crashing.
>
> Returning zero in case of an reading error is fine. It indicates that
> nothing was red.

read

>
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@skidata.com>
> ---
>  common/spl/spl_fat.c | 2 +-
>  include/spl_load.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Perhaps instead this should be fixed in _spl_load()? We don't want to
ignore errors, and returning -EIO is not as good as returning the
actual error received. The docs of struct spl_load_info indicate that
functions should return 0 on error, but that is somewhat surprising
behaviour, which is probably why people are not following it?

> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index bd8aab253a..345bc55149 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -53,7 +53,7 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
>
>         ret = fat_read_file(filename, buf, file_offset, size, &actread);
>         if (ret)
> -               return ret;
> +               return 0;
>
>         return actread;
>  }
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 1c2b296c0a..b411d9daa1 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -17,8 +17,8 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>  {
>         struct legacy_img_hdr *header =
>                 spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> -       ulong base_offset, image_offset, overhead;
> -       int read, ret;
> +       ulong base_offset, image_offset, overhead, read;
> +       int ret;
>
>         read = info->read(info, offset, ALIGN(sizeof(*header),
>                                               spl_get_bl_len(info)), header);
> --
> 2.34.1
>

Regards,
Simon
