Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B64C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1249C87E35;
	Mon, 18 Dec 2023 16:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtJ5kBG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B704B87E57; Mon, 18 Dec 2023 16:02:40 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548B587E26
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6d9f879f784so2735141a34.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jGOnK9Ja66UUqttmDcjiSaA6vZ8sqCPAI3ostx8zZ6U=;
 b=TtJ5kBG3axcRyJjfYy4UsEwgLwjNC3jTTViYVYXEHypWSMMx65HsYuRI589MD50ZDm
 BE9gf+ehpzfwpVIbqsABvIpKv8ImUMnYmjWxJsr/JVWEgc48tQPZmEgtDDj0jYbn5xL9
 hnflUjtCtHSodnVTlLpW036FAaKH6PK2Owhdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGOnK9Ja66UUqttmDcjiSaA6vZ8sqCPAI3ostx8zZ6U=;
 b=vp+Lqg2SfCORG6Dr7dU8dsBNRfffQaILjZ0jIpDH1XJAqae9hAryxMhfClrOIMSTHE
 j29uUZy4QbvuFTmVHzGb4OIcg7vhzjeJrnH7IDWpyPQiXQzuYmmCnR7bG9a7NdNTru4D
 asV5pyP6mZAH/wzme3YgegSN1xp8KWXJxNj82cp5wvy8IUFp8+6cWcQKgQz8AOmrfRDQ
 UiMvYs8mxXHp9YGpaRE9YlX3DwksXYYZEObdo190RlPnwRatUJZRn785ifpsBgtRyJdE
 raWlJw3yXJCFvDp3KvoemIj/0CCD1yjXr7dBFUlxtrQ5z9f2KGJwFE2cIl+D4pZ6bOxB
 w73g==
X-Gm-Message-State: AOJu0YzdlJ/tV1BpGBhvmJGy6GnMG2PlRV3guBgXCf29NSw+0CnjZPJO
 BHqA0oOrLIGQNexu/s24lmJo1tu+v6eHm5eQ1zh6Xg==
X-Google-Smtp-Source: AGHT+IGc++SgiNs4KX/L0qm1Sg+8I6G36KKNZWWl6HL8QT18ASgEcGrBUUW1w5r83RYfaFn7KiQAGTqNa+3dpshhIAM=
X-Received: by 2002:a9d:7a53:0:b0:6d9:edd2:5c96 with SMTP id
 z19-20020a9d7a53000000b006d9edd25c96mr14990260otm.38.1702911752811; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
In-Reply-To: <20231218023842.281336-5-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:40 -0700
Message-ID: <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
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
>  fs/fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index f33b85f92b61..82ee03b160e9 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
>                 return 1;
>         }
>
> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> -                               (argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> -                               len_read);
> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> +                       (argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> +                       len_read);

As I understand it, this is setting the boot device so that (if it
happens to be an efi application) it will know which device it came
from. But this is a hack. For bootstd, the device is known as it loads
the kernel.

Also it does not deal with memory allocation (nor can it).

Where are we using the 'load' command to load a kernel? The distro
scripts are deprecated.

At some point this code should be removed. Is it too early for that?

>
>         printf("%llu bytes read in %lu ms", len_read, time);
>         if (time > 0) {
> --
> 2.34.1
>

Regards,
Simon
