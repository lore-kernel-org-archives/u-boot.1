Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D1C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972E580C93;
	Mon, 16 Jun 2025 15:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g2/KB3GU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F42381760; Mon, 16 Jun 2025 15:27:12 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340108070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70a57a8ffc3so40530977b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080428; x=1750685228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vqNzaYJeHW0sPBD8fuBDZJch9wfYNw1/NPhdzENxP+I=;
 b=g2/KB3GUvE/6tb63SB6+cz/VGQu70JfwmyKea9zZqnEJjfDeLHg0NzwpOM0leuOsNN
 ZT5TWKOGbW9xtNKb7luHmgxscIeUhwe9prMm0mlFIdy+uMW8fZ+/Jve4v5+Fqgdhm06o
 zPBNQ5VbIQ/XjDIO5pJi0SO3ATA7Id95ok2xK7U9Lraj1Vk+XTc8zpeyvKun2c+w9re0
 caOwFnzY17Lkg32j3SI9351UJGHQEoIF1rDv2WY8sGBNj7vwtsicBOx6ilN9BNSyFOi2
 GSfloWPo6dhy3a0zgqHD5L8rW8NzJjoLYXNsUgivSYUVqddS8isSoQcKgInjyBEoUb4c
 Ec+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080428; x=1750685228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vqNzaYJeHW0sPBD8fuBDZJch9wfYNw1/NPhdzENxP+I=;
 b=Umvy3ZDQA7418q3rmV6rmOpVWzvvcJ6g0MKVaQ1txrPYZC652PLfASWmikO+WKwVpj
 4lHrfqheHFqkcB3i2KPtx3fifTx0YuotP45sZGU+VD56NxlD0760IvjkPtciN6OIKg5I
 WSE0pkBC/43rr8mwwPSvESuD/PWk3RIhFpMHXOg72UkPIyG+aSAY6Nav8PdkO6PF78s1
 rtl/xhcs9OK3jRheZ6KHmtS8+MqsGGA2GsrLMJQeEIuPEWyH8xUgIl/5hzwgvCmJ0LCk
 Fa7ctani3of7QY1ATfIMrCiLW6fFIgFU8Xp9UGnzyQRxqOz6JhX9lHDIBmf9tXCU3cmS
 xzvA==
X-Gm-Message-State: AOJu0Yy0KS9q7j34zZqwoAHHbomjsF8DyqnkgLH8SdGw1rM4gchDjq9X
 yNkSWpYem2qEgvaBqD49h0WCV23OgWOTx0I+uMjvm0OeKXGXhpoaKSQxw3z/X9wEXc7Bk0lyEPG
 TNniWxkLyytqlSmBSjWxH5E9La84sCrqxdeh2OznDtQ==
X-Gm-Gg: ASbGncvp5Kf9ptCmFtbnFh2khvvcA59r/SlZ4EHHIT/R0bjGZipnxFsAElkBCEXy6Pb
 +E2j2vs8OdkCm+GAUPSi3kFyBU3UZjU/ZaQm87OEhEJu67acwzvClHZOg7UoS14tTRHgI021+9+
 u6tEkbm8Tn2EcCQ/1rsS/2cYj6TPL7wOMHaPAGA5dYFlVF
X-Google-Smtp-Source: AGHT+IEdPyZ7dBikGv1+0Qs6N+vACh50/hy3l/tMLNxr/STwnvDCKppzvmoxtrq62fcDbOHycVcSGj7wUpr9bUiztn4=
X-Received: by 2002:a05:690c:498c:b0:70e:5eda:4940 with SMTP id
 00721157ae682-711754fe358mr126082167b3.25.1750080427985; Mon, 16 Jun 2025
 06:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-3-javierm@redhat.com>
In-Reply-To: <20250613085742.796015-3-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:26:32 +0300
X-Gm-Features: AX0GCFsBVpaSEf-ltf_Vf3G6NK5aVEkiBOcmY3B3jJf2ffgSc-sXixnLXsEXka4
Message-ID: <CAC_iWj+K-nY-evAj-fdZSNtwxZYNBQrKWmBSASZe6Mp9triesw@mail.gmail.com>
Subject: Re: [PATCH 2/3] disk: efi: expose the part_get_gpt_pte() helper
 function
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, mkorpers@redhat.com, mskrivan@redhat.com, 
 eballetb@redhat.com, mripard@redhat.com, alexl@redhat.com, 
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Thanks Javier,

On Fri, 13 Jun 2025 at 11:58, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> This function will be used by the EFI application disk support code
> to provide data required by the EFI_PARTITION_INFORMATION_PROTOCOL.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  disk/part_efi.c |  2 +-
>  include/part.h  | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index c7d79e253958..9f7907075887 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -216,7 +216,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>         return 0;
>  }
>
> -static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
> +int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
>  {
>         ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
>         gpt_entry *gpt_pte = NULL;
> diff --git a/include/part.h b/include/part.h
> index fcb3c13dea4d..ae36f23e33bb 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -628,6 +628,20 @@ int gpt_verify_partitions(struct blk_desc *desc,
>   */
>  int get_disk_guid(struct blk_desc *desc, char *guid);
>
> +/**
> + * part_get_gpt_pte() - Get the GPT partition table entry of a partition
> + *
> + * This function reads the GPT partition table entry (PTE) for a given
> + * block device and partition number.
> + *
> + * @desc:      block device descriptor
> + * @part:      partition number for which to return the PTE
> + * @gpt_e:     GPT partition table entry
> + *
> + * Return:     0 on success, otherwise error
> + */
> +int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
> +
>  #endif
>
>  #if CONFIG_IS_ENABLED(DOS_PARTITION)
> --
> 2.49.0
>
