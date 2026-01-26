Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC458C88E42
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 05:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8011583E7F;
	Mon, 26 Jan 2026 06:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m+npL+VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330D883E85; Mon, 26 Jan 2026 06:15:50 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC7483DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 06:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8849dc12f6so603306066b.1
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404547; cv=none;
 d=google.com; s=arc-20240605;
 b=eEpsVZaEvDc4aVaJn3cMZyg1jHMHIYUKAKgVm0WsmLt1XJ75E8zdd8JxsKSWEOf8rb
 Kl5ecBKZdCJJHXSysQRzFMCgn5KVBOR/Ns9xCaTISY2kKpR6T3E9VjmlvNjkEYpVcTHe
 U8ZJJfdRXqio26XFZxbmXcOpxqe+xz+KVgXNRQh3AGhafr/kBzmJwjZclNdk6lIq+uVq
 6WlVqiOD9y6qJC3hCJptb9gfAcr0qA/kdaG+h3fMazgYnvTSyrTS0m4caWsueuZbBvW+
 lutJipocjeHcocxKSCAVtaO5EGhV1kmHjM1TCjiNNlP806Brb8X75So+sZsz6HpkZyrr
 YeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wXvmmb47Hv6SPtVnnPrfvERiX05lzhwnsQHvXZ5UEq4=;
 fh=+Tm2ihy32xHl4i1ac8BgsK0NEOzhsfMuZ6NphDyPiVo=;
 b=Oc75BuxVyjbyIwtHTFBhkXyW9JXoOXQWLCCzMi16bcD0h7bc7M995C1zEJcszWKD3N
 /DcvCM2FUIzdwcR0rXxp1K8t3hutoOED8FhYku11eEJyE1gMveSPASabGGpAKnOEvzHS
 w5JJEN4B7vGGNivH6X0rK5qZhWoRn66daBrddkf3/xZXPpHza+D8D3E4EOIPRdBBgaro
 PNaeSZ6fSZDmD4XsQj8Mf21ikMOFiVqYVDu5fRTwIzmoTdO/9v5pmeIdS1NOAFdEQIjX
 xw+81CVAR1QBnm1OruqNsDeRQXdlE0G+bjctC9yAPF6WBug6rMAOeRe5fRB7i7hXNs6t
 fikQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1769404547; x=1770009347; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wXvmmb47Hv6SPtVnnPrfvERiX05lzhwnsQHvXZ5UEq4=;
 b=m+npL+VKuYVLqZeZ/PQKr2eX/ePITm6mO7HQ3SsqPBHMCzHs6xwKAyiejD74x8kdRf
 FLRSexYCWQryAFTOk1vTmzDMZELBaFNEZqqo5xr/eWmZeLYaDpblvQOkQvZwbT7+c2AX
 ArhKs3Z8QltdrZHwD5zdBcz4d+jBU+2yvla/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769404547; x=1770009347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXvmmb47Hv6SPtVnnPrfvERiX05lzhwnsQHvXZ5UEq4=;
 b=iHvbctp81yZZ6rlvrACRWxYPLzgOBkscnTQb5lGq1bwUPkO4qGPhZw0RLgO1k1Z+C8
 1W97KibNc509CEsd1MSoj6jOkj4JJatAPbO9MoPBmBBKA5HnKZpsFDZGyQwFxOxSX5KZ
 Z0pEX/D2HtGvTloSnagxnt/mC94FKpsIK1dubHlEAP8euavVwhTpK1qkSGnzTDz3zHoX
 BwL+9sSiCIIkkyoO5MHtZZroz+LG5mUhiRi9oFwAi6h5uNW4H+MKrPEk8OZXbnL1zC+7
 V8r50jDGC6p7dNGEQnYuTHuEFy7btojruHoHO5KoOw8M/kRGgHdvKL9cD0x2msfVte/D
 +o0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKWH/rQ1oayBNo4va3PXiKCsN94r1b9cujl+ESVV3nE3y2gGCehvAQu+kb4W2LBMxOWzNq10=@lists.denx.de
X-Gm-Message-State: AOJu0YwBzTlDmdYt/2RJKQEhY0sNceheo/yfBKMazxZqwNXYAxXjGqcH
 jptADd36ghj+FquwXPQ6OxcQIjj1wZRMetNnnP3i1HcZ6IEJ2tFaHpqOM53jhkYzfn/DPn064GJ
 kDzE5m58ezpRlqCql0EDz7bVboZC+UPBzRIZMptT/
X-Gm-Gg: AZuq6aJUTqMkNOmssIr9mSN7mC4sR4HEKF9Twvyzt1pAKU676DDToI7n/MFXE6KB6HI
 VoTCDOVdBosOd9SV72eoqdHGh9xh6f0sRljltXQh8zn/Dt+FaU3cz7sSTQVLihkvA8wmVXpMxXh
 AQLzOIT4VVYnvu4yT2bybV6hees1vFjA34VwtrO8elGeT37Ct2zdw+tAl8bYIvVggiIwhBF8zKQ
 Pp5lSfbdUO7gqCesUQFCxyZahW+iNWPva77o0KwnsjOVE1BKsKOmIRHl4RnRVUsb8MRVtHU2iQ3
 4A6T0cAj
X-Received: by 2002:a17:907:702:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8d20d405f0mr220618166b.27.1769404547497; Sun, 25 Jan 2026
 21:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Jan 2026 18:15:34 +1300
X-Gm-Features: AZwV_Qjzf4QFven2HhAF7k_sywLcXxWO5M4b3t65DuCK6h0107oQW98ASEwsM5s
Message-ID: <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, me@samcday.com, aswin.murugan@oss.qualcomm.com, 
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

Hi,

On Wed, 21 Jan 2026 at 19:39, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> to receive arguments given to the 'reset' command. Process the
> request_arg() op before the usual request() op.
>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v6: Wrap this functionality inside CONFIG_SYSRESET_CMD_RESET_ARGS
> ---
>  drivers/sysreset/Kconfig           |  8 +++++++
>  drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
>  include/sysreset.h                 | 18 +++++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 0181f6cd581..6fb0ca81dc6 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -49,6 +49,14 @@ config SYSRESET_CMD_RESET
>         help
>           Enable sysreset implementation of the reset command.
>
> +config SYSRESET_CMD_RESET_ARGS
> +       bool "Enable reset command to take arguments"
> +       help
> +         Pass on the arguments received by the 'reset' command to the
> +         sysreset driver(s). The sysreset driver(s) may make use of the
> +         additional arguments for implementing arch/board specific
> +         functionality.
> +

I haven't been following this, but what sort of args are you planning to pass?

Regards,
Simon


>  if CMD_POWEROFF
>
>  config SYSRESET_CMD_POWEROFF
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 536ac727142..f25e09e9cd0 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -32,6 +32,18 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
>         return ops->request(dev, type);
>  }
>
> +#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> +int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
> +{
> +       struct sysreset_ops *ops = sysreset_get_ops(dev);
> +
> +       if (!ops->request_arg)
> +               return -ENOSYS;
> +
> +       return ops->request_arg(dev, argc, argv);
> +}
> +#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
> +
>  int sysreset_get_status(struct udevice *dev, char *buf, int size)
>  {
>         struct sysreset_ops *ops = sysreset_get_ops(dev);
> @@ -71,6 +83,26 @@ int sysreset_walk(enum sysreset_t type)
>         return ret;
>  }
>
> +#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> +int sysreset_walk_arg(int argc, char * const argv[])
> +{
> +       struct udevice *dev;
> +       int ret = -ENOSYS;
> +
> +       while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
> +               for (uclass_first_device(UCLASS_SYSRESET, &dev);
> +                    dev;
> +                    uclass_next_device(&dev)) {
> +                       ret = sysreset_request_arg(dev, argc, argv);
> +                       if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
> +                               break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
> +
>  int sysreset_get_last_walk(void)
>  {
>         struct udevice *dev;
> @@ -132,6 +164,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         printf("resetting ...\n");
>         mdelay(100);
>
> +#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> +       if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
> +               return 0;
> +#endif
> +
>         sysreset_walk_halt(reset_type);
>
>         return 0;
> diff --git a/include/sysreset.h b/include/sysreset.h
> index ff20abdeed3..d1cc9ebc542 100644
> --- a/include/sysreset.h
> +++ b/include/sysreset.h
> @@ -43,6 +43,24 @@ struct sysreset_ops {
>          * (in which case this method will not actually return)
>          */
>         int (*request)(struct udevice *dev, enum sysreset_t type);
> +
> +       /**
> +        * @request_arg: Reset handler implementations that might need to process
> +        *               arguments given to the 'reset' command.
> +        *
> +        * Note that this function may return before the reset takes effect.
> +        *
> +        * @dev:        Device to be used for system reset
> +        * @argc:       No. of items in @argv
> +        * @argv:       Arguments given to 'reset' command
> +        * Return:
> +        * -EINPROGRESS         if the reset has started and will complete soon
> +        * -EPROTONOSUPPORT     if not supported by this device
> +        * 0                    if the reset has already happened
> +        * (in which case this method will not actually return)
> +        */
> +       int (*request_arg)(struct udevice *dev, int argc, char * const argv[]);
> +
>         /**
>          * @get_status: get printable reset status information
>          *
> --
> 2.34.1
>
