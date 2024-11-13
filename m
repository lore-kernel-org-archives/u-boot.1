Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6866BD41C15
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 08:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACEEA8953C;
	Wed, 13 Nov 2024 09:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DUWmaTPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBA488B16; Wed, 13 Nov 2024 09:17:43 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D60188B16
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so5393250b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731485860; x=1732090660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=52hknG44CzWPgQyqdxod+YF/7rtGSG9PttIbzFOy+IQ=;
 b=DUWmaTPm9y729l1oEpy5CJyFDP7dBC57cvtoScOVgNzei6/qCUYMqh7LpCBGLe45/b
 GER/4qHzxzFvzJooEQYa/OktVm1CjTGv1LA+f+dbi/xzXCf/Jve0joAlgOsxkJNGqvN4
 bd81y3coYOXnbIFXyjqBCIVWLxt1dt5ihBpaBYLUc1bQp3vHgig9PPn3C1Wgxm7d0wQf
 HUSwqu7WaTNsIbty94ziZrat6XwY1g0l1vcwlO+cljyvPeCXjUCsiVWxeHSaRtl4nseQ
 sxw/8k7HPxPHZDNJay+yD5g7jz0Dz1AotgPYYt4N86aE091j8i1Ku8CE+XAUQ++yq1Yd
 mM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731485860; x=1732090660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52hknG44CzWPgQyqdxod+YF/7rtGSG9PttIbzFOy+IQ=;
 b=ofbFVBJAOM2dg4jWOeEga0HNZoeyCgf8Bp1Qxcr/1anN22yLsjEjMXn5SbF+vk20XO
 junbkRVYqrOfVOhHYwuc+saHYWDL8NFk5/Epy4l61RfaLAXATqdzSERJUX06jsGcD1fL
 oqDM5LZSVT4HwTXVlA1zgQqBcV+dFFW1RTNrdjnuzMJYOmANYu8U+r4SGPPagi341JoW
 YBuftdkI1DhIisSWAEajyyw7FkSC9BElHtVi5l07AUAqjQYWUZvDGiHzN9o0w856WqhX
 mKSGRSIbSMyVyIXR+dhuUxO/++KWgu+Jdwp6RJrqgToniqeJFNHZxy+W+EY9FWDb1nBH
 P8mQ==
X-Gm-Message-State: AOJu0YwnvqmKsSc6q+ZlckJIMtneQEp3psbYU5D4+u6v5rrs+qGvb7Ta
 pkWXPqnZZR1yGSeu5+dxurNu7SejtakzNH8HJH/tEI7om+di5rXkkYCQDtVsjqBOv2q50F6ta/g
 YF2YyzgFz4hNUvS9qAy6HvHxgNB0AlKWVjfjcgg==
X-Google-Smtp-Source: AGHT+IFPbgqmHPJup8+OhEPlGCaa3k8V9G3wdDmx9MPwFdUWn1tbbKUENwiffOXk9CXy+mBlzqOrBe8jAKyznirdeu0=
X-Received: by 2002:a05:6a20:a12c:b0:1db:ebe0:449d with SMTP id
 adf61e73a8af0-1dc22b57f10mr28876156637.43.1731485859813; Wed, 13 Nov 2024
 00:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-2-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-2-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 10:17:03 +0200
Message-ID: <CAC_iWj+J-+nmpKLKDNrQh93xQ9Rdvvb5S9KRrryH-KQOY1SqcA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] net: net_utils: Move ip_to_string to
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

Reviewed-by tags missing for me * Heinrich

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> The function string_to_ip is already in net_utils, which is
> compiled unconditionally, but ip_to_string is currently only
> accessible if the legacy network stack is selected. This
> commit puts ip_to_string in net_utils.c and removes it from the
> legacy network code.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  include/net-common.h | 10 ++++++++++
>  lib/net_utils.c      | 11 +++++++++++
>  net/net.c            | 11 -----------
>  3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 3cd0f34374..b7a519e36d 100644
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
