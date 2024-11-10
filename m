Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20C3D5E380
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A3D88FAF;
	Sun, 10 Nov 2024 12:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="imcVONAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C58B88FAF; Sun, 10 Nov 2024 12:38:38 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC14B881FD
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so3187755a12.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731238714; x=1731843514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wnvPiycrAIjH/AhlrUit267KcpGX3DrpZQ/vSShug2k=;
 b=imcVONAlx26ZOv2KrJJ7KbEES2FV7p1EdKTq+SRbMNnmCNhhWD9ITbJsgp4PL9m04L
 kBsGegoZDROrCASfpE8vWCCpu9ML6C/MqoInhlztrI/7EoyDf4UfmuqhlJNCdRFaazNW
 6WLUeoJ6CXqI3jhCHT7Zre0uge5CCflf4alKwQ1Enq+wG7Jwu6ELoL2QopqYfNmWrcTs
 /UcYvfzSFlYEXy7XmbV73uuUcSwzVDDM1UM4ZUDmPUQeqjGGKRsLxyssXgptJD8rpa0e
 fSzAb/GhlhBmABpkZxjwGIARftHZ/IhKI9mscUQhZzc7+vhApOb8sSvj6ubn0xINuJMZ
 4tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731238714; x=1731843514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnvPiycrAIjH/AhlrUit267KcpGX3DrpZQ/vSShug2k=;
 b=pE381KX4O277RRDiJXrqYcQJNGGVTBIZ20i8TlTkSWdTgxhHdlFqJ6pwAPLSZFh67R
 FCcDPOWTCwgc5a+GvTPyDXFyBKvv9NZyt3vU86QbAcDsaLZzQqa1E5SrKkEjGS+E2Cus
 Q+UjN9qDnjdev7IJDhExaeV6A2C+bq8pwXSeaqUynM16MLkBEZBix+/mMmLcspJmLx/7
 JriVDqrZA1WpKU15ueo9D5hnngIuHRk7rbQkLQUS+uRxKqe5FgWIcbneJbBadm5PVHEl
 X4tTDJjgcBRBb+rhQ7yiPsQNUDRO3YUeO5FzQ3oSCxzwbAfXNbtgXGpH1PwEfJw8gpwU
 RNsg==
X-Gm-Message-State: AOJu0Yx340HWVrCdDOhqBZtmU63eiH6hWgDN4w95lrrB/u5zaPUjfGUz
 ujYDoGbqMJjnw03e0U8yZ0iLYx66zxQP3ljwP2K2FVLKnpUBb2Mrc+Yr+kLeb0s+p2nQahF/Yug
 mVpJzjvswF99SRR/HcwlTvLJR1jfXYdZepif1Fw==
X-Google-Smtp-Source: AGHT+IHDP3pc/M0CeJq6sgU831awDufxg61pbnPvqm7M83ltxAj9QCzoyFms9ibpYYHn3oTF+FOWbPjl95PkdFV4g9c=
X-Received: by 2002:a17:90b:4b88:b0:2e2:c681:51ce with SMTP id
 98e67ed59e1d1-2e9b16e552fmr13167615a91.1.1731238714192; Sun, 10 Nov 2024
 03:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-2-adrianox@gmail.com>
In-Reply-To: <20241108133850.431075-2-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 10 Nov 2024 13:37:58 +0200
Message-ID: <CAC_iWjJdfkgT9ueo3j1Yw=m3iRkPaxHEc3OWuN6qhW4stuMHHw@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] net: net_utils: Move ip_to_string to
 lib/net_utils.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

On Fri, 8 Nov 2024 at 15:39, Adriano Cordova <adrianox@gmail.com> wrote:
>
> The function string_to_ip is already in net_utils, which is
> compiled unconditionally, but ip_to_string is currently only
> accessible if the legacy network stack is selected. This
> commit puts ip_to_string in net_utils.c and removes it from the
> legacy network code.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  include/net-common.h | 10 ++++++++++
>  lib/net_utils.c      | 11 +++++++++++
>  net/net.c            | 11 -----------
>  3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 11c53766a3..5206b8346d 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -426,6 +426,16 @@ void string_to_enetaddr(const char *addr, uint8_t *enetaddr);
>   */
>  struct in_addr string_to_ip(const char *s);
>
> +/**
> + * ip_to_string() - Convert a string to ip address
> + *
> + * Implemented in lib/net_utils.c (built unconditionally)
> + *
> + * @x: Input ip to parse
> + * @s: string containing the parsed ip address
> + */
> +void ip_to_string(struct in_addr x, char *s);
> +
>  /* copy a filename (allow for "..." notation, limit length) */
>  void copy_filename(char *dst, const char *src, int size);
>
> diff --git a/lib/net_utils.c b/lib/net_utils.c
> index c70fef0d99..621f6512b6 100644
> --- a/lib/net_utils.c
> +++ b/lib/net_utils.c
> @@ -152,6 +152,17 @@ out_err:
>  }
>  #endif
>
> +void ip_to_string(struct in_addr x, char *s)
> +{
> +       x.s_addr = ntohl(x.s_addr);
> +       sprintf(s, "%d.%d.%d.%d",
> +               (int) ((x.s_addr >> 24) & 0xff),
> +               (int) ((x.s_addr >> 16) & 0xff),
> +               (int) ((x.s_addr >> 8) & 0xff),
> +               (int) ((x.s_addr >> 0) & 0xff)
> +       );
> +}
> +
>  void string_to_enetaddr(const char *addr, uint8_t *enetaddr)
>  {
>         char *end;
> diff --git a/net/net.c b/net/net.c
> index f47e9fbe33..ca35704f66 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1723,17 +1723,6 @@ int net_parse_bootfile(struct in_addr *ipaddr, char *filename, int max_len)
>         return 1;
>  }
>
> -void ip_to_string(struct in_addr x, char *s)
> -{
> -       x.s_addr = ntohl(x.s_addr);
> -       sprintf(s, "%d.%d.%d.%d",
> -               (int) ((x.s_addr >> 24) & 0xff),
> -               (int) ((x.s_addr >> 16) & 0xff),
> -               (int) ((x.s_addr >> 8) & 0xff),
> -               (int) ((x.s_addr >> 0) & 0xff)
> -       );
> -}
> -
>  void vlan_to_string(ushort x, char *s)
>  {
>         x = ntohs(x);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
