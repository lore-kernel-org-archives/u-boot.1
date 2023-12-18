Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80E9C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240BC87E44;
	Mon, 18 Dec 2023 16:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bMBlgqMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0967D87E08; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B13A87E26
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6d9f069e9b0so2731482a34.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911749; x=1703516549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a3wteGXy3SsC89x5yHRZy36gldGaYHlEXsDFQotQ5vk=;
 b=bMBlgqMTRUWUcEhBHFDVdzwcvSJBzuAe4VQ3o9kIvB7ieoeInFU7if0mCWOeyPSHxc
 F8AnsjJFITiqZTUlRDgqYK6+U1mNCMpeK7LwsVPtHDEk0/sKB2E80ke24VYty+p6hPzz
 a4C0RNQHn0W12ZDYOXr0+MO/lc5vBCIfEhc0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911749; x=1703516549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3wteGXy3SsC89x5yHRZy36gldGaYHlEXsDFQotQ5vk=;
 b=uaxA9XeXawBkezMkdD5h33TcYr3U634JcoUDnAgrNGQWbY5bt0eexGek9gOB5d4EF3
 rnIVvUkdxa1WxS2QWg8OGTE7tQVzOfZD/17eq+D7kwLvFN1GPehHcbugZbIakmpAlj1s
 3VCDqagQ8Xanjb7GUCY6ucYIJ1L9Y5HWKgnJmU+wUsaeSn/VhUn9SCWRRHUBd9nqUlUR
 lBExhVoiLnl4LTAPWTYTGfZYXaASAkDOly4EpHd3U2XncvJbBw8eqg4vJJAxAi260CDL
 f7gO4bM+WXyvVd8maNtKUOAO/SyFYLAKExRROCuh5cLiLM5SSOfFZ2sLXqf2mUj5T8aj
 n/FA==
X-Gm-Message-State: AOJu0Ywc7oLgR6Bqmdd6B1B86a0kOLXpnpuq4xGFyCWSIp5DuDgP3L6C
 QYE0Nk+8qM8wMFGuVt0cCukp8uGoUR8yCwHae3cn/A==
X-Google-Smtp-Source: AGHT+IG4WXrZykdvNrbwXahinqIuyBvQ3OQ3NhNL9SaHYoQ6tVyhNsmrkEOaekrm69lgozuV70YJkNl1d7GIceE2BPg=
X-Received: by 2002:a05:6830:138a:b0:6d8:a456:d99d with SMTP id
 d10-20020a056830138a00b006d8a456d99dmr16857205otq.5.1702911748709; Mon, 18
 Dec 2023 07:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
In-Reply-To: <20231218023842.281336-4-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:46 -0700
Message-ID: <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi AKASHI,

On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Now it is clear that the feature actually depends on efi interfaces,
> not "bootefi" command. efi_set_bootdev() will automatically be nullified
> if necessary efi component is disabled.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  net/tftp.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>

I have the same comment here as the 'fs' patch.

> diff --git a/net/tftp.c b/net/tftp.c
> index 88e71e67de35..2e335413492b 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -302,12 +302,10 @@ static void tftp_complete(void)
>                         time_start * 1000, "/s");
>         }
>         puts("\ndone\n");
> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {

Shouldn't this depend on your new CONFIG? What happens if EFI_LOADER
is not enabled?

> -               if (!tftp_put_active)
> -                       efi_set_bootdev("Net", "", tftp_filename,
> -                                       map_sysmem(tftp_load_addr, 0),
> -                                       net_boot_file_size);
> -       }
> +       if (!tftp_put_active)
> +               efi_set_bootdev("Net", "", tftp_filename,
> +                               map_sysmem(tftp_load_addr, 0),
> +                               net_boot_file_size);
>         net_set_state(NETLOOP_SUCCESS);
>  }
>
> --
> 2.34.1
>

Regards,
Simon
