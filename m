Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B40C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE9C87F31;
	Tue, 28 May 2024 09:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RY8yXm/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1DB88405; Tue, 28 May 2024 09:32:54 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F61879F2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42108856c33so20697185e9.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716881571; x=1717486371;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mgUZ78+iFCTuzva8xLRi4B19HHV1NSzyNmw9z92ogaA=;
 b=RY8yXm/2tEgdbis+TgYymQgVILc8g5cjFVD3mQMwJWitV7FrPRAjWJkgeJxVdoUR9a
 v9BAZYHSkU8NaJvrx0wBOtn8NEa4MdtVPdpjjBBCx7gDk7IbTXTNPb97Dm/sFjVVTU3u
 OEWtu84aBpWF8YAGGoJMzCDdATYooqaYwByjpqlMQoKb5aKZ/TtMrTzA4D8ZBx5MwwUr
 GvuF5EetVFUjyFkrXMbo230K9SG43Tr1hwg6CQi+NckyFAjk8Vubww8SEfr0hE9E0xRP
 Ipai6eAkS0OW+8nyzNBQX6Gyo1tEx+SYoSjx7n3rGXOLwYAije3rbSNO8caMf/9f+6st
 Xm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716881571; x=1717486371;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgUZ78+iFCTuzva8xLRi4B19HHV1NSzyNmw9z92ogaA=;
 b=Q6pRXRAgcqF/T2cEG87WYfyTftKNpw8i2HJQ0xXWZu1xsEaq0HwTSdnEthdakz5yYk
 XO8T74WFq5N4StoeSvkryiPM7VA0LbavLc4tZgdchGrIxu3NytKJA8jzSWxnYnaO/Odr
 DoKvQw9BLsP2VPBAWMWfEd6bT8adClxs0a57kU6gbIzYsYiHNh0c1pGDLGCBrH6YRebe
 Kh6Q1HNeUCNLUijd/hG0qf0QgeEQiUTt6fLJStox4zgt2H84Dc/dZy3CTULa8smyqnFy
 pojodVxsykaLslzmDG4XD7xtUYfArvZDfsBfzwmxMG3M9R/Ftp7nersOuQYP0gQX05HE
 RMrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXesfcW3dAmjNoe0qSYvsxnU2DXw+qmftN52d0hBTLfeK/l4byvf+7b2ymeJaWtNJnQJYNGt4cdV/AocF3QXRgBE3V1SQ==
X-Gm-Message-State: AOJu0YzJkKM9t4pkBbUKavXQ0l6X7j7q4t8lg3txqyQBLxBVWbbdY2tX
 7/ZuRbjfhVHVmtE4h7BWP6rTUmZzU8bzepXFs5Fo9SFwVLJv3AGNexnHxKMLyMU=
X-Google-Smtp-Source: AGHT+IFZEi0Fjh5G+/eVNdk07jlCs4GhOAvsBMsY96XBdYmY/Flv3CvxKCKXIPotzRLxEHYnNceq3g==
X-Received: by 2002:a05:6000:1151:b0:354:ece6:d9b9 with SMTP id
 ffacd0b85a97d-35506d5bfd3mr10037634f8f.15.1716881571504; 
 Tue, 28 May 2024 00:32:51 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-359efaf5402sm3542528f8f.78.2024.05.28.00.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:32:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, r.stratiienko@gmail.com,
 igor.opaniuk@gmail.com, dsimic@manjaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, eajames@linux.ibm.com,
 marek.vasut+renesas@mailbox.org, paulerwan.rio@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] avb: Implement get_preloaded_partition callback
In-Reply-To: <20240519191856.2582174-3-r.stratiienko@gmail.com>
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
 <20240519191856.2582174-3-r.stratiienko@gmail.com>
Date: Tue, 28 May 2024 09:32:48 +0200
Message-ID: <87ttiigzmn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Roman,

Thank you for the patch.

On dim., mai 19, 2024 at 19:18, Roman Stratiienko <r.stratiienko@gmail.com> wrote:

> AVB can reuse already loaded images instead of loading them
> from the disk.
>
> The get_preloaded_partition now looks for the env. variables
> set by the 'abootimg load' to find the correct partition in RAM.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  common/avb_verify.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index cff9117d92..d2626e8844 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -6,6 +6,7 @@
>  #include <avb_verify.h>
>  #include <blk.h>
>  #include <cpu_func.h>
> +#include <env.h>
>  #include <image.h>
>  #include <malloc.h>
>  #include <part.h>
> @@ -595,6 +596,55 @@ static AvbIOResult read_from_partition(AvbOps *ops,
>  			   num_bytes, buffer, out_num_read, IO_READ);
>  }
>  
> +#ifdef CONFIG_ANDROID_BOOT_IMAGE
> +/**
> + * get_preloaded_partition() - Gets the starting pointer of a partition that
> + * is pre-loaded in memory, and save it to |out_pointer|.
> + *
> + * If the partition is not pre-loaded in memory, the out_pointer shall not be
> + * modified.
> + *
> + * @ops: contains AVB ops handlers
> + * @partition: partition name, NUL-terminated UTF-8 string

NUL -> NULL

> + * @num_bytes: amount of bytes to read
> + * @out_pointer: pointer to the starting address of the partition
> + * @out_num_bytes_preloaded: amount of bytes pre-loaded in memory
> + *
> + * @return:
> + *      AVB_IO_RESULT_OK, if partition was found or was not found

Add:

           AVB_IO_RESULT_ERROR_IO, if partition size is smaller than requested

With both small remarks addressed, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> + *
> + */
> +static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition, size_t num_bytes,
> +					   uint8_t **out_pointer, size_t *out_num_bytes_preloaded)
> +{

[...]

> -- 
> 2.40.1
