Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F87AD75E33
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850D8896CC;
	Fri, 22 Nov 2024 13:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jqo6mHwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64367896FD; Fri, 22 Nov 2024 13:33:20 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6CD389339
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e9e377aeadso1750975a91.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732278796; x=1732883596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x/GEgSjcLa5tSsTn9arpVakARFx4ELRrTeASGOmSxNI=;
 b=jqo6mHwXJLhAMFpkPRdFLFRW2+rinqkqlDAl7drYL+qBcO6X0RkJsv/Rr9FWCKXtIs
 PerIcmKAsx3TFceg+KKIaSp5pz7zSzogAOUpT02t0YlGUlNJDqfiyg9K+OGJXYIawuPM
 BirQI0879LAUR4fkW2trIlSpInMQe1qPKkpHZOTOtV73pGA7LTbdMNqYjK7MkJ33zHpi
 1fEYyfgdPk01NIixE+rFWnytZyxlwUDWVk1KBHjxBuPht9WZu+1oOp5D/9kRJMYE3/3v
 X/MDFWRDR61qJWZprcpEZeew/Juok9ntZQjnydkteKyK+JWiIXE0psnmvvYt4tj29cMz
 ZW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732278796; x=1732883596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x/GEgSjcLa5tSsTn9arpVakARFx4ELRrTeASGOmSxNI=;
 b=B3EDotRkgUeHH18/IheHb6U6+POpIoo1fvEdAOMTPMh1NX4NbbHXGQsFscYYd2ib55
 L7O6yiyS+Y2gsqnidtxJtaljk5hHTNztyD/GzMl4JIiBYJfimoJvuFoGF+ZE2u5y3Aqo
 Uc7+sE/xbL9DECofWMMwqHSdrQMuG9pL4/jwKGuIv9iWg21M2CrH0cOOZYnSD76IYztU
 brzAYQ1Iit5O1FA03VeG0oe+4sERJVK5Krc83wwL9/g9OJKhWKb6MchVyZZpVuUxJ1l9
 bh6z2XYzYKzSa4v51kfEkXIutlJ67j8cLAnnnwIJjHRMxxqZur2cWOEpYoV9vSaf9rRx
 5j7A==
X-Gm-Message-State: AOJu0YzS+L1AdK7OSIPMoEYHq6FnOxVmBGICaly1V3hK6cENpofXrvHy
 5lSz31m+rtTetU7JzloGjc9SPwFZVx1oRGbrz+1RD/d5uWwRShVueEMr5SEc0pBNjBZIalzQnKG
 omK3eiUi3E07rAW+Hks9oEx7rJq3hfxmpSyhnsA==
X-Gm-Gg: ASbGncvakU3yT6M5mUqpRvucruY9yPX7tuAXztFtplp11z4yQ0eKgoIatIDvwMEg3bK
 QTVNh3ZDxbaQaXzyb8cBBx1WxEV9M/g==
X-Google-Smtp-Source: AGHT+IFOR+YLABBXiY8EFLbiOBXwX3WEhwh6r5/s8oyPHI9ZT3cuabSnb7XuTKu1UFV6FlUsZiQY42JjyXHbKLHQKeQ=
X-Received: by 2002:a17:90b:3b44:b0:2ea:7755:a0ee with SMTP id
 98e67ed59e1d1-2eb0e02030cmr2929541a91.4.1732278796386; Fri, 22 Nov 2024
 04:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-17-sjg@chromium.org>
In-Reply-To: <20241119131844.4078144-17-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Nov 2024 14:32:40 +0200
Message-ID: <CAC_iWjJL1M9ZNTqUwBcFcQRta172-KZvXrERg_1ndjK_acx7QQ@mail.gmail.com>
Subject: Re: [PATCH 16/39] net: Tidy up the comments to parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Tue, 19 Nov 2024 at 15:19, Simon Glass <sjg@chromium.org> wrote:
>
> This function is a bit vague as to what it does. Expand the comment a
> little, to specify which args are provided and which variables are
> updated.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  cmd/net.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/net.c b/cmd/net.c
> index d3e566752d1..01332d57b98 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -311,9 +311,18 @@ static int parse_addr_size(char * const argv[])
>  /**
>   * parse_args() - parse command line arguments
>   *
> + * Sets:
> + *
> + * - net_boot_file_name_explicit to true if a filename was specified
> + * - net_boot_file_name to that filename, if specified, else the value of the
> + *     'bootfile' environment variable
> + * - image_load_addr if a load address was provided
> + * - image_save_addr and image_save_size, if proto == TFTPPUT
> + *
>   * @proto:     command prototype
> - * @argc:      number of arguments
> - * @argv:      command line arguments
> + * @argc:      number of arguments, include the command, which has already been
> + *             parsed
> + * @argv:      command line arguments, with argv[0] being the command
>   * Return:     0 on success
>   */
>  static int parse_args(enum proto_t proto, int argc, char *const argv[])
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
